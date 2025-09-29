Return-Path: <linux-kernel+bounces-836539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A944BA9F76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF7F7A66CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126C430C0FC;
	Mon, 29 Sep 2025 16:10:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BCD302CC3;
	Mon, 29 Sep 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162250; cv=none; b=gs6X4m/0rhVMp8NueG/vw7vR2ICt/q2beeIIqCEb7unDciaFJh/WMwqPkgG7I8vFOabV1FaIW48fSpnOyhM3kCiUFPMcpk1qLGBitqGTgWAf14cHF8PUPuYqMVT4hJoVo6bOrXcD87PSvQyntLbSg/920LYpn5p6HLDpUdviCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162250; c=relaxed/simple;
	bh=lkWKMGyuWmIS9hRLihsDNiV+gfmfyAAU0gjj2D94/1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeRdiiHOuJ1PJtVa1j0RryMxYqazognD2okwOZfDzf6Ih262nFdpc2DfhLmV+7A75iopXDG+NwBWvpcwglDJ3IcA+cQwI36t+hMtYDnSvyceFBWPIwJy09G9/I1DbO7E/Luc2L3+l49r8rKByYutFgtlnJClpwdliQ3i6SNVai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB29150C;
	Mon, 29 Sep 2025 09:10:39 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E27AF3F66E;
	Mon, 29 Sep 2025 09:10:45 -0700 (PDT)
Date: Mon, 29 Sep 2025 17:10:43 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNqvg984pmj+otfF@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
 <aNU5nCklRhuc4u3X@e133380.arm.com>
 <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
 <aNp+7yjrs36/hSPS@e133380.arm.com>
 <c91846ab-e08e-48e9-83bb-357eab4b9d87@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91846ab-e08e-48e9-83bb-357eab4b9d87@intel.com>

Hi Reinette,

On Mon, Sep 29, 2025 at 08:38:13AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 9/29/25 5:43 AM, Dave Martin wrote:

[...]

> > Generally, I agree, although I'm not sure whether that acronym belongs
> > in the MPAM-specific code.
> > 
> > For this patch, though, that's irrelevant.  I've changed it to "MBA"
> > as requested.
> > 
> 
> Thank you.

[...]

> >> I find "worst-case precision" a bit confusing, consider for example, what
> >> would "best-case precision" be? What do you think of "info/MB/bandwidth_gran gives
> >> the upper limit of these interval steps"? I believe this matches what you
> >> mentioned a couple of messages ago: "The available steps are no larger than this
> >> value."
> > 
> > Yes, that works.  "Worst case" implies a value judgement that smaller
> > steps are "better" then large steps, since the goal is control.
> > 
> > But your wording, to the effect that this is the largest (apparent)
> > step size, conveys all the needed information.
> 
> Thank you for considering it. My preference is for stating things succinctly
> and not leave too much for interpretation.

I find that it's not always easy to work out what information is
essential without the discussion... so I hope that didn't feel like a
waste of time!

> >> (and "per cent" -> "percent")
> > 
> > ( Note: https://en.wiktionary.org/wiki/per_cent )
> 
> Yes, in particular I note the "chiefly Commonwealth". I respect the differences
> in the English language and was easily convinced in earlier MPAM work to
> accept different spelling. I now regret doing so because after merge we now have a
> supposedly coherent resctrl codebase with inconsistent spelling that is unpleasant
> to encounter when reading the code and also complicates new work.
> 
> > (Though either is acceptable, the fused word has a more informal feel
> > to it for me.  Happy to change it -- though your rewording below gets
> > rid of it anyway.  (This word doesn't appear in resctrl.rst --
> > evertying is "percentage" etc.)

Sure, it's best not to have mixed-up conventions in the same document.

(With this one, I wasn't aware that there were regional differences at
all, so that was news to me...)

[...]

> >> I think putting together a couple of your proposals and statements while making the
> >> text more accurate may work:
> >>
> >> 	 "bandwidth_gran":
> >> 		The approximate granularity in which the memory bandwidth
> >>  		percentage is allocated. The allocated bandwidth percentage
> >> 		is rounded up to the next control step available on the
> >> 		hardware. The available hardware steps are no larger than
> >> 		this value.
> > 
> > That's better, thanks.  I'm happy to pick this up and reword the text
> > in both places along these lines.
> 
> Thank you very much. Please do feel free to rework.
> 
> > 
> >> I assume "available" is needed because, even though the steps are not larger
> >> than "bandwidth_gran", the steps may not be consistent across the "min_bandwidth"
> >> to 100% range?
> > 
> > Yes -- or, rather, the steps _look_ inconsistent because they are
> > rounded to exact percentages by the interface.
> > 
> > I don't think we expect the actual steps in the hardware to be
> > irregular.
> > 
> Thank you for clarifying.
> 
> Reinette

OK.

I'll tidy up the loose ends and repost once I've have a chance to re-
test.

Thanks for the review.

Cheers
---Dave

