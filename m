Return-Path: <linux-kernel+bounces-779616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EFFB2F63D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D08B4E2873
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04B30EF7A;
	Thu, 21 Aug 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xpmqm9gX"
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE030E847
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775011; cv=none; b=OHgl2z5B5DktUK0qxrY0D9RcT9qk+JwAPUxmQ8MSWAHcwJA2Z0c7yfVvBotJ7rsi1aRubynetQ0sEQLBfRXuDG2pk0jA2hAu2h+3pMGx8bNx5C21Q6ckdE7gOrqwNVuxjdlGmfwRxJF5fhLmM0RcpAFgHiB2Iwn5BCoCxhXjyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775011; c=relaxed/simple;
	bh=cHuqB43g+O16/Z3CpSQ3oQ/XdPfNvLQgDSdfExkjhI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAKCO9VX9johYWiYMR+lh2xEp/tME2fKi0O9CElvTAuvoXi4cODd/Vmsr8/4flcgwKopJ8fNG7QlarWXdUSB+Z11PRrDlDNjXmGj8rH9MkMhp2df1lruzEWTWVNQUPnRchi4ThWjMqBffkLET+f5KPz21HdTibcpljANfTVIDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xpmqm9gX; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b4746fd4793so711783a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775009; x=1756379809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTOBCmTJeaSpol9K63NxFX5d4RT5ariDJfta1AzP468=;
        b=ee5YrlWGsgFe/GCEntprEUYwC2MRxp7q/riyYkkaLWf8xmJWekVSlPBerAVs+gawKr
         iiDJV4qjf+C1BDdIbC8S4Goc5XDxfj1IhcXTyBENeciTGgV10FHqj2QRMYulbcOZlAQt
         k6an0kar/laZ5quugyIMJTLaPXftx0yRb6aOV3nkAkPLwelGuJwZbbUxf6wSaUaTN1YH
         /NwzvcUQyn5lSFTx0bQ/N59XPjXKeL0V76MHWRv/lYFwnljFAeSJDrXoR6YmlRw67Btx
         5kWxVuO7eysOBNJvAn6F0NU+6UOSMMBXqmUZFDISG4C4RKEtteMHEK0hKx9b3eOt1P07
         IQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUdewUwyx62D1KmywUydA6Y5BMkd41Fia9fWgC6evNa3j/BBsjKq+CVGRwlAEEsO/z784h4c+5LiQGp8n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqN629DGb1qsWy2dtq9onGDH5Nmi97cVoNWeac2qIclIubTfU
	P3HIXZOOtx6oUh4Q3IMHItxaeA5URO0a43WUN7asTFxzL6aXqWFLjOhCNuNbEMQviWVTaCLaBwl
	foPSEBlkhyp6KOFUhYjeEf0O+sKNSFNKVxRoAzAAN/LDG/zsmF+V8k1aB8H6gW8yG8x200J/PVK
	W0m3ak+rbbILgnficTyGuU+nWtba+YxZbtdqbfpq0QSIKplROdEOfEUbtYAnCqxrL8zeJOQxaqA
	8KR9rw0Bo/gL6dBvZM=
X-Gm-Gg: ASbGncuAdiccVdg2AmUsuWiY0F7iZGWn7up1tCaK+Nq+xFYRxoJ1QK1FQYaPfSC1fy6
	t4nqARD8UB1HEfG4uKHIQGWHK9RjvgRFjHBvTobBsncCxlHturcnJbOhwv8OGuQk2HCWz/T0PQc
	C75pcBRO/hjqRWM/GL+RVRTJuXl050gnniTuy05SHxM+kxkZKgopUAyqrwf9p8j7MwKhV/ncxpH
	zzvHelo5Jp9EJq8zJBBuz2z5EAHb8MinHlL4f46npsBA+HAEOkVPx/Hi4n9ILOJ03PRCL2eVuW0
	y7KWwg34w9iLNbxqCvq7GvsM65sjEmXuhanUcriR3WlON3S0v6Z5HLsFQA6LCSv4nXA2g2mmPIT
	fawmVEfqhwygsYNhIT0QyehmKikH1Cg4Vt0LUX29m8qK5m5lToR1KO584Jji8y/V78xt+dbye0p
	U=
X-Google-Smtp-Source: AGHT+IFuXWv7eyFO8lZUthP21H3/UCIp+lxt/4KQ6t851H4rSBmDJBYLhEBsz5zcvSTl9neAXkh7fFXuohvs
X-Received: by 2002:a17:903:40cb:b0:243:485:26a5 with SMTP id d9443c01a7336-245fedb05f9mr26071615ad.34.1755775009573;
        Thu, 21 Aug 2025 04:16:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed34f4b1sm4673905ad.28.2025.08.21.04.16.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 04:16:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-246164c4743so5947685ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755775008; x=1756379808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTOBCmTJeaSpol9K63NxFX5d4RT5ariDJfta1AzP468=;
        b=Xpmqm9gX+6+efijMHItIEUdD9wOrNjLHt0E95+lEzcr994KX+MaR1X751iu6YAnTK+
         1jkzmmmQMOC4RNJ8QiutVgUJtl8WEyq5Y6K/1cL1ujAD8rEeyGYi6ZxH+Kyp17/fcvX6
         HhL5+b1ORA3/LiP74CL3eCYT2/cU/C6OZbDUI=
X-Forwarded-Encrypted: i=1; AJvYcCW/RxUnQePLYIKnL3W57eZP9SUY+Ko193F+Z6kZOs60aCqH0vhyU+r9dNl0Tz5fqyVh8C0aqdbKOf3iJSc=@vger.kernel.org
X-Received: by 2002:a17:903:1250:b0:240:1831:eeeb with SMTP id d9443c01a7336-245fedd06c6mr32499885ad.40.1755775007722;
        Thu, 21 Aug 2025 04:16:47 -0700 (PDT)
X-Received: by 2002:a17:903:1250:b0:240:1831:eeeb with SMTP id d9443c01a7336-245fedd06c6mr32499515ad.40.1755775007278;
        Thu, 21 Aug 2025 04:16:47 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245fd335ea1sm21363285ad.110.2025.08.21.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:16:47 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
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
Subject: [PATCH 1/2] ptp/ptp_vmw: Implement PTP clock adjustments ops
Date: Thu, 21 Aug 2025 11:03:22 +0000
Message-Id: <20250821110323.974367-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20250821110323.974367-1-ajay.kaher@broadcom.com>
References: <20250821110323.974367-1-ajay.kaher@broadcom.com>
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
index 20ab05c4d..a18ba729e 100644
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


