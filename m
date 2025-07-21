Return-Path: <linux-kernel+bounces-739369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D552AB0C56E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AE617EF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A32D9785;
	Mon, 21 Jul 2025 13:42:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEF6F06B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105365; cv=none; b=kznFYjYcCBn4sVpswWdIYxKriBk7V+53LGq5hG+X2LCzlc/JSknraCCKcuBqlQZF6nrbgjIbEcoQAXMeksKhDfLfUxxAS7zBuehHr7rZ6SKhd/vbTdcfmE3TV/3A1koUaVAOlc/H3oMxDLJhef9IgzfmQo8jpS6UQkOFndMazq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105365; c=relaxed/simple;
	bh=u+j7EU/PCVIclxopev02AYHct4cglS3Bhzn5MuxKEos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayoFqrndlGTP8WDFM0PDPBwsf9YtpEyCv76WG+4nIgOeiKoTY7onf6SsmGY2tJbLkvpT789nTklhTdhHm8KUjPFLPx8YTx4J0J2dDG6dHyG36s7dXynS6NjxnaVo2Z6rivJ8JYDpSfu/i2sjwbH529Yg29xN3cNuHDKppToKJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88F50153B;
	Mon, 21 Jul 2025 06:42:35 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F06D63F6A8;
	Mon, 21 Jul 2025 06:42:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:42:38 +0100
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/10] coresight: Appropriately disable trace bus
 clocks
Message-ID: <20250721134238.GD3137075@e132581.arm.com>
References: <20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com>
 <20250627-arm_cs_fix_clock_v4-v4-5-0ce0009c38f8@arm.com>
 <807d7899-cab4-4449-aba4-645593b1db21@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807d7899-cab4-4449-aba4-645593b1db21@arm.com>

On Mon, Jul 21, 2025 at 10:20:42AM +0100, Suzuki Kuruppassery Poulose wrote:
> On 27/06/2025 12:51, Leo Yan wrote:
> > Some CoreSight components have trace bus clocks 'atclk' and are enabled
> > using clk_prepare_enable().  These clocks are not disabled when modules
> > exit.
> > 
> > As atclk is optional, use devm_clk_get_optional_enabled() to manage it.
> > The benefit is the driver model layer can automatically disable and
> > release clocks.
> > 
> > Check the returned value with IS_ERR() to detect errors but leave the
> > NULL pointer case if the clock is not found.  And remove the error
> > handling codes which are no longer needed.
> > 
> > Fixes: d1839e687773 ("coresight: etm: retrieve and handle atclk")
> 
> I would drop this tag as I don't see what we are fixing ?

This patch changes the clock operations from:

    atclk = devm_clk_get(dev, "atclk");
    clk_prepare_enable(atclk);

to:

    atclk = devm_clk_get_optional_enabled(dev, "atclk");

The commit log mentions in the old approach, "clocks are not disabled
when modules exit." So the patch is not only a refactoring, it changes
to use devm_clk_get_optional_enabled() to register
clk_disable_unprepare() as a callback to disable clock when the device
is released.

BTW, I selected the commit "d1839e687773" as the Fixed tag as it is
the first commit that introduced the devm_clk_get() +
clk_prepare_enable().

> If there is indeed something, I would recommend:
>  - Call it out in the commit description.
>  - Move that as a separate patch, so that it can be
>    safely backported without touching all the other drivers.
> 
> If you agree with the above, I will drop the "Fixes" tag and
> can merge it.

Please let me know if anything I can follow up.

Thanks,
Leo

