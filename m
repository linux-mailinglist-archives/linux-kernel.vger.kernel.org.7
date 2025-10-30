Return-Path: <linux-kernel+bounces-877424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D82C1E149
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B325834D4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39123ABBE;
	Thu, 30 Oct 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e0D1lCYE"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAB6FC5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789629; cv=none; b=r6gSwOuzyQcqT6JDibAXtTEcu1yJDCiVfrVJ7XXkldt4NU9rwoevRMWiUGsxb43+AkNedBMOF9XBT7kTsd0g2eDesFeVLLyEk8fXPvfNG/XvCNS4IMj6AaLHazyzvyS9WY0kiKHmF9/XaF5odcvdFxf6n6jOVwt7d44FYnfxdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789629; c=relaxed/simple;
	bh=3gpLTmyFpc+JfGSe4RAcu0u/+obWLauvfquFj/3m+Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOTBs0lsJPN41o0Ph3Jt2r7kwUxaIIcbWszlTHUh4PVNiRkGscdZumQI/8XtdnEgwGY6l8euCXmYdIYP4y7+z9hGP8tQeAgp3zCwPuJuBUZmP7s0YP3mJac9YVjkGbnwNTtD9LYulqQ7do9KxyXbOUpcehvkHcNPtIQZrJ/GP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e0D1lCYE; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761789618; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=tnDygJTj35NeJIA2of2oglKX1I1n/+8UrGE1eV1fK3s=;
	b=e0D1lCYEftmZyYeFOYUbQvDvjVMniGL7dtZWE5ZMgBsCap3obY4iq1qsfRFJs7B6yNneswLoNHtnleMeiYpdqtsINBaJaI/QFDVCfe+9kHvVDYLPc1LdYqY4R7vFXjn4sFMXLmClWxKBllQ89kzBZEqyIR+5eIBbiSEoCDkcM5E=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrHtb4v_1761789617 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 10:00:17 +0800
Date: Thu, 30 Oct 2025 10:00:15 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/6] panic: sys_info: Capture si_bits_global before
 iterating over it
Message-ID: <aQLGr25DrvA62uDH@U-2FWC9VHC-2323.local>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029111202.3217870-3-andriy.shevchenko@linux.intel.com>

On Wed, Oct 29, 2025 at 12:07:36PM +0100, Andy Shevchenko wrote:
> The for-loop might re-read the content of the memory the si_bits_global
> points to on each iteration. Instead, just capture it for the sake of
> consistency and use that instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks!

