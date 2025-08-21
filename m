Return-Path: <linux-kernel+bounces-779617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE1B2F668
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2133A7552
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F40030F544;
	Thu, 21 Aug 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DjsVb16g"
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180992EAD13
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775022; cv=none; b=u1L+t+0KjZrh4FoJ86lCGTW6gEJPM3qHh0x5PVL43cJTlSke3AOrmc4AdpDRwDQhv5ouo21f1eXNFvOjyMibC4dGu8eCYiQjJISFKEumwXEruxLmuXm0j2gG0ncfkqXqlBqZlWUH7zdXDIqRJXH10RMgSDFmratSX4gg0Eh1qEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775022; c=relaxed/simple;
	bh=Mh0jYCcl2AsQYiir7/eSo4Eodqp1ipzQ+9QF7J/Shn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jj73PEX4bs2oIbVrSrjxu210tHYZNVJtqa0mYsk0PlGuJmvKXhl++kyrFOyYN+mdmGOETLhdyueAvvzrcdQfM9+1AszhrViHzq0oBNJtqq5OfDlX84+9tN08yI7Uz4v8Ub386/h5j+m4i0QwSW7bSkniS5rYB7V1GPtEDmF1oUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DjsVb16g; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-71d5fb5e34cso8891407b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775020; x=1756379820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdQolOKpYG6UAB2piGu+oICeMfmzrvTtBrOxQYX6H6w=;
        b=tQLGMATZpf8IhUio5hXfQWk4E1SZnUdPh/uxywemqClBJGSb/2bLPQc3c+93gSay1o
         TSSiqfr1i/X9w5uWH1tjBR7MNrvVRBZ9vCdDJ6NXsNIiccl70OQeLyBz2InxJkgeWTnM
         ZnhsXXMu1j9SgVDDkwkaCR61Fbz8iVtRwGlIQV3+KWdmQDrdR0iHTLRYSS5KIWrKOTmB
         5jcjQ++xXsbBmHa2YZ4RGtI6/u/Fu8oVfdxsyP5bPng4MHsE5bc6y98caUbzLgn12FmN
         KgmB9jJdUG+kC68g1F9WoBgESijhnyxOAtkBMMPQerD/4dIkn3zBd3KX9EWAHlHrILMM
         3s4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3egeZ7eczOKiLWmjoGIt4mKQPMAyW1Fj0bFr/Ki3hWU66e4eRrpZg38gkPXOr5Eo7T598iCuULBSLu2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1d5+MuJADORDnDAh+5YKn8/W2qOgbk4ghTCZIJzx+7nRatOjD
	4fuwH6HgMm5kqQaHthe8axDDRTaVxs1cbY+T+pcDmYU4J0aKaJNd9l41HoeRKIQ9KxsP1bAsqR4
	p2DW2yN2CHaD8DxfiucJYdsHZt6SKdL5HqmzGd7eSHFmke9FiLqZqIyX3xwG1at99nm1v494nXM
	tBeQnb/ZotnKHqwcTs3Uu6oTJiXkg9mE0bU19LUHOfzEvSnfmLHujY9BUvbnP5GP+1WKrnxJyKt
	rC81hJQFWN0ZEE7nao=
X-Gm-Gg: ASbGnctmXM90Hv/lJj2mfY2RlV2VLchWAZZJpr0zb5a7VzCt4Khj6fyFhRaiGLVsq6r
	DJVZOcZtr0ovyFIT7SxPUwZueBvziusRbZGYEMr6N3wmTFY8+Djt0fFzuQayDJxW9nGfvm15wGb
	fLRkzTfWTXDBBNtwjnZjCzSdi5My7V6moUkjKOcLcEPlD3IAGCRAFpGvZ9yFVSqhPmGUGChbqpu
	qIMQwvAQlNBABhc5cMeTDy8u9OXIiAI2otvyU1Az+TyAVs4vTr0vvaZbKeOkIvNtq+EhTlE6xfH
	7fzUQCb1+64ZK17gq0HzQg32541kUy8roYuaxvL734YhL0wVQi8zy9Z/NDs7llohtNX//WMDfj5
	/pwiCWfYo2AknvDVwY5Ug14fB1QAtic+G9Sv8iRtg5xKJviVRmvzsGVFPCqUTahHAMPkKiSk+
X-Google-Smtp-Source: AGHT+IE2dQ7dp3OzipXuP6Pa47y6vBQwZ8QmpGefRTF0qw2jJGg2x+FM1CDxdooPua/89YD3L7OM5GQj2w8h
X-Received: by 2002:a05:690c:370a:b0:71f:9a36:d336 with SMTP id 00721157ae682-71fc9fb83c0mr19463987b3.25.1755775019888;
        Thu, 21 Aug 2025 04:16:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71e6e1fa880sm12036287b3.41.2025.08.21.04.16.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 04:16:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24456ebed7bso11679165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755775018; x=1756379818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdQolOKpYG6UAB2piGu+oICeMfmzrvTtBrOxQYX6H6w=;
        b=DjsVb16gVl68O2SQ+zjZM40PwF2m9J1VScXtEQ2Ha4k1qsF68Jb5/apgu13+5bALAG
         mnD6OO6d3mpGK2pINcFhKghFNMGDbeCfbSwAE49HORH67/on+DUGZ0QUbBNdKfQC4Stj
         hMZNDJWqLvwZxRr+/9jj+1d0Q9/imQBiXLkeA=
X-Forwarded-Encrypted: i=1; AJvYcCXRvoi8AR6KIuZKu5e9IB6OtzEbxvRUyDBKFxaF+lJrnqPW68nls7yxPiylS9zZ1HONBVpjX13J92Fd0oY=@vger.kernel.org
X-Received: by 2002:a17:903:2448:b0:246:571:4b51 with SMTP id d9443c01a7336-246066025a9mr26676635ad.29.1755775018506;
        Thu, 21 Aug 2025 04:16:58 -0700 (PDT)
X-Received: by 2002:a17:903:2448:b0:246:571:4b51 with SMTP id d9443c01a7336-246066025a9mr26676165ad.29.1755775017689;
        Thu, 21 Aug 2025 04:16:57 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245fd335ea1sm21363285ad.110.2025.08.21.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:16:57 -0700 (PDT)
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
Subject: [PATCH 2/2] ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
Date: Thu, 21 Aug 2025 11:03:23 +0000
Message-Id: <20250821110323.974367-3-ajay.kaher@broadcom.com>
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

For scenerios when ACPI is disabled, allow ptp_vmw driver to be
loaded by directly probing for the device using VMware hypercalls.

VMware precision clock virtual device is exposed as a platform ACPI
device in its virtual chipset hardware. Its driver - ptp_vmw - is
registered with the ACPI bus for discovery and binding. On systems
where ACPI is disabled, such as virtual machines optimized for fast
boot times, this means that the device is not discoverable and cannot
be loaded. Since the device operations are performed via VMware
hypercalls, the ACPI sub-system can be by-passed and manually loaded.

Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
Cc: Nick Shi <nick.shi@broadcom.com>
Tested-by: Karen Wang <karen.wang@broadcom.com>
Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/ptp/ptp_vmw.c | 71 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index a18ba729e..ce44b12ce 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -98,25 +98,41 @@ static struct ptp_clock_info ptp_vmw_clock_info = {
 	.enable		= ptp_vmw_enable,
 };
 
+static int ptp_vmw_clock_register(void)
+{
+	ptp_vmw_clock = ptp_clock_register(&ptp_vmw_clock_info, NULL);
+	if (IS_ERR(ptp_vmw_clock)) {
+		pr_err("ptp_vmw: Failed to register ptp clock\n");
+		return PTR_ERR(ptp_vmw_clock);
+	}
+	pr_debug("ptp_vmw: ptp clock registered\n");
+	return 0;
+}
+
+static void ptp_vmw_clock_unregister(void)
+{
+	ptp_clock_unregister(ptp_vmw_clock);
+	ptp_vmw_clock = NULL;
+	pr_debug("ptp_vmw: ptp clock unregistered\n");
+}
+
 /*
  * ACPI driver ops for VMware "precision clock" virtual device.
  */
 
 static int ptp_vmw_acpi_add(struct acpi_device *device)
 {
-	ptp_vmw_clock = ptp_clock_register(&ptp_vmw_clock_info, NULL);
-	if (IS_ERR(ptp_vmw_clock)) {
-		pr_err("failed to register ptp clock\n");
-		return PTR_ERR(ptp_vmw_clock);
-	}
+	int ret = ptp_vmw_clock_register();
 
-	ptp_vmw_acpi_device = device;
-	return 0;
+	if (ret == 0)
+		ptp_vmw_acpi_device = device;
+	return ret;
 }
 
 static void ptp_vmw_acpi_remove(struct acpi_device *device)
 {
-	ptp_clock_unregister(ptp_vmw_clock);
+	ptp_vmw_clock_unregister();
+	ptp_vmw_acpi_device = NULL;
 }
 
 static const struct acpi_device_id ptp_vmw_acpi_device_ids[] = {
@@ -135,16 +151,47 @@ static struct acpi_driver ptp_vmw_acpi_driver = {
 	},
 };
 
+/*
+ * Probe existence of device by poking at a command. If successful,
+ * register as a PTP clock. This is a fallback option for when ACPI
+ * is not available.
+ */
+static int ptp_vmw_probe(void)
+{
+	u64 ns;
+
+	return ptp_vmw_pclk_read(VMWARE_CMD_PCLK_GETTIME, &ns);
+}
+
 static int __init ptp_vmw_init(void)
 {
-	if (x86_hyper_type != X86_HYPER_VMWARE)
-		return -1;
-	return acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+
+	int error = -ENODEV;
+
+	if (x86_hyper_type != X86_HYPER_VMWARE) {
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (!acpi_disabled) {
+		error = acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+		if (!error)
+			goto out;
+	}
+
+	if (!ptp_vmw_probe())
+		error = ptp_vmw_clock_register();
+
+out:
+	return error;
 }
 
 static void __exit ptp_vmw_exit(void)
 {
-	acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+	if (!acpi_disabled && ptp_vmw_acpi_device)
+		acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+	else if (ptp_vmw_clock)
+		ptp_vmw_clock_unregister();
 }
 
 module_init(ptp_vmw_init);
-- 
2.40.4


