Return-Path: <linux-kernel+bounces-874247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289BC15CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 553A3354B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B333CEA2;
	Tue, 28 Oct 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2aHdX4Jr"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC01A9F9F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668987; cv=none; b=Oe1pCjv5llwRTFTyKpi2ulmYqPriuPLymg/hkx48WafQnTXzvLrBhMq7yrJukxeVk3qAKi08JaD7Z1lq7k1ijKjDQl0v24TNWWxhzYDKMOpzGrQM9BZ8FIq1/PnR2n67dnwTCv3JldxIigv5fpBL2p6a+G6n9Ltb44VCCcSwOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668987; c=relaxed/simple;
	bh=xQ0DSL8vGlaPGQU9Hp7y9CcwdlTXKyRGe5V82OocB5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhrnvOEdkTTVimWozKgBPIcIxhcmqzyVfi753FEtLT7XNLVQ3pfF0X4XbFcYWH8o8SbLCpWkpsUnc202PbaGJyTKq1rZWiIqA9iIvaOMFxesvfoiC/BiJP6dY9C1K8VS1rqfgs2AP9TIWYiaNDf6/U4qtge3XsHBQwxlpEgk09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=2aHdX4Jr; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430da09aa87so29220145ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761668985; x=1762273785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU+TdivIUQqN8kZ5z+UlMDP2EK04JqI3D0gfCEED62A=;
        b=2aHdX4JrMmiQeCqQefDdTvXXrjSCVX/dfkXE/gznbAtx5/jO01zA+l/CJNEQuvLnWX
         o6v0/DoyzWNPt3oSO++UjGjCslc+BXZ4FJRnCzp5YOexCvA8Asa+ArKqnVhScY+mdZ3J
         b+TaWGvrrE4HNPF0lpgE6FLcnHdu4KGY3RCYkbyKDT6aMEMPpfTyhFU6nar7FOh+DC2e
         CWAEehGAl5V6gCaence0ZgaXdHvFofgWbmqiEP/QK9zD9iUosgZbKlSmfIK7Z5Gf9Zf+
         KsXV64UgSzgZr/yAvzoe2fLOfJ2xEwnlH2cRsuRzhqeIuQfwLDSd6Qv1Fz7KGXJaJJzY
         nGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668985; x=1762273785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU+TdivIUQqN8kZ5z+UlMDP2EK04JqI3D0gfCEED62A=;
        b=a0NgbQ9Fb7uWj/GKW7sPqERtTv4deTlYbQ5rbUSeFzKqp0EfbWNVFAEaBaMCMg7myV
         y7KgrZl9X5yoqAO/d5h+nsz+PwWPk1DgmxlE6YPB4V7VFFiph1Sw68jWC8LFhCSRCSOA
         UE8yk0eELiTGZVFtyP7/WPUGzZYUkcK0Tpgkk46mJisSl7k1b6J5m+8N/VJGvLykXvux
         Mpho5DGRJKfnPF9Gv/n994Qvcpx5r/6EhOAmbq8GQbl1Fblux2NqDNfEHqEGV2qlWsoP
         5YcC8J/IojawRhM5ll6GN1Afq9RyhCYH+dTtfnDHuLTU/+kXBoxXavssDcXho6ryQGux
         UReg==
X-Forwarded-Encrypted: i=1; AJvYcCVOenAlQh5o//sw3qL+KwemFsGkaziR/xhmzkG5TKWJdv8SAWyxCvw+XPeci1g6ySs5E0QK1RvYRNaJ/q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgh1r2VzbysoPOMu16RxBDkmLMMTVySbgy+KFw8nnkYp9jcpBU
	lPgOSYpGTMe0zGX4IZoh3qDYVfvAfuXQrWdiwpE7loB19ZZDMYGAK4QdZF/Ax5ENkxGubHrfCRz
	O3sb399kDGUifsOTQm2a4BVw5XP4aUgV0a4qriNMvog==
X-Gm-Gg: ASbGncvM92OcIjv4ycDqurk8Ohzt4U2tFlIX35s15u05P6aE6TP2NFkyYuvRAfO5Hme
	hvnDgp8ZU5KmJ0bEyhP1/AL1Z0qqQUyG93JH4fpDV9GINv8RKv90re0oDFp7WYdM027x8IV6p9E
	sQiqtK96YpulRUG5S9cj1qld3AnB2eIMB7GGNO25rPjtETZK7uO0L9q4UN5VnirP0g9jl6bTuCj
	91rj/SrrwdPSyOmX4tRt4LknKyOeR3niwLyzr3JGeJgw8fmlzNMJeZF+rMbDcd9e3aC0ruFsLjW
	K/eOxrTiv92kwggsZg==
X-Google-Smtp-Source: AGHT+IErAS74fWZIiI+tq2UyEDPXnXxNVCopnwSSqDNelEK9r7LFhgamKfvM6HVy6byU9ivOLNYx10ZFvWOtH8QctNI=
X-Received: by 2002:a05:6e02:97:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-432f82bbd0dmr6242035ab.10.1761668984856; Tue, 28 Oct 2025
 09:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023032517.2527193-1-minachou@andestech.com>
In-Reply-To: <20251023032517.2527193-1-minachou@andestech.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 28 Oct 2025 21:59:34 +0530
X-Gm-Features: AWmQ_blNGqcbnB8O5PtfaRq8QkAGM6_aeGo0IUFrD9sil21TuzEIfSgTnICVsec
Message-ID: <CAAhSdy285QMVghHZv0He8-YOdBdK71_UXtQcy7_nf=3jaPxWsg@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: KVM: flush VS-stage TLB after VCPU migration
 to prevent stale entries
To: Hui Min Mina Chou <minachou@andestech.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tim609@andestech.com, ben717@andestech.com, 
	az70021@gmail.com, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:59=E2=80=AFAM Hui Min Mina Chou
<minachou@andestech.com> wrote:
>
> From: Hui Min Mina Chou <minachou@andestech.com>
>
> If multiple VCPUs of the same Guest/VM run on the same Host CPU,
> hfence.vvma only flushes that Host CPU=E2=80=99s VS-stage TLB. Other Host=
 CPUs
> may retain stale VS-stage entries. When a VCPU later migrates to a
> different Host CPU, it can hit these stale GVA to GPA mappings, causing
> unexpected faults in the Guest.
>
> To fix this, kvm_riscv_gstage_vmid_sanitize() is extended to flush both
> G-stage and VS-stage TLBs whenever a VCPU migrates to a different Host CP=
U.
> This ensures that no stale VS-stage mappings remain after VCPU migration.
>
> Fixes: 92e450507d56 ("RISC-V: KVM: Cleanup stale TLB entries when host CP=
U changes")
> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

My comments on v2 are not addressed.

Regards,
Anup

> ---
> v3:
> - Resolved build warning; updated header declaration and call side to
>   kvm_riscv_local_tlb_sanitize
>
> v2:
> - Updated Fixes commit to 92e450507d56
> - Renamed function to kvm_riscv_local_tlb_sanitize
>
>  arch/riscv/include/asm/kvm_vmid.h | 2 +-
>  arch/riscv/kvm/vcpu.c             | 2 +-
>  arch/riscv/kvm/vmid.c             | 8 +++++++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vmid.h b/arch/riscv/include/asm/k=
vm_vmid.h
> index ab98e1434fb7..75fb6e872ccd 100644
> --- a/arch/riscv/include/asm/kvm_vmid.h
> +++ b/arch/riscv/include/asm/kvm_vmid.h
> @@ -22,6 +22,6 @@ unsigned long kvm_riscv_gstage_vmid_bits(void);
>  int kvm_riscv_gstage_vmid_init(struct kvm *kvm);
>  bool kvm_riscv_gstage_vmid_ver_changed(struct kvm_vmid *vmid);
>  void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu);
> -void kvm_riscv_gstage_vmid_sanitize(struct kvm_vcpu *vcpu);
> +void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu);
>
>  #endif
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 3ebcfffaa978..796218e4a462 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -968,7 +968,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>                  * Note: This should be done after G-stage VMID has been
>                  * updated using kvm_riscv_gstage_vmid_ver_changed()
>                  */
> -               kvm_riscv_gstage_vmid_sanitize(vcpu);
> +               kvm_riscv_local_tlb_sanitize(vcpu);
>
>                 trace_kvm_entry(vcpu);
>
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index 3b426c800480..6323f5383d36 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -125,7 +125,7 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vc=
pu)
>                 kvm_make_request(KVM_REQ_UPDATE_HGATP, v);
>  }
>
> -void kvm_riscv_gstage_vmid_sanitize(struct kvm_vcpu *vcpu)
> +void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>  {
>         unsigned long vmid;
>
> @@ -146,4 +146,10 @@ void kvm_riscv_gstage_vmid_sanitize(struct kvm_vcpu =
*vcpu)
>
>         vmid =3D READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>         kvm_riscv_local_hfence_gvma_vmid_all(vmid);
> +
> +       /*
> +        * Flush VS-stage TLBs entry after VCPU migration to avoid using
> +        * stale entries.
> +        */
> +       kvm_riscv_local_hfence_vvma_all(vmid);
>  }
> --
> 2.34.1
>

