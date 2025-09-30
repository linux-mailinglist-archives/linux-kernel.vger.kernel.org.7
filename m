Return-Path: <linux-kernel+bounces-837888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EDBADFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917D5194081E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8C308F39;
	Tue, 30 Sep 2025 15:55:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AE25D53C;
	Tue, 30 Sep 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247736; cv=none; b=Y4U+bdDXubahhwpPfn9fXAWdygmYQO1ag1A2mMxbOYVAmrIsJrG7C9y0nyeg9+0y/A+fX3k9QLhaWYDXcGZQaMwf1Yk+DUXaaitIcUkGxAlzT9GuNUNDVpQFNrgVtfb20xbK99ac20DellBUxpExwRBREQprT/giks/qMmDEkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247736; c=relaxed/simple;
	bh=A9RtkQhqFR63w+amJSn8vAWfbt8JhFeZACTSd4Gysb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUs85ROYK1uZWsbEOlUSs7sKTNh/oEvlkq0BbTpWpVcK865joqR9lQWLN4kz+UIvtXtc2fncYELCx91RmpCgumzuDAPYAE4Lq3IhLSWV+ivTE1PEsQUXeUa9NI+Rtb3ZP/q8mvUb8ZSVWe5714hdYzndTWaZs5Sk1GyeUAXBed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28AA51424;
	Tue, 30 Sep 2025 08:55:25 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B26F3F66E;
	Tue, 30 Sep 2025 08:55:30 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:55:28 +0100
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
Message-ID: <aNv9cA7W+NNZuDSc@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
 <541fb538-0c22-4ad2-9c6e-83ada7f2240b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <541fb538-0c22-4ad2-9c6e-83ada7f2240b@intel.com>

Hi,

On Tue, Sep 30, 2025 at 12:43:36PM +0800, Chen, Yu C wrote:
> On 9/29/2025 10:13 PM, Dave Martin wrote:

[...]

> > I guess it would be up to the arch code whether to trust ACPI if it
> > says that the maximum value of this field is > 511.  (> 65535 would be
> > impossible though, since the fields would start to overlap each
> > other...)
> > 
> > Would anything break in the interface proposed here, if the maximum
> > value is larger than 511?  (I'm hoping not.  For MPAM, the bandwidth
> > controls can have up to 16 bits and the size can be probed though MMIO
> > registers.
> > 
> 
> I overlooked this bit width. It should not exceed 511 according to the
> RDT spec. Previously, I was just wondering how to calculate the legacy
> MB percentage in Tony's example. If we want to keep consistency - if
> the user provides a value of 10, what is the denominator: Is it 255,
> 511, or something queried from ACPI.
> 
> MB: 0=4;1=75           <--- 10/255
> #MB_HW: 0=10;1=191
> #MB_MIN: 0=10;1=191
> #MB_MAX: 0=64;1=191
> 
> or
> 
> MB: 0=1;1=75          <--- 10/511
> #MB_HW: 0=10;1=191
> #MB_MIN: 0=10;1=191
> #MB_MAX: 0=64;1=191
> 
> thanks,
> Chenyu

The denomiator (the "scale" parameter in my model, though the name is
unimportant) should be whatever quantity of resource is specified in
the "unit" parameter.

For "percentage" type controls, I'd expect the unit to be 100% ("100pc"
in my syntax).

So, Tony suggestion looks plausible to me [1] :

 | Yes. 255 (or whatever "Q" value is provided in the ACPI table)
 | corresponds to no throttling, so 100% bandwidth.

So, if ACPI says Q=387, that's the denominator we advertise.

Does that sound right?

Question: is this a global parameter, or per-CPU?

From the v1.2 RDT spec, it looks like it is a single, global parameter.
I hope this is true (!)  But I'm not too familiar with these specs...

Cheers
---Dave


[1] https://lore.kernel.org/lkml/aNq11fmlac6dH4pH@agluck-desk3/
> 

