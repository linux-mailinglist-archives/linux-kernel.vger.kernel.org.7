Return-Path: <linux-kernel+bounces-838959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD31BB0810
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C09163EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DAF2ED866;
	Wed,  1 Oct 2025 13:28:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21592BD03;
	Wed,  1 Oct 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325301; cv=none; b=fqI0gZP4TlMIPIQaaNWh6RdSITc1i2CC7A0bi+rn+EgrHnSy6ijnBwFAAqa5MbBgNfH8V2LM5OBWtJBC6s8YKWURhFN5PC/J289w6ZV5VxowkZR81yXazNxfVuNj9z8dgN8taChQQhzlz7ieRAT/wOJbbB1agO5fckJOv0qpsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325301; c=relaxed/simple;
	bh=TLVkysF/GBhoRIO7bnkXwy1hLk+VVGzi7IiFgnKT0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP3w4DiDcPCE+zOEDhc8MO+QkiEaljvK9SoKyrTflhLyYPVGsjypnOZgTyhikgToL4zK07Js5yjArymI3JW62Q1m9e4rlkGgRv0ojHWQnHsCTK1kCVlq8fQsXkkQPMyueU54ywUSOvY1q7QXhuMpEvcfTkBlK+Ik2m0BHvAKLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 155C116F2;
	Wed,  1 Oct 2025 06:28:10 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B49483F59E;
	Wed,  1 Oct 2025 06:28:17 -0700 (PDT)
Date: Wed, 1 Oct 2025 14:28:15 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] coresight: Add format attribute for setting the
 timestamp interval
Message-ID: <20251001132815.GN7985@e132581.arm.com>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
 <20250814-james-cs-syncfreq-v2-5-c76fcb87696d@linaro.org>
 <20250930151414.GK7985@e132581.arm.com>
 <3a731a9e-0621-42b6-b7fc-4b0fd9b7da6e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a731a9e-0621-42b6-b7fc-4b0fd9b7da6e@linaro.org>

On Wed, Oct 01, 2025 at 01:40:37PM +0100, James Clark wrote:

[...]

> > > @@ -103,6 +111,9 @@ static struct attribute *etm_config_formats_attr[] = {
> > >   	&format_attr_configid.attr,
> > >   	&format_attr_branch_broadcast.attr,
> > >   	&format_attr_cc_threshold.attr,
> > > +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> > > +	&format_attr_ts_level.attr,
> > > +#endif
> > 
> > By using .visible() callback for attrs, we can improve a bit code
> > without spreading "#ifdef IS_ENABLED()" in this file. E.g.,
> > 
> >     static umode_t format_attr_is_visible(struct kobject *kobj,
> >                                     struct attribute *attr, int n)
> >     {
> >          struct device *dev = kobj_to_dev(kobj);
> > 
> >          if (attr == &format_attr_ts_level.attr &&
> > 	    !IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
> >                  return 0;
> > 
> >          return attr->mode;
> >     }
> > 
> > Otherwise, LGTM:
> > 
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> > 
> 
> Unfortunately that won't work because you'd have to always include
> coresight-etm4x.h. This file is compiled for both arm32 and arm64 so it
> would break the arm32 build.
> 
> I could define the TTR_CFG_FLD_ts_level_* stuff somewhere else but then it
> becomes messier than just doing the #ifdefs here.

ATTR_CFG_FLD_ts_level_* is only used in coresight-etm4x-core.c, it is not
used in coresight-etm-perf.c. Thus, we don't need to include
coresight-etm4x.h in coresight-etm-perf.c. Do I miss anything?

A similiar case is the attr 'cc_threshold' is only used by ETMv4, it is
exported always. It is not bad for me to always expose these attrs but
in the are ignored in the ETMv3 driver - so we even don't need to
bother adding .visible() callback.

Thanks,
Leo

