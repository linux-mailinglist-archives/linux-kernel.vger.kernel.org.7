Return-Path: <linux-kernel+bounces-858005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E9CBE8871
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6814EAB37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1C32ABD0;
	Fri, 17 Oct 2025 12:13:07 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4C2E5B2A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703186; cv=none; b=XbUB9CX0PFbvazJ1lILC75RffWNd8e2mzGigD5Vb5yibqlYdeAbXZM65hctP+GZt4bNzJx8/UJebuHl0QEu/SzGgru3PfP9LAdI/gndhS/Z7CVR2FgTVb2BKLNBspbxEW70NhT28vPbZLAnkJU7+dOibVRrpjBcu6Cv7lLqsb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703186; c=relaxed/simple;
	bh=8mg+fNbsu+KeGEu7BuN5o0N6+N/QSVNQ6UDJqE5kDiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=af1D96jU7ypIXxrQNNIC5y3fMOpGhRUaQNJkaPu2okyTg96QQQ+DQxYGgUSZENC92zwwc1Ys33M64NlgVxeWFMvV0jXrkhgvylhDUs0nJE3GtpnOKyOGQ3ZpAuhmyV/8JkGn4zaijIT8B7D5feQu9fGbTFm6q0svuJGuMB8pEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b609a32a9b6so1083611a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760703183; x=1761307983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbvlmTTew8suBTsuq02Ewef+SzGUQT2VDP01I1YDZS4=;
        b=W0RCwHCRWR6GvXFaztmK1lUtKqOsdb3/T0bnI4EQrYlxalA0tK+zHekAgymJejhh/m
         /zWv7/FFiP6LhwF84dLRJwEBRQHdwptTCVRN6r15LupaOr4xJxUkHUp7/AZ/Qetl8I6k
         X7SCQbyu2T2QT7DmDNBPh/unmbJTBnvez0NP2J4THj1kjjwxOHW7geUJX+rrlzGM+2gI
         wlDkK03GtfvDq9D2v6zr3ih4i2YL4stnC17Yh+psujODwOAKlt8fKpj9h21i9CU+fIL0
         FPvalYUl6Bx13Upf5X6wRvOJ+nJ1uqUmZr58exYaDfXp/XkdjRCCOM7u64OmnthxXYez
         OQPw==
X-Forwarded-Encrypted: i=1; AJvYcCXlJdyABNsNbcJlzJih76tWai20yLeX8HblfbQDBrirgKHgovnbjOpySsNro2npgBVJBwhSjeGNfmMtbTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CxXxguT8IrPwBGjp6hRdTpYrJHJV4IGWlWNltAvQvLmFl5Fg
	PsLxDiqz/ZKPWFxE3+SMri/16Z4eRvjCrKkKpXkjAP6FOPcKd0hyjH2y
X-Gm-Gg: ASbGncu8VqJcYnw3htxtUkgFH01qaJedIn2xB4QS7Rc0qvnKfTejDzYCytFmhOuAuC3
	AV4jWKsXPqNRkuces045lv2UuwIg3Cclhx3xjF2Js379MJDx3bBZbH2QkaoxrRZuSQgxW59yuN+
	4RjWtrJTv1/ngdEX3+5YlX0BcI+Wc1ZnY4x3zups+Yytiwr9aA/zXovn8t5gUulBbZkyNs1q8Io
	41Qv6dbWg5P9rkDKLx8y/nNPVWZDSPG5Cx1VBgbBb7Fso9XA7h4g0PGTF4i5wggpgFwXmIz5lWE
	0aO5m7E061wsIQIXGBSzqH4HOoRp/QAdyxUNwKEG5ARNfGp3Lpn/Ke4axXkKHH3bA6gMLfST7HV
	8vZDfKUK8vPkf58v+Ow9W6J7mSU0vV+0017ghB0+VoDPxyk/59ololeIOwVyMgvO43mbZ7W3bOy
	I5CVEaHE8VKQoeQymWxUcup9RgJODFP02TU8Dtkw==
X-Google-Smtp-Source: AGHT+IHfpLf94DuGp8KVk2x2Wh18b+nC6KvwnJiN04mhJAqBLprpNtm8s3d7xOrQlj13RcC9M3vsrw==
X-Received: by 2002:a17:902:f552:b0:269:ae5a:e32b with SMTP id d9443c01a7336-290c9ca741bmr45567155ad.13.1760703182994;
        Fri, 17 Oct 2025 05:13:02 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2923d9dc3dcsm281815ad.28.2025.10.17.05.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:13:02 -0700 (PDT)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v1] usb: xhci: limit run_graceperiod for only usb 3.0 devices
Date: Fri, 17 Oct 2025 20:12:54 +0800
Message-Id: <20251017121254.2887283-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_graceperiod blocks usb 2.0 devices from auto suspending after
xhci_start for 500ms.

Log shows:
[   13.387170] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
[   13.387177] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   13.387182] hub_suspend:3903: hub 7-0:1.0: hub_suspend
[   13.387188] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
[   13.387191] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event
[   13.387193] hcd_bus_resume:2303: usb usb7: usb auto-resume
[   13.387296] hub_event:5779: hub 3-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   13.393343] handle_port_status:2034: xhci-hcd PNP0D10:02: handle_port_status: starting usb5 port polling.
[   13.393353] xhci_hub_control:1271: xhci-hcd PNP0D10:02: Get port status 5-1 read: 0x206e1, return 0x10101
[   13.400047] hub_suspend:3903: hub 3-0:1.0: hub_suspend
[   13.403077] hub_resume:3948: hub 7-0:1.0: hub_resume
[   13.403080] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
[   13.403085] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   13.403087] hub_suspend:3903: hub 7-0:1.0: hub_suspend
[   13.403090] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
[   13.403093] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event
[   13.403095] hcd_bus_resume:2303: usb usb7: usb auto-resume
[   13.405002] handle_port_status:1913: xhci-hcd PNP0D10:04: Port change event, 9-1, id 1, portsc: 0x6e1
[   13.405016] hub_activate:1169: usb usb5-port1: status 0101 change 0001
[   13.405026] xhci_clear_port_change_bit:658: xhci-hcd PNP0D10:02: clear port1 connect change, portsc: 0x6e1
[   13.413275] hcd_bus_suspend:2250: usb usb3: bus auto-suspend, wakeup 1
[   13.419081] hub_resume:3948: hub 7-0:1.0: hub_resume
[   13.419086] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
[   13.419095] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   13.419100] hub_suspend:3903: hub 7-0:1.0: hub_suspend
[   13.419106] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
[   13.419110] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event
[   13.419112] hcd_bus_resume:2303: usb usb7: usb auto-resume
[   13.420455] handle_port_status:2034: xhci-hcd PNP0D10:04: handle_port_status: starting usb9 port polling.
[   13.420493] handle_port_status:1913: xhci-hcd PNP0D10:05: Port change event, 10-1, id 1, portsc: 0x6e1
[   13.425332] hcd_bus_suspend:2279: usb usb3: suspend raced with wakeup event
[   13.431931] handle_port_status:2034: xhci-hcd PNP0D10:05: handle_port_status: starting usb10 port polling.
[   13.435080] hub_resume:3948: hub 7-0:1.0: hub_resume
[   13.435084] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
[   13.435092] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   13.435096] hub_suspend:3903: hub 7-0:1.0: hub_suspend
[   13.435102] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
[   13.435106] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event

usb7 and other usb 2.0 root hub were rapidly toggling between suspend
and resume states. More, "suspend raced with wakeup event" confuses people.

So, limit run_graceperiod for only usb 3.0 devices

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index b3a59ce1b3f4..5e1442e91743 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1671,7 +1671,7 @@ int xhci_hub_status_data(struct usb_hcd *hcd, char *buf)
 	 * SS devices are only visible to roothub after link training completes.
 	 * Keep polling roothubs for a grace period after xHC start
 	 */
-	if (xhci->run_graceperiod) {
+	if (hcd->speed >= HCD_USB3 && xhci->run_graceperiod) {
 		if (time_before(jiffies, xhci->run_graceperiod))
 			status = 1;
 		else
-- 
2.25.1


