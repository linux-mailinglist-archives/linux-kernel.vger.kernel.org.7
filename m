Return-Path: <linux-kernel+bounces-802517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83DB4530A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14041B203BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9B289824;
	Fri,  5 Sep 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m1PORwTq"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590F272E72;
	Fri,  5 Sep 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063981; cv=none; b=X+a1foe9EY1ODAhvMf0Po7HJCDNLTPaE5WV/Yu2XqcCcCxll3+7wijk6wT9SOLGQH0H2IDhV9TZHUzrTk3BSVybaJ3suN2EAEVW9ffVkRnrijuRXNBYeHQEbty7+m/ysioPKpHMBT1YEs4fBfS+0oVuS24E5BwiLARSX9x/KT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063981; c=relaxed/simple;
	bh=nOXqfCWmN5V41agEEtvIimfepPpb3P+Yh9dklxlQJFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMcj+vcirUoPAXjV3jvnUz986zXW0MWNTKPWUYiyhHKNaEKstYwkLNDlxOT7nIgVY4yuwyFYDMFfoSWoXeJgP/9QbAvToX49/SWgK56Hq1xKb8rchAI7yZn2iwHDeUBo7m0CnCWoqGcZhdGtD8OPyfhx4K3GXJlNRv9f+8j2Mxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m1PORwTq; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=nOXqfCWmN5V41agEEtvIimfepPpb3P+Yh9dklxlQJFY=; b=m1PORwTqSEuHSqXJsATOHKvBAf
	6BNrLRhnvLgks1uTdOPcubsBVsYX3Fg3f+rnDxpdVS4QPex38Wyz4AWI/6jxQaQ1wDIU7/0HVNT8q
	jhNUO8rkU5/mayuTVA3DJHnkKxnD0KuzmbH1VlyPNMcJ7feEk6ADkEgMrfP+mbPNi55kfdbHCs6Vi
	2ndkqVFI752kYWgjQC8/ZqcuaQ8DzsTZobFbltiKN1joKNsyIEfBKJxxEw5uTbmr4f1BsxCeDb6GT
	RfyIulMW/oCalJQVZujrpm0IGaW9W09HIZJY6ah3QIygwFhLYvu5FwnHXCa1ZC8eoClIi6kF3Z6q7
	goxFdS7g==;
Received: from i53875bb6.versanet.de ([83.135.91.182] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uuSbO-0005d9-Gg; Fri, 05 Sep 2025 11:19:26 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kaison Deng <dkx@t-chip.com.cn>
Cc: Wayne Chou <zxf@t-chip.com.cn>, Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 FUKAUMI Naoki <naoki@radxa.com>, Peter Robinson <pbrobinson@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kaison Deng <dkx@t-chip.com.cn>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Add devicetree for the ROC-RK3588-RT
Date: Fri, 05 Sep 2025 11:19:25 +0200
Message-ID: <2744084.BddDVKsqQX@diego>
In-Reply-To: <20250905090115.718622-1-dkx@t-chip.com.cn>
References: <20250905090115.718622-1-dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Freitag, 5. September 2025, 11:01:15 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Kaison Deng:
> The Firefly ROC-RK3588-RT is RK3588 based SBC featuring:

On the webpage it is unclear about the soc, both rk3588 and rk3588s are
mentioned?

https://en.t-firefly.com/product/industry/rocrk3588rt

>=20
> - TF card slot
> - NVME 2242 socket
> - 1x USB 3.0 Port, 1x USB 2.0 Port, 1x Typec Port
> - 1x HDMI 2.1 out, 1x HDMI 2.0 out
> - 2x Gigabit Ethernet, 1x 2.5G Ethernet
> - M.2 E-KEY for Extended WiFI and Bluetoolh
> - ES8388 on-board sound codec - jack in/out
> - RTC
> - LED: WORK, DIY
> - BTB connector for PCie, UART, USB, CAN, SARADC, GPIO
>=20
> Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>

you definitly need a 2nd patch adding an entry to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/arm/rockchip.yaml

The rest looked pretty good on a short glance :-)

Heiko



