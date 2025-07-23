Return-Path: <linux-kernel+bounces-742127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A3B0ED9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6C116AFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C527FB1F;
	Wed, 23 Jul 2025 08:49:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC027A92B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260552; cv=none; b=XGBav0q30CNsuPOtvLPmLjcGVumM3l2wVP/JJ2bnSOvn23qEw98bi9ulm5ZhUJATIzm7p3q8gohiYu2dqa7uh5FizMhLxDih9SPbZdQZu355wuZmVdyYvKbTsIaUiS0QCOJceIAttv/MnhG24xx5aeFNg5A7xTkjbxNZy0W0Mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260552; c=relaxed/simple;
	bh=UIxA8PfIxTr9Yc1OXWjAvTUdgAeQw+cvzk9x7t5Xucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7ClyPA1SIsQiKvIX8oFz74LdGsuem2eaRrGXvGWwRyu6I2wqzOrZHchf1PmDOVDal7VU4apjxeihWP0eW8XxROmQiPKj/W5KWlQICIT8Sl6C/jkR5dh7Z6dGTK+idnLQ+vTkao3taYBTmEwYdsTolCkI/JR3di1k2fw5lEwXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55BED1BCA;
	Wed, 23 Jul 2025 01:48:57 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA52E3F5A1;
	Wed, 23 Jul 2025 01:49:01 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:48:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Weikang Guo <guoweikang.kernel@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Ensure phys_to_ttbr on pgdir for
 idmap_cpu_replace_ttbr1
Message-ID: <aICh9Z3dsEQj_79y@J2N7QTR9R3>
References: <20250722082117.1777570-1-guoweikang.kernel@gmail.com>
 <aH-mlN88NrTzahfM@J2N7QTR9R3>
 <20250723024923.GA1884099@ubuntu-virtual-machine>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723024923.GA1884099@ubuntu-virtual-machine>

On Wed, Jul 23, 2025 at 10:50:55AM +0800, Weikang Guo wrote:
> On Tue, Jul 22, 2025 at 03:56:20PM +0100, Mark Rutland wrote:
> > On Tue, Jul 22, 2025 at 04:21:13PM +0800, Weikang Guo wrote:
> > > Commit 5ffdfaedfa0a ("arm64: mm: Support Common Not Private translations")
> > > changed the contract of idmap_cpu_replace_ttbr1, requiring that the TTBR
> > > argument passed in should already be processed by phys_to_ttbr (i.e., in
> > > TTBR format, not just a raw physical address).
> > > 
> > > However, the current map_kernel implementation does not always convert the
> > > pgdir/ttbr argument via phys_to_ttbr before calling
> > > idmap_cpu_replace_ttbr1. This can lead to issues on systems with
> > > CONFIG_ARM64_PA_BITS_52 enabled, as the TTBR would not be properly folded
> > > per the ARMv8.2+ requirements.
> > 
> > For the cases below I don't believe that this is actually a problem.
> > Since commit:
> > 
> >   453dfcee70c5c344 ("arm64: booting: Require placement within 48-bit addressable memory")
> > 
> > ... we require that the kernel Image (including any trailing unallocated
> > bytes accounted for in image_size) are below the 48-bit address limit,
> > and so there should be no difference between the PA and TTBR format.
> > 
> > We could probably test and enforce that in the early boot code somehow,
> > if we're not doing that already.
> > 
> > If we were going to change things to avoid accidents in future, I think
> > it would be better to enforce this with the type system. e.g. we could
> > have a ttbr_val type that's distinct from phys_addr_t. Even then, for
> > the idmap code I think it's better to avoid the phys_to_ttbr() dance,
> > since that has runtime patching.
> > 
> > Mark.
> >
> 
> Thank you for your detailed explanation.
> 
> As you mentioned, if we can guarantee that the kernel image is always within
> the 48-bit PA range,then there is indeed no real difference between the PA
> and TTBR formats in this context.

Yep.

To be clear, I'm saying that there's no functional problem in practice,
and hence the description in the commit message is more alarming than
necessary.

Since the conversion is trivial I'm not against applying the conversion
consistently, but if we do that I think we should enforce that through
the type system so that missing conversions will be identified by the
compiler.

> In that case, does it mean that the conversion of `reserved_pg_dir`here is
> also redundant? (There may be other similar cases.)

Yes, 'reserved_pg_dir' should be part of the kernel Image and hence
below the 48-bit limit.

> If we already ensure the kernel is always mapped below 48 bits, it does
> seem safe to remove `phys_to_ttbr`here as well.

I assume for both instances of 'here' above you're referring to the
macro below.

> .macro  __idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
>     adrp    \tmp1, reserved_pg_dir
>     phys_to_ttbr \tmp2, \tmp1    // This might not be needed either?
>     offset_ttbr1 \tmp2, \tmp1
>     msr ttbr1_el1, \tmp2
>     isb
>     tlbi    vmalle1
>     dsb nsh
>     isb
> .endm

Yes, the phys_to_ttbr conversion above isn't strictly necessary today.

Mark.

