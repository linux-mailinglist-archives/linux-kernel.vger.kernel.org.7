Return-Path: <linux-kernel+bounces-883044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0313CC2C603
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4D23B52FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A10305062;
	Mon,  3 Nov 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qaihg5Er"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80172FF64C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179039; cv=none; b=Nn7VUr5ZXWhht65bHhuiIU0gKvtwpGIDwOTUmoWJN7pOUCHSvmQrXQvZl+o9qQJzTBRa8TuYwBYWLzKIdHuWEKL0eHrdWg5y0hsHRsheAFU8NwsfTdMvz3kisxNZkyRbzZP2f/i/N5UyClf8ezH94T8TY9rU1BRmBqHyO7P+dBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179039; c=relaxed/simple;
	bh=UtNwVwI/wqn5FQwPmZJqlNOH1MWM7O77ROobJGWWcG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcOtoyXXpph/Jd6c//nIUbE40yRZ1RRfxFytD5euC49OC7myEGOAUv9ehLrcOMfEV0uThMz+MHzzMfHCv5yAi5p3uPkBkiDVOVKkMVrwSeeAyTL3TOv8zLJQQ5BfB48viP91O84I4RL9nOKdP6PHtwkqY+cuFmX2f3KpF9CyJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qaihg5Er; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c52db2e41fso3388527a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762179037; x=1762783837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JaPI4TOwc8pcjpYKYQR9osF0pTwnJUqTyqEhiCHODo=;
        b=Qaihg5ErBH9rUhix7o8w0sSdyFcM0AdpVmA586Fui9sgwKkcJoGttfBuKHZ/iIVgAm
         qTx27doq9h2QD4Tw6tXG44aHIXFnGdgUUBENf5afOXBqtyafL5oF6JskCEeNoH6kf8ZP
         NtjvI3oFN4OMfoWIPYi0YAnwtwT1Kh049aype9JDwMkCGPixscuoDokm2JQcR2EjO0PT
         +6TDjPJc6ThOE2h6kDzo/H7MLbIfz94wiX31C/Hl64Byd+pXAS9fWDbPKiD5TETX/fH+
         9+DVUpUyzidF4fJhPMOVfdrTPc2388mtSvN4mSALfEYHulHVBcOabRoY0Gx2s4wiBUZr
         MkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179037; x=1762783837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JaPI4TOwc8pcjpYKYQR9osF0pTwnJUqTyqEhiCHODo=;
        b=dk5foBOD1Lo+A8PuTUI2Va5LPpKT9T1rJk9/o8EbW3ndpMSNuDZOc0zjm5e9weYA8m
         Wefr3w65n04KIYst3zZGiUHcf9VSptE32smMhgoa2K7zOZopMUED/uvyfDwU0H+mMCX/
         EgIijS5VCJNNagHhbRL0m4c+us8edFgcRBcEk5Pcf3djachGApRJWmJoNMrFp/afe6X9
         Zj19+Zd0aRfvjF/QplsEj+aTlD4laKafwENUnoLVHdR4m5XclAUBJDu9MpigfvHno93O
         tXU5PhGaOgAZrTECjy88SWB6gW4+CtWX2FvhrHsGXt1RM0B3jf0y4P0itf/C/Q8RzpjV
         LiRg==
X-Forwarded-Encrypted: i=1; AJvYcCW1hyXkN3kASZsBpPTKt5nmZBMqeOuXCQotzDULSc0EToFM2IqoZZ+7DbVzgvfKdAFCuqstdW4Hs30W+HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRttGdFIFUkx5PTdGvJzFvUfvK4jpdPYanrJExx9EY29piO/0D
	njvNUh2rXTnxy9O6FzEmj/PAgOoV5Ngp5MO2kCh7Vcu/O4bQUVAfckFDXVWW+d4+FqcQwitQjVP
	XIBbUc+Hxh7BcK7GITtQUMV/dEsrLpxoayCNCi0L+bA==
X-Gm-Gg: ASbGncuULxuloKsd7gpevbFuVqfYdsRRA2fbyN+pOaUEewNLTexzAbJJh9K7DzKlEi8
	a3XbIuTj1ouH7j6Lgp776+g0Js38fOPgW/G8I/rtvl5ODHKS6Pa13364S/5i56wY9fEp/PL6TcQ
	cJUpI3OQwOEJ79QTreVKcggUXR5YD6XnnrukcwXTAGGxOdgvfx1NIpAnKosERptH1oFTSTTAITh
	Wi1MFcOwYliSGyE44INm2ledaZHIBUBao6Mwg3QVaSJAFOKSf02pAYPXf5qKwu+k7V5+fDscPpX
	V9J+LcpN
X-Google-Smtp-Source: AGHT+IH003xd/z7vMYdYr/htcUUGBamI3Mhgf3J747VLZKVMmuby2I02PMB4X/i1lIibUxhRhuJgj0cQRxtddc4mmfo=
X-Received: by 2002:a05:6808:331a:b0:44f:8ccd:c489 with SMTP id
 5614622812f47-44f9538d80fmr5983206b6e.25.1762179036704; Mon, 03 Nov 2025
 06:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
 <20251027133431.15321-4-cuiyunhui@bytedance.com> <20251028-scallion-list-c8aa5f350286@spud>
 <DDTYKLFUE3M0.17GD0S4OSQG16@ventanamicro.com>
In-Reply-To: <DDTYKLFUE3M0.17GD0S4OSQG16@ventanamicro.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 3 Nov 2025 22:10:25 +0800
X-Gm-Features: AWmQ_bnrk5zzhmENTE3zzUyyuY5snirkUQxon433_6W_9CsF90gdobpBao0iCQU
Message-ID: <CAEEQ3wk8w1q8Ujpq+6fyRPP+zqTy6_q22K-g681VZyVXstPaDg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] riscv: crash: use NMI to stop the CPU
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, luxu.kernel@bytedance.com, 
	atishp@rivosinc.com, cleger@rivosinc.com, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, songshuaishuai@tinylab.org, 
	bjorn@rivosinc.com, charlie@rivosinc.com, masahiroy@kernel.org, 
	valentina.fernandezalanis@microchip.com, jassisinghbrar@gmail.com, 
	conor.dooley@microchip.com, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radim,

On Tue, Oct 28, 2025 at 8:36=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-10-28T10:42:12+00:00, Conor Dooley <conor@kernel.org>:
> > On Mon, Oct 27, 2025 at 09:34:31PM +0800, Yunhui Cui wrote:
> >> NMI is more robust than IPI for stopping CPUs during crashes,
> >> especially with interrupts disabled. Add SBI_SSE_EVENT_LOCAL_CRASH_NMI
> >> eventid to implement NMI for stopping CPUs.
> >>
> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> ---
> >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi=
.h
> >> @@ -487,6 +487,7 @@ enum sbi_sse_attr_id {
> >>  #define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS   0x00108000
> >>  #define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED       0xffff0000
> >>  #define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI             0xffff0001
> >> +#define SBI_SSE_EVENT_LOCAL_CRASH_NMI               0xffff0002
>
> This event isn't defined in the SBI pull request.
>
> I assume it's a pure software event that the platform shouldn't inject.
> If we want to reserve more events for software use, why not make them
> generic, like SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED?

In fact, it's not just crash NMI, but also stop NMI, kgdb NMI, etc. An
event can only register one SSE handler. If all use
SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, we'll have to execute each
different NMI handler in sequence within the SSE handler, with each
NMI handler checking for itself if there are NMIs of its type to
process.
Is that what you mean too?

>
> Thanks.

Thanks,
Yunhui

