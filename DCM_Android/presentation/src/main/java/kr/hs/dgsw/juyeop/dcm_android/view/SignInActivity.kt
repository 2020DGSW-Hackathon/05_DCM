package kr.hs.dgsw.juyeop.dcm_android.view

import androidx.lifecycle.Observer
import kr.hs.dgsw.juyeop.dcm_android.MainActivity
import kr.hs.dgsw.juyeop.dcm_android.base.BaseActivity
import kr.hs.dgsw.juyeop.dcm_android.databinding.ActivitySignInBinding
import kr.hs.dgsw.juyeop.dcm_android.viewmodel.SignInViewModel
import kr.hs.dgsw.juyeop.dcm_android.widget.extension.shortToastMessage
import kr.hs.dgsw.juyeop.dcm_android.widget.extension.startActivityWithFinish
import org.koin.androidx.viewmodel.ext.android.getViewModel

class SignInActivity : BaseActivity<ActivitySignInBinding, SignInViewModel>() {

    override val viewModel: SignInViewModel
        get() = getViewModel(SignInViewModel::class)

    override fun init() {}
    override fun observerViewModel() {
        with(viewModel) {
            onCompleteEvent.observe(this@SignInActivity, Observer {
                shortToastMessage("로그인을 성공하였습니다.")
                startActivityWithFinish(applicationContext, MainActivity::class.java)
            })
            onCompleteErrorEvent.observe(this@SignInActivity, Observer {
                shortToastMessage("로그인을 실패하였습니다.")
            })
        }
    }
}