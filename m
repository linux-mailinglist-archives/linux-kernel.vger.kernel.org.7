Return-Path: <linux-kernel+bounces-608255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD31A910E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 02:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A4919E0AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B503C1EB195;
	Thu, 17 Apr 2025 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="JI1XL3/f"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258E1DF725
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744850755; cv=none; b=JN1gg/75kaW54Ts6728ZV1fFHaFjGgQhAt5542iX5gcLRm0CY3Ygi9IiegDG9NreNdFHC492vnv6l42fMe3LJO9GerEf/U1RFY5Y4qeS2YEyi5PbKsgHcLT8qEBBYgnkVsr4xf6gc0/OruXzrOQyacFCVQfR4iiZ0lbjVhZhN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744850755; c=relaxed/simple;
	bh=J/2BjloWZckVQhuvMB1uvXaQEomsSVRjTMmjSOb71fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYmqk8JumklJarTc2o+lLD9PBD0J/+scq9ONgITCo9OT9r+6dN4YOK+CwOLUGvD6/rtvoQB+kL+mm105zEgDiZvv8pwnEr2bNZmwSSust/WSStO2J49r+jmr+7SKN9NDZJU0cj9uD8/Gs6LoEOa9O0uVFbPDAZ9UhGgnae+TPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=JI1XL3/f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22622ddcc35so3577035ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1744850753; x=1745455553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE4wYBK9Y5cNUsygtOoB0ARoJoNyVY3pBnlsFqh8m6U=;
        b=JI1XL3/fUCifAGOZLiwZ4pq6Zq4rmkpoXC0MUIEpvCwmEhDfDbLrLhU26F2wa1ewbu
         a9fGjhept1r0k4iAOoUdi7DEpDzZvJbb9/5JpnLNNskImo5NQn21hkT/cVtK0SFWHvDM
         8AKnquH1ZCcl0dU6CvWgY0Qr5t7kSKMSdKNB+FnvvIWJJvg3NmML47qqZoEO46sI3KWL
         3XokmkrsAMSqSeGAGJoP0Sl8ugvb6yBiS0oYly0Nukk0AGhHgLFs+/gi8irC5FzOROxc
         oIW3a4obl8AuMLrpXWgKJANNx8v+ZGul0lgjq+pP2m/pPYVxq60K7XxOFN/nwkY87z10
         BRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744850753; x=1745455553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE4wYBK9Y5cNUsygtOoB0ARoJoNyVY3pBnlsFqh8m6U=;
        b=XYwrMEee6Z+sMm5L5M6QlQGaeve5Y7Q4AZeeNk8ZkzApKDxPFGvZk8b1Q0WZUBP0gJ
         fUlcBrx2cU5j21iegxeqVqZEXHidrDMkk+vSWfHarqqLQ01TCOxTs1YjozB+tdGA+6vx
         B4HycsiDfPFpRTo02SnUrZgn3NU6xn9kvjFiioB/EuEsUAXIRFNbeF7TWECQwQaYZy5S
         pavhTKK0ADPTslNeK3ZAjRLhiQLSGTedZJ/3a2EE3HKURso1++XV+bk1ogKdnbDPlPVI
         X+ze/4ZCoPCq2JXjizf6hi1s5xkWp3WvdOqMLsJq2dF7KytC6ok82ZZ3UtUAorb5Ltw2
         lGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBA7jLXOtvpsI0a/XPeKam3zv7Pn/I+1Spbwk9s2oNIziunrAec3/fKjfz0LBaOFm7vCgh/GZxPZ79uCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynw/Y7RwHe1OZ8q1kxtgS/W97MxFPzu+aUIfsq/lStMVguhgX3
	gMhfLJCVXSaw8eVVKKccmCDcsepqs72bZOT4EDyBOotF+YXoT+gyr/gURmE0Wg==
X-Gm-Gg: ASbGncvX/ZmkF0J/+iAbaijCVWC2miFsQnFFhJypGAQ5ohMY+j2J7fz/mjObzKtDLXj
	5AJZFEc8776zsDlxLZFuU8VvO2clCv9sMk1JQi+b7z737+Uu55ENAWOVZLnLH1MxhkIrwtFl6cg
	v2zQy5SZ9WOAIL2ze3LCEaKf/WZspAeCzKqJA3qZ4pLnZRf4iW7cSzTZ10jyiz8koYwpw0t+5mP
	rrZ1mDhkGJ8wuxFFkeu8WYFkJ2YHEnUGOWeH8YCYMA47HLxvwzmg237jdtK+/+qZRqRlTmJs40b
	Yk5bNBmsZhhLOwqHBJ2jDHVBYCcnAzdHhLoTgyBoBkTnkK0k1zvW2lJ5Ulz3W7ZwDnGhLjj9IzU
	wI1ed2Q==
X-Google-Smtp-Source: AGHT+IGmzmZrkDFcQ2LokFGzzovBf64YFT1R45GKZ3897zaZpcrc8bUJ8p+qhlmw+686pWWDCMQedQ==
X-Received: by 2002:a17:902:d50e:b0:224:c76:5e57 with SMTP id d9443c01a7336-22c359734cemr60143045ad.39.1744850752887;
        Wed, 16 Apr 2025 17:45:52 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcc24csm20887985ad.183.2025.04.16.17.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:45:52 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: gregkh@linuxfoundation.org,
	dpenkler@gmail.com,
	dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v2 13/14] staging: gpib: lpvo_usb_gpib: u8 over uint8_t
Date: Thu, 17 Apr 2025 00:45:32 +0000
Message-ID: <20250417004533.86765-14-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417004533.86765-1-matchstick@neverthere.org>
References: <20250417004533.86765-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch.pl.

CHECK: Prefer kernel type 'u8' over 'uint8_t'
Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 494cfa21b938..19127ee906c2 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -706,7 +706,7 @@ static int usb_gpib_line_status(const struct gpib_board *board)
 
 /* parallel_poll */
 
-static int usb_gpib_parallel_poll(struct gpib_board *board, uint8_t *result)
+static int usb_gpib_parallel_poll(struct gpib_board *board, u8 *result)
 {
 	/*
 	 * request parallel poll asserting ATN | EOI;
@@ -999,7 +999,7 @@ static int usb_gpib_write(struct gpib_board *board,
 /* parallel_poll configure */
 
 static void usb_gpib_parallel_poll_configure(struct gpib_board *board,
-					     uint8_t configuration)
+					     u8 configuration)
 {
 }
 
@@ -1033,13 +1033,13 @@ static int usb_gpib_secondary_address(struct gpib_board *board,
 
 /* serial_poll_response */
 
-static void usb_gpib_serial_poll_response(struct gpib_board *board, uint8_t status)
+static void usb_gpib_serial_poll_response(struct gpib_board *board, u8 status)
 {
 }
 
 /* serial_poll_status */
 
-static uint8_t usb_gpib_serial_poll_status(struct gpib_board *board)
+static u8 usb_gpib_serial_poll_status(struct gpib_board *board)
 {
 	return 0;
 }
-- 
2.43.0


