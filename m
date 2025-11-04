Return-Path: <linux-kernel+bounces-885088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36C4C31F71
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE84D3B51AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA3264630;
	Tue,  4 Nov 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR2MSp67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE82F6191
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272047; cv=none; b=cK0L4ADZggWr9UZDME8yEhv+dSR1UHmNOTHRngtl4epDo5Q++UOsqCaok6YAlLV8fnLgkDFK4aOSWhrmYicQ9yVTz0sfikndaeXYQNvlYJ0iHsjObdK1ercpLeO7WSFm/34VDVY9CcXPm8doDek8gbF8wQgPT3R6bvi/PjoFGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272047; c=relaxed/simple;
	bh=ybUNx2jIsLvN4wny2PiVPksAIEQ72qetHRtyXmJ7k+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dz7EfhGEm+igraj/xNdRG2heTXNL01FyZABsp39Cz508gfu8M3WvqQETIYppFW/jfdWrRo08JjXJCfJ2aqjjOddzYki1Uo46kICYvAEWyOrngRTRM2AlH4AOmvaolLTYjNRYsmqZv/z89ymfmCPolRzSQhWuswNwOcNVzeZfMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR2MSp67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BD8C19424
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762272046;
	bh=ybUNx2jIsLvN4wny2PiVPksAIEQ72qetHRtyXmJ7k+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aR2MSp67zqdggky6ji+ROENkuohDPiaQlj3TFfzgJuVOIikzpSfzs+sq46ojKZw8r
	 A5FlDZe39wDsjKHO5j/9noGKuu2zvq7e8tf44OhtOPqKRjtpZXmupTez8z6OzE3nXu
	 BPq0ODTnbiP9WZQxzzsuKr6vJD68nnX526E8EvNl28saz18spNanPFefLHsLu30olA
	 I6oCp9oHONaotM3RZD+oIso/ZtQSugSn4juCLOk6flkvIAYl3WRR4Y3gHKUl5Y6WHW
	 Vv8dDByVwHj5T06QxIxCa/RGTB0pRLkYg8miXLppj54c+LQdSYShe2HgwA8gQSAbW2
	 ibXI8F9kXwDiQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59052926cf9so6311756e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeMT5WA/r1DXdkU0HRj7gqJ8Y8BCrwfNrvesr7xgn1hZvNjN7AjPlEJZOA6mhSI6+lo73DxwqvREe+qKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfJr2Hk8N85MEtlsqcEAl+X5k1xVjwjQmaZjJswyL/XoyrvLT
	qfTFUjoILyyadqG1kVEr01P0qvLx0J/2cMIsZ8b+YqVGOruo1LAZ+XVfhex5wXKVDgEhspjMC4k
	ae3GbmaK1qMrUHj6qFq5se0xowTKU6OI=
X-Google-Smtp-Source: AGHT+IHl4TYsbIp7q7RcLM8gvEfvv4DHuvd8GjPAShqj+bYodluXicBE5Hx5rY1swrBJdmW0rYHy3/YN70gri25XdyM=
X-Received: by 2002:a05:6512:2391:b0:594:33fc:d52b with SMTP id
 2adb3069b0e04-59433fcdb46mr1505550e87.36.1762272045211; Tue, 04 Nov 2025
 08:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com> <20251015205634.3820870-12-ardb+git@google.com>
 <aQohO07DpxlriQfJ@willie-the-truck>
In-Reply-To: <aQohO07DpxlriQfJ@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Nov 2025 17:00:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHJ8QWLE=awDUpNa0Cf_1YXMQaW-Se1NvvavOocshDkTQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnZWe2FwdCEPmDBbfXyQD7IMRyef3q6dtPcCDOW1XeyOM1FaYaJOwR85bI
Message-ID: <CAMj1kXHJ8QWLE=awDUpNa0Cf_1YXMQaW-Se1NvvavOocshDkTQ@mail.gmail.com>
Subject: Re: [PATCH v4 resend 3/7] arm64/fpsimd: Don't warn when EFI execution
 context is preemptible
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 16:52, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Oct 15, 2025 at 10:56:38PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Kernel mode FP/SIMD no longer requires preemption to be disabled, so
> > only warn on uses of FP/SIMD from preemptible context if the fallback
> > path is taken for cases where kernel mode NEON would not be allowed
> > otherwise.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/fpsimd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index e3f8f51748bc..3d848c89604e 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -1934,11 +1934,11 @@ void __efi_fpsimd_begin(void)
> >       if (!system_supports_fpsimd())
> >               return;
> >
> > -     WARN_ON(preemptible());
> > -
> >       if (may_use_simd()) {
> >               kernel_neon_begin();
> >       } else {
> > +             WARN_ON(preemptible());
> > +
>
> Given that may_use_simd() returns false on systems without support for
> fpsimd, I wonder whether moving this WARN_ON() actually helps with
> anything.

This code is only reachable if system_supports_fpsimd() returns true,
so may_use_simd() will only return false here when running in
hardirq/NMI context.

> That is, you probably shouldn't be calling __efi_fpsimd_begin()
> from preemptible code regardless, no?
>

Not sure I follow you here: __efi_fpsimd_begin() is generally called
from preemptible code, and it is the EFI runtime wrappers themselves
that disable preemption - that is the whole point of this series.

