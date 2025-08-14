Return-Path: <linux-kernel+bounces-768155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A333B25DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10EA887139
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA492267AF2;
	Thu, 14 Aug 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+EUehwo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22F23ABA9;
	Thu, 14 Aug 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156850; cv=none; b=BNDvsrKDbBQkCJC+VtfASfZ0DlJ1yVxOvv8hjnujNO8JaewUDc3bLWkBP7h3yCYqqhCS3JyVpzEfNy6qeX4IjWSajHZQCV5zD1g/XH9brKxQHtCTGVFRwhFEMTrEv0/CA+juvK/pt6aZvIRM/tpyfMwUXmruVbEeAWv4rtbIPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156850; c=relaxed/simple;
	bh=LJd1geNBy2YUOQZn4tcXpzRfpGTicx49it90zq+bOqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o9ED3z2DAvkcCVM61lC4NHDBKLsKavhPt6zjzb4oFHviTKLrxODv13KuQLdNr8K667SEaUr+dLJ9D/FyaBiZfwVginJW8JkrR8j3qIF5M1PwybBVeKDZgURtr51UJuspTLDLvCGK3FXAM5xPD/EZfX0h6fjSE6nTWHow7yfCDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+EUehwo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b005a3bso2837935e9.0;
        Thu, 14 Aug 2025 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755156847; x=1755761647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2M/m4HKQCvdWjIeylkJsHm9kOPrIMl3GluMn7yeTG8=;
        b=f+EUehwoB16pteqa58GXHsaVw608DT3bg89sVHR+B77PZKQqIfGngm0cR+WQB0nDPk
         JDKo204qnYHo5jyoAVeO/RdANX/oZt1ITvhBIucqifbOjuxftE+yRy0mQ7OWhv2eCE61
         gRMuHONtR7cWSdLJdc7FfppshiluKRyQq2W171LMYZHqE5wyEPIyD2PEbunXs0Hw8JnH
         49spAH+Jkf1UPDnF9/y6ayu70Jk4JyLLmBvNDx3OUKkPGfvv3591g8wKArAdAotF4BbV
         o+V6F6ZyTykOsmp1ClOWl+xTcjR4V8yMrwCwHFoglBjunRQt0/4vgW37cpM8GqdiyKAa
         sFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156847; x=1755761647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2M/m4HKQCvdWjIeylkJsHm9kOPrIMl3GluMn7yeTG8=;
        b=FLK8T2HqDE2hSRTpptvXqxV2lmIhkkGZ/1eIB51W/5iw8uY+aW2gQeByB0qjC1+NxK
         KiGRtUNbenBnB3FM2WUSbmTEQhYn/mKcH7MfnGUbSI+EpRMSrKMC0v9F0dCwTiGoFlV5
         q9gDzACzb0gaFnq9zz7LWoGLal6Jrg3eENfllLdeYY+ON6PZjItN67OKdVg5FJKlp/xx
         UVPf5QxC/RoMCNOvfN11O0nQxsoVrNBmjgjcSkFlqWEh+p6bTsDgTwQRS0H6P0+o0T8A
         W8QuGpo56s3l0Y1GeGiLgv+y4D8f4Wz2L6sIazXfPQQv6POaaazrhcZ+FnXy+0isrgEY
         bXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBEXrpCj6b+oxCY2VpA3oq91nsgHTLHZYLMnF2pn4OFQKO2jT+p5M10V+72Z8zANRQshPEOjKdT6JtndE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSl+371CRdOJCpKhk7ce6IUISCpZLX1sDX22sfwMDrmiT5LTZ
	/Kh5iI5ju0Ty4U8YAYx8FKD/UczjUPIq96sDSOnzxsCAyua36B3vymX4Zo3Ao2IUKcwuAg==
X-Gm-Gg: ASbGnctsd2RadbnP4KbO/nBsSJqGSZJ3OM6kT8LIcefxFyxcJAPBO+A6QBaJY7G2uOs
	zReRfQNGTsga6KyVdzcKlWWo9s+XKi5ZQE+XQ3KwQR8UsE/6HxDFxS7OjXW8vQaVHwMF2dqvvwi
	yh3mgiSwKq8UC0grpYjcDcuD2aIxl1lIq0xeQBy0zCrKc3NFJzC9fmKkUlGapP2n/gySVMOvLg3
	s/Ed3aFZx0RcEMTYb5lFOqMqoT2tbkc6t9RpunkuvMgkRDNYdoZ3RJIikX6XpEaG5zROWWASRaF
	Bk7bKwTKkW3JjwPOTtg4u+f/EddM6L6SChHHA8uc3Olomhx523GOqvZvHugfMIjSR6/Sfj/QBiy
	NM8+55vVt4m46xT3Pzv8m
X-Google-Smtp-Source: AGHT+IHppwspW/kQK459wuYUKs5NhnoXjB3l7OFQXOpJgl4ZFivqjr4i4+wqeEkBa7r689nGdTGULQ==
X-Received: by 2002:a5d:5f4e:0:b0:3b7:93df:39d0 with SMTP id ffacd0b85a97d-3b9e41783a4mr1535118f8f.15.1755156846682;
        Thu, 14 Aug 2025 00:34:06 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8e009e465sm41792367f8f.43.2025.08.14.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:34:06 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: rt5133: Fix spelling mistake "regualtor" -> "regulator"
Date: Thu, 14 Aug 2025 08:33:26 +0100
Message-ID: <20250814073326.17644-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/regulator/rt5133-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rt5133-regulator.c b/drivers/regulator/rt5133-regulator.c
index d0f367381fbb..39532618e73d 100644
--- a/drivers/regulator/rt5133-regulator.c
+++ b/drivers/regulator/rt5133-regulator.c
@@ -511,7 +511,7 @@ static int rt5133_validate_vendor_info(struct rt5133_priv *priv)
 		}
 	}
 	if (IS_ERR(priv->cdata)) {
-		dev_err(priv->dev, "Failed to find regualtor match version\n");
+		dev_err(priv->dev, "Failed to find regulator match version\n");
 		return -ENODEV;
 	}
 
-- 
2.50.1


