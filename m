Return-Path: <linux-kernel+bounces-826331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2030B8E354
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9609517ADBF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9837F2147E6;
	Sun, 21 Sep 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqAlOYID"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0891E8324
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479910; cv=none; b=hN31a+oMpQmt658+dwHXlqenvUOcrp9L7nGGUTSAIAFupDogk12oQV4h5gw27j909KOU68gr0PLTpKrAQr88MVkcujmj70gaYtusxe5s6vPfgBvmz/xF0HJdA4yluF/2rOQmVuI8FihfXeAvFA5CgglEtpi2TsHa7XRzWid4eM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479910; c=relaxed/simple;
	bh=1dTtzDC6tZE567amj3+s+yhSP+wPAp0a8+47DgV7k8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQIB5BMQ4yWEatXaSt9hvWBcLh2PfHCpkABLX1cZ3/ipR9b6YQODl0sGbecalSZlVtROb/7p2/lHqOB/5bYqClHVfMtqB/Ytilk1DUu5ReheqWxFNuf9O/q6D6O+OrOHMbeTGqguQpHbSyKX/3ieU85YTSrcFG1KLUHy5Ucq+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqAlOYID; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267fac63459so34688335ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758479908; x=1759084708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FG8Bt7npKalhz1su7W/I5V9S/1CafpuEGaa5DL+2Qi0=;
        b=PqAlOYID7AAaB8eh5BKe3kI67+nj0k49XsBlf0bEztj809nbEcDa+hMTgb2LbZ55w3
         XswIoZ4JnBqZBMk+dl+ZZjUBB3AImK16EyiA3SW+2/mADFYo/Ar7VJPOk0fU6pubJcqx
         YyHUk45Ky708RpB36UdrnrWZFLwMdFO5VBRc+/mEaLeuKdlcQsq/+0pk78F6g0iDImNB
         GozMxsnPS1Y79lfOLOY8rgV85O7TCP5gY2MipeRUOrhUtf4u6rcBVCR3fzlBl0VbfF76
         0XbLlzgvyqpC48H5V+Jh5amy3X74zs1iIVNpRwRLIkjzZ1t9S8VruFcQlWBXP2HHuvQW
         hJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479908; x=1759084708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FG8Bt7npKalhz1su7W/I5V9S/1CafpuEGaa5DL+2Qi0=;
        b=MH4eiC5lHRuPaTekYeH7h+lytFsJ+t72FaF2xm1y/LgGBrCjUfaE6Tp9KeYWTjIcKN
         QX0tkyMNUr37e0dqbO2C7qeVltCVnXFt+5TkTBa724BM3J6no/l48w/D2bLcTrFf7BEv
         45SOynXHxwFy+dFCCX4dTaZbTdbfjyZIUOO0vatOAD6wJcTZHGrs3V3OP+He1JtMfUtg
         hchXZfbQg9ci5y9ms2y6Hf4OuKLEnTbzOlfC4c9UULqIJAnJIsTE6qTUE6BHLObRsHL+
         Ji7CuEV0udHlxisnbrwxAc6KWLAdvUujGvSKHNk3sq/s4Nui/YZNclvO9lXNZKPeLAv3
         6nuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLsb3gZuxtev7JbXFK5AAfnhhyYFhPZ1NvPgG+KHzboPcV1+VdxKSWKBJMYSFSIOPnnnvtrK54guobbJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyx5poiTpF2TAErvf+gZm5+II9q1xCwvkLCzUg9dBQnz9y4H6
	PwRYSHDHapChiCpwO65XTbEb4cPoQ9xMiXvaxyHEqGZn3Cfo2Lrf4cl1
X-Gm-Gg: ASbGnctrr9mn2cDRejiA9cjPHFrEuHI7Fkg06cVe1fOtTm9tIV2e9hcuBedt6P3JTNZ
	J1scqA93so7AWEjRran7pgVCQbEnJw1bqex5THjxsS6GvRNUew7j9njxccC+YX9FJir525ddL0t
	qBOtYrGQvBrIRMCa0Hhxtlj6zKZqivSQKd1oFVL2YBa2fGDF/8Co7O+0wklzuuzSLxPNb1UDHAv
	Ue4IwlyAUwshqv+EWuyPrnNEdigHucdcT2bqlna90xW22Wr3r1f8da6gstoB1Cj1JenJhAeX8xc
	s1MSf2hqBqe+yu5VlNcCERrYomMq4y5GbNeYgESgisk0CXmseWsRSxS0PN3d6DE8YCYvNOOL+Qj
	nIrqZhAug15RTTotjqA==
X-Google-Smtp-Source: AGHT+IGVujox0fyaNT3MucK6Cw+loJTsxMamdU8PPqz9OPA70Qfq4hxxfxRZjg3jA0wAYGw/vNjnww==
X-Received: by 2002:a17:903:183:b0:268:1623:f8ce with SMTP id d9443c01a7336-269ba40dccdmr118789165ad.10.1758479907783;
        Sun, 21 Sep 2025 11:38:27 -0700 (PDT)
Received: from fedora ([45.116.149.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcbesm111053795ad.88.2025.09.21.11.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:38:27 -0700 (PDT)
From: rtapadia730@gmail.com
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jessica.zhang@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	Rajeev Tapadia <rtapadia730@gmail.com>
Subject: [PATCH 1/4] drm/panel/lpm102a188a: Switch to mipi_dsi_generic_write_seq_multi()
Date: Mon, 22 Sep 2025 00:07:18 +0530
Message-ID: <20250921183720.237761-2-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeev Tapadia <rtapadia730@gmail.com>

Replace deprecated mipi_dsi_generic_write_seq() calls with
mipi_dsi_generic_write_seq_multi(). This avoids hidden early returns
and matches the direction of other panel drivers.

No functional change intended.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---

Question for reviewers:
In this patch, I switched to using mipi_dsi_generic_write_seq_multi().
Currently, if both link1 and link2 return errors, only one error is
reported via accum_err. How should this ideally be handled? Should we
report the first error, the last, or combine them somehow?

 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 5f897e143758..982cb61849a0 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -162,27 +162,34 @@ static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
 static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
 {
 	/* Clear the manufacturer command access protection */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
+	struct mipi_dsi_multi_context dsi_ctx1 = {.dsi = jdi->link1};
+	struct mipi_dsi_multi_context dsi_ctx2 = {.dsi = jdi->link2};
+
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx1, MCS_CMD_ACS_PROT,
 				   MCS_CMD_ACS_PROT_OFF);
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx2, MCS_CMD_ACS_PROT,
 				   MCS_CMD_ACS_PROT_OFF);
 	/*
 	 * Change the VGH/VGL divide rations to move the noise generated by the
 	 * TCONN. This should hopefully avoid interaction with the backlight
 	 * controller.
 	 */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_PWR_CTRL_FUNC,
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx1, MCS_PWR_CTRL_FUNC,
 				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
 				   MCS_PWR_CTRL_PARAM1_DEFAULT,
 				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
 				   MCS_PWR_CTRL_PARAM2_DEFAULT);
 
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_PWR_CTRL_FUNC,
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx2, MCS_PWR_CTRL_FUNC,
 				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
 				   MCS_PWR_CTRL_PARAM1_DEFAULT,
 				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
 				   MCS_PWR_CTRL_PARAM2_DEFAULT);
 
+	if (dsi_ctx1.accum_err < 0)
+		return dsi_ctx1.accum_err;
+	if (dsi_ctx2.accum_err < 0)
+		return dsi_ctx2.accum_err;
 	return 0;
 }
 
-- 
2.51.0


