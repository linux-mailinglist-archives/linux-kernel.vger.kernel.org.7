Return-Path: <linux-kernel+bounces-811880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB7AB52F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C071897004
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4226E704;
	Thu, 11 Sep 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2gaCq/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B68F7D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588489; cv=none; b=Qu9kNqmkwSaW/yuwHiP+5H4P+CpKdIdWmVEPX6tHcJAwm7AOvB6zG4p5nMGp1a7bmrIPl8J+eEI8noXS/zakjsEHIhF/VoqnOsrTh6a+Btnjm8bY++Aq0b/Mqv7EZ0Xn3h3GpoGEg85tl+8J05GFJX9t5Vt8TKezGsk4+VykPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588489; c=relaxed/simple;
	bh=qcwkKCiYu69+MlAmuClu7yal5bt9UA5Xzjd+iYOanOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kbdy37VpTxQNvAoIGGDqGb7WEh3ZOEvMXdEvRAVoM8cFbo0pJUNFvv0SKTuVeQEVBBO/tCR/U8kJT0nZ+fRhVm3RkkzM4Eczji4jQ1FMNqxE2Atov4Yd1e1zwhlnfUHv372OaZDMEjbTTSzwf2o3ECxjTY4qJMT15mjZ7ZZsEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2gaCq/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A44C4AF0C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757588488;
	bh=qcwkKCiYu69+MlAmuClu7yal5bt9UA5Xzjd+iYOanOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G2gaCq/HPJpvimU0nAjGHqGGFrOWvEpjthSOPI8V7JQxB2xw/jhEtd+BkHFo+0Pj3
	 ZTpt82S/+e2k8p5ngrQ7BjVGsYYNWICjqMdOBBYAjLzxBL3VJUGOc5QY3Ytu5ehgQF
	 dWbv7p+G2Hva6LV23bMvuMDFSM2BcEeL13s9e4gYAKRRWU6bEWe/xDkjlfBoDDfTPo
	 AYLzNVAR/IugHdT8Xzkp9o+NI27Y5nfAEL+v8Oc9K+udOPAluL0PXH1FaID03/RgqW
	 No9/51PXwBIJob6B3OB3vj9MagqTQBjIXdoPcT8xvZaYvwON9QX4nynNguiVOkdEGs
	 yaTXrsTypyrbw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso4878661fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:01:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlN3DHqxAB7WTeGSeEg0S3S8lvzKIQhlsB2p24hISBwy7tGPyFKZgHP2K/cOf8qjR3qQIW3HmRMGLDWFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9ViwcyTlZO015I6yDYZuCNBABKUqP1AZGYqYj+kHVRg0w29u
	OulGkYcbhWTMjuZJiu5/JGosiwz30QZR9jXtg0Ls/oPAYnkrvVnHQqO/iEAQz5K9YY7sKYdhSwA
	Z1MV20ubxRdGi+2PyFerFd5ItB6SMfVQ=
X-Google-Smtp-Source: AGHT+IGcEbBFp/2Fh0XeMpz+5/rU4x28vqOtFqExcdzTuNfvhLVgJUe6AzbpIhsu4BDjrjUhuLaPSCReMoUhxkhgDCk=
X-Received: by 2002:a05:651c:19ab:b0:336:e32f:79ed with SMTP id
 38308e7fff4ca-33b55f3292amr64487191fa.29.1757588487165; Thu, 11 Sep 2025
 04:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910104454.317067-1-kevin.brodsky@arm.com>
 <CAMj1kXHR34kpL1qLgeEgEmRZN1o=umWzjZEzmSV+X2AX-4CvVg@mail.gmail.com> <b0b11c57-e45b-4a53-8dba-93e8ce5800c1@arm.com>
In-Reply-To: <b0b11c57-e45b-4a53-8dba-93e8ce5800c1@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 13:01:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG7bpDSnx8stk4eAYP4C4zgCN4qc+QEFFK2y5=RP4Xitg@mail.gmail.com>
X-Gm-Features: Ac12FXw3MQJ-186gJHsvUQGzb5AY80L338hr6NUNkPCASCKkcMmO8Q6YFPmQtMg
Message-ID: <CAMj1kXG7bpDSnx8stk4eAYP4C4zgCN4qc+QEFFK2y5=RP4Xitg@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Move KPTI helpers to mmu.c
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 12:52, Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
> On 11/09/2025 11:19, Ard Biesheuvel wrote:
> >> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> >> index 49f1a810df16..624edd6c4964 100644
> >> --- a/arch/arm64/include/asm/mmu.h
> >> +++ b/arch/arm64/include/asm/mmu.h
> >> @@ -104,5 +104,11 @@ static inline bool kaslr_requires_kpti(void)
> >>         return true;
> >>  }
> >>
> >> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> >> +void kpti_install_ng_mappings(void);
> >> +#else
> >> +static inline void kpti_install_ng_mappings(void) {}
> >> +#endif
> >> +
> > Nit: you might just keep the former declaration, and check for
> > IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) in the function, rather than
> > propagating this distinction to the header file.
> > But either is fine with me.
>
> That's an option, but that would mean removing the #ifdef around the
> functions defined in mmu.c. They would probably get eliminated by the
> linker if the CONFIG isn't defined, but I'm not so sure about the static
> variable (kpti_ng_temp_alloc). Probably not a big deal but I feel
> keeping the #ifdef is more self-documenting as well.
>

Fair enough.

