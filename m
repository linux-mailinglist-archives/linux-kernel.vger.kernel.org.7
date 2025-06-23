Return-Path: <linux-kernel+bounces-699133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F86AE4E38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 22:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3C816AD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC42D5437;
	Mon, 23 Jun 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSnvRcZf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAD2D4B57
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711226; cv=none; b=HcpcHMM7cmbh0gzdEW+honCpKEFZGbHg6RyKvZ5YXX1q8SunByDULxvZb1q9J+mov9UOqL8MY5wTCfWnmNEZz7LiToOXYESIgM1Ez7B0WVetpIHf9xRsEu138b5ZuesqgPXYSEDI+9kEYSxK3oV3aKXUqmIhtcWI9yOqKtxF/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711226; c=relaxed/simple;
	bh=Zhuvl4KnS3oB7uKqYBHpHRfcybkMRxnNYJ+NQXkoFBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiU9O8hMF3+tNcZnVwkLYsSHxoq8urhl2AYgSY2XsSOv5dEi9TQke/DOqbr9EFHa+iUmVi4yFLT0565D4yjMmPRnb/PypRWbcO9oy7jBmvuCVuIJjwq+2ctfturLYFa7TwSjYyp8GIzG642mk8SR6qH0OdOyTUchpK4GnJJAN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSnvRcZf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-237f18108d2so45645ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750711224; x=1751316024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQPU1jwDqaIvFAqHZbhsvjmULs6RRSSTDERPy7mYC/w=;
        b=tSnvRcZf1UYOSdfNDgYvjIr8QqP9/W8ScMdiHp4mjaWsd9PSSaiSEbL5pBk2zdhqPK
         9LJCxrLbnrbx7+WoFWIVt+l3j2V6WKGy1yvCMK8MuJHC7oyIz8GT8qhGfVKTRYEjgznc
         czAxGfl7RvQASP5GJeoaQItK7ZcaRLmAgMAc+OH+mp0LDbEGcP5lnnRzdVmHE40bXRyr
         CMc524T79E+UYhB3Yd+WLgJDHn1dsbLrmQyrLsI0q3RiAj3yZ7rnRacRQoUvPS6RX4EV
         kNOisVN3kCoRdVR/ylfPQUdCfnZQc6JCJHNzY1UJeCz4u9xtoEgsGN1AnEznIdXCGOaM
         OCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750711224; x=1751316024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQPU1jwDqaIvFAqHZbhsvjmULs6RRSSTDERPy7mYC/w=;
        b=UBEHH+NcX7MFxPpsUqBqsc7/DrS33SItinogkrrEMGLCYokwKI4O/ZQvBGtj/iYWsa
         IOqmCXhr+crUQwencChYT6UsyLYtoyhp0bhoqblBvtnokb44KK6LZD/BQ+ym8UjjF4Z1
         Jq4YNHV9aQso/vRJPXVS5aqBCWGglCpyLJbMjSjqH7PUhOk7FG4INQD+smwOY7BkqquW
         u6FqEdYWlv31D0JkgHwE79kxr96tIQRIASGH1yL4PvYFv8hnbmMJ8/qG4YIEXZcwKzPH
         rQjwCoM16Z2oNJKE0vH5aJpW/bASB4Nma8wW7BNN0Ji/kteaMYImosKAx67Q7E024vUu
         a6OA==
X-Forwarded-Encrypted: i=1; AJvYcCWPB1NHpTiw0rd9CYLDWaGRrm+dQgMca0LwkrIXbruroohxwHkG+fLs/JyFspMhpwdIwMfJtT6GSYqg2gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyFGoAf7zi31i2sZitRtQh0LJrFKRo84793iP740P71HIHJ2H
	PQiyGBTJ6GHS4PCrfADR4a0lRWAiSB8A7E8BhOxQ9+rnhdJzvlCSYqylPkZaY4cpkfBtTi2c/Y8
	0jaAjHbpeOwMVYp+ZZSgLdfLZc0psiBD+onGk0y0s
X-Gm-Gg: ASbGncsGIz7d8UwElf57YTmoaSrDEG2+LsrHAoXYpubA6g2pvksPoMpSyKEIhGIxrPT
	5UkwZoa0SQrf4J9/WJLQ0zp8qEyVaAy8afDblVv9h0IwyikE/XuAGHafbF88Og1UTf8+8im3PAl
	xlLbqUw2ZL1cazoPBafHlAZndXcP5b2ZD8r8N0aw1J155cpRsIBQ6Risl3gAIm5vgZbISZQJDN2
	kb+peIpKrM=
X-Google-Smtp-Source: AGHT+IFUHKxNUZ3MwYjq/wkDI3kUu/0SCAMOAElnU/6pCk2jEVzxFHLOd5NxdmYdVQHL1UJZyG8hqjuVYY6Eb3+e7tY=
X-Received: by 2002:a17:903:1c1:b0:223:ff93:322f with SMTP id
 d9443c01a7336-23802b63e09mr728085ad.2.1750711223886; Mon, 23 Jun 2025
 13:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611095158.19398-1-adrian.hunter@intel.com> <20250611095158.19398-2-adrian.hunter@intel.com>
In-Reply-To: <20250611095158.19398-2-adrian.hunter@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 23 Jun 2025 13:40:10 -0700
X-Gm-Features: AX0GCFuPFZd1yMYIv9481hq8QdvlFhQ_xbq_lUsfcqcvZ9md8c33VovBY0efJaM
Message-ID: <CAGtprH989TDzAyQntYjU8sTC3J_VNbNQg6dx_BzENNqXdRKs2A@mail.gmail.com>
Subject: Re: [PATCH V4 1/1] KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com, 
	kai.huang@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:52=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add sub-ioctl KVM_TDX_TERMINATE_VM to release the HKID prior to shutdown,
> which enables more efficient reclaim of private memory.
>
> Private memory is removed from MMU/TDP when guest_memfds are closed. If
> the HKID has not been released, the TDX VM is still in RUNNABLE state,
> so pages must be removed using "Dynamic Page Removal" procedure (refer
> TDX Module Base spec) which involves a number of steps:
>         Block further address translation
>         Exit each VCPU
>         Clear Secure EPT entry
>         Flush/write-back/invalidate relevant caches
>
> However, when the HKID is released, the TDX VM moves to TD_TEARDOWN state
> where all TDX VM pages are effectively unmapped, so pages can be reclaime=
d
> directly.
>
> Reclaiming TD Pages in TD_TEARDOWN State was seen to decrease the total
> reclaim time.  For example:
>
>         VCPUs   Size (GB)       Before (secs)   After (secs)
>          4       18               72             24
>         32      107              517            134
>         64      400             5539            467
>
> Link: https://lore.kernel.org/r/Z-V0qyTn2bXdrPF7@google.com
> Link: https://lore.kernel.org/r/aAL4dT1pWG5dDDeo@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
>
> Changes in V4:
>
>         Drop TDX_FLUSHVP_NOT_DONE change.  It will be done separately.
>         Use KVM_BUG_ON() instead of WARN_ON().
>         Correct kvm_trylock_all_vcpus() return value.
>
> Changes in V3:
>
>         Remove KVM_BUG_ON() from tdx_mmu_release_hkid() because it would
>         trigger on the error path from __tdx_td_init()
>
>         Put cpus_read_lock() handling back into tdx_mmu_release_hkid()
>
>         Handle KVM_TDX_TERMINATE_VM in the switch statement, i.e. let
>         tdx_vm_ioctl() deal with kvm->lock
>
>
>  Documentation/virt/kvm/x86/intel-tdx.rst | 16 +++++++++++
>  arch/x86/include/uapi/asm/kvm.h          |  1 +
>  arch/x86/kvm/vmx/tdx.c                   | 34 ++++++++++++++++++------
>  3 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/vir=
t/kvm/x86/intel-tdx.rst
> index de41d4c01e5c..e5d4d9cf4cf2 100644
> --- a/Documentation/virt/kvm/x86/intel-tdx.rst
> +++ b/Documentation/virt/kvm/x86/intel-tdx.rst
> @@ -38,6 +38,7 @@ ioctl with TDX specific sub-ioctl() commands.
>            KVM_TDX_INIT_MEM_REGION,
>            KVM_TDX_FINALIZE_VM,
>            KVM_TDX_GET_CPUID,
> +          KVM_TDX_TERMINATE_VM,
>
>            KVM_TDX_CMD_NR_MAX,
>    };
> @@ -214,6 +215,21 @@ struct kvm_cpuid2.
>           __u32 padding[3];
>    };
>
> +KVM_TDX_TERMINATE_VM
> +-------------------
> +:Type: vm ioctl
> +:Returns: 0 on success, <0 on error
> +
> +Release Host Key ID (HKID) to allow more efficient reclaim of private me=
mory.
> +After this, the TD is no longer in a runnable state.
> +
> +Using KVM_TDX_TERMINATE_VM is optional.
> +
> +- id: KVM_TDX_TERMINATE_VM
> +- flags: must be 0
> +- data: must be 0
> +- hw_error: must be 0
> +
>  KVM TDX creation flow
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  In addition to the standard KVM flow, new TDX ioctls need to be called. =
 The
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/=
kvm.h
> index 6f3499507c5e..697d396b2cc0 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -940,6 +940,7 @@ enum kvm_tdx_cmd_id {
>         KVM_TDX_INIT_MEM_REGION,
>         KVM_TDX_FINALIZE_VM,
>         KVM_TDX_GET_CPUID,
> +       KVM_TDX_TERMINATE_VM,
>
>         KVM_TDX_CMD_NR_MAX,
>  };
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b952bc673271..457f91b95147 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -515,6 +515,7 @@ void tdx_mmu_release_hkid(struct kvm *kvm)
>                 goto out;
>         }
>
> +       write_lock(&kvm->mmu_lock);
>         for_each_online_cpu(i) {
>                 if (packages_allocated &&
>                     cpumask_test_and_set_cpu(topology_physical_package_id=
(i),
> @@ -539,7 +540,7 @@ void tdx_mmu_release_hkid(struct kvm *kvm)
>         } else {
>                 tdx_hkid_free(kvm_tdx);
>         }
> -
> +       write_unlock(&kvm->mmu_lock);
>  out:
>         mutex_unlock(&tdx_lock);
>         cpus_read_unlock();
> @@ -1789,13 +1790,13 @@ int tdx_sept_remove_private_spte(struct kvm *kvm,=
 gfn_t gfn,
>         struct page *page =3D pfn_to_page(pfn);
>         int ret;
>
> -       /*
> -        * HKID is released after all private pages have been removed, an=
d set
> -        * before any might be populated. Warn if zapping is attempted wh=
en
> -        * there can't be anything populated in the private EPT.
> -        */
> -       if (KVM_BUG_ON(!is_hkid_assigned(to_kvm_tdx(kvm)), kvm))
> -               return -EINVAL;
> +       if (!is_hkid_assigned(to_kvm_tdx(kvm))) {
> +               KVM_BUG_ON(!kvm->vm_dead, kvm);
> +               ret =3D tdx_reclaim_page(page);
> +               if (!ret)
> +                       tdx_unpin(kvm, page);
> +               return ret;
> +       }
>
>         ret =3D tdx_sept_zap_private_spte(kvm, gfn, level, page);
>         if (ret <=3D 0)
> @@ -2790,6 +2791,20 @@ static int tdx_td_finalize(struct kvm *kvm, struct=
 kvm_tdx_cmd *cmd)
>         return 0;
>  }
>
> +static int tdx_terminate_vm(struct kvm *kvm)
> +{
> +       if (kvm_trylock_all_vcpus(kvm))
> +               return -EBUSY;
> +
> +       kvm_vm_dead(kvm);
> +
> +       kvm_unlock_all_vcpus(kvm);
> +
> +       tdx_mmu_release_hkid(kvm);
> +
> +       return 0;
> +}
> +
>  int tdx_vm_ioctl(struct kvm *kvm, void __user *argp)
>  {
>         struct kvm_tdx_cmd tdx_cmd;
> @@ -2817,6 +2832,9 @@ int tdx_vm_ioctl(struct kvm *kvm, void __user *argp=
)
>         case KVM_TDX_FINALIZE_VM:
>                 r =3D tdx_td_finalize(kvm, &tdx_cmd);
>                 break;
> +       case KVM_TDX_TERMINATE_VM:
> +               r =3D tdx_terminate_vm(kvm);
> +               break;
>         default:
>                 r =3D -EINVAL;
>                 goto out;
> --
> 2.48.1
>
>

Acked-by: Vishal Annapurve <vannapurve@google.com>
Tested-by: Vishal Annapurve <vannapurve@google.com>

