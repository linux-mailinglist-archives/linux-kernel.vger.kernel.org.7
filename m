Return-Path: <linux-kernel+bounces-747643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21051B1364D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E6B188A639
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2223535A;
	Mon, 28 Jul 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dn1p5S1+"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89792E36E6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691047; cv=none; b=DONqBz4ibDIso0kxIUKJWrc/QrzAhWPQmjz1jv2iKAp7UurgpumReiJWHOm+G/mGuJh2By2WVZPee5STZXOzTAEJn23V0fNew/nLzsIs3zj4bWYrCjcK2Pgex34PIMpuRrgC1Zy3TYS52SIWmgmiStsJ9f4fR19J0yRDGVvDGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691047; c=relaxed/simple;
	bh=nV4/PTmUEYP9KwMf532+qDjUVUN0GHVZDZLIsvcU80w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s9qqQakf1/qF+UTqH0mDxCBOEKekLpSnwL2cdhlMlDgFjz9GcVi7LoGTgnGiKgeiLPG5+vQAVcnbzBLzy+MWUFlWZohu+NoxNN8OddnSNVjHJ0T6zjR1Pxavqm/GfkOSKdJQBj+MJCTSyBNaxdzYoSBOfMEuYG11qEBUA9BkPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dn1p5S1+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7074bad055eso2215126d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753691045; x=1754295845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aS8c0DmZhV/h10pO2Kk++8G/v4lwXvV7Mu1YBRRf+B8=;
        b=dn1p5S1+ho/aTvhjiloNb5cICGlRS/ln8LntU9/7fZPfyBFxSa/URrSxj5Ezni40gK
         8l8SVy6UmG+9bfUX81Aa3egxqesA6d9OXO9iB6y7W/uoOK8WwT5D2yGatGFTg48pX27s
         4OcaybDgJpt68fJqZ19SqIW86DwmU7wpF5Nzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753691045; x=1754295845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS8c0DmZhV/h10pO2Kk++8G/v4lwXvV7Mu1YBRRf+B8=;
        b=JcEhjAXyW98zfn3ueXHK6KxGpzYmmoBsIdpQX6mEZgwUuOVsr2bKxM3oZkc3+6NoiW
         ao09DvGQzG/wAU3YzZW4XjmiKYVulFW0g6WhTCa8+Zco1FRts72eXelxwAemSrQXcX4J
         v8ek8WfOUWkm4Q//+4sK9h/ub4ZdxreeixsIqW5llGzEc/ZImTTnTQp0/4ngOiPa2IHq
         ttDmihB7yzo7xziLbS7TROxfIYW0kOZcq0xIt/E3vZY0kvSquaq3GIiflZc7n1KphAGD
         M4sI82DES8BxzI158Ya1UbQ+SIBbfE4+uFyi6R8PaEVqBBN/miEOFFCF7oEosHlFirsT
         9mZw==
X-Forwarded-Encrypted: i=1; AJvYcCXbfhRSPfUok2rr8dsSgfOnS1v/Md3cU81jTJ1tvQlFA/wrBU8gyoN3idZXe3PploCOpqFQBL76ftkz0CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYx5xjM5lcxFPcdSmWSyTHiBfIJj2Fh78VMhy2De7bWF7ckm9
	ef0ukaHhIJ+j+U1afHVaxy5AuCzYxmJB37OylWab9197JRlMGqHfP6sJugOYALsoVQ==
X-Gm-Gg: ASbGncuwiRs11Ul3SvU6TA17KNDUmaXiPCVtR38GQDqvvrSRryzb1+lElXuVxQ1YhVf
	u6TuzN6bRHcRlCUHnSyee99+QzmWjQJtjmSb65ZX6wDW8i8gYkvJVDWAQKiSevwiWS/DF4iqsdS
	FwDCvnnRFcrpoYBDGnwkJcyPpOCr2LBVN5d/PeizAxEB2yi3IdpjUzy4UCRHfj3+x5653ylkihw
	/F6xhyVxRrRj3UtwhPxUxc0gzjzellVzHTeiARbr9hgHImvksgvmXfaXwqU4fP3YQU/2Vj6MQCh
	NRccYtFvjkpVvbX/sYvhxMxD5+MTgd8LvpZ1kFLL2PpdPhwHi6crdO3Udm11GU3HNmoMZK1lUzC
	959HB2IpExD/qIePeO5VPMXxTba16HFYWw92nTRmQJNJbjycZO8tBTbDj0xl/24yDyDB4CFOVt2
	k=
X-Google-Smtp-Source: AGHT+IEd9Qtbq/Axeuxm78yPvalIEBxFUnS73+vOHypPFZ6GDCTmnUWa4pzwHujXD4fPbZeOJA0urQ==
X-Received: by 2002:ad4:5de9:0:b0:704:f94e:b5d6 with SMTP id 6a1803df08f44-707205e99f1mr163132936d6.46.1753691044726;
        Mon, 28 Jul 2025 01:24:04 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff0f1sm27786876d6.9.2025.07.28.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:24:04 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vdronov@redhat.com,
	netdev@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>,
	Hulk Robot <hulkci@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] ptp: Fix possible memory leak in ptp_clock_register()
Date: Mon, 28 Jul 2025 01:11:21 -0700
Message-Id: <20250728081121.95098-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 4225fea1cb28370086e17e82c0f69bec2779dca0 ]

I got memory leak as follows when doing fault injection test:

unreferenced object 0xffff88800906c618 (size 8):
  comm "i2c-idt82p33931", pid 4421, jiffies 4294948083 (age 13.188s)
  hex dump (first 8 bytes):
    70 74 70 30 00 00 00 00                          ptp0....
  backtrace:
    [<00000000312ed458>] __kmalloc_track_caller+0x19f/0x3a0
    [<0000000079f6e2ff>] kvasprintf+0xb5/0x150
    [<0000000026aae54f>] kvasprintf_const+0x60/0x190
    [<00000000f323a5f7>] kobject_set_name_vargs+0x56/0x150
    [<000000004e35abdd>] dev_set_name+0xc0/0x100
    [<00000000f20cfe25>] ptp_clock_register+0x9f4/0xd30 [ptp]
    [<000000008bb9f0de>] idt82p33_probe.cold+0x8b6/0x1561 [ptp_idt82p33]

When posix_clock_register() returns an error, the name allocated
in dev_set_name() will be leaked, the put_device() should be used
to give up the device reference, then the name will be freed in
kobject_cleanup() and other memory will be freed in ptp_clock_release().

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y, Removed 
kfree(ptp->vclock_index) in the ptach, since vclock_index is 
introduced in later versions]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/ptp/ptp_clock.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c895e26b1f17..869023f0987e 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -283,15 +283,20 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	/* Create a posix clock and link it to the device. */
 	err = posix_clock_register(&ptp->clock, &ptp->dev);
 	if (err) {
+		if (ptp->pps_source)
+			pps_unregister_source(ptp->pps_source);
+
+		if (ptp->kworker)
+			kthread_destroy_worker(ptp->kworker);
+
+		put_device(&ptp->dev);
+
 		pr_err("failed to create posix clock\n");
-		goto no_clock;
+		return ERR_PTR(err);
 	}
 
 	return ptp;
 
-no_clock:
-	if (ptp->pps_source)
-		pps_unregister_source(ptp->pps_source);
 no_pps:
 	ptp_cleanup_pin_groups(ptp);
 no_pin_groups:
-- 
2.40.4


