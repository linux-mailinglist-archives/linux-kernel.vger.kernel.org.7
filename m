Return-Path: <linux-kernel+bounces-802463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D28B4529B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A2D1894921
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B4310771;
	Fri,  5 Sep 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUajUdKg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E227EFF1;
	Fri,  5 Sep 2025 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063206; cv=none; b=iTs9mkz1XvgzDp3Ct7Ku1LhHPe+abUBQNI8euahXpZJdIn3CU/hPPCTc8MWEuJ1MP6Umpt3j31I4Jf3vyWWKGmBJLLIR038rj45ZD70HTXGj/gDZymqANpHHSiqLhjwVlJuzc+lxEpZCaeHNwV1dL5mO2Axf5L1rFQEDZts/JpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063206; c=relaxed/simple;
	bh=rRDRie+arRa0yqYYOTsTXaDhoR4vLQdygBET+PjEQc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yq+OZ89go76tcsw8u3cucYQgJuu5jNaX/7h6gVjuEGsQvcJp/no0TRfS59i003dQ8TYig5u5NzowLYwmItJAqfXr26xIQoKqycm36wfxzsEPZMZNwLKCye0bdMUvSqCgqpiwmzKh8QpXi2aDpGpm8lmjbmU3Ao8Rzb4p+LarSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUajUdKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF243C4CEF7;
	Fri,  5 Sep 2025 09:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757063205;
	bh=rRDRie+arRa0yqYYOTsTXaDhoR4vLQdygBET+PjEQc4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lUajUdKgwY0Sq6MDHOLTnDF4kPjjkA3IujfW3bUn3lPncE/df3YKTc1oh3sxBDGoM
	 +DSOcAV/jMRaVkHfCsmQe3Vu28Z8ocRHLIDMs0drHPr6rFzRMtkknHLjFxPgyjOU+i
	 kq5XfePVWzDAo6ahRBU/3U/ZSzuShOupUHAmrW9zoncX5vxh8E6BcGM24gvtdukniV
	 VNt/y3gwKLWOtwEwgyOwKUXG/BhfUNrTh2vkVak2Y1jJ9QZFdYxocuPy/ocbgSed0+
	 YwS4X4cxROLD0XNVlnI5gyP0S/KzOImRt37xeMPq7N5MRgHYeTbrt/GNcfY2h8DwTB
	 kpbR6jCIX0nPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B663CCA1016;
	Fri,  5 Sep 2025 09:06:45 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v3 0/2] clk: amlogic: add video-related clocks for S4 SoC
Date: Fri, 05 Sep 2025 17:06:37 +0800
Message-Id: <20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6oumgC/3XMyQrCMBSF4VcpWRvJ2MGV7yFSmqm92DaSSFBK3
 920G1FweQ58/4KiDWAjOhULCjZBBD/nwQ8F0kM39xaDyRsxwiSpqMSdMW0CY32rxxs2mtdKCtk
 QWqNs7sE6eO69yzXvAeLDh9eeT3R7/5USxQQLYitXcu54Sc/dNPoe9FH7CW2txD6+puLXs+yVY
 kp20rGGiG+/rusbnwRNkuwAAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757063204; l=1186;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=rRDRie+arRa0yqYYOTsTXaDhoR4vLQdygBET+PjEQc4=;
 b=A5m6cXJ2nTGuUrkU0tNq1RZdcImPw4PhYKxqStuGNEeMeM0a3mwpAAbZEQzsDgZKfdniWS/mU
 DiNGQWNB4/XCv8eTNRvpCwrwuj7O8iIi4HFlBLfNIOJdFd7J13M0+Jx
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



