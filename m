Return-Path: <linux-kernel+bounces-727854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96342B020A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7341CA4E35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE912ED858;
	Fri, 11 Jul 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BtF4wEvN"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A52EA484
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248547; cv=none; b=adT5+1fumUY85xg2RXgc6O3U96MwWICRQ63USR14Syo637v3s7c1PsIUZhKUSykpj0tEk+2n2iuakSBMc5IRQeRInG9R9M0OavzVOY42n1h3NWSSOm+7op6hvWFQNie62ZHkHXL3NJxiVYU4t2uq3YulAG8cfv4aexh611CS7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248547; c=relaxed/simple;
	bh=VQDZpUiX0fAbrf8rpXsOWh2+2CZcHLjRlxsFGdY98kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WecQEjvLdoPckx6jSkj/D0bumUH+a3ywXJLoO6q3XhZk4pOs191HZGSJuT8BKWVk4B8zo99dLUx8gNUwnqJnDNOef75oJjiSWjpnANFeIq+qN7zEj/R33A0tcQIkX0lIBFLIlsYjeatATDK+u9yvg8+H/IUVDL020DSKdgO/Tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BtF4wEvN; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752248535; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=xmqBJ3ARjf+VSR83mqrdEMU1yM+puhnflfqp9dGiiNU=;
	b=BtF4wEvNT2MQxpav7EKkGo/EEurgwfAmQlUiPskC1/QKVRnX9ZOws4nES6XC1annk3neA20V4FkjTKhbah+kMzrjiT41mDEQZR8U/LSQ2AO2zLE8fSKGFEM/B+MUYWXoDKGdwGK65lalW+7wivQme5cUPy5KsUuu0RiyjzvSdj8=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WihRFKS_1752248533 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 23:42:14 +0800
Date: Fri, 11 Jul 2025 23:42:13 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [rft, PATCH v1 0/7] panic: sys_info: Refactor and fix a
 compilation issue
Message-ID: <aHEw1U8x5WfGaMsC@U-2FWC9VHC-2323.local>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <aHD_1QopiVCU-vzh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHD_1QopiVCU-vzh@smile.fi.intel.com>

On Fri, Jul 11, 2025 at 03:13:09PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 12:51:06PM +0300, Andy Shevchenko wrote:
> > While targeting the compilation issue due to dangling variable,
> > I have noticed more opportunities for refactoring that helps to
> > avoid above mentioned compilation issue and make code cleaner in
> > general. Please, give it a try.
> > 
> > I put a revert as the first patch of the previous solution, but I believe
> > the previous solution may be pulled out without a problem.
> 
> Btw, I can try to pop the fix upper in the series, but since this
> whole feature was only a few days old, I propose to drop it completely
> for now and start again. Please, Cc me for the review.

Can we just take your fix and nice cleanups? Do we really need to drop
the whole series? My gcc haven't raised warnings in the past several
versions, and I will install clang for more complete compiling test
beside functional test for future patches.

Anyway I don't think it has fundamental blocking issue, but I'm fine
if you insist to do so.

Thanks,
Feng

> -- 
> With Best Regards,
> Andy Shevchenko
> 

