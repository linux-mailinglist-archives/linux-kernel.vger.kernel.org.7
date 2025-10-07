Return-Path: <linux-kernel+bounces-843625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 29599BBFDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C37D34BB95
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227D1C84B2;
	Tue,  7 Oct 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1m+eAS1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890F1A9FB8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797648; cv=none; b=bLjtsnLxnMCUHmdxV5lofTf4Hh1GKq2Vr8f09xzTe6wNPy/hRBVqHGpnyhksvMmg2XDcPMXhKfkiBO6gtDUbIGds+ACJVk/h05A8pTPNdzSF5wpS4voj4HOk2bGsRqwoRIucNH6RqzdoVkfveqURCzXudl+eMDNdWbNizPzw1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797648; c=relaxed/simple;
	bh=GzUSOSJZ+eDMzzz+ixvlJiOEN2cRY2aCg4gyiQyGc+8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HSs9m3vsNC2fBrcoWOc8DV2ynab6UVzTGFdt4E29Hx3BBFlDGSEGBeaLNjqcpcuIgIktdWj/1e+N0f4Wx1lyAXMHWu9aTK594rxNp9Z7AqyypzyeBrADuG30h7NseNk8EJ8Hh6m08EGNZTliHWKi74jckL/PT2/ZKP0V1fgPh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1m+eAS1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2699ebc0319so52929155ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759797647; x=1760402447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W/DQArMjl2yBGMSdiHTTS+HBsWvNwcwKM6KZuhbPH/k=;
        b=i1m+eAS1kMD6q6obRhdzg3QstEaTqqPDKPdu32tOgcPHEeM9lqosA/2WJ/J85oMYL4
         TrptIWSMPBVZ/E0CviHK5df3DX70zj73svn1AgF83WxQJI0iYDCdYj1K2tl+7Ki1krlq
         7WS8r27eueaLzmUoOgw0qRyVFU0v0wmIEs0/OznkZXLuxZtlNNP0ldbK2tBVgXw5CPf+
         3wQTL1TUt9Vzy4MreHRuYnrLihVu5bd37wcPBQdT9/Y6py8mdjxFTnZbcgM6pZY+HLyt
         MR2a9OVl8CCgCXsmLnzuLZOF0P7Kvo7fesfrQWrdwRaIbXUKFfUNCRpus3ShnJTYI5S3
         Q+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759797647; x=1760402447;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/DQArMjl2yBGMSdiHTTS+HBsWvNwcwKM6KZuhbPH/k=;
        b=DaRJLx2pwnL777KHjY0e7YepbcmMY9J51eIVf5NIGuI+UnWkd95j7LVfVS8DmTQ71X
         1RZL66j9YsRQuq7HgylxPqVrKFYMMbsHJ3d3Lozf5adFUe2n9K6k405pSH6s0jpvffSn
         ugN4CO5QhwmMtW2DuMpGHwZZ3enw21dYcGCe1imw8m2zo1FkGDU3inQ2j8vocxzJB0n7
         5k4OWXEA+kx7nej18GWBqV86+Ra51WjAwWVVr0R0ubyqKzdq/Vw8VSP18U7maNWuGE2a
         gffvob4xMWKB4fRQRok6m0vKde+MmPyFccMsh/juMF7Dy2RlzqxSsHn9qs7Wr21c5ynf
         Kc1w==
X-Forwarded-Encrypted: i=1; AJvYcCVm9IYOP9xdWq7OUSk+geSSSmWiCnXUiwLRib6PLj3NJ+dZ7mMP1HXR43GgqiqbQn7Bekr9/stq9xjraBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlIyuWW0F/VLQav+QLeu5n5xnGtoEfeIgai8ua5J3I1DvQo3a
	RpK6nkpDH5rThtSCgOF/uEdzs++B6m4uD9W23MIUO/KrtQKIpK3uxAdSzmEJbc55F6oNNK7UoAr
	MvUV36A==
X-Google-Smtp-Source: AGHT+IEY1y9c3Okn3yYddyarlZ6Ym/i6T63/pjjdt4P4J9z2U7i5GwzQfVHKsVapqjsTXkVksPfyo4YHfT4=
X-Received: from plhy5.prod.google.com ([2002:a17:902:d645:b0:264:d7d1:2748])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0d:b0:267:ba53:8bd3
 with SMTP id d9443c01a7336-28e9a61a74amr212561785ad.28.1759797646756; Mon, 06
 Oct 2025 17:40:46 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:40:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007004043.4109957-1-jthies@google.com>
Subject: [PATCH v2] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
From: Jameson Thies <jthies@google.com>
To: akuchynski@chromium.org, bleung@chromium.org, abhishekpandit@chromium.org, 
	tzungbi@kernel.org
Cc: jthies@google.com, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cros-usbpd-notify-acpi probe currently does not exit when it fails
to get a pointer to the ChromeOS EC device. It is expected behavior on
older devices, where GOOG0004 is not a parent of GOOG0003.

Update the cros-usbpd-notify-acpi probe to check for a GOOG0004 parent
fwnode. If the device has correct device hierarchy and fails to get an
EC device pointer, defer the probe function.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 313d2bcd577b..c90174360004 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/fwnode.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -15,6 +16,7 @@
 #define DRV_NAME "cros-usbpd-notify"
 #define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
 #define ACPI_DRV_NAME "GOOG0003"
+#define CREC_DRV_NAME "GOOG0004"
 
 static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
 
@@ -98,8 +100,9 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
 {
 	struct cros_usbpd_notify_data *pdnotify;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev;
+	struct acpi_device *adev, *parent_adev;
 	struct cros_ec_device *ec_dev;
+	struct fwnode_handle *parent_fwnode;
 	acpi_status status;
 
 	adev = ACPI_COMPANION(dev);
@@ -114,8 +117,18 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
 		/*
 		 * We continue even for older devices which don't have the
 		 * correct device heirarchy, namely, GOOG0003 is a child
-		 * of GOOG0004.
+		 * of GOOG0004. If GOOG0003 is a child of GOOG0004 and we
+		 * can't get a pointer to the Chrome EC device, defer the
+		 * probe function.
 		 */
+		parent_fwnode = fwnode_get_parent(dev->fwnode);
+		if (parent_fwnode) {
+			parent_adev = to_acpi_device_node(parent_fwnode);
+			if (parent_adev &&
+			    acpi_dev_hid_match(parent_adev, CREC_DRV_NAME)) {
+				return -EPROBE_DEFER;
+			}
+		}
 		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
 	}
 

base-commit: 48633acccf38d706d7b368400647bb9db9caf1ae
-- 
2.51.0.618.g983fd99d29-goog


