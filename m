Return-Path: <linux-kernel+bounces-886876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE12C36C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48D2666B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E3335558;
	Wed,  5 Nov 2025 16:14:54 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906D33507F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359294; cv=none; b=UOiR63jxdFb567xdeZynV5LvoZ26bfjm6gn8Rz2UVsfmVa/CAzA6/3VaKT5yGtnHQJO3ZagNz7galJHISvclX5jdFPIJPPrmasxAwanemz8qWOKOQpKt1fzBaxYBK/kgGWTqLvzMRLzZF60CIcX0GsFMbgnQ3GzCBKHyab/kE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359294; c=relaxed/simple;
	bh=TmeZVR88pCskAzNdUhUd6j6Kpz4DZLRD/VmqksaVv6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNZ/4kL4cjd1C0axUpG+M+73ORZtGj+FYtfboPCw2kChKMEX7DWcUBBlusKLCzYiC/U6nWfKznAjVzN3N0QAQvDg2ClRZlBd6wuBBCMmRhAzydt8xbfOppmv0xzdQgWsOEZcYeMGDRcpANdzKuOg/aOx9foXPirVDFIwxqQkfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst022.omp.ru (87.226.253.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 5 Nov
 2025 19:14:46 +0300
From: Karina Yankevich <k.yankevich@omp.ru>
To: Sandy Huang <hjc@rock-chips.com>
CC: Karina Yankevich <k.yankevich@omp.ru>, =?UTF-8?q?Heiko=20St=C3=BCbner?=
	<heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, "moderated list:ARM/Rockchip SoC
 support" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC
 support" <linux-rockchip@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 3/3] drm/rockchip: dw_hdmi: avoid overflow of clock rate in dw_hdmi_rockchip_encoder_mode_set()
Date: Wed, 5 Nov 2025 19:07:19 +0300
Message-ID: <20251105160719.2917175-4-k.yankevich@omp.ru>
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
X-KSE-AntiSpam-Info: {Found in DNSBL: 87.226.253.162 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;87.226.253.162:7.1.2;spb1wst022.omp.ru:7.1.1
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 87.226.253.162
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=spb1wst022.omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/05/2025 16:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/5/2025 2:40:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Conversion of clock frequency from kHz to Hz in
dw_hdmi_rockchip_encoder_mode_set() can lead to integer overflow,
since type of drm_display_mode::clock is 'int'. Fix it by using
1000UL multiplier to avoid overflow at least on 64-bit arches.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5e3bc6d1ab48 ("drm/rockchip: dw_hdmi: introduce the VPLL clock setting")
Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 727cdf768161..ca31c2a4e440 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -277,7 +277,7 @@ static void dw_hdmi_rockchip_encoder_mode_set(struct drm_encoder *encoder,
 {
 	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
 
-	clk_set_rate(hdmi->ref_clk, adj_mode->clock * 1000);
+	clk_set_rate(hdmi->ref_clk, adj_mode->clock * 1000UL);
 }
 
 static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
-- 
2.34.1


