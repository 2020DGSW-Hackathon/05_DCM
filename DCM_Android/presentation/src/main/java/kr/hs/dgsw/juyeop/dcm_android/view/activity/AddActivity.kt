package kr.hs.dgsw.juyeop.dcm_android.view.activity

import androidx.lifecycle.Observer
import kr.hs.dgsw.juyeop.dcm_android.base.view.BaseActivity
import kr.hs.dgsw.juyeop.dcm_android.databinding.ActivityAddBinding
import kr.hs.dgsw.juyeop.dcm_android.viewmodel.activity.AddViewModel
import org.koin.androidx.viewmodel.ext.android.getViewModel

class AddActivity : BaseActivity<ActivityAddBinding, AddViewModel>() {

    override val viewModel: AddViewModel
        get() = getViewModel(AddViewModel::class)

    override fun init() {}
    override fun observerViewModel() {
        with(viewModel) {
            onBackEvent.observe(this@AddActivity, Observer {
                onBackPressed()
            })
        }
    }
}