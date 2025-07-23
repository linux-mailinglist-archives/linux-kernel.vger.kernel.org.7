Return-Path: <linux-kernel+bounces-742302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F4B0EFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821AD3AC648
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8228B7C9;
	Wed, 23 Jul 2025 10:24:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6A277C9E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266240; cv=none; b=DtNLZ2zVJY4qEeJOq/p+LXKDOd9/XGCqweP7gSEmSSxo+1wXSFdcHRG/rE5lJm5dB5r41ajPWvz4mZdxhiZJZCl6T1rygpp1xeJsB+rflKmR9sLc27/IlmNjxhsJ+5KWMbLPqYLJqAmunBe7BTjeJOWpSla2gF6rJas6q9p3yGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266240; c=relaxed/simple;
	bh=k2N2kXKbG4db75Hpml+LtVoswRkcOT3xjDvro7B2Gr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8Y2WKsQfYNDk0awrH/of6ZlOttBGcVONq9fG5ahsPC4Wnz1s0cNQeFou5vatAdWd4YST3D1xlSFhGRWqXeZhUXckIIK5Y3RhpFATGc2e9B8kHlgn5Ufrll5LbRpdqansCqPQgluI0FHRTKIVuqj9kM5rzZI48Eag8cKmygLIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE35A22C7;
	Wed, 23 Jul 2025 03:23:51 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DAFB3F5A1;
	Wed, 23 Jul 2025 03:23:57 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:23:55 +0100
From: Leo Yan <leo.yan@arm.com>
To: hejunhao <hejunhao3@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] coresight: Appropriately disable programming
 clocks
Message-ID: <20250723102355.GJ3137075@e132581.arm.com>
References: <20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com>
 <20250627-arm_cs_fix_clock_v4-v4-4-0ce0009c38f8@arm.com>
 <daece566-2cca-71dd-d21a-80dadad2c71b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daece566-2cca-71dd-d21a-80dadad2c71b@huawei.com>

Hi,

On Mon, Jul 21, 2025 at 10:08:27PM +0800, hejunhao wrote:
> On 2025/6/27 19:51, Leo Yan wrote:
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 4ac65c68bbf44b98db22c3dad2d83a224ce5278e..dd2b4cc7a2b70cf060a3207548fe80e3824c489f 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -480,26 +480,16 @@ static inline bool is_coresight_device(void __iomem *base)
> >    * Returns:
> >    *
> >    * clk   - Clock is found and enabled
> > - * NULL  - clock is not found
> >    * ERROR - Clock is found but failed to enable
> >    */
> >   static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
> >   {
> >   	struct clk *pclk;
> > -	int ret;
> > -	pclk = clk_get(dev, "apb_pclk");
> > -	if (IS_ERR(pclk)) {
> > -		pclk = clk_get(dev, "apb");
> > -		if (IS_ERR(pclk))
> > -			return NULL;
> Hi,
> 
> Here, the function returns NULL, but the caller uses IS_ERR() to check the
> function return value.
> Yes, this patch has already been fixed this, and should we split this fix
> into a separate patch?

I am not sure if I understand this question correctly.

Are you suggesting that we should use IS_ERR_OR_NULL() instead of
IS_ERR() to check the returned clock pointer?

If so, the answer is that we should not change it. As Suzuki mentioned,
we need to tolerate the absence of pclk in the ACPI case. So keep using
IS_ERR() is the right thing to do.

Thanks,
Leo

