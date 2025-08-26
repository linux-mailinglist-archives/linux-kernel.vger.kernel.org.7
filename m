Return-Path: <linux-kernel+bounces-786928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F7B36DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE6B365A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622127D786;
	Tue, 26 Aug 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="Ow3AQbo9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7A2773E8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222849; cv=none; b=AOd8IyDA3teehbtHOhMqoI3EpBLSZMko2qTSsnIoErvPmQeIZfMIsxYM5AEA30PRA7QtRFKXx6QWryBq5hGwzgM7q4LXnbJ15pj3WUin3QG5GDbN/llNA6xhbOc/sPqZ6ND5XCVwF9vVM/gKpf1ftttljkbYTODVgKUWFxAcP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222849; c=relaxed/simple;
	bh=e1IxRhJNfBVPgixPhdtFHmYVX1m5TSkpTuyErZRKZio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGzPjDyqeoJcwownuzXQQCHryonx8VhaJwo321vPARG4KWPlp4PLJD4AWl2cW7i1kdqNE2KIN1OrHPFoqyu3DZjOvt9wOVf6Fo3b19gflzi4cOcoV6cun62FQinoIe63ii3HpfmyEL8Ipl34q6LYYMMq7lcSiENnVtWNQtawmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=Ow3AQbo9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-246151aefaaso39642245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1756222847; x=1756827647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6f+oL5erjgnIG54ke5F/FkltoGarOf5946uCvH5YNQ=;
        b=Ow3AQbo9wjVCDVcaaU4gbvdmlY+h3ZK2H5iRNjdPArRjzRqrPJMih3P1W0C0VsfljD
         CPhsTxYJJO7RkW6BrZZYvCoVpcoyeaBSsQfHivSxKGZXU6c8Awn1JhQ8N5uSwCXsnH+F
         /F4Z6ozOl6CN24IIT+5Kg0roAg/i4fQwOneO6K7cnG+3DragP4lFrIWjTLJuCQ4KEFiC
         1L/Czf6tt/1bbwKrwOiLZpUdXWSvasgDXqks6luZCm0NObnG5jQaBsP2PUadesMIW1h7
         LA6i9E7khFldrKjrbPedd7lV1xNYoMR+2+4Km7dHG13Tin5q1HxJym/z0nZ+doBhcMhA
         yO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222847; x=1756827647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6f+oL5erjgnIG54ke5F/FkltoGarOf5946uCvH5YNQ=;
        b=SZLqbeYAYCd/Jv6Yi+1gB37WRpzBe5Fl5uF+e1W6Q1WaMiv/NfydemDkoKQKrf8wv+
         LDqIlAjU/dIlZML+5BF7pnHF2juljdnsGmu8aZc3vvWVyW/hcdqjjqm5FuOUIuWyalaI
         RGtV/3MgveYWdYlkJ+Ep+HzZvSOL8U3ty0w7smnm0WNVOY7qkRYNOmmeKnHmePPmyEOm
         LEKGLyScDblIIn9tF02nd9zC6qGkr+dP1WIiJ52fPtItGw8nDWDb5g6YwTgL7IPxSNjc
         VPcCtYKp2rnHKy2mH/rMbKazMytIGf2oGqZRgrz0jhEFr2izKe7gG34NmWlVcXIYjKep
         xpdg==
X-Gm-Message-State: AOJu0YyZhlK1lJDUDLhh04+e59bxL0M5A5/szbwFKgBU5UZwSs+9Tf/1
	rkgTQZtAaSkbEIw5quxQ2Ast9xFdkVPfnyxfXfiEyo6DqCpzGQewXQuPaqLArErjeWhCQOE/ZWM
	B2XH7XHc=
X-Gm-Gg: ASbGncvE4PVJNsy1BYvWAmsIu3HjQmE4uACA5hmAXj+ZkM8txnrDs/hvJsMRlnqQfw5
	DpZCyj5OGoqPVHlYg12bEoKUIZKSGfuXl+ZaqwWdWvS9GyA9k6Y4BsXlweQjr72Z3HbcD0dvLl2
	RQyxTKnhQX+4PiDkWw/YbZ6M8Kr6vnrgKmHyN8enICNby0uBXIQEQ7Fp9cG5FDm6wKRvfp6U/JQ
	ZchGtlt4bm30KQZVfHHEXWj4ToJNjW3XFzueb9M2XzVay574Ov9NAOpXmvQi8anT8fRlWUpPSrO
	2QgPMgmTrwR1dnXJM98UYU76PrJ6kXVS5f7lfHaziD3/nRWxDGNvLdFgqZBafa8xUoqAGP1BIKT
	L70SPT4nOLcfCiOKtep8fWgSSbSWT39b83VsdVuOkNHtAR8bUNY4nQ1L1LCElAB4eX5gDbjvzNZ
	rOxLYZF3gmZlKJa1j1vI18GgnYalksZupwc76S3w93
X-Google-Smtp-Source: AGHT+IFhBVaZYGu9IKPFKe9pJlE3st+GV2WgnybrgrUPlI9dqOaccQqXFsDRq+o5QdSDJZXqXkvTSA==
X-Received: by 2002:a17:902:db01:b0:231:9817:6ec1 with SMTP id d9443c01a7336-248753a26eemr25285385ad.17.1756222846647;
        Tue, 26 Aug 2025 08:40:46 -0700 (PDT)
Received: from ajye-OMEN-by-HP-Laptop-S.compal.com (60-251-68-181.hinet-ip.hinet.net. [60.251.68.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246a4e7f517sm75905195ad.117.2025.08.26.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:46 -0700 (PDT)
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mac Chiang <mac.chiang@intel.com>,
	alsa-devel@alsa-project.org
Subject: [PATCH v3] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
Date: Tue, 26 Aug 2025 23:40:40 +0800
Message-Id: <20250826154040.2723998-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing op in the device description to avoid issues with jack
detection.

Fixes: 6b04629ae97a ("ASoC: SOF: Intel: add initial support for WCL")
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
v2: Add Fixes: 6b04629ae97a ("ASoC: SOF: Intel: add initial support for WCL")
v3: Add Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

 sound/soc/sof/intel/ptl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/ptl.c b/sound/soc/sof/intel/ptl.c
index 1bc1f54c470d..4633cd01e7dd 100644
--- a/sound/soc/sof/intel/ptl.c
+++ b/sound/soc/sof/intel/ptl.c
@@ -143,6 +143,7 @@ const struct sof_intel_dsp_desc wcl_chip_info = {
 	.read_sdw_lcount =  hda_sdw_check_lcount_ext,
 	.check_sdw_irq = lnl_dsp_check_sdw_irq,
 	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
+	.sdw_process_wakeen = hda_sdw_process_wakeen_common,
 	.check_ipc_irq = mtl_dsp_check_ipc_irq,
 	.cl_init = mtl_dsp_cl_init,
 	.power_down_dsp = mtl_power_down_dsp,
-- 
2.25.1


