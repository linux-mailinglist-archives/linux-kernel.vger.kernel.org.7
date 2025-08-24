Return-Path: <linux-kernel+bounces-783566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6869EB32F17
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6071B22F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52E275846;
	Sun, 24 Aug 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ofw47oKN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C712CD88;
	Sun, 24 Aug 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032895; cv=none; b=BAHK7AA59P7zJ8owOh+t/lfBXZriQY4BHnBUsKLmisO04tQtI/5AUim70qTqRTVsRBynXPquUJvKGzlxzMeHvWpgNdoRiXKYV1X2kE9LIrZhqgkWGiksTBUQqO15H/Oy9CEv58p4RwGESAYnr9Vm2kYH40q1q6ukcgQUuNlmd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032895; c=relaxed/simple;
	bh=g3Y2valtKVkcwvvqF3bMxQPiKmIwiRlgM8RAXiDGY1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo+6yNqUPMKJFE2grqkmzYhFLNuHjMnSHMfUoy8IATT18JTWpIqhXWpn3v6BYSUpdlBtoDijGtiIhEouAuu713322cjR+XkJ3komcrzV3xMGksKMtfpgzOeIIeqg/6E7az51oVc5ohr1f/TIH4ADNk4MUse+7vKZTw5r71y+zYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ofw47oKN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=EwTgys468jql8rVpPk9a/paDP+nmzSD0YQvFFWl46ow=; b=ofw47oKNMMAVQYH3GBtMoOvqJk
	GokgYOKqYabSnX/9F65crfkeNIdU558Yfi4SUxG19HW6uCh12I/pFOyNlv7tPEbXmWSE/c9hsZR2K
	yFDAQozCUytnXBB9ZNTD6P4YCKBJo3jTgXvV5l2jQsJF/OjkLhrNzetQdSpOfFW9Tornpj0Sqesc/
	MXSjv3j03tF/B/CSliwuYN9GJMmmjJg3Bv84kd/jhgo5sNSVRxwXWR+5Yc+Kish7k6OgkINoRqMM+
	1iQY2VXS/fGtvH6FCan/NKwjDor+3sH016JEbSrtSpkhY0gNhJ477LoFgsARDwfhUltIT2Hdx7dwP
	hE02SP9Q==;
Received: from [62.245.128.201] (helo=phil.wifi.munich-airport.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq8N5-0005H4-W0; Sun, 24 Aug 2025 12:54:48 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexey Charkov <alchark@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pavel Zhovner <pavel@flipperdevices.com>
Subject: Re: [PATCH 0/3] arm64: dts: rockchip: Enable RTC, WiFi and Bluetooth on RK3576 EVB1
Date: Sun, 24 Aug 2025 12:54:39 +0200
Message-ID: <175603280232.3445205.16083508502929513202.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
References: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Aug 2025 00:30:22 +0400, Alexey Charkov wrote:
> Rockchip RK3576 EVB1 boards follow the usual Rockchip design pattern
> with the I2C connected RTC chip feeding a 32 kHz LPO clock to the
> onboard Ampak AP6275P combo WiFi/BT module. In this case the WiFi
> part is connected by a PCIe link and BT over UART.
> 
> Add required DT nodes to enable them.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Add RTC on rk3576-evb1-v10
      commit: 0adaae77862932a19cc14c086d7fd15ec0ef7703
[2/3] arm64: dts: rockchip: Add WiFi on rk3576-evb1-v10
      commit: ebf8183ad08afc4fcabe1379a5098354829d950d
[3/3] arm64: dts: rockchip: Add Bluetooth on rk3576-evb1-v10
      commit: 34f7620912bb0f881a23dfea529e69fd2e8fdcf2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

