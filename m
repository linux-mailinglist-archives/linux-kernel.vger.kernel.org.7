Return-Path: <linux-kernel+bounces-870200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38538C0A2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337983B3153
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929922FE0A;
	Sun, 26 Oct 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvTBLq4d"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F31262FCB
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453854; cv=none; b=o8KNHr9RJnKVkHGbiF95lsLmX+RXoT1WHdp8lwZUT8lrSfKRueqgsuN2dbxgN870Ndyd+rP0O7QcVa8Vgc7HnsUHjCXmgFECTQfW43hgDGFbvR0EsYm2YFuzx1ZrN3uILk9VczvJqEPdfzuZH8+qaRAveW8uF6WOu3UvIEOZM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453854; c=relaxed/simple;
	bh=w4Q+yHhJBasAdeSXBOcO67FD8hR5fmC9dO9uLZoDllg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl5h2VJYlcblGKA6kK2bZ+q1UUTJ9vVfgQ1ACBtsGJS2c/5Sk5IYcYq30kBOIp6UdVWpW4oml1lQzBF5fq2K3KpHfcJtypzvIiZh7GnPI0/0axYpvDjcUAGmJgtraU9c6at1BBG66lx23v4hwfhjhjVd25uotOB4ofTVsVuDUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvTBLq4d; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so3785558a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453852; x=1762058652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX0ni6H4pbjiWrv/AnHeK1axe/PVUJRTQ2U0GTGwYuk=;
        b=IvTBLq4djabjUfXBykrwlBeQWgEupiQzR/GgeVIx0y8nBaXI525RrJwN9f0/V4jIte
         jHHK56ACso13tnNQK17eQAM55c1KgIQdoQI2HrCx62j6AM3Yw0bn0QoNQCN/mtJpMOT0
         zUcHog+/5bJH/HM4XpvzUAqVFblMn6RpyevZ4sXKU1fYyOh5TM2D+WFwjGNVcGtoI7Tc
         +FW3uRxIZMPn/5ELL8GfUZzcQt3V3DH/X1uii1/PcXay4LmoOmjGtLFqhSPU5gDgs0KT
         mbn836jNDeT6vq4J3WbKimnAGxQGOPDNmDQvzrIYKKm+R5cEdfBYaKISNKT57NC4J1fF
         LDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453852; x=1762058652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX0ni6H4pbjiWrv/AnHeK1axe/PVUJRTQ2U0GTGwYuk=;
        b=M30ClH37umGvnCnwfkBEos8c1psT0thcplBOPmc6eJuxHn95exzGng6P7+Nx8ef7TU
         TzMDhvtaxECGW7N6T9pU7MMtsIDGgZAC7CR9BNg1Stpus0bFtYEzBX7YP5CaC6SfYOqb
         xL7WEYLMxVrG4VKcm0/XlwykytkPa3SCsbIXBJyg4cd+hct5GiTK4vVhnHLWfWYPWCdt
         w3tyKqtJmC6ysYjLxr7f8OohZbxaR94aAVG0ZIPj7Eo+INkRkVTpxBQ12pQgvUi1amoo
         IncvutiJYP5lGbRTq6jRMQtu4l6FSgnq3E5vz+482jEmmuE8GTI7XGp0WTJy/LXeVKkQ
         SCZA==
X-Forwarded-Encrypted: i=1; AJvYcCX3+BB2NkQahx3IbC9LMAxBjPaf3r8nfYL1gPXY+idQjl992KYeIUOaa0UCbPn4zGpyAQYEA0skNqv/ZZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqHNpPDVMUOfcJgkSxjCmVduZQz/p+n+FtvyjxbiG3NCnf3Vv
	RroMNLXtXRF0T1SkIfBz7++exzclbDrGfbSSGqIzvIp2mwqzOgWTLHBd
X-Gm-Gg: ASbGncsjl3+5bMmmXlQrSRtOBD6aA2ty7sQQ0NQcf4dseZBMSYwxNtIKsGHtGWqAyBW
	oWREPKPZenW+hXzqRFXGouheXuP4xPyh7e/h+cBPVZ2MVoBJL4183nFJr6CTEyIL5hneWje8wvv
	bSfSfKJKhqa0eDsXaPh/NAGzVfCQRrQocAf6b+SQK21JA8HmC2SSIB8V/gxKSPpljlKHGThI5pP
	S/jZn9SieyyBoGab/nsUXF/kp1qJz37uFT3F11WMYeSvL0QS9ClnJuzJEYtbmEWKHaCQJ1rGbdO
	Gi4DihbZ1JWbU9/JeWUTo5xOiDYKPj5xXGIFd7bDEk3M5MPDnJKVufYOOdpxhN53717SZjPGO50
	mVoZoTzfuxAS1JpUBcLH3Bh0BdEaDOwjn17a4KeEpHoBnp3AWI4vaXAK+aXfF142cPaN9K9z7Vq
	rh4UanJ6dySUoGrKqdYWgsBQs4SJPqOGqv4jCUPuP9knDSAC6pAg==
X-Google-Smtp-Source: AGHT+IFUy9nDaJV51/d03ANfLAhw0sYIOgZYfK93VgsR+kv1D2t1kjboFjQQXoUpP81vgHZLi1rddQ==
X-Received: by 2002:a17:903:187:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-29489e050e4mr101688115ad.17.1761453852259;
        Sat, 25 Oct 2025 21:44:12 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:44:12 -0700 (PDT)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v3 2/2] PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
Date: Sun, 26 Oct 2025 04:43:35 +0000
Message-ID: <20251026044335.19049-4-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After misc_deregister and restoring PCI bus ops, there can be no further
users accessing the einjected list. The list items are therefore safely
freed without taking the lock.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c8d65bfb10ff..a064fa2acb94 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -523,7 +523,6 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
 	misc_deregister(&aer_inject_device);
@@ -533,12 +532,10 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0


