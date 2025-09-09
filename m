Return-Path: <linux-kernel+bounces-808227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C3B4FC18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C763B22E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098133EB11;
	Tue,  9 Sep 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Hd1kEHg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB30321F39
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423451; cv=none; b=X6XXRp1M1MB6TNeZjG/M56RuwBxEx/L54ZmJrBHvDNsrdLc4/W1Yibp+8kzwqE6GJmx1jw+cxL3rd4yyd3yeDqVAFXxjaTv1m8hHgv2UvJVSyf6QM3n4A2XvR0EHpdMY3lFgEOloqaKeVt35IX9gUW5i034S4iNS5adJmlZDDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423451; c=relaxed/simple;
	bh=bbl4DyFXk0UG+eC+k504rCf9NHkV4gzzBz1QQDB5SeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD3KcQcFWkwR7iuJ6XCSVPyWVY5LEpF0MNQYigA8vHS+Y1YCdqABZPPjZvj0orikhjqC2RKk98msIxKztHmvjk0N5LjvBdPjGVclz3BDfapUFUmSxfMoCXLIiCQDjUHlwV/7IvKfuQO2ctS9jsuTfYzwm0OMEUgm6wxGY5IIyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Hd1kEHg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de54bfc36so149405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757423448; x=1758028248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6mSkBMDtmSXT+SD6Rqrl6ORDllRpYLgcACmxMG0DYZs=;
        b=1Hd1kEHg79pzk7f6n+dcNhzGQvuEXAEKibuFRfvXWpyG7lUmHKwkKfdO1HpknKrutq
         8jx0yob/Pb/L0j50H9OU7f749+TSFRlzu6sxPXV0FqfxpVXG8xCCf/gTt/e/wvZyvfDK
         uWAihfOwD5FMq9u85B/F2JDB3h5KF9W4HffB691wqQyJ/zYVhH+lBwbiYg838GlX07wO
         uX6pvxyL+SHoz8nUJuMliwl+J5WcCWKH4Q4di/wmoUubt5mCWQZjYdtQ4BN1YpgVdlbu
         TZn3E2IpElriaEcq2dbFfresMee6GK4g6exZyrsS2EkDhzQ+Prdso18uECpr4RAhZpFw
         +dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423448; x=1758028248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mSkBMDtmSXT+SD6Rqrl6ORDllRpYLgcACmxMG0DYZs=;
        b=szAA4YLG4BR6I8ibWXV9xCrLIiw+lztagGAhh16tKU2UJVIFOJ2WDKPcqbZMbsblo8
         uCtcD1a4Wl11wj+/Vq0tipH//N837pymrKGAF/5Y97AdB29Q+Wz2RFy4znt+DYCUkqbB
         PHfU0Mmvgnyqb5SA7+XeuF4wxHtOoV3cJE6/oSDoSx3ZjbNnCbvgPPCu2rum0KtgG1O/
         QGYpS/BkpvgVkYw5X1UBEfhbodE1TzxpSijDfZZDwzXIwkYmBlsU2lP50YN0Y5PJNI3b
         qUsi1Sq9+GvlwZeWs54GeEPavQHlKk9ikVObyB2RrNkOmkX5nYpbSScAiI51hq0FjYjK
         5olQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfCha7s6jtCjJlxiddi56Ffdf5BDkdmWNCY4BW6bdLNueQgSsKai/LbAamNcOIEfbWAjj1MFfF8h2fDWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmB+x345S95DVK6zMEoQW6RWiwR6k8uEsZLjl+9bb9fik7w8ZF
	1JwI7hKuaZhigHswRtV4wPm/CUhZCzQdHAqsIjCQ86H/JHODtTd5WhKC1zsco8f0PQ==
X-Gm-Gg: ASbGncvpiOV9u48qOUXQHkCl+rj2X9CgH2WWwemPEf1Hw4Eqvdz/cjZeRjuTYBR8go5
	y3+PWFHoPEP7UEF+V6m+DIRnTQmRHWTezWdnGDqTnPQo5zMr+sqNavmRWs/ch4mH1g8UH+aevDE
	VVaGiTRCIncFGDeVbBpqJDJlFeg8Uuquro2w9KNwsKrvuiQI9T4J2R5EF7cY4K9pouZgsm/vqgi
	ACYItWtPo2IZcX8P6on4dJiubYce/RnW0Noh1TfV5I2Z27eU7Vs9z7hSSughSlCJcxFFtLkbt/r
	YreLrTt9dTWusSW3qabQ6c91zeTbI5bpBAqF+o7+8U0NE4BzXpSJpqSlLXHOVzED7ijN8gqRLst
	yxTnXqwaGa6zn0dk9ui1eGoy8DpN3CtsplNS+eX8J4HDaRNhi5D6rrScNDzPq+i4tlrE=
X-Google-Smtp-Source: AGHT+IH+u0DJgHIFy6cMKe7xSpOobqzObKFJnY4/liHGfEZfRkJ/HR3MdmvlukXa1RXp5MtkjRU4Cw==
X-Received: by 2002:a05:600c:1c81:b0:45b:9bcb:205 with SMTP id 5b1f17b1804b1-45dde17da47mr5535315e9.5.1757423447377;
        Tue, 09 Sep 2025 06:10:47 -0700 (PDT)
Received: from google.com (26.38.155.104.bc.googleusercontent.com. [104.155.38.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda2021dfsm178871185e9.24.2025.09.09.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:10:46 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:10:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, qperret@google.com, keirf@google.com
Subject: Re: [PATCH 1/2] KVM: arm64: Dump instruction on hyp panic
Message-ID: <aMAnU9ddUZPvjZIJ@google.com>
References: <20250717234744.2254371-1-smostafa@google.com>
 <20250717234744.2254371-2-smostafa@google.com>
 <aL7JLbljvX1JATP3@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aL7JLbljvX1JATP3@willie-the-truck>

On Mon, Sep 08, 2025 at 01:16:45PM +0100, Will Deacon wrote:
> On Thu, Jul 17, 2025 at 11:47:43PM +0000, Mostafa Saleh wrote:
> > Similar to the kernel panic, where the instruction code is printed,
> > we can do the same for hypervisor panics.
> > 
> > This patch does that only in case of “CONFIG_NVHE_EL2_DEBUG” or nvhe.
> > 
> > The next patch adds support for pKVM.
> > 
> > Also, remove the hardcoded argument dump_kernel_instr().
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/include/asm/traps.h |  1 +
> >  arch/arm64/kernel/traps.c      | 20 +++++++++++++-------
> >  arch/arm64/kvm/handle_exit.c   |  5 +++++
> >  3 files changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> > index 82cf1f879c61..0d7e86a95d62 100644
> > --- a/arch/arm64/include/asm/traps.h
> > +++ b/arch/arm64/include/asm/traps.h
> > @@ -30,6 +30,7 @@ void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *
> >  void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
> >  
> >  int early_brk64(unsigned long addr, unsigned long esr, struct pt_regs *regs);
> > +void dump_instr(unsigned long addr);
> >  
> >  /*
> >   * Move regs->pc to next instruction and do necessary setup before it
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 9bfa5c944379..d692c05e3686 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -149,15 +149,11 @@ pstate_check_t * const aarch32_opcode_cond_checks[16] = {
> >  
> >  int show_unhandled_signals = 0;
> >  
> > -static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
> > +void dump_instr(unsigned long addr)
> >  {
> > -	unsigned long addr = instruction_pointer(regs);
> >  	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
> >  	int i;
> >  
> > -	if (user_mode(regs))
> > -		return;
> > -
> >  	for (i = -4; i < 1; i++) {
> >  		unsigned int val, bad;
> 
> I'm a little worried that this function might be used to try and dump
> instructions from userspace now that it just takes an address.
> 
> Maybe we could:
> 
>   - Keep the name unchanged, e.g. void dump_kernel_instr(unsigned long kaddr)
>   - Inline the user_mode(regs) and instruction_pointer(regs) calls into
>     __die()
>   - Check is_ttbr1_addr(kaddr) in dump_kernel_instr()
> 
> WDYT?

Makes sense, I will do that and respin v2.

Thanks,
Mostafa

> 
> Will

