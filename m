Return-Path: <linux-kernel+bounces-754720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3EB19B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757BC177003
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CD22F16E;
	Mon,  4 Aug 2025 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGfDJj8z"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79919223DCE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287891; cv=none; b=NDt8RYOYzfI2o208iUy28NzHTJQcc+oCwp+YT2Of6BX5TkqUvyrWG/HBrS+iQcGoDfJAXTirhPq82ECqjliVlvqQiYUA6yQRCLM7ZOdpqisUxh7pgmllWOYMHCkrSgEyfSlZUiBcYtuz2xzHuaujWzKpWI8IOSh9dlQC6OASj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287891; c=relaxed/simple;
	bh=6sKmS/5c3VcSuMhoTPhJAZc2y+PVgAnAv6l+2/XuopE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMkKHB/Gs0ujorKhyIF0R6ytnZhdX1DwtJNHys+sd2Rgy6+2JQa8pRBsUHaZ1FCV3l195xg81FkwRRm3QM4AQ3m0sa6nbn2Mx0cVXXJVFhAzkbsENTD5XVShVcBKv5gKhSqW7ODZ2Sgm29gXMJ9eWCw34KS7VW6B5SKb1iAIliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGfDJj8z; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so3979239b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754287890; x=1754892690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m32bZyb6SJnOcY3tjh9ljjeq+YXt/MVPLhG2/S58q+c=;
        b=SGfDJj8z6nCqnQkYvboX2R6ikysfgmPld6ra+L5kuyj6ulW8cMXoIJ6HE7Jlr3QZdP
         /XbAPEkYF1UEoixe/1AhmJffyouDaADN/KuR7FdAQuxbD1fxDtC7EMp6UnWGozLLyqVT
         aKWTWZf9kT5YjpzIu/qTB4jpkzxbjLGwLVw8G/VQwALM53wVzHNl061u2AC7wH3t7A6P
         29F+uayBI4JshDWX4A89MJ1CaORE3aNYPd3+mq9FrKtbwcVVp7TSES4v+uTUGSQMMf4u
         i4xCQ/Do+RGnDIh/tOEw+fxrUKRlzS8dRDuUInqUl97y8Qk5e/PMuzmI350TZMgfXjLm
         rUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754287890; x=1754892690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m32bZyb6SJnOcY3tjh9ljjeq+YXt/MVPLhG2/S58q+c=;
        b=n4P0b/lsCCss2kzzNyIHErXYrZmGBzkg+uiHp3hblErrWkqQ2DadsIRdcJMCS8TQmJ
         kHnbxSpYn7BMe5f6MOiN32nV7F7nwtdNdX1AR/NxCZGD925i8M9lDkUhAFGy28R6OuuT
         pDzlUI3obKCECVaUUca/ecKnnmHDts9hSyuT+cpxeVy2YDij+RGDNX6UjNwExCkjmg7A
         jSuqSLTSrchgHqubkQZFmt2AVsCP4rofonOdrm+oGBHUDm8uo0rStBhJte+tJwPhk1aB
         hpkJXkOxI6tG+KTPtCM53AlG/IWYELgEmOn6R2yF3NZOBb8NZ00nrHVh2DV1bp8utttR
         pgwQ==
X-Gm-Message-State: AOJu0Yx+R360B5dtYRNoSely/RyFrnQrf9V2y7GQ0Ag8QHIzkTKeSf2d
	0ch+0bOZGEWkJvnXDvZwU09A8ootreyGiw336swN0y3QfI9eebEPv3iP0d8sxg==
X-Gm-Gg: ASbGnctf2ou9/3lChzK9SFNqjBKsIQXsk2It8/TrE/qaUp/9D0K7K1ZFgq0ScwPQkio
	jkwcYVdhA03N+ENsfmjq49TdH2kD7kLkxMNHm7JhSxSK0eoT6jx7Dcn1JlESREk1H//CcE7NCli
	8xsSPl+U8VgKhGPIhwlcLOcw1vVOFjEPshwGdmtMnkJY26YsLsLrzcTN/MTb32hFpP653lrPA4y
	mg5UNLqvL5JRbmPjAXaYGX98ATRxb7fpU+uNcRZWVb3kCnr05KDzQOiIs6hb4/jR1T7IBaGJy/z
	+aagsrg9P8KwclV3qFd4dA0qgPmN1yrhOiEygwcKmE4i1he3yAdwL0Z6I8Y0+32GLcSLUF58Tug
	USTIwUuCOaDxZoT8CufjKb/95ZmD5w3AQ9FM=
X-Google-Smtp-Source: AGHT+IEjxdVXlQtdKzygt/JuqJupUuqa1kMedgmhyOyO0oItcCsvYDgx7xGqMb2IBDegbm1KLzzGFw==
X-Received: by 2002:a05:6a00:4c97:b0:76b:f01c:ff08 with SMTP id d2e1a72fcca58-76bf01d0125mr8694835b3a.2.1754287889611;
        Sun, 03 Aug 2025 23:11:29 -0700 (PDT)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcdd40f63sm9618024b3a.87.2025.08.03.23.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:11:29 -0700 (PDT)
From: Ao Sun <aosun718@gmail.com>
To: linux@roeck-us.net,
	matthias.bgg@gmail.com,
	p.zabel@pengutronix.de,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	Ao Sun <aosun718@gmail.com>
Subject: [PATCH v3] watchdog: mtk_wdt: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date: Mon,  4 Aug 2025 14:11:24 +0800
Message-Id: <20250804061124.7150-1-aosun718@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7f952385-ae89-436a-8f7f-f51582f29cc2@roeck-us.net>
References: <7f952385-ae89-436a-8f7f-f51582f29cc2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the device resume process, an interrupt storm occurs after
interrupts are enabled, preventing the watchdog device from being
resumed and functioning.

To ensure that the watchdog is resumed and executed before interrupts
are enabled, Use NOIRQ_SYSTEM_SLEEP_PM_OPS().

Signed-off-by: Ao Sun <aosun718@gmail.com>
---
Changes in v3:
 - correct the Signed-off-by.
Changes in v2:
 - remove extra space, and align multiple lines.
---
 drivers/watchdog/mtk_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index d6a6393f609d..7dc53409cf99 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -327,8 +327,8 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
 
 static const struct dev_pm_ops mtk_wdt_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
-				mtk_wdt_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
+				      mtk_wdt_resume)
 };
 
 static struct platform_driver mtk_wdt_driver = {
-- 
2.34.1


