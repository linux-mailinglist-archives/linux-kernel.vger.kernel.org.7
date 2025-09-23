Return-Path: <linux-kernel+bounces-829510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F7B973D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8014C3351
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D992E0914;
	Tue, 23 Sep 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1k67Flz"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1ED1DC9B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653459; cv=none; b=scZ91UeTyjcZQoOtRdNkYt1JzFC+iQvobQMm4UrdRIlK5RPkCUCfBWuPI8/jR2fGfryI5hxnUCeqZNmMgIjS/vSh/Z1++qjKlXOqHKB4CuQcuSnYsGF0p0GYZ7xgVeW3Eyb9X77nO//ujJ9BR3hOGph1tgWvnh0tT/HRMpY/2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653459; c=relaxed/simple;
	bh=qa2NQh9RJDy9WQ+d31yHCVmbVNa2k7cV21sEiSC75R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggqA68Q34Klqow/H/1trnETkEC5lKsbfPup/IJSNShNecKzQQ1b6l8XmGqmLxrjmupVbtWIaTbpqYoVAKDGCybhgYuxAb8D/QWcPf3ZbH9okR/fHMOfDG0mXxY7Osk7Nfw2LcNYvEBhr+jm2SR7+1pVYrsLBa1728z4IEZS9LjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1k67Flz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so2906376f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758653456; x=1759258256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EizzNWoZUikDV1FxG67Kon1XSkcUmIn52o7zV6bqtSg=;
        b=h1k67Flz3qUI2TV5NVFwLPnp7skd6mANpk3RMlWkk4kqfMyuEi3MqqKr78hB9ctPap
         V6E6cJ64lvO+fZJXXcoXN1+xCG6ncst0XCNG4sVkbrC19TNlhUo3knLAu8wV9OhF48gJ
         aHgIOMtRMeoiMoEoSy7e5mkYgLvUbQAWy4OkDbT7bs3/L1Xn1tf893J0J68OIUudCL9S
         wLW6yQxB+RWisbHc/Inv75sApkoPPXiFyLnZ/WghICR62UmWIkhbFhhkuANt10KX2WkI
         9VFWFUGPFLvttj76MOotHFb5wn3giXVBbYC83herd+RppgVTOKJlJuWtbaulUkRO2kz7
         Kt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758653456; x=1759258256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EizzNWoZUikDV1FxG67Kon1XSkcUmIn52o7zV6bqtSg=;
        b=aOtEx7gWXit7rHUbpanlFE9Kwn6kxh/IBHvpUvBL4qOuliyyCkNWlLURUnD5cU5hlD
         63G3gExVjQN8YO4SoJcxX8/+rCP31loNTie/+glGKPBg3ngq8BfQZO45yUvWO/xOrKxZ
         CqMpx7Gyp9ZovoeFyh+/9o5xqVDeOAuWcBUPurfzdlBG/6e9WI6IAyaXXuPWwHVpluQg
         Zd+vXajqXTJwusryAHFC8GCIybJsd8BgGmYg42vAowlwd4rMTBWmxIDOqIE6GqrgHaC7
         SRJGzXLygWmRtiVCRJ4j9ryKDwUHDLcBvUj5SAH+hEB5+bpGb8C+XXixftFa7XXp5rN6
         BS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXB1n9r9nini/ch/YhBqzZ3gwLLNIg0t/6ZyGuciGk0E1v2fNtW4693Zkn70bx5mr+LjO2ARR8WDTkt8I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EWzEisfcY2aYqJwdBsVvH1qcIrImw5Oz8H4b5R+d4BAjW26l
	h1sqr+Ot/+yC0fZE+Ydd94/k2g4WX/mWFcHf6w2togWTvRhzOp0/imKM
X-Gm-Gg: ASbGnctXQrldhZOSbhn2Bfc0cViWAadqPmvlQJOpT6eQH2svQrdBJFgzuE/NslV9NwQ
	0weIhyf6L7e+CK+BVD77fvtKpUlAuoC9m6YSKZxBemuEsCGjRFOc6ILG4EIq1erVC7kbFHjtf7a
	jEYSMTmIWonUH0IL75kfR2OL/glSzdMYDP/h7zeUNmULS6qzaTy3N5spvi1fIjHGhnn6EI1CDiv
	QpvnxAen5ukets1zU/VpjWtGRVzAZa0JjxbpnotITJh5RqgoSUb44Qb9pQdZeEZOD9klxhgzOGl
	LfNkSL/VEQIXMOeS341ZRObe3TvOcXJwTHuEXomfrjp1FYvORo3GurR7Rn4GWmOKd1ADLeViSsx
	ef8Sp78CYxa+zwfqnembroQ==
X-Google-Smtp-Source: AGHT+IE2Au0RbnAAqqWNX3SWN53Mr2OlHht3ylbNddwR+2vdZFFql/xTJVTdhHclfhtpTGY9FAw7Jg==
X-Received: by 2002:a05:6000:615:b0:3d8:3eca:a978 with SMTP id ffacd0b85a97d-405c59e17c0mr2834428f8f.21.1758653455458;
        Tue, 23 Sep 2025 11:50:55 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e24835b32sm22658075e9.13.2025.09.23.11.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:50:54 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Niranjan H Y <niranjan.hy@ti.com>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoc: tas2783A: Fix spelling mistake "Perifpheral" -> "Peripheral"
Date: Tue, 23 Sep 2025 19:50:06 +0100
Message-ID: <20250923185006.213861-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_dbg debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/tas2783-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 3e03e68932f6..3a869a101844 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -1229,7 +1229,7 @@ static s32 tas_update_status(struct sdw_slave *slave,
 	struct tas2783_prv *tas_dev = dev_get_drvdata(&slave->dev);
 	struct device *dev = &slave->dev;
 
-	dev_dbg(dev, "Perifpheral status = %s",
+	dev_dbg(dev, "Peripheral status = %s",
 		status == SDW_SLAVE_UNATTACHED ? "unattached" :
 		 status == SDW_SLAVE_ATTACHED ? "attached" : "alert");
 
-- 
2.51.0


