Return-Path: <linux-kernel+bounces-826380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DB3B8E5E2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F10189808C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905162989B0;
	Sun, 21 Sep 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFm6zQpP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F71A7AE3;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488762; cv=none; b=I+m1Lv+UZl/cq4H3LWMU+Jz9HaLdOt+CZ5hCFOxK3GavyyOQr5cbMNZxjLBLap/qlDnezVmkM5OevyLFHo/LCIdMufUzsFhOuoVC7qiGPw8sdxTZuEBzM7nUUtHbhvlKdGkayjo/22kEMzpBRhGY802WMVVI1uCSsUVkgqmCaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488762; c=relaxed/simple;
	bh=p36wcFyPQqlAAPFV8kif2hBbqmR6V3mP2tc/m/CbJ/4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oto+fgTRjbRpzoP0ddg3vwo1x1xPCJS3WjvAgq4OkKuzGw4sPPE1ieSVWZCwJrEYgbyHIdXOrZd3p0qNFm+HvWGf2TdAOqoazka5Jo2T8/0VUGlDV+CtTF9bi4bfSq1RDDAd4+OXxJAfZjE97Sx6Q6sgFDVemm16J14Ab5znG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFm6zQpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 767C2C4CEE7;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758488761;
	bh=p36wcFyPQqlAAPFV8kif2hBbqmR6V3mP2tc/m/CbJ/4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BFm6zQpP+meGakJqNg2ZDtXbgZR00zlC5XxK3+S/NLiIUjb3J3gzVr9l4GZ+VShHJ
	 VkjuYNZmEiUPELtAZmV9BVufjY2hu3Ku+wnJ2XfaQB577FRzj1sakLGN4PQpurl0l3
	 zZolOgngMgUKfmWNQXsCGZC1sk6xESHdKWpbLLuSWa2vPncgLndhEWmBFsEwfh5Sr2
	 S8gzk1iDYvwXmRBcXTRl3iBhHyF7fTtj8jtLlXkViyg8vlTo2jypxqwFtureDMD8P4
	 qDynJWzIrc6AbdogAvmGwDKCgtO0aGujliDnYbc83Zx/H4m4ZSFP4fIckoJ3K3nDqC
	 Crc4IWKtdPEPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B64CAC5A8;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Subject: [PATCH v3 0/5] Upstreaming Pinephone Pro Patches
Date: Sun, 21 Sep 2025 14:05:53 -0700
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALFo0GgC/43NQQ6CMBCF4auQrq0pBaG68h7GkDIdyiSFEiBVQ
 7i7hRU7Xf5v8b2FTTgSTuyWLGzEQBP5PkZ2Shi0urfIycRmUsiLuErBh2GoHNl2rjQAuqrTtgr
 eceNfPVdpCSpvjEZlWCSGERt67/zjGbulafbjZ38L6bb+CYeUCw6qrsFkKPGa322nyZ3Bd2yDg
 zxi6Q9MRgyLGqAAXeYaj9i6rl8CYUdAFQEAAA==
X-Change-ID: 20250920-ppp_light_accel_mag_vol-down-817c84fdae8d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758488760; l=2092;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=p36wcFyPQqlAAPFV8kif2hBbqmR6V3mP2tc/m/CbJ/4=;
 b=khC8t4v1Xu2EYfXP+DQY1VBR1+l0j/G7ns8n+3Uvymukxh1d3LQBBOqQmCJhHs7Fu9juXzzqq
 YjcenQ0Ge0WDV1e1PLp2Plg2a/OL903KHrvnQARvu9wQ3uhqCRbw8r8
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

Throughout the years, many have contributed to the Pinephone Pro (ppp)
development. Unfortunately, these patches are scattered around various
repositories in different states.

I will be attempting to upstream these patches. I will start off with the
following small series:
- Add light/proximity sensor support
  - https://codeberg.org/megi/linux/commit/f171bc7013bc7ad3de9af817bfbcbfa548ebe01c
- Add accelerometer sensor support
  - https://codeberg.org/megi/linux/commit/b0bb7633e073a6760fa213b8c4a78ea2e73c7bf1
- Add magnetometer sensor support
  - https://codeberg.org/megi/linux/commit/2f7e67f451f16eaf15b81aa1dbdf126d54927d35
- Add mount-matrix for magnetometer
  - https://codeberg.org/megi/linux/commit/d7cd2eab931e32fa94408a96d73b4e6c0616107a
- Fix voltage threshold for volume down key
  - https://codeberg.org/megi/linux/commit/7c496a5cc27ed4e38b740f36c2d8b2c62f80ae54

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
Changes in v3:
- change magnetometer mount matrix
- update volume button threshold
- Link to v2: https://lore.kernel.org/r/20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com

Changes in v2:
- remove usb-typec node in dts from light/proximity sensor patch
- Link to v1: https://lore.kernel.org/r/20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com

---
Leonardo G. Trombetta (1):
      arm64: dts: rk3399-pinephone-pro: Add mount-matrix for magnetometer

Ondrej Jirman (4):
      arm64: dts: rk3399-pinephone-pro: Add light/proximity sensor support
      arm64: dts: rk3399-pinephone-pro: Add accelerometer sensor support
      arm64: dts: rk3399-pinephone-pro: Add magnetometer sensor support
      arm64: dts: rk3399-pinephone-pro: Fix voltage threshold for volume keys

 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 42 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250920-ppp_light_accel_mag_vol-down-817c84fdae8d

Best regards,
-- 
Rudraksha Gupta <guptarud@gmail.com>



