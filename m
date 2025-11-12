Return-Path: <linux-kernel+bounces-897890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF8FC53E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F25434501F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BA34B42C;
	Wed, 12 Nov 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar64TOml"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C534B424
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971556; cv=none; b=r/Yoxd3CPwmUWYsievZZmxlpd45nA7vtLtqlpt8xZr4dfLOzZQGUpzQoyG8V+QCRfqhSg+lglU2R0843dcYVzZhNIZFIbT1lHlTW3nNsGTOWlutkdzmCi6LmwS5cAGsX5QTVs3JR92f2HCYEGmS7YO7Tv97ewYqkmR+iedWtSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971556; c=relaxed/simple;
	bh=JSk2wiQKBahdJ8dYGksFv11VvJ1NPd2DXSatLhgaWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJop/8Hpm/vm8E6d7ibiI2ROddp0N+NoQkCKkA0wQ8LPebS/vNZODe8lZL3SN2JaPy6iZoblLNw5DOMotQEOijhemOl+HjRhUYNc+b7Hg1jkoNXvSFqZSJpOdeNMha3bjiRX1E+rJwIK/qsn5pxTOi52C02oC/DbO1w5CYcrrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar64TOml; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297d4a56f97so11973465ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762971554; x=1763576354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajL3qyJYFc6tD7lnGfH4M98Ye8+T06Aj5rRcRA12Okk=;
        b=Ar64TOmlxe3N161cZTBVfb/dIqX1VLovG5y6PwyGIPc2VMxhhcM+Gj7EAubKCkIpGN
         Fktk6wYT9DWPnzsYTrOoDCDAXoOgle6N583gZmaELsF/ifk8dI2YrwoccXb5f2yOmmIa
         Jz6QYNA8wx+hEvHER/Yey2e7TbLKBsAHuRr2G2o7jCzYSCjuQ7b/jq8owxs2nfEMuy9U
         IeX2v0wQrbU7gcBdDUMF9IzRitozq1Fy2Quu34FNEarVMSFyTuMRYA2RcLApmey0jDmP
         +OEQ8d2FwLumogpVUO/8IBqS6kLyNrE1eudUPMrSrTLPUP2nNLjN/v1gShWSp7zztx7j
         jMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971554; x=1763576354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajL3qyJYFc6tD7lnGfH4M98Ye8+T06Aj5rRcRA12Okk=;
        b=G/WCHkkxpRxWGzengZCJTWvmohQ2FaLh4ko9HpVOm2emLrvo3q9vQz/5avL3nTunK6
         /W7ab6MbbGWprC17+7wkWMd3oPwjfXQll+IPgP6MlTnGZL6IqOpQlwuiz/Y9tc/L2lB0
         NZA/1prrnc13JekVGMS1W+de9wnwDgsOO4z8y4vrScVvuHj7dkbFQw5GtkrPTnj0Amjv
         qWADQbFKp/s+1N6IB5dyTtfinlF+2hZm29r3ZT6Bb3Epzcw2LWQzkRiWRKNtED/R7s/w
         voRbeWOLPwa5SrviO2+DM7SyIX6XMuf8OXPPZwSZ3wFRkgk5CeuNjAlMQ1xNwlGq27mr
         xxTw==
X-Forwarded-Encrypted: i=1; AJvYcCXEmjD1FQsyryeEU3g/MMtijSWc9W6skKUUHeTZKw/3NEW6aKfqTcHTOJkWIcpXY/bGA71Q/SakvOxie/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+Se3/+Up/Ar4MMc+AcPImK2W6o3rOi8SCXWxufMermh74b+O
	zEKi6nasdeeWJMlEHtu/75hno5LF9sAknWy4SfT8jwj8gh+r2CjtA135
X-Gm-Gg: ASbGnctmL405BiPhK5txCYJaSIkRkj+0xjtG1hBg72KozANfb4lv/6Yyg12SuPcfqM9
	Mlb2bYW6Q3gfadmmpqAwBV8WwGSiqjoylqBXL12anjU/p9e8ssds1YQ/vbwkyNn0YvZZAs+bFHG
	BgtlS0hczHnyWu1finloH+ID5WRsMQYxh+nzB7EWsEPqLdtIv+8f09tAV8WBQwly1ojQYrSBnQk
	abmeHksrCTHSH+1nfHkcjKoHo+ufz0kEUx7zIKAybDDDmGDp9+ssGyhCLv4+UYhrVhBH7JejeLP
	K4I9BY2n5rJHVuZ+P8ephgJleelZUVzthOjQPXyKCEhsRzwRI8bfXD57sL2xR+DhIFi781eVZMv
	oWudqYYPzNRFaWOjzNesVW94A0d0zGWDO10ynPY7W22/At+tdLI393klpb5fgFoMhd0rIWvWg/k
	/9jTHdrvL30uLvlsAJ
X-Google-Smtp-Source: AGHT+IHlsgCrOCxbH1xUwfriUBHh5Wzt3eZZ8m1hSbR+IpGy4PwSajaGLSMmb7HAExzbcjFaVH+8vA==
X-Received: by 2002:a17:903:28c:b0:27e:f018:d2fb with SMTP id d9443c01a7336-2984ed2b896mr48147475ad.6.1762971554462;
        Wed, 12 Nov 2025 10:19:14 -0800 (PST)
Received: from gmail.com ([157.50.185.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9f8f1sm37051095ad.54.2025.11.12.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:19:13 -0800 (PST)
From: hariconscious@gmail.com
To: cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	sakari.ailus@linux.intel.com,
	khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH v2] ASoC: Intel: avs: Fix potential buffer overflow by snprintf()
Date: Wed, 12 Nov 2025 23:48:51 +0530
Message-ID: <20251112181851.13450-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

snprintf() returns the would-be-filled size when the string overflows
the given buffer size, hence using this value may result in a buffer
overflow (although it's unrealistic).

This patch replaces it with a safer version, scnprintf() for papering
over such a potential issue.
Link: https://github.com/KSPP/linux/issues/105
'Fixes: 5a565ba23abe ("ASoC: Intel: avs: Probing and firmware tracing
over debugfs")'

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
Thank you for the feedback and the suggestions.
Corrected the indentation & commit message.
V1:
https://lore.kernel.org/all/20251112120235.54328-2-hariconscious@gmail.com/
 sound/soc/intel/avs/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
index 3534de46f9e4..cdb82392b9ee 100644
--- a/sound/soc/intel/avs/debugfs.c
+++ b/sound/soc/intel/avs/debugfs.c
@@ -119,9 +119,9 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
 	}
 
 	for (i = 0; i < num_desc; i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len,
-			       "Id: %#010x  Purpose: %d  Node id: %#x\n",
-			       desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
+		ret = scnprintf(buf + len, PAGE_SIZE - len,
+					"Id: %#010x  Purpose: %d  Node id: %#x\n",
+					desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
 		if (ret < 0)
 			goto free_desc;
 		len += ret;

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


