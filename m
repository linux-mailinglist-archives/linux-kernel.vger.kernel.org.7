Return-Path: <linux-kernel+bounces-886998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E8C36FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF4F1A40AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23413321DA;
	Wed,  5 Nov 2025 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqdTQMEp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBEB339701
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362233; cv=none; b=nQRnFmm8PD59XXtU3L4Jq3DuSArKNsCWAM5jrI1Nxmyh3egHEi/VuUr2gc2InVZ04tD+OK5USZnEp6W4Og6BSVPhuNICYghQPrdPee1E5PqKMVnSSH7OQTSpbR3YN2V0HUDsB3FJw1cnUIQUxtm1KeGDuL0SKzs7TA6NiqPLl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362233; c=relaxed/simple;
	bh=fg8T6HLm59/38dJ+JLRKlWSwFCUyza7TxNKcYtn9qTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiYO7+IrnBaVTAk7QJhwV7sPrHufEVBcWlZ6FcMeRxXF6yes2un6zLMxq9BGSaGkHG+VNew3JhvCNfWnS0g0FH3jIC/v8Y0P69Bw5H/VWJlWelryUnAEA6NCvq0ccypvDH2fcnlKGrJWCIJ9njsljP+d6xTU3tc4PCl6GfnuGNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqdTQMEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475AC4CEF5;
	Wed,  5 Nov 2025 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762362232;
	bh=fg8T6HLm59/38dJ+JLRKlWSwFCUyza7TxNKcYtn9qTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqdTQMEpi2Ckqu0wfUfjkgZ2N/CsHg3nchqrCOWiqlI5Lm+SoWMDuo1Qvs7w2GYda
	 wo6oU2hbtYFYsvlS1VYTAJ0tdkxXsyOsK5RvOYEIUlVkvwtAqAdHUqZ5IqkoihrMc3
	 m6iFlsk6vbN/fkpS0UH839f2gSKLGzT9qO+Fj6Zv9xaZSK/s29nByz9Y42RTIYR7Bo
	 okwduZ3FHNzw8oaqW8wOdLx72JNesjcaLIDWuupT9/AUM2ZKczMAgOLmZNZ0zMvW3n
	 FCq8vnik0cRJUMgP/JBaiL2NpSXKlq5FNN2UgMjNQa1phl6zF+2do2Jk0CE8IooHhV
	 g+wXBR0QEOawQ==
Date: Wed, 5 Nov 2025 17:03:48 +0000
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Add a fallback stub for pgd_page_paddr()
Message-ID: <aQuDdE_Tj3di7q3P@willie-the-truck>
References: <20251014110633.304961-1-anshuman.khandual@arm.com>
 <aQoORmgliayA0s_a@willie-the-truck>
 <e660e033-6300-4deb-b034-4d26746d8d01@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e660e033-6300-4deb-b034-4d26746d8d01@arm.com>

On Wed, Nov 05, 2025 at 08:24:40AM +0530, Anshuman Khandual wrote:
> On 04/11/25 8:01 PM, Will Deacon wrote:
> > On Tue, Oct 14, 2025 at 12:06:33PM +0100, Anshuman Khandual wrote:
> >> Add a fallback stub for pgd_page_paddr() when (PGTBALE_LEVELS <= 4) which
> > 
> > typo
> 
> Sure will change - s/Add/Adds
> > 
> >> helps in intercepting any unintended usage and which is also in line with
> >> existing stubs for similar [pud|p4d]_page_paddr() helpers.
> > 
> > Are you saying the kernel compiles in this case without your patch? Which
> > definition of pgd_page_paddr() does it end up using?
> 
> Kernel compiles for PGTBALE_LEVELS <= 4 just fine without this patch as both
> its current users p4d_offset_phys() and p4d_offset_lockless() are wrapped in
> with PGTBALE_LEVELS > 4.

Ok, but your patch is trying to catch broken users of the macro, right?
So my question is, would such a user compile today? If not, then your
patch is pointless.

Will

