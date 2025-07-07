Return-Path: <linux-kernel+bounces-720603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A042AFBE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B1F3B55A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0824C28BAB9;
	Mon,  7 Jul 2025 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeWRsq9o"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD7261595;
	Mon,  7 Jul 2025 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926478; cv=none; b=uyxfIz3bRBHoAJFYNVQDeolXi7THaESIOrCSpQ3C5oEitcih7lhOfrgl59CNFq/8Zyc1rrSV2Aesj3bndOYm70ItOlu866rdGqXM12mk4WLr3F5iqJ8VI+TLSh5UI5q7o2pVtcGsOX8/V3CHZMZYFOI1lsKxWHRqPLHZ2qA2+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926478; c=relaxed/simple;
	bh=PkpmXhSUusw2YrpYvb3I2lF/EyWtf0lTKoUVC5rAAC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuDXq2NqtFi/Iw2+YFzUZ0aJgOzf9Ld6yAcL3sWR1fp2ix4QWVLakAYvr12afsycSQrmGruJvSkyX0CQGyibkRTCvAqXJWMvcK0sSZELhlfLGvOWl2gzQp+tjVFG7qjI7GrkyX0eSYYbsQm4V0xY8GNswyNYnFYgnF+xtxxx5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeWRsq9o; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae361e8ec32so746073866b.3;
        Mon, 07 Jul 2025 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751926475; x=1752531275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkUPzwtMXYgPO/Kb/C5U1ws9C5WYTeb2Se96g371Yls=;
        b=CeWRsq9o1ZjkcqStm9lBjqA/vRg8wN7gFwTlYbOVuQdJ7ivW8pDk84Qfsdb7a0n0Wl
         oTkYL6fcgk9KoXhibI1F28YhmXgeRC4e+JyR/onpg2oSA2UGsotYZl9ngeh4lAR2MlON
         kjfp2hVWQhvfITTdu6EaNr9+/bRyvcMo9rYAXKwzI3XGXVPrci5gYXeYA6QTuP3LNBzT
         +FBJmI1T/6jlsTnMMekAY5AJwG8XfoJf+L+WZDhrrCAF1CI7P2tOQcANAOXBN7lLB18Z
         Jggrh8KVGOTlmx8XCGEtSUCho/Hc3sevW6ba1M/iPr/VvVFoXnDueM+YT5irhVRXmq/8
         80DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926475; x=1752531275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkUPzwtMXYgPO/Kb/C5U1ws9C5WYTeb2Se96g371Yls=;
        b=qjzEww4A4UBrZnY8c5upPKdFRaRyg2KhKHxBh3IWfORy4vtgjqGFG53rf4eoK+ygzB
         qrCJRXaX1XTJF2/soPPD5IUiieS9KXp7ne5rrTZP3brpx5YdzTGu/P+PU29v3HqqMtIv
         S+JiZxtMUAOZ+r2DRI8uHafMEJoX7IyOcaZleqXaOz99ht8XXSq1fSkiE0xGImQ4fArf
         yibkhW6KY33VxOlg2d2FjXpQ6ARlOOsx6XbawnTEfZnChjQUR30JEPRRj50vxC6Ro5WV
         OTRjEEMBAPz1WvDTAusRv81voWJtvnXp1f2ACovMi4I2WhOjV42OX2nQX3034kGT8ZQF
         ImuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvQueIMNnS4LC5eIFt7KRV/vleR8bgWbyDMKQu6CD4gwttakWVztuh8LrGdjjMz+Jcj5wH4bebe7TLIDo=@vger.kernel.org, AJvYcCXVA9gP3WcT/vnuC721O0IiJ4KUomv+oAfRcMXow8t7TnZe88n/J8O2kjnhdtF2SfDF/qcKpvgvyl8IREk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyB7Xh98xBtUa0yz1xp+aSeN8JA8kZRdr2d/et3NlKEXhdNAc
	icmE3lUePZ1l5FepPFD2t0n7hTCUplt68+KoVedMW+QFrZgyswmvbfib
X-Gm-Gg: ASbGncvRUI5/8SjOd0ynzrIRbpvSzrs7dKz1Qo9SoPJIS5kJJzv5ikVAQ/fSkBZ+DX2
	ZAwyJEvL4LVcXEqjIMJKunSXWHxqckQ/tFb8TV82XEEvw0kXaXHdYVFMka91mhFwUWaZOm3A1lC
	21g2Dyhhg59WFH6hJO7byKU07ti2QLpPchWEtAz7/U81bL/hSARXS3Z1YCGOg2eJ00tUKkikHmU
	OeawltuI2CFIhWt/DMs0W2GjVYOeI8BVEZVl0qP5vMpbTd94WdS6amJkRHchKO4lGr+65QV+c+k
	H/RbneSqj75FYJq9OGCB1csJtWo7ID/7/U4bOrBEfOIK/Ed4g9bZDhBGmyMrdBUfA9bdkmMF4h0
	ZvoEydw==
X-Google-Smtp-Source: AGHT+IGT+clpfM3l6sMVkuSJFA1o1pzCYQ3UJh3NumRLa9tcWKfiaW+WoS8mlYXbSfWNLIzSmdCG0A==
X-Received: by 2002:a17:907:7e92:b0:acb:abff:a5b6 with SMTP id a640c23a62f3a-ae6b0b77a25mr58480466b.13.1751926475133;
        Mon, 07 Jul 2025 15:14:35 -0700 (PDT)
Received: from localhost.localdomain ([89.149.95.104])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm769217666b.180.2025.07.07.15.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:14:34 -0700 (PDT)
From: Alexandru Andries <alex.andries.aa@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	venkataprasad.potturu@amd.com,
	talhah.peerbhai@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Andries <alex.andries.aa@gmail.com>
Subject: [PATCH] ASoC: amd: yc: add DMI quirk for ASUS M6501RM
Date: Tue,  8 Jul 2025 01:07:30 +0300
Message-ID: <20250707220730.361290-1-alex.andries.aa@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add DMI entry for ASUS Vivobook PRO 15X (M6501RM)
to make the internal microphone function

Signed-off-by: Alexandru Andries <alex.andries.aa@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 97e340140d0c..61fcc30c3353 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -416,6 +416,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6501RM"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {

base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.50.0


