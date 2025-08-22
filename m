Return-Path: <linux-kernel+bounces-781021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F588B30C68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FA77B597A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67E289E13;
	Fri, 22 Aug 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="b+F0ocoU"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E5271447;
	Fri, 22 Aug 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832612; cv=none; b=BrqSUzsB4QYxvIChyrvlBEAFAOqadF3Yb20RHMnyujfDo5jJreVKWcqYCSLL3KJnXEBcK9MYId3D+LP6B+D01VSPOR6x3FyZf36d0DSNe70FhBWLZZnIwsVVVBTdeqe/RI/Ef57rBmxEJ66EAmW2EEja2rUnfrL+5ImHzyb65s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832612; c=relaxed/simple;
	bh=L1H0EdWPh644U3jURwUkeyJqGTXjRwksAEYYAUbMyPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzVZRajRtbS+sFiFvBoYWxejRuy1uxRn7V1wwkQYMejDUtiKiX+dcbbIHK6mCffJr0LOxFeI+BuQBd7I4JXxAsfN/DYu3NaSueN0mxabhLiJvQ3auozDrhXwYGBgQ/oGf46mtha+G3hBDGkYvz26rx+SX8ScNtcMz0HNM4q9e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=b+F0ocoU; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9Y5z/0H5fJJc4dRc+K5nieP3CrPw2M6u68DtSwXj2A4=;
	b=b+F0ocoUgiT/Md9GnxolGWs1nmad/3q4h/fpptL8K/uxxdKpuCEVVd7Jyw0QrW
	AhiZgN3GOfcCs03MhJjaRisD6xWaQLtDjGKhMJwjUUeiXoXP9lWUVNUnDxYwCXmI
	g/3N+7FCo/3KtpM1TUL48BGbJyfKpCotJR5oefyBgdfjQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnHvf74KdoHr0kAw--.6236S3;
	Fri, 22 Aug 2025 11:16:12 +0800 (CST)
Date: Fri, 22 Aug 2025 11:16:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] ls1021 DT fixes
Message-ID: <aKfg-nqgbsBX-i2y@dragon>
References: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgDnHvf74KdoHr0kAw--.6236S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4rZrW8Gr1rWw13uF1kAFb_yoWxZwc_G3
	ZxG3WxAr1UC3yjyr45Was2vF9rKr4q9r43GFy3CrnxJF9xKF43Was0y3W5uF1UZFZavr9r
	Jrs5CryjqryavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjahF7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNB174Gin4P0QdwAA3H

On Fri, Jul 25, 2025 at 08:13:25AM +0200, Alexander Stein wrote:
> Alexander Stein (10):
>   ARM: dts: ls1021a: Fix gic node unit address
>   ARM: dts: ls1021a: Fix qspi node unit address
>   ARM: dts: ls1021a: Fix sai DMA order
>   ARM: dts: ls1021a: Fix FTM node
>   ARM: dts: ls1021a: Add reg property to enet nodes
>   ARM: dts: ls1021a: Remove superfluous address and size cells for
>     queue-group
>   ARM: dts: ls1021a: remove undocumented 'big-endian' for
>     memory-controller node
>   ARM: dts: ls1021a: Fix watchdog node
>   ARM: dts: ls1021a: remove property 'snps,host-vbus-glitches'
>   ARM: dts: ls1021a: remove undocumented 'big-endian' for
>     memory-controller node

Applied all, thanks!


