Return-Path: <linux-kernel+bounces-750405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C17B15AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD67A3ABB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4AF292B2D;
	Wed, 30 Jul 2025 08:56:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC9023741
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865802; cv=none; b=NU2ELuLBPG6QkG+0GZXgHM6vPh63yS59YLGjawD82aWioeRMb4k95G4sFRATFq5BiYMTpbKHJGDgKa9aJjVhn6kfHnIYwEbDYOqr0jaNSu5iCkb+ACPOjw/cnvHlEKLAM+n/TSlLlI/5Y2OEzAhfjk8AhpYkXAjsONok0jDG8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865802; c=relaxed/simple;
	bh=qBE2HGiMSuqWFGIHqYGVYoYs8VHVC+8w2e2jsgoax2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJCr9SckBRGQkdxAR7CJqPTvLEfvciPsid8MRcvW262wes2hEzBzvhW72AQyIBxYpF5sbDzx2VSl2qSZWLGDRcVQ5QRQwxl2W7vaWtSg5iILez6Giad3TEnzQG7uIOsC7oHwlff8aQATgdhfDpBSjvZO0SjC5rJapj9VSjJvvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063061BC0;
	Wed, 30 Jul 2025 01:56:32 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 917383F66E;
	Wed, 30 Jul 2025 01:56:39 -0700 (PDT)
Date: Wed, 30 Jul 2025 09:56:37 +0100
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
Message-ID: <20250730085637.GB143191@e132581.arm.com>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
 <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
 <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
 <15370a42-8e92-4f57-9ff2-f283d9fd30bd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15370a42-8e92-4f57-9ff2-f283d9fd30bd@arm.com>

On Tue, Jul 29, 2025 at 01:30:28PM +0100, Suzuki Kuruppassery Poulose wrote:
> On 29/07/2025 12:31, Mark Brown wrote:
> > On Mon, Jul 28, 2025 at 05:45:04PM +0100, Mark Brown wrote:
> > > On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:
> > > 
> > > Previously we would return NULL for any error (which isn't super great
> > > for deferred probe but never mind).
> > > 
> > > > +	pclk = devm_clk_get_enabled(dev, "apb_pclk");
> > > > +	if (IS_ERR(pclk))
> > > > +		pclk = devm_clk_get_enabled(dev, "apb");
> > > 
> > > ...
> > > 
> > > >   	return pclk;
> > > >   }
> > > 
> > > Now we pass errors back to the caller, making missing clocks fatal.
> > 
> > Thinking about this some more I think for compatiblity these clocks need
> > to be treated as optional - that's what the original code was
> > effectively doing, and I can imagine this isn't the only SoC which has
> > (hopefully) always on clocks and didn't wire things up in DT.
> 
> You're right. The static components (funnels, replicators) don't have
> APB programming interface and hence no clocks. That said, may be the
> "is amba device" check could be used to enforce the presence of a clock.

I was wondering how this issue slipped through when I tested it on the
Hikey960 board. The Hikey960 also has one static funnel, but it binds
pclk with the static funnel node. That's why I didn't detect the issue.

I don't think using optional clock API is right thing, as DT binding
schema claims the pclk is mandatory for dynamic components. My proposal
is to enable the clocks only when IORESOURCE_MEM is available, something
like:

  if (res) {
      ret = coresight_get_enable_clocks(dev, &drvdata->pclk,
                                        &drvdata->atclk);
      if (ret)
              return ret;

      base = devm_ioremap_resource(dev, res);
      ...
  }

The static components don't bind I/O resources, it is naturally not to
enable clocks for them. Please let me know if this is reasonable
solution.

@Mark, thanks a lot for testing and bisection.

Leo

