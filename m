Return-Path: <linux-kernel+bounces-752437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E83B1758F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DF13B50D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78324DCF8;
	Thu, 31 Jul 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZhxm4J3"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17778C91;
	Thu, 31 Jul 2025 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982478; cv=none; b=jTvi2xHSbrHj4GwGSX8HsJzaPzwCMCIA1P0/aBd4l1TSQDtI5YgKQTKqZqjTm2KYpB4DR8ZZh9WunJ1qtqrYLQRhBPnJTLbWZsxSVGKQATdONT1a2wIQ48ZppSA26CEqRie2rzBI5rRh6XMChFyWfnY4ULiXihj2PSYFBerFZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982478; c=relaxed/simple;
	bh=KjzkxvsZmPCWZ/f4oH4n8quaSqtOFENAICPuHP6poSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CA00KodcFE2eLEdB4rdXVeymCZqcZ7Ycw9HqtFU9CgX+/R051sc658CbRLTp4FhU7nQGcgamt9gzPu+ACXto3IREMpIOAKlwQLtE3edaGRtHaks+RKA5I/iZpaUoIcBVBFH0CqLXg+mDQVceBzGoUq2iEP5QY7+9tKwc2DZ3nwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZhxm4J3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b788feab29so442996f8f.2;
        Thu, 31 Jul 2025 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753982475; x=1754587275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHj2cLcysVsJjYvm8qgEzC9MsQpweHLRLr/f4+AM8Wg=;
        b=LZhxm4J3aDxIsFNg5KcL1DKdd5+NskLOA7/W/RFL3jMYnkFtbzjaQdr4w6hrhba7Sf
         TALjTn8nVtcTtc4RWD8R3fFZ6ZIGZwk0R91tdNrVD1LuSgulyQVTeYkseudEEziWgNdA
         CfLMHli3mgEq11dDO0ehejNYBWfxu+gexgiLKDIiEHw9biZBtIKC8+mWrnGPbfHkYJ2q
         K3vGwcRbI7nxBV5hvQXJM9eFckdbpt+XQCcezaEOKD2rQhdHevKf3cQaZIPsgxmM25mx
         ANwPoP57PXeRxlg5PD1/xIhixseqaN1U0xH24NTDSq/CnMct+G+EFFak8HYLlwmlOskk
         4RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982475; x=1754587275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHj2cLcysVsJjYvm8qgEzC9MsQpweHLRLr/f4+AM8Wg=;
        b=hlRflzw6I5NBJJdQvvqXg2OaIkCFPlSMOE+2KdNwg2jHUgPp0uYu+blH1NRw3okf34
         xbUiECW5ta8IrEx1QwceupS7mwiqN5BZes02Zfyv4AeVl0sbtVKZxTvBk5RmlKD3IxXL
         iH2Y4zEE9+WHEPIPTSAENSUIWNVSTQAEAKfL+i77rI42ba0yW/o6Ok0+M3MlLNZ9blSQ
         sUvzNmRSlUsDOtuty+eQwslKmzMeatYX09Obt3aIw38pzzX7yXh/uX+kum6uvNT3E/Qm
         B/6h3KVlDlyqfLp/qJcamk8FXx5JhZgbbLOdXu1ARoUgZPMMP3IeSv8kO0PTTba4V/Xl
         lw3A==
X-Forwarded-Encrypted: i=1; AJvYcCWMI0c/PoKnPNUYagA5j545VEw/tw5u8RGEEWEk692ASVuO07M69oRxA12XukMtLORba/0ZXDPfGAB1PUY=@vger.kernel.org, AJvYcCWN1S9QkLsNj50S7dlc2M0dW3E4eHA6rJll3uniqBHPakNQwyIKBBnz73yORrmTffa3fA0EWvz/sN9d06k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGDo5FzJKdLoxm2zPVqQwFUu1AlN9xB/+3VOUBk0w1tWrnMWD
	6rNOPVfXpHmG0vI3PU/4gXL+tbJnUhTp/3V5KqlOqmr9HU+IVRRsModuZQn38FhHEiY=
X-Gm-Gg: ASbGncspyNzDa4YEAGuVYpQhBwcBmJxFgrZy2wmTnpV2dxDoAmy6YAoMiZXaGXAuHYK
	2+LxSywb6AwYQBEQEj3e5AZN+zUnQzY4qJM9rM8I7cCPEwjT7AUysFd1LjCW8u3ToNAix+PCXeU
	G2AHvzPMEFGmkpVtIvK14Y8XHY/lb6LteHeKEwBRGQQVCRWEVTN6av11ADRpy5Ca7JH4fsXlEJ/
	cHxiRCrRptwRS8gOcmnVBFwbB0fAtSct6/3H1O7wczBhEwvL25mT1owEwKPA5KzKx0djOfHPceq
	3rjZntQPPWTLqDdb3IxI0L9rDLt0DYFdKxLvHOvV2r+BrJXA8GvKUhaSPWUbdD1snXh2rYMiOM9
	TDyvF5gbBpD0jHXd8GKhrvkXfzNEi1QiFB4ee8Mtx05qZLR36n4wanBmDZzLrt1FBf0umA1E2LJ
	VWFd5Rf/WV3lQM8q3hdQDW+e5r+oUTeO/86ZWlqQ==
X-Google-Smtp-Source: AGHT+IHz/hA+7wNQb1Ei481z3W2jJ4TXaPeF/SNCxwU5l4QQTudc9pbxGoZZnIz7C3Nya32cIIHC4Q==
X-Received: by 2002:a05:6000:4025:b0:3b7:9d87:97c6 with SMTP id ffacd0b85a97d-3b79d879eaemr2856835f8f.44.1753982475192;
        Thu, 31 Jul 2025 10:21:15 -0700 (PDT)
Received: from localhost.localdomain (mort-07-b2-v4wan-169802-cust2612.vm24.cable.virginm.net. [92.239.90.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abeb2sm3070574f8f.11.2025.07.31.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:21:14 -0700 (PDT)
From: Peter Jakubek <peterjakubek@gmail.com>
To: cezary.rojewski@intel.com
Cc: Peter Jakubek <peterjakubek@gmail.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: Intel: sof_sdw: Add quirk for Alienware Area 51 (2025) 0CCC SKU
Date: Thu, 31 Jul 2025 18:21:04 +0100
Message-ID: <20250731172104.2009007-1-peterjakubek@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DMI quirk entry for Alienware systems with SKU "0CCC" to enable
proper speaker codec configuration (SOC_SDW_CODEC_SPKR).

This system requires the same audio configuration as some existing Dell systems.
Without this patch, the laptop's speakers and microphone will not work.

Signed-off-by: Peter Jakubek <peterjakubek@gmail.com>
---
 sound/soc/intel/boards/sof_sdw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index c639df2cacdd..f997b2dc221b 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -741,6 +741,14 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOC_SDW_CODEC_SPKR),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CCC")
+		},
+		.driver_data = (void *)(SOC_SDW_CODEC_SPKR),
+	},
 	/* Pantherlake devices*/
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.47.2


