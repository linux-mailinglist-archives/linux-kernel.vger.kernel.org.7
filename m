Return-Path: <linux-kernel+bounces-730064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B07B03FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014041A64860
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3C253B52;
	Mon, 14 Jul 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uau/Xy56"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB831FBCA7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499466; cv=none; b=UGqhsNaSEi43+qOwvsYCw63/1VOPgYMH+UHoZy+VNuOTFSgBYuIrgcRdos0k34Ujipw1Szxrq6x+N7s/DU6Mw210fSO5al/UvNO58AiqCi46cEXmMiT0MfdIHJuF7mBz8HodY4Q7I/SiwQGM3eOx0v+LkCw4C1r6UVyHYzPPRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499466; c=relaxed/simple;
	bh=J2ffDN6EUGZ8T6S1yTqAhB2qvyjg/RtWmUp9VgOF/fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gshdvlgMVZTQcJu7F9kV3eXNtfGAEa/cKBOs0cxnVzW3cVXX12YL8uCOU2fL6Ov5/LbsYjZABagQB1LCnp09CYdKGsVv8b4/XflVG++tYADlfTUXYh458gyqdpl6leDlWyYqAgjwgD2wmcdMK7NhE8iaqzl54t8VAkeI68bjjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uau/Xy56; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e1d8c2dc2so38617137b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499464; x=1753104264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXTxy7Pkq1/nS+EI0CTjTLmkB2ARbkqsIO7hOa/3iDY=;
        b=Uau/Xy56zZc0ICqdYwyzoSgKcTUGxShA5b6H52uIjeO3ALB9FoOMxabq4oYEEeTtOS
         vlGwOErIrOVHARWRa9PqWNMpZgWuV634qpvRjaRy6OUg/FGYR4jpKJAZfoXhQGfIivbq
         UpjxzQqauEE6IzWrsNyV3OC91LLQQgJAn0GpXNlKde2gs0uWC62Kgk3b2UisnsHbiY1K
         O7d2Hx1LM2azrhhBQZS5EfS21S5chNsG0VdYRPL4jah1/oiGG9sRdFHmarjM3OlgySDo
         BTz+B5Lt2rOwCnCOZHiROqAm4kLDkmm69RUWJ9uRIVjgoBnXZVa3wNlAaBLS+imSQL8L
         o/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499464; x=1753104264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXTxy7Pkq1/nS+EI0CTjTLmkB2ARbkqsIO7hOa/3iDY=;
        b=CmXW+CL91zz5z4zgH0dpcqnywi+aji5uQEibBTolA2Ft20CFwY7bF1ailcfVuusZdi
         D+LsGm2cdAlObXHoOqplvgXNUS+YmQuZhI9TtRfzrJSf7cgvqEf+h9Xe5VVS6SY62qzS
         nA/Ii/8h0e9/A3T+EQLfyDwKG0LpZ7DHSD6nRIXNIVrT8oYBMaYIFnUSvvEC95dEZz05
         KQ/RNjZWF9GrqtXW8Hcs8FKdOynhDnjG9xE2Z+DXAt3zU28DvgpsOZ7DCrSDiz64pIZ6
         Yw8bzp7IXjgYRxg7+SwqBy0ZLehlVD5vLU0Yp8wsc4ZSP+mAAaSxoj2Q55eJugz1g+pn
         M5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVpg2u5TT+6Wfs1OQxm7VHIC4xt7pe2EZe1vPJmmVEqmybK/o+xgpBxyLmlF+PNlikhVasKwXhk8Hk25Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyRQtySvSLZwJKZuKhDwXf+iCJg+9VW6lYU9eHLzjNWY002AO
	GBJ1kdwcgOkOy8miTpwjOjibKnm/oKpHa5CKFOydWAjcDivE+fMiOiWSHiAXcbM3QMZPCTeY
X-Gm-Gg: ASbGnctaNBftsRh2LWImTR2K4jsVjCPTYaHlNfRijHEBgrctbA+51AMAndYHG6ywpdp
	5IS0OTqTxq0zrSEoOZaUi2r8BLsG2Tr15j+dzsS4GkSW9J86r5uYf9v3dWgQULN1QtgRLY1vgPa
	EHIY7ya5d5hk3lMYwZufnh1vgcz9rrpElO//JhkwQIE1uNZDzCkRFltADEcedIUf4jwz+tJrP+T
	u4YoT6lbo2Z/x4sZfIaAxueC6waM4wdGHxzBdEPkQuEjoi+7GfZuUSStLIkgPPbIg546M1TcTk7
	EevNW/iILgqIWBU7a3ebfeg7hM0VTpBdG1RVgHhB36EDWCjJdyTeVr5MeJRNtdeMcyWZKDNK4+4
	NwxV19o+sjZV5Ogx/nrVOYcTewUFf6SM5mX26LQsEoA==
X-Google-Smtp-Source: AGHT+IGWPWcafeo1jD9K/VD7+214i5teUcbTYJWlQbbSLztFO7e9t2BvNNOK4UlmivGPBYP1VbXidg==
X-Received: by 2002:a05:690c:6e93:b0:70e:7663:8bb4 with SMTP id 00721157ae682-717d7a5f9a0mr194358657b3.25.1752499463531;
        Mon, 14 Jul 2025 06:24:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:5881:3041:2700:a2ad:ca5c:a53f:4ed5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61e32casm19546117b3.83.2025.07.14.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:24:22 -0700 (PDT)
From: Nadzeya Hutsko <nadzya.info@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Nadzeya Hutsko <nadzya.info@gmail.com>
Subject: [PATCH] staging: vme_user: fixed alignment should match open parenthesis
Date: Mon, 14 Jul 2025 15:24:09 +0200
Message-Id: <20250714132409.26875-1-nadzya.info@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the scripts/checkpatch.pl warning in
drivers/staging/vme_user/vme_fake.c:1064

Signed-off-by: Nadzeya Hutsko <nadzya.info@gmail.com>
---
Hey, this is my first patch, I appreciate any feedback, thanks!
I've done this as part of DebConf workshop
---
 drivers/staging/vme_user/vme_fake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 4a59c9069605..731fbba17dfd 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1061,7 +1061,7 @@ static int __init fake_init(void)
 
 	if (geoid >= VME_MAX_SLOTS) {
 		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
-			VME_MAX_SLOTS, geoid);
+		       VME_MAX_SLOTS, geoid);
 		return -EINVAL;
 	}
 
-- 
2.39.5


