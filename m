Return-Path: <linux-kernel+bounces-873692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63CDC1473B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027B05E8157
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFF30CD8D;
	Tue, 28 Oct 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CKNhenZu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01430C626;
	Tue, 28 Oct 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652030; cv=none; b=uOoai+xg9oKT/SBcoYOPcGU3t5PZmkHBn6Q7M5+jUgjVwqqkdNhwqt2xXsRmS0O1/WDR6rYY7qL/c+Ik1jNNlw/ZY3D2/xbCzLBPA2vGZJhc7ornLujuykOzXo1+Ds39g6sA2Rg7pH+KOHqS9Pl5JI+g0tJGxRnsweTHxIcw9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652030; c=relaxed/simple;
	bh=dhVlfFBuIJdMHGGksIj7RamXnkNaK+qKXIFsvtZ4AgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PYQT5yW93hjL8K0FbyXSHkTAp3bSCyW6q5X8BZ9ssoPk2yFqfNF7tuYNVzZBRn6h21DEcqngcpZikBWx0Iv6Exlf/cJifuafriyrNIIFw5w2SDXrhr/l8dpzdU26VJWCxvg8zcDpAtnrJCcQhNg8pH49n2dpokz5kpCyyV8u6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CKNhenZu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E03EF11D5;
	Tue, 28 Oct 2025 12:45:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761651917;
	bh=dhVlfFBuIJdMHGGksIj7RamXnkNaK+qKXIFsvtZ4AgI=;
	h=From:Date:Subject:To:Cc:From;
	b=CKNhenZuEDjQ4yRNCvaMBiAYGCYEwQB7dUHnLJ3EXj1blYl3u5grUKo6VF5Jr5VY0
	 pSDRbAe1iHlfefiG4oNb6eJgab/D4r2fp8tLTsZI6a5pKc8esVHuUewoFZuQF5f8aT
	 7FKMmXsgRdDA2hckki2lp02iI1jeIoHao5LfZjqA=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Tue, 28 Oct 2025 17:16:47 +0530
Subject: [PATCH] clk: bcm: rpi: Mark ISP clock as critical
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-rpi-isp-clk-v1-1-2a54fecb495c@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIACatAGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3aKCTN3M4gLd5Jxs3dQk02QTC2MTs1RTQyWgjoKi1LTMCrBp0bG
 1tQDTw4FaXQAAAA==
X-Change-ID: 20251028-rpi-isp-clk-eb5c48346e51
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=dhVlfFBuIJdMHGGksIj7RamXnkNaK+qKXIFsvtZ4AgI=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpAK0zbSf9BdGRuZCYvi6Lckjwz2ResH+/mIgE/
 d5g1BPrRfmJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQCtMwAKCRBD3pH5JJpx
 RbGKD/9SUdtmw4sJCgNYzoCpg/x3H9l8i92BGJffd5WLRFBDnuEqUidpH+jBcoH8M3Zdq9/W0j0
 oV+MUIB0lqk0Cn7gyCEMOr4UWj0gCCv5dxwNSmbzegTfx9ZhDy8ECJf45nlstK1f+BqLGVHeyzu
 NonV+QV1iFgr48k0NMmDBS28Kox5nhUpYhSkHpJ0MMqifRcEObQ7uVbsNEe9wrTerhFQSGxmsdO
 1BDkJBeRPRwUDV0BhY3ujT85s58imP72fPKZuM9fgWUK2dX1uuYrMbOK42A58OeQNh8tV1KksyG
 2N38UnFj8wwpZwZh66N+2EZCa+B6rc1X81639KO34h//8XuAUbsKw0zoWkWN1iFsGfvj04jnZfz
 be/7sDbL1vmosrRbrYmm0UWvCT+iYQCjTYoHoPSI6C9H2SqrPibDlNPOebWT/Sx1U2+GZdBgXoe
 3gomg+VvbkTn8GYMjEICrMN6ENuLfMWBoUythy7ZssffidblaofbJ/EnrfjfSgucnf5Wa28RdaV
 LT0td2cdJhYLWfOFET2pMtHnquSjPYZz+c8Yq7MBHWo6YOduGqElJpGS/SbcYTenLtGsZkplcUc
 JTFRBoS2i6KneOxpyBTmty2+2ksAapJ9RRO39b8hR5RQz8tYD9BmhX6i+dG43wIuZSiQ3MBQo0F
 wBIpvjcaN04mcOw==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

The ISP clock should also be marked critical to prevent the clock
framework from disabling it on boot, which can lead to bus lockups when
the kernel tries to submit buffers to the VC4 ISP firmware.

Link: https://github.com/raspberrypi/linux/issues/7100
Fixes: 919d6924ae9b ("clk: bcm: rpi: Turn firmware clock on/off when preparing/unpreparing")
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 1a9162f0ae31e330c46f6eafdd00350599b0eede..dcc3ae5fb91650b042d52f02499922786b43afde 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -151,6 +151,7 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
 	[RPI_FIRMWARE_ISP_CLK_ID] = {
 		.export = true,
 		.minimize = true,
+		.flags = CLK_IS_CRITICAL,
 	},
 	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID] = {
 		.export = true,

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251028-rpi-isp-clk-eb5c48346e51

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>


