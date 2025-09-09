Return-Path: <linux-kernel+bounces-807371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8DB4A388
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE9A17A926
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD87307ADE;
	Tue,  9 Sep 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQwNxFTW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E030597C;
	Tue,  9 Sep 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402978; cv=none; b=iuyUZglkL0yzjtYDquhu0TBXcDCGpe7JmGXHnexXfilFahpC/rYKz6t2ksVA4iix3IEEGsUXKVESEVOwZQ8myn+yD66Kc31YawQrgNR7XVGdRUeXRha4Q+1kJo/hWaBCUO83lTHCd4H74nONlzhuFucbjZE7vN1s+OLmVQ1dP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402978; c=relaxed/simple;
	bh=VdFf4gK8OI+xzT6h3uwJdXQFG43m8vn/Jt66A+K1OhI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QvUn8yQEwXtokQtisXV3gspd3KW9scWHYXkkiP5WVtvy3ZcZFWjgdCwFn2EGXJoW9iBSYGOo0hGGDwjLxLdU2jQYs2b1Jizwn+BAD8L0bagn+ioPV9ltrKRSuXlCMzAaVxiWtbtuYiUvJ0DZulPpIF1huRtyWzj5cNA3j/rHwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQwNxFTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 123A7C4CEF4;
	Tue,  9 Sep 2025 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757402978;
	bh=VdFf4gK8OI+xzT6h3uwJdXQFG43m8vn/Jt66A+K1OhI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XQwNxFTWA/dDsH9e48VAHeXRxDa/spqK5t3LaBcEwWkJnu9Tr39fMDZ0sq9azFWg3
	 h0NyMcIWwIp8CTeNK9EgPnwjuDx3fSyhIWuykTiqN0gpsN2U69U1CtnyOfhazaZ/r1
	 ZY29qB96gM6eKGmzk9t3DpV4RN2uIg2CZ5iF+3058hFisIYzlpB9YdGyqiWpFWskiA
	 chxxs0Y4InzHJQOBL4KBOJOO1u4XkVG7mf80NNKa+Zs5/w6Injxmqcc+G/sSQJnaSN
	 JnXNnWlx0fwAQa+/uMwZh8V2GV+AuaO+pfiQxzTKlXaT0l1cGcxN4a1wos1hAd1IdP
	 HGFqvcbURn0Ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F252ACAC589;
	Tue,  9 Sep 2025 07:29:37 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v4 0/2] clk: amlogic: add video-related clocks for S4 SoC
Date: Tue, 09 Sep 2025 15:29:10 +0800
Message-Id: <20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbXv2gC/3XNSwqDMBSF4a2UjJuSpyYddR+lSJ4aqqZoCS3i3
 hudCEqH58L33wmMbghuBNfTBAaXwhhinwc7n4BpVF87GGzegCDCUYk5VNZWKVgXK9M+oTVUaM6
 4RFiAbF6D8+Gz9u6PvJswvuPwXfMJL9d/pYQhggy50heUelrgm+raWAdzMbEDSyuRzQvM9p5kr
 zXRXHFPJGJHTzcv0eE/zV5QxIzEWmi58/M8/wA0WCiRLAEAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Chuan Liu <chuan.liu@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757402973; l=1370;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=VdFf4gK8OI+xzT6h3uwJdXQFG43m8vn/Jt66A+K1OhI=;
 b=VqbrJOceJlc/Q2NatDtM8IYSiB6c80Qzc90doSqPAWs5h9HtoADXKA1PAXlWHugPJQNONaby2
 WNjm62jEbQyDJ/Z9+9A/Wxx0CTEbzXU7A8PNFgDUer2L7djydKqW7T/
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

This patch introduces new clock support for video processing components
including the encoder, demodulator and CVBS interface modules.

The related clocks have passed clk-measure verification.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Changes in v4:
- Add Acked-by tags from Rob and Krzysztof.
- Fix compilation errors.
- Link to v3: https://lore.kernel.org/r/20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com

Changes in v3:
- Rebase with Jerome's latest code base.
- Link to v2: https://lore.kernel.org/r/20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com

Changes in v2:
- Removed lcd_an clock tree (previously used in meson series but obsolete in
newer chips).
- Removed Rob's 'Acked-by' tag due to dt-binding changes (Is it necessary?).
- Link to v1: https://lore.kernel.org/r/20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com

---
Chuan Liu (2):
      dt-bindings: clock: add video clock indices for Amlogic S4 SoC
      clk: amlogic: add video-related clocks for S4 SoC

 drivers/clk/meson/s4-peripherals.c                 | 203 +++++++++++++++++++++
 .../clock/amlogic,s4-peripherals-clkc.h            |  11 ++
 2 files changed, 214 insertions(+)
---
base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
change-id: 20250715-add_video_clk-dc38b5459018

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



