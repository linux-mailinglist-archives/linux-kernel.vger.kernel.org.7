Return-Path: <linux-kernel+bounces-836372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA98ABA9823
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA7F1887DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BAF3064BB;
	Mon, 29 Sep 2025 14:13:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984363A8F7;
	Mon, 29 Sep 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155208; cv=none; b=Dmqfz6tTPbT6tgvkLoCz61yttcS2oN73tEjzRBGP09IkMnqV1fTYS+vuUPLlNJS41PT8rRlLJgfrD9OUviYB8vICZIEeOeoYbXjAt1ll8VJTZ+O6LXSsADSNkIt47qj5QOr/W2+w0LTjiPnr22UdaAZUDO627Ym5dm0hk4B7gXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155208; c=relaxed/simple;
	bh=6E+0CiG8HpAm1tksikhkvDuPqc/OnV8v777SwtOGFJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYveWkFhGlbcL06U1xfMRRRO+VoKag+oCCUCgEFscD7VB2GrJXaxp8q7x4jnQ/RHWrMgIzgdfvRGhEEow63VV09zDYXYcspNXUtGc4DTrVqJuXCHBF7WyqbvV94pT7Zjq14OIuY5wowaxv4+Au2tVu7GCC7EpsMvf75pLzVYDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8CB150C;
	Mon, 29 Sep 2025 07:13:17 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831EF3F66E;
	Mon, 29 Sep 2025 07:13:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:13:20 +0100
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
Message-ID: <aNqUACFbXHjURWir@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02647276-dea2-47b5-a271-7f02666e0492@intel.com>

Hi there,

On Mon, Sep 29, 2025 at 05:19:32PM +0800, Chen, Yu C wrote:
> On 9/26/2025 6:58 AM, Luck, Tony wrote:

[...]

> > Applying this to Intel upcoming region aware memory bandwidth
> > that supports 255 steps and h/w min/max limits.
> > We would have info files with "min = 1, max = 255" and a schemata
> > file that looks like this to legacy apps:
> > 
> > MB: 0=50;1=75
> > #MB_HW: 0=128;1=191
> > #MB_MIN: 0=128;1=191
> > #MB_MAX: 0=128;1=191
> > 
> > But a newer app that is aware of the extensions can write:
> > 
> > # cat > schemata << 'EOF'
> > MB_HW: 0=10
> > MB_MIN: 0=10
> > MB_MAX: 0=64
> > EOF
> > 
> > which then reads back as:
> > MB: 0=4;1=75
> > #MB_HW: 0=10;1=191
> > #MB_MIN: 0=10;1=191
> > #MB_MAX: 0=64;1=191
> > 
> > with the legacy line updated with the rounded value of the MB_HW
> > supplied by the user. 10/255 = 3.921% ... so call it "4".
> > 
> 
> This seems to be applicable as it introduces the new interface
> while preserving forward compatibility.
> 
> One minor question is that, according to "Figure 6-5. MBA Optimal
> Bandwidth Register" in the latest RDT specification, the maximum
> value ranges from 1 to 511.
> Additionally, this bandwidth field is located at bits 48 to 56 in
> the MBA Optimal Bandwidth Register, and the range for
> this segment could be 1 to 8191. Just wonder if it would be
> possible that the current maximum value of 512 may be extended
> in the future? Perhaps we could explore a method to query the maximum upper
> limit from the ACPI table or register, or use CPUID to distinguish between
> platforms rather than hardcoding it. Reinette also mentioned this in another
> thread.
>
> Thanks,
> Chenyu
> 
> 
> [1] https://www.intel.com/content/www/us/en/content-details/851356/intel-resource-director-technology-intel-rdt-architecture-specification.html

I can't comment on the direction of travel in the RDT architecture.

I guess it would be up to the arch code whether to trust ACPI if it
says that the maximum value of this field is > 511.  (> 65535 would be
impossible though, since the fields would start to overlap each
other...)

Would anything break in the interface proposed here, if the maximum
value is larger than 511?  (I'm hoping not.  For MPAM, the bandwidth
controls can have up to 16 bits and the size can be probed though MMIO
registers.

I don't think we've seen MPAM hardware that comes close to 16 bits for
now, though.

Cheers
---Dave

