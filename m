Return-Path: <linux-kernel+bounces-804987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3528DB482AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D47554E052B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299CC1F7569;
	Mon,  8 Sep 2025 02:43:03 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F97AD51;
	Mon,  8 Sep 2025 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757299382; cv=none; b=HjqptLBUO58L7X1KYP1wo3N/8ysnfAfKpjf9cq38I4DX1s6/r5J0FWv4sn6wBmn7SHDoFh3uhaMdcEyGHhsrDUtzWpqEgWxcfCr+4NEhXv3Uyt6r7Jz22QFZGo8Ru7UrcyjwLYNGtDL18QPldfbVOdcuiQvQw+dzGILIRI07vv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757299382; c=relaxed/simple;
	bh=uFP29cNly6YMrOfoT9o+KWSTBUwmoAs9nNafqPy7vMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Avii3psGDxBiLI7Llx6vRLaPwzL9UZnR82u5tJCE8k3YYhfxasopJBxukvEvn8UWWajcNIko3ESROHwPBHhRgidqgAwmJ0L6Uyuu5pCIX0GuH1K1r/2GnjjbsRCvrcaWcy7UcXF2Mr2GhgTTaZqoCkNufJqEyPXh3SbtzkjOfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: zesmtpgz8t1757299367t8a4b77a0
X-QQ-Originating-IP: kDY0/8+9nALfx1XqnlgO5eSHKtE512wTM2GGkuQcJPg=
Received: from localhost.localdomain ( [183.51.121.90])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Sep 2025 10:42:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9255924790218013141
EX-QQ-RecipientCnt: 15
From: Kaison Deng <dkx@t-chip.com.cn>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Wayne Chou <zxf@t-chip.com.cn>,
	Kaison Deng <dkx@t-chip.com.cn>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the ROC-RK3588-RT
Date: Mon,  8 Sep 2025 10:42:45 +0800
Message-Id: <20250908024245.1005875-1-dkx@t-chip.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2744084.BddDVKsqQX@diego>
References: <2744084.BddDVKsqQX@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NY5+brHrxRqv0L0Vu+D4vlcTgkGN1Y20P8bYZwEZYKwhjPgUwPE3Q9Bg
	L4aZOQLwui7Xb5gUMRR6JFAPT7Huu/s55mC5eAjwPENaQHhB+tdFg8IMQLWgKgCzTfNz6eQ
	p7yjUI5L/TUN81zE1pJqWYhJKkkGg+8VzpFsYHQ7RiqnuZpzrGEFArN1J2Pg6Wupu3Ai34t
	z5SwQSiTczErbFIDnDSyeebKC0dze8hHXTklaJEA+EYimWSY3VoCkrfMrC0yn3TrVrFVVVv
	VU8x2yulKn8nhQO6HBJozNBC2j8xPuxYDYsZBOHqWPw73i4xW8xbpuJmD5pULzfqj2Sb2u8
	b1O+r5HarGdtBjBs9s5zHlFK6S7MVALM9rrBUvKA37e5g9EE2HSp+FL5SlKw5hZsKTAJyIc
	O+yiwIvxmZvKVXm47IWby/NY/FSQKiCzQAyf9NUgaaMHbmQjykOGxA5mK7NwpArSBDUhhnO
	+wQiBtqaHE4nWSnJsB3cwtlc1wO2aOjMmvCTN1sP7NVsbw2huP/L5hINiNI8XhGCUQ80btl
	uezuAGH+n+A8Vt2yGKlR5H6M8nhJpexi3rdpMMUATmP8O/1WoNPzFIBVN9RsDCztDOGK9E5
	NiZt14frw0RDEkSYIz18/Ap2Rqos5QFR5De6J4qoy1KUva3Bux0HsDOhFFFyY87Zb+DPGpz
	u+F5ovGEWBz3hfCJX3L3fHGXu637vIbKDimWHhofb628LgItb95zxXacF9iWYPNO/z/jJF2
	2vENa20uS1vgdLFNrFHwpYRb4Z7ElxK0R3lgJTDbCY7naWjL+UmiE6YhOC1zkuoCbSaxUic
	77XllQjUA/4geWb32x/4WPqvv5mFtodN2Fr2jBwfDrgoPVy1oAkHEcDmAgTg6ng0fPQ5OzT
	VUKEF4gbvWrHy1UVxPNtHe1ds6GQAOAt8xY4VruCA9i8dNMVslazZCYOriUTwjuxlwKnvup
	RphnJQztmr2LIqGm4HZ2yP5r8ZVRY4GgIP4jFCConJSz2+wd3HSIqK3Z53cr8A5ewcC6IX/
	NfPJLuMx6a8B3WMoojjdOptcEPsHOgu5ALnkgPXnWtyDSCUTVTC4klB7uz7TSibiatLO7pa
	bB2Dy9pRlR/aJdCZntzSNDM3jiE8BmdcLcxThWUTOTch9D0h23xe2hJ/MQ4/RQfIehBzyQO
	5pS8bsgCM8xGK3nfbTH6+MG9Vw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Hi,

On Fri, 2025-09-05 at 11:19 +0200, Heiko Stübner wrote:
> Hi,
>
> Am Freitag, 5. September 2025, 11:01:15 Mitteleuropäische Sommerzeit
> schrieb Kaison Deng:
> > The Firefly ROC-RK3588-RT is RK3588 based SBC featuring:
>
> On the webpage it is unclear about the soc, both rk3588 and rk3588s
> are
> mentioned?
>
> https://en.t-firefly.com/product/industry/rocrk3588rt
>
Is rk3588. This webpage is incorrectly described, we will correct it.

> > - TF card slot
> > - NVME 2242 socket
> > - 1x USB 3.0 Port, 1x USB 2.0 Port, 1x Typec Port
> > - 1x HDMI 2.1 out, 1x HDMI 2.0 out
> > - 2x Gigabit Ethernet, 1x 2.5G Ethernet
> > - M.2 E-KEY for Extended WiFI and Bluetoolh
> > - ES8388 on-board sound codec - jack in/out
> > - RTC
> > - LED: WORK, DIY
> > - BTB connector for PCie, UART, USB, CAN, SARADC, GPIO
> >
> > Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
>
> you definitly need a 2nd patch adding an entry to
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
/Documentation/devicetree/bindings/arm/rockchip.yaml
>
Thanks for reminding, I will add a 2nd patch for him.

> The rest looked pretty good on a short glance :-)
>
> Heiko
>
>

Kaison

