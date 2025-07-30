Return-Path: <linux-kernel+bounces-750599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704EB15E83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB588563426
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8E627C158;
	Wed, 30 Jul 2025 10:54:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23191A83ED
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872880; cv=none; b=r6K3lFPVUeBZVoDPtSPAyNnegT4mys3e6mO68sIpx9M0VY+VRZztVegTE6jUJ+l92EMOCeGitXybDn1TjSKNKVj0y7Xa6RnTemwozOxWVT1B+RD2HhVJXl3bE5UJZgthtwBHMkGYuS87/4Ec6yJZe3kaLYdQbSDhtsOdelpwR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872880; c=relaxed/simple;
	bh=tFjGCHkodjewqQzVkcaSycMgkj1U6ITooGxsGqWSHHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7mvopxKCXieh9kUyP/ULrA6sgpYDdgMkDQq9fIZPOs035fyKJ1xSm6dqHkS/nar1mjr4WTWlCzhMBbrjEU9RBDuk+jQz7IsrR4zkymNCMD/25sF6I5nYi5lQWfZjR5ievjfVlCCMk7rFV2oWHPntqBQ3ITSHZ6N1K6/gIY0fKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C74031BC0;
	Wed, 30 Jul 2025 03:54:26 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1CE3F673;
	Wed, 30 Jul 2025 03:54:34 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:54:32 +0100
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] coresight: Appropriately disable programming
 clocks
Message-ID: <20250730105432.GC143191@e132581.arm.com>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
 <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
 <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
 <15370a42-8e92-4f57-9ff2-f283d9fd30bd@arm.com>
 <20250730085637.GB143191@e132581.arm.com>
 <caffdde4-fad4-4462-ba92-84416726a12d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caffdde4-fad4-4462-ba92-84416726a12d@arm.com>

On Wed, Jul 30, 2025 at 10:27:48AM +0100, Suzuki Kuruppassery Poulose wrote:
> On 30/07/2025 09:56, Leo Yan wrote:
> > On Tue, Jul 29, 2025 at 01:30:28PM +0100, Suzuki Kuruppassery Poulose wrote:
> > > On 29/07/2025 12:31, Mark Brown wrote:
> > > > On Mon, Jul 28, 2025 at 05:45:04PM +0100, Mark Brown wrote:
> > > > > On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:
> > > > > 
> > > > > Previously we would return NULL for any error (which isn't super great
> > > > > for deferred probe but never mind).
> > > > > 
> > > > > > +	pclk = devm_clk_get_enabled(dev, "apb_pclk");
> > > > > > +	if (IS_ERR(pclk))
> > > > > > +		pclk = devm_clk_get_enabled(dev, "apb");
> > > > > 
> > > > > ...
> > > > > 
> > > > > >    	return pclk;
> > > > > >    }
> > > > > 
> > > > > Now we pass errors back to the caller, making missing clocks fatal.
> > > > 
> > > > Thinking about this some more I think for compatiblity these clocks need
> > > > to be treated as optional - that's what the original code was
> > > > effectively doing, and I can imagine this isn't the only SoC which has
> > > > (hopefully) always on clocks and didn't wire things up in DT.
> > > 
> > > You're right. The static components (funnels, replicators) don't have
> > > APB programming interface and hence no clocks. That said, may be the
> > > "is amba device" check could be used to enforce the presence of a clock.
> > 
> > I was wondering how this issue slipped through when I tested it on the
> > Hikey960 board. The Hikey960 also has one static funnel, but it binds
> > pclk with the static funnel node. That's why I didn't detect the issue.
> > 
> > I don't think using optional clock API is right thing, as DT binding
> > schema claims the pclk is mandatory for dynamic components. My proposal
> > is to enable the clocks only when IORESOURCE_MEM is available, something
> > like:
> > 
> >    if (res) {
> >        ret = coresight_get_enable_clocks(dev, &drvdata->pclk,
> >                                          &drvdata->atclk);
> 
> That may not work, as they may need the ATCLK enabled to
> push the trace over ATB. They may skip the APB, as there
> is no programming interface.

If so, I will use an extra patch to skip pclk enabling for static funnel
and replicator, as a result, patch 04 will be:

  if (res) {
      drvdata->pclk = coresight_get_enable_apb_pclk(dev);
      if (IS_ERR(drvdata->pclk))
          return PTR_ERR(drvdata->pclk);
  }

Then, when consolidation in patch 07, it will have a code:

  /* Only enable pclk for a device with I/O resource */
  ret = coresight_get_enable_clocks(dev, res ? &drvdata->pclk : NULL,
                                    &drvdata->atclk);

This turns out to be the case for both static funnel and replicator
devices — regardless of whether the DT binding includes "apb_pclk" or
not, the driver will always skip enabling it. Any concerns?

Thanks,
Leo

