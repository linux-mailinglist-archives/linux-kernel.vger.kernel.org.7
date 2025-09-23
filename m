Return-Path: <linux-kernel+bounces-829102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B2B964A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2426D3BE314
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041324679A;
	Tue, 23 Sep 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaRkpidZ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876D246764
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637538; cv=none; b=J1wTlXOGgUVsDaLgFy5yXNK9KyD1SAfvraq4BVz3U3grf9dRFLvOPSsBojqPzx/TXYpRM6tSwpGPgEX+jwDObodW4iYun/WWGO3jU9TyB65vuLakCFnfXz5wgRnl5bZirxk7KcdOe1DDwTIz2p5cCWo1MFd85C1nGX2nFNnpO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637538; c=relaxed/simple;
	bh=fvZVIobSVgA0V4+wbEQ8dctAdFoGdyKkjJ0YUscV8H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph3p+2H8GxnykvBMIYmj2jQFMvoz+EyrgQV+iA6B+mDbfmEsw+hNop3+9tp8+4LtIARAcdEQKZVGiapE+9F7nSLoK4Pm8cEf0AFKLfSaCAymTiChAqBqYBLeAB3yx+E9PB2fHrD7WhQhBPmmfh2NC5A5kC//G/3nASOK4bmwneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaRkpidZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso2850649a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758637536; x=1759242336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XROprbCtjuklHYiP4Gbbtjd/RPICDKsyrvlFDi2oCEc=;
        b=HaRkpidZnPt9U2IAhKdSmWY9asS7hY1GLiYU3LMEb3G6qD0b+8QOycwTUgtQEUC51e
         okI/TKa6/lsVDI42AiGyYi11261wn918R3FHp7PpgC8X/px1MnfBLoZ1zYc+Z5mwxul2
         YvAy9Cdt+AgzBM1adTYcE4EzSS7pzghPRZAXalu+Aze3RtN6faPhoxRL1vc9tQv5amla
         3SLI77ySWUGcUA4SLx8Ck38xnBEmwvfRs/nZNj16QDJIYcBNHgPC0cEvCmWN4h82JU6y
         TV5jus+MHUduVb60pQlFIeoP3EXtvsT2cgWAdVsO2kTtdieL3yZfV0i9qY9dhj0maSjI
         PEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637536; x=1759242336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XROprbCtjuklHYiP4Gbbtjd/RPICDKsyrvlFDi2oCEc=;
        b=b3z/fK0HS5W46SklRzaz7Gwy8t99jInsKdusNRE2dYRF69rD3B1lvDroOQvq72Sca/
         VIS6wsWLBld5QH/7oz+058xDtluV49raKuA+1FVvQp4oy2GI5jFZ1VtFGvPlW3HjA5Lt
         8pyoT09ezWzOeHbSu19stIy5E5TgknYyZpo+aqDdlQV7NQz3JwR+NM/oWKhI/70HXsKR
         9t7mL5VzFTtGu7g0NsJK4XaKVxw0K0Plig9pNvowYFNI16uz5q7gylUmBXDXnp04BIOc
         U8rs/1+P69msCpNOilZjaTUNVxZr2XzYNQ9r1CHLcf/q0fZIvZzEOm93NdADUEjEFGi0
         Spew==
X-Forwarded-Encrypted: i=1; AJvYcCUBGtM7ikP50srFM1FOvSpp0KKqnb1/U98pOHjnez9CUTk2JHbAtaXbGSytSLCQCf8MAU6pf5/wtQsaE6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92ag3taYAGdrcvWghH83o0rPVVw6l5bjLbi4lbliKAWszxE3v
	4dWIHb6hAChKH1Qtmiy+hE0A4/0gHY/xhKwiFzpbZYNLp4LEUXb4AHMb
X-Gm-Gg: ASbGncukMt9+lEkOTgQPNE2enaMlWmnZepEVqyq46mTthw7L59HwQ/06EkSv0D5diwp
	qTCKzvmiFMwIoVSofMsiXQBC/Cw8apDky4ZboOS66gQ8d5+w6a7o+o1RbQkdEfZQtVi654N8qKW
	p6QrplmRH3dJzoucJqKV93I+XLqMkGjC0ovadAlP2Tl3io4sFiHK5MQTOjQU1pPwCk9/K/jjnxB
	gMGoIwDx/lhGmjRXWf3nC6plqhDjGtmYTg4s5zDKcNy4AmiYIpJoIjPP0i3kxuecuHrSQZA5VVD
	WG/zInYkQgz6Xq9HjjuFoZpfZZ6YK4CqCg6u69SrK+Hj/EO0iLgnSl3lhApWT0wtW+oiP22stJ/
	94h7JO5ZzzFz3WrsGx4TatiAvp8ews+SJuj8Iaw==
X-Google-Smtp-Source: AGHT+IGdLk45QVGsvBMFLlapJTj0bAWi+72cOD2C1lJ8mJoFxICxzqgCiJPBRNvESbhBP7jz8ig/2g==
X-Received: by 2002:a17:90b:4d08:b0:330:852e:2bcc with SMTP id 98e67ed59e1d1-332a95c4b83mr3635903a91.21.1758637536082;
        Tue, 23 Sep 2025 07:25:36 -0700 (PDT)
Received: from gmail.com ([157.50.55.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306061aa5fsm16092605a91.6.2025.09.23.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:25:35 -0700 (PDT)
From: hariconscious@gmail.com
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev
Cc: shuah@kernel.org,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] sound/soc/sof:Use kmalloc_array instead of kmalloc
Date: Tue, 23 Sep 2025 19:55:13 +0530
Message-ID: <20250923142513.11005-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Documentation/process/deprecated.rst recommends to avoid the use of
kmalloc with dynamic size calculations due to the risk of them
overflowing. This could lead to values wrapping around and a
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array()

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
 sound/soc/sof/ipc3-dtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index e5c8fec173c4..6ec391fd39a9 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -126,7 +126,7 @@ static int trace_filter_parse(struct snd_sof_dev *sdev, char *string,
 		capacity += TRACE_FILTER_ELEMENTS_PER_ENTRY;
 		entry = strchr(entry + 1, entry_delimiter[0]);
 	}
-	*out = kmalloc(capacity * sizeof(**out), GFP_KERNEL);
+	*out = kmalloc_array(capacity, sizeof(**out), GFP_KERNEL);
 	if (!*out)
 		return -ENOMEM;
 
-- 
2.43.0


