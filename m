Return-Path: <linux-kernel+bounces-813293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8701B54332
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5013E7BA996
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB02C0F9A;
	Fri, 12 Sep 2025 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJclE4RQ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273A2BF3E2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659689; cv=none; b=kE6k38rwGf6S1dGdMw3y+cXrA2ms2nb1eRbmkTunFzkpDwh4c2tJlkoLogOfms6gTz2uOucMzfS0aehnPd6/UhzXHF9c1zlWJoeAj7L5RyNkLlwlOppdeuBubIbthEdk6QD70oIURLm1pHREhd51svOmVYw8lV2AwL9YZlFfSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659689; c=relaxed/simple;
	bh=UT/bION2zNpmXwBRk6uc/9Eat1ApMNYCZlITkT1NplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evp9k8migXObK2Qp1en8KgRg1goUHm4iJDrxdv80VU5o4M6s5fyxNCJ+gLte10GVtRkxaLR1skDUSay71pM/a+SbgtiSJJsWNPaQwqzk3CwN83zR52KGeXBgDLBKas1ecPW/EH/w5wHiraOWH8Mgo8LgbpgXYvUtlc6SFCqdEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HJclE4RQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0787fdb137so225806366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757659687; x=1758264487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0Xtud0TdVZ+DWagzGFvFsKpmqRiYDQ9VDWpfm1enwI=;
        b=HJclE4RQxmxaCLVM93/M+u9jaZapowUif+CwHjITSKUfHZux+HseO5umqbQKPEuZTI
         vxepY5pl31etZNwc+jzTLepMZGT3wn1IpRfgwluWLWqvnOKEwEAq7o/WY9jLRF5d2vyC
         UtyhuEvpuKz1iVBlDc7URgNWq8MO1JNU+DFoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659687; x=1758264487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0Xtud0TdVZ+DWagzGFvFsKpmqRiYDQ9VDWpfm1enwI=;
        b=O25Umzvmr07X/D4lX6viSScbhMIFXIZvuzsmoEfMfEPADpojZDllV9Em7RH8mFzXkF
         ZUQuyQXmJs5Q5m6Ki6OwyqnTK2id+nN860R5/ouWoeplKb3rGF8A1YTZWZkJWzX3VQI0
         BSlWn266oqpbqcrgdecCZN+qu6Yj83FFa6lMGuH0rV1fLUz1UaaK3JmbJDI4eiQFhISH
         3QFv4v2BbBHn9Y4AKdD/hUJtr6yjaRPx2GwNqfumlbPWshhPzZqCq6mggqq8pFS47weD
         pubE+02I5WeBzIZaBOeYJvAdbJlPRCHYP5OPzLdaJ/hLIieJqR/Jud89/dxSCL6gOYqc
         HPFw==
X-Forwarded-Encrypted: i=1; AJvYcCVoHPRczd7Z2Ul+CG9VUMwMRy+oJItXNoHV9zcdL22B9w6OSmirUjO2tQ8/oUxeCEFh7QteC3xLYQsS2T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAopISJuHbjCi6KfxzuGGmX4k892dJJj6Dlym0bLgVvUvw7/o
	1cekf+BS9enxdQr//0u5uIAwe9fWaUYZU1CrDcHvVTBpV17X3aEQU/jY3J3Dl6NyHA==
X-Gm-Gg: ASbGncvnVhA+iWBv6aLjdn99BThL0fYU1NKpvuBQRLPbE3iuOp9Pk3sQTXPWJ3etYc5
	PKmkzo8QygEn0ICNv0/oPdw4VQXZ5c9X6nDHpnCmqlwHFQ2neJq53lAVsLzSWsibDx6RLkDY/2j
	BYcSwiKlFrXWkAeQLoWUt4VJGShIAW1SdEaO6Arq2Ub9up3gp8s65xSshYBJOwfd/doca5/EEY/
	y6KtwN8zzN0vSTdmWsIW6zAzma9dho+TaGwxhlf/2+11K9hGaGDVA9NoK67W1rzGBNAXs5qI1Q4
	I8t2ExrJi7kLSEl/ypcCdP79PLfz+cyUa4LAm+pW63ylsmJssy6igABgvT5aQp+9htr/iaUr9AL
	OIHLwr4+nTOgCqOpvqZIo3qhSAlojPH0bJUdcgRPJ/oG+RGzHwjzBkTSBDWkzZ+51IE95MJO4HR
	fmYjLpocmXVrWifIL5G7uCdr8OW8ky9nfYrPgP
X-Google-Smtp-Source: AGHT+IFJXwxQzhGtmgTg6Wyltw4l/rkxAEpJ7pN6ZY/j+zLPCSWzQ8LLU+wbeQfpDvkIAniXPe0jLQ==
X-Received: by 2002:a17:907:9623:b0:b04:708e:7348 with SMTP id a640c23a62f3a-b07c37e0e05mr181292666b.30.1757659686414;
        Thu, 11 Sep 2025 23:48:06 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128a1esm295465366b.29.2025.09.11.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:48:06 -0700 (PDT)
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
Subject: [PATCH v4 4/4] usb: typec: Expose alternate mode priority via sysfs
Date: Fri, 12 Sep 2025 06:47:51 +0000
Message-ID: <20250912064751.1987850-5-akuchynski@chromium.org>
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

This patch introduces a priority sysfs attribute to the USB Type-C
alternate mode port interface. This new attribute allows user-space to
configure the numeric priority of alternate modes managing their preferred
order of operation.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec | 11 ++++++
 drivers/usb/typec/class.c                   | 37 ++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 38e101c17a00..0f6e6adb71c4 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -162,6 +162,17 @@ Description:	Lists the supported USB Modes. The default USB mode that is used
 		- usb3 (USB 3.2)
 		- usb4 (USB4)
 
+		What:		/sys/class/typec/<port>/<alt-mode>/priority
+Date:		July 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:
+		Displays and allows setting the priority for a specific alternate mode.
+		The priority is an integer in the range 0-255. A lower numerical value
+		indicates a higher priority (0 is the highest).
+		If the new value is already in use by another mode, the priority of the
+		conflicting mode and any subsequent modes will be incremented until they
+		are all unique.
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
 
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9f86605ce125..6191f7def91c 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -19,6 +19,7 @@
 #include "bus.h"
 #include "class.h"
 #include "pd.h"
+#include "mode_selection.h"
 
 static DEFINE_IDA(typec_index_ida);
 
@@ -445,11 +446,34 @@ svid_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(svid);
 
+static ssize_t priority_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	u8 val;
+	int err = kstrtou8(buf, 10, &val);
+
+	if (!err)
+		err = typec_mode_set_priority(to_typec_altmode(dev), val);
+
+	if (!err)
+		return size;
+	return err;
+}
+
+static ssize_t priority_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", to_typec_altmode(dev)->priority);
+}
+static DEVICE_ATTR_RW(priority);
+
 static struct attribute *typec_altmode_attrs[] = {
 	&dev_attr_active.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_svid.attr,
 	&dev_attr_vdo.attr,
+	&dev_attr_priority.attr,
 	NULL
 };
 
@@ -459,11 +483,15 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
 	struct typec_port *port = typec_altmode2port(adev);
 
-	if (attr == &dev_attr_active.attr)
+	if (attr == &dev_attr_active.attr) {
 		if (!is_typec_port(adev->dev.parent)) {
 			if (!port->mode_control || !adev->ops || !adev->ops->activate)
 				return 0444;
 		}
+	} else if (attr == &dev_attr_priority.attr) {
+		if (!is_typec_port(adev->dev.parent) || !port->mode_control)
+			return 0;
+	}
 
 	return attr->mode;
 }
@@ -2471,6 +2499,7 @@ typec_port_register_altmode(struct typec_port *port,
 	struct typec_altmode *adev;
 	struct typec_mux *mux;
 	struct typec_retimer *retimer;
+	int ret;
 
 	mux = typec_mux_get(&port->dev);
 	if (IS_ERR(mux))
@@ -2489,6 +2518,12 @@ typec_port_register_altmode(struct typec_port *port,
 	} else {
 		to_altmode(adev)->mux = mux;
 		to_altmode(adev)->retimer = retimer;
+
+		ret = typec_mode_set_priority(adev, 0);
+		if (ret) {
+			typec_unregister_altmode(adev);
+			return ERR_PTR(ret);
+		}
 	}
 
 	return adev;
-- 
2.51.0.384.g4c02a37b29-goog


