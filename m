Return-Path: <linux-kernel+bounces-815339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0486B56302
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB28564214
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871AC2701C4;
	Sat, 13 Sep 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXmGco/0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404D1DFCB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797567; cv=none; b=KJXolfrZiiajTkJs3cF6kZPruq/7JpVzcxhMC1Enr++cNCBxdVlRMTH15pAGiRD1V+uz9QUITQeV7cgAIhS6n2xPzptBK4vkXrfWHmHnalyq26C90gXP1u/LRCYHEddeT3pfdfo2U/mc6Ng4TQbm+noxVaeVOfUkFW27Nz/xibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797567; c=relaxed/simple;
	bh=6cB1PIjaQQyA3kiM2J7WpK5U80/7n0eJSfHZG2fZr44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u02J7rNbOtINncN+b0FYFICceH8fs6F1g/lGgGOL1lVS3sU0nt2RX+6qpoHbGBvBXj+331YcigKh4voarnr/mW11+wo+CHYPS8i8DtWd6yYDrfwmOp5P90p5deGERN7gYp5cZVX5+FWypIkSXJg+TEXvnk7pW4xA+QawdZEPScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXmGco/0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45cb5492350so22319365e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757797565; x=1758402365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmIep1wDMXSCh9cFnFi6p5dn6PsaCtoTytyMPukDvHg=;
        b=DXmGco/0uk0XJ0FEoKVngxNzkb8ZUWOE14iZBFF6eGZGFpGOd+3PbV+3JsRHGqFwBS
         tkh3sFzYMbmIldgPLkTYoc7kexugY8xYZBu/OyePE8pSF/ZqceOs851rTzsWtFTp2k6v
         svVWdQQlkBHM0hG6PcNIIzkcvNgGmay6/N9h2XfYF+s92VcXw4iuj1LQoKyROVRII/k3
         BSk35MYDmllSGtCSjhF0UAcTCepAKW9XIWieRxVNHPC45c55iFkKa9Gya1nfu06oGRBx
         Nh8kyXiTCjm85wmA34O6KfktbRdq5zjQnD8KgtkaernEmhSUUBOr3Yq1SjFfv6CTQ4S4
         yblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757797565; x=1758402365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmIep1wDMXSCh9cFnFi6p5dn6PsaCtoTytyMPukDvHg=;
        b=L+z8VuCnIoWMqXF91GIFkFSXioGTtZ5WHeL/KMbjRc2BewZ0ysQRv3VfHJBQWq0OMh
         i7DKTJlW+BZpRwzmPGXSixCcXJJpT4sB2nmrxplWcHBH2zD8k6JxVZT4UQHgF2Xm1JL9
         GdvZdeiX2rTKNE+lj5KIBJ1cnUEtn2OYpsdrgvBM7Ii7VrJCVW6Yu2OXeaeYnUatYhcx
         ExzrN+gm8pfHNUjHUEyApqBhrnrlHuFj7etfdKYuSKDVVSG4XJgxI/Hb42p6NRdN5TOs
         mkJy23CsDpEd9kyfVyrxpF5XxIQN5PjoRfe+uC61agZyYnnrnm4sB1ZhEoFe8A+WV6YC
         qVuQ==
X-Gm-Message-State: AOJu0Yx6u4LNmlGOrg6g/SZMY3e6mYvuvBGlBnHX0VXkQdmlxAI9rGER
	ZFHU7D4oIt9IN+WBMfl5+eddesow1D6GJDzN5jaBx+OsYZdpwnq8lPh+T9r2dbwKiEs=
X-Gm-Gg: ASbGncuiDJRkQIEQq3YA6VxUw/N2c56e2/d2dYu8vHS3G7iayz0/YuJRVYhP637YLzB
	ehVgTIu5MHkrW04L9Q85tfGCXhE/EidGBzC0/Xluh3TvTbn3F6fMdvgNmK9gB4/2EWbvZ/M1C5V
	MO/2CodL2ueTQcWIcSIdZ2rv1ZZ6sv9Xibet3Z4Uaxvq18/6od33BpSqrpInQnIbwX/sDrulH3x
	urzLgyr9d/SGTrSWQ8lx+E4PXydzpETYuMbMymE0QanWIAPZJjgIJpo2ciqoLtoDv8UqfWAufVf
	RtAEbXXwHFO0+ISazdJiMCm6Mvx8oX3LGbcyOY0zGRp2ZOksqBEm3GAe8qR6AuuFRJghH14DC32
	kyDCyPd74+O5joGl5SpLeG5Al+VMvcuWSDfKd47yVsQud7+ljcc5zPcWTh0JqO1zRnD9J5mS/RQ
	fWpue/LANR6m5jgHl7+w==
X-Google-Smtp-Source: AGHT+IEYwuoz3GBF+LcAApgP3wlOqXjd/zQg0xRvpKkhECl0nmQkywM1C4DsgdjMud4YB9ZOC1LytQ==
X-Received: by 2002:a05:600c:1991:b0:45d:d522:5b2c with SMTP id 5b1f17b1804b1-45f2120717dmr63479955e9.34.1757797564602;
        Sat, 13 Sep 2025 14:06:04 -0700 (PDT)
Received: from localhost (86-42-187-225-dynamic.agg2.cty.lmk-pgs.eircom.net. [86.42.187.225])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e0156abecsm112655735e9.4.2025.09.13.14.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:06:03 -0700 (PDT)
From: Shay Power <shaythomaspower@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andy@kernel.org,
	linux-fbdev@vger.kernel.org,
	Shay Power <shaythomaspower@gmail.com>
Subject: [PATCH] staging: fbtft/fbtft-bus: remove empty macro argument
Date: Sat, 13 Sep 2025 22:06:00 +0100
Message-ID: <20250913210600.36986-1-shaythomaspower@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed the trailing empty argument in define_fbtft_write_reg calls to
fix SPACING ERROR reported by checkpatch.pl.

Signed-off-by: Shay Power <shaythomaspower@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.50.1


