Return-Path: <linux-kernel+bounces-851332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB75BD62C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C524421403
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D79230F7E3;
	Mon, 13 Oct 2025 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMO52PQz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456430EF80
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387663; cv=none; b=OTnpiHuAkUNKD0noXvl9hsWJciZYyXVEBUR7lEJRZmKV4R5cSPDxgGT9xrEVnUogiSYMGC0QekdBAwHO4dG1mL+gp0egMgc7TVem5cgrj1D9t5lDRhEBQaC1GR1XGuZkDl2nDiDOwLqk+kZoA5jctS0bOY5S+56GgoLHajD+uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387663; c=relaxed/simple;
	bh=R1YnFh8aXUGKuVVtnPClepvt/LVUGJ/UtnMqEulZIYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dUFwHb6GPtDWxiW4cSGWH83XoGLQx+kpy60zRVKn3U6qN3UD7tiFBI7uUMpySaT2tey78u33q0psgn7JVMX3GnI3WlilJS6ifs9j2Oa0J7MC9uqpAQnpDJgocswqeMQpKDEktLmO9BjtFJT+jQvqEsPqWIFw/mii02resk4l0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMO52PQz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7811685b417so43821207b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760387660; x=1760992460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFnB74J1pAvDm1nl6YVxkFp2KLUlGXZiPBf1NrkOorI=;
        b=bMO52PQzI4F9dPx84r//NPWVXxaBOt65XYRWH9LDhdRM7bXFtZStQCFKaejRJhfSlS
         OQr9g6hDIBxLYdnioYiARYTbaxVzMeBwdhU7ELfWZMgScGo2JrGUCwXWky8qDrcDaBPU
         SnCMo5/9alVda50NLSfhgeblc94Nb4NkQSO8rzGm+CZ5gldUd04tQp/WMU4+hYyC9Rha
         MoWgdQsvzv6eEzhFeqahauHedOUl9E8y/T7WtB2jbbYcUpqo92hJssxkD6zG2ZnfXccf
         YuUH5Q98qKN6joDtJ3EwZ3w/f5xDidnCDT40rTwBvJ6nrP5mYhT6rDbPYqrkF99cJvhU
         YbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387660; x=1760992460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFnB74J1pAvDm1nl6YVxkFp2KLUlGXZiPBf1NrkOorI=;
        b=pkAwkvRBL8VFDtbs+1WVIwFVLIdbQhTabYpxX4qcvb2Z3GHD5cypa0Fgx6nsYuvASM
         UwtR9457rQSHiWuyzRoDxyMZXJwqjinAZWqu+aI87qSR41q55eexPn/vG8bkbVXlN/CO
         8l66uDPvYJo6Hm/Y+7XVuqVZ2o3q2Ogv5nhFDtTfoQp15WXHKfKc+wcRJxcnvuOYYsOM
         jgy9HgGtoeM2YR57mmkAOg4wtlMMIUwKWLZjJMj4aJUVAzqqeKLzZxcPEXL+X1y2ryz8
         MvgF50mdD84Cyrog9sGRWNEEagAYv6s/1B2bTrxRNpyijVf4fjAsWJBH3XSw3CTpZQKa
         i3qw==
X-Forwarded-Encrypted: i=1; AJvYcCWIdcsyh+4alldssSSRCArMKI1rt8NNGm7VwGduq+Wal5DjcDASh2HzQB6ofkIWBtot4vOIK/hha7+L/Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/FriNkWIz0m5LGWcM8O56au/yZt35vGD71bSaK8dsXflijkH
	akD4hENVuwLNcwIELPYPy80lqY/UcWkS4xJDibfriK09+EjEVUkVaG97PJfpTQxMwaJakGcaGrR
	rEbOvtw==
X-Google-Smtp-Source: AGHT+IEjUm82raEjN7d+M3tvikmOo78EaMWdJ4VaMRN5Im1/+9AxanQNq/18YLWj74gbMAzsjUUto92DYFo=
X-Received: from ywbjh10.prod.google.com ([2002:a05:690c:710a:b0:780:e432:6fc7])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7487:b0:781:64f:3145
 with SMTP id 00721157ae682-781064f72ecmr131650497b3.67.1760387660244; Mon, 13
 Oct 2025 13:34:20 -0700 (PDT)
Date: Mon, 13 Oct 2025 20:33:27 +0000
In-Reply-To: <20251013203331.398517-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013203331.398517-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251013203331.398517-4-jthies@google.com>
Subject: [PATCH v4 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is defined
 in OF or ACPI
From: Jameson Thies <jthies@google.com>
To: dmitry.baryshkov@oss.qualcomm.com, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, krzk+dt@kernel.org, robh@kernel.org, 
	bleung@chromium.org, heikki.krogerus@linux.intel.com, ukaszb@chromium.org, 
	tzungbi@kernel.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

On devices with a UCSI PPM in the EC, check for cros_ec_ucsi to be
defined in the OF device tree or an ACPI node. If it is defined by
either OF or ACPI, it does not need to be added as a subdevice of
cros_ec_dev mfd. cros_ec_ucsi will load from the OF or ACPI node.

Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index dc80a272726b..1928c2ea2b8f 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014 Google, Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/kconfig.h>
 #include <linux/mfd/core.h>
@@ -131,11 +132,6 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_ec_rtc_cells,
 		.num_cells	= ARRAY_SIZE(cros_ec_rtc_cells),
 	},
-	{
-		.id		= EC_FEATURE_UCSI_PPM,
-		.mfd_cells	= cros_ec_ucsi_cells,
-		.num_cells	= ARRAY_SIZE(cros_ec_ucsi_cells),
-	},
 	{
 		.id		= EC_FEATURE_HANG_DETECT,
 		.mfd_cells	= cros_ec_wdt_cells,
@@ -264,6 +260,23 @@ static int ec_device_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * FW nodes can load cros_ec_ucsi, but early PDC devices did not define
+	 * the required nodes. On PDC systems without FW nodes for cros_ec_ucsi,
+	 * the driver should be added as an mfd subdevice.
+	 */
+	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD) &&
+	    cros_ec_check_features(ec, EC_FEATURE_UCSI_PPM) &&
+	    !acpi_dev_found("GOOG0021") &&
+	    !of_find_compatible_node(NULL, NULL, "google,cros-ec-ucsi")) {
+		retval = mfd_add_hotplug_devices(ec->dev,
+						 cros_ec_ucsi_cells,
+						 ARRAY_SIZE(cros_ec_ucsi_cells));
+
+		if (retval)
+			dev_warn(ec->dev, "failed to add cros_ec_ucsi: %d\n", retval);
+	}
+
 	/*
 	 * UCSI provides power supply information so we don't need to separately
 	 * load the cros_usbpd_charger driver.
-- 
2.51.0.858.gf9c4a03a3a-goog


