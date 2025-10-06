Return-Path: <linux-kernel+bounces-843414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49964BBF223
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2A8A34B5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794834BA37;
	Mon,  6 Oct 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3syiBFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA91221FAE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780789; cv=none; b=KZ3titAfDh+EbYuywC3fBPgNo7CD9oYvIxVIULJhuxiQZjwAR9T5jwdHFn1+pvBdddiqxuqtMULaBRZGDuAhd0ovE8difFaKnfUoJUQg3r8nUzOVvn4HcN0tnBLU52aBNfN49YVeGG4hJmxY53U30Rj66d+YHEQ1W8unCZ+WOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780789; c=relaxed/simple;
	bh=RGOjghczmBhOn629RRqeFBoH+bmWrNCvmm7l98/ereY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtynoY9xdrQuw8Mkch2h7qtbbt5jnIQgnpfR0kf3DLRNCF/J1h/xPS6hXCppNN8nA60pRMVdkd1vzQKkd34TLwyV/Sv0B9/C40CCmGlyr9fUD0Pz1vvG83zmbdjTxigiThSQeoxIMnbba9tfJmCvrw78B1A/IVf41Wpwnp9n7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3syiBFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19519C113D0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759780789;
	bh=RGOjghczmBhOn629RRqeFBoH+bmWrNCvmm7l98/ereY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f3syiBFFmJTX8U4zhWCmLfRemYi6nT3Nr0TsNcoNis6Qoh5r4Mdoa6w5gfWBPBHhJ
	 nHTBKNMHLZAWiNfHmqo8ce9AapAcjmrk+w7oLuoxwsP6i4Y3jszTCcAuyZ5b051Sh5
	 NrVphzBp23MsKCtY+R/RsC4OGMFO7+uQZFJ9kEoXe6ienz/9tF5u3jpD+xXf0urFOV
	 P5HRvMkAg5Ead/82pXoYDMmBoP3esHe/8uX6XV816zJs6hSey6bx/y60zC+z+dCKJE
	 XxYX22gkH5u64eMGBbE76BD7aM3i4NZkbb+Y+CfAWVL7r/gkqeEz2gmhWRMJroM8G3
	 MNbR44HmX3XqQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36bf096b092so48699871fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:59:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJicctwanCsfSockWT48hoa9OJkIkXeZxJqPDDaXKxiWeIrBBuAZZLBEcMidE3Cj/n6s1B2W22TADAldQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFm59kTSADkQGIX2EsoyR8ggEqqLAjwYpf3pLqujCG6CKbKMi
	RwwV75dXMFneAM3Izpn9hQ354HmuVQG5VA45+cwpYsSpjOzWdn5z8vJYlEjX7sY71dzEeSP69SS
	+dHI7Q0tiEqibiu6VSuCeo47TtecYhZ8=
X-Google-Smtp-Source: AGHT+IFCefbDSL2GYf6TgImraEUnQIVmnSoToPwmnqaXu68yMygrqwch2iehFFb+Yblt2/Ln03XrF5n8NYG5k5DfAYk=
X-Received: by 2002:a2e:bc86:0:b0:373:a93d:5b2e with SMTP id
 38308e7fff4ca-374c36ba428mr50608951fa.3.1759780787463; Mon, 06 Oct 2025
 12:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002210044.1726731-2-ardb+git@google.com> <5824c012-dcb2-4312-9b16-810656290831@amd.com>
In-Reply-To: <5824c012-dcb2-4312-9b16-810656290831@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 Oct 2025 21:59:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHUjL7=CPz0viSBvfeX=BKNYuUkrpTizn9H1ZgJecB6cQ@mail.gmail.com>
X-Gm-Features: AS18NWCnlytWnKuUujx3FjdzntMejSYw-Dggtn3KRe_zRGRZD-JaqCeN49BKKzs
Message-ID: <CAMj1kXHUjL7=CPz0viSBvfeX=BKNYuUkrpTizn9H1ZgJecB6cQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsafe uses of kernel mode FPU
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, broonie@kernel.org, 
	Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 19:42, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 02.10.25 23:00, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The point of isolating code that uses kernel mode FPU in separate
> > compilation units is to ensure that even implicit uses of, e.g., SIMD
> > registers for spilling occur only in a context where this is permitted,
> > i.e., from inside a kernel_fpu_begin/end block.
> >
> > This is important on arm64, which uses -mgeneral-regs-only to build all
> > kernel code, with the exception of such compilation units where FP or
> > SIMD registers are expected to be used. Given that the compiler may
> > invent uses of FP/SIMD anywhere in such a unit, none of its code may be
> > accessible from outside a kernel_fpu_begin/end block.
> >
> > This means that all callers into such compilation units must use the
> > DC_FP start/end macros, which must not occur there themselves. For
> > robustness, all functions with external linkage that reside there shoul=
d
> > call dc_assert_fp_enabled() to assert that the FPU context was set up
> > correctly.
>
> Thanks a lot for that, I've pointed out this restriction before as well.
>
> Since we had that issue multiple times now would it be somehow possible t=
o automate rejecting new code getting this wrong?
>
> E.g. adding something to the DC_FP_START()/DC_FP_END() or kernel_fpu_begi=
n/end macros to make sure that they fail to compile on compolation units wh=
ere FP use is enabled?
>

Something like the below perhaps?

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 73a10f65ce8b..d03e3705bade 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -35,7 +35,7 @@ endif

 # The GCC option -ffreestanding is required in order to compile code conta=
ining
 # ARM/NEON intrinsics in a non C99-compliant environment (such as the kern=
el)
-CC_FLAGS_FPU   :=3D -ffreestanding
+CC_FLAGS_FPU   :=3D -ffreestanding -DIN_SIMD
 # Enable <arm_neon.h>
 CC_FLAGS_FPU   +=3D -isystem $(shell $(CC) -print-file-name=3Dinclude)
 CC_FLAGS_NO_FPU        :=3D -mgeneral-regs-only
diff --git a/arch/arm64/include/asm/fpu.h b/arch/arm64/include/asm/fpu.h
index 2ae50bdce59b..1297e660bd89 100644
--- a/arch/arm64/include/asm/fpu.h
+++ b/arch/arm64/include/asm/fpu.h
@@ -8,8 +8,10 @@

 #include <asm/neon.h>

+#ifndef IN_SIMD
 #define kernel_fpu_available() cpu_has_neon()
 #define kernel_fpu_begin()     kernel_neon_begin()
 #define kernel_fpu_end()       kernel_neon_end()
+#endif

 #endif /* ! __ASM_FPU_H */

