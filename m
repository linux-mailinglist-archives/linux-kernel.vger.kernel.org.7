Return-Path: <linux-kernel+bounces-762569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B3B20888
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC6F4262EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0E2D3A83;
	Mon, 11 Aug 2025 12:14:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42EF2D29D1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914445; cv=none; b=bCqJq5sy3nHKVrfhsLkCKR1dtaeSUtrjhxp98bAEA3sGIIvw0soVdrOImipHAgDwA3w0+sXI3W/zDzVYHxHSLhVdI0ul+jYLnDwnjmbqCIz6aMFT3aJhE8IfEg6Dt1o1KlPviknCaODuWCCi6EEv1Iw/RdmvytoEgr62R5a7tHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914445; c=relaxed/simple;
	bh=PfIE5l+N1d6LX3aDn2RThHG42Kxl7lFpoohSZ/I07Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrw9y+FaijFmJcCDCTGEXUpMqm2i1dLP8Mmh2Hw36c2pYMVnZWWTDCQZzsaZcUnv2hZw6iQbcCEWcaxRbHGC768MyOsgnJhRclIiw3ehQYGDte5pi1QspQGjmpPxzNkeF7OCThQZarqNwkmXs2l//RaKLVNAqdc4EPMSWXmxjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD112641;
	Mon, 11 Aug 2025 05:13:54 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 733573F738;
	Mon, 11 Aug 2025 05:14:01 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:13:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, fanqincui <fanqincui@163.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Fanqin Cui <cuifq1@chinatelecom.cn>,
	hanht2@chinatelecom.cn
Subject: Re: [PATCH] arm64/module: Support for patching modules during runtime
Message-ID: <aJnegL4HcT2evOnR@J2N7QTR9R3>
References: <20250807072700.348514-1-fanqincui@163.com>
 <aJXlegQfZTdimS3k@willie-the-truck>
 <3d4011c0.6aaa.198981027d7.Coremail.fanqincui@163.com>
 <86zfc68exk.wl-maz@kernel.org>
 <aJnccgC5E-ui2Oqo@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnccgC5E-ui2Oqo@willie-the-truck>

On Mon, Aug 11, 2025 at 01:05:06PM +0100, Will Deacon wrote:
> On Mon, Aug 11, 2025 at 09:01:43AM +0100, Marc Zyngier wrote:
> > On Mon, 11 Aug 2025 08:37:32 +0100,
> > fanqincui <fanqincui@163.com> wrote:
> > > 
> > > Hi will,
> > > Yes, you are right. The alternative callback function lives inside the module.
> > > This callback function is actually similar to kvm_update_va_mask in KVM;
> > > 
> > > The module's callback function calculates some values based on
> > > the current CPU features and then performs the replacement.
> > > 
> > > The .text.alternative_cb section is actually marked as SHF_EXECINSTR | SHF_ALLOC
> > > during compilation, so intersections() includes this section and sets it as executable later.
> > 
> > I'm worried there is a chicken-and-egg problem here. What if the
> > callback itself requires patching via some other alternative? Is there
> > a guarantee that this always performed in the correct order?
> 
> Maybe we should just reject loading modules that have alternative
> callbacks that don't reside in the kernel text? 

I think that would be sensible. We never *intended* to support arbitrary
callbacks in modules, and if that's something people want, they need to
provide some actual justification.

> I _think_ that should cover all the in-tree users, although I didn't
> get a reply to my question asking which module triggered this bug
> report.

To the best of my knowledge, that covers all in-tree users. From a quick
grep for 'alternative_cb' and 'ALTERNATIVE_CB' in v6.17-rc1, all of the
patching functions are non-modular. AFAICT the only one we export is
alt_cb_patch_nops().

Mark.

