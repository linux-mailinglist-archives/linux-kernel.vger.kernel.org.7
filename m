Return-Path: <linux-kernel+bounces-739096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1BB0C1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B434717158B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59528850C;
	Mon, 21 Jul 2025 10:48:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32928F5A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094920; cv=none; b=gpwq+PUdpgBKBICpoJNTGhfskNVB+nXe4DNz66Kb1ZQvrL46O3SXm4U7ZGiT81F+cmnpdBpKV81MUAeIHxjRMDnuEn9bgB/wLoNcswFd2RldFYZnQpylA9ql/BABLPm264rcjBx4DiaDNQ7V7nko96qSdmJ44S1zHYUOGCz1/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094920; c=relaxed/simple;
	bh=saxIPlbRshy1bRAi2/1qrgyOYPsIzV3Fxe76xTa13EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6mZlO6viJuLMkUsx+DEJJApXmO4SFQRowXdlA0DJ9qxKDANJGknQTQVq3S7cbUqqnvSCngF0nwiyCEFvlv8NmkmHNmK3Tao8tQ6bvb+DrawZs2g3Xuyq6yF1VOAJ6LQZ90rNZ4nNOeaMe7dnDssoj3PLvSFo+fFG8TELmnNuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 257C6153B;
	Mon, 21 Jul 2025 03:48:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A7CF3F66E;
	Mon, 21 Jul 2025 03:48:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:48:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] coresight: Appropriately disable programming
 clocks
Message-ID: <20250721104834.GC3137075@e132581.arm.com>
References: <20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com>
 <20250627-arm_cs_fix_clock_v4-v4-4-0ce0009c38f8@arm.com>
 <5a5f1355-563d-498a-9dec-3479a257b3e6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5f1355-563d-498a-9dec-3479a257b3e6@arm.com>

On Mon, Jul 21, 2025 at 10:15:22AM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 4ac65c68bbf44b98db22c3dad2d83a224ce5278e..dd2b4cc7a2b70cf060a3207548fe80e3824c489f 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -480,26 +480,16 @@ static inline bool is_coresight_device(void __iomem *base)
> >    * Returns:
> >    *
> >    * clk   - Clock is found and enabled
> > - * NULL  - clock is not found
> 
> This is still valid, right ?

No. Since this patch uses devm_clk_get_enabled() to get a clock, if the
pclk is not found, it returns -ENOENT (see of_parse_clkspec()).

Only the optional clock APIs (e.g., devm_clk_get_optional_enabled())
return a NULL pointer instead of -ENOENT when the clock is not found.

Thanks,
Leo

