Return-Path: <linux-kernel+bounces-753937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B8B18A55
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7104A567C4A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0C213AA2F;
	Sat,  2 Aug 2025 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="KBKETv+3"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC72E3701;
	Sat,  2 Aug 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754099845; cv=none; b=CybBk8oIFCMv5r0Wx5+E8zzqVw4lR3CRJvo6PxkbR2Q67XFygEf/36VkKiVvLJDIN8VfZ81dGGQcdz5LP7FXiYyzhGEu98AylwiAClGpv04FtE1ZoDAVMOOH5Mo2tvtoHJIFOeDcGNbHAzo/VTIvL1jlY+xw6WMZj7D2MMN+eBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754099845; c=relaxed/simple;
	bh=AyvojaMUL5GFQ+RGadkxrq01+rU8vIQIordppxfHfyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pCql5fGcpOWTRoqP0lUNvioUeLt6qWdxP3bvfqJj/CQTleDJgQgiqmR+SmvKjdpF5/lfWTara5ghB/ZJzVZHgox5oYdCPSZlTvQMy2VxoLxqVhxJ9DnGg8Wd57It0BKHzROfjheB2VbpgBcW8BJw1yX5a0OPDKrarQ7qeXLaDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=KBKETv+3; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bv5NR3vbxz9sVv;
	Sat,  2 Aug 2025 03:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1754099383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EzGrUiyur0PDjcm61AO5Pdz6n1eUAx7WVBcJE1M5ghA=;
	b=KBKETv+3sEn4+XGT9mbrJOg0yaagruc0IT5vaeqTj2YVlqYcjzsH7KjETLEXJxPsy1hVwE
	E45fIwXmyhixaxPPKTeL/DQL6bp5OLr4Azj6DhyMTT6rlJ3heU8qh5P79xERxT8TQe++YA
	iNRExyn3f7fEvskBrg6iU+rm1Sx4sXFDCakS97jTyWMoHXDRDvGmgHBJ0LXlGx5/I2KlEZ
	z6fPO09U5Q0SoOtwMUFi8zaPTVSb/ub8uslLDqgfep7DvRr/O7Uzn5vKDOmNWkXa5ff22F
	Kz1yXvRpDxY/NEolfMIqimb/+YntgGVp3FXXpTGjDD8+lTvYk/asjxYXY+l9RQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 01 Aug 2025 21:49:26 -0400
Subject: [PATCH] drm/nouveau/gsp: remove always true if check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-nouveau-fifo-v1-1-25b9db5283bc@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAKVujWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwND3bz80rLUxFLdtMy0fF0zY9NkM+M0c/PkxFQloJaCotS0zAqwcdG
 xtbUAKUL4mV4AAAA=
X-Change-ID: 20250801-nouveau-fifo-635c63f77cae
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=AyvojaMUL5GFQ+RGadkxrq01+rU8vIQIordppxfHfyk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpQVG1iZmtseEdmeHQ1Q0h3ZXllcWUyZFdjeHJsdmcvCkUrTFZ1dWprdGRyR3NvWHBW
 bjVIS1F1REdCZURySmdpeS84YzViU0htak1VZHY1MWFZS1p3OG9FTW9TQmkxTUEKSmhMNWlPRi9
 4TzNMUW0vclp3Y0dpcC93RDNBU3FDdlU1UklxaUxHZGU5RFJZTWE4czB4bURQOXNWbjZ0MUZCTQ
 o3SlV1bmY1amJ1Q1U0SjZwRlp3TllsR1Jxcm9OT1FiL1ZaZ0JyYTlHV2c9PQo9a2RtRQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

if (1) always evaluates to true. Remove the unneeded check.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c | 36 ++++++++++------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
index 1ac5628c5140e66d306a1aadce10c810886afad3..104c72ec359a07a318ac99f5c217f0b07db2b784 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
@@ -188,32 +188,28 @@ r535_chan_ramfc_write(struct nvkm_chan *chan, u64 offset, u64 length, u32 devm,
 	if (ret)
 		return ret;
 
-	if (1) {
-		NVA06F_CTRL_GPFIFO_SCHEDULE_PARAMS *ctrl;
+	NVA06F_CTRL_GPFIFO_SCHEDULE_PARAMS *ctrl;
 
-		if (1) {
-			NVA06F_CTRL_BIND_PARAMS *ctrl;
+	NVA06F_CTRL_BIND_PARAMS *ctrl;
 
-			ctrl = nvkm_gsp_rm_ctrl_get(&chan->rm.object,
-						    NVA06F_CTRL_CMD_BIND, sizeof(*ctrl));
-			if (WARN_ON(IS_ERR(ctrl)))
-				return PTR_ERR(ctrl);
+	ctrl = nvkm_gsp_rm_ctrl_get(&chan->rm.object,
+						NVA06F_CTRL_CMD_BIND, sizeof(*ctrl));
+	if (WARN_ON(IS_ERR(ctrl)))
+		return PTR_ERR(ctrl);
 
-			ctrl->engineType = eT;
+	ctrl->engineType = eT;
 
-			ret = nvkm_gsp_rm_ctrl_wr(&chan->rm.object, ctrl);
-			if (ret)
-				return ret;
-		}
+	ret = nvkm_gsp_rm_ctrl_wr(&chan->rm.object, ctrl);
+	if (ret)
+		return ret;
 
-		ctrl = nvkm_gsp_rm_ctrl_get(&chan->rm.object,
-					    NVA06F_CTRL_CMD_GPFIFO_SCHEDULE, sizeof(*ctrl));
-		if (WARN_ON(IS_ERR(ctrl)))
-			return PTR_ERR(ctrl);
+	ctrl = nvkm_gsp_rm_ctrl_get(&chan->rm.object,
+					NVA06F_CTRL_CMD_GPFIFO_SCHEDULE, sizeof(*ctrl));
+	if (WARN_ON(IS_ERR(ctrl)))
+		return PTR_ERR(ctrl);
 
-		ctrl->bEnable = 1;
-		ret = nvkm_gsp_rm_ctrl_wr(&chan->rm.object, ctrl);
-	}
+	ctrl->bEnable = 1;
+	ret = nvkm_gsp_rm_ctrl_wr(&chan->rm.object, ctrl);
 
 	return ret;
 }

---
base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
change-id: 20250801-nouveau-fifo-635c63f77cae

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


