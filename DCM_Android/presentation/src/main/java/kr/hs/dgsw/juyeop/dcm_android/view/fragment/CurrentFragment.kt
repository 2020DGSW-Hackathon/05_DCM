package kr.hs.dgsw.juyeop.dcm_android.view.fragment

import kr.hs.dgsw.juyeop.dcm_android.base.view.BaseFragment
import kr.hs.dgsw.juyeop.dcm_android.databinding.FragmentCurrentBinding
import kr.hs.dgsw.juyeop.dcm_android.viewmodel.fragment.CurrentViewModel
import org.koin.androidx.viewmodel.ext.android.getViewModel

class CurrentFragment : BaseFragment<FragmentCurrentBinding, CurrentViewModel>() {

    override val mViewModel: CurrentViewModel
        get() = getViewModel(CurrentViewModel::class)

    override fun observerVieModel() {}
}