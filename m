Return-Path: <linux-kernel+bounces-883429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C51AC2D6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D5564EC35A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE231AF1B;
	Mon,  3 Nov 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2uSXDyw"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351F26F293
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190254; cv=none; b=XVIXvGqLF4geshp9cU6NvuGI0z3y7br+3ampxH4w6UtoRWOcrBVgAvb5f08DKxVdRYbipiHDOjtYYuj1pq2hxHECtQ1RkOibVwOTwaBPaqS/dw0klVTsvLA/tpFRusSMyQqHzPvFnDHHq0SE3xdJQPibi0BO1Y8z8kMJ2RXLqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190254; c=relaxed/simple;
	bh=ywlAt1IJoxSZZYbVK30qpv9Yk6Z0ceJZH3PSlVUHacw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ciZ3A2tTeskTdo1j/0NL/r33aveTFs/voNlGJL1bXnA+t6obV/kJugIgPd1bLHiGiA5HNDalXBTeWsDaf3gNu6g2LSdN8nMRMqrb4vkbKFAjhNKasSLXydMJVBcZeazzL+MuqUe2j7f/QnT4u+xDFQm0HI8YJtomdN36Tf+3nsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2uSXDyw; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso1360156b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190251; x=1762795051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kksmKNYVqd+uErs7CVztic7a4Xyw6TxrahAVbwRtSA=;
        b=V2uSXDyw7SFG25D2DP5SwFFyH8n38BFldmSSx/PHi4H+JlAf8qWc/G6M5HwFx5E6+C
         2GZprvb+MnqJPWpiI4ARUxlg12eigpEvVsinnP9RJP8xHykcA72XemEQtgiy4/ZAt+ra
         MYAc2dco6/kzmTscax/QaT87qxZLadk9WVDZVD4lboEPasjoiIPmLwdIlan0rJH5/OXN
         UjgNgMjdXZmBN+U2n+JJQPzsf9Ea/YGCBAWQUnT3ngQp7xPs99E2II+ibbIar2PMnMTt
         ZZlN3aRHknks1y0OSq8u5u4RnRywcdky6g3rIeWQMDbdmZlf9Enuqd04okruoE0M8v7A
         xlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190251; x=1762795051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kksmKNYVqd+uErs7CVztic7a4Xyw6TxrahAVbwRtSA=;
        b=GzXl/nm3OhULbaOUFJOgv0ZRp446OOknWCDM9dtZQ/pSNVJA2Ib3qGpYKMj5pTXXHW
         0E1FAyEyNeDP2iMNxwS3iKrWLzyCFskRYRXV7SE/hDFygwgJ7zdEuRI62EDdUdFCoK+B
         HNQXK9TiDkZ1Vg+crRTb6HYHk3ySS/aG8FUZJ1jnWWtaSMyf6ZaTNV3KYiIyz+3VyIZg
         WaR2XpJkehNAK78qnX4eBXxaVD/O2GNAzIHZRyjlOI/FUgQMA0rKMjnumAHMc89XWxID
         60iKpnBgt4ps+l8m68jryUUQXVFvtpiytKfFysakXIKWOUk28y07q3PC2DgavMa+WNAi
         btRg==
X-Forwarded-Encrypted: i=1; AJvYcCXX3lqnyrQX2KlHfSLCiIqw/DNYwXpAx2jzQg2H5yWUWA5S3O26Zgk00wWj6zl2MTqqdS0bFL4DzFYlA6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJnmgh96hbwY3jpZHRHIqUJhkW+3t00vLpXGtfHnp5KUg/4Pe
	RLVPj+SHA1J1wIDqZ1ZygGB8H6arX/ogVivx5I18d9ZoriBhNt8/udxV
X-Gm-Gg: ASbGnctVOlrDH3EFhXqTbr5FiFRb4erHIgmd/OHnq0RJ1UScx+ofJ5vgyW5SeQSTdX8
	zHF2XiUuoEiGBc9gX6QU81UqzI4KFdB9O86N1ygdYI1Rl22EgaTXp6PiyKGZqKXsBXFcmP1pAFw
	4Q9KKGFEoNqS7dfGw1KyNmW29uiP3oEh2MyP2CXVKp2upIigDxZX+nj/IIdB/DtID/+U9BM3k6l
	J4ciaVAKQCnH0tEWIYVHRGhOlLq0Eiym5qkC/keO8t7jF0U7Pi0doj71cR3ep0ZWk6R8i1fY6hY
	3MpMsDDtB3ym9hLpmocYTXeSE7/Vw95lZma4k0W447pPcDCvxUVVkkixPA+b9AgIWxzZ6purVG4
	dNl4duiJlO5KFK6es9C4CWt5y2cTxzNECGw+AAMwygiDbBqFYdBmeQPTrE2sbI7rAYxHnjQiKQI
	0=
X-Google-Smtp-Source: AGHT+IEh1pB9FNn1laHqFiES1TSY/mujOV7r+ksozCtg3k8Zu+1ydhQneDCtjE1I43f+WBjK2mFcPQ==
X-Received: by 2002:a05:6a00:951a:b0:781:171c:54cf with SMTP id d2e1a72fcca58-7a777760e07mr15739593b3a.1.1762190251263;
        Mon, 03 Nov 2025 09:17:31 -0800 (PST)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db28d3fbsm12148112b3a.43.2025.11.03.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:17:30 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v5 0/3] Add devicetree for the 9Tripod X3568 v4
Date: Tue,  4 Nov 2025 01:16:59 +0800
Message-ID: <20251103171702.1518730-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change in v2:
- Add vendor 'ninetripod' to board filename
  > 'x3568_v4' => 'ninetripod_x3568_v4'

Change in v3:
- Fix Makefile

Change in v4:
- Fix overlay dtso

Change in v5:
- Rename 'ninetripod' to '9tripod'
- Add rtc0 to alias
- Fix PCIe regulators node
  > Test passed with CLK missing and CLK installed.
  > No boot issue observed.
- Replace ethernet MDIO PHY
  > mdio0: phy0 => phy3
  > mdio1: phy0 => phy2
  > All point to the same device.
  > Rockchip's phy0 appears to be a universal PHY.

Coia Prant (3):
  dt-bindings: vendor-prefixes: Add 9Tripod
  dt-bindings: arm: rockchip: Add 9Tripod X3568 series
  arm64: dts: rockchip: Add devicetree for the 9Tripod X3568 v4

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |  11 +
 .../rk3568-9tripod-x3568-v4-camera-demo.dtso  |  84 ++
 .../rk3568-9tripod-x3568-v4-video-demo.dtso   | 154 +++
 .../dts/rockchip/rk3568-9tripod-x3568-v4.dts  | 887 ++++++++++++++++++
 6 files changed, 1144 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-demo.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-video-demo.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4.dts

-- 
2.47.3


