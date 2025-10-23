Return-Path: <linux-kernel+bounces-867039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C9C016DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7704950086A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3981233B97D;
	Thu, 23 Oct 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iMK2Izjq"
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F631D742
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226034; cv=none; b=Z9Yza3+pW2ybnSMIQUAbKvvGEJ8yLq0pu6i+v6wNSB8Btox41thdjwpepsFrCZEMBE6wO0uRjCPji9LRUYw+S6hBJ6R9aLwnRvNIddX+XRFZtINCKVWCI6wd8wImfF9rwaB9UP6k+cU2yLCCn4ZxsWy0cYtvhNOv98qAOim14Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226034; c=relaxed/simple;
	bh=pgKFrT/kQ7yft1xAmrKOU9RUhiqawEtbhAozzN7ob3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iryItTaqXmaDXUiidPQxbKI2ZT+D9ZBO9HfKTRgft9ZY9oQ1ML4ctky1KwVDTvMMYRPe7jolIv26aVBgWDneLqEdiC1WHn1KoAFFzM0ppj1igvzClpbKGLo7gyKlfksBXLp7q9W25+YdL44PQXHgNQsQsx/oXjrYjJaSNx5sJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iMK2Izjq; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-3c97b52b031so486040fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226031; x=1761830831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgxpeCfDCqbostprF+yWh/qnmS37ThiUJQldgkEpZik=;
        b=wCRU1vUpisafZDn5OV5yNqzxOq+nAwMsHy2GSqT8etcWJ5Z17kxGcY9RhUFHEWmirN
         GS7X5luuzUf1Lhuc8KP6LoYQe5AkIG1/ZO2BdTKpD52oBNs6dou50LNDzvIhMgIbiW4H
         x4OREsZuo0YBwzRa2+E2q6FsQaf3uiAAoW3mbC55sQWr0NtZyVNs8b9vsNmowbAD/zQA
         7ByhqoTMxPTaXDg+9cxoNiwskGj0x3tFslC2hOVo4fYIdEsqViSex0MywUu5jNY221fs
         I+7QxjFS+JGOTqhlfky5YOb6AK3HKN2sfFMxfoe3iduaI2cut+H6eO1DEnNpry3/ggNL
         iSsg==
X-Forwarded-Encrypted: i=1; AJvYcCVLR1sRnfiTi4GPWvrZoySoxqR7hoLMIQ5+c9HTG2OCt1IZubTyj/vyIQdj8UbfyiM78V9IOmv0FlFO8Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWkfB/LZzAH/3ijc7mYLCWR3btUhlYfjt4TdNbMyfvQmfcMLd
	cZ2t5FScg5qXBRJrSraalt8UGuugJnbs2t/HsM8gAoYuTUF3EDdeU+W2nWrgls4P0URt5eci6kF
	dzwyaNGFwfc84d0DofjFDPlLSI5DuUd3psEUjCF7uGNAv1lSo0+t5wp0iEqGnNbqCnw0nP2LAET
	IGCjm7/YHC8CJN4k6ZwuujFfGcjpLrFBjivK4hHY3445eWf2RPo7hB+bjoEsp6r1a7BClBA8Bus
	gal3BJlMRb8vbgh
X-Gm-Gg: ASbGncv6BHmafApQB1RXvVAIF5Hlo8TvkTKbqCxd0923mywFLvJrHtwV7mZDQMkBtyB
	fN9kT+EeDnn1fFekq3eD8IxCW8h7EiZfsS/Ow4s0VyRagbr8rSSPBvaSP3twyA8z89DxrJjmZwq
	O4lFGRZXwvq32lUDpGc6zl0H37zHM2YcU1WMbqeXjlu936vGB7LESA3eHFtOgKfArIhRwSVbFAh
	UlczedhFIcSYmf2zvtkXbIEG5w5Q5fAKDWDQU+0iTSqX7ga3oN2b7nzM+RCpYM7aKIBwUkoFuij
	ioqfjwpYE2C7QSNV+/RaOyqa7MDEChsRkQ02IpBN9PkJ8KhvaYiLVxiYzFrBbOAJ3M3rtFnUZBh
	/ywRvCrFyIsQJWyZ3A2iO0LfxgT2KKsBAGeF+likVsxolB1a4z4laOuGk0H44dw71cDkkJhGPbL
	jwrMMVANFipqLz9ODNlBqa7iGxeI5ep980rA==
X-Google-Smtp-Source: AGHT+IGY6sw/Lr88hlGQXONEYZUEjXL5wMRFY0ZOFwzR9jAI8oz20qILHY/7UjHLVRZzh8llasLaH8fBY9Xw
X-Received: by 2002:a05:6870:1719:b0:319:ca54:8731 with SMTP id 586e51a60fabf-3c98cef79ecmr8290124fac.8.1761226031535;
        Thu, 23 Oct 2025 06:27:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3cdc4c41b67sm177382fac.9.2025.10.23.06.27.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:27:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290bd7c835dso8421505ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761226030; x=1761830830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgxpeCfDCqbostprF+yWh/qnmS37ThiUJQldgkEpZik=;
        b=iMK2IzjqUDqkC+mwYj0tVU/6EPmeqbNcY9lzyKfWG09mZq5BN3pce0JJcUmG/7Qwlq
         X9Ru81iX86wxcIjoG+r30HEYstDtBOw9/CaBjTXeA33s2qu3Tj0WkCzNMlB8P59491wu
         pbK/TnVF785k/aQRxOJaZhUq779uZiDJ/Cs9g=
X-Forwarded-Encrypted: i=1; AJvYcCXFuOipKYHcmGb54plcJeun05Uig6KW9XD+zTDUtNwrCn4d+151Ly2sjBZw5zHDRcxwShDue3ja7LSpCdo=@vger.kernel.org
X-Received: by 2002:a17:903:46d0:b0:267:9931:dbfb with SMTP id d9443c01a7336-290cb65c642mr303910555ad.54.1761226029941;
        Thu, 23 Oct 2025 06:27:09 -0700 (PDT)
X-Received: by 2002:a17:903:46d0:b0:267:9931:dbfb with SMTP id d9443c01a7336-290cb65c642mr303909995ad.54.1761226029324;
        Thu, 23 Oct 2025 06:27:09 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc204fsm23739785ad.60.2025.10.23.06.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:27:09 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	davem@davemloft.net,
	richardcochran@gmail.com,
	nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	jiashengjiangcool@gmail.com,
	andrew@lunn.ch,
	viswanathiyyappan@gmail.com,
	wei.fang@nxp.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	cjubran@nvidia.com,
	dtatulea@nvidia.com,
	tariqt@nvidia.com
Cc: netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	shubham-sg.gupta@broadcom.com,
	karen.wang@broadcom.com,
	hari-krishna.ginka@broadcom.com,
	ajay.kaher@broadcom.com
Subject: [PATCH v3 1/2] ptp/ptp_vmw: Implement PTP clock adjustments ops
Date: Thu, 23 Oct 2025 13:10:47 +0000
Message-Id: <20251023131048.3718441-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
References: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Implement PTP clock ops that set time and frequency of the underlying
clock. On supported versions of VMware precision clock virtual device,
new commands can adjust its time and frequency, allowing time transfer
from a virtual machine to the underlying hypervisor.

In case of error, vmware_hypercall doesn't return Linux defined errno,
converting it to -EIO.

Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
Cc: Nick Shi <nick.shi@broadcom.com>
Tested-by: Karen Wang <karen.wang@broadcom.com>
Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/ptp/ptp_vmw.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 20ab05c4d..ea1cbdf34 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright (C) 2020 VMware, Inc., Palo Alto, CA., USA
+ * Copyright (C) 2020-2023 VMware, Inc., Palo Alto, CA., USA
+ * Copyright (C) 2024-2025 Broadcom Ltd.
  *
  * PTP clock driver for VMware precision clock virtual device.
  */
@@ -16,10 +17,16 @@
 
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
+#define VMWARE_CMD_PCLK_SETTIME VMWARE_CMD_PCLK(1)
+#define VMWARE_CMD_PCLK_ADJTIME VMWARE_CMD_PCLK(2)
+#define VMWARE_CMD_PCLK_ADJFREQ VMWARE_CMD_PCLK(3)
 
 static struct acpi_device *ptp_vmw_acpi_device;
 static struct ptp_clock *ptp_vmw_clock;
 
+/*
+ * Helpers for reading and writing to precision clock device.
+ */
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
@@ -32,18 +39,28 @@ static int ptp_vmw_pclk_read(u64 *ns)
 	return ret;
 }
 
+static int ptp_vmw_pclk_write(int cmd, u64 in)
+{
+	u32 ret, unused;
+
+	ret = vmware_hypercall5(cmd, 0, 0, in >> 32, in & 0xffffffff,
+				&unused);
+
+	return ret != 0 ? -EIO : 0;
+}
+
 /*
  * PTP clock ops.
  */
 
 static int ptp_vmw_adjtime(struct ptp_clock_info *info, s64 delta)
 {
-	return -EOPNOTSUPP;
+	return ptp_vmw_pclk_write(VMWARE_CMD_PCLK_ADJTIME, (u64)delta);
 }
 
 static int ptp_vmw_adjfine(struct ptp_clock_info *info, long delta)
 {
-	return -EOPNOTSUPP;
+	return ptp_vmw_pclk_write(VMWARE_CMD_PCLK_ADJFREQ, (u64)delta);
 }
 
 static int ptp_vmw_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
@@ -59,7 +76,9 @@ static int ptp_vmw_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
 static int ptp_vmw_settime(struct ptp_clock_info *info,
 			  const struct timespec64 *ts)
 {
-	return -EOPNOTSUPP;
+	u64 ns = timespec64_to_ns(ts);
+
+	return ptp_vmw_pclk_write(VMWARE_CMD_PCLK_SETTIME, ns);
 }
 
 static int ptp_vmw_enable(struct ptp_clock_info *info,
@@ -71,7 +90,7 @@ static int ptp_vmw_enable(struct ptp_clock_info *info,
 static struct ptp_clock_info ptp_vmw_clock_info = {
 	.owner		= THIS_MODULE,
 	.name		= "ptp_vmw",
-	.max_adj	= 0,
+	.max_adj	= 999999999,
 	.adjtime	= ptp_vmw_adjtime,
 	.adjfine	= ptp_vmw_adjfine,
 	.gettime64	= ptp_vmw_gettime,
-- 
2.40.4


