Return-Path: <linux-kernel+bounces-858346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45CBEACCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2557C5D33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8502F12A0;
	Fri, 17 Oct 2025 15:52:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028E330B2E;
	Fri, 17 Oct 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716332; cv=none; b=pHviG53B1QgHW4kKfXHB4E45JY2yVV+NPW3aPXSrKFlR/YKwpybYUC27F9BUwaxzNF9iRDvESyZYiHkvtb11DeWIJNLhrlpxFrjVljUiL4Av93WsDlQ72SvzwQJ7WAi24j4NKAECxtNDDfesI9JMjX5Sb0RIkPA7j5ZwCYvIDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716332; c=relaxed/simple;
	bh=KG2cv8tKePy8Aq4dA2CYm/WJRsZFx/9WRZnz4wtuG1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMKHOZVja1a8ThL01E9V4JbTZrFVFBds3kY31wvAySYGzkgoTOdVsBbdBY7wGyfAjitFXWQ4QnovLy992AU3ebTJwkU/pE9j2tkJ+58LjZtd4hWWrfDfEBg3rpN0e7eKTPqjmRJ5/8pVinyKDTOFbYjLWxsGrmh0yhVDhx1T3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061861595;
	Fri, 17 Oct 2025 08:52:02 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D926D3F59E;
	Fri, 17 Oct 2025 08:52:07 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:52:05 +0100
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
Message-ID: <aPJmJVz6In55MMhr@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <aO+7MeSMV29VdbQs@e133380.arm.com>
 <1493d341-16a5-47e9-a834-cd8133b91fed@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493d341-16a5-47e9-a834-cd8133b91fed@intel.com>

Hi there,

On Thu, Oct 16, 2025 at 08:57:59AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 10/15/25 8:18 AM, Dave Martin wrote:

[...]

> > I finally got around to testing this on top of -rc1.
> > 
> > Disregarding trivial differences, the patched version (+++) doesn't
> > seem to introduce any regressions over the vanilla version (---)
> > (below).  (The CMT test actually failed with an out-of-tolerance result
> > on the vanilla kernel only.  Possibly there was some adverse system
> > load interfering.)
> 
> My first thought is that this is another unfortunate consequence of the resctrl
> performance-as-functional tests.
> The percentage difference you encountered is quite large and that
> prompted me to take a closer look and it does look to me as though the CMT
> can be improved. (Whether we should spend more effort on these performance tests
> instead of creating new deterministic functional tests is another topic.) 

I ran the tests soon after booting a full-fat OS, which may not have helped.

In an ideal world we sort of want two RDT instances, one under test,
and one outside it to isolate it from the rest of the system...  but
that would require extra hardware :(

I'll aim to just boot to a shell the next time I run these tests.


> > Looking at the code, it seems that L2_NONCONT_CAT is not gated by any
> > config or mount option.  I think this is just a feature that my
> > hardware doesn't support (?)
> 
> Yes, this is how I also interpret the test output.
> 
> Focusing on the CMT test ...
> 
> >  # Starting CMT test ...
> >  # Mounting resctrl to "/sys/fs/resctrl"
> >  # Cache size :23068672
> >  # Writing benchmark parameters to resctrl FS
> > -# Benchmark PID: 5135
> > +# Benchmark PID: 4970
> >  # Checking for pass/fail
> > -# Fail: Check cache miss rate within 15%
> > -# Percent diff=24
> > +# Pass: Check cache miss rate within 15%
> > +# Percent diff=4
> >  # Number of bits: 5
> > -# Average LLC val: 7942963
> > +# Average LLC val: 10918297
> >  # Cache span (bytes): 10485760
> > -not ok 3 CMT: test
> > +ok 3 CMT: test
> 
> A 24% difference followed by a 4% difference is a big swing. On a high level
> the CMT test creates a new resource group with only the test assigned to it. The test
> initializes and accesses a buffer a couple of time while measuring cache occupancy.
> "success" is when the cache occupancy is within 15% of the buffer size.
> 
> I noticed a couple of places where the test is susceptible to interference and
> system architecture.
> 1) The cache allocation of test's resource group overlaps with the rest of the
>    system. On a busy system it is thus likely that the test's cache entries may be
>    evicted.
> 2) The test does not account for cache architecture where, for example, there may be
>    an L2 cache that can accommodate a large part of the buffer and thus not be
>    reflected in the LLC occupancy count.

I suppose the test could take all the cache sizes into account, but
this could get complicated -- for a statistical test, it may not be worth it.

Can we probe it just by setting the CAT mask to all ones (maybe
excluding one bit to give to the default control group) and then
flooding with data until the LLC usage stops increasing?


> I started experimenting to see what it will take to reduce interference and ended up
> with a change like below that isolates the cache portions between the test and the
> rest of the system and if L2 cache allocation is possible, reduces the amount of L2
> cache the test can allocate into as much as possible. This opened up another tangent
> where the size of cache portion is the same as the buffer while it is not realistic
> to expect a user space buffer to fill into the cache so nicely. 
> 
> Even with these changes I was not able to get the percentages to drop significantly
> on my system but it may help to reduce the swings in numbers observed.
> 
> But, I do not see how work like this helps to improve resctrl health (compared to,
> for example, just increasing the "success" percentage).

If I understand correctly, this programs the default control group with
the inverse of the test's CAT mask, so that there is no overlap?  That
seems reasonable, if so.

I wonder whether bandwidth contention is also having an effect.  Would
programming the default control and test control group with MB values
that don't add up to more than 100% help?


Cheers
---Dave

> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index d09e693dc739..494e98aa8b69 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -19,12 +19,22 @@
>  #define CON_MON_LCC_OCCUP_PATH		\
>  	"%s/%s/mon_data/mon_L3_%02d/llc_occupancy"
>  
> -static int cmt_init(const struct resctrl_val_param *param, int domain_id)
> +static int cmt_init(const struct resctrl_test *test,
> +		    const struct user_params *uparams,
> +		    const struct resctrl_val_param *param, int domain_id)
>  {
> +	char schemata[64];
> +	int ret;
> +
>  	sprintf(llc_occup_path, CON_MON_LCC_OCCUP_PATH, RESCTRL_PATH,
>  		param->ctrlgrp, domain_id);
>  
> -	return 0;
> +	snprintf(schemata, sizeof(schemata), "%lx", param->mask);
> +	ret = write_schemata(param->ctrlgrp, schemata, uparams->cpu, test->resource);
> +	if (!ret && !strcmp(test->resource, "L3") && resctrl_resource_exists("L2"))
> +		ret = write_schemata(param->ctrlgrp, "0x1", uparams->cpu, "L2");
> +
> +	return ret;
>  }

[...]

> @@ -162,6 +173,11 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param

[...]

> +	snprintf(schemata, sizeof(schemata), "%lx", ~param.mask & long_mask);
> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
> +	if (ret)
> +		return ret;
> +
>  	remove(RESULT_FILE_NAME);
>  
>  	ret = resctrl_val(test, uparams, &param);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c

[...]

