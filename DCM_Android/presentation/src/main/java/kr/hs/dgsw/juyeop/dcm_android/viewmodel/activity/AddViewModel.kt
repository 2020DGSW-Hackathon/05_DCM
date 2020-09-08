package kr.hs.dgsw.juyeop.dcm_android.viewmodel.activity

import kr.hs.dgsw.juyeop.dcm_android.base.viewmodel.BaseViewModel
import kr.hs.dgsw.juyeop.dcm_android.widget.SingleLiveEvent

class AddViewModel : BaseViewModel() {

    val onBackEvent = SingleLiveEvent<Unit>()

    fun backEvent() {
        onBackEvent.call()
    }
}