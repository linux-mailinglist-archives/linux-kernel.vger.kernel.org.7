Return-Path: <linux-kernel+bounces-778781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E8B2EAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29A81C87968
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AEE253954;
	Thu, 21 Aug 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrqfgCSF"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3271F91C8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740862; cv=none; b=Pw389V9Y7OWdfCzMuFqyRouT1qxXTeW3ACWja0dlh5i0ja3zD1Iqy4uhjx7AMIa/cxl1RkY3oSz7z0VEZCar060TbBsj83eBnZUJMUTOgHpIIPFkCYVzcqfFcF8VTWQJ+RZtVXaJ+HUCw7nM/43hVlPdG8eFWsITAQfb/5lDV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740862; c=relaxed/simple;
	bh=FwlXjDOvoPhU3ws3aopxzlxmseKwaQiXbFytY4DUmJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocipExZl8AtNvlAQEGTzqH1bwaatZOffjThbCaCZ/x8kLfrGi3ckP1sNouHP46AqysLuENLeEr5mBt3U3/EJhlAF7GwZUxC3fk6yINGgG4cjJMOUPdMSIpWQpbI/RPudCgbnvX/S+a7WyUzxFo0kWf6mFHVdeybOcVxNb5lp4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrqfgCSF; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e67d83ed72so4168525ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740860; x=1756345660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epz/iAe61wK5d2iPWv/y8Ta3anyLI9CMIK3ZJbjFUR0=;
        b=FrqfgCSFVfhpF2oY28woZrgVQCCWfUgZkyTjMIQ9SYH8lmxd8YCFy7Ig+gVTZEEfNl
         eyiPFOQp84kqAzLU+POX9pIEcQ3I85FWHzYXgmyI/go9d0ZmZJHsQ9nnP+qhOJm3Kygp
         wN6+w6qNpKfZZ5qSf8GjzxuMCT6r0oUzh3OQ/dgJiQgipShCdzdH0y30Z/PdHXCdaKVW
         7FVfJU4royyq01R0TkCUN4SGuaHkVKPWx8Me2mfFY9GWBxZVQcH3zw9SUpMk4IMGqKox
         pJTbCvNYiyHPi3472M6TY4/94fjsuKRWUyCc7wGN+XLcVkgfEhia6AS+eVazOOF6lBZg
         8EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740860; x=1756345660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epz/iAe61wK5d2iPWv/y8Ta3anyLI9CMIK3ZJbjFUR0=;
        b=HgtjCP+Bw8zoDVtEPVwtJgzlS1MmmH9o3r+sSEys/Kv0Qc256fIE9xeNqV6We8JCll
         p5fAT6IEyfQ4ZHKpsObljpoICvAattouazwd4aQvgssJ+Ryco5AI5gVBi2ggDIfE8DrR
         6ANQXmseGJAazBqpWre9gWpnPh32gxgugHw1Hgsoq0dfXsyXWyC6/Xpt2cvYHsjeiJ26
         N0wZRm7filJ5UCzmBjp8jshiAtQ/wzqcorl36xXWRz3G+tue7Rd37q8xC8dGSKidKoc9
         d+S0FAIzNz4rbIYX2iTp5eGDAc10gquBLWBHnoGkpma1tmd+Jum3jaAe812x1Oix4RZe
         jLHw==
X-Forwarded-Encrypted: i=1; AJvYcCWzLLxhSbYMJLDfSaQgtfzO3axO3DOdT0xyWoiT9O4OIHnKFfZNbc9+jL8/Mxum8ypXx69EXsv40tHUo5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2eAm+E5uuMqB+sIDoo83q2WUPbHI6IaQzaOqAu4sE5EQ/aeB
	xScIXrUlQOf0/z7GrFtbRti2/1BY8Rf+58fMcb7JitC3Rkyo/mQddAzr
X-Gm-Gg: ASbGncvlr/ny+N/jBarJHTiYPuyBi7AGwW7nbQZTO37XFyj573Us4KP6XHTEsAkJDpc
	ikVLrWX0sT0mUHLgdoJ5N64tt0JfPVlMkVlM5s/PKwd03BHQaF8gZH0NwHeNtbJgJLDgmMfQRkk
	qOCulMNMW1lJUYcSjYV/2s6jcMPZlFYpW1jN+r9jCCpAjnjnogD+QUPVmCykAWIK1rblfKpWLFY
	cchSkwxsTAtIWABvtArZypaxgBvfbVPmY4amWS1YzHzK7kfyLRFwA+YoX0rppgxjNu6DRHFmuHE
	vZsqwoRh/TJfR9rpLNnf1Buo7Trs3KADO9oa7o10eLZdJN95cBrxi1HWe87FdnmBx0BoJln7fxT
	KIYAIa2WHCbYKDWorO87DXZE=
X-Google-Smtp-Source: AGHT+IHZYK/ax1hgY4iz6VhBp4wSokshN6ZQFy/MFAt46+tVGOtms3R7YW/2E72HwIFvuBCTIlaxiQ==
X-Received: by 2002:a05:6e02:228b:b0:3e5:67a6:d417 with SMTP id e9e14a558f8ab-3e6d444027bmr13182265ab.8.1755740860024;
        Wed, 20 Aug 2025 18:47:40 -0700 (PDT)
Received: from aperture.lan ([2601:40a:8000:28d9::f29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e67e6abec0sm12430875ab.48.2025.08.20.18.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 18:47:39 -0700 (PDT)
From: Brady Norander <bradynorander@gmail.com>
To: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	amadeuszx.slawinski@linux.intel.com,
	tiwai@suse.de,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	pierre-louis.bossart@linux.intel.com,
	Brady Norander <bradynorander@gmail.com>
Subject: [PATCH] ALSA: hda: intel-dsp-config: Select SOF driver on MTL Chromebooks
Date: Wed, 20 Aug 2025 21:47:30 -0400
Message-ID: <20250821014730.8843-1-bradynorander@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SOF driver is required for functional audio on MTL Chromebooks

Signed-off-by: Brady Norander <bradynorander@gmail.com>
---
 sound/hda/core/intel-dsp-config.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
index 3cb1e7fc3b3b..00f184917623 100644
--- a/sound/hda/core/intel-dsp-config.c
+++ b/sound/hda/core/intel-dsp-config.c
@@ -167,9 +167,9 @@ static const struct config_entry config_table[] = {
 
 /*
  * CoffeeLake, CannonLake, CometLake, IceLake, TigerLake, AlderLake,
- * RaptorLake use legacy HDAudio driver except for Google Chromebooks
- * and when DMICs are present. Two cases are required since Coreboot
- * does not expose NHLT tables.
+ * RaptorLake, MeteorLake use legacy HDAudio driver except for Google
+ * Chromebooks and when DMICs are present. Two cases are required since
+ * Coreboot does not expose NHLT tables.
  *
  * When the Chromebook quirk is not present, it's based on information
  * that no such device exists. When the quirk is present, it could be
@@ -516,6 +516,19 @@ static const struct config_entry config_table[] = {
 /* Meteor Lake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_METEORLAKE)
 	/* Meteorlake-P */
+	{
+		.flags = FLAG_SOF,
+		.device = PCI_DEVICE_ID_INTEL_HDA_MTL,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.ident = "Google Chromebooks",
+				.matches = {
+					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+				}
+			},
+			{}
+		}
+	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_MTL,
-- 
2.50.1


