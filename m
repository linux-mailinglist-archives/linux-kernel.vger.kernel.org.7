Return-Path: <linux-kernel+bounces-841974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77435BB8B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 086323467E1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1012472B1;
	Sat,  4 Oct 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUw4YA+b"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00823B604
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759564906; cv=none; b=t5I9HGf8xKcd+XC5lpWiV27Nu4EXpoOoNmrpQydS69QoNnZChPG7txa1CNp0ione24/8cSGt9aB8pBhrPWX2Rvym80XZLecgFhuE03eIIav9D/JCHio2FSOHHq26om6lU9Utqu23MZwm/YEdZqEPfGzm8Nh+bE6NXGxuJsGvr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759564906; c=relaxed/simple;
	bh=KjAy/lvyyRZ8zGb/5b2zhZlwN6xjwOXL9DkAX4lt92Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXf67oeXCsY+eNqnAh8latCGliaifoFQYsKGWw3BjTxKQuPyThiaqHvTnIequ6xmQg34Xt/D0l1Mf3nhDz1zj2fMFYph+mRND5O7yO3eUsBwGq1jSqXBjaEkekJlkVuxTlbtEF3vTfYAVtGKmXaAsEWwMknzACDuViTunKpzgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUw4YA+b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26e68904f0eso32339085ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759564904; x=1760169704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0HHNpXXNcTkL+nhU/xsbqvNsp+K5n0NS1hpW71SqOE=;
        b=HUw4YA+bRS2/NhLPQ8+5Pa3FK19M6/S95/ZGzMDPCT7rEZHTV26/VXq9zEwRbtTvJc
         avRLpWfudTGy6GzCt1QeY/IvRSENmwvXIPbZJg+hsBHChg2tP4zVqFjd1iSTTwyGqS0T
         IUyvpg95sEC9Q5uaZb0Z77onewjmOxFHs/ZTjr/HNFhDDJhPJavF5uWytPId/mEOkyXA
         QQcFt7ceJdneTYoa5xrbht0FOSsS5slD4SgJ76zrf41W7uEcWUcG+dtJB+5JgaTQp+MI
         4dG4xTDb0aV1jrzhux8pt8gosfYjlr5FNUv32TpSheyhTRmuOEbDjn/5xzK6k9Ma6qXI
         DfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759564904; x=1760169704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0HHNpXXNcTkL+nhU/xsbqvNsp+K5n0NS1hpW71SqOE=;
        b=V2a2byEOk/ujVJxbPdFsBMMurFBxtPQeiDmVSDjzCp/9sMntCpP+Sj6spQwlRM4VQX
         qvvla7d1h+KBoXmF+3qcOT2lLAPUsAX8KaGmCTHo1mt5Fn1kC3k0/pSCr8zhrjU9I9ji
         UNbxROHkO1fGEDPvhHj/eLt459mDwZ2WMNE92IgVeoIY8mg+FdhEV+gNFrQK8G+ENkcJ
         2tNeLwgvzsVE6gAGNabMGqQwoMBoq0NE8JSQVSnXBQrUvtac1xnJPr9yoZmKI1lapnhA
         IB2SLiIVtBVCJM3aDVDZLIRg+pDu3gM6S5DG13jKKiwC4+lQbeUunXYQa0JoTcS8WcIL
         IYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNWPXMQK6J14qJNG/PP+Xw6Vu6JKGk+qPv5KauQmCvhpp78mkv1lriMPRlFllNWiBpmyxuLEc8s9/SqDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Vxb0btSfxXF30QNYRyu2+WbyHg+E6KB9UbNO1ukNVFn5MKMY
	eWvOCz3ciFCWH3G+mw4OqeIuOCONuLae9Gohue72t6tl9gCpZD9cmjFf
X-Gm-Gg: ASbGnctOKrh/ANl/91iJdOVLBirBV+/msG232qGQpseox8c2GuBxx9vfkuDcF6m7/7k
	8nnVCP+9LPBtOfUSqOgdwpp/DuJ510B8/KPOgzot28JJRd0JjBYCys84G/9M/1dIZk+2WFIJ+Ap
	JT29u1NQ7sl7Nt1ZxZM5htvRrVNDKZB8aPbnFXtLSiDHpgloOL0S5hapvkXIOQ8U8SIIqB/FnKG
	r8psYCiNwuEtk7eKYfgLZRtVBU4+lqGDIVkpCsKJZV8+lzQWX29qLNBmPooiBG0NDERMr4LgaJj
	vPy++D/m4p+BbOEqAOXcQqqFvGo0XVVH6Uw0J5Asz/vlPH9VPHa4TbICPNuQHvKdGkqIpCzRk7z
	czlUR0MBoKCpBZhVxPLnpkAfI4b3wFm/hgyFPac0eUhHkfq8ahMYgOg3w0M97xQ==
X-Google-Smtp-Source: AGHT+IFXUEH4SoswhGENnhaBYTvA3J2cAJeazeigS8wwqtI9GXK/ebBTvKu4N8A/XRv+TrDANyOIIA==
X-Received: by 2002:a17:902:c94f:b0:269:9a71:dc4a with SMTP id d9443c01a7336-28e9a648547mr61572455ad.41.1759564904400;
        Sat, 04 Oct 2025 01:01:44 -0700 (PDT)
Received: from mentee25.. ([2405:201:d003:7033:7b72:2259:4f28:5ecc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701bf31sm10238056a91.19.2025.10.04.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 01:01:42 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH] usb: serial: fix: trainling statements `break` should be on next line
Date: Sat,  4 Oct 2025 13:31:23 +0530
Message-ID: <20251004080123.98285-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Run `checkpatch.pl` script on path `drivers/usb/serial/*`
Find ERROR: trailing statements should be on next line

Doesn't claim any functionality changes in any of the modified
file.

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 drivers/usb/serial/mct_u232.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 2bce8cc03aca..41b80a075b87 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -153,16 +153,17 @@ static int mct_u232_calculate_baud_rate(struct usb_serial *serial,
 		   divider = 115200/value;
 		   real baud = 115200/divider */
 		switch (value) {
-		case 300: break;
-		case 600: break;
-		case 1200: break;
-		case 2400: break;
-		case 4800: break;
-		case 9600: break;
-		case 19200: break;
-		case 38400: break;
-		case 57600: break;
-		case 115200: break;
+		case 300:
+		case 600:
+		case 1200:
+		case 2400:
+		case 4800:
+		case 9600:
+		case 19200:
+		case 38400:
+		case 57600:
+		case 115200:
+			break;
 		default:
 			value = 9600;
 			*result = 9600;
-- 
2.43.0


