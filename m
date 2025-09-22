Return-Path: <linux-kernel+bounces-827435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F8CB91C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AD03A7136
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072827B35C;
	Mon, 22 Sep 2025 14:40:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB127B343;
	Mon, 22 Sep 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552003; cv=none; b=NaFybs7Vds7U4vnS5y4xcPn3Ou3JkVKEWmGxqlb0O7xTuGuVARczUtWoXo3DMYMKcPZtY8mPzPGK+5sFXoBhLjr/G9bTMl1mg0AjMxlMC9y/LmtfDaqEZtWzeTAQ2HdyyIdJ/VDEHJY6wYREs2Grcw0f6UMX18sEnAV3gL5OGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552003; c=relaxed/simple;
	bh=79OnI+vS0+4bLD+IAlrrbw6Jp1hqmp6f3STgmE14v8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y40zorICw5ulZf74h9SUcrNci3q2MlxZgIFSUSbo9Z69te5f/aflE2NnTgD+aIWkM9Iz1VpzVE1/grYqyRnQo8I2orqEMbnCh4Kq3VeMO9IE9KK5meqkL8JT+DQkkU5ispJU4ACaDSo50ct+AkUvNoux8XmADSY6cBFo8vXCGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 317961424;
	Mon, 22 Sep 2025 07:39:51 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F98F3F66E;
	Mon, 22 Sep 2025 07:39:57 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:39:47 +0100
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
Message-ID: <aNFfs43UBp6tjqPM@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>

Hi Reinette,

Thanks for the review.

On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> nits:
> Please use the subject prefix "x86,fs/resctrl" to be consistent with other
> resctrl code (and was established by Arm :)).
> Also please use upper case for acronym mba->MBA.

Ack (the local custom in the MPAM code is to use "mba", but arguably,
the meaning is not quite the same -- I'll change it.)

> On 9/2/25 9:24 AM, Dave Martin wrote:
> > The control value parser for the MB resource currently coerces the
> > memory bandwidth percentage value from userspace to be an exact
> > multiple of the bw_gran parameter.
> 
> (to help be specific)
> "the bw_gran parameter" -> "rdt_resource::resctrl_membw::bw_gran"?

"bw_gran" was intended as an informal shorthand for the abstract
parameter (exposed both in the field you mention and through the
bandiwidth_gran file in resctrl).

I can rewrite it as per your suggestion, but this could be read as
excluding the bandwidth_gran file.  Would it make sense just to write
it out longhand?  For now, I've rewritten it as follows:

 | The control value parser for the MB resource currently coerces the
 | memory bandwidth percentage value from userspace to be an exact
 | multiple of the bandwidth granularity parameter.
 |
 | On MPAM systems, this results in somewhat worse-than-worst-case
 | rounding, since the bandwidth granularity advertised to resctrl by the
 | MPAM driver is in general only an approximation [...]

(I'm happy to go with your suggestion if you're not keen on this,
though.)

> > On MPAM systems, this results in somewhat worse-than-worst-case
> > rounding, since bw_gran is in general only an approximation to the
> > actual hardware granularity on these systems, and the hardware
> > bandwidth allocation control value is not natively a percentage --
> > necessitating a further conversion in the resctrl_arch_update_domains()
> > path, regardless of the conversion done at parse time.
> > 
> > Allow the arch to provide its own parse-time conversion that is
> > appropriate for the hardware, and move the existing conversion to x86.
> > This will avoid accumulated error from rounding the value twice on MPAM
> > systems.
> > 
> > Clarify the documentation, but avoid overly exact promises.
> > 
> > Clamping to bw_min and bw_max still feels generic: leave it in the core
> > code, for now.
> 
> Sounds like MPAM may be ready to start the schema parsing discussion again?
> I understand that MPAM has a few more ways to describe memory bandwidth as
> well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
> schema format to user space, which seems like a good idea for new schema.

My own ideas in this area are a little different, though I agree with
the general idea.

I'll respond separately on that, to avoid this thread getting off-topic.

For this patch, my aim was to avoid changing anything unnecessarily.

> Is this something MPAM is still considering? For example, the minimum
> and maximum ranges that can be specified, is this something you already
> have some ideas for? Have you perhaps considered Tony's RFD [3] that includes
> discussion on how to handle min/max ranges for bandwidth? 

This is another thing that we probably do want to support at some point,
but it feels like a different thing from the minimum and maximum bounds 
acceptable to an individual schema -- especially since in the hardware
they may behave more like trigger points than hard limits.

Again, I'll respond separately.

[...]

> > Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
> > the other tests except for the NONCONT_CAT tests, which do not seem to
> > be supported in my configuration -- and have nothing to do with the
> > code touched by this patch).
> 
> Is the NONCONT_CAT test failing (i.e printing "not ok")?
> 
> The NONCONT_CAT tests may print error messages as debug information as part of
> running, but these errors are expected as part of the test. The test should accurately
> state whether it passed or failed though. For example, below attempts to write
> a non-contiguous CBM to a system that does not support non-contiguous masks.
> This fails as expected, error messages printed as debugging and thus the test passes
> with an "ok".
> 
> # Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
> # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
> ok 5 L3_NONCONT_CAT: test                             

I don't think that this was anything to do with my changes, but I don't
still seem to have the test output.  (Since this test has to do with
bitmap schemata (?), it seemed unlikely to be affected by changes to
bw_validate().)

I'll need to re-test with and without this patch to check whether it
makes any difference.

> > Notes:
> > 
> > I put the x86 version out of line in order to avoid having to move
> > struct rdt_resource and its dependencies into resctrl_types.h -- which
> > would create a lot of diff noise.  Schemata writes from userspace have
> > a high overhead in any case.
> 
> Sounds good, I expect compiler will inline.

The function and caller are in separate translation units, so unless
LTO is used, I don't think the function will be inlined.

> > 
> > For MPAM the conversion will be a no-op, because the incoming
> > percentage from the core resctrl code needs to be converted to hardware
> > representation in the driver anyway.
> 
> (addressed below)
> 
> > 
> > Perhaps _all_ the types should move to resctrl_types.h.
> 
> Can surely consider when there is a good motivation.
> 
> > 
> > For now, I went for the smallest diffstat...

I'll assume the motivation is not strong enough for now, but shout if
you disagree.

[...]

> > diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> > index c7949dd44f2f..a1d0469d6dfb 100644
> > --- a/Documentation/filesystems/resctrl.rst
> > +++ b/Documentation/filesystems/resctrl.rst
> > @@ -143,12 +143,11 @@ with respect to allocation:
> >  		user can request.
> >  
> >  "bandwidth_gran":
> > -		The granularity in which the memory bandwidth
> > +		The approximate granularity in which the memory bandwidth
> >  		percentage is allocated. The allocated
> >  		b/w percentage is rounded off to the next
> > -		control step available on the hardware. The
> > -		available bandwidth control steps are:
> > -		min_bandwidth + N * bandwidth_gran.
> > +		control step available on the hardware. The available
> > +		steps are at least as small as this value.
> 
> A bit difficult to parse for me. 
> Is "at least as small as" same as "at least"?

It was supposed to mean: "The available steps are no larger than this
value."

Formally My expectation is that this value is the smallest integer
number of percent which is not smaller than the apparent size of any
individual rounding step.  Equivalently, this is the smallest number g
for which writing "MB: 0=x" and "MB: 0=y" yield different
configurations for every in-range x and where y = x + g and y is also
in-range.

That's a bit of a mouthful, though.  If you can think of a more
succinct way of putting it, I'm open to suggestions!

> Please note that the documentation has a section "Memory bandwidth Allocation
> and monitoring" that also contains these exact promises.

Hmmm, somehow I completely missed that.

Does the following make sense?  Ideally, there would be a simpler way
to describe the discrepancy between the reported and actual values of
bw_gran...

 |  Memory bandwidth Allocation and monitoring
 |  ==========================================
 |
 |  [...]
 |
 |  The minimum bandwidth percentage value for each cpu model is predefined
 |  and can be looked up through "info/MB/min_bandwidth". The bandwidth
 |  granularity that is allocated is also dependent on the cpu model and can
 |  be looked up at "info/MB/bandwidth_gran". The available bandwidth
 | -control steps are: min_bw + N * bw_gran. Intermediate values are rounded
 | -to the next control step available on the hardware.
 | +control steps are: min_bw + N * (bw_gran - e), where e is a
 | +non-negative, hardware-defined real constant that is less than 1.
 | +Intermediate values are rounded to the next control step available on
 | +the hardware.
 | +
 | +At the time of writing, the constant e referred to in the preceding
 | +paragraph is always zero on Intel and AMD platforms (i.e., bw_gran
 | +describes the step size exactly), but this may not be the case on other
 | +hardware when the actual granularity is not an exact divisor of 100.

> 
> >  
> >  "delay_linear":
> >  		Indicates if the delay scale is linear or
> > diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> > index feb93b50e990..8bec2b9cc503 100644
> > --- a/arch/x86/include/asm/resctrl.h
> > +++ b/arch/x86/include/asm/resctrl.h
> > @@ -18,6 +18,8 @@
> >   */
> >  #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
> >  
> > +struct rdt_resource;
> > +
> 
> I'm missing something here. Why is this needed?

Oops, it's not.  This got left behind from when I had the function
in-line here.

Removed.

[...]

> > diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> > index d98e0d2de09f..c5e73b75aaa0 100644
> > --- a/fs/resctrl/ctrlmondata.c
> > +++ b/fs/resctrl/ctrlmondata.c
> > @@ -69,7 +69,7 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
> >  		return false;
> >  	}
> >  
> > -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> > +	*data = resctrl_arch_round_bw(bw, r);
> 
> Please check that function comments remain accurate after changes (specifically
> if making the conversion more generic as proposed below).

I hoped that the comment for this function was still applicable, though
it can probably be improved.  How about the following?

 | - * hardware. The allocated bandwidth percentage is rounded to the next
 | - * control step available on the hardware.
 | + * hardware. The allocated bandwidth percentage is converted as
 | + * appropriate for consumption by the specific hardware driver.
 
[...]

> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 6fb4894b8cfd..5b2a555cf2dd 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -416,6 +416,12 @@ static inline u32 resctrl_get_config_index(u32 closid,
> >  bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
> >  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
> >  
> > +/*
> > + * Round a bandwidth control value to the nearest value acceptable to
> > + * the arch code for resource r:
> > + */
> > +u32 resctrl_arch_round_bw(u32 val, const struct rdt_resource *r);
> > +
> 
> I do not think that resctrl should make any assumptions on what the
> architecture's conversion does (i.e "round"). That architecture needs to be
> asked to "round a bandwidth control value" also sounds strange since resctrl really
> should be able to do something like rounding itself. As I understand from
> the notes this will be a no-op for MPAM making this even more confusing.
> 
> How about naming the helper something like resctrl_arch_convert_bw()?
> (Open to other ideas of course).
> 
> If you make such a change, please check that subject of patch still fits.

I struggled a bit with the name.  Really, this is converting the value
to an intermediate form (which might or might not involve rounding).
For historical reasons, this is a value suitable for writing directly
to the relevant x86 MSR without any further interpretation.

For MPAM, it is convenient to do this conversion later, rather than
during parsing of the value.


Would a name like resctrl_arch_preconvert_bw() be acceptable?

This isn't more informative than your suggestion regarding what the
conversion is expected to do, but may convey the expectation that the
output value may still not be in its final (i.e., hardware) form.

> I think that using const to pass data to architecture is great, thanks.
> 
> Reinette

I try to constify by default when straightforward to do so, since the
compiler can then find which cases need to change; the reverse
direction is harder to automate...

Cheers
---Dave

[...]

> [1] https://lore.kernel.org/lkml/fa93564a-45b0-ccdd-c139-ae4867eacfb5@arm.com/
> [2] https://lore.kernel.org/all/acefb432-6388-44ed-b444-1e52335c6c3d@arm.com/
> [3] https://lore.kernel.org/lkml/Z_mB-gmQe_LR4FWP@agluck-desk3/

