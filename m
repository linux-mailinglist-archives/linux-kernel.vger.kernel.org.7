Return-Path: <linux-kernel+bounces-786300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3547B35805
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B322A5EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE762FF145;
	Tue, 26 Aug 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="bZf7RCtP"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA12FDC5A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199166; cv=none; b=CqLThfBQwyRgLtqZOyCVVRrHNEFZi3k4yiIqjDVAxawfW1+YOITixlmbA4NYLQV7WzEPFaNlIt+601vP35RGs5zXMr0phkrhBkpNzAU3VVoXLhR8FwR5FbBX3HMXTM6P0sISQ5ftwpc1CjWbztI3rrXJeBcegQ6H2HOZexxijn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199166; c=relaxed/simple;
	bh=YgtaFHi/bxrhz17NVyh3pLs5z1ygFjpcVAiiYPcL668=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ewh4pGImp6MUbynxmxAqVAILIRh4aZKMLEQ5cKPehEnsIgKGuSQVkbGPoXdQ//zk8RqN3iF5/bPpjN2K/pRWrgy3aC7d6+wWM5YAuCwt8OZo+G5PWYe9NH5vJvw2nSVdUAVkh5xfmMHe5HpIJ39xN6XX6Bv0LhDswUD9W0wjm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=bZf7RCtP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771ed4a8124so1448270b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1756199161; x=1756803961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZe1UjdRbGOPov6yiPQ0LhX88zH29A9ZZWF+7zEKVVo=;
        b=bZf7RCtPK9OLNLjQXaV/fGMB/bGS94pLw55cMqc6fi2YcOX9eiP9u4UUxRiR5pvkMQ
         9sqV82U2EwfsyBlasP05Px0ptFn/xvp0QkMBVK7wBX9yY4BCUJ1mBf28hDqm8LXmBpHs
         VRQnZQ9ajdJci49Mg943F7WNHNteGdCOHL5P3c16fI4uZKtT0PppBVE6S+55aDASFAgx
         76Dsblgu7Mf/wcof0gwfDgmw8I2rqsYJ5ai/69o8sUNje7giUYzm7EZwe3n9s3wdOjKZ
         YNeiq3BZqohZqgLCnwJU9UyZiKSk3mnx+J2sysau5X25i05enp6kZdB2lKkEhaWQzoXA
         DQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199161; x=1756803961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZe1UjdRbGOPov6yiPQ0LhX88zH29A9ZZWF+7zEKVVo=;
        b=nE8accV0lOZIYWyXd6R0++LIFwmfGmCqXrEYnK99vc+irXr/xWRtif/4jilQ9TG5Lc
         sJpKauh5JXPqk+FXzmV/L3z1JFYUA0h2TBAhwl2wTtjNFUzMUxXTn3seND5mugrv2AAS
         X9IxD2P8v+W/Eo7d+9kk115RRccF2i3W/Ov+otGbst+Rqt6Gqo0K6FFCHu12mq6Np2ve
         hlm+LZWrHHAVZGIsX+4qrhuc0tWMpwOvShgcQocTaV58xBcISg8HJ2EExpads14s2t+S
         kdLA43NrlGfY3IP7mDrbGddHDtBhS8NWtfkEUEPXGXsfZ3tmmgnzm6Dk07Hr2oFihBTU
         E77w==
X-Gm-Message-State: AOJu0YzYbhXdmgONtyZJP5vph4YJ3U9svnVRdNljtMW2BYafDVtjXvXe
	AdFSqp/5V5/ZqWdsl/ZF7jkFevty1BsQS3U2cnt0B3pY+TK7sKOnheo4WRh6P5cBIrHPheAfPBo
	nEs/mUCE=
X-Gm-Gg: ASbGncuc01EddSqKPKy1Qry8UB1ViY0tyoEvR64icwUGc8zyNZxReXaZYeR3gXXQVpt
	5HvzKuT7Bw5A8znu2SnQwjZeys/Xh6G+wdqwv6o8H2+vCXQTYww3MLxNQinc5opNGqM0hcsuMST
	UzpjFKs1BJjX46D/Esz2WxJlv+MMUvBRzMCmuza+On/VcXavY5w8Be/ur4iAbAjh1BzDrhrHyrV
	Uvy/piPrwFd7D4jKxAPYCUFoDNCgzmbaR7pral03sVkA17aLH49YVkU3IzEHNCH5hJdDw4amzpu
	Hva84jg0zgCecKKO3Mk1/hep2f0RKno08PN13fHAIo1NBqOPUA+FCr2m07MkBkomdV2Mrp3kU3z
	k7JqymGsAAbgk4yhet000aDwZr//mnUFIJWgwajUCOYUY+GuR9kI0Yzwv7RciYgAvSrGeeN3h28
	YVsUdzEfioUsUwVloZoJCVnHSWDInP6Am8IEga/yDBIjtsL/9L03w=
X-Google-Smtp-Source: AGHT+IFF3yN7+WJotq830CgHmPvmXMKEJdmaqjUoUbu/8vEGyPahcd8Cv+OX2SGGHwyFylNgl8pxFQ==
X-Received: by 2002:a05:6a21:9999:b0:23d:ac50:333e with SMTP id adf61e73a8af0-24340e6bd14mr22095061637.43.1756199160864;
        Tue, 26 Aug 2025 02:06:00 -0700 (PDT)
Received: from ajye-OMEN-by-HP-Laptop-S.compal.com (60-251-68-181.hinet-ip.hinet.net. [60.251.68.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm9796053b3a.79.2025.08.26.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:06:00 -0700 (PDT)
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
Subject: [PATCH v1] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
Date: Tue, 26 Aug 2025 17:05:30 +0800
Message-Id: <20250826090530.2409509-1-ajye_huang@compal.corp-partner.google.com>
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

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
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


