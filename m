Return-Path: <linux-kernel+bounces-887484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC911C38571
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A84418C5669
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337562F60A7;
	Wed,  5 Nov 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTTJAevz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCFF2E8B73;
	Wed,  5 Nov 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384970; cv=none; b=rUmlrCAttxTUCb0aB07m5KlDg8OITrdO96z6rdW1upES0mcxGLHRqSkEV1sAZAO3XXwmyXlrORxJVzWBX/xicjHIzSqSjRkJ1ehRbqqra96cA+sjlSEW6Xzo6wAHqqrj7WqlubDFxB+7HEY0aeY4sJKCpDDyaoiHLB6vRxWZNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384970; c=relaxed/simple;
	bh=EmTWfvkMbb3dqk19EtSTmtmk5e8i+zIt0u4oJLxsHjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BiGs+wosLvjlM76u2+5Zm8DOYzOwZ+qSX4K9Dk+nBmQhrzjnBySsz+sX+J1BRVWi8+k+TF46WZKkDIadYfA4YFL8zzmBx0Chpk611qsDlbgpSjqaZClPSq0uaiC4rtZUv3Gveefz3QwDQspR45zMgfDz2xlu5kA9XcBbbLyePTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTTJAevz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73A0C116D0;
	Wed,  5 Nov 2025 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762384970;
	bh=EmTWfvkMbb3dqk19EtSTmtmk5e8i+zIt0u4oJLxsHjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cTTJAevzImaux51JW2HZmy2YyEBdDz+ooofjz1m77IKyWrAWqxioXwJQgzkjqQzmn
	 EgppiLwRn7X/uoGqr6jq/K/O0zm+xSrEaWivgUdSY5Ix2C7wXvpMzm+bXjiziJPKye
	 ohwFobH62LzXBjoKHFXz11fLOEAdNTRHaDX/8Bra+HwUTuzzFr/ePmuPyy6EBICk8F
	 ErBL3dx2Fz0nbYI+kjKLpccPxJv6mM1I+yNesgQpIwhgAPMOS60gbRnFLwYZCkZFvl
	 JxT743QtX7Z/SmFN2h6ksCiphJ5xAbigByX5aW+8RsLzifrOuI/Tt/YKSr0QfMFnQp
	 BHE0xiSEURNmg==
Received: by venus (Postfix, from userid 1000)
	id 486E6182F71; Thu, 06 Nov 2025 00:22:45 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
Date: Thu, 06 Nov 2025 00:22:43 +0100
Subject: [PATCH 4/4] platform: arm64: thinkpad-t14s-ec: add suspend handler
 for keyboard backlight
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-thinkpad-t14s-ec-improvements-v1-4-109548ae75c0@collabora.com>
References: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
In-Reply-To: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=EmTWfvkMbb3dqk19EtSTmtmk5e8i+zIt0u4oJLxsHjs=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBpC9xE23WsyRkwotKjWD39YBOIdf1avp0G6h6bS
 QXNCGFczMGJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaQvcRAAKCRDY7tfzyDv6
 mhY/D/4yXQORCB7TVAaXYy1ssUkwErPaw1RNV62POFsRlwJWT4qUC3qhFdEaIeWg7r6CM+Jd9xy
 mqNH/mKTfh6ewBWUzAAt6PQ8FfF7Y3WzrTvC58NPGXF5IPL/QaK6t2fHNWznLQDiIvRASa3mWE2
 L0PPMVcye5Ry8Utm3S5bt97HtjAKaaro9c/WditrAkRElrsxOrJyHRVyEVIKUAGo2fdWHVxyM49
 ADHLLVx7PnnTNtJ880LhPX3yu9s7nJbiwJb29j94WZfIzvon/98XGkRypTFAJvG4huEwp5yQBKc
 SguFgJFz4T0qiVz2PISfPb3VknUm5ioapxXdjesThPTGGWaEnz81l43dWo0sIDIKh5c1YJpTedj
 aBA9Tpch3Tn+OYs1A8imduUCVZgYamVaZPp4GFZHXQhtDF3Loz3IBgx7CQc2AA3ebhbFrAdHctU
 cejWvObyodGenPjmxMe9PKqgna5XeIv4H5AyaPdjBRwgNo056iEnPeR50mfcqRrLDvXgP7JXwf1
 zBXKCMMpjkXIJwte6rMtnuYgOqSgMKKHhyAgnqZX6drDFZOa58nCpnp9A2F49OqRz401QEw1T54
 Lv68BXvqTKzIsmEQWvpfQiAoF/6dR9ATNMORBf5zfbOglHIg2iEz/PH6TvIzv6rbNNJG0f0lIO5
 SHIxtpKYvST/xxA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This ensures that the keyboard backlight state is restored after
a suspend-resume cycle. Otherwise the keyboard is automatically
disabled during suspend and then stays disabled after resume.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/platform/arm64/lenovo-thinkpad-t14s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
index 066074a1314b..82c3ad6b3ee3 100644
--- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
+++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
@@ -609,6 +609,8 @@ static int t14s_ec_suspend(struct device *dev)
 {
 	struct t14s_ec *ec = dev_get_drvdata(dev);
 
+	led_classdev_suspend(&ec->kbd_backlight);
+
 	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
 			       T14S_EC_MODERN_STANDBY_ENTRY, 3);
 
@@ -622,6 +624,8 @@ static int t14s_ec_resume(struct device *dev)
 	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
 			       T14S_EC_MODERN_STANDBY_EXIT, 3);
 
+	led_classdev_resume(&ec->kbd_backlight);
+
 	return 0;
 }
 

-- 
2.51.0


