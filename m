Return-Path: <linux-kernel+bounces-858434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923ABEAAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A2C1AA4B06
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C670296BBA;
	Fri, 17 Oct 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LjJoAxXp"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A9296BD6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718104; cv=none; b=iXaQ7Q1fLA0WusXBi5ZQgo+mb/9NKrE9KLPOMvv3ehSboImgPjVDtr8lGyB0BpmovkZy37Z0MnboiaL9NbIbOU1Ml1A6PzyYk+p46ha1GGVkTMAvkFi6dSRrDp5D7cAHYyG3+kcW3EGVCbxEYVJRHpovOzhGaxb7MpyCh0ZqBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718104; c=relaxed/simple;
	bh=RRTwAZLk/2qwdrsLFWGGbVFAHrlDdK2F4Drz9CQFSks=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Z2RBnVPc1DSzkWoFCDxJLwYU9bmvWQUZEE/1TLZ/7kEWmBgkB2p908gaFL/8Lm9aitoBA65Pr7bipGjggkMx+20cv/HY5GM1X6SNRVc8++wE2XZMF5iFzS2EI9zYMhcKnGfpGH4WXqUsNA8J5Xw7mkfM+tXfaTLpEN3Y4LxjLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LjJoAxXp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EDCE3C041F9;
	Fri, 17 Oct 2025 16:21:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 439F4606DB;
	Fri, 17 Oct 2025 16:21:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01A30102F2326;
	Fri, 17 Oct 2025 18:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760718100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M92WI+PGFdvoEo5x/+VF/yQMrWADVhb1nigV4QXWseo=;
	b=LjJoAxXpFtx6zaAAFyn0jnPHV3jwcS75RTNQnQL3aSoDj+iA6M0I9VAo4P4cX9+vv6t2mX
	sGRWUlywn6/2wGFoIxFhaU2SJ2Up7Sw+t0yF9IsNRkbmOsKKHqkXydQDPtuQT2lzbzrJUW
	LLur9aDt+drjnUsk28si/PDdwcMHgJO0mQ9ekTEq00L2TlD2iRUZg1HiJ91lyrJNwpo4v0
	zUoEB/Kfhh8MdhzzgCSWiwGKNcF8EboAAk29M9jQCljnY4BwiGwd/36r/F38tVM8Hn33aj
	VQ9/1jeFuf/XHTBgVIhAycea1PnNZGDOu/cg/HUwfsVc23iqgSwG6u8rOWTRhg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 18:21:35 +0200
Message-Id: <DDKQH2MIHZ2S.2MPJCNHXMIT4U@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Naresh Kamboju"
 <naresh.kamboju@linaro.org>, <dri-devel@lists.freedesktop.org>, "open list"
 <linux-kernel@vger.kernel.org>, <lkft-triage@lists.linaro.org>, "Linux
 Regressions" <regressions@lists.linux.dev>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Simona Vetter"
 <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, "Dan Carpenter"
 <dan.carpenter@linaro.org>, "Anders Roxell" <anders.roxell@linaro.org>,
 "Ben Copeland" <benjamin.copeland@linaro.org>
Subject: Re: next-20251014: Internal error: Oops:
 drm_bridge_connector_hdmi_cec_init drmm_connector_hdmi_cec_register
X-Mailer: aerc 0.20.1
References: <CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com> <CA+G9fYv_mGoDzFv33v7Y5+6yz6z=xp9FJRiFUBYDapvE_rrBXA@mail.gmail.com> <DDJSBQRQJTMZ.X1W4I5YOURPK@bootlin.com>
In-Reply-To: <DDJSBQRQJTMZ.X1W4I5YOURPK@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Thu Oct 16, 2025 at 3:36 PM CEST, Luca Ceresoli wrote:
> Hello Naresh,
>
> On Thu Oct 16, 2025 at 12:52 PM CEST, Naresh Kamboju wrote:
>> On Thu, 16 Oct 2025 at 16:14, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
>>>
>>> While booting and loading kernel modules on dragonboard 410c board
>>> with Linux next
>>> kernel next-20251014 and next-20251015 the following crash noticed,
>>>
>>> First seen on next-20251014
>>> Good: next-20251013
>>> Bad:  next-20251014
>>>
>>> Regression Analysis:
>>> - New regression? yes
>>> - Reproducibility? yes
>>>
>>> Boot regressions: next-20251014: Internal error: Oops:
>>> drm_bridge_connector_hdmi_cec_init drmm_connector_hdmi_cec_register
>
> Thanks for the report.
>
> This looks like the same issue reported here:
> https://lore.kernel.org/all/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.=
com/
>
> I'm writing a fix right now, will send it today if all goes well.

Here's the fixed version:
https://lore.kernel.org/lkml/20251017-drm-bridge-alloc-getput-bridge-connec=
tor-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

