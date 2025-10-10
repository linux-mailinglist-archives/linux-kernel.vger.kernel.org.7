Return-Path: <linux-kernel+bounces-848210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C558FBCCE58
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8230F4E1BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E22882AF;
	Fri, 10 Oct 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M89jGeQ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DC2EDD6D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099378; cv=none; b=ZsFuPwCV5BGJV/1YwvAhK9yon8iNfZMxIMJQBdNrhmcPVYDaafbi4ZXCxNZ/1PjFshrQxm9EjwUuspM75ajymmWaiZlEhNA8LeeqLVXLMMEIDgG6fTNxZy9Q0Ymiu4kJx+CJudxMEYCa5QZfn73GBQJiUe9YcGosk8BTtaf+gLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099378; c=relaxed/simple;
	bh=Jj1hHD26ywHZMQ9GcmV4Z80Kfj4cikffumrIj2vHHVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkncV7qMkr2oyqx8/YoH+G3sju9nexla4gdLXOrZjOnqExOFgOfqg/ltVsZFSAelDo8qB8dNDpsFkaFiBr/y/C1Fun7gsuUS4iFyWcnAzFxPELkS5CXMD+ScMG0SUPEwJrfUadl/eOiK6NdMFLzczna0npnNQ2Og2fASuGX08uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M89jGeQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D7CC4CEF1;
	Fri, 10 Oct 2025 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760099376;
	bh=Jj1hHD26ywHZMQ9GcmV4Z80Kfj4cikffumrIj2vHHVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M89jGeQ+NJe3vL+jI1vMZ43D5BwZBga3DFmtKIQZdEQp/IMbFwdkyba+qYbAas5hU
	 FkZXsMDOBauWrtjWMjOl/BC+UUOQdTqcEEcgrmk+faiu3xmhRnbOY5i06bmCTzGjut
	 jj77AxtZeDrqtl1iJZmH7aDBKphq3NNCamTsyuDTY7RBR/5tfpW/JGj/d/GdzJpEUP
	 MxoYC4312jSflEeoF2r7hpeJwN17vlGswS3NX9abdDWIRsB0zL/S9bOhBQ5batjWNL
	 u/ORdZB9g2BaXzF4/djWqyRP+SSoRdq1ZW2/VJhHdeBgnJIYs07twhUkSPHDSqP11K
	 R0sSrESLuBXHw==
Date: Fri, 10 Oct 2025 13:29:30 +0100
From: Will Deacon <will@kernel.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH] arm64: cpufeature: Don't cpu_enable_mte() when
 KASAN_GENERIC is active
Message-ID: <aOj8KsntbVPRNBKL@willie-the-truck>
References: <20251008210425.125021-3-ysk@kzalloc.com>
 <CA+fCnZcknrhCOskgLLcTn_-o5jSiQsFni7ihMWuc1Qsd-Pu7gg@mail.gmail.com>
 <d0fc7dd9-d921-4d82-9b70-bedca7056961@kzalloc.com>
 <2b8e3ca5-1645-489c-9d7f-dd13e5fc43ed@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b8e3ca5-1645-489c-9d7f-dd13e5fc43ed@kzalloc.com>

On Thu, Oct 09, 2025 at 08:10:53AM +0900, Yunseong Kim wrote:
> To summarize my situation, I thought the boot panic issue might be due
> to incompatibility between MTE and KASAN Generic, so I sent this patch.
> 
> However, it seems that the problem is related to the call path involving
> ZERO page. Also, I am curious how it works correctly in other machine.
> 
> On 10/9/25 7:28 AM, Yunseong Kim wrote:
> > Hi Andrey,
> > 
> > On 10/9/25 6:36 AM, Andrey Konovalov wrote:
> >> On Wed, Oct 8, 2025 at 11:13 PM Yunseong Kim <ysk@kzalloc.com> wrote:
> >>> [...]
> >> I do not understand this. Why is Generic KASAN incompatible with MTE?
> > 
> > My board wouldn't boot on the debian debug kernel, so I enabled
> > earlycon=pl011,0x40d0000 and checked via the UART console.
> > 
> >> Running Generic KASAN in the kernel while having MTE enabled (and e.g.
> >> used in userspace) seems like a valid combination.
> > 
> > Then it must be caused by something else. Thank you for letting me know.
> > 
> > It seems to be occurring in the call path as follows:
> > 
> > cpu_enable_mte()
> >  -> try_page_mte_tagging(ZERO_PAGE(0))
> >    -> VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
> > 
> >  https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/include/asm/mte.h#L83
> 
>  -> page_folio(ZERO_PAGE(0))
>   -> (struct folio *)_compound_head(ZERO_PAGE(0))
> 
>  https://elixir.bootlin.com/linux/v6.17/source/include/linux/page-flags.h#L307

Do you have:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=f620d66af3165838bfa845dcf9f5f9b4089bf508

?

Will

