Return-Path: <linux-kernel+bounces-894416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF35C4A40F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFF7189086D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11E32B9A4;
	Tue, 11 Nov 2025 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUCYvg0r"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAEC305E3A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823153; cv=none; b=QVAQxCSovTA7iLwOq7GNmC1u++iZ5HiwnQC6XWx2cCerywE79+oJkHAZh2tArewgSOB1wNX3gd8qiomD8fyVkfN2xLd4WCx5N2KxwG0LoMRM+qFki2iH5cnXqcgY0d8VeC3hV7YscCU92v3GIfTKGzdbvwRtnTWQBIJEBWT0JHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823153; c=relaxed/simple;
	bh=zoaJWkh6BFdghSAUNArPV7iTe5Ektktbb+pOIIxP8zo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJGOLaKV+WwrJbLt730fFDlA+XK6dFvRoDnVkLx8n4DXKqhJQXOmspyihMat9CLTzirOqXvRZHzO9A8xNmtUHTkLuXUEjq1xIcX9JG2wKYkFZgI9NEFM1m9euyZCYalVj8YoVodLMIXsOODri9to2lFxS0mllP6YNU1gZib3jRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUCYvg0r; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so4360444b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762823150; x=1763427950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9OzIqPmPfxJecOLxd5sV7dij2CavVRjVBl1sDZ2zms=;
        b=MUCYvg0rqZbTG5hxIaACJjH90uY1h0bT/91eFbEfkPydq3IGGejvEVX/O9tkLdCQR9
         pDNwszsuqDV5uPFJhmZYiEWRMUjfBrc61za322SiTiyN+cXn4A/g9eTb2zBy8UuVOiWK
         BjmHX6KUGVO4KCp7n8q45b6H55+EU9MfPmySCkcSyHYjxj2RRljzgJD+Lv3IWyc0mnWf
         hXBgdW/jkaUaGD0njx0nho4OOGsBu2Y4Yvn/iH7QNDSs7iKBnbnF207kk7fPqD6XvPm6
         cw2ePJkz5cKxoNhcGpIPP04L720ufhhbrGe51r8NSj5wUwf8z0kduoo5QUewh7u92btm
         g6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762823150; x=1763427950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9OzIqPmPfxJecOLxd5sV7dij2CavVRjVBl1sDZ2zms=;
        b=Qhr4E2tr9zNlW3G0krlwDAPASPWu+ZueO/uyHMQcQp0rDkt1EWbcHha4F7ukuycWe6
         rj3iz/uTfby6ro5Px8TqjbK0zvyAzDZfpu4mYI9gu9T0TH/jut5xKDcIKbUdeDIhqIjO
         G/R1MkjqGQmCAIF4VNRqZJ5lJdDSgBurUII5frRoxTl+0H4gdEFI1Llg9vkkcH033OJs
         Zp3tk5zvx/kFrDExIUu+vuP6L7d2+b3VbUs02qDnLp1NpWBNG2YanXvZa9OwAiRc6p21
         t/XzAQtjHhM4UQ4oTuFuQbB4pVOfTixSlfLjA10OPCwgb73w3aj0dEieM7J4bNYS61b3
         cbrA==
X-Forwarded-Encrypted: i=1; AJvYcCXr6sff1N0OJKS+cxGEwZIDYymZwhxcufnYAcw82kc8Epie1OVAsGr2++iYOxcuWJLK848of2qk3WAu6GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuR1sfLauSmnTs7d9XMNLZKESRYCZ3Taa7GIqUAFyn8MPl9n28
	cTuFFOjmRhndcO5RVOIzmpAnB8MPXkheU0JXrzgCzOP8BEC4XVO6/Nsr
X-Gm-Gg: ASbGnctcB171Z0lTQVOXSp5Xz1TmKeU0DELTziax18K5vnRTSY4+O2jk3RDviODplSP
	lwi/5F4TA/JlBosg+08oKM44uOXwIAL6Iox0Wph3BxGw+yzwh0B2qYIPik5fqlvYO80+aRllAe1
	cS6VjT7qkArdp0fZCCHPQwmomifo4pThxyk9Pyd5Rpf0HundVPkjGsq5IU5V5wEMlYjOxiYByTZ
	6ItVsXMUmet5Vw2I/UhwefZXXR+6Ev6OZhROG+IeSu4HYWVMxyt6DJHyTrd4OyJDgqVxEk28eGO
	jB0/aTk2fcpmVtDl2jokBfW/GVkSuQebGrZ7fgRHZ1GlT+XTeYnjpD4keoc6mN4FupLz8UqlyKW
	/o2FhQ1lDuBeWJLUijrl4B3+IA8e6VPU7sUss/cEeKjkx38rYJ6WEWK63LMnk2JD7Qx67mWetVm
	0zHxViHIKVNucOABYUfcPt7fuUCILGLVmTrcFNA3YE
X-Google-Smtp-Source: AGHT+IGUCQ7upwGzK2A9984x0NsgNPPuWNkmmYitgWgDEE9wtyrDQw0fgYga1Yd4jxR10qY4fICcTw==
X-Received: by 2002:a05:6a20:7fa7:b0:342:352c:77e5 with SMTP id adf61e73a8af0-353a4287c28mr13280750637.54.1762823150437;
        Mon, 10 Nov 2025 17:05:50 -0800 (PST)
Received: from localhost (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c801d1sm10500464a12.7.2025.11.10.17.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:05:49 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb: typec: ucsi: yoga_c630: Remove redundant duplicate altmode handling
Date: Tue, 11 Nov 2025 09:05:41 +0800
Message-ID: <20251111010541.145421-3-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111010541.145421-1-acelan.kao@canonical.com>
References: <20251111010541.145421-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e0c48e42d818 ("usb: typec: ucsi: yoga-c630: remove
duplicate AltModes").

The yoga_c630 driver previously implemented its own duplicate altmode
detection in yoga_c630_ucsi_update_altmodes() to work around buggy EC
firmware that returns duplicate AltModes instead of empty ones.

With the introduction of the common ucsi_altmode_is_duplicate() helper
in both the standard and nvidia registration paths, duplicate detection
is now handled automatically in the core UCSI code. This makes the
yoga_c630-specific implementation added in e0c48e42d818 redundant.

Remove yoga_c630_ucsi_update_altmodes() and its callback to eliminate
code duplication and simplify the driver. Note that this causes the
driver to switch back from the nvidia registration path to the standard
path, which is the original behavior before e0c48e42d818. Both paths
now include duplicate detection, ensuring the firmware bug is still
properly handled.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index 0187c1c4b21a..dae2f41f8d82 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -137,28 +137,6 @@ static int yoga_c630_ucsi_sync_control(struct ucsi *ucsi,
 	return ret;
 }
 
-static bool yoga_c630_ucsi_update_altmodes(struct ucsi *ucsi,
-					   u8 recipient,
-					   struct ucsi_altmode *orig,
-					   struct ucsi_altmode *updated)
-{
-	int i;
-
-	if (orig[0].svid == 0 || recipient != UCSI_RECIPIENT_SOP)
-		return false;
-
-	/* EC is nice and repeats altmodes again and again. Ignore copies. */
-	for (i = 1; i < UCSI_MAX_ALTMODES; i++) {
-		if (orig[i].svid == orig[0].svid) {
-			dev_dbg(ucsi->dev, "Found duplicate altmodes, starting from %d\n", i);
-			memset(&orig[i], 0, (UCSI_MAX_ALTMODES - i) * sizeof(*orig));
-			break;
-		}
-	}
-
-	return false;
-}
-
 static void yoga_c630_ucsi_update_connector(struct ucsi_connector *con)
 {
 	if (con->num == 1)
@@ -172,7 +150,6 @@ static const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read_message_in = yoga_c630_ucsi_read_message_in,
 	.sync_control = yoga_c630_ucsi_sync_control,
 	.async_control = yoga_c630_ucsi_async_control,
-	.update_altmodes = yoga_c630_ucsi_update_altmodes,
 	.update_connector = yoga_c630_ucsi_update_connector,
 };
 
-- 
2.43.0


