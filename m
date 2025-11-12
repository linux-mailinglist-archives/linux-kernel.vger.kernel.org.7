Return-Path: <linux-kernel+bounces-897178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0826AC5235D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5764EF762
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F43176F8;
	Wed, 12 Nov 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhW9+isC"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D430E854
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949203; cv=none; b=WndLV37vdO4RR4BpzqcWpEU18pTTlGUDnF3EnEvUr0AR4BYdG0tesfDggiIrtfgSqClm8i1kMVdu+6WE8rYvQKY/+jOyeJcPt3biMBH5ec9g2klor6NEgMMWeeUAObBfw4nRdxQoXOjMcn8nmQms+/GGGvxd4WGWoqW4h7jqK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949203; c=relaxed/simple;
	bh=TPJDvSVZTbBn2A6SepOj5NvERXxcqlwdeCpBeCb5W00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDT7nPvDtvoqbzlmWqb5LLFyvwOv4mX+c1FXKnKCWQVl3tc8VaJu08me63VP0M7Eca+1SmY3bLHXTS4NYiXuiEACXHfkSd2HEjOrQiXpKK4Xj/t5pFraSklUxnlmRNFp6UwUEw8PXX/8S7M2hIoIJhZsk7yBd96FY3mVqfBegno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhW9+isC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b427cda88so476207f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762949199; x=1763553999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tc2H4/EhQiTg4atKH7sDBTa7g3DlJ+euypu29w5QsY0=;
        b=OhW9+isCrYMNKc7wwk8hHZPmmr08Ra9wYWoumnDNQct4AF+wXb83ATRrjkQ1jrnCnA
         sB+fr0Xk3WRRI8JmkbEW/vdQWddkRUgDgacbkxRVoeHr4HVc+og/YTd8ZUHMePguH+kL
         mnqqTatcgJTVDRbPPTyK9F7FwEoGeT3mkxMas2eDyMKtK4zlhPQTigdwH49dJt/51Sxl
         hKaC2MGypDQUz+ThPi4fhRqa4XRInRh7DWETZhm+9R3LhSiJO/TGz+pFjCj6OVdeBDaS
         pDNZuNYCToUvYkzhS7nDTXEuSBgBFUDBC13MCXgsTr0KAvkPktw9s9caNxdSQ1rwrvcV
         X14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949199; x=1763553999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc2H4/EhQiTg4atKH7sDBTa7g3DlJ+euypu29w5QsY0=;
        b=W0lf4eQ1Dm4z6RC8LsBF2TLgGUn7Lu0sA6WEG91a0TX+JF8Z9nN1ifb2xaZf/zvXvO
         obGihB/i3LmIFngOy8QcnN2YZ0hPUbXaNIGbivRm0TVEAYvzhsLT/gRl9TzxT1nyhkv9
         3/s6AjMqeN8FCCtkO/Sps4yiFHV2ncqXKOl5Qzj7m1Si6W+6cOBomrg0gACWKxWwpqyF
         WGxcV5tT0Mx/ZyFfq5zsbyQ0Pdh+XzNUIXdV4M4h4TuPpoaXXyL9g9Ndu38/CVRwDOga
         drAkWd3duH5WEU0wkIrEv4rZAtaMybJAujQC/pxiaTZ1EdP8NZuPew9yAyyVRqrtBm5/
         liIw==
X-Forwarded-Encrypted: i=1; AJvYcCUkt916RdjHuw6Ktgy3BfXMHfzJMXRpjNQBTyTJsCExlvAWsvJ+Nbs7FYDiELOrFZ+Gtd0QTdbcefxdpLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kk3GcsFwGyZnIJWyYb0Sq7+290Erx5xbBpe/mff3oVHRpvmY
	yqQth369dwxIvqCYC30ItTKZkjYYREOEjD64zFXOzadfzqDhLwIYP2WK
X-Gm-Gg: ASbGncuFQMSAJ/Io/jbEB5ulBMCYZqfoboG5oWSWvlCsWnHiNs1KoasZdl7nT5QkDhq
	egFuA09fvd5I3Sv7feKbpXG7KFpgh1J5EA9UfjYoPAbXNCwcaa1G/fPUHDrpJkuOvGu+xQKFf0O
	qdrrcEvMjsys7zEMnUMSZ18kAmJekXf1amJ0JzxD13irPkGdWfvuPcXy38AlbLhUzS5SI0ioHrq
	OOHSlb3ZHfXV9ff31rNWxoNTKTkGhb7FLMFOma8zs0tMTh6P6EUyZUiSKdE37v9e3GDJEWC3Ryh
	QQAc5z3uh6uczwDrVYlK4Ptrt2o1EUCsjRByF29/wtCXqcZsEwWkTQBhISYA3E3JoVflhczDCbe
	kImw8CEk0yjfYP4PM2slgylgodBYd2gZeKLA84RDkHa5giDv7P7bypoUH5VDx4M49wT2eIshYDD
	xhG4zY6D7+ZisLVA==
X-Google-Smtp-Source: AGHT+IFWYVx/EEeUdCv3zGzHjJiaxTuPQPm6ZEUuUTGNOgLsYKGU4TTfMfOJtqHsLMvu+Rw5uNzZzA==
X-Received: by 2002:a05:6000:2001:b0:42b:3806:2ba6 with SMTP id ffacd0b85a97d-42b4bb94662mr2791770f8f.25.1762949198873;
        Wed, 12 Nov 2025 04:06:38 -0800 (PST)
Received: from gmail.com ([136.226.168.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm32486989f8f.9.2025.11.12.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:06:38 -0800 (PST)
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
Subject: [PATCH] ASoC: Intel: avs: Replace snprintf() with scnprintf()
Date: Wed, 12 Nov 2025 17:32:35 +0530
Message-ID: <20251112120235.54328-2-hariconscious@gmail.com>
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
Compile & boot tested with necessary config parameters.
Other areas of AVS uses scnprintf() variant.

 sound/soc/intel/avs/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
index 3534de46f9e4..100b95bfcd78 100644
--- a/sound/soc/intel/avs/debugfs.c
+++ b/sound/soc/intel/avs/debugfs.c
@@ -119,7 +119,7 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
 	}
 
 	for (i = 0; i < num_desc; i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len,
+		ret = scnprintf(buf + len, PAGE_SIZE - len,
 			       "Id: %#010x  Purpose: %d  Node id: %#x\n",
 			       desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
 		if (ret < 0)

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


