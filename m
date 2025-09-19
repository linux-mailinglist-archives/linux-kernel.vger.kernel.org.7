Return-Path: <linux-kernel+bounces-824032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85F6B87F62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC825808E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63728727B;
	Fri, 19 Sep 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/qUzZBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF716283FFA;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758261551; cv=none; b=YgqeGEJFIJD+4aDayt0FnfZQG+o/5cTT321ibfHmHDRG7X+l65Yu7HZaNPWE3d7G+Mt/44VvLKqqI6wBRr9peoF6kRa2OSl2eSDInYArLTwnXGUlzDnaNHlm8qRlwBlZOrsy6vKCypq9n3j51anbt1Zu3Iy/je3eCDXqMmhFre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758261551; c=relaxed/simple;
	bh=ARN6P9/X424zlXLiKTbeILtanwkQtWd4O4u45ktBDnM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nl0I/Qsip1YSxHfTGacB3YW8KRJ/km8zoQUtGMPxmegEqroEHjCT1QGIpxjuzsKi29zvHOg/OLXnzWhLKlwsaO2ZmlEG2xCdbzPV7/fEumkTMqKeGeN8dFzZEJhrKoX6SJDdqn2WV9UGEaBbKmlrgvCrjsjULAkHPHXvvjulYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/qUzZBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80730C4CEF0;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758261550;
	bh=ARN6P9/X424zlXLiKTbeILtanwkQtWd4O4u45ktBDnM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R/qUzZBHIsxOOMKjnRckwsYr37MOnatD+425r/3bMIPTdPagxJds5RmoXdQ1t7PSw
	 VKC4ys+4Uc9nL8IE8GblocuztHLnidGyWn+8wb1a19Hlb+dz6TDoeQyv2we8B05JEU
	 u1BFt8RduSHsac4/Qy8o8L0oHtV5TsnoV4ydfE4FxogDz0D3c2M4V7sflb0sX/Gk30
	 fgIFe2FaZzjgQP5En/DtRwdZjk6xGCa9JI4dq8+nh6fTSBS/zxAxvOeQlVtUu3RwOD
	 0w8Q1STDbdNCMp/PAJSrRasbDvrE4wPofWtXcP+AFKlIJGDYIYMy5rDycGS1U5k3Xd
	 jaP8moY3eVaxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC39CAC592;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v6 0/3] clk: amlogic: add video-related clocks for S4 SoC
Date: Fri, 19 Sep 2025 13:58:58 +0800
Message-Id: <20250919-add_video_clk-v6-0-fe223161fb3f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACPxzGgC/3XPzWoCMRSG4VuRrBs5+TmZpKveRxHJzxkNVVNmJ
 LTI3LvRjTKjyy/wvIdc2EhDppF9ri5soJrHXE5tmI8Vi3t/2hHPqW0mQSJ0ArlPaVtzorKNhx+
 eorIBNToQljXzO1Cf/+69703b+zyey/B/z1dxe31XqoID10Bdb5TqlRFf/ngouxzXsRzZrVXlw
 1uh5142H4IM6LGXDvTSq4d3sLivmrcKdHQi2OBeeP3s3dzr5pEggki6894uPT55YeYemyeJ0im
 0zsDs/9M0XQHF8HpArAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758261548; l=1984;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=ARN6P9/X424zlXLiKTbeILtanwkQtWd4O4u45ktBDnM=;
 b=XXP6mQSo6VYw2td4KrrELnplOge6oWnhKcSZSb+u2Xr4OOmy2ahWYAZ3efQOYgziW+ySI+p7C
 kh9uYnVngwBDttGGcI1ZdGpcOzEN8UVV20TQpALs/I9Lf+4KyV+HqZ7
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

This patch introduces new clock support for video processing components
including the encoder, demodulator and CVBS interface modules.

The related clocks have passed clk-measure verification.

Some potentially unsafe flag configurations were identified in other
video clocks, and they are cleaned up as part of this patch series.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Changes in v6:
- Split the flag removal changes for video clocks into a separate patch.
- Link to v5: https://lore.kernel.org/r/20250916-add_video_clk-v5-0-e25293589601@amlogic.com

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
Chuan Liu (3):
      dt-bindings: clock: add video clock indices for Amlogic S4 SoC
      clk: amlogic: add video-related clocks for S4 SoC
      clk: amlogic: remove potentially unsafe flags from S4 video clocks

 drivers/clk/meson/s4-peripherals.c                 | 206 ++++++++++++++++++++-
 .../clock/amlogic,s4-peripherals-clkc.h            |  11 ++
 2 files changed, 213 insertions(+), 4 deletions(-)
---
base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
change-id: 20250715-add_video_clk-dc38b5459018

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



