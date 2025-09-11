Return-Path: <linux-kernel+bounces-811407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405BDB528AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73AC37A596E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8633258ED8;
	Thu, 11 Sep 2025 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+Bb9zpG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01716257453
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571897; cv=none; b=SPM1LqPytQtSFHEIgjCdpF5XLn+I7W4F6u4yVUQcUphFPqCb1EQQkClWKrnpTvjUtPrLw54OdeEbL5cWk7AcfxbuUWYFjKN8C08WWIsMMW4imlxH8WzeH8yhKeyxBwX6POd4Kkw6ml0bw2HdCydt/L82/5zxAdq5ol8kTWjAd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571897; c=relaxed/simple;
	bh=LWISxWpZIWpayb7lXXH/jdmlK51vVZcbwDDS5/tVFd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvJI7bhjpWmnSet52Uc/eUACkRB0wvGi0tdyuV+3kXLd1VzEobOOm3c00QrvAA5vcc34AkBWgfZZGOp3M4TIENfDGyfMIlfnZ9VkZdoudkqPtEOdlv28BwmBoaBdp4Ve5Zxc2vwPc2ZjycXMwmCuArZxBFuoGHmCFQMH5c5ATnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+Bb9zpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C145FC4CEF1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757571896;
	bh=LWISxWpZIWpayb7lXXH/jdmlK51vVZcbwDDS5/tVFd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r+Bb9zpG0WNuifHbdn917sxYe4G7Q6CVr3RZuYgsWQxd6sQTnI+jiRMtCiMpzgz+l
	 Evi5xB/R44jOGxR+16dMvn0DjwdeRzppiLH9jRD7MTQZF8eTczmOv1pcJIRqMNdQa8
	 0NS8f6sKONLkfy6YRhziFLpjrqW42VXcFNeI6e9ILuy1ruX+z5rgxKGY8qE+OTrreT
	 UMyxKyWpub8WmQKplsRcxk8hLIqcwTQTy4K0DmmfeeVg1YWPtJgtnqh+h1TfXnamAZ
	 yMU5rCZvjI5dPnCiQsDZQlMGogGCZPKqkXK50XVhJcMnr3oEh0lZ8uZRV9+0qpKA0O
	 MUEIN2gYhnCpg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so319464e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:24:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrnvCRo3xECfO07vax5H9OL9Y9e2gZvHzqdOkYlLoGqEK/5f5er2Cm1MW2lEcqTmyN4WX802V9s/1jLh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Kes+9J61fPtPU9HyQRDRbhekvDKHjM1hSSHXY5uw7SujjnCS
	pmBORHhTHmxpr/ppydD2zvhNIx3CXdV++W2OQGX+UjL+wIwqEp3fAGOHmYxQaqhGypGR9AO7aPY
	R+0v6Vhhz0p1ZXQ8km5eRWUvflwYrMzk=
X-Google-Smtp-Source: AGHT+IG29ahrAP8GFbMhC5SlNYOdpYF2cGBGuOOogKOlf0rutSht7MwWOV0kTpYrOZDoYWwhMGpLaYSS4D9ns3F7NW8=
X-Received: by 2002:a2e:b8c1:0:b0:337:f217:a785 with SMTP id
 38308e7fff4ca-33b5cbcec6amr58212641fa.23.1757571895136; Wed, 10 Sep 2025
 23:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910104454.317067-1-kevin.brodsky@arm.com>
 <41f3227e-b945-4303-90b7-732affb0a101@arm.com> <CAMj1kXEmfCHpssFjn_+4ZjKCUaWPeiVwznCpGumTfz33k-rfkg@mail.gmail.com>
 <f8c268ce-798a-4d3a-bab2-16eea633f9db@arm.com>
In-Reply-To: <f8c268ce-798a-4d3a-bab2-16eea633f9db@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 08:24:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHDKGsaOn96zecba=-6Bib0SVYs=voMr5DLjWOn_qAqAQ@mail.gmail.com>
X-Gm-Features: Ac12FXzciR3IyG7PAaM9LIGz6dBGdo1fkr-R21kJeV_W4pyF-M5kwwVrYSYE318
Message-ID: <CAMj1kXHDKGsaOn96zecba=-6Bib0SVYs=voMr5DLjWOn_qAqAQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Move KPTI helpers to mmu.c
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 08:18, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/09/25 11:38 AM, Ard Biesheuvel wrote:
> > On Thu, 11 Sept 2025 at 07:13, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >>
> >> On 10/09/25 4:14 PM, Kevin Brodsky wrote:
> >>> create_kpti_ng_temp_pgd() is currently defined (as an alias) in
> >>> mmu.c without matching declaration in a header; instead cpufeature.c
> >>> makes its own declaration. This is clearly not pretty, and as commit
> >>> ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
> >>> function signature") showed, it also makes it very easy for the
> >>> prototypes to go out of sync.
> >>>
> >>> All this would be much simpler if kpti_install_ng_mappings() and
> >>> associated functions lived in mmu.c, where they logically belong.
> >>> This is what this patch does:
> >>> - Move kpti_install_ng_mappings() and associated functions from
> >>>   cpufeature.c to mmu.c, add a declaration to <asm/mmu.h>
> >>> - Make create_kpti_ng_temp_pgd() a static function that simply calls
> >>>   __create_pgd_mapping_locked() instead of aliasing it
> >>> - Mark all these functions __init
> >>> - Move __initdata after kpti_ng_temp_alloc (as suggested by
> >>>   checkpatch)
> >>>
> >>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> >>> ---
> >>> Note: as things stand, create_kpti_ng_temp_pgd() could be removed,
> >>> but a separate patch [1] will make use of it to add an
> >>> assertion.
> >>>
> >>> [1] https://lore.kernel.org/all/20250813145607.1612234-3-chaitanyas.prakash@arm.com/
> >>> ---
> >>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> >>> Cc: Ard Biesheuvel <ardb@kernel.org>
> >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>> Cc: Kees Cook <kees@kernel.org>,
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> >>> ---
> >>>  arch/arm64/include/asm/mmu.h   |   6 ++
> >>>  arch/arm64/kernel/cpufeature.c |  97 ------------------------------
> >>>  arch/arm64/mm/mmu.c            | 106 ++++++++++++++++++++++++++++++---
> >>>  3 files changed, 103 insertions(+), 106 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> >>> index 49f1a810df16..624edd6c4964 100644
> >>> --- a/arch/arm64/include/asm/mmu.h
> >>> +++ b/arch/arm64/include/asm/mmu.h
> >>> @@ -104,5 +104,11 @@ static inline bool kaslr_requires_kpti(void)
> >>>       return true;
> >>>  }
> >>>
> >>> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> >>> +void kpti_install_ng_mappings(void);
> >>
> >> Could the declarations be moved here instead ?
> >
> > Why?
>
> To avoid both typedef and external instance declaration in the C
> code even though there is just a single call site in there.

But why would we want to avoid those in the first place?

Moving these into mmu.h pollutes the global namespace with
declarations that must never be used outside of
__kpti_install_ng_mappings() to begin with.

> Also
> is not bit cleaner as well ?

That is highly subjective, but personally, I think it only adds confusion.

