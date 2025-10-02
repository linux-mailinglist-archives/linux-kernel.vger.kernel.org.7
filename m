Return-Path: <linux-kernel+bounces-840421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325FBB4615
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16543BCA97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1EC223336;
	Thu,  2 Oct 2025 15:40:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350D1F4262;
	Thu,  2 Oct 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419643; cv=none; b=HVj0AF0a2i/N4yc5v3Jg484W5HuuG957j4LoayW08hMdQTa5OuEg5l0ly83uA+xgkz9Fdksej3LhyiojH6L3J0y9bL4yNwTv/swwPgemhsCvjWN3v1Rjr5fpgfWkm1NC3v5Tw6OE8EDYESthYB//IYsujtoV9cIc2xZd0sA5V2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419643; c=relaxed/simple;
	bh=Ubfz8YVPKpuh7pZs3gkbSV2BTWnrx0Dn7K5DF62Ocmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZGNFh5mKvPXRfpOU0qNLRNUxV69ibcH/H78DwrelUO6PR48MEF6DjXwr08r5OeS/rM2+k9jZYYUg8LKdCN8GBuCio2OuMcGY95VYz24idZCximA+qUISL1pqlm2BZei8Y35L7R0J5IUvJWpifSa0vPnpVS+wmHnuIUYA+7NmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 482941FCD;
	Thu,  2 Oct 2025 08:40:26 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 241AD3F59E;
	Thu,  2 Oct 2025 08:40:32 -0700 (PDT)
Date: Thu, 2 Oct 2025 16:40:13 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aN6c3U8te/MK/WlW@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
 <541fb538-0c22-4ad2-9c6e-83ada7f2240b@intel.com>
 <aNv9cA7W+NNZuDSc@e133380.arm.com>
 <38569247-431c-4b0c-af0f-aadd6fb26849@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38569247-431c-4b0c-af0f-aadd6fb26849@intel.com>

Hi there,

On Wed, Oct 01, 2025 at 08:13:45PM +0800, Chen, Yu C wrote:
> On 9/30/2025 11:55 PM, Dave Martin wrote:
> > Hi,
> > 
> > On Tue, Sep 30, 2025 at 12:43:36PM +0800, Chen, Yu C wrote:

[...]

> > > I overlooked this bit width. It should not exceed 511 according to the
> > > RDT spec. Previously, I was just wondering how to calculate the legacy
> > > MB percentage in Tony's example. If we want to keep consistency - if
> > > the user provides a value of 10, what is the denominator: Is it 255,
> > > 511, or something queried from ACPI.
> > > 
> > > MB: 0=4;1=75           <--- 10/255
> > > #MB_HW: 0=10;1=191
> > > #MB_MIN: 0=10;1=191
> > > #MB_MAX: 0=64;1=191
> > > 
> > > or
> > > 
> > > MB: 0=1;1=75          <--- 10/511
> > > #MB_HW: 0=10;1=191
> > > #MB_MIN: 0=10;1=191
> > > #MB_MAX: 0=64;1=191
> > > 
> > > thanks,
> > > Chenyu
> > 
> > The denomiator (the "scale" parameter in my model, though the name is
> > unimportant) should be whatever quantity of resource is specified in
> > the "unit" parameter.
> > 
> > For "percentage" type controls, I'd expect the unit to be 100% ("100pc"
> > in my syntax).
> > 
> > So, Tony suggestion looks plausible to me [1] :
> > 
> >   | Yes. 255 (or whatever "Q" value is provided in the ACPI table)
> >   | corresponds to no throttling, so 100% bandwidth.
> > 
> > So, if ACPI says Q=387, that's the denominator we advertise.
> > 
> > Does that sound right?
> > 
> 
> Yes, it makes sense, the denominator is the "scale" in your example.

Thanks for confirming that.

> > Question: is this a global parameter, or per-CPU?
> > 
> 
> It should be a global setting for all the MBA Register Blocks.

That's good -- since resctrl resource controls are not per-CPU,
exposing the exact hardware resolution won't work unless the value
is scaled identically for all CPUs.

Cheers
---Dave

