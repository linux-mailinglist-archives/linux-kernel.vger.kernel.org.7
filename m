Return-Path: <linux-kernel+bounces-722848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CADAFDFB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6464A162A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7308126AA93;
	Wed,  9 Jul 2025 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N+PTKq0d"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB0191484
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040514; cv=none; b=OxpaFTosgKeteAb6pMuXhDtGkNIFrOTl0fY9eZw+WjmEKcbE5574Jo6yVIca1cZjlEDhQGxp5Mmzca+Ps8pfOgNOPHJY9/vpPztzYXC+A4NEP6EyvlLuo/s2DEmuG4u72CH27ZOm4HiWyfKWBAOwN8Hc1EtCBhks0zQX6xGd2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040514; c=relaxed/simple;
	bh=+ct3kvHBxH5MMUjJy8jOUDeR3RbsB40gIyFDI0DbikQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrRSB+5XMjtNuRaSOweL4/W/VsANUbZ91yoYzsmqG2TWLguTGCn9+3Gm4S2DFS5pTDwU0avRvNEtvk1d5euxFO3Gp9YAWTbFYfgN3NCokN72mteoPStGZeBAhx/GeuUMSyi/PdZRJIb/13Fbn6qVFtQXdEIS6fJ7/st0OTuXDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N+PTKq0d; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752040508; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AtmsbTFxBLE3ggp840g/o74/3MOXss/L8gwWoubJheQ=;
	b=N+PTKq0d/iaTmW/A+G+4LwVr3oUgrepZ6YmD8L2/5TgSPyt91+F6fzp5L72sNMrrSKFmdvzpsWCQ/opXbQ+AP8sZwJf6/etgSi5Hmqp/Oeb09Le5L0qyBUSghlQ+vLMIihnmsZRD1mCDVZlcMPUuPjpUzB+4jX7Dp3XKNSTlTrY=
Received: from 30.221.130.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiWaECA_1752040507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 13:55:08 +0800
Message-ID: <c7379b0e-ebe6-42d4-a779-7264e331335c@linux.alibaba.com>
Date: Wed, 9 Jul 2025 13:55:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: address D-cache aliasing
To: Jan Kiszka <jan.kiszka@siemens.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
 <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
 <bbe6cac3-7792-4d85-b5ec-124f7eec20c5@siemens.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <bbe6cac3-7792-4d85-b5ec-124f7eec20c5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/9 13:50, Jan Kiszka wrote:
> On 09.07.25 05:46, Gao Xiang wrote:

...

> 
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Please make sure to address stable versions as well once this is merged.
> I've so far only checked 6.12 (besides top of tree) where this applies
> as-is. Other versions likely need extra effort.

Yes, I will address them manually one-by-one.

Thanks,
Gao Xiang

> 
> Jan
> 


