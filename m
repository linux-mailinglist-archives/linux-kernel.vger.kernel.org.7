Return-Path: <linux-kernel+bounces-829471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86422B9725D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DF01895433
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A102DF715;
	Tue, 23 Sep 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in0c0VEy"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013F2DF12A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650406; cv=none; b=KlG1Xezc9naDDgosETS5kjC/WEvbTziiH7BBbE6Q9fk2ioPjSJ6av/Ux0g2sm2gAUy37FC9mYgOIC3BEPROdJk9BhnYGfRZMav0wo/qecGKR4S04tfDeyAqmjxlbSBO/B8WnDTztEJ22CC7uU/7aKGoCNkg0p1Dbc0ySPohy+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650406; c=relaxed/simple;
	bh=7Bo1kzD0/rFjU3dEcXj4ae5Kzk5PeuyJqqmxduk1MfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/HhqE0vkFVXu1hmtLImK9oXrqllIe+2ntzS7kdqF5d6nVrJ4O3cCQP/0WZu9/nIg8gAqg0o9JnHOybQNjJ08mGUlbLQ4OGYRN/US8OKfXaIs9CiELSrtdLeMo5Ayuj5SXgaJlWBpAOqreYxsn8g9dapiHYFqwSIsZTzzNq4L3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in0c0VEy; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-267dff524d1so43476415ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650404; x=1759255204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPN+oc06mTdPxDaONBr5KXu8+tb7IBNS+Yxkpiu/3UU=;
        b=in0c0VEywPEsCmDmyF9Mh9y/0tVbSnwScqRLuwG9aR3v8rE+SamUM+a6vizHm+BPAi
         RXOkjJGZipXzKXOoOixY9isMZLj9zYUP7MRTUfabQh+tB78XEMHLSL+4Q/2F1pBZMd7B
         WeTIm7bxVyG7ew/WQhRAbfHuW9zkpB5FUW2xxELpWD3scLVyYtNz7Iw6sLJdWF0Nilxy
         zwNfGSJPSnqjtDwYg2GtzZuEbX/YwZyB6/I8e/uFGRnPNqqFa5XnuI5LklQaw9Zzj/qd
         f8K/Phn0eXLtgFV+w9Lu3CiQKu5vB7jOk8ELeg+sbs6g4DWZF8KA3vCz78yihsK25HDj
         C+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650404; x=1759255204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPN+oc06mTdPxDaONBr5KXu8+tb7IBNS+Yxkpiu/3UU=;
        b=aAbGA0TIx7j8IpUBg8yEroUSr+1EeH+ezy5fiUZUobpH2moC0zRCOH+ivHbw4q1Lc2
         ygxKduVf6a+9ntqW295YtpAS3Gazdsm3WC7Qqkt9/72a4JRlvGZUyTE1uN1ZMg83VDat
         h0qv7/pPJuxCJx5klGVw0c1ux3xQyEUGBAcCPiS/XIWhWhlvqFxGzQ/W5oNbjL7zlvT0
         zkgrimiEKcmLiAEez7truRBVPnw05FvkcBOOvDJwsZNRi59qD/nPptTqj5Db+JvZvYaU
         3OrQbLrt1pb2Ics7n8v2J/mPwaZySw8/LMEuENSVCcagKQVDS+cgahuZxQT2qq5DJM0C
         XB5A==
X-Forwarded-Encrypted: i=1; AJvYcCU6QuiIe6fe8WTDamdwoFkOhCDZiGy6/718p98AQJZFa8ceUBoFcz1drdCSrmA1WLWc4ST7ZLE0EtDgS4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrhl0gjI7rsg+PU3Bdj4RQ6TmY3oicQNUQLv/S/eeLvaO2CUGc
	Chexu/zNklIDcAApHAS6oJNQmmmu+Q9ulAENoFOfroVGIK6JiAZ2az3Q
X-Gm-Gg: ASbGnct9JQqsbWHouJAP1dItM1ZDbav9yMHzj9JaBOsnPXutrC3kJHpQPcsK1XZsrwS
	59iNbBRRT7cgiT1Z/iZem5x5b+jzDfbWLq22qPnPSH364UrRhhTH/+HmzWfHM35MhwI4X7syWTB
	s+jeWadyRNB63YTL2LBFbSHdwUwVDcbym495ktV5CdDFjyWzAl/BbQGh9+9byDXLzKg5C8Nn1SB
	SN8t4f9hzmw+kri7v/QmuFYTUKlW0RN7W5nYItORS6XEfu4bzIoHgOiYF8XB0QHrT0kupomVPHX
	ZMyiEP7KHVEqcghXFFXO2a0zVbj1wUAC0+Wc43cPfir2taKLepp86CE9/ChXtTPCKOgGxy+GwPN
	X5YFtjRTBcAAaVFcFaOddNHLlbw==
X-Google-Smtp-Source: AGHT+IEWKPk22+IFda8QlIhnbmRUEgNAemmbBXNZ0koD7vh+dtohjy+qJSjFHMQPXGRYWGDbqNSDrA==
X-Received: by 2002:a17:903:1590:b0:23f:f96d:7579 with SMTP id d9443c01a7336-27cc5431617mr44289415ad.37.1758650404028;
        Tue, 23 Sep 2025 11:00:04 -0700 (PDT)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368dc1sm164122485ad.152.2025.09.23.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:00:03 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: hverkuil@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH] media: saa6588: Fix unsafe debug printk macro
Date: Tue, 23 Sep 2025 23:29:27 +0530
Message-ID: <20250923175927.4380-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing dprintk macro used an unwrapped `if` statement, which can lead
to logic errors when used in if/else constructs. This patch wraps the macro
in a do { } while (0) block to ensure safe usage.

This change resolves the following checkpatch error:
ERROR: Macros starting with if should be enclosed by a do - while loop to
avoid possible if/else logic defects

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/media/i2c/saa6588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/saa6588.c b/drivers/media/i2c/saa6588.c
index fb09e4560d8a..71d34d229564 100644
--- a/drivers/media/i2c/saa6588.c
+++ b/drivers/media/i2c/saa6588.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 
 #define UNSET       (-1U)
 #define PREFIX      "saa6588: "
-#define dprintk     if (debug) printk
+#define dprintk(fmt, args...)  do { if (debug) printk(fmt, ##args); } while (0)
 
 struct saa6588 {
 	struct v4l2_subdev sd;
-- 
2.43.0


