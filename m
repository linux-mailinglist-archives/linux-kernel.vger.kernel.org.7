Return-Path: <linux-kernel+bounces-678157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B33AD24E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2E616EDDC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF4221F3C;
	Mon,  9 Jun 2025 17:14:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FDB221704
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489262; cv=none; b=UPa0QqURaKEnPMe6834vu0T8E+iBE44+IR+iSzqwm+lV5iufRqOVhgUfOlfGa5xWoiIzjJ14/qMvJ7LywkLs+6AJkRNRg81szy50C3rRcVuNPnK3vMoUavkhdBGZPPLibw/hyoEykbVqq6WT5B60bH0k8C/buToZw2L6CoXkdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489262; c=relaxed/simple;
	bh=+6orwwYVzyYi6OfmNuzWvuT0jyjCZgn6mczUZlzDoyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz9DWS6r9S6S04/5dsSearcT0W1/9aRtPp5Izh61+Y7QXsXCsFLZOnjluLoJGyPLGZazvnmXe1vWViqYtDT+VSyxEqlQObsOhVy16fZDJZnkEbPMAJookcpQFLzjfnSUOdc7+0Bysib1NBoPkxE+ggN5TPP8B9lOCijQh+9qVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A5D4150C;
	Mon,  9 Jun 2025 10:13:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3C4C3F66E;
	Mon,  9 Jun 2025 10:14:17 -0700 (PDT)
Date: Mon, 9 Jun 2025 18:14:13 +0100
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] coresight: Avoid enable programming clock
 duplicately
Message-ID: <20250609171413.GO8020@e132581.arm.com>
References: <20250609-arm_cs_fix_clock_v3_public-v3-0-423b3f1f241d@arm.com>
 <20250609-arm_cs_fix_clock_v3_public-v3-6-423b3f1f241d@arm.com>
 <b30fc361-a04f-4a48-b8e2-f7c2da213e6c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30fc361-a04f-4a48-b8e2-f7c2da213e6c@arm.com>

On Mon, Jun 09, 2025 at 05:58:34PM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> >   static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
> >   {
> > -	struct clk *pclk;
> > +	struct clk *pclk = NULL;
> > -	pclk = devm_clk_get_enabled(dev, "apb_pclk");
> > -	if (IS_ERR(pclk))
> > -		pclk = devm_clk_get_enabled(dev, "apb");
> > +	if (!dev_is_amba(dev)) {
> > +		pclk = devm_clk_get_enabled(dev, "apb_pclk");
> > +		if (IS_ERR(pclk))
> > +			pclk = devm_clk_get_enabled(dev, "apb");
> 
> AMBA driver doesn't handle "apb" clock ? So we may need to retain that here
> ?

Here checks the condition "if (!dev_is_amba(dev))", it means the device
is not an AMBA device (e.g., a platform device), the APB clock is
enabled at here.

Otherwise, for a AMBA device, the AMBA bus layer will help to enable
APB clock.

> Otherwise looks good to me.
> 
> Suzuki
> > +	}
> >   	return pclk;
> >   }
> > 
> 

