Return-Path: <linux-kernel+bounces-899502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67230C57F40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75B914EA71B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095D28C854;
	Thu, 13 Nov 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsycDSpp"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BC204583
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044042; cv=none; b=Vtc0meRQJqeFpT00IiJiVfhxTaBVM2fbKGB+ylin3BOXRpPbwwtKHy+/bjAfpYYrnWgLKcXmwmXTRttcyXqR6fi/RHZjDZKkx6As+6x+NY19h5pMVA0VJbTC+OAtgVTK9aUQ/WOFHkWhckv62UmVHxJHZ1TNq7QyVhaBIo6nSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044042; c=relaxed/simple;
	bh=0Tw6q9uVnCB5RsC3DsVy4ZccNs7ur2RBRKPq+4D012o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZe4/+7JFC9CKjFdryHYbWpEmfZUgFnJm1aukuPdCTXsLJin5z1jH5ng8jbQzZGL41lH4DBROmMkL6HjaX9NQyB7EynMLXHiKsVpIJb26Bzt9V1tfIqQYgaNC8H7NXAzsMDNMvwXrlZibPrtGOkF3UikdZ/od/tMDqMgOoDgT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsycDSpp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso545584a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763044039; x=1763648839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFXYEF7QB/i0A/FdoVAEDHxZYMr8pDZZX3lr2SNEpCE=;
        b=CsycDSppE1KSpDgiaKq+TAMob1NKpnbMq1D1lVw/J9USc8WH7u5CFqzDeC2lqnsG3+
         MM9uw9UJMgoG/gx77LPgibrpwpkkGRc+ol+7pPWMty++MOjdNCeNqkYsNA/QWSUaeRAS
         4E1RXaSpPFDB14wv1y6sAkWFMs6W3MOWUMM+CgtOCdMsA/toFdCl1rG9L66lYjEwSxYo
         OQxKwwfJu1jZa2Wpppg/kMboIvbczPP5dhJOxS45B2h1csmC0bcg6q3eJoLVcjK1EKTH
         2BhNyVwZK5qZpIaK83A1kwNE7thGe1wLgLKLsiPi1Ud7UtR+RFHYPX2VJL+fApyXrDFn
         G3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044039; x=1763648839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFXYEF7QB/i0A/FdoVAEDHxZYMr8pDZZX3lr2SNEpCE=;
        b=Y1c7gwjHgKKxcWD06a4Ec4cYXXDmtwpsqkKTYO/Ji7mvhRAPbHDDBA/xzKnB6O5FJL
         GA8oYynVILUJpEP/BjgDBdzR+rjTNDu264rNIrQG1DAsX5dBU0GFCOrPpmSBDOqM1fTU
         9fzrXUSvj9KpgJEF5xYGD2t6AXZJM6Wh2iGOoUWWo6GM9HBo2jDpXCr0voSuMfy8Jtv4
         W4dRT+MmCr7mHKKJISAZpoQwqQEtoONCn88zDjNiJco/mEVPKfsupVJd1LUBuX5W7ocu
         84K89QIccYAQAxAMPsAQadzal6HHcg1FaA7EbfgOj++/PQjoE7sLgFpmKAgnAD2hwLdJ
         QbuA==
X-Forwarded-Encrypted: i=1; AJvYcCW8TDx+4fVt5rKQV14KJUEN9rYoBl4fKp/0tNZ+5b2xbglB9qF6sl72ptguQBG9DpQ/hcAIIKBOSXgWa3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsL8r/y4DbHFHDGrsTAcANGA/yThLV5WTxRE4GRrKakdGEGtv
	nfvSbX1wTU9nZhFBL+DtIhWQ97kbCxaRevF8yXiNiHUuHLNnk22t+fes
X-Gm-Gg: ASbGncuXi0lfLpfeJwNG4y5TMpdb8jophFDyavbbA5GmxUR+aleOnz60jrWl+LOvJCW
	mPqKavMtzzQU4Qi/glJtnINg5w3/yNzImyS/MI5PlFh9jIBVHlmT0PJUeR4rSlvxodjexdbsVz0
	/nZ3woVC2YfZMd1CvrrLEApIYEUA/jWzgX91UUr8stUrpkBpxI7hXNvHV0rlV9D7e4d4yPxetH6
	yfDVQK7ZW8QZHssChdwjP0qMYoJFkTw9u3it0xOFUs9frX0qAqTLB9TtRXhfWykDrVgBfiyXHmZ
	zdDwfU9VzLH3zuaYWW5IMS4keUzdjy0nW2KDejdGmHojijrUE28Nu7YHWLeZdGGZgkqYTl/x77r
	u5jMjmBkMTkrctP2FHBVsMlmZWKl6HIBieZkm7IRQoO0VGmu6hMF9JYQle4fPFgIxlSVb0ZXaKY
	P2hwsxgp52ri01ndjP
X-Google-Smtp-Source: AGHT+IF3GrG7ZK+M9RU6VrohEraA5W5GhEDI6zHXa1dkOUqo9dFQeLn6sFP+g+cHtwCkgQIyJU9QrQ==
X-Received: by 2002:a17:903:2b0f:b0:297:f09a:51db with SMTP id d9443c01a7336-2984ed45caemr92249865ad.15.1763044038540;
        Thu, 13 Nov 2025 06:27:18 -0800 (PST)
Received: from gmail.com ([152.57.125.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm28242755ad.7.2025.11.13.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:27:17 -0800 (PST)
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
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH v3] ASoC: Intel: avs: Replace snprintf() with scnprintf()
Date: Thu, 13 Nov 2025 19:56:38 +0530
Message-ID: <20251113142637.259737-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

snprintf() as defined by the C99 standard,returns the
number of characters that *would have been* written if
enough space were available.Use scnprintf() that returns
the actual number of characters written.

Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
Thank you all for the valuable feedback and suggestions.

This patch updates usage of snprintf() with scnprintf(). 
As in accordance with the C99 standard, snprintf() returns
the number of characters that would have been written if
enough space were available.With scnprintf(),the return value
reflects the actual number of characters written.
Change log:
V3:
Dropped the Fixes, stable tag & updated the commit message.
scnprintf doesn't return the negative values as per the contract.
Hence removed the check of ret < 0 as it is unreachable.
https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.scnprintf
V2:
https://lore.kernel.org/all/20251112181851.13450-1-hariconscious@gmail.com/
V1:
https://lore.kernel.org/all/20251112120235.54328-2-hariconscious@gmail.com/

 sound/soc/intel/avs/debugfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
index 3534de46f9e4..d224b25323be 100644
--- a/sound/soc/intel/avs/debugfs.c
+++ b/sound/soc/intel/avs/debugfs.c
@@ -119,16 +119,13 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
 	}
 
 	for (i = 0; i < num_desc; i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len,
-			       "Id: %#010x  Purpose: %d  Node id: %#x\n",
-			       desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
-		if (ret < 0)
-			goto free_desc;
+		ret = scnprintf(buf + len, PAGE_SIZE - len,
+				"Id: %#010x  Purpose: %d  Node id: %#x\n",
+				desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
 		len += ret;
 	}
 
 	ret = simple_read_from_buffer(to, count, ppos, buf, len);
-free_desc:
 	kfree(desc);
 exit:
 	kfree(buf);

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


