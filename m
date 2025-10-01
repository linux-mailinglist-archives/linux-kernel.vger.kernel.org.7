Return-Path: <linux-kernel+bounces-838568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3CBBAF8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9853AF5C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2A279DDB;
	Wed,  1 Oct 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IVczpYBv"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C70279355
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306370; cv=none; b=F2rDGjn/TyNo8nRq+xwtKua64LvirG7ByWLs5/3pn3QUQC1SrHGvycJaVrVRHKT4SmE83MKn4oZmLmTOBFs/yR0v9ItoXI2bMOf6b+jDLOdutcAzgU7UbZ0noZMH3kaTP3T8KxrVhhJUZVsqOQQ4gSdJkR0kH0c4uN9n9uieJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306370; c=relaxed/simple;
	bh=/ykmk2fkekJndu1S7aDPXYfJRdmiCohbXJjZADcy7R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRdQyCXnAC9KuD0/TvXOMXIOSoRp7zLyNXQAgq0wZxxxbM2axGijBPQpBFCl1TzNaYOpJULy24mGY7AbrX49CYRbT07LtQRheAiywz5HSUuMF8bnVY6o0QSgWBjDsGHetXimxCmcC5YUibf4zzQ+84zhUITxF+Cmxy6d/a2YhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IVczpYBv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso1212882a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1759306366; x=1759911166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wta+A7F956rwxD04gcs4FdCT+k6OzI/an4+vTIk+CQ=;
        b=IVczpYBv2qLCeWjInXrrmtVuhT8dPmMMc43wBtgblij+igRlqvbOk8RWyVYd6YXgAI
         l1Cn5c/nQNJspUmcT1yqY8/XFGPQPMeE4mFBTHelL1Hf9rdt0EctoG7v2djXU34NhIBM
         XsRGpGswui+f2xMtXvqNTi0b6ikh9VYaNl0hFPnyHE/VVRgFgE+tU0HhBM6mXrrAcwZA
         80365TNXfzZCHJF3hpDU4vMg7+Zb06avzz62QpmFTbUSrXp5c/ehSLwKbiSUSJpGQz1k
         d/3JpvGco+2DsAjnJ/SRpdYeHnIal82pq12B/mHTFbPxrjMcHNoFjPZkTpnLNDrZ/6uX
         IFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759306366; x=1759911166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wta+A7F956rwxD04gcs4FdCT+k6OzI/an4+vTIk+CQ=;
        b=g0hWlXw5d6RXtAAXTzGuNt9cIDX9fA+7+2d1KunW87Fma4/MLPM8fQSqPmp0ZLsOZC
         EwNVqBYaf1NwNLaqTiPGWtlUwHn9SJmGs9IJicJmlkzSXoFk5oi2ik9X281xEaX1bY/N
         0yT3c/tAvtRKYRFgfKj7dqL8ZaNctR60HHYqDqWfQ7dLLSMa0DIUnvj09Pc5QemBHHzc
         F5LF851X3IVstOocKiJWNcdDpHTFpodE38gK4FhNWtRseecnhmtuZ9vQevAcl+BBUbja
         Jr7eD+TGjkFN0g8MpcuGV9ea4v2ABpQKU5/uvT8JxRnAjBU/KhA+FkmEYE8eZDFpXlfC
         BRtA==
X-Forwarded-Encrypted: i=1; AJvYcCXOgITexG6xvb0lXM69cNqu5SYc3RFIPlRKdvwCx/PiDhpT+7SivFWFIkk3pfR4hRtQqmpbsn3r1rxFrnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaauvKu97eVoQvjXtsWpfiSKvGRfWQhc2GGsE5qHD5KigPWpok
	5EdGJjgBuPYID9ywEtaQMOo5nJ8VnDcISiUFsPyDcrjxWFjFUPwBYTf6VX8qs/J1iiwF2+sSGqB
	jHZY6mGYBU88EJ/z+cxQnUEUuXqjIrIWfXmOpmpezmg==
X-Gm-Gg: ASbGncuSZI/ev5W6uGmter4zn5GrjDu9I0nbT7y7MgRDA4+iJxgn0Uej9S2QFnRJyao
	HoGVnRfQ8LHvndFRTAGx6ESCVEt3usHa4OcKAMXLU95CKN/afZNtqfsC6aANioygqfT8hWnAuDP
	EnOx7YZaTxQPGmQYr1K7roAVXBeDpOY6IzwDTGTfOPYDmCtiz64XkX3tD3MdXjcX9i9WyTe9+fO
	Lzp1S/Qypvma80G+EtmYpzEVQRozX4=
X-Google-Smtp-Source: AGHT+IHxoxX3gNePX92jgrf3o5NGrsKnxP1/TaoEMmDFGG51CJYv4H8WcqjR9qqpRa0ecLRvIjN9Sz2BUF6bF5jNxvU=
X-Received: by 2002:a05:6402:354f:b0:62f:935e:5f56 with SMTP id
 4fb4d7f45d1cf-63678e7ba35mr1645295a12.7.1759306366111; Wed, 01 Oct 2025
 01:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-vmscape-bhb-v1-0-da51f0e1934d@linux.intel.com> <20250930012102.iayl5otar3lim23i@desk>
In-Reply-To: <20250930012102.iayl5otar3lim23i@desk>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 1 Oct 2025 10:12:33 +0200
X-Gm-Features: AS18NWDjsMAcIoTBRAqX3j_rJS61kSImXarv5R47JeNrqoZozENyZbt4z5E7ip0
Message-ID: <CAMGffEmJM+NZVM4HaXA6jmdjB1C6nPNxmLizD9P-3CojfVLsXw@mail.gmail.com>
Subject: Re: [PATCH 0/2] VMSCAPE optimization for BHI variant
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	David Kaplan <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, asit.k.mallick@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tao1.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:22=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Mon, Sep 29, 2025 at 07:12:03AM +0200, Jack Wang wrote:
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> >
> > Hi Pawan,
> >
> > Thx for the patches, I tested them on our Intel SierraForest machine wi=
th
> > fio 4k randread/randwrite from guest, qemu virtio-blk, noticed nice
> > performance improvement comparing to the default IBPB before exit to
> > userspace mitigation. eg with default IBPB mitigation fio gets 204k IOP=
S,
> > with this new Clear BHB before exit to userspace gets 323k IOPS.
>
> Thanks for sharing the results.
>
> I realized the LFENCE in the clear_bhb_long_loop() is not required. The
> ring3 transition after the loop should be serializing anyways. Below patc=
h
> gets rid of that LFENCE. It should give some performance boost as well.
>
> --- 8< ---
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Subject: [PATCH] x86/vmscape: Remove LFENCE from BHB clearing long loop
>
> Long loop is used to clear the branch history when switching from a guest
> to host userspace. The LFENCE barrier is not required as ring transition
> itself acts as a barrier.
>
> Move the prologue, LFENCE and epilogue out of __CLEAR_BHB_LOOP macro to
> allow skipping the LFENCE in the long loop variant. Rename the long loop
> function to clear_bhb_long_loop_no_barrier() to reflect the change.
>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Yes, I can confirm with this change on top, I get almost same
performance as vmscape=3Doff for fio test.

Thx for pushing the performance further.
> ---
>  arch/x86/entry/entry_64.S            | 32 +++++++++++++++++-----------
>  arch/x86/include/asm/entry-common.h  |  2 +-
>  arch/x86/include/asm/nospec-branch.h |  4 ++--
>  3 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index f5f62af080d8..bb456a3c652e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1525,10 +1525,6 @@ SYM_CODE_END(rewind_stack_and_make_dead)
>   * Target Selection, rather than taking the slowpath via its_return_thun=
k.
>   */
>  .macro __CLEAR_BHB_LOOP outer_loop_count:req, inner_loop_count:req
> -       ANNOTATE_NOENDBR
> -       push    %rbp
> -       mov     %rsp, %rbp
> -
>         movl    $\outer_loop_count, %ecx
>         ANNOTATE_INTRA_FUNCTION_CALL
>         call    1f
> @@ -1560,10 +1556,7 @@ SYM_CODE_END(rewind_stack_and_make_dead)
>         jnz     1b
>  .Lret2_\@:
>         RET
> -5:     lfence
> -
> -       pop     %rbp
> -       RET
> +5:
>  .endm
>
>  /*
> @@ -1573,7 +1566,15 @@ SYM_CODE_END(rewind_stack_and_make_dead)
>   * setting BHI_DIS_S for the guests.
>   */
>  SYM_FUNC_START(clear_bhb_loop)
> +       ANNOTATE_NOENDBR
> +       push    %rbp
> +       mov     %rsp, %rbp
> +
>         __CLEAR_BHB_LOOP 5, 5
> +
> +       lfence
> +       pop     %rbp
> +       RET
>  SYM_FUNC_END(clear_bhb_loop)
>  EXPORT_SYMBOL_GPL(clear_bhb_loop)
>  STACK_FRAME_NON_STANDARD(clear_bhb_loop)
> @@ -1584,8 +1585,15 @@ STACK_FRAME_NON_STANDARD(clear_bhb_loop)
>   * protects the kernel, but to mitigate the guest influence on the host
>   * userspace either IBPB or this sequence should be used. See VMSCAPE bu=
g.
>   */
> -SYM_FUNC_START(clear_bhb_long_loop)
> +SYM_FUNC_START(clear_bhb_long_loop_no_barrier)
> +       ANNOTATE_NOENDBR
> +       push    %rbp
> +       mov     %rsp, %rbp
> +
>         __CLEAR_BHB_LOOP 12, 7
> -SYM_FUNC_END(clear_bhb_long_loop)
> -EXPORT_SYMBOL_GPL(clear_bhb_long_loop)
> -STACK_FRAME_NON_STANDARD(clear_bhb_long_loop)
> +
> +       pop     %rbp
> +       RET
> +SYM_FUNC_END(clear_bhb_long_loop_no_barrier)
> +EXPORT_SYMBOL_GPL(clear_bhb_long_loop_no_barrier)
> +STACK_FRAME_NON_STANDARD(clear_bhb_long_loop_no_barrier)
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/e=
ntry-common.h
> index b7b9af1b6413..c70454bdd0e3 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -98,7 +98,7 @@ static inline void arch_exit_to_user_mode_prepare(struc=
t pt_regs *regs,
>                 if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
>                         indirect_branch_prediction_barrier();
>                 else if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_EXIT_T=
O_USER))
> -                       clear_bhb_long_loop();
> +                       clear_bhb_long_loop_no_barrier();
>
>                 this_cpu_write(x86_pred_flush_pending, false);
>         }
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/=
nospec-branch.h
> index 32d52f32a5e7..151f5de1a430 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -388,9 +388,9 @@ extern void write_ibpb(void);
>
>  #ifdef CONFIG_X86_64
>  extern void clear_bhb_loop(void);
> -extern void clear_bhb_long_loop(void);
> +extern void clear_bhb_long_loop_no_barrier(void);
>  #else
> -static inline void clear_bhb_long_loop(void) {}
> +static inline void clear_bhb_long_loop_no_barrier(void) {}
>  #endif
>
>  extern void (*x86_return_thunk)(void);

