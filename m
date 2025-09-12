Return-Path: <linux-kernel+bounces-813290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C36B5432C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B62A036A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9F2BCF75;
	Fri, 12 Sep 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ori/PK32"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201C298CA3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659682; cv=none; b=DvTZkxsle+yLymcDRXTf9xw8Jv/Be6aT8m/tEN8EwUmzz2encQF8GTnV3P8g0Ta1DWMDsJCDqs1s85QlohsfiTw93BaGenxc/d4RXhrQ+NsSvUuGJSx10kiNeQDWtasFFjaZBoRWPvogDlHrTRsv0Wr7Maf6xl5NeHrETUTAmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659682; c=relaxed/simple;
	bh=9TpjhbJBttEeS1KmCJosi4Hh395qIeJ+0k53azp1Q0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgIBPOMtNX4oCjIpWHjrhclx/AKcxEQhuiAdGfPLNTLlamkxP8TjxE/PGvWtcpGhLpUgXcIi+yENItkMgx7oOe7aFc9PrrLTKec09n55/iNwohTLt6qtXzkQLKCjDbhnYM15vs9i94juEZUEDeUhXQMTwjvfLg859QrA4SJTwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ori/PK32; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0787fdb137so225792566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757659679; x=1758264479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faD29vPc8TtJSIlMGbZZx8zq4usFD6uCUoteS6fd/xA=;
        b=Ori/PK32m0qecDiURF5UbohhVhLpLD7bJ5olQjAd28TQOk8JN5wH+NvtWXpKPs08Xb
         X/GYUk3CFtrX0H8WR//izJcZVc/Yt7ZYoiDNzVt+1QJoaOyePgjkLWYSp6HqDBkgQ9k+
         DJLr3JZTdqFTL/YIx3HjkQzNC4uzTl9nFuTwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659679; x=1758264479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faD29vPc8TtJSIlMGbZZx8zq4usFD6uCUoteS6fd/xA=;
        b=FQOKrNX8cyaqdfhBLi/0DgeJK+Pi2yjFa0IqAxqt02/H+FqKBpBLgfmNq90XFA7JcD
         4LrQJQ9X2GznwYtV4ZdYkozvYn7TDnqbHWLr1rGVYsvVGxOHb4L2QNaPTNypbwX8gS/d
         FceGnkHfsksO5IZCz2v/6iyMGoZ8xLoSxsx8XRVRLXBPPJephEyZmXmakyEME9CgRq8J
         /6WYSadgOjNHjyUlm2oQMfu2MIyQYPeB3TVx3mMJvS5U7L2e0U1fwIuK9yICP1jEd8Wa
         PgiDBy3Bfw8MU85HC8hXucjetjnTxOFd+y7ZDYRVGusUjNuFkXVbbTQI68D84BqFJPjA
         EwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDHnqb6qdBTKfU0X9j1mxV1dKOk9cmw4SBtAfR7ZGrFZdRS2hAzeom0CLV167DTTfHMNWbO22wwR5qGh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpJmmytoWUkSIsSqVnUTQGrfVqHDioLvKwV5iXP6nTK8l2ajD
	rhSty4zbjqi6p+tBA5Z0P82A9wAUG7hSdlU5Oa9FFd4IcN9Val7pd27xOlvthIE4Ew==
X-Gm-Gg: ASbGnct1EBzbStoY/uECYXUflKMw1K1f9onoW1XuDk8n3k6Z3v6j/QoER4s/lccNyeA
	CWZGwErpX/+coXrPOYL4VumxP+x8/uO6HtfnAPZ4+lAru6SOzCL2jBOgOluWbIFqSmJ5WM4C3Px
	juFVVE8HiQPJBX9fc1chQpOlX06J2ybqz7/hyeDF2UD9EySCWW7jEYY4sG+XqotpQ8vdsdJ5MkK
	W+QYzBDqOI9bMxEApKXZHXruJA63N1UUHzaRV0LImfbcpKWKVBF0iz6ZBmaVY9XtTGkjuvLWf+7
	oh8NUTgLKaWiSYInyKbR/W8NRgCtOnXTPfyRfzblaOio86mbPAZ+Dhu4DJD1ejq88uU5/QD/RVZ
	IRlnVlhv/XdxKWOACrjHM+8Sb/z9X48JrSVX0kzwFsn7+/+0BjQv2oyLescQT9WU65FcuckRSJW
	awv1yJHQSgvcfLbhqFBtgHglxMkA==
X-Google-Smtp-Source: AGHT+IFx9ydYE5CesosJBDmvUWYyToOaRt9RCUyztzIS5eLFbP6lDhD0TsJXKbVlqYDJqGhNfxzUgg==
X-Received: by 2002:a17:907:6d21:b0:b04:bfda:e457 with SMTP id a640c23a62f3a-b07c3a7b8d8mr152607566b.63.1757659679234;
        Thu, 11 Sep 2025 23:47:59 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128a1esm295465366b.29.2025.09.11.23.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:47:58 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v4 1/4] usb: typec: Add mode_control field to port property
Date: Fri, 12 Sep 2025 06:47:48 +0000
Message-ID: <20250912064751.1987850-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912064751.1987850-1-akuchynski@chromium.org>
References: <20250912064751.1987850-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new field in the port properties dictates whether the Platform Policy
Manager (PPM) allows the OS Policy Manager (OPM) to change the currently
active, negotiated alternate mode.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 9 ++++++---
 drivers/usb/typec/class.h | 1 +
 include/linux/usb/typec.h | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 67a533e35150..9f86605ce125 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -457,11 +457,13 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 					     struct attribute *attr, int n)
 {
 	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
+	struct typec_port *port = typec_altmode2port(adev);
 
 	if (attr == &dev_attr_active.attr)
-		if (!is_typec_port(adev->dev.parent) &&
-		    (!adev->ops || !adev->ops->activate))
-			return 0444;
+		if (!is_typec_port(adev->dev.parent)) {
+			if (!port->mode_control || !adev->ops || !adev->ops->activate)
+				return 0444;
+		}
 
 	return attr->mode;
 }
@@ -2681,6 +2683,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	}
 
 	port->pd = cap->pd;
+	port->mode_control = !cap->no_mode_control;
 
 	ret = device_add(&port->dev);
 	if (ret) {
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index db2fe96c48ff..2e89a83c2eb7 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -62,6 +62,7 @@ struct typec_port {
 	struct mutex			partner_link_lock;
 
 	enum typec_orientation		orientation;
+	bool				mode_control;
 	struct typec_switch		*sw;
 	struct typec_mux		*mux;
 	struct typec_retimer		*retimer;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 252af3f77039..8f51665d44ec 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -287,6 +287,7 @@ enum usb_pd_svdm_ver {
  * @prefer_role: Initial role preference (DRP ports).
  * @accessory: Supported Accessory Modes
  * @usb_capability: Supported USB Modes
+ * @no_mode_control: Ability to manage Alternate Modes
  * @fwnode: Optional fwnode of the port
  * @driver_data: Private pointer for driver specific info
  * @pd: Optional USB Power Delivery Support
@@ -304,6 +305,7 @@ struct typec_capability {
 	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
 	unsigned int		orientation_aware:1;
 	u8			usb_capability;
+	bool			no_mode_control;
 
 	struct fwnode_handle	*fwnode;
 	void			*driver_data;
-- 
2.51.0.384.g4c02a37b29-goog


