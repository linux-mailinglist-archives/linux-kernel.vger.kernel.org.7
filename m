Return-Path: <linux-kernel+bounces-779482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A3B2F4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AC6173DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1332DBF73;
	Thu, 21 Aug 2025 09:53:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE322D97AF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770004; cv=none; b=QhOjqg4NwMkUSjAd0BgRwgauuolSWHVd8X+f73hKvwvZ7b55gi08+UUHc1t8/U1diwzc8cIh2685Jb0nq0Jav0AIkDuNIoluyuVu/ZR7yT7nRHeJOvNNEYIFaNH5jVEZoOTUGS+k5Z1eMyM5DnnVBYyCD6eV89o2OLDdOTsEzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770004; c=relaxed/simple;
	bh=BD0onsfXqVtd8Pnm14xrc8HPfcuveoNaHLgQn1mnH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7+s9QDKKcknbXgjUyLqxRP56x+j303J0/D1lRpHXM+I1mQSQqwDcvPI8MDAMY2yAFQQ+eTkBlpl5INi/8jcjcKP/hM4GRfUpxSiUPiOYcqA5s7XrtW1E19nLvi4xx69Ld+f601mruuX6Zi8cm3BO8J6PJmFTt1SvlE7C2SjNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF189152B;
	Thu, 21 Aug 2025 02:53:13 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11793F63F;
	Thu, 21 Aug 2025 02:53:20 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:53:18 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: <cristian.marussi@arm.com>, <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: arm_mhuv3: Remove dev_err_probe() if error is
 -ENOMEM
Message-ID: <aKbsjmEnXIOka7QM@bogus>
References: <20250821093253.559809-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821093253.559809-1-zhao.xichao@vivo.com>

On Thu, Aug 21, 2025 at 05:32:53PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 

While I understand that it doesn't print the message for ENOMEM,

	grep dev_err_probe.*ENOMEM | wc -l

gave be 80 results, so not keen in just getting rid of one instance only.
No strong objection either if the subsystem maintainer prefers it this way.

-- 
Regards,
Sudeep

