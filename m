Return-Path: <linux-kernel+bounces-811727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9DB52D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3D13A98C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264C12E9753;
	Thu, 11 Sep 2025 09:21:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD92E8E17
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582513; cv=none; b=aWY8qgBBlX09ZmF46ICndXY+MNEsnxuWMM9ey0tqdAampbZGyqg9QfDWHbUmR4MTHqMZm0868Hg1NnzwfsgNbtOCeVu+XBnhiKYi8z2+E2fMTpDNYU14m9YVM1/iAx1wgeFKPeUKfmho3cf94fb9rC0G6+PAPp6+CcwJyGgKc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582513; c=relaxed/simple;
	bh=fwnz560nzzMxV6DqBoKz/DjGY2+IqAi0Yq75U8aVUTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St/QoWowtXzBApesj0FXVjHWwvCbgzur+y0/argqjTICPc8wM2gLVWHpTGHGdXLDNzmsrI5y1Ar7DPJwVOuaYUtEagNcsFd8upchdskgK3wEyHra9bSjaS0JjqPnzDxaBg7q52R7GrL4divrfD3gwX0zlroEgjqNmPYIvep30t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4064153B;
	Thu, 11 Sep 2025 02:21:42 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B51DB3F694;
	Thu, 11 Sep 2025 02:21:50 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:21:48 +0100
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mao Jinlong <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] coresight: Explicitly use the parent device
 handler
Message-ID: <20250911092148.GC12516@e132581.arm.com>
References: <20250512154108.23920-1-leo.yan@arm.com>
 <20250512154108.23920-4-leo.yan@arm.com>
 <64186261-3e65-45b5-a68c-8ec236a75f2f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64186261-3e65-45b5-a68c-8ec236a75f2f@arm.com>

On Thu, Sep 11, 2025 at 09:52:20AM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> > @@ -1393,7 +1397,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
> >   err_out:
> >   	/* Cleanup the connection information */
> > -	coresight_release_platform_data(NULL, desc->dev, desc->pdata);
> > +	coresight_release_platform_data(NULL, csdev->dev.parent, desc->pdata);
> 
> This may be problematic, as the csdev could be NULL ?

Indeed. I will drop this change in next version.

Thanks,
Leo

