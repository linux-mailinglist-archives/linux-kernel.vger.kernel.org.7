Return-Path: <linux-kernel+bounces-826010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE158B8D54A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ACF1678E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F308221F26;
	Sun, 21 Sep 2025 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QecKSyIB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618648528E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758432687; cv=none; b=mjj84xxhNE0X1JImDQfreFh2O68+N4k1mXjvB5l1ntl9eek5aTVdotA/lhu5m1vgaIXFH60EQvISiOAgDyRG0ZuVGDwPeZt+WFwVVJrpiTQlL9iDSdot4CFM/rYeLzfWf5TB3WRDrukkxIqQDeMJKY+GFCLKylPSxRa6ZtgTVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758432687; c=relaxed/simple;
	bh=HleFLPeUvaEcqn/0PXc1U+sGzWdcOrBF4wDM+LDGl6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoGHnqTwjmriNvtoJJAP3OLnqSTjZX7caxfpxR1RgT/bjAvp7kEI3JO0Hc5KtS3CKFY6cqO+PL88iYitwYNSF+1lLRP53Zxy+WPZDSHQMjMdmnp7HbRXNmHOXZeILNP7NGh5E9MjcRlqEvxeB2fahHpwkFJyc2Lmoau4JefZ06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QecKSyIB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269af38418aso32822585ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758432686; x=1759037486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bXUQHTmnBfGtfX7iEITnx6oxhdVdrA+nHLfzwZOPN4=;
        b=QecKSyIBiOiLvPH7RAEHSkjiRDTkiywlKnNs/l7o6crV/rrYAdXsZFvS9sFnPiCpIm
         v/Z45fCHnMtI3+h5Gpg/4KPrdxKLMJkoqdQCvGxFY1BDxfg19E6EYPLRgPVhMRmJ3s83
         AheTh9RSD3L4cT+x7rdv3f1ZtzqJ0Cs9eTLJSHz5TqBQoiFS4oAmLjp0ln0xFi2Sc9yL
         ne6SDTAyHD2A2jjUTdNmEL6CEHom4t8t/J5jvRw1xMgms4VHErpfF0AgYgEdASdYPGnE
         RHruecvUXdyOv+CdXfPfDZHYWOND9XORB+BPDFXJiYO+bHVYsXcZUIN833fVarmnCjfG
         nmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758432686; x=1759037486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bXUQHTmnBfGtfX7iEITnx6oxhdVdrA+nHLfzwZOPN4=;
        b=TbAQytpfD/0GAwC9Y7qFYDFb5goyFRsn00cQyGXtJMZLD+Sb98zeSw1INkvbWQb3xb
         /Iq7Tk2Z8nrRZH0ufJwxkwzEO8WBhQh7FKWQXvYeB6ehZh1pG5JvBUXbb0Kw2WpHcOf3
         iRGkBVP75+4s4p1FnWGtHpW5qAPFmodD4AWou7ekz1xNtg1GFbIbHcYUlmdnZ4Zf+UeY
         xGWjkkFVgsOBdRHhdf5cTfEjEwFEaEmaPGFLmMOQ55rBFpAMMXJDAamv9P4DmjJvZ/uA
         bYXYhQiKUB337E4pMZF7b5pRAmu6r0ewNOj405wc3Z1SpIHhXuUibJOgGuPvTONa6KJQ
         uR0w==
X-Forwarded-Encrypted: i=1; AJvYcCXMRYEqImTgNSkZYZguQHnkl5svdu944cLdtGwKmZeb9/ImhTYNAcTHJ+0YPEqKi9Cb4mNN95VVXHhIxxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYWsuFSOEiimv6iP+u+pfmi89bPYlVeemOwVkgTT0gafT+75D
	+nSGh7Pbx6JNxX2vBxMmLq3dVWv2s/hnEXgOk0JqygbMWGgUmRKj9HGw
X-Gm-Gg: ASbGnctLpSsIMEVXTX3PFsCaoHT+fB8xCo4PCLg8yuoVpXfACF472Efz/QXz67Gju7L
	RGi1B/gKYgzeRqLuz46Z2qgAvAP+4NzNWxd+WlO4I3DV4U3P6jS8Z7bghT3IjrojABrE24uqHhj
	MRP5AzfjCUTOKG50TqoROJqBroYMiWWmsEGE+zshSQvq3DywaSGUH6r/RGG/sjoKSk762fRfjP+
	JuCpPAwHkikaLyxW/DPs0Or8L/Zs1HfgtejWlQgItw2L/3IvuzjRXzGDKWpysQmvgLVxaThFwqd
	p2qQbsKhnAopFy1ixtH0HXn2d/Ixh+b/mM07912NZ2xXnuYXuH4+WxPxBloFmySvsLIsC9U5XtZ
	AfpLmugJ3Ko8A1HTCjtUGfhSYLTZ4fx8/jocUFFew3LYxls0t0j1AsasT9FA=
X-Google-Smtp-Source: AGHT+IEpkQw1QkNUhuiZ+x3z/qRYz/267S9IR2W58CWz9qesSZGnwbL5E9ovayRrnpFVMvIiko29WQ==
X-Received: by 2002:a17:902:d483:b0:269:805c:9447 with SMTP id d9443c01a7336-269ba3ec74bmr102451495ad.4.1758432685731;
        Sat, 20 Sep 2025 22:31:25 -0700 (PDT)
Received: from orion (FL1-125-194-6-184.tky.mesh.ad.jp. [125.194.6.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df630sm97225825ad.81.2025.09.20.22.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 22:31:24 -0700 (PDT)
From: Masami Ichikawa <masami256@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: minbell.kim@samsung.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Ichikawa <masami256@gmail.com>
Subject: [PATCH v2] HID: hid-ntrig: Prevent memory leak in ntrig_report_version()
Date: Sun, 21 Sep 2025 14:31:02 +0900
Message-ID: <20250921053102.150182-1-masami256@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a scope-based cleanup helper for the buffer allocated with kmalloc()
in ntrig_report_version() to simplify the cleanup logic and prevent
memory leaks.

Fixes: 185c926283da ("HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()")
Signed-off-by: Masami Ichikawa <masami256@gmail.com>
---
Changes from v1:
- Rewrite patch title
- Use scope-based cleanup to drop goto-based error path
---
 drivers/hid/hid-ntrig.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 0f76e241e0af..a7f10c45f62b 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -142,13 +142,13 @@ static void ntrig_report_version(struct hid_device *hdev)
 	int ret;
 	char buf[20];
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
-	unsigned char *data = kmalloc(8, GFP_KERNEL);
+	unsigned char *data __free(kfree) = kmalloc(8, GFP_KERNEL);
 
 	if (!hid_is_usb(hdev))
 		return;
 
 	if (!data)
-		goto err_free;
+		return;
 
 	ret = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
 			      USB_REQ_CLEAR_FEATURE,
@@ -163,9 +163,6 @@ static void ntrig_report_version(struct hid_device *hdev)
 		hid_info(hdev, "Firmware version: %s (%02x%02x %02x%02x)\n",
 			 buf, data[2], data[3], data[4], data[5]);
 	}
-
-err_free:
-	kfree(data);
 }
 
 static ssize_t show_phys_width(struct device *dev,
-- 
2.51.0


