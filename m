Return-Path: <linux-kernel+bounces-871926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63BFC0ED81
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23358464880
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385A2EDD76;
	Mon, 27 Oct 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9P7A7SE"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDE2EC096
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577505; cv=none; b=gMSWr+a9jvjrJ2StZ4G4Mbv+s1Pyw71SI66jLxkdixrCZnPg6vK2JO5CIPVF1rPDXaRNXnriwGz18at2sXcZZidBAg3+b9sBxtSqsRZN2vtAzQJ3J4kV71CEqVNR3/dfK7fBKY2Jsx0JqAtHAA8QY58iniONTHLClNE5wnootcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577505; c=relaxed/simple;
	bh=T6j5pJIXxBFsaGqyk9NT2RfkOVr+/me2qdWz0yBnXMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSpRBImkuJrpIFh+dG5YqP1MEONJDL1+Gcsh4juUp97Pj0cXkfuOc2SL1r8Xm34Ex3DxK3Tsg/mFlt9b8SzslO0kUemWlqojmleBFDr9GfSP7ObYnkl6q3a5qCk6B87Gn79voHGFPUe/kAHmOshn2/BJNu62yo9/k1vR0DE+/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9P7A7SE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e0798so68488985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577503; x=1762182303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTupaOgzH6gbHMiWqxU5N/avQRrB+TsM9DGFdEjR8ho=;
        b=G9P7A7SE0cYKcuVk8MuBwcRcI74Kjl6yzR2cI8MhocDmNulu+Blaqelp6KgoHbWxwd
         t9rYTdRhIHyK6aOGUHGhOMHNx5T6Y81wndqXyjJzh1/UqPAI7Iuy6LRwc5sVvCgrrcYT
         Gq0Z9o7x61LaU28+avucYFU3C66Y2Mo165wSpT4RflfEKbZbc1iwyk8d+42cjp0YEJNB
         fI2UEMxUNKqvCoVDCBaKZ/61wftDhyd8sDtxcHtxBcv4OsBpIHjtW7fl35QzaJ51PVvk
         qg/4MpzUX3zBaHBRB7GESPKtRHWZyAB271XnUW2zuBEnJbtccpKBDJCzW4UTvxIzLKmt
         hsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577503; x=1762182303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTupaOgzH6gbHMiWqxU5N/avQRrB+TsM9DGFdEjR8ho=;
        b=l9P6GuYv9VZNlJCK4WyR0CuhSJPWR7lQk/L2/RTO86MK8oEteT5PBKB5a97IqhiEbT
         ss/zwoXA78oUcg7F7fE67aNpCfsNJjpPL+PRIl9TSabmEhy9xvbIFXcgnhNzWyYLkJLP
         jvDx5P1fcEquMxQ8k8HyRVKzq4OBCwmDEdgjxe0G0wlOY2mhJ46xf0koKr8xwbzVQMC0
         ZlmK5P6hH+YQ9o4wBygtYTxaU9nHH0IY1t0hczOoneK2K9irxzeNetwVcALXj/mv5y2X
         QlkiPGIG2nQf1B6+c+ZAkFNlSURkBVEAFRGrjpImWYlnRBuf4mAic9op3lez+TUAY8oX
         RPDg==
X-Forwarded-Encrypted: i=1; AJvYcCX+fMiKx98K0gC4u3PQGyK14tXUW47un9Na8ueA3ANfzEVd0neIg2rv1RTb/EdBva0EMIgRt/S3LRKZjTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ivs4WEP7bw/pZxiVhM9kQfYPhLb7WDZ2wsdXsfrPEPQwb7eJ
	CxPiduT1EheDVfRfI2igT40sw91/BAALa858HDh9xvg0E5ejQ2g24/gK
X-Gm-Gg: ASbGncuW8bVrQjHeYRFD9qpD3uC3lZX/j10bXwHRFbvJs3dj+8/NBcznMHRw03BrxY/
	UfmDqtgR4h7uYisnauN26+6YZHbR18MTalQTtfOnTgv3IusYTz1xrPvXFJkSKikrXoi4WBRduLL
	icMCBGktMSNxqeY/7SZwdW3WbE4CDXusIttEy8kSKY7xtFDBzbMOdrV5xt8Qqjkuey8JAz/NMEg
	T4VkfYza7EZQRsbzXod+56z4lA/gLOtYzr5Tmek8YwLWRRH/pE27q33yXXNGecIpjdQkROFkp7T
	SRcr89mDI2NEb9SzPzmAX3/o08M/vOD5bZQCImCIc3Q1zLgXgtDRkTvUX1bhLf3/6Kr+U8zI0vy
	tS2X17XVKojJLIJSKGzpyDnZnlTZwSfYxkosidB9jrb0zcdRqAGP/KgVBDWbgZXqkAmPKrMNugV
	4hcaJ9CrFduC2+Nk8k1QO2YzRMkrxPVzvD
X-Google-Smtp-Source: AGHT+IHo5ASx3suVa6f8wqaFBDyQtbbs8qUYAB4N9R32si782j8k4P1cTG8u6ANyizohrN8+sMLTeg==
X-Received: by 2002:a17:902:eccc:b0:27e:f07c:8413 with SMTP id d9443c01a7336-294cb378960mr2882435ad.9.1761577502931;
        Mon, 27 Oct 2025 08:05:02 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d273a2sm84808825ad.60.2025.10.27.08.05.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:05:02 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: nforce2: fix reference count leak in nforce2
Date: Mon, 27 Oct 2025 23:04:45 +0800
Message-Id: <20251027150447.58433-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two reference count leaks in this driver:

1. In nforce2_fsb_read(): pci_get_subsys() increases the reference count
   of the PCI device, but pci_dev_put() is never called to release it,
   thus leaking the reference.

2. In nforce2_detect_chipset(): pci_get_subsys() gets a reference to the
   nforce2_dev which is stored in a global variable, but the reference
   is never released when the module is unloaded.

Fix both by:
- Adding pci_dev_put(nforce2_sub5) in nforce2_fsb_read() after reading
  the configuration.
- Adding pci_dev_put(nforce2_dev) in nforce2_exit() to release the
  global device reference.

Found via static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index fedad1081973..fbbbe501cf2d 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -145,6 +145,8 @@ static unsigned int nforce2_fsb_read(int bootfsb)
 	pci_read_config_dword(nforce2_sub5, NFORCE2_BOOTFSB, &fsb);
 	fsb /= 1000000;
 
+	pci_dev_put(nforce2_sub5);
+
 	/* Check if PLL register is already set */
 	pci_read_config_byte(nforce2_dev, NFORCE2_PLLENABLE, (u8 *)&temp);
 
@@ -426,6 +428,7 @@ static int __init nforce2_init(void)
 static void __exit nforce2_exit(void)
 {
 	cpufreq_unregister_driver(&nforce2_driver);
+	pci_dev_put(nforce2_dev);
 }
 
 module_init(nforce2_init);
-- 
2.39.5 (Apple Git-154)


