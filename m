Return-Path: <linux-kernel+bounces-828202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07963B942AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9A57B1950
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A112D270568;
	Tue, 23 Sep 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltm/nIBi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0D229B16
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758600188; cv=none; b=qUZtqxW6JUu4rwjwIT8n/Sni0u2W4Dfhr4pN8KYZc4UoXncrxt3XmefLRBQisw/+1Y8zWvGBkAuYyki4ulDswAm6dQ64j0DMRS7HK1Lck8RfIZ8R7nQesNNCDt8NatC2UyywEkELSdl7uWDAQRXJFb7OwKhrMC4f9bWQdWubquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758600188; c=relaxed/simple;
	bh=CjypHTonfU2PuKnjzfba4IZNkvtM3Pi4QkFQXRJ9I6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nd/7SHgKauP4HDe83jWuqqKSCC6O1zN55N3mtm/WN09SBpixpn6vSeJhIYqFpBQnQ9k1iU6OQRAwmfoR5qMc9nCV1HZqOHhHCdfiZhuhPO/wHSEW+ry9UpNkO36wwlsmlYJr3Cta53S2EmojwTLls+CfQn4CtZ5YeBXMlr7dFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltm/nIBi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445805aa2eso52791105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758600186; x=1759204986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9+aPj+lnXE4gCiejoLjoYIeVsmkQRlhBmkDWv3AzlU=;
        b=ltm/nIBiOhTX+jSQbMp4nsatxbVrfwdH1v1KVdAfE0n1W62NC2s2Hp4NS1g9jvroft
         TafNonWTX2kG/zYEQrB+OI8a1K0eTrGZYXQzg9AlmPVuTQR4dAsZRVO+o/ifdRxFx1KP
         ihecXKpkkArDrcAZrk2o6BWfNNsTtpH2Vd2MV33hg1pbLDeogTDDbi/G3VNZKWQQ/wFw
         Jyxg4JeQtggrOMuaQKYqQEL8G6c9KX5pv1pzrleA2KsHXYqI81djg0UtnJJdT84qwO5w
         /qHiu+tN7F4JDNfrPw5Y+RSbDt+e41I9Fp9ey8H/z+iv7Wol6+SNO2DW5G83wFiwFbfJ
         7VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758600186; x=1759204986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9+aPj+lnXE4gCiejoLjoYIeVsmkQRlhBmkDWv3AzlU=;
        b=KK9fsECs2MPtfJLglwHFVxWaXo/JHRKW3hkSxmkT+n3kcBOZ/sYiCLvP/DuD+b/lWr
         2Z1kY7cVEXZA86F0aI4h+rBrq2C4ZpCcrNrCytmOx/5xbJzhBU7uOQBKXpvFu7ekG7KI
         nu4g16OMOOPU4fz+biMuR98S+OxNOM8SR1B8mP5o4AdgKOOEBHcCfW79XsDYe8xQj81D
         E7YzkJ5UGc6G5mA/VRaid3Hbc1MFwMgbDb6VMwrMXgLT+vAa+NQlLGzpeloNh0Pw0YTb
         CaGeD88oxwdJ/oCtwRHMB3OPltmxmCtpblRfIT01J+HGX+mVRiQRo/kWOlr4a0M/QZzF
         cvlg==
X-Forwarded-Encrypted: i=1; AJvYcCWGrHH6DlD6ORDjDDlp0XQWQrc1b8pxVX/8yxe5e+KARUJNjW05wvUCdUgPG/aCJxTQsocN5mGtOmVRmV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnI2RhL6kzrjhi5ui+fEcjnfbJCKuFxapjKQHQPnq7TMwoMac
	EM7vDTMbMaG1uvv0CBjSKzC87OKn9pChthzjPtwLLSzdPRCCH2p9WJMC9EonaFOH
X-Gm-Gg: ASbGnctCrLOeUK+iB7wwFIzrBdZxaLLnuZwZiOUGCzD/XlwEbH7c2M/rWOSfqGAWyw6
	tH7tAbCDXYlPyG2ppfbqo0pbsAYoc0Qhj63glVHv02/O/l7exmrlU8+kqJAelxuFDLX6quvV10P
	6ReNZSh/fl6qGZfCjC3zn3MspC6LDiUM5g/iiWQeR3ewYY9V99DGuMYU3U47adn0dXuNB2ti5Mx
	ExQwmpBlxn81rRvA9nwgzLtkzOeMv7Dui/o3VjA1fFPyTxToaE9Y072Bz54ynFIOnMJfxRbiufY
	OftzFe0WzmIdiBOq3qs0Xb+9aQ2lg0st/iRmtnzIKCz4l0hxon8RmEM7ijgaEHdz+DCmyYXTZ6+
	/OLepMG7nuObs9vCRw6u72ud4ENlERvYxSw==
X-Google-Smtp-Source: AGHT+IEixYpSxdSU4oB1lU9rbuUjobE4QlV/b4m6Br+aZmOnIABcgsaB2MYHx2Hinnp9uAOkJ10dAA==
X-Received: by 2002:a17:902:db03:b0:266:ddd:772f with SMTP id d9443c01a7336-27cc28bef39mr14459835ad.9.1758600185700;
        Mon, 22 Sep 2025 21:03:05 -0700 (PDT)
Received: from embed-PC.. ([2401:4900:4e22:682f:9daa:270e:a331:7be2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273e8fasm17765485a91.18.2025.09.22.21.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:03:05 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: mpearson-lenovo@squebb.ca,
	srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: Add ARL PCI Device Id's
Date: Tue, 23 Sep 2025 09:32:54 +0530
Message-Id: <20250923040254.7547-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing PCI ID for the quickspi device used on
the Lenovo Yoga Pro 9i 16IAH10.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=220567

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 6 ++++++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 84314989dc53..49c8458f0118 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -33,6 +33,10 @@ struct quickspi_driver_data ptl = {
 	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL,
 };

+struct quickspi_driver_data arl = {
+	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL,
+};
+
 /* THC QuickSPI ACPI method to get device properties */
 /* HIDSPI Method: {6e2ac436-0fcf-41af-a265-b32a220dcfab} */
 static guid_t hidspi_guid =
@@ -978,6 +982,8 @@ static const struct pci_device_id quickspi_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, THC_PTL_U_DEVICE_ID_SPI_PORT2, &ptl), },
 	{PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_SPI_PORT1, &ptl), },
 	{PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_SPI_PORT2, &ptl), },
+	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT1, &arl), },
+	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT2, &arl), },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, quickspi_pci_tbl);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index f3532d866749..7f0fb0056244 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -21,6 +21,8 @@
 #define PCI_DEVICE_ID_INTEL_THC_PTL_U_DEVICE_ID_SPI_PORT2	0xE44B
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT1 	0x4D49
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT2 	0x4D4B
+#define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT1		0x7749
+#define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT2		0x774B

 /* HIDSPI special ACPI parameters DSM methods */
 #define ACPI_QUICKSPI_REVISION_NUM			2
--
2.34.1


