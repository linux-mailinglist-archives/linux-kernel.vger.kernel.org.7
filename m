Return-Path: <linux-kernel+bounces-829919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD46B98378
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E37B6480
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E453AC15;
	Wed, 24 Sep 2025 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDPmJuQ+"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D35C8CE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758688655; cv=none; b=ndx/QVDhHQ7A0JOHnBz5xf15JBd8f7wahV/NiFOM35kOie620A0q85xJPxVeRD+ffjVks+b51FHw8t5bdfqNfqW/fUFFQkjf6gz0CaNQINLzb27vHSITFa4vDQAHnLywtggDMDgjIovremQDT9DslJzs+maq7wCmQi3u2NMdc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758688655; c=relaxed/simple;
	bh=RRDPP8ixAZkfYkD+0XWsW143p6YSMBD1DDMJaAaF9t8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=psFYd9Qq7zHveA7Cn1iQ7xUPfiggHq14epsrbKORCQSTQajkS+rOf/zzIDxEvQqB22JrkmFiytYn9rI92ngok5954xr8VpMIVXenebQaJdX5QfyPQ4M9vQttDUM1CJ0SqH027jiclFalOVanEGVgpGLefhvB0FXQ8o7llSx4xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDPmJuQ+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77d94c6562fso6376315b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758688653; x=1759293453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2AtE3wb9Esvjdk98Ay0zc20hm41uPjRxNV/m1l3tfU=;
        b=FDPmJuQ+BWsfiGxlPG+z73LuLzo4Wo1eLPCrwRh6AphmmSi6IpidqE61hptb/75X7J
         zPd/F5UvhCuUnrGKlrYkS8MkPk0u5dFxRcKE4aHYRrdQdnbrG3cQQzEHHWAc9XTJqnzU
         xPHHPOl3cO8AUKptrczWetLHIoqQfhkFXQy22T1yccCmvnukYdZStJyWOpcnMhpFarqP
         XdEJFtadJ9KiyA+mpm5NRTHkOfuGoujNFOuhGdirzBSUgw8OIIO37nvn0Aiir4mf2ws8
         uewPHlO2RBxEOPsOOknNTU8bSmppFDNH5WNLc5cxrGuWdPBVxYAIGNZeyESTfnEdSfQl
         bN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758688653; x=1759293453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2AtE3wb9Esvjdk98Ay0zc20hm41uPjRxNV/m1l3tfU=;
        b=fDba/RtlDMOEATyEA/vOcTrNPS4MSsMXTPHHnI99/jXPD39LTYyQZYYoZMj+9AEYPo
         rHZA+7i68cMkzACdbDxaxOR5xex/Ivd/8iCxgvJcXiLf5krSnH7PVSMkwR+iMvikN7sb
         kN28bwpef+hQbnYcuWH8i0Rary2CGv6UvzeFo+x2YAEKvKFY4uYvQoY1hPNyWfCaVTdk
         ZrFwNcLQk/FPvhynDwCYuSGbgFqfCXiawqnSYUZpaxJPWvru2zqILyjFY+KTJEXL7Fkl
         lkcmCqw1qzgVtJDdrJizgo+pkvYCrhenzwG1EXMQYQ5w14VPvQoj82goZzI80tvcb6uU
         e8+A==
X-Forwarded-Encrypted: i=1; AJvYcCWpUZXIw3qFcR09x4zbB1bcbe4OoY8yifEVv/ukQJ01b4XKw7T+LzE2BBSjhTenw9muCz8v2olYAnCh1tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zhyuDrTBUfl5RFbu9ijrwJlacurV9Y4nOU8mfIpkLI+KHbFQ
	mkCUUw2fJli+6EqhLO4+DrY9L3RMKJL0HpkrqzzkHmvnWIyal0SFjtQI
X-Gm-Gg: ASbGnctCghDRbxP2YnTP7n0WDYVEwltPH5gxVhxCBcVO2A0AbCMKq42Tx2MjiyFDKVT
	lJph6nfqB8GTjApWt/MUWl53oOVLXQI7LdGznNsxfiOlfTOFke1HQGBJb1foEVOd1vgb2gGuww0
	ZvZendLi9euI0LrQ3ipMcceo3bEZbXJ7VM9x999sUUf69RWi+MeOywMOkNGjPBt7orksaqh0FqU
	YoBot7/+yNJQTC0wTapdnMB/6wV/5HmvUlissqQ4Y9IEWBQ0ejwZjp8C3YMbkljP9KRcQgyn95V
	Gn8uzQcEjDtTCiNOczahJK7yv7S1zExo8+CNTyMtgyrOAOyfe8JNiitnBC8qlhhkqqPyEeKqYa4
	t6kt2u54X3pJ8673Vsv1YswQ/YOqAzorOKw==
X-Google-Smtp-Source: AGHT+IELiGCDwK/3N8AD/xB8vMByTAfUuiT/2C6BA80wtfiX+6BqvaDzI/YKAnY9RJbUWABNVlvMBg==
X-Received: by 2002:a05:6a20:bc89:b0:2d9:b2ee:784a with SMTP id adf61e73a8af0-2d9b2ee9d54mr2716962637.20.1758688653537;
        Tue, 23 Sep 2025 21:37:33 -0700 (PDT)
Received: from embed-PC.. ([2401:4900:60e0:7677:7e66:bbb0:5e83:be39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552882b177sm12122235a12.11.2025.09.23.21.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 21:37:33 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: mpearson-lenovo@squebb.ca,
	srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: intel-thc-hid: intel-quickspi: Add ARL PCI Device Id's
Date: Wed, 24 Sep 2025 10:07:20 +0530
Message-Id: <20250924043720.5545-1-abhishektamboli9@gmail.com>
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
Changes in v2:
- Change the max_packet_size_value to align
with MAX_PACKET_SIZE_VALUE_MTL

 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 6 ++++++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 84314989dc53..14cabd5dc6dd 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -33,6 +33,10 @@ struct quickspi_driver_data ptl = {
 	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL,
 };

+struct quickspi_driver_data arl = {
+	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_MTL,
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
index f3532d866749..c30e1a42eb09 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -21,6 +21,8 @@
 #define PCI_DEVICE_ID_INTEL_THC_PTL_U_DEVICE_ID_SPI_PORT2	0xE44B
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT1 	0x4D49
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT2 	0x4D4B
+#define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT1 	0x7749
+#define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT2 	0x774B

 /* HIDSPI special ACPI parameters DSM methods */
 #define ACPI_QUICKSPI_REVISION_NUM			2
--
2.34.1


