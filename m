Return-Path: <linux-kernel+bounces-877551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D681C1E695
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647613BCE63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9832E158;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2ZTiUXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C432C944;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801858; cv=none; b=GYG9XiDWkFlC89fvd/lafLEx4NI3IPvyd7TFKmKfangPy8DcIXAorII8LRXkJ8jL3hyL9ntSV2jRjCM+dwMcgoWUAV+TyZJLvDb4Y8EENpbFdBVlW77NNHNzf4JU8I477peplPFXnxlJ2pb8QTRstsTABwha61LzTd/Rru55LEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801858; c=relaxed/simple;
	bh=qk43B9yCr7jS07xjPb+H5F9/166ml0k8WcuPbOL1yd4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qk6JnXa1FPc8DJsL6uuWln/70HV+mV2lgD4tyvgxLn+8OH0YiNSFO/p9vnzn/cJgzazyAELQWvZSSO3hCh5PoNVFnVYVpLXC8KYkK8T1WAV73O+/pK/2YWUCHe8wYqolrwqVg/IukDetvJe+BhGcXs/b8A2VHcWca1MgXOZOkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2ZTiUXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2222C4CEF1;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761801857;
	bh=qk43B9yCr7jS07xjPb+H5F9/166ml0k8WcuPbOL1yd4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=O2ZTiUXAX2d5KG2aIahl7c8/Sb9GrysrpoWWwvGa2m5YKYnSbysivAGi+KgrtZ9rU
	 Wjxv6sqaL9Lr4dx/1bwZ85Qep684DUaPuQjm2oDU1TNCKRgAk4l7d5sj2dVE72QgUJ
	 gGUPsEaipBtF9sDzikjvL9aIxktVkStVk1OLG98aygttA858jLbgOJfXe57YM4+xn9
	 nqQ0oaZ3H6/R8csqQNFean7HUnumkNNJmTr0sBEkGOsA9xrjC25SMd/YMFldYigwR+
	 S6v4X1FI8UlJJUaclAWDlIQ6p/iB3gQLaqrMvJuwn3Vj5lngCzdRjqk25X4/NxXwdA
	 1q+idvcoeXyzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E7CCF9F0;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v2 0/5] clk: amlogic: optimize the PLL driver
Date: Thu, 30 Oct 2025 13:24:10 +0800
Message-Id: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHv2AmkC/22NQQqDMBBFryKzbkoyqGm76j2KiMaJDqiRREJb8
 e5Nhe66fA/++xsE8kwBbtkGniIHdnMCPGVghmbuSXCXGFBioSRK4ZaVJ35TvYxj3XmO5IVuyV7
 VRZcmV5CWiyfLz6P6qBIPHFbnX8dJVF/76+HfXlRCigZ1oRFtW9r83kyj69mcjZug2vf9A/c0w
 HO4AAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>, da@libre.computer
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761801855; l=3694;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=qk43B9yCr7jS07xjPb+H5F9/166ml0k8WcuPbOL1yd4=;
 b=Ye9PcJTMkJnNXguvJBxSK+yppF+Wno1exRnSWWteXg6YN/Pw+36WDOLdRjHH1oDmOdI3Xjjxe
 +Vy68rbQbjsCt8sSw17LMUW3/5DKwJg+qq0XVpEjuNWje75b/DnN6GW
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

This patch series consists of four topics involving the amlogic PLL
driver:
- Fix out-of-range PLL frequency setting
- Improve the issue of PLL lock failures
- Add handling for PLL lock failure
- Optimize PLL enable timing
- Change the active level of l_detect

For easier review and management, these are submitted as a single
patch series.

The PLL timing optimization changes were merged into our internal
repository quite some time ago and have been verified on a large
number of SoCs :
- Already supported upstream: G12A, G12B, SM1, S4, A1, C3
- Planned for upstream support: T7, A5, A4, S7, S7D, S6, etc.

Based on the upstream code base, I have performed functional testing
on G12A, A1, A5, A4, T7, S7, S7D, and S6, all of which passed.

Additionally, stress testing using scripts was conducted on A5 and
A1, with over 40,000 and 50,000 iterations respectively, and no
abnormalities were observed. Below is a portion of the stress test
log (CLOCK_ALLOW_WRITE_DEBUGFS has been manually enabled):

- For A5:
  # echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
  # cnt=0
  # while true; do
  >     echo "------------ cnt=$cnt -----------"
  >     echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
  >     en=$(cat /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable 2>/dev/null)
  >     if [ "$en" != "1" ]; then
  >         echo "[ERROR] PLL enable test failed! (clk_prepare_enable=$en)"
  >         break
  >     fi
  > 
  >     echo 0 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
  >     cnt=$((cnt + 1))
  >     echo -e "sleep time: 1 s."
  >     sleep 1
  > done &
  # ------------ cnt=0 -----------
  sleep time: 1 s.
  ------------ cnt=1 -----------
  sleep time: 1 s.
  ------------ cnt=2 -----------
  sleep time: 1 s.
  ...
  ------------ cnt=42076 -----------
  sleep time: 1 s.

- For A1:
  # echo 983040000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
  # cnt=0
  # while true; do
  >     echo "------------ cnt=$cnt -----------"
  >     echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
  >     en=$(cat /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable 2>/dev/null)
  >     if [ "$en" != "1" ]; then
  >         echo "[ERROR] PLL enable test failed! (clk_prepare_enable=$en)"
  >         break
  >     fi
  > 
  >     echo 0 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
  >     cnt=$((cnt + 1))
  >     echo -e "sleep time: 1 s."
  >     sleep 1
  > done &
  # ------------ cnt=0 -----------
  sleep time: 1 s.
  ------------ cnt=1 -----------
  sleep time: 1 s.
  ------------ cnt=2 -----------
  sleep time: 1 s.
  ...
  ------------ cnt=55051 -----------
  sleep time: 1 s.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Changes in v2:
- Modify the judgment condition of 'm' out of range.
- Split the PLL timing optimization patch to make it easier to review.
- Link to v1: https://lore.kernel.org/r/20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com

---
Chuan Liu (5):
      clk: amlogic: Fix out-of-range PLL frequency setting
      clk: amlogic: Improve the issue of PLL lock failures
      clk: amlogic: Add handling for PLL lock failure
      clk: amlogic: Optimize PLL enable timing
      clk: amlogic: Change the active level of l_detect

 drivers/clk/meson/a1-pll.c  |  1 +
 drivers/clk/meson/clk-pll.c | 76 ++++++++++++++++++++++++++++-----------------
 drivers/clk/meson/clk-pll.h |  2 ++
 3 files changed, 51 insertions(+), 28 deletions(-)
---
base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
change-id: 20251020-optimize_pll_driver-7bef91876c41

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



