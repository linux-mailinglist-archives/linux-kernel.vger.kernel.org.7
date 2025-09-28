Return-Path: <linux-kernel+bounces-835404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F794BA6FED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B41417C04A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8834E8287E;
	Sun, 28 Sep 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aafpli0g"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3E2D3237
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759059250; cv=none; b=Meh7muu6ykhodxiUYLRWdyMztN14/5ZQDwrvxqwkwJPvz1ev7aJgYmkem0u4NGs0GfqaMZoEuBxMcel5JF44RApH2buCLu5Irx9t/Dj58UemEe4vjYCM8z/0jjJ35D4A9gQVSpJoosefAciNLc5X0A31Jb/SYNxpVRo3UzhUAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759059250; c=relaxed/simple;
	bh=tScS/pS4Gn6GgvGk1K/xKhHsVgSJ6DREItv+LKn3W0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioyiF88fr9jlvMp2MbMYOArc9xkcZS+wMpTxNwchHN5QGQLcBN8466SRAw4uQmw+zuOUoLDwuR/652MnG1zmydArhjSlbbnFHaYM0jq+jaUACE8+k5SY1k/vUwywUVKKm8Zhb7w4b6S3n4kz3j4pvD2DiK09Z7pbgO+0yO5QdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aafpli0g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so36160965e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759059247; x=1759664047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnvGAr8iYkB0Wv3fJqUIRennMUMlOyLME/4zACe/66Y=;
        b=Aafpli0grrHOQ/KRW09rOd8kgr6UCe78hkKFXgMnHPbg2T/fFWn27nHmq+RiGxOv7+
         HRfmJUYdjssXJYSnF8L5l0ssf5grSuw72+nVfsGplhSMmtLjqk1Wt1nC3d/x9Dgm2XSL
         D/T+1N7bqoI0lb8KZlqRP7c9BhXihyk/qCzvRNntKchgZ4OAi//N5vXIjdaHbL9GWO8b
         tbOiRdhWAyQ5qdq7zqjIsgdoHqaP+uQI98iGyz5rBdbmbXdDg7pn+YJ5tEIZj4aBLpT5
         oq+/p2uYVsQulqn2pVt7aj9dpm/9SJBL/w2XEuFz2jLvvJ9wrbPMF2fMJh0MQ+nxoiVH
         MmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759059248; x=1759664048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnvGAr8iYkB0Wv3fJqUIRennMUMlOyLME/4zACe/66Y=;
        b=KRLiyAHjI28y/PwAvbnqHVdWQTC9jtgEP2Lgq/BvqCK8D7q4Syk+C1VqTZFbCivjlO
         aEufAZtL9YDTO3ps/Ic9H9ecR/1cuyJdk2fdOwzmb4BCgA9A0lehcOuPPvyvueW1MgxT
         KkjHG52fg4r/gKXNZ3b5G548m0vECQK2EqiMajSS4RbY2m5f4DWpkemKcJKqeAprU3+0
         AOwsvjh5XdGFM+tjEk+uU0eU7/q3XesQCBIu0WlqPjb1D5koyF8SFaWV+8rC+GhsPIQj
         +E18yEwbQBiN6T4zE+OsS3AfnVVJK6RN5KZWHr7thfXe7gkdRpWB3aDXWLNrLkcF0o9n
         +K/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTCyzAfMBGw9p9BjSeE4lwZvRxlea/PO5LOOgMqPsiV3O5SrRypEbNHk3TdueoTPqIB6bSRFpZ0bzu5co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSeDUIRwfVEt0TM3unZSHxdmMe1Oe/27z2GKthaWT8hDilQ6pZ
	d/Iy1jInEqT2JUptHwEkx9P2Y2HRgiE2lxg1+1Gis+wcfNBvqRric2SK
X-Gm-Gg: ASbGncsDacHMLh6YZZmuUzIxjTeSETINTq7K+3JaL16wgDZShsBnWy8WfUO2f9fNrdo
	7rrrvor9hj7YVzltOnqvj/vZzuPqXdw91j/XWosGbY2rYlXIqqjZnTnESy5veAmqa+YMyYil49n
	aaERvMBVH5wvd3k+5wvPQ27uP4c5bKZERts1u6cSWwIXAoBTvMnMlx05rDVCq2yQlhvx/iFvdi8
	RtXqxlSq+pQtcm+neMfv6N028jxuX5ldVQbUKSttZH38H2p8aXpJEAnQMoM4ajd64IuiLMZ0v8a
	wD4WYOj4WwOPRSZ1g4xWiwTLtNlPMNqIfgRxu5orlcWDVOn6WCfiAJu+BvMS6pZZTkhZDKSGdqU
	wzAdgYLnbXXyiysWl4C/Ifpt1bnfqZ5qcCne1Bg==
X-Google-Smtp-Source: AGHT+IGSoXJrQGjjbAQu+dFDiNaJeIvSNFQV3ZRIFhhtFQ94nnIsQBfhQk5TjF/wR6Cbv80f4vA5Hg==
X-Received: by 2002:a05:600c:489a:b0:45d:dc9b:e85f with SMTP id 5b1f17b1804b1-46e329aedecmr83219135e9.2.1759059247234;
        Sun, 28 Sep 2025 04:34:07 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996c03sm187074365e9.3.2025.09.28.04.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 04:34:06 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 1/2] staging: gpib: Fix sending clear and trigger events
Date: Sun, 28 Sep 2025 13:33:58 +0200
Message-ID: <20250928113359.6197-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928113359.6197-1-dpenkler@gmail.com>
References: <20250928113359.6197-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver was not sending device clear or trigger events when the
board entered the DCAS or DTAS state respectively in device mode.

DCAS is the Device Clear Active State which is entered on receiving a
selective device clear message (SDC) or universal device clear message
(DCL) from the controller in charge.

DTAS is the Device Trigger Active State which is entered on receiving
a group execute trigger (GET) message from the controller.

In order for an application, implementing a particular device, to
detect when one of these states is entered the driver needs to send
the appropriate event.

Send the appropriate gpib_event when DCAS or DTAS is set in the
reported status word. This sets the DCAS or DTAS bits in the board's
status word which can be monitored by the application.

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Tested-by: Dave Penkler <dpenkler@gmail.com>
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 4dec87d12687..ea44a766fda2 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -327,7 +327,10 @@ static void ni_usb_soft_update_status(struct gpib_board *board, unsigned int ni_
 	board->status &= ~clear_mask;
 	board->status &= ~ni_usb_ibsta_mask;
 	board->status |= ni_usb_ibsta & ni_usb_ibsta_mask;
-	// FIXME should generate events on DTAS and DCAS
+	if (ni_usb_ibsta & DCAS)
+		push_gpib_event(board, EVENT_DEV_CLR);
+	if (ni_usb_ibsta & DTAS)
+		push_gpib_event(board, EVENT_DEV_TRG);
 
 	spin_lock_irqsave(&board->spinlock, flags);
 /* remove set status bits from monitored set why ?***/
-- 
2.51.0


