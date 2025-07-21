Return-Path: <linux-kernel+bounces-739388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F2B0C5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2803B26A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA992D5A0C;
	Mon, 21 Jul 2025 14:00:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2A2D8DD6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106402; cv=none; b=aHy1YuUNVCQd7hiQHI4RjBLUuKBExIbYqEvpPRTP1QsEljSqSjEyrYPPLRgohvel2NuR+7aoxgYpmBAIbRQiZ5K9hMHoV4iK1Ylhf67ATftv5pTNY0tW0Iw+0Ka6dPGgfYYhDTyY2bkttK+Arc8PP4TvbrTM0FFWUTCnhYtYwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106402; c=relaxed/simple;
	bh=QRro4iNQid9d7xN7JufpQ6+idVYr9FxuniHrLYzKwz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdAuUv3sSEK8VnUBtOHRT2MBq+lbUAK6S2Pbz4bKKqN6UY0IJBLkmpmlVSjfcQLbhWKchGR7mXHPnWFI/CjtHAHVb22Zaf5KgX+VNuUQv0KQ/wLsxvF1dNlmUVFZnwIfS5cyMcHT8YUGA9g7WV04s0Ve4k0jv3qwmy16hKv/ojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D99DC153B;
	Mon, 21 Jul 2025 06:59:54 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CA5A3F66E;
	Mon, 21 Jul 2025 07:00:00 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:59:58 +0100
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
Message-ID: <20250721135958.GE3137075@e132581.arm.com>
References: <20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com>
 <20250627-arm_cs_fix_clock_v4-v4-4-0ce0009c38f8@arm.com>
 <5a5f1355-563d-498a-9dec-3479a257b3e6@arm.com>
 <20250721104834.GC3137075@e132581.arm.com>
 <607c03a2-267c-46e6-a7fa-e733c1970e60@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607c03a2-267c-46e6-a7fa-e733c1970e60@arm.com>

On Mon, Jul 21, 2025 at 12:40:38PM +0100, Suzuki Kuruppassery Poulose wrote:
> On 21/07/2025 11:48, Leo Yan wrote:
> > On Mon, Jul 21, 2025 at 10:15:22AM +0100, Suzuki Kuruppassery Poulose wrote:
> > 
> > [...]
> > 
> > > > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > > > index 4ac65c68bbf44b98db22c3dad2d83a224ce5278e..dd2b4cc7a2b70cf060a3207548fe80e3824c489f 100644
> > > > --- a/include/linux/coresight.h
> > > > +++ b/include/linux/coresight.h
> > > > @@ -480,26 +480,16 @@ static inline bool is_coresight_device(void __iomem *base)
> > > >     * Returns:
> > > >     *
> > > >     * clk   - Clock is found and enabled
> > > > - * NULL  - clock is not found
> > > 
> > > This is still valid, right ?
> > 
> > No. Since this patch uses devm_clk_get_enabled() to get a clock, if the
> > pclk is not found, it returns -ENOENT (see of_parse_clkspec()).
> > 
> > Only the optional clock APIs (e.g., devm_clk_get_optional_enabled())
> > return a NULL pointer instead of -ENOENT when the clock is not found.
> 
> This will break ACPI based systems, as we may not have a "pclk" described
> for them. We should be able to tolerate "no pclk"

Get it. How about change the code like below?

  static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
  {
      struct clk *pclk;

      pclk = devm_clk_get_enabled(dev, "apb_pclk");
      if (IS_ERR(pclk))
          pclk = devm_clk_get_enabled(dev, "apb");

      /* Tolerate no pclk for ACPI device */
      if ((pclk == ERR_PTR(-ENOENT)) && has_acpi_companion(dev))
          return NULL;

      return pclk;
  }

