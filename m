Return-Path: <linux-kernel+bounces-836292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F430BA9391
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B9161F43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120030595C;
	Mon, 29 Sep 2025 12:43:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFC22522B6;
	Mon, 29 Sep 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149825; cv=none; b=ppVbmwmM+qs3LdWG9UTL+f3zXKjM4jhxcywC6KmjoaTkEpVmkRAh0KHbKVh9t0GwwGWlUI6WNgYfPqAsHwaHhbFbERwb7aKSovZzzBB9azO8K3dXVCLvudOR3S7N3xza2jA3PsPJEaJnPQ3rudnJK+8cHXM1mU11VuuDu3MUKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149825; c=relaxed/simple;
	bh=Q50WlyXFFt5SsVN9OWSYPYfe/beepPI4zCRku06v8QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGOsStoqZONs4faZIApUfc54vn0OKQMO2qmqSL7EgEPCzCIT7Uu1G4hgR9Hn1X29i9QO9Y6UCpMiyvb37FfFamKKuOfiBc7a29XIeZryw6Ph80xR8zUaW8xVELksB/FURL7hEI/L8yuCi6iZNrD3RCwDElCUH7Jutrwbp1RuiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DE11150C;
	Mon, 29 Sep 2025 05:43:34 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42CDC3F66E;
	Mon, 29 Sep 2025 05:43:40 -0700 (PDT)
Date: Mon, 29 Sep 2025 13:43:27 +0100
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
Message-ID: <aNp+7yjrs36/hSPS@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
 <aNU5nCklRhuc4u3X@e133380.arm.com>
 <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>

Hi Reinette,

On Thu, Sep 25, 2025 at 09:53:37PM +0100, Reinette Chatre wrote:
> Hi Dave,
> 
> On 9/25/25 5:46 AM, Dave Martin wrote:
> > On Tue, Sep 23, 2025 at 10:27:40AM -0700, Reinette Chatre wrote:
> >> On 9/22/25 7:39 AM, Dave Martin wrote:
> >>> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
> >>>> Hi Dave,

[...]

> >>>> Also please use upper case for acronym mba->MBA.
> >>>
> >>> Ack (the local custom in the MPAM code is to use "mba", but arguably,
> >>> the meaning is not quite the same -- I'll change it.)
> >>
> >> I am curious what the motivation is for the custom? Knowing this will help
> >> me to keep things consistent when the two worlds meet.
> > 
> > I think this has just evolved over time.  On the x86 side, MBA is a
> > specific architectural feature, but on the MPAM side the architecture
> > doesn't really have a name for the same thing.  Memory bandwidth is a
> > concept, but a few different types of control are defined for it, with
> > different names.
> > 
> > So, for the MPAM driver "mba" is more of a software concept than
> > something in a published spec: it's the glue that attaches to "MB"
> > resource as seen through resctrl.
> > 
> > (This isn't official though; it's just the mental model that I have
> > formed.)
> 
> I see. Thank you for the details. My mental model is simpler: write acronyms
> in upper case.

Generally, I agree, although I'm not sure whether that acronym belongs
in the MPAM-specific code.

For this patch, though, that's irrelevant.  I've changed it to "MBA"
as requested.

[...]

> >> really sound as though the current interface works that great for MPAM. If I
> >> understand correctly this patch enables MPAM to use existing interface for
> >> its memory bandwidth allocations but doing so does not enable users to 
> >> obtain benefit of hardware capabilities. For that users would want to use
> >> the new interface?
> > 
> > In ideal world, probably, yes.
> > 
> > Since not all use cases will care about full precision, the MB resource
> > (approximated for MPAM) should be fine for a lot of people, but I
> > expect that sooner or later somebody will want more exact control.
> 
> ack.

OK.

[,,,]

> >> Considering the two statements:
> >> - "The available steps are no larger than this value."
> >> - "this value ... is not smaller than the apparent size of any individual rounding step"
> >>
> >> The "not larger" and "not smaller" sounds like all these words just end up saying that
> >> this is the step size?
> > 
> > They are intended to be the same statement: A <= B versus
> > B >= A respectively.
> 
> This is what I understood from the words ... and that made me think that it
> can be simplified to A = B ... but no need to digress ... onto the alternatives below ...

Right...

[...]

> > Instead, maybe we can just say something like:
> > 
> >  | The available steps are spaced at roughly equal intervals between the
> >  | value reported by info/MB/min_bandwidth and 100%, inclusive.  Reading
> >  | info/MB/bandwidth_gran gives the worst-case precision of these
> >  | interval steps, in per cent.
> > 
> > What do you think?
> 
> I find "worst-case precision" a bit confusing, consider for example, what
> would "best-case precision" be? What do you think of "info/MB/bandwidth_gran gives
> the upper limit of these interval steps"? I believe this matches what you
> mentioned a couple of messages ago: "The available steps are no larger than this
> value."

Yes, that works.  "Worst case" implies a value judgement that smaller
steps are "better" then large steps, since the goal is control.

But your wording, to the effect that this is the largest (apparent)
step size, conveys all the needed information.

> (and "per cent" -> "percent")

( Note: https://en.wiktionary.org/wiki/per_cent )

(Though either is acceptable, the fused word has a more informal feel
to it for me.  Happy to change it -- though your rewording below gets
rid of it anyway.  (This word doesn't appear in resctrl.rst --
evertying is "percentage" etc.)

> 
> > If that's adequate, then the wording under the definition of
> > "bandwidth_gran" could be aligned with this.
> 
> I think putting together a couple of your proposals and statements while making the
> text more accurate may work:
> 
> 	 "bandwidth_gran":
> 		The approximate granularity in which the memory bandwidth
>  		percentage is allocated. The allocated bandwidth percentage
> 		is rounded up to the next control step available on the
> 		hardware. The available hardware steps are no larger than
> 		this value.

That's better, thanks.  I'm happy to pick this up and reword the text
in both places along these lines.

> I assume "available" is needed because, even though the steps are not larger
> than "bandwidth_gran", the steps may not be consistent across the "min_bandwidth"
> to 100% range?

Yes -- or, rather, the steps _look_ inconsistent because they are
rounded to exact percentages by the interface.

I don't think we expect the actual steps in the hardware to be
irregular.

[...]

> Reinette

Cheers
---Dave

