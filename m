Return-Path: <linux-kernel+bounces-877434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3ECC1E1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60872189B792
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9C2FD675;
	Thu, 30 Oct 2025 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lzLRUohi"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA32FC02F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790276; cv=none; b=uQrto5RWggEwcZDpiBjPjoOKTSlApkciVxBoEzNkODZkEhO0BSdqSvdoSBgHyrO087OJ6vNH+NvLbZqJcHB4x8Us8JMtZTKswpwyD9kfmcZ2EaFrLPi1JU0L+hQfk4XEBN5Izhg/KqsLyokE4cLHZDN41bUT5lQZG3KJjUtOYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790276; c=relaxed/simple;
	bh=LKXjtkkjzVKH9NxlXx87xpWpSKOG8BnVoJpQ4WW2FXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro2jpbXkArjY6dY88BCrixkOaG7KC0L4hRW56QkVURUQbjYmEL0iJidCLKoVXWNStMsISkCtYliqp6yS2g3EWkJDcgilPRkrZDXAzYkvPHm3ulZjRSMjZiSZyPOmFin6qfIpHsePShaWCh+SjPxoCyZQXz/CcrWcoasEHa/oRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lzLRUohi; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761790270; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=BKC1+VCpxRdu2kzZyR0H6DihwcU5VWh5kPxCG/Fr17A=;
	b=lzLRUohi9vYFplyZQii25bQULlXwmnQwUX7fcWsbKmJJyFiitzb1oLuqGTKfdhXAEXPulLsNIqqDoKCPRn4mnUFG8M9d8RKAA70ALxaHUFNBvBNxB2csN5rgKbOBs/+uRTds8q2D1NZoHEb9bGfRkaQwCekbVR5ECV0MtSngEFo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrI6eoI_1761790269 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 10:11:09 +0800
Date: Thu, 30 Oct 2025 10:11:07 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 5/6] panic: sys_info: Deduplicate local variable
 'table; assignments
Message-ID: <aQLJOzp_h-zZntru@U-2FWC9VHC-2323.local>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029111202.3217870-7-andriy.shevchenko@linux.intel.com>

On Wed, Oct 29, 2025 at 12:07:40PM +0100, Andy Shevchenko wrote:
> The both handlers use the local 'table' variable and assign
> the same data to it, deduplicate that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks!

