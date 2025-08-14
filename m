Return-Path: <linux-kernel+bounces-768009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D869CB25BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C185B5C4EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5825291B;
	Thu, 14 Aug 2025 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltxOYszw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044BA63CB;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153181; cv=none; b=lNWT14y/GdIY6nmOOdRsPdxNUELJY/WrWeXbHmuGm27EEIQLvGP8z2wuYlfg4E8cC/pf6m1iVuauWfQOxWAdRSt7Low/T6k24X6BySv7VUP6i/4xPVORp+mX+D6x7evKBuvouIqeM6cPrzRyeIc0MaGfIPQneeSDqoKGdPN4bMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153181; c=relaxed/simple;
	bh=xqoMW8XQ1IL75gw5lb1OBnSfzSjiDXCBOC9x4KnlLSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ihM+5pE7t1N7l7rB8gFhQlxwdXiD/M4t0eyoCViMC2B992lDqbKmTUwQ/BMeIaTc2/YU4SmF3bdj8DfmEL3ZTGzCaZYAL3KOjUg+4JiEd9nxMfryjXurELCyzN6PwtH3chsMwKPgyXGVn4EoBO2KLdmM7EHRBgbHkXkPmMKhm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltxOYszw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84191C4CEEF;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755153180;
	bh=xqoMW8XQ1IL75gw5lb1OBnSfzSjiDXCBOC9x4KnlLSU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ltxOYszwyPENTkWpH3lho4Bdhhglu0MEvycD6ttz6Bga0lL/91rXsPKb+T5sGoI/d
	 NZmfiDWBkr7em9POsifhRmfwG3XQWAjT+Q8lIwKB6niA+Y1jUC5VCUOeS1A0MDOQSc
	 DzX6YbEW82W6+2ioXMmaPN17z+zw105AQX9lJRbwuEuF9e1xtN5CEU0s8ozeEMmmf3
	 noj4IwjWMBxEH25HGRhYgDgzOpOuSQhp2VNiIBMT/UFZDIZTpZCGuUtKY87pAjQs4s
	 53UISIos8L5S3NfUKv1wHFoVXmUc6g4nxYi+jw5vMb9ZnngQnuL/MalM9wWXjQrwNv
	 oce4e4tgSCLeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70860CA0EE3;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v2 0/2] clk: amlogic: add video-related clocks for S4 SoC
Date: Thu, 14 Aug 2025 14:32:43 +0800
Message-Id: <20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAuDnWgC/3XMQQ6DIBCF4auYWZcGRNS66j0aYywMOqlKAw1pY
 7h7qfsu/5e8b4eAnjBAV+zgMVIgt+UoTwXoedwmZGRyQ8lLxRuh2GjMEMmgG/TyYEbL9q4qdeG
 ihfx5erT0Prxbn3um8HL+c/BR/NZ/UhSMs4pjY2sprazFdVwXN5E+a7dCn1L6AgvXnoqsAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755153176; l=1032;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=xqoMW8XQ1IL75gw5lb1OBnSfzSjiDXCBOC9x4KnlLSU=;
 b=E9qwT/Wglp5klWxgaqu55zaf7kslbuWrgnxDSlI5uC6A/jiIeb80gLHO4L7bEWyWkeHO9fg22
 wVZO7UoAtatCXo0rYwDEQWepfMylL42p3Q3Fq2yVcudVVZI1qkWbJ1e
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
base-commit: 8a65268500b00ecee5402ef9f80618ff73f30707
change-id: 20250715-add_video_clk-dc38b5459018

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



