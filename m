Return-Path: <linux-kernel+bounces-891838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44069C43A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06713AE205
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE70273D8D;
	Sun,  9 Nov 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtLCSsMw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPjIembO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA226E6E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762675169; cv=none; b=FWqW48iNSbpIKTEBUbZbDkJwKdii81691MwOhZumvL6fCEC2+C+31yIvsdji6uhws5aUGEicNtSMu64Km4zCQUKe+8OeC8pYGmYi8a3QkBUWK4g8od0NHMi6+dlXjrzuxY5k3gngFCCFf2nkR6Zn++rxSIPiJFWpI3dngTrXFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762675169; c=relaxed/simple;
	bh=gEg9Evdib2QUkp9EbKFgp9vG4ut2yLvMGS+fUMrt/vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmJPcgAex2z2uo94JEqAJanlG4wUB+mXQ7xKLM2gSCRwpsZYVxGaT6oRw85mQMuC03fhKAoHqm8ZMDEXkzzKDW4sgQgnAywX2ONoGissb8kAiGj+BkGl7IB89nyG7OwkzJRWq2eb3jLkR7F9Quu7yFYgGruPtVfasZIWlxHzUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtLCSsMw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPjIembO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762675167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RmddV565FqBe/uzADNdZiOCFmNopt521U7nuIq6Mvsw=;
	b=XtLCSsMwobFk/KFkDdhsichSOVuvJP84PH9Jd5TIRlvBPEzV++FlTOYZQVbRhsFvCwIOxJ
	hdoQg8DFbEKBIJRGDBs0y3Uf54A4GsH86Ge/F5wHcnYtDkaOpe6X98ZHyML1rAdVb1uJY2
	+ijZlCNRdQMI2nsVQMWfcVpjA0xwJbc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-qbJTo-OQO_qp6mSDAoU9Ag-1; Sun, 09 Nov 2025 02:59:23 -0500
X-MC-Unique: qbJTo-OQO_qp6mSDAoU9Ag-1
X-Mimecast-MFC-AGG-ID: qbJTo-OQO_qp6mSDAoU9Ag_1762675162
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6409f6d6800so2648038a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 23:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762675162; x=1763279962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RmddV565FqBe/uzADNdZiOCFmNopt521U7nuIq6Mvsw=;
        b=IPjIembOsuayobfM6O4c4hfFJ2bgvs2qrImWb9rJUvUpQsDYzY4f3RmSH1UARYOje7
         +L+bjGH9Qyn+oYQ5al/0SRVn4Kb+cxeoa9rPoTAwVG4ql5XR6vqTUevbezW63iisdAxK
         YyBTADyOf8j5wbPyNiviJSnHXb8ttrs2sA7LNWBwUJUeBjPW0AQUEQmry63c7G3ctnDi
         DqujsgU5SFULQ2zviOzRc+Bqxr+NV61z6g0NyOKOT37ZlHEHdrZvWjbxKKoRam9gYN/I
         1s2+2TNGiTaZ7tTmkDwuO59e3pHNrUHO95j45JsE63aspHE8xRneGAyz4zApXM+7HyJh
         Z/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762675162; x=1763279962;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmddV565FqBe/uzADNdZiOCFmNopt521U7nuIq6Mvsw=;
        b=phjAtReRTcrZRLFgvnPXApeS7jNvl2zEKbyf2jzhPBplZWCFm0N5TNS0PqOyHsNnPz
         Prg5GE3Cy+W+VfbRmwNIqrM4iFlNSST8SbLcW1PcXu/Hth4mDmYv7z1EhVVU7+AB00AR
         kY2nISXsVb/pMSx/zi9euC7zO6gl6MwPA5xdvFzad1Xc4oQR4/orgjtCQtVfJDclagnk
         MhOygdKcFKb8beOyVBO3I0roGAeCqLMx3MsnBf+OXM86ZycC+toTBUqWZqXvgikh+Uq/
         6Lrie/ufSeqlK+v97pFSxi0dwJZMgwd2ww7trtWXUep0w4PE4wo/RuZ61z485jONQ0+S
         ntMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBPALGC5sv5aBPdEI+JjWGxG+O53D9OmE/RMxUIkcFX2lPuGUvl7Ly5pnyNQP4G+i94ZY4f9wIP22XiCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEVND32qIO4mr5+A+4Lf61cQ+O/dwFtYTIzjCmR198wu/xJvH
	/E7R2RBPH1voGnr1CI0GnOMhNNMfiL0w5t5HF+mSJijlT5qMVwiGVn4Sh1kVW3fOz7MlxvxoOvh
	Sd8kETbzA9X9NKmGuSKqReKmzrz1WpIEwlS/1QzDfmrU638A21Fqu12V3cuTsJ/EwQg==
X-Gm-Gg: ASbGnctsMGHHP1/jomVcAHCOzgFNPo+pL+H4zKa0uOqqMjqzvVFAuBl0EcEcy0e01Ax
	kXo6+6rofPgagYA+dO8/ibO19dH4txjJamgruS+qMoqenGdb+3TXRc54D+Jqgz1AJrxRYYgq92I
	hj/uQ3q/zNgnQGSl6l3p+Ss6RuUZLKyLe09dN9RIX2aUooD0PrrQ5lSi0BEHc8kSDAijN5NDmkK
	UOq/Q6uhv8d+icW8xdoiFlm+v+Vy/Gh1mKacCVLhnVfv/h9bJU0HA90Rg+vazXOYyJQn039nZ5Q
	t5znhGNenmCjFBUT+2tHScTBYGmkZsMta0DlgbrVu1lQ7WWHmAoChEiIJ4+9tea4CpEYwUFxxAc
	PAXR8cQ3wVm21tB0CtKBL578dmFLNxl6eMdcri63nUqR+CkWm+2gs9LWJ7nifuT7PJmt5vBWiUS
	avDu+t
X-Received: by 2002:a05:6402:218c:10b0:63b:efa7:b0a9 with SMTP id 4fb4d7f45d1cf-6415e5ceac3mr2570844a12.9.1762675162461;
        Sat, 08 Nov 2025 23:59:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUHRye6REsOjWn3j1IXsXu+KLjVA8ih3DiUGggpCYdJYwjpciyC2WCKRZC5Qe+r98AYX8OWQ==
X-Received: by 2002:a05:6402:218c:10b0:63b:efa7:b0a9 with SMTP id 4fb4d7f45d1cf-6415e5ceac3mr2570834a12.9.1762675162026;
        Sat, 08 Nov 2025 23:59:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6417b28a73esm1229837a12.35.2025.11.08.23.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 23:59:21 -0800 (PST)
Message-ID: <be2a7126-2abc-4333-b067-75dd16634f13@redhat.com>
Date: Sun, 9 Nov 2025 08:59:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] KVM: SVM: Switch svm_copy_lbrs() to a macro
To: Yosry Ahmed <yosry.ahmed@linux.dev>,
 Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
 <20251108004524.1600006-5-yosry.ahmed@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20251108004524.1600006-5-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/25 01:45, Yosry Ahmed wrote:
> In preparation for using svm_copy_lbrs() with 'struct vmcb_save_area'
> without a containing 'struct vmcb', and later even 'struct
> vmcb_save_area_cached', make it a macro. Pull the call to
> vmcb_mark_dirty() out to the callers.

The changes to use `struct vmcb_save_area_cached' are not included in 
this series, so they are irrelevant.

Since I've applied patches 1-3, which fix the worst bugs, there are two 
ways to handle the rest:

* keep the function instead of the macro, while making it take a struct 
vmcb_save_area (and therefore pulling vmcb_mark_dirty() to the callers 
and fixing the bug you mention below).

* you resubmit with the changes to use struct vmcb_save_area_cached, so 
that the commit message makes more sense.

Thanks,

Paolo

> Macros are generally not preferred compared to functions, mainly due to
> type-safety. However, in this case it seems like having a simple macro
> copying a few fields is better than copy-pasting the same 5 lines of
> code in different places.
> 
> On the bright side, pulling vmcb_mark_dirty() calls to the callers makes
> it clear that in one case, vmcb_mark_dirty() was being called on VMCB12.
> It is not architecturally defined for the CPU to clear arbitrary clean
> bits, and it is not needed, so drop that one call.

> Technically fixes the non-architectural behavior of setting the dirty
> bit on VMCB12.
> 
> Fixes: d20c796ca370 ("KVM: x86: nSVM: implement nested LBR virtualization")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>   arch/x86/kvm/svm/nested.c | 16 ++++++++++------
>   arch/x86/kvm/svm/svm.c    | 11 -----------
>   arch/x86/kvm/svm/svm.h    | 10 +++++++++-
>   3 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index c81005b245222..e7861392f2fcd 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -676,10 +676,12 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
>   		 * Reserved bits of DEBUGCTL are ignored.  Be consistent with
>   		 * svm_set_msr's definition of reserved bits.
>   		 */
> -		svm_copy_lbrs(vmcb02, vmcb12);
> +		svm_copy_lbrs(&vmcb02->save, &vmcb12->save);
> +		vmcb_mark_dirty(vmcb02, VMCB_LBR);
>   		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
>   	} else {
> -		svm_copy_lbrs(vmcb02, vmcb01);
> +		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
> +		vmcb_mark_dirty(vmcb02, VMCB_LBR);
>   	}
>   	svm_update_lbrv(&svm->vcpu);
>   }
> @@ -1186,10 +1188,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>   		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
>   
>   	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
> -		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK)))
> -		svm_copy_lbrs(vmcb12, vmcb02);
> -	else
> -		svm_copy_lbrs(vmcb01, vmcb02);
> +		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
> +		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
> +	} else {
> +		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
> +		vmcb_mark_dirty(vmcb01, VMCB_LBR);
> +	}
>   
>   	svm_update_lbrv(vcpu);
>   
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fc42bcdbb5200..9eb112f0e61f0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -795,17 +795,6 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
>   	 */
>   }
>   
> -void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
> -{
> -	to_vmcb->save.dbgctl		= from_vmcb->save.dbgctl;
> -	to_vmcb->save.br_from		= from_vmcb->save.br_from;
> -	to_vmcb->save.br_to		= from_vmcb->save.br_to;
> -	to_vmcb->save.last_excp_from	= from_vmcb->save.last_excp_from;
> -	to_vmcb->save.last_excp_to	= from_vmcb->save.last_excp_to;
> -
> -	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
> -}
> -
>   static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
>   {
>   	to_svm(vcpu)->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index c2acaa49ee1c5..e510c8183bd87 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -687,8 +687,16 @@ static inline void *svm_vcpu_alloc_msrpm(void)
>   	return svm_alloc_permissions_map(MSRPM_SIZE, GFP_KERNEL_ACCOUNT);
>   }
>   
> +#define svm_copy_lbrs(to, from)					\
> +({								\
> +	(to)->dbgctl		= (from)->dbgctl;		\
> +	(to)->br_from		= (from)->br_from;		\
> +	(to)->br_to		= (from)->br_to;		\
> +	(to)->last_excp_from	= (from)->last_excp_from;	\
> +	(to)->last_excp_to	= (from)->last_excp_to;		\
> +})
> +
>   void svm_vcpu_free_msrpm(void *msrpm);
> -void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
>   void svm_enable_lbrv(struct kvm_vcpu *vcpu);
>   void svm_update_lbrv(struct kvm_vcpu *vcpu);
>   
Since


