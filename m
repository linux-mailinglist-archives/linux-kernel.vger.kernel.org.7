Return-Path: <linux-kernel+bounces-886872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A26C36A67
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4CD1A201BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7C330313;
	Wed,  5 Nov 2025 16:14:35 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F672FE078
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359275; cv=none; b=kYDIe2n7lcNqGxh2BLaCD/b4r1U/bX8juxBVfSgt7g80QKrN6cSBn8qz67M8v2Esc1suSeEMzvQ0vNwsbs4pKSB/gMY0RU7lCOFW6Mj70eoC9x8NY6MSXwSP7uyni6pM8WbcvG0gWPsttGUeaXpR6kXP0oqaUjQf/2eBbg/OBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359275; c=relaxed/simple;
	bh=vJkMVq6G2qN/73t7UWvO7phQ40as8q3ei9NmRcEZJc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0OmDVKR6onp90Ma2koltUnUXGacYZGj8JIx1XYO2+hZu+kxecJgxgCWpS2qNUE0xKUiDxqOXpDo+79Tn+5wsQhJWRXrMX1nrscrvMqND5Uu3wO68nhpB+1LIa9jZHn7e01bbiKXikVgKk79IqZp388pCtxzodc6dXmCMzgPn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst022.omp.ru (87.226.253.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 5 Nov
 2025 19:14:21 +0300
From: Karina Yankevich <k.yankevich@omp.ru>
To: Sandy Huang <hjc@rock-chips.com>
CC: Karina Yankevich <k.yankevich@omp.ru>, =?UTF-8?q?Heiko=20St=C3=BCbner?=
	<heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 0/3] drm/rockchip: avoid overflow of clock rate
Date: Wed, 5 Nov 2025 19:07:16 +0300
Message-ID: <20251105160719.2917175-1-k.yankevich@omp.ru>
X-Mailer: git-send-email 2.34.1
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
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;87.226.253.162:7.1.2;spb1wst022.omp.ru:7.1.1
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

This patchset fixes conversion of the clock frequency from kHz to Hz in
Rockchip DRM driver to avoid potential integer overflow on 64-bit arches
(it is not possible to avoid on 32-bit arches due to the clk API using
'unsigned long' for the clock frequency).

Karina Yankevich (3):
  drm/rockchip: vop: avoid overflow of clock rate in
    vop_crtc_mode_fixup()
  drm/rockchip: vop: avoid overflow of clock rate in
    vop_crtc_atomic_enable()
  drm/rockchip: dw_hdmi: avoid overflow of clock rate in
    dw_hdmi_rockchip_encoder_mode_set()

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


