Return-Path: <linux-kernel+bounces-769477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB5FB26F31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D875E3659
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9AD29D268;
	Thu, 14 Aug 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B04Rs5wP"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09E2309B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197106; cv=none; b=NhbpSHplwwn/aIaT8jKuUsMa6I8JoWF+JheMvPT3kLvRdg55ulFOFnbn8KTOa2M++QMQA+/fGx7PtyWaim7hN/eSQdZhLm8ohEypWXTKybR/GGHPqKJubBY5NJgZ386dv+i12RD9JZZnHjuVF5cLu6BY6FZzdEnQRNlyHA9COa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197106; c=relaxed/simple;
	bh=eUBNjC8QE0qeN7YbjDptuSSINLe1oW6vNYbL6Ks8GS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyHfswV/OLDl0CsNnXpmT84MlFIQOrA1g0QZYinFEa1csuZWVeYAf2WNimqQnme/j2vim2NxmgzwB+QtUK9T/Xijxuis7iOfd8FUHD5E2H+hHTdzb18v95G3kyu3f9p4BUed7SC969tyU+YcS/9jr2Hi2kzaoA+USAItirRZXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B04Rs5wP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb732eee6so232548766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755197102; x=1755801902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR3Vo6gytGVX7qnZsp8KSoWCmMGj6HFPr8g7tZMKrMk=;
        b=B04Rs5wP3dNwf/b1PwQScMAhfPZPaNuj9yMFcvLsGh5OndXA5aqRTEPZf1kuywUeK8
         6c/NKxTza9fa6utr+TQ/AdjCyrSw2c8oS5oj3ZDF906JvNvgoRsl14gJjy+vLLrUOnpA
         iXKzg05reVn8hMyIGlG5sMp7Qqog7HogB1Qx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197102; x=1755801902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RR3Vo6gytGVX7qnZsp8KSoWCmMGj6HFPr8g7tZMKrMk=;
        b=NIIWwLgiIKhhBSIEAMdoKumEdbCopljRzjDfkJQgBGO+3uX2MRKEL70Toxlz0lwByv
         hHPwvuC1HBq0D8G11YbWCUlai+uKwonMQi9lPhL39litS+Vz0BpBZazzeYCVitRqQqW8
         4QeYnL7rQ6JtmYz1MM2NELz91t5QoEHBELk5UGhC7V7UJMIaAodrE88EMoqjYlsuq7Zu
         1ecpXH1OzCjU81zrVcl5d8TjY303DKmvwO8tifjW+OR7vkINi8T/7zvVdcKIc2cJpMlu
         4g8U+7z3Rfq/4kHzR7b8t0Ez29CrVvfvwEHkEfTPEAJJqlqurr6lAj6nqEsjgLZu2eFh
         RH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVQc0uFXgaVf0MSflrCzEA/CRJ5Pvp4ebIZ9w9Xii7/RVJhoIcXIXslBhYleKJdv5+gWgfqLW7Ccbs5HIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThxxZ9nzjp1omsKq9Ja70i+Zp5AoYd9ciQjTmZ3fCFyylYrDX
	neCECQ1zYNQjzzf05M16eUQ5JVRLldxkw3kIkagZSDgOkcnXBU1i8pFScIX02GrTxA==
X-Gm-Gg: ASbGncs/7nDyqLeFIbvOR1e+KiPZnRcPUgqdBxZXFvTEA8ipW9ovmnL8PrdaWuWitOS
	lQCOHY8OcRFzoLZjC5lRGq6o8jwz6mN4raABLmZ2BNRBuu5/lHrCIS+ECAcFIZwBSpWH7AJSXYD
	ETxFBdc36HMRMcIlfR1Pg5Q9yrjtloH1HydvTjIeKMAPUXjxXQ9KI93egCynSF0SaINeerovo7D
	AmJeAgJ/M6H0aBT/Q1/WPFb61ypW3zBbF5ke2IzewjKVJOq+YurB6rCnQznhJsCJP860YvJ3DhX
	rIgPP9qxe3WjEApmtjEipzxoJiwQqgh87nJXSrTiTqa3qkAR9zmD8NgO/8SpMbUpbq92ATfkqMm
	T7bHrFtW298QDSE8RNb9ubhMKxVcu1XD7ISCf+KnNYAS/lt5TOUH5ZzJBkXW2VlDhRFkKuTCF/9
	VaeD1XiiVttQ42
X-Google-Smtp-Source: AGHT+IF+BYCHuUTwdpdjVvLvUjz9fJvW2obdjNL293EGpVlweKHP0tzpD6mVfCW4djoRh1UoGciBdQ==
X-Received: by 2002:a17:907:7fa5:b0:ad5:8412:1c9 with SMTP id a640c23a62f3a-afcb996f1aamr380512666b.59.1755197101896;
        Thu, 14 Aug 2025 11:45:01 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm2614772466b.106.2025.08.14.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:45:01 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v1 1/5] usb: typec: Add alt_mode_override field to port property
Date: Thu, 14 Aug 2025 18:44:51 +0000
Message-ID: <20250814184455.723170-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814184455.723170-1-akuchynski@chromium.org>
References: <20250814184455.723170-1-akuchynski@chromium.org>
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
---
 drivers/usb/typec/class.c | 14 +++++++++++---
 drivers/usb/typec/class.h |  2 ++
 include/linux/usb/typec.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 67a533e35150..a72325ff099a 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -459,9 +459,16 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
 
 	if (attr == &dev_attr_active.attr)
-		if (!is_typec_port(adev->dev.parent) &&
-		    (!adev->ops || !adev->ops->activate))
-			return 0444;
+		if (!is_typec_port(adev->dev.parent)) {
+			struct typec_partner *partner =
+				to_typec_partner(adev->dev.parent);
+			struct typec_port *port =
+				to_typec_port(partner->dev.parent);
+
+			if (!port->alt_mode_override || !adev->ops ||
+				!adev->ops->activate)
+				return 0444;
+		}
 
 	return attr->mode;
 }
@@ -2681,6 +2688,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	}
 
 	port->pd = cap->pd;
+	port->alt_mode_override = cap->alt_mode_override;
 
 	ret = device_add(&port->dev);
 	if (ret) {
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index db2fe96c48ff..f05d9201c233 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -80,6 +80,8 @@ struct typec_port {
 	 */
 	struct device			*usb2_dev;
 	struct device			*usb3_dev;
+
+	bool				alt_mode_override;
 };
 
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 252af3f77039..6e09e68788dd 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -304,6 +304,7 @@ struct typec_capability {
 	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
 	unsigned int		orientation_aware:1;
 	u8			usb_capability;
+	bool			alt_mode_override;
 
 	struct fwnode_handle	*fwnode;
 	void			*driver_data;
-- 
2.51.0.rc0.215.g125493bb4a-goog


