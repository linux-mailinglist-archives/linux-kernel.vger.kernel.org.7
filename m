Return-Path: <linux-kernel+bounces-864785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8ABFB8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FE384EB2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9332A3F2;
	Wed, 22 Oct 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zgka9XoA"
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6932143A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131236; cv=none; b=rIrhtVh0CQwTegYjQznlxwEKMyCWYHkafoSrSoYw2ljQUGBz9wg52DbgppDTvZM38+bhA+2I47NTcWqkeRWjPJEt/7tidip3zITJuK2mek2fGAezFFCnun8kZm9W6eT0MKtXL5/yN5YLkat1LXr/QUwAA7LdjFxQYVasEP6ObzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131236; c=relaxed/simple;
	bh=tphZkRN4cfZYFVTFehKBYnLpVKDqMthpMvjmWlBcnCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNgxfzaHofdaNoaJbBjBfBg5QLIhUhLjfoG4eDkR80zlq8mmQQCIiUhBO4Jf/V6RjtsToyHzEFnjm1JFZjzbh1pfdMs9UNLzC3BFNxTBwnOjHHSGvejEN3JLTMBO5o+RBy6BmioNOHWecwnWIZKLhA8kuit9viYbHXi1JlHur3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zgka9XoA; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so836317a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131234; x=1761736034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA9Oy21XPeXmPlSwKvLYBk2PQ/Fy4Lvp8jR4DRUe+f8=;
        b=gRfjOMnPsR5Iq0a3NbzI8NbxDguPs1ELm3begJdS0qcVTnRjmyBt/MIBnkrTfgAHDa
         uZ8iQe+Tx5aoZ1yIPA4j7yBlw2ezS/meAoYclOSzmd3ey0T7PED+km4U/swDOgLrY9jY
         O9ALbsKq46jtD8uykY7LGXMgPj4DdSxqPTTQ2FHS1mXs3b9IgYGf+EKHf+Okvm5CWOc0
         ITg33p8IQ/vELGK3AVx5V9/VIBDmjZKre7mY7tYT5ft7BSU8r2RiFZmxy0Ulj517rtx8
         5LsGVwp6a1lS8qt8RlmyI7YuaqK+yXUUfNr9R3A+9SDkNYxZnHPmhC2TEO5d1Ql+zAkg
         87CA==
X-Forwarded-Encrypted: i=1; AJvYcCVnxq2Cba00+Ip0ubxXEhj09pQWujllvDMxOzLtK25n20TL3JRQGqeFP054VXQfBOdAbUX1licjd8oU+38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOuIZFO3znle1m0wdEljlqJs8FdB9uozNK6x9Y6UOxuyvZK0O
	IX+MUCAMAeHvlbqxqUMbzH6hx7aCTgtmWPOS2qA8KTkM3azTK/lbN/0rvSS9ZmTzjBRAHfrVsvQ
	UCNJrwJ0AbGyR0kTGVsgB4+ef7972O5JY8CO6rK3Lw5T5YSZtCu0KfJ6FqImua+RVHLWtsUPsb4
	pWKjKNpuDbW+q7l1oT1eWQzMC5ApkDzf0NjFuNV4XBRtUjHn/+hJLUCFnqam7zWhiNE+lLTvy1T
	/3XaM6XZXKEaj5h7YI=
X-Gm-Gg: ASbGncslGCgE1EOJD8H4k9hGbyK/m2iPwq+AZ//uwASTlmG/5AsVzLFWxHkrKvN37qY
	ce7p22fCOxmmIUnCAyEU21x3f5Qcu2R2ydHoLPq6Mu5xgNKBlzykVRoi2wn1RJyTfqD0FA28ZaO
	FZOa2ZsBGgG9mpfUmR37V1hvGZEZ26G69NBsU8oX+S79dWsaEEwTg1WaeFd5vfRATIpHpmfT1fH
	XxD7ZfjLWbwR2eA7ECpL/j9PKjaDxrL82FzfyLtVqCih/dhX5tQ7Vm7kKu9Km1y5Nu65HAZciKr
	Zrf2Xv+lxi2VAcWJhuwFSAYj/b2qD5TeWGBXfuN4G08vzmB+zDuAAoHtJiD8j+SAKspH/rtj/PN
	qMATxCYCPRMudq0yL4Fr91CVNY/8yAxTc08+6/he12MPi5dMJ5A7pvzjxX6X7ssrcQ2EcAOwt/Q
	E3naI+Ns4KR00dUfJP0ep5wsVzek1q+RQ=
X-Google-Smtp-Source: AGHT+IGH6lOI2ts0P2unOg7QuOSlv5jj0XUTbCSMURU40UOWY/qzud5wETsuS5cuKkWA6PhSVSpzlfGTMDTD
X-Received: by 2002:a17:90b:4b44:b0:33d:a6a6:2e26 with SMTP id 98e67ed59e1d1-33e9120495amr1390497a91.13.1761131234358;
        Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-33e22421a2esm215116a91.7.2025.10.22.04.07.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909a67aed4so7301895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761131232; x=1761736032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA9Oy21XPeXmPlSwKvLYBk2PQ/Fy4Lvp8jR4DRUe+f8=;
        b=Zgka9XoA3l7OIOI4OLkeZJH/Na1b5BVlHCBcQKLDnck1NIcLbIgzmR4MS5Zsj+0dh4
         819h9Cndr3YHJXCOM+934lRz0i7Ii2UVHfAPWcPSSGwax/PJisvYJDxCIcfvosSEdnyP
         oLEstaS+13AgAX1EL4M+QDJcuvm8PNY9+8uWQ=
X-Forwarded-Encrypted: i=1; AJvYcCV2fkSdpZtwTrEduARA2ZUV5nzKLh3DQj8RofzPxocqwB8b2TJtVqBa9lyrY/knJL4Yn9kOjzuU0mUiRps=@vger.kernel.org
X-Received: by 2002:a17:902:f690:b0:28e:873d:8a with SMTP id d9443c01a7336-292ffc0ab76mr41334025ad.15.1761131232541;
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
X-Received: by 2002:a17:902:f690:b0:28e:873d:8a with SMTP id d9443c01a7336-292ffc0ab76mr41333645ad.15.1761131232122;
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm135964955ad.52.2025.10.22.04.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:07:11 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: kuba@kernel.org,
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
	vadim.fedorenko@linux.dev,
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
Subject: [PATCH v2 1/2] ptp/ptp_vmw: Implement PTP clock adjustments ops
Date: Wed, 22 Oct 2025 10:51:27 +0000
Message-Id: <20251022105128.3679902-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
References: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
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
 drivers/ptp/ptp_vmw.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 20ab05c4d..7d117eee4 100644
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
@@ -16,20 +17,36 @@
 
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
 
-static int ptp_vmw_pclk_read(u64 *ns)
+static int ptp_vmw_pclk_read(int cmd, u64 *ns)
 {
 	u32 ret, nsec_hi, nsec_lo;
 
-	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
-				&nsec_hi, &nsec_lo);
+	ret = vmware_hypercall3(cmd, 0, &nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
-	return ret;
+
+	return ret != 0 ? -EIO : 0;
+}
+
+static int ptp_vmw_pclk_write(int cmd, u64 in)
+{
+	u32 ret, unused;
+
+	ret = vmware_hypercall5(cmd, 0, 0, in >> 32, in & 0xffffffff,
+				&unused);
+
+	return ret != 0 ? -EIO : 0;
 }
 
 /*
@@ -38,19 +55,19 @@ static int ptp_vmw_pclk_read(u64 *ns)
 
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
 {
 	u64 ns;
 
-	if (ptp_vmw_pclk_read(&ns) != 0)
+	if (ptp_vmw_pclk_read(VMWARE_CMD_PCLK_GETTIME, &ns) != 0)
 		return -EIO;
 	*ts = ns_to_timespec64(ns);
 	return 0;
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


