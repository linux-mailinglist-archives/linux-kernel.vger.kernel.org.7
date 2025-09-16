Return-Path: <linux-kernel+bounces-818020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A9B58BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C217A174
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC8238C33;
	Tue, 16 Sep 2025 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlPKPcqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A08136E37;
	Tue, 16 Sep 2025 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988389; cv=none; b=u9nDWzyiY6+67oiBXLerKq2E5ieYJ49mtzaiTmWIak+hrRzIuo85zREsuxOZ0rZhxQ30HcuXsb/E7/x+zQHpxI2SB2yXH4c8X2icMG6Wwqv/V5jlvSe/PM4rhc3Sqz30pv/O0uKiutipKRXcKjYRC1ZmUxLcgGvRQm0/i5Cprsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988389; c=relaxed/simple;
	bh=9kK68Xs+KCmxOIP2SAhilPIrfTsceTJZcF5LekB7CjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DkZlWFKWieXSZ2UdFS5DqIxpHr1ogZeLFl3lHr841I+zYH405owGXK1derK9jyvW4qK1cqjLiVluxqOgF58Z8D1FFNmf5MkJtRHHxbUcQvnR5Py88Xm1aIMaPrqIiiO+ERtaIpCxrH2k1RRCtSIn14clf64SRSx8ccILYsnl2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlPKPcqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA2E2C4CEF1;
	Tue, 16 Sep 2025 02:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757988388;
	bh=9kK68Xs+KCmxOIP2SAhilPIrfTsceTJZcF5LekB7CjI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nlPKPcqCkuRy7II+o0WDa1b/voNXMCByVg+5KMOKTd31IcKDiHP6Fp5VZuYA3W4ba
	 MxTnUbhhMwKviZzvE9pJtFkD6/Z36AGZdR7IPMs0fH1HG24wbDDMzp+yWp3RMhCxUZ
	 V4zAXVjJgU2vY81WZ9E58T7dGwG935ilnEJHr7kflO1RdBwG22+6Uym8IL3JjfLPkV
	 gPDnIXRgZdlmdBHZkNrK9qr1Q3ec5JBw6oX3pFn3tbfwzaKPd2wXaiidQ85TOlV0zI
	 OybKc0txpzF34+ao2DDBQ/ztUB8b+Wbetll8x3/8ik5JmBNws7vXhQuE1OOIchgS8D
	 cISqLjBEi0bpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7199CAC592;
	Tue, 16 Sep 2025 02:06:28 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v5 0/2] clk: amlogic: add video-related clocks for S4 SoC
Date: Tue, 16 Sep 2025 10:06:05 +0800
Message-Id: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3GyGgC/3XNSwrCMBSF4a2UjI3cvNrEkfsQKXlVg9VIK0Ep3
 bvRSbXV4bnw/XdAve+C79GmGFDnU+hDvOQhVgWyR305eBxc3ogCFVARgbVzdQrOx9q2J+wsk0Z
 woYBIlM218024v3u7fd7H0N9i93jnE3ld/5USwYA5+KopGWtYSbb63MZDsGsbz+jVSnTykvC5p
 9kbQ43QoqEK+NKzyStY/GfZSwbcKmKkUT88//Rq7nn2woMF4niltfz24zg+Aapg/Y1sAQAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757988387; l=1583;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=9kK68Xs+KCmxOIP2SAhilPIrfTsceTJZcF5LekB7CjI=;
 b=nkaxWwNE5fra2bm3s9BXD4almurc1c50e/MeIIel3z6gjw+9eMM/sYz0NEoQvw99qUNoZiwcP
 5xi9b8BjZ3jAnCPUugGo5SfS5d6mXEvuQ+pT7SKmPR3u8+p6qYRjGZi
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
Changes in v5:
- Add Acked-by tags from Conor.
- Remove unnecessary flags as suggested by Jerome.
- Link to v4: https://lore.kernel.org/r/20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com

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

 drivers/clk/meson/s4-peripherals.c                 | 206 ++++++++++++++++++++-
 .../clock/amlogic,s4-peripherals-clkc.h            |  11 ++
 2 files changed, 213 insertions(+), 4 deletions(-)
---
base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
change-id: 20250715-add_video_clk-dc38b5459018

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



