Return-Path: <linux-kernel+bounces-832443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA040B9F546
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F913847FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6E1DF265;
	Thu, 25 Sep 2025 12:46:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553DE1D5151;
	Thu, 25 Sep 2025 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804405; cv=none; b=H5LzxwmIzBG0I2Y9cJBZE1Zs7kLnQhcNPOuUScIUiq1K0zcCy15JTDapLQtG995yxZJ9tBjrBYdfULEzPudGBgqZssgOq3phhlwPyCjbHs8lKahjvIkVEzbPkAIBaOd/RgMSppZNvzDua8Yz/dhq7OWaQiC/CkQW6aIpL8uWRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804405; c=relaxed/simple;
	bh=oXlMMXrECXHevbgLEjibGUnRCSA77iRKd7qP29W81po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGX/rmYXZ9sSwRk9vMIwsbtk68XcZwNrXSlOkDkkPLIOlr+qW3DuLg5jFg4dfRaWMLknGs51aom8fJSbYl+bI2sbSaQOdrIjBWVP1vDRzJ6ytau83yPmvGuiFnDRIZ8PK1gFI2Y0G/ljNTkCNMq3eqD4Q7ME0FuYir1A9jJkHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FF611692;
	Thu, 25 Sep 2025 05:46:34 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12423F694;
	Thu, 25 Sep 2025 05:46:40 -0700 (PDT)
Date: Thu, 25 Sep 2025 13:46:20 +0100
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
Message-ID: <aNU5nCklRhuc4u3X@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>

Hi Reinette,

On Tue, Sep 23, 2025 at 10:27:40AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 9/22/25 7:39 AM, Dave Martin wrote:
> > Hi Reinette,
> > 
> > Thanks for the review.
> > 
> > On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
> >> Hi Dave,
> >>
> >> nits:
> >> Please use the subject prefix "x86,fs/resctrl" to be consistent with other
> >> resctrl code (and was established by Arm :)).
> >> Also please use upper case for acronym mba->MBA.
> > 
> > Ack (the local custom in the MPAM code is to use "mba", but arguably,
> > the meaning is not quite the same -- I'll change it.)
> 
> I am curious what the motivation is for the custom? Knowing this will help
> me to keep things consistent when the two worlds meet.

I think this has just evolved over time.  On the x86 side, MBA is a
specific architectural feature, but on the MPAM side the architecture
doesn't really have a name for the same thing.  Memory bandwidth is a
concept, but a few different types of control are defined for it, with
different names.

So, for the MPAM driver "mba" is more of a software concept than
something in a published spec: it's the glue that attaches to "MB"
resource as seen through resctrl.

(This isn't official though; it's just the mental model that I have
formed.)

> 
> >>> The control value parser for the MB resource currently coerces the
> >>> memory bandwidth percentage value from userspace to be an exact
> >>> multiple of the bw_gran parameter.
> >>
> >> (to help be specific)
> >> "the bw_gran parameter" -> "rdt_resource::resctrl_membw::bw_gran"?
> > 
> > "bw_gran" was intended as an informal shorthand for the abstract
> > parameter (exposed both in the field you mention and through the
> > bandiwidth_gran file in resctrl).
> 
> I do not see a need for being abstract since the bandwidth_gran file exposes
> the field verbatim.

Sure; that was just my thought process.

> > I can rewrite it as per your suggestion, but this could be read as
> > excluding the bandwidth_gran file.  Would it make sense just to write
> > it out longhand?  For now, I've rewritten it as follows:
> 
> Since the bandwidth_gran file exposes rdt_resource::resctrl_membw::bw_gran
> it is not clear to me how being specific excludes the bandwidth_gran file. 
> 
> > 
> >  | The control value parser for the MB resource currently coerces the
> >  | memory bandwidth percentage value from userspace to be an exact
> >  | multiple of the bandwidth granularity parameter.
> 
> If you want to include the bandwidth_gran file then the above could be
> something like:
> 
> 	The control value parser for the MB resource coerces the memory
> 	bandwidth percentage value from userspace to be an exact multiple
> 	of the bandwidth granularity parameter that is exposed by the
> 	bandwidth_gran resctrl file.
> 
> I still think that replacing "the bandwidth granularity parameter" with
> "rdt_resource::resctrl_membw::bw_gran" will help to be more specific.

That's fine.  I'll change as per your original suggestion.

> >  |
> >  | On MPAM systems, this results in somewhat worse-than-worst-case
> >  | rounding, since the bandwidth granularity advertised to resctrl by the
> >  | MPAM driver is in general only an approximation [...]
> > 
> > (I'm happy to go with your suggestion if you're not keen on this,
> > though.)
> > 
> >>> On MPAM systems, this results in somewhat worse-than-worst-case
> >>> rounding, since bw_gran is in general only an approximation to the
> >>> actual hardware granularity on these systems, and the hardware
> >>> bandwidth allocation control value is not natively a percentage --
> >>> necessitating a further conversion in the resctrl_arch_update_domains()
> >>> path, regardless of the conversion done at parse time.
> >>>
> >>> Allow the arch to provide its own parse-time conversion that is
> >>> appropriate for the hardware, and move the existing conversion to x86.
> >>> This will avoid accumulated error from rounding the value twice on MPAM
> >>> systems.
> >>>
> >>> Clarify the documentation, but avoid overly exact promises.
> >>>
> >>> Clamping to bw_min and bw_max still feels generic: leave it in the core
> >>> code, for now.
> >>
> >> Sounds like MPAM may be ready to start the schema parsing discussion again?
> >> I understand that MPAM has a few more ways to describe memory bandwidth as
> >> well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
> >> schema format to user space, which seems like a good idea for new schema.
> > 
> > My own ideas in this area are a little different, though I agree with
> > the general idea.
> 
> Should we expect a separate proposal from James?

At some point, yes.  We still need to have a chat about it.

Right now, I was just throwing an idea out there.

> > I'll respond separately on that, to avoid this thread getting off-topic.
> 
> Much appreciated.
> 
> > 
> > For this patch, my aim was to avoid changing anything unnecessarily.
> 
> Understood. More below as I try to understand the details but it does not
> really sound as though the current interface works that great for MPAM. If I
> understand correctly this patch enables MPAM to use existing interface for
> its memory bandwidth allocations but doing so does not enable users to 
> obtain benefit of hardware capabilities. For that users would want to use
> the new interface?

In ideal world, probably, yes.

Since not all use cases will care about full precision, the MB resource
(approximated for MPAM) should be fine for a lot of people, but I
expect that sooner or later somebody will want more exact control.

> >>> Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
> >>> the other tests except for the NONCONT_CAT tests, which do not seem to
> >>> be supported in my configuration -- and have nothing to do with the
> >>> code touched by this patch).
> >>
> >> Is the NONCONT_CAT test failing (i.e printing "not ok")?
> >>
> >> The NONCONT_CAT tests may print error messages as debug information as part of
> >> running, but these errors are expected as part of the test. The test should accurately
> >> state whether it passed or failed though. For example, below attempts to write
> >> a non-contiguous CBM to a system that does not support non-contiguous masks.
> >> This fails as expected, error messages printed as debugging and thus the test passes
> >> with an "ok".
> >>
> >> # Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
> >> # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
> >> ok 5 L3_NONCONT_CAT: test                             
> > 
> > I don't think that this was anything to do with my changes, but I don't
> > still seem to have the test output.  (Since this test has to do with
> > bitmap schemata (?), it seemed unlikely to be affected by changes to
> > bw_validate().)
> 
> I agree that this should not have anything to do with this patch. My concern
> is that I understood that the test failed for a feature that is not supported.
> If this is the case then there may be a problem with the test. The test should
> not fail if the feature is not supported but instead skip the test.

I'll try to capture more output from this when I re-run it, so that we
can figure out what this is.

> >>> Notes:
> >>>
> >>> I put the x86 version out of line in order to avoid having to move
> >>> struct rdt_resource and its dependencies into resctrl_types.h -- which
> >>> would create a lot of diff noise.  Schemata writes from userspace have
> >>> a high overhead in any case.
> >>
> >> Sounds good, I expect compiler will inline.
> > 
> > The function and caller are in separate translation units, so unless
> > LTO is used, I don't think the function will be inlined.
> 
> Thanks, yes, indeed.
> 
> > 
> >>>
> >>> For MPAM the conversion will be a no-op, because the incoming
> >>> percentage from the core resctrl code needs to be converted to hardware
> >>> representation in the driver anyway.
> >>
> >> (addressed below)
> >>
> >>>
> >>> Perhaps _all_ the types should move to resctrl_types.h.
> >>
> >> Can surely consider when there is a good motivation.
> >>
> >>>
> >>> For now, I went for the smallest diffstat...
> > 
> > I'll assume the motivation is not strong enough for now, but shout if
> > you disagree.
> 
> I agree.

OK, I'll leave that as-is for now, then.

> > 
> > [...]
> > 
> >>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> >>> index c7949dd44f2f..a1d0469d6dfb 100644
> >>> --- a/Documentation/filesystems/resctrl.rst
> >>> +++ b/Documentation/filesystems/resctrl.rst
> >>> @@ -143,12 +143,11 @@ with respect to allocation:
> >>>  		user can request.
> >>>  
> >>>  "bandwidth_gran":
> >>> -		The granularity in which the memory bandwidth
> >>> +		The approximate granularity in which the memory bandwidth
> >>>  		percentage is allocated. The allocated
> >>>  		b/w percentage is rounded off to the next
> >>> -		control step available on the hardware. The
> >>> -		available bandwidth control steps are:
> >>> -		min_bandwidth + N * bandwidth_gran.
> >>> +		control step available on the hardware. The available
> >>> +		steps are at least as small as this value.
> >>
> >> A bit difficult to parse for me. 
> >> Is "at least as small as" same as "at least"?
> > 
> > It was supposed to mean: "The available steps are no larger than this
> > value."
> 
> This is clear to me, especially when compared with the planned addition to
> "Memory bandwidth Allocation and monitoring" ... but I do find it contradicting
> the paragraph below (more below).
> 
> > 
> > Formally My expectation is that this value is the smallest integer
> > number of percent which is not smaller than the apparent size of any
> > individual rounding step.  Equivalently, this is the smallest number g
> 
> Considering the two statements:
> - "The available steps are no larger than this value."
> - "this value ... is not smaller than the apparent size of any individual rounding step"
> 
> The "not larger" and "not smaller" sounds like all these words just end up saying that
> this is the step size?

They are intended to be the same statement: A <= B versus
B >= A respectively.

But I'd be the first to admit that the wording is a bit twisted!
(I wouldn't be astonshed if I got something wrong somewhere.)

See below for an alternative way of describing this that might be more
intuitive.

> 
> > for which writing "MB: 0=x" and "MB: 0=y" yield different
> > configurations for every in-range x and where y = x + g and y is also
> > in-range.
> > 
> > That's a bit of a mouthful, though.  If you can think of a more
> > succinct way of putting it, I'm open to suggestions!
> > 
> >> Please note that the documentation has a section "Memory bandwidth Allocation
> >> and monitoring" that also contains these exact promises.
> > 
> > Hmmm, somehow I completely missed that.
> > 
> > Does the following make sense?  Ideally, there would be a simpler way
> > to describe the discrepancy between the reported and actual values of
> > bw_gran...
> > 
> >  |  Memory bandwidth Allocation and monitoring
> >  |  ==========================================
> >  |
> >  |  [...]
> >  |
> >  |  The minimum bandwidth percentage value for each cpu model is predefined
> >  |  and can be looked up through "info/MB/min_bandwidth". The bandwidth
> >  |  granularity that is allocated is also dependent on the cpu model and can
> >  |  be looked up at "info/MB/bandwidth_gran". The available bandwidth
> >  | -control steps are: min_bw + N * bw_gran. Intermediate values are rounded
> >  | -to the next control step available on the hardware.
> >  | +control steps are: min_bw + N * (bw_gran - e), where e is a
> >  | +non-negative, hardware-defined real constant that is less than 1.
> >  | +Intermediate values are rounded to the next control step available on
> >  | +the hardware.
> >  | +
> >  | +At the time of writing, the constant e referred to in the preceding
> >  | +paragraph is always zero on Intel and AMD platforms (i.e., bw_gran
> >  | +describes the step size exactly), but this may not be the case on other
> >  | +hardware when the actual granularity is not an exact divisor of 100.
> 
> Have you considered how to share the value of "e" with users?

Perhaps introducing this "e" as an explicit parameter is a bad idea and
overly formal.  In practice, there are likely to various sources of
skid and approximation in the hardware, so exposing an actual value may
be counterproductive -- i.e., what usable guarantee is this providing
to userspace, if this is likely to be swamped by approximations
elsewhere?

Instead, maybe we can just say something like:

 | The available steps are spaced at roughly equal intervals between the
 | value reported by info/MB/min_bandwidth and 100%, inclusive.  Reading
 | info/MB/bandwidth_gran gives the worst-case precision of these
 | interval steps, in per cent.

What do you think?

If that's adequate, then the wording under the definition of
"bandwidth_gran" could be aligned with this.

> >>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> >>> index d98e0d2de09f..c5e73b75aaa0 100644
> >>> --- a/fs/resctrl/ctrlmondata.c
> >>> +++ b/fs/resctrl/ctrlmondata.c
> >>> @@ -69,7 +69,7 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
> >>>  		return false;
> >>>  	}
> >>>  
> >>> -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> >>> +	*data = resctrl_arch_round_bw(bw, r);
> >>
> >> Please check that function comments remain accurate after changes (specifically
> >> if making the conversion more generic as proposed below).
> > 
> > I hoped that the comment for this function was still applicable, though
> > it can probably be improved.  How about the following?
> > 
> >  | - * hardware. The allocated bandwidth percentage is rounded to the next
> >  | - * control step available on the hardware.
> >  | + * hardware. The allocated bandwidth percentage is converted as
> >  | + * appropriate for consumption by the specific hardware driver.
> >  
> > [...]
> 
> Looks good to me.

OK.

> > 
> >>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> >>> index 6fb4894b8cfd..5b2a555cf2dd 100644
> >>> --- a/include/linux/resctrl.h
> >>> +++ b/include/linux/resctrl.h
> >>> @@ -416,6 +416,12 @@ static inline u32 resctrl_get_config_index(u32 closid,
> >>>  bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
> >>>  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
> >>>  
> >>> +/*
> >>> + * Round a bandwidth control value to the nearest value acceptable to
> >>> + * the arch code for resource r:
> >>> + */
> >>> +u32 resctrl_arch_round_bw(u32 val, const struct rdt_resource *r);
> >>> +
> >>
> >> I do not think that resctrl should make any assumptions on what the
> >> architecture's conversion does (i.e "round"). That architecture needs to be
> >> asked to "round a bandwidth control value" also sounds strange since resctrl really
> >> should be able to do something like rounding itself. As I understand from
> >> the notes this will be a no-op for MPAM making this even more confusing.
> >>
> >> How about naming the helper something like resctrl_arch_convert_bw()?
> >> (Open to other ideas of course).
> >>
> >> If you make such a change, please check that subject of patch still fits.
> > 
> > I struggled a bit with the name.  Really, this is converting the value
> > to an intermediate form (which might or might not involve rounding).
> > For historical reasons, this is a value suitable for writing directly
> > to the relevant x86 MSR without any further interpretation.
> > 
> > For MPAM, it is convenient to do this conversion later, rather than
> > during parsing of the value.
> > 
> > 
> > Would a name like resctrl_arch_preconvert_bw() be acceptable?
> 
> Yes.
> 
> > 
> > This isn't more informative than your suggestion regarding what the
> > conversion is expected to do, but may convey the expectation that the
> > output value may still not be in its final (i.e., hardware) form.
> 
> Sounds good, yes. 

OK, I'll hack that in.

> 
> > 
> >> I think that using const to pass data to architecture is great, thanks.
> >>
> >> Reinette
> > 
> > I try to constify by default when straightforward to do so, since the
> > compiler can then find which cases need to change; the reverse
> > direction is harder to automate...
> 
> Could you please elaborate what you mean with "reverse direction"?

I just meant that over-consting tends to result in violations of the
language that the compiler will detect, but under-consting doesn't:

static void foo(int *nonconstp, const int *constp)
{
	*constp = 0; // compiler error
	(*nonconstp); // silently accpeted, though it could have been const
}

So, the compiler will tell you places where const needs to be removed
(or something else needs to change), but to find places where const
could be _added_, you have to hunt them down yourself, or use some
other tool that is probably not part of the usual workflow.

Cheers
---Dave

