Return-Path: <linux-kernel+bounces-884676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272EC30BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B9BD4EC99A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D222EBDFA;
	Tue,  4 Nov 2025 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urg5jwmK"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E62EACEE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255982; cv=none; b=a2LA2bF/W6q2knWX08sE6fGAepyy99MZZ1lQ7nzbOw+ctyw3cV7PtwE9v4FM3AFzsDzTEk5JJwpcO7yLaq1+CmEtsLjwZuR4KmpesDUHzZC4Td6TJXmXpfA0N7X+3wN1fYCRiVx2QsEVkdBKWXQtoqxLxBgVTZ7nU+oF9WtT62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255982; c=relaxed/simple;
	bh=W1/5a7VsUfRhct0i5NaSbgry/+x9qR6Zhl7syl2QDUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEKiB/e1WC97SxDmb5aSyhZ7Au1X1hfEkwwx2fGbZ4vJ0y4RwhYwLZbVHnzDX1R0mKRS9HdEUeNmmwLxj+oEBEQP7389tO5oTAy+zESD5Z7QZrx3oG0XwCGtoAXLPzReeP0O+6EvAbxNIzKbfse+GWNf/fMEvb9ukm9Ed+GUK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urg5jwmK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso872158966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255979; x=1762860779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Nxq+Z1fn/xWrOumJFi9/RSQVqz8cFPqXlsH8mXzKoU=;
        b=Urg5jwmK7UV5U0+Fwq9dAEOWPRIF9FKhSlSClkT0xmqk5dxZIuHkx0xCiD2huYIUDi
         pw411tgrmQzgxuxxLf0sgMzqP038QZlxuxLG2pXumkPfvqxrdH9QgvWcTDxzVkMnOZDm
         tgnR5s0UhXFL1jYQI6hOqoU60oeZNKYZcfyYVxSwUl/Gk5i+ccoanc6eH56RAWHye2bW
         AIV6F5oUCYiWzz4w/w7/io2JlQrzPK8TWONm6nlB64XmT8VsemuZbVT3Izgj1eV4833Y
         1+mtSbyb3zyNwLkcb1IHnfKNMLpEpqPSIqQo+PGYK5btASsfaoPFe81GoOsfemq04J+w
         JFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255979; x=1762860779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Nxq+Z1fn/xWrOumJFi9/RSQVqz8cFPqXlsH8mXzKoU=;
        b=D2j7Evz7YkSRz28Sy++OswkXZXCMRAxZ8Z1G7GDp78Cib8IQeoc2AgX3uVBvXb+3aT
         0sDXpQ7uOoPxB3+Di+Lnz3MZ9dwNwh2OqbHC+saJQgbvIIMKbYuTQQMXd4y7c11cNwH8
         xdcj1Wf3nYoHFZ5cRLFxVt4thwNztzx02LKTq0VeBEBGq42biNfyba5zTVABD8SccDtF
         9Iakmek+8sc3cJu0b/E2mAoQag/ubZI0QMh8lb7Ge/hJcrSpwbrA/JFAfMYkgmhW4vj4
         CHIzXoAKJUDusVDR6AYERgCxxU7SZCys0UjJ4ISaHAMym5AySiwOplRM45KHnlVkG0iz
         giLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAVbzJ6ikfjyQNLMcxYyteD/i/wcDSFwa5Yd1aEbuyoWZNwiJBDHzxaG0ZDuae3wyf8Y8/z3YW2D+7Uj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYr47gOzPgRW+ED+DKg/1oODkq7Ma0DcKZYZM1T8jtNLd4pdy
	03AD6YA7XtAj5/iAxxOqdP4P+p/0g9SR0+VPSNfwOpHcJtT7mOr+CHqe
X-Gm-Gg: ASbGncuGMZirmg9gTpgwr0crlSjlHH0zxhY8znZgOBfmiNVKr4nV83gEldHdv7/0iuQ
	1S17lSmJi6tyGt5Szkl0doJF+2W0cBrXbbXfHD1BEAvMikHwHOzh8XWDvPLWT46mFgcc9mZngpS
	21E4f2zKlm1h/ACXTaQTWXaBXyxAmdaK8hhijBaRZnXwh0r09oi5sZH86h99VrXMW+d8ICIZmyn
	HYKFp26oVdWSlu1OUilCl3YCAg7CfQ74ysl4fT7EwhMKVOGQRXI+mabvjWxMhH7iyz19x9hG06x
	ZlKcB0hkPk3ZotfGYuZuX3CSrSt9aUsNREksqt/cuHRiPb43bIO0UV9LgGbljhiP9gZvUIyROtg
	jkri+mpJzgPNC7xKvnkPEa9A48MkFpvf1YmTYrAbcD4aoawYeBu4zUUWjOyaMywaTmJgtFvtJe8
	CN6OGtmhcmM9ra6d5vxLtK5XOhV5pWrrGj+aifg5iGHXIh5Uh6zjnuS6Bkg1wkmOaE9m7krB71
X-Google-Smtp-Source: AGHT+IHEMSASSTohnLG9wMInMyaJfMwowF7cYVsEpX3e0SDI7y3LeNeOnjHYdUJzMywCwp6kp4EraQ==
X-Received: by 2002:a17:907:9602:b0:b72:588:2976 with SMTP id a640c23a62f3a-b72058829famr341889366b.60.1762255978638;
        Tue, 04 Nov 2025 03:32:58 -0800 (PST)
Received: from jale-pg.. ([2a02:2a40:17ee:2900:8627:17a2:2166:4084])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72404470e9sm182469766b.70.2025.11.04.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:32:58 -0800 (PST)
From: Jakub Lecki <lec.jakub@gmail.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Lecki <lec.jakub@gmail.com>
Subject: [PATCH 3/3] usbip: Limit maximum number of virtual host controllers to 31.
Date: Tue,  4 Nov 2025 12:32:48 +0100
Message-ID: <20251104113248.223594-4-lec.jakub@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104113248.223594-1-lec.jakub@gmail.com>
References: <20251104113248.223594-1-lec.jakub@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading the vhci-hcd module with number of virtual host controllers
configured to max value of 128, the module initialization fails due to
insufficient number of available IDs for USB busses.

Each virtual host controller registers two usb hubs (USB2.0 & USB3.0) to
the usb core, each with a unique bus number. The number of USB busses is
limited by ID allocation range [1 .. USB_MAXBUS - 1] (defined in
usb_register_bus()). Therefore, VHCI_MAX_NR_HCS must not be greater than
(USB_MAXBUS - 1) / 2 = 31.

In real world scenarios the maximum number of virtual host controllers
possible to create may be even lower as other USB host controllers may
be registered. In this case, the module initialization failure is
correct as the number of virtual host controllers must be adjusted by
a user to a given use-case.

Signed-off-by: Jakub Lecki <lec.jakub@gmail.com>
---
 drivers/usb/usbip/vhci.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
index 2772d923a8cb..3b0ea4038e51 100644
--- a/drivers/usb/usbip/vhci.h
+++ b/drivers/usb/usbip/vhci.h
@@ -76,8 +76,17 @@ enum hub_speed {
 #define VHCI_DEFAULT_HC_PORTS 8
 #define VHCI_MAX_HC_PORTS USB_SS_MAXPORTS
 
+/*
+ * Number of supported virtual host controllers. Value has upperbound of
+ * maximum possible usb busses.
+ * It is limited by a bus ID allocation in [1 .. USB_MAXBUS - 1] range,
+ * resulting in maximum of USB_MAXBUS - 1 usb busses allocated.
+ * Additionally, each virtual host controller registers 2 usb hubs (USB2.0
+ * & USB3.0), therefore maximum number of virtual host controllers is:
+ * (USB_MAXBUS - 1) / 2
+ */
 #define VHCI_DEFAULT_NR_HCS 1
-#define VHCI_MAX_NR_HCS 128
+#define VHCI_MAX_NR_HCS 31
 
 #define MAX_STATUS_NAME 16
 
-- 
2.43.0


