Return-Path: <linux-kernel+bounces-833588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BABBA25B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6751F625FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8901D63CD;
	Fri, 26 Sep 2025 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em2hV96b"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4D18DF8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859398; cv=none; b=uPdBEvP47SVwlJJiqu7w+A4cfUvf/ftRHZsWiltnGhmk1TH29r3P5XzvVn/Ec+NjKcC55C4lEGZXUr0ikh9kxBdbRzq2DRIB6M+LzKCTMhgcHlx0gV05n+pQF5gY1aNEVgWUrgbNqHJNOOlgJ39aBwq0cChykz4Jp8fVWDE3kFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859398; c=relaxed/simple;
	bh=wvhzxABFdiOg+ADsIFkLjfPZXMEFheR4Ig6WrpOZQwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hXQ/uztn3ypIBf51/p8j1Hfhi+ByiPcgS0bgsJVIZkamTwZGefkksC03hNStGxxNMyDTBWa4acVFEANVjg+ggkDRBz08ASLu5B36ZUIANybhms7KuFQ4y0MUOB6C0YYZAoHeJ15+yoXlY4DhU6EBwstlv0jYAywfi6imd0/m3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Em2hV96b; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-414f48bd5a7so177232f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758859395; x=1759464195; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SytoPnG5QJz686o335sBi4HCtgv9sYZ8aX3hOtRMKuU=;
        b=Em2hV96bno6K4j3EiQ4i+vWldVz172Jhassul+IUdwIrwuSktCax0xo/EEMeA7glUz
         N7rjfp3f1Xm6dwKznrnCoz31TTXrJs7xjXAX//HulS53XAizOxcDv4qL8TwZGgRcWXD2
         DYmRqH+VbbyP9qx8/29UsGgz6UF4zTr/JzruhLh+qeR7OH5uxB8J8UrNIPc7r+jYinq1
         Vrtz+W9/A6V/OEo0QDx8C0e5QM1wnda3PpQTt9snHBkozlteFwk1kWVrFYOvBhRTFL6n
         j+BCcvbGGjbin8Bw7a2OlOrWGMy8Ug3MFbIwV7ywrKjWi6wYE/uiMRDS4OWSotjA5yEB
         PE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758859395; x=1759464195;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SytoPnG5QJz686o335sBi4HCtgv9sYZ8aX3hOtRMKuU=;
        b=nK6wlrkghy+UwJ2RmR6bxMyxtoRtCefvgCt/gEx2TR6DXS9FHbWKjxIu+C1th1zAbp
         z2dq9Iidnyajynjfi/32LnQSVzm73feIFc9KQ3nd2jzEBVJY/ckMKXUzYAvAvvPIDOcS
         D3nM2f5HW79GhgE9yfi4FWIblb/lfjpMifjvE8DzYvUNTNcnVmRMEi4qFQtVWurYfxhP
         cjCEOxbXk7mrb4X+Ik/BVgiH+gdhYxMzHhgVp9kRih46Ma+9GlTC9UFtVTOD5sAanUJO
         kAelmFNpjO76H622OQR1WZTZCaCKVV4WcA9/u8BbN2XzP86EZFs8V5Gmwu0qEoi3Imp0
         LABA==
X-Forwarded-Encrypted: i=1; AJvYcCUlV6ykugrRiMK464VsroDu30ihEkEYes8YvWGuvhqb1cu3Pfh0H35UOt0TSvAvE3OalKW+lkAxYeU+8dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkAMB31LkxYiMQf48/yD3hJJ9AN1PoDjUyWjcKqcoF2AubBjg
	evL8uR5ocPXIm1nT8AgAhzu4S209iR29hxxBFWJBPuI92FpwsRLGPekNKo+e8ohHr4E=
X-Gm-Gg: ASbGncu37XJsi/NuVUUu5BCpK2MkfYA9p+XWwo2HnIHrGC3Ft3Es6hf3V+PinTAd5ck
	Stt1qxBbI3wDFqK5EzNK2gTeFtLmYYFoEAuQBZa7O4E78QKaE2TRkHQCUrPtUSIONPUsdleQsBH
	HMz7G0fhv5A+VyRPpC6hXEMv5rCyuN5XIvMJ4GFLNzKpIQWYLK2unlTXHVf1P4JtpWKb8sw2Qxx
	u4zqs0b8QTVLOqOj3PY5xZwXEQZ3fty8ornVbXrkMYRQAMqKO8cW1R0V32NbddCC58RPdO7MHwV
	3XXrRCpi28So+kH5kj6eRUqpwSyPOnL3MO+xJoqGfL2dD047ww9/JzaxZVOGysEijYxfl3xFe6T
	IIgvqBtpaznRefkUcmQJ11TO9X+LMbl/nCCR9M/k=
X-Google-Smtp-Source: AGHT+IHNqzt+aianVVfPntORZwd/WnwppYwAnuoO1k+luridVLwZ4XnvDsMlhkTtJ7/8EeWUMuSP4A==
X-Received: by 2002:a05:6000:2484:b0:3f0:9bf0:a369 with SMTP id ffacd0b85a97d-40e43b08823mr5542343f8f.14.1758859394949;
        Thu, 25 Sep 2025 21:03:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb89fb2fcsm5697497f8f.22.2025.09.25.21.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 21:03:14 -0700 (PDT)
Date: Fri, 26 Sep 2025 07:03:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Niranjan H Y <niranjan.hy@ti.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] ASoc: tas2783A: Fix an error code in probe()
Message-ID: <aNYQf4cyavnku5Nt@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code returns the wrong variable "tas_dev->regmap" instead of
"regmap" so it returns success instead of a negative error code.
Return the correct variable.

Fixes: 4cc9bd8d7b32 ("ASoc: tas2783A: Add soundwire based codec driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/tas2783-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 3e03e68932f6..21cdcf93bbef 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -1285,7 +1285,7 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 					      &tas_regmap,
 					      &tas2783_mbq_cfg);
 	if (IS_ERR(regmap))
-		return dev_err_probe(dev, PTR_ERR(tas_dev->regmap),
+		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed devm_regmap_init_sdw.");
 
 	/* keep in cache until the device is fully initialized */
-- 
2.51.0


