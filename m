Return-Path: <linux-kernel+bounces-813388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE8BB5446E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F4A585434
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5142D5C8E;
	Fri, 12 Sep 2025 08:04:51 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7427279DB7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664291; cv=none; b=rTKUW56uzYVnwBWJAULuhoi6+HrjIQaJ18vU4AeheRJVFufTCWXWjXfZBzoUq9Mh0JHMeuy5ma6iB/ckwUyZy8WSKvK+pUS5r5vonMJulU/hrasJRH1y0mF+tqDOsY+wt3X7NMaysr35SkT3PK11xhip2I6WHHG2GyWgZIqRFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664291; c=relaxed/simple;
	bh=ydbovWkE7ig1v2vzS3j5URx9TJDy82rsnAtS/OcoS3Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F2P9veIWlJhAd0K5B53wVeeAQIpE43Vnp5B0E9iVE7nz6srwX4tuPCM4axE5ejt/6Wlw0KbjXHwg0E8ShBFJ1URm4ODjtLoO9XtwfvWR7KtNfoA+EEbREqab7S6FtTwmEPNPnTXRqrtUXblWutXfkDRK9e0AAk0uKxEHHhPgdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6C14F2BA98D;
	Fri, 12 Sep 2025 10:04:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9oQYwUgJsckZ; Fri, 12 Sep 2025 10:04:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1EA132B4F62;
	Fri, 12 Sep 2025 10:04:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TYWbwBhd_z1d; Fri, 12 Sep 2025 10:04:46 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id F04EC2B03C8;
	Fri, 12 Sep 2025 10:04:45 +0200 (CEST)
Date: Fri, 12 Sep 2025 10:04:45 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, leoyu <leoyu@mxic.com.tw>, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Message-ID: <579487457.27484.1757664285819.JavaMail.zimbra@nod.at>
In-Reply-To: <CAAyq3SZmuTPrEb4i7QR-4Gi6YWsLFGOGm9=a0UvLR5rMLiLxsA@mail.gmail.com>
References: <20250812051949.983040-1-linchengming884@gmail.com> <152133202.103367.1754981828821.JavaMail.zimbra@nod.at> <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com> <608935583.115196.1755171013804.JavaMail.zimbra@nod.at> <CAAyq3SZT67uwggdNX99qEc4bwSkUw2U=sCc6mon064D=f7oH=w@mail.gmail.com> <1899901955.27456.1757663848457.JavaMail.zimbra@nod.at> <CAAyq3SZmuTPrEb4i7QR-4Gi6YWsLFGOGm9=a0UvLR5rMLiLxsA@mail.gmail.com>
Subject: Re: [RFC] mtd: ubi: skip programming unused bits in ubi headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF141 (Linux)/8.8.12_GA_3809)
Thread-Topic: skip programming unused bits in ubi headers
Thread-Index: KYU+KBLIMEgyf12O7akTXDrRUQ7ZhQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Cheng Ming Lin" <linchengming884@gmail.com>
>> Thanks for the detailed answer!
>> So, yes let's apply this change.
>=20
> Sorry, I need to adjust the code a bit, since I just noticed my
> condition on vid_hdr shift was incorrect. I will send a v2 version.

I expected anyway that you'll send a non-RFC version of the patch. :)
Just in case, you ran ubi tests with various different nands?
nandsim can help.
Especially with and without subpage support.

Thanks,
//richard

