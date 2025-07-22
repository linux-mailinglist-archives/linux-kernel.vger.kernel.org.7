Return-Path: <linux-kernel+bounces-740840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9AB0D9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8062317CA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB482E9EA4;
	Tue, 22 Jul 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a07JJv9Q"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D92E92C4;
	Tue, 22 Jul 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187961; cv=none; b=Z5uCHOEJ6Tujz/NbWBDqDBepiVUn5qTZM5pSJqBTu3jEsy2er/H6OkLbVvKeOEk/FV0tll0qO1Tl194ejkoP4WukcaRpjMHfc5mcPz491zcqRpjbmpHtm385z0/MwhG7d6eSWrHR9Izp54QRex+IOrv+634rqjbyj3to8XY0ZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187961; c=relaxed/simple;
	bh=D5OeGLYphWl9/jQBQDwYK8cqd5YCzquSe6S/d3A4YR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvF4tCeD2ufxkquqCaehQCCGddriabn/UUmY98XjbASKuGprz4RF8qjKLdEIOXjEgnaiA8HtDF2RzlEn3luQNE13oz+KJpeVjM7rPahoDyWIuih0F8DiWd14AQLmy7MtUM3na1QOl963dl2W929o1T8qyUJmRR2nMR32a16tIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a07JJv9Q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so2789367f8f.0;
        Tue, 22 Jul 2025 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753187957; x=1753792757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR08by9XdStyKPayjZ1DkTPP+M90uxnZLUPskVBaYN4=;
        b=a07JJv9QzcwkSZSjyCXLQk6dawbEqX3hAUIrGtOvh6e2H20uGfwpOhFlgidJ/4JBdQ
         ONbkFaQNAu7T2fvZwSIpBNMd3cz3cnRJGbu2R4trKqyx4c2P6sgQsovNzGXmWu82DbNZ
         7bev49ipz+nIV+hE/zmKeeOx2JgA8n1ZUtY3bQ2/2g+NB3KMlbLLjkI6eg6flJaLcYcZ
         rY4nHF4yfVyBRdLan0Fq0f2eGi6RyuBi4FN1/pOcE6VwcwKCi+fMGmN+qi9eFskFGtlL
         BWtthUP/uY2pDS5Z2r4jay38yIXv+C/2Y2/cUuYMFCEnXSbT8hp9k1fIUAwd7dfO7kcA
         6BKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187957; x=1753792757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR08by9XdStyKPayjZ1DkTPP+M90uxnZLUPskVBaYN4=;
        b=hWIyISFfzfUTcBhz7oLuSTioLchLqzeRn312+g+tP9vY6Q8vR4gyGMGHbN6CpBYy9O
         9puBn21fFhWj8hf9W9n4BLuA1+PX3+HoQ6pC8JASgpKUA1ww1PKhcHVq3+9L+I5YFQrX
         uVPgd4O/baGoWOawcxt8BRP8Fr7pjL5A6njR9svXNfq1Prt8bc/7USqwEHecxMOM9OLx
         gzgv3N37BXrUpC9tA4Bek6VassC5Hp/2S6WikLEyNR0k4I/twvYPKlI5PUZJphfoEarh
         SK2RbE7tvsv/XUQSckncNjXRauVKPkD8BZ/hX6r+w1FzN3qN+iWzrzGHTYZmzJhWriH1
         FpWA==
X-Forwarded-Encrypted: i=1; AJvYcCV3IJ6vN+bb5hvxjvU7+AJ9TFcDv8JX5eJiy5a5B5NZGgieDDmyTBYkxxizDxIHJQAplkoAWtJV3jgoHLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TP7g7z2oF3uteOBEl8w7OlLONR4P1r9XqCfB8vE5N/+K1NhM
	X4Df8avQ5tscgPH7nkWJ+/a4UQazVn554IUOzIqE9ggQMF4Ublnl/LCY
X-Gm-Gg: ASbGnctqgtFQroZzPxHIgJa2djoqV69O8AaKhd8J8BAqOMpkSHqpl68Q2dnVrt3Ioon
	yZYg1JDTc6PYz92q2BMnWthzIIt24aZALsMOyUYoCw1bV60fq+i2TlTQS4NcXkHE9Kc/RlKE7LV
	a2OD7UtcstVSH0a0ZiI65DXaxaQDA4UGy/4WrxyITqRdW/I+RBoNjI/6Wgo+sIlsDotWUE+Qb8f
	xuiBthW3njWdNgmInUXow6Fn/wORWx/gQc2/rfsAZ/J7Data6k1G9Qq/7aJquGN6kwvEHZJ5egj
	mvu4KUtZXV2nxuLZ3eizxRhTdK7k3rV/hdUX6qS2BqNe1fnZevPwV/+bFJew4XeVa8+IcB6nZvf
	u67QaTRtcl7YEEhIs0J442LkLNWbxQZG3+N+0UQ==
X-Google-Smtp-Source: AGHT+IFUOXIG8Fr2xTOPb12sdzkJ76EHYYR79u7QBoj6jkdmmEk1+A2/y4FejEdhhllhm9l7BrFuNA==
X-Received: by 2002:a05:6000:1882:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3b60ddc647bmr21356244f8f.57.1753187957328;
        Tue, 22 Jul 2025 05:39:17 -0700 (PDT)
Received: from tearch ([46.104.48.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm13525197f8f.58.2025.07.22.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:39:11 -0700 (PDT)
From: muhammed.efecetin.67@gmail.com
X-Google-Original-From: muhammed.efecetin67@gmail.com
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	lee@kernel.org,
	rafael@kernel.org,
	efectn@protonmail.com,
	daniel.lezcano@linaro.org
Subject: [PATCH v2 2/5] mfd: khadas-mcu: drop unused nvmem code
Date: Tue, 22 Jul 2025 15:38:12 +0300
Message-ID: <73c18d4d5673f3aeced46bf36ee405fffcd6e2bd.1753179491.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753179491.git.efectn@protonmail.com>
References: <cover.1753179491.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Drop "khadas-mcu-user-mem" code since it is not used anywhere.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/mfd/khadas-mcu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index ba981a788..ca4bd6cf5 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -80,10 +80,6 @@ static struct mfd_cell khadas_mcu_fan_cells[] = {
 	{ .name = "khadas-mcu-fan-ctrl", },
 };
 
-static struct mfd_cell khadas_mcu_cells[] = {
-	{ .name = "khadas-mcu-user-mem", },
-};
-
 static int khadas_mcu_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -105,13 +101,6 @@ static int khadas_mcu_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-				   khadas_mcu_cells,
-				   ARRAY_SIZE(khadas_mcu_cells),
-				   NULL, 0, NULL);
-	if (ret)
-		return ret;
-
 	if (of_property_present(dev->of_node, "#cooling-cells"))
 		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					    khadas_mcu_fan_cells,
-- 
2.50.1


