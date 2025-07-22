Return-Path: <linux-kernel+bounces-741264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B5AB0E220
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4B6548238
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9227E043;
	Tue, 22 Jul 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOmirMj/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFA125A34F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202898; cv=none; b=nA5hAKOKXB6cNGXWtqZpBANFxygu6GHXGQBMQIvBm1dNTjH7AC9dfwUimf51iNyGNEyyhYX7oryxdQ80zDUlVBepsedV1GgHSJgBhwDukn9VlyMoCSZQ85BcljddYZZ0GJMOnlOG0xTxz9Yltbji4ujUggzql1rfHJ4WM5VFnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202898; c=relaxed/simple;
	bh=BQLxK6QNZqGDGYvT1tqhX06NLvVqubTSINaqRw4OZRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvUJ+RxPHUYZEdgSomHr8Sf9yLmcrPlrmW5G5W+OKH6ZhiWppxd11flctrqx9cKoVLnWJLBtiCB+BdB3cm6hHgAwpzfMwFCjgpIUk4CDdf4LzPuPQFLVb1CTmov8RDKUB7lcdHodx4EM39n1+jtQDucRlxnmiPhx9RX7nHpBK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOmirMj/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455b00283a5so35144855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753202895; x=1753807695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3lRxwpSev28TePbbD+/Qgoo79t3TAvOtgeCaVQp08s=;
        b=HOmirMj/eRbAl6BK5TqphWGcXidDr7d9mEKlnET01n5AWxGq8Yb/19EH+wlxsTmDTP
         nmQklzHUzGTvs8tUtuy4F6lGCSA5mAPNlxIDAUnL0+PU5SkgJEWAPESx7k5YVfKWYt++
         S6w5c+uo2juXIwQos/YpQGE44KznISLGoBlSYynPbIsWjo4emL/gMXpgs4t8HJjVYfKu
         57Zl1TJJ7Vknk6DVfozQpKHQHwlxTV5Hf3NEDfXgekuBklBdCKCEjiIa0eH0TXdTiJ7v
         rWq685Pq174gnE18eXDO26jaECf+czIkBPTjaNRf2jmZQUX8diTkkcUzCnMSmiHDd5kA
         BiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753202895; x=1753807695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3lRxwpSev28TePbbD+/Qgoo79t3TAvOtgeCaVQp08s=;
        b=LX5YEge/+NskYDfzh9GT7xYw60NOG45ZtKngibad6sMykcIeKmFKLyJimDd88MPKne
         mxKsDVAw+Nw74N+LAo4YO2396o2ZlAdNC98ohJpzM6bR4IbsHD34Y0CTQTaQEm5QtLO9
         yYQa/WVfy1BtdgGRezIXojcoOq6Mf5rk4jWggAI4PIEOPK5b3g8WOsLpNj0OkngKuDzc
         7BgC5tIpcYop6YGdJ1UEDAXCTn4x51ggxH+w0Si0G0N/K1hqokITJdhvnDDjbWZgsFxt
         9CJEaBwdMn7Jq1xlz+kjACnOTCnlyHLdwLDyzkKa0gBByQPDpJsP8Yx6B7hZU+Mp5yc9
         RQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDDFK5JSu1GKDJdoTNBOMqFJZqo0n6139WiTJHDY7b0dTMW02AKEuBSJatWMcvKfO2F8f67c6jcDopDQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGKWEgKhzGQINU81l9XgK4Zq6AVLjc3OwoSXgHIvgNJ/odNox
	rnmGgDeUW0ZeS0DnwxdU7EoUjebXAx88IbLA+lf104EvKbLrSdx5jPtg
X-Gm-Gg: ASbGncsC1uA888a6enkkIVY+c6yl0zWzCHDwPcJhKXOoOVn03PKEfna0FViid8Wt4Nl
	rX2N2pztrJY3K9emvx3vJ2bgC7JNugjWgUFc/bJr4wDF6v1NuO4MSiDuMFJlxycTrq4ImcahzeK
	443JdfLB9wrX20uh1VvfCnydzpliGfGAU8aj0+R1PWHvIIbV7NxCC6qeKsBIqpa8hhi5DImvlyF
	g0W5HvLmDUNthJYpGbC0SMoEO5USg5TPzYXgxT4U6l/UBKZMto0bNbIeWKZjiFFty15GSShMEvX
	NW1TMLnRW5T/TVzW80qqTSPT+CUS6iyDwRyIQf7j0E0ZksBWHG/floHT4lidcM0Vejc152BCGip
	mCSSM5Bq7v2hDSZ1KBh+whKzMkgMLeG/frlS9U3g=
X-Google-Smtp-Source: AGHT+IGSrnv3OH23b5AXkhuLVBuAoH1QvwJx6IlIkzLx0/LotdK7jxu1iX1BJQvtiSRBdKjTuTDLPg==
X-Received: by 2002:a05:600c:6219:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-4563b8fcdcbmr130426955e9.33.1753202895054;
        Tue, 22 Jul 2025 09:48:15 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm192801785e9.8.2025.07.22.09.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:48:14 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: Add init response codes for new ni-usb-hs+
Date: Tue, 22 Jul 2025 18:48:10 +0200
Message-ID: <20250722164810.2621-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new version of a bona fide genuine NI-USB-HS+ adaptor
sends new response codes to the initialization sequence.

Add the checking for these response codes to suppress
console warning messages.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 7cf25c95787f..73ea72f34c0a 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -2079,10 +2079,10 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 		}
 		if (buffer[++j] != 0x0) { // [6]
 			ready = 1;
-			// NI-USB-HS+ sends 0xf here
+			// NI-USB-HS+ sends 0xf or 0x19 here
 			if (buffer[j] != 0x2 && buffer[j] != 0xe && buffer[j] != 0xf &&
-			    buffer[j] != 0x16)	{
-				dev_err(&usb_dev->dev, "unexpected data: buffer[%i]=0x%x, expected 0x2, 0xe, 0xf or 0x16\n",
+			    buffer[j] != 0x16 && buffer[j] != 0x19) {
+				dev_err(&usb_dev->dev, "unexpected data: buffer[%i]=0x%x, expected 0x2, 0xe, 0xf, 0x16 or 0x19\n",
 					j, (int)buffer[j]);
 				unexpected = 1;
 			}
@@ -2110,11 +2110,11 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 				j, (int)buffer[j]);
 			unexpected = 1;
 		}
-		if (buffer[++j] != 0x0) {
+		if (buffer[++j] != 0x0) { // [10] MC usb-488 sends 0x7 here, new HS+ sends 0x59
 			ready = 1;
-			if (buffer[j] != 0x96 && buffer[j] != 0x7 && buffer[j] != 0x6e) {
-// [10] MC usb-488 sends 0x7 here
-				dev_err(&usb_dev->dev, "unexpected data: buffer[%i]=0x%x, expected 0x96, 0x07 or 0x6e\n",
+			if (buffer[j] != 0x96 && buffer[j] != 0x7 && buffer[j] != 0x6e &&
+			    buffer[j] != 0x59) {
+				dev_err(&usb_dev->dev, "unexpected data: buffer[%i]=0x%x, expected 0x96, 0x07, 0x6e or 0x59\n",
 					j, (int)buffer[j]);
 				unexpected = 1;
 			}
-- 
2.50.1


