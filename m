Return-Path: <linux-kernel+bounces-751163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6FB165E2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1DA7B6D17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E222E2F18;
	Wed, 30 Jul 2025 17:57:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8C2E2EEE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898261; cv=none; b=bmuGN0n8rQIsJ0/XF4H3J+YTEqWCkD1M5AndvpFnsA1ERv3j/hTi6mHnGbP28i0UPcYHN02++XbF2qmt6EIbH9jR/29hgBmmKgsaQpo7neLmCQMzqdsr9i+Rgom1H5Vqznm4UvZ02pGHqO1L1WJEONYoQEn/U+kSTfeIUMGOjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898261; c=relaxed/simple;
	bh=MgHWfHofC9KDfxNVxgX3AqEBvM08vH6lRVDeIVYtkdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBNbqlNeONDZvvHtGoeB2AKyslwnqRQ0CgOWci/09+hOsncudSxD6tLqc9xbbB3nCKBJkAquIPrJ18ypM4XGuGisP8C6K3oKSRtPGR8L1EkSCjevn9SCRa8CgUx7OWLU3vUdJNugDcK+phxPW9M+WQxDhFtIAYkU3pXvhtgqLtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74D71BF7;
	Wed, 30 Jul 2025 10:57:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7A03F66E;
	Wed, 30 Jul 2025 10:57:38 -0700 (PDT)
Date: Wed, 30 Jul 2025 18:57:36 +0100
From: Leo Yan <leo.yan@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 04/10] coresight: Appropriately disable programming
 clocks
Message-ID: <20250730175736.GD143191@e132581.arm.com>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
 <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
 <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
 <15370a42-8e92-4f57-9ff2-f283d9fd30bd@arm.com>
 <20250730085637.GB143191@e132581.arm.com>
 <caffdde4-fad4-4462-ba92-84416726a12d@arm.com>
 <20250730105432.GC143191@e132581.arm.com>
 <cd250adb-61e7-414f-bf17-6cc960e44f7b@arm.com>
 <015c39de-001b-4660-bc64-6fd07eff9f18@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015c39de-001b-4660-bc64-6fd07eff9f18@sirena.org.uk>

On Wed, Jul 30, 2025 at 12:09:42PM +0100, Mark Brown wrote:
> On Wed, Jul 30, 2025 at 12:01:25PM +0100, Suzuki K Poulose wrote:
> 
> > I would recommend using that and don't force the use of apb_clk/apb
> > for AMBA devices. If the firmware doesn't specify a clock, but does
> > specify the CoreSight components, it knows it better.
> 
> And perhaps more to the point if a currently working system suddenly
> starts requiring additional clocks in it's binding that's an ABI break.

Yes, the change should not break any platforms if the DT binding is
passed correctly. I will update with devm_clk_get_optional_enabled().

Just for the record, I was a bit concerned that the driver might not
report a missing clock after switching to the optional clock API.
After discussed with Rob and Suzuki, I understand this should not be a
problem. Any missing clock issue can be caught by the DT schema static
checker, or a system hang during the development phase would remind
developers to bind clocks properly.

Thanks,
Leo

