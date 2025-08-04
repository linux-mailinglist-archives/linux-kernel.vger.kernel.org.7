Return-Path: <linux-kernel+bounces-754898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D17B19E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D1E3BB4BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC486245006;
	Mon,  4 Aug 2025 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luiiZTaN"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0324466C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298248; cv=none; b=nb+bxJLq7YestYf3khGhdhZecumB0YSD6ykepdVZYybJYof69C+qPLWy3DbkGzD0SovfQUjnx7Po3KB3Qfr1EEfeFqr1+Pvjl7DuJ9hg3CZ6fUaNKeiIxBOwnL2BozLvhcbFSCkqJ17SyqKSqCmM3gRTk7UNc+pXyRRSrI+JwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298248; c=relaxed/simple;
	bh=SeYBoLiLdsd4RYBx+xmk62y4glTyVdE4JpC5IMRPlMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5OMC6VHJL8QwQwDhlHOKjttOR5gXG6nIvWCHBg4vGFSbTgmePnAo7taKqiHHr+mwlxWmCi4rb6ITcKriKCechXqnzNwJT8bBBeJ/rsFRifmpzn4HD9JSNlPHTldQj8weMMPFp9b7zQ5lCybdknCecmjCOYLurN0k+3r/QOI0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luiiZTaN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af949891d3aso236064766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298245; x=1754903045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbhdT3BVEtPsr7nMwgyR5zxNdwkZ/IAe0pEt6XO5SM8=;
        b=luiiZTaNv7Qxi1lKhzxANGHnOQk5b6aiP0HwgCFXaiC7apueLzmcFu9sA039Ws7N26
         b0Xa2rxNdJaVPiNg74xVWCO0dkVrAlLOKeKCUUE+WPst7ZZvFJ+6exvUjnCUb3ULWeOJ
         13PSA3QkgJBtvJURdLNRZPknWrBlF3jk63+nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298245; x=1754903045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbhdT3BVEtPsr7nMwgyR5zxNdwkZ/IAe0pEt6XO5SM8=;
        b=EaGxmKLrsBRvGIrda/z3SeObSQwO8DuZgKU7/NpSfwhCJBvdtLhrwEzmBwvuyx3Ax9
         eRDGfkXn8UF1WfFnx4sCkucbN0SGMxVrwXI6TMhsygwinpOv6EreCPf9gOJXzOlNn9Sg
         zrrDQtkl2yhX2uhymvhyMg02ATlSK0vMBc3OU2AUB1yLsd/HciKmsR81Ls66LxORMvMs
         2OW5dgU2ziofyPA4XJQE0EIJ+uyPXXNFrXhktVVRl9reMBgMavDMG/ccAZQJmjA0SjqR
         ULGmmOR7A/vPVyrJPMkFA17MTkv+HrShoUA6kUZU2bqNPeIW16M+ZuVIKN0f22pjaoYr
         vWzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpPO3tmxODCyEeRLmW//bLDTCG/0ralijvFSgGPq1lnRwixfVIhFVZ0v2Lwp7LvIspqkol+MFPKPMT4Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBfFLNFX6XRcQy5Ets5WIxlA1kDe96MtEIsArLDCTpJH4b8pf
	QaBgBonI2f0ijBlMsVCkSFbbv0iBKU7nOD8f4Uz/udvvTUL8dP0PaXVRJsO7aajBcg==
X-Gm-Gg: ASbGncs0R7pLkyEYZMQTku2LvX6zCNCWqUU4OpOXyNHQfX4KLSeQXxIMK7hThwpU97Y
	WoU/fM5WjcGwYbo4AbHQNt6Vrz0b+2pBue1iEVv8p/MLlBFzb2bcK3u0ST2EONhN0K388YnPHdx
	VTZhjkN7Jx/CfYWjbnp4gxA5HmkXuiBDDZqex6T5W6McVG7Isr+eASSbwWxpVUpDFqxqOEVQeYW
	9reEmcfj+sH5dEkODy0eVdNY6FhHsQaxW9TWuq8UQFsI2QbGpo+WoyjlXiUSXyIzhm2t1r5OovR
	ZjC9JGp0wZ+4+L/3AFXfisK5RMLAH+FX9yr0VO/7wfTECPN5fc2WLVvsRiZy5RbqSMshLtnUxyi
	cBSVEGmMNyoIrj01df/vanBlRDdjVp22R6iIUkyVRjFvlfxcIbJh193wzlCRcpZEeHP7DcvINcF
	yY6kv5n4TudkVLvjNszsS3pHCp+Q==
X-Google-Smtp-Source: AGHT+IGevy8HvEbH/6/5kPktQXX98NEixPFRIRgQ3eseS1Hs85sSCgqCJM8sG0Zq21CouJBtYcjtwQ==
X-Received: by 2002:a17:907:6d1f:b0:af9:e9a:3ce9 with SMTP id a640c23a62f3a-af940031934mr1082193166b.10.1754298244562;
        Mon, 04 Aug 2025 02:04:04 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:03 -0700 (PDT)
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
Subject: [PATCH v3 01/10] usb: typec: Add alt_mode_override field to port property
Date: Mon,  4 Aug 2025 09:03:30 +0000
Message-ID: <20250804090340.3062182-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
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
2.50.1.565.gc32cd1483b-goog


