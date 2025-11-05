Return-Path: <linux-kernel+bounces-886874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC5C36CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A5366669D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD3334C21;
	Wed,  5 Nov 2025 16:14:46 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD833556E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359285; cv=none; b=aaL84whFKoIjpkNBGbEwwrcG9HistGop17uXf2yhu887UMePpefoVNLz367s8F6zo3Cih5d54gFWGhXiZgcI6U98mkCxc5fjZDouEN32shHTNLF8ZilxqoMHxfppB6bpGRf1OiRXMaZd/a8Cj5d/Dc5bkEgxWdHksRUdtajBqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359285; c=relaxed/simple;
	bh=s3n0unM8fl7/M0BhD7n2qAjj6YvnndYHEUBGy10hFU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJhdaNOTAvxe+RfEUYBnLEmRBeAWfCLdm0IflkcsLTwpjidhtUZmHyM4PJfQmyQ/Y/zOvEv1VYjWS7nqdeGCCYjKhazIIlN0kDk3k2pNTn8tpmRmndq/Tprv3JilRFSp7sxD882yHtlfAEOFrnMh5jd4FB3d4Tasm3k+QhXZeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst022.omp.ru (87.226.253.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 5 Nov
 2025 19:14:31 +0300
From: Karina Yankevich <k.yankevich@omp.ru>
To: Sandy Huang <hjc@rock-chips.com>
CC: Karina Yankevich <k.yankevich@omp.ru>, =?UTF-8?q?Heiko=20St=C3=BCbner?=
	<heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 1/3] drm/rockchip: vop: avoid overflow of clock rate in vop_crtc_mode_fixup()
Date: Wed, 5 Nov 2025 19:07:17 +0300
Message-ID: <20251105160719.2917175-2-k.yankevich@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105160719.2917175-1-k.yankevich@omp.ru>
References: <20251105160719.2917175-1-k.yankevich@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/05/2025 15:59:09
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 197810 [Nov 05 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.yankevich@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 75 0.3.75
 aab2175a55dcbd410b25b8694e49bbee3c09cdde
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	87.226.253.162:7.1.2;127.0.0.199:7.1.2;spb1wst022.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 87.226.253.162
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/05/2025 16:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/5/2025 2:40:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Conversion of clock frequency from kHz to Hz in vop_crtc_mode_fixup()
can lead to integer overflow, since type of drm_display_mode::clock 
is 'int'. Fix it by using 1000UL multiplier to avoid overflow 
at least on 64-bit arches.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b59b8de31497 ("drm/rockchip: return a true clock rate to adjusted_mode")
Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ba6b0528d1e5..b1e2ca84c26d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1239,10 +1239,10 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 	 * 4. Store the rounded up rate so that we don't need to worry about
 	 *    this in the actual clk_set_rate().
 	 */
-	rate = clk_round_rate(vop->dclk, adjusted_mode->clock * 1000);
+	rate = clk_round_rate(vop->dclk, adjusted_mode->clock * 1000UL);
 	if (rate / 1000 != adjusted_mode->clock)
 		rate = clk_round_rate(vop->dclk,
-				      adjusted_mode->clock * 1000 + 999);
+				      adjusted_mode->clock * 1000UL + 999);
 	adjusted_mode->clock = DIV_ROUND_UP(rate, 1000);
 
 	return true;
-- 
2.34.1


