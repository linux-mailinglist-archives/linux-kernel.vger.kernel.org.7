Return-Path: <linux-kernel+bounces-894667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D53C4B8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B2C3B0B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06682877CD;
	Tue, 11 Nov 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui9fB2gX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C9285418
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839514; cv=none; b=aOFgke/2GYLkl10V8sElQ2e1gIc81Zoak14ypRgErdQRBpLOM9oaOi6URgB8K4Ci+APuemjxkOuALwBAXpsUhpmOsR2p/93bGe3a/HgezAiSClGr1d38dodO4DuxXzGEUb2JI1F7qYBhHp1bQNRbmpVtWrYtNXkIoEkrRFZkbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839514; c=relaxed/simple;
	bh=bl8ormw/0G47BcA133p1sT+0poex0ZwxwrNZQ1PZfYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M60PyqJaLl6fuvk/B8yllB2yWYA7fh9ej1km44aQA9La08LxKokpMKI1ERoF7MU7uCC6eSI1HTct7LRUwmjFmGdiuLLvTwgeXjC+WUEekHv/spPznu1z/a11HH1ZRFo+9alG/RXmM/dR7Oj6viYsI+k70/DFmkANd2WjIgNPexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui9fB2gX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so26930315e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762839511; x=1763444311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb+qXNML2Zug0mRs+ShkI2kLcvT3TeWhztfdHoVJFl4=;
        b=Ui9fB2gXZH+wqM8H2Xp9y3xbAo4OCtWNMETe353PNsf57twuu/HOFFSBF2ugabV3k6
         z911M/C3wCCUAdthH998yGDdEI/yHpfKMG+2RcE/7nbURZ6Kjojpl8VIhiNertLObn4m
         7H6x3D/1JpQCF11GtvXIYeoCFboCLUudRVGFLf9ikTnjUH+nybEwIHCyTkgMGbEIIuIM
         +NKUcJqLdXx2ZBHEXwTAGUqhbA5Zps21MQOJVX2NpdJYXWX6I9sdM4MqlYWIpcgb/kU3
         3D95dkrq1Te6+M6qAm1tFrQmZaBAYGgRm9WU6O8fA/nQBZJlPof4AYmIp0Rjlb+TRpTo
         CHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762839511; x=1763444311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb+qXNML2Zug0mRs+ShkI2kLcvT3TeWhztfdHoVJFl4=;
        b=LODjUD2KLz3gIAqWLhx+ZrV/p3iruq3CuzOmJ1Ed3uRHmh1sumovhPqBUWxEVsBK4q
         16b8F20FE+Fk9xCcRYNEEoW6tkacB4+ZnGMc7dzmihegyeFcY5y2j4ghlhmWE3gy1FiI
         FMNRbmDIcZifrbIjk4DrnrbjNHy/tSoXK/Sxff+90fQ8K7cHbWsSIVU8uOysetS9c/8y
         +d9NVJT7ln/6kdf+yMlpzgQtMqVOqFgTsYb5Z4zSxeKNWwHISjGMMICyLt1WgWz5HfNo
         joFm5KruO5E6yZip1dNAaNvUUf6AXgvH4FQXDb3vIdRA/0sHdLNj7eJiGjjGXLTHMH5z
         DjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWslVST3EqYYVL3LLDMR9otmBrbmH8TwS1pq6aUipit0aaDrmpmYxlGcXid/SAas0+kXkl3Vpl7O0sJyqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysL2WzHHdUmWlr4znHIBiR+imI8bacGYZ5La4AE7o5hN0axEaP
	EBa0Kz4MldAKG2qxWKViiStBA5QQUQvghmrNwhfQIzaPfd+RuW1bTal0
X-Gm-Gg: ASbGncuRZ57F9QzTu78M8sAh2Hz9qReNMkc4A+nclXC37s0GmO9R7AepvyoriPcpjJ2
	MZq/ezpdlJOgOMaIig+izD0drAJbXr9Qnh1uNThJgDqzNWzvPmFtoh97YKdoEhs2a1PayJX3PdJ
	U5nRWAWViCNn/ru8fYo7I5FuvCoI0T3t3PfDyM4TGXTutf2GS9OK6TASyHdTuXgdLpf6NDLOGsM
	GaS3nntXu7d28233GyvL7XlRocsH5Uc5FnvJWKByJUZY1KSLgnElJe7GbGC3tRBIZSkDHX/uirc
	m4xOEZFW4Slq/GJBdjTGMH3cst8dXGUfLqJ2zjge5s8jWLwXouQprTrjrxbDrOlvcQPrKWRAqsB
	S6unLJm629WtWpSt3+xkO2Lyjhot6QZe3NFrz0G0VmTtxzSOrCvlFt59AQ5AzK+YMt1Vo/Yr1kJ
	8x9xM=
X-Google-Smtp-Source: AGHT+IEv5JnCqFKP1Mph4p8AIKA/3nXc5QfvNqGpBizR/xRbU8dBBYCYd3u61pCiDSVO4Cy/pD0Gaw==
X-Received: by 2002:a05:600c:41d4:b0:477:7479:f081 with SMTP id 5b1f17b1804b1-4777479f19fmr59167825e9.12.1762839510290;
        Mon, 10 Nov 2025 21:38:30 -0800 (PST)
Received: from gmail.com ([136.226.168.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm109459225e9.13.2025.11.10.21.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 21:38:29 -0800 (PST)
From: hariconscious@gmail.com
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] ASoC: SOF: sof-client-probes: Replace snprintf() with scnprintf()
Date: Tue, 11 Nov 2025 10:59:21 +0530
Message-ID: <20251111052920.56459-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

As per the C99 standard snprintf() returns the length of the data
that *would have been* written if there were enough space for it.
It's generally considered safer to use the scnprintf() variant.

Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
This patch replaces snprintf() varaint with scnprintf() in
scenario to know the actual length of the data rather than *would
have been* written data of snprintf().
No functional changes intended.
Reference Links:
https://lwn.net/Articles/69419/
https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.snprintf

Note:
*Compile & boot* tested.(CONFIG_SND_SOC_SOF_IPC4=y)

Thank you.

 sound/soc/sof/sof-client-probes-ipc4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-client-probes-ipc4.c b/sound/soc/sof/sof-client-probes-ipc4.c
index 758a56d271d7..d3fa37106b64 100644
--- a/sound/soc/sof/sof-client-probes-ipc4.c
+++ b/sound/soc/sof/sof-client-probes-ipc4.c
@@ -289,7 +289,7 @@ static int ipc4_probes_point_print(struct sof_client_dev *cdev, char *buf, size_
 			__func__, SOF_IPC4_MOD_ID_GET(desc->buffer_id),
 			SOF_IPC4_MOD_INSTANCE_GET(desc->buffer_id));
 
-	ret = snprintf(buf, size, "%#x,%#x,%#x\t%s %s buf idx %lu %s\n",
+	ret = scnprintf(buf, size, "%#x,%#x,%#x\t%s %s buf idx %lu %s\n",
 		       desc->buffer_id, desc->purpose, desc->stream_tag,
 		       swidget ? swidget->widget->name : "<unknown>",
 		       sof_probe_ipc4_type_string(SOF_IPC4_PROBE_TYPE_GET(desc->buffer_id)),

base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
-- 
2.43.0


