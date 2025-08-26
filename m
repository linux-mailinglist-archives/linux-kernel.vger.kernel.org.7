Return-Path: <linux-kernel+bounces-786394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 126DAB3592D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6041B66369
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB3321425;
	Tue, 26 Aug 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="VjS/30TQ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955531812A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201057; cv=none; b=fAulTbxmb1cHiRJPD5PXEdAJGuw7ocgqX9W0ShLMYKT4fB0EJ+h3pSScY7uuKqVmRNQyvItuiueuAVVikCMEL/rYFCZazGE5kZbb6Ig5phlEfT493pLgoFceGu7BRzW6xe+8sGDHjvLjx9jotqFEDm+RiWILt/JynqdOEBQo5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201057; c=relaxed/simple;
	bh=rOnwfMAg3INdElV3aRVOTwiBkwEa8av1tj4H4Fl0SEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VV9xUIff/Aw5Q3ILcwqPBiCrw0owmRnOwViavT5Ecuu2AzcArvCiuZI36YR6N0Fys1Ioj8Lz3wRdo/aJsBXl74OQOE5icCKfN80OjTy+RWASKLSrv5LdHEm6pKcfTdVvEKDfJWjF9dF5sHoCJilZQfACigJERZjhrnMOY83dyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=VjS/30TQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-325393d0ddaso2513550a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1756201055; x=1756805855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3mcb5bkMtc2XORNKLuQuVAdE/1TJbciXhfUQDl6LaYc=;
        b=VjS/30TQaZBXx2j6q4eLoGo1RC0zSL25RQunMDDTYrLdCjS3CUJbI5EtSYVWmoUrM6
         CbG2+K7iQ86phiZMUI3VFK2WgFtN6AXELpYM+sK5kAcL9i5vl3I5adm+aFf1uZdTI24c
         ikrdLRB+hzg69kIA04jbXg8LIrS4wYJWR1CUNp7w40o2EVDF17hG7DoS9wOultzhvgpH
         UIyrDcPeS5Kn0kL6W0Yrr1/72UOi1gfoK4owFcWZCSbNMw70IngPnSPMwZNWxkFwVt2C
         tHWRjdzGXmsjuyg5FfSFVD5r6EB61CNTy4FOwtorv7eg0l2Tfp8k2HkjZh3wtFeg5JWK
         DPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201055; x=1756805855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mcb5bkMtc2XORNKLuQuVAdE/1TJbciXhfUQDl6LaYc=;
        b=DRYmg0VT9zokK60A0kKD9r5+sZqHro24kCLoC7SHZQrsObbQManJdhpGxWVvxipfpU
         gJxOytSE5N614gAI8XuaVUT2Z0jaLOM7EaJZFWm+Cm68W3qNZwioeB7xC16/Bg0Kswxf
         kgL8fzRP72tH4cX8pJAmjAuQ4FKk8CKa+kPQqrBm6cewzx0NtkPlyNzKZQgkX6vRB/8G
         Udh8QDGD9Cz2v7NjMv5owzspKIRP2V8Hth0BbcKg94OWpWlhcv2VjSqY7B4FDmlYQl9a
         PhM2IV5FZOKCieKpZ/VW2FaBEJejLFFpQj76+rgZ02S111S5cOZompKitbIDEvhA+0M/
         Eaeg==
X-Gm-Message-State: AOJu0Yxc9rfVWybZtUvDBWyj/KapQJg36dyLAw1V54zf44OUV+MycRPz
	MyU6DmR8qBmi0RXPGww8aArcao8PRz4QopPWYNSX9xf716QPelc561QweFnWacoSO2pgQpE8X+b
	r2/a+t1U=
X-Gm-Gg: ASbGnctaWoMXnfSTz1a+az9gob4nUE5K11LhSp/WAuQ6VurM82z6+Bsp8m8rIYsRYpL
	FJDtA5rC2P7InU8dGR+phSdAibL77PfaQ3FXqHbVbKCLW8QflTR288ERkSCBwX3aMdjbeUlW/24
	0HMHiBO53wBZMWGEWOQhMNcRbmnrTtgVFkUqe1RMfyWrcMLwW+XOMh7uYxEAGV4e4hsbMNztXHQ
	qNTgCXKB7i4vi1DXg+n+7jqOnQRiIkq/5bGqeU6vp8o7YcwtjgrL162JCxItZ88N+B8yYTXbjrZ
	un4LAAc5Y2/5URxzMsEihVv2mTZnraSft7b2XGTOS0fj3fFiGh7QHr7JbJrAnBfscKOn4qhkOcm
	x6WUdeJNCVhCJGhSwoT3BI1JNuWU+Jg+XSxoBznepyZfkkEwp8N4DuWlCLXJDvzX81bPSi54CsC
	mhlRsCdnjGD0T91V0nqZsWmyqW7wrQzFXHxdr7ti/e
X-Google-Smtp-Source: AGHT+IErMpCIz6xZ5L4Dai10sGE88F9Po4L0thCMVQfmK480d2PRNhldDxgRTc81OY9BE4TV9ujwsw==
X-Received: by 2002:a17:90b:384c:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-32515ef86fdmr19131536a91.13.1756201054504;
        Tue, 26 Aug 2025 02:37:34 -0700 (PDT)
Received: from ajye-OMEN-by-HP-Laptop-S.compal.com (60-251-68-181.hinet-ip.hinet.net. [60.251.68.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32549fe6c21sm9530925a91.5.2025.08.26.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:37:34 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
Date: Tue, 26 Aug 2025 17:37:25 +0800
Message-Id: <20250826093725.2432153-1-ajye_huang@compal.corp-partner.google.com>
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

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
v2: Add Fixes: 6b04629ae97a ("ASoC: SOF: Intel: add initial support for WCL")

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


