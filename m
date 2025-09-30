Return-Path: <linux-kernel+bounces-837291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D4BABDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DDF3AB087
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C6D2BDC26;
	Tue, 30 Sep 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZAnVlAL5"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB829E11A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218235; cv=none; b=ksQ2zZ3ttAmy4OPlGMD1RtQZPWTFazMrnDpxJ3goS4J5iNw4pu/cUzb7Bph+kYFJZxtZbdms3ys5BzYgW7AWV/BDtROmwLXxFqUynYTnnbKmLt3/NZ1GcObPVmxQ4q7WOKCJHdNsTLeWCHBAyNGvPgBy6phLf8eMWExBXooTndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218235; c=relaxed/simple;
	bh=GS7WqF0LF08bwFtmgD01RFP9YngCcT17XIqLFbp8DBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Y78N7bI6QI9E/q+AifozNVQJDbJeJ97vHzlAOsBE/d9jIdXx0O8z8JANCUiH3ZEdyzDTHDHNlvMLGfYkIofSDGlW9lNYRAa926fx45t8Ipyz9SPrvkwfEQcCBXcfVealuW7c9UCq1OOm1lkELREqoVDS9Wt/so/nDnxttlrfbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZAnVlAL5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b551b040930so3759144a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759218233; x=1759823033; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hgG+aaQgnT9ZPHFiK/eFUVeZgtIS+EmmmaaEftFkXN0=;
        b=ZAnVlAL5AmBqNdQbdXm3YZvl9Ybo2Q9cMYSlSDyQltoXto/0ebSexF4TO0Pb8YFds1
         NcPh5bcIOqZB6d451egPq7sZF+n8aq0L1yAwhnYy7O8mv4zQawVhavtQ7ePPY7zVuhsI
         ynIqYtc+hjcIP1hGvT5QOyZBN348w7evu5zOsRxf09ECueAL6UAIDWQcEMHJ4RR58sKB
         TedMUd1RRAUp15PxQnXgNM/e8i0K0ri7KdGkfI5YtbdVOdzuBaNJWSJrMTCfAg3Ce5Xo
         o50XELF7cUxdMs4KLFF2hC2NX0xNmQBwKFCZV3FMwQ0SqkurLcS5hif887JBKEp+DsWE
         gDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218233; x=1759823033;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgG+aaQgnT9ZPHFiK/eFUVeZgtIS+EmmmaaEftFkXN0=;
        b=eqbQi4TjmWM+p4/d+by2oUmFZKTFc0P9Uc/WlUn0yG3oarjV8w0HHJrFbMc9YrnEXn
         4hTKlXwc8qxXBiI0CaglHi4MKzNROHjZmjrUE498gOdJoKdH57G4k60lEWG+IkHS5DV9
         uoc29v7qI7MsXrJ3rJDg6d6S2yElFMcP7/lwOcp15jOJ1YnMUcp08pwjYiRsi4XO+XPr
         ++DJZ30/ucK+n9Wj1o9PE4eat2vxSxt/REtEjLMS32uXTyIY1x5cdQZTmcxjjnM8wCw8
         3l6GCpUkrJR1EuasKifkV/rUSpXnYZ9MTjlD5ZOMpairJd5s/LCW6XCKDdib/dSNvRXN
         49KA==
X-Forwarded-Encrypted: i=1; AJvYcCVJhvEepqFgUQ0hJttBld99D3y9G32HByv7DZiqtlzTWbKQ6YozK/F/J+HmjujL6fhJ7XyHmWmgTksgsfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8u50RgtcgL9dSsnrL97Etk3FVMQLs+FIwim7tqPe3Z4PZWRD
	i3iGTq9HDXsxlqXQxCYfo6/HPqa0jFt78QWAY4+AQTYnwu5ZoGfXh5VKyOrnvNzZanrtCrenDfZ
	wOssM
X-Gm-Gg: ASbGnctjPXRBjHCQEEKGW8dhbvU/ApH1j0+M4UOJD6mEayRINaENIpFDqB89npTwOMK
	0ZTNgGBxLqITiDZnqDheAN2RlGSK/LHrD4POSFE2S5VMkTXTjMQ4DNGB2+W62a8UcrJiEoYu8db
	DLkA/gG3QRX35BUzwOyr/HZaI1Hq82jHKQ4xQ+htNNeSxFaRidEj140gEQ0TjfEazXC5u5glUIR
	QSmexyH+CUEQCbZTqhQFaX8RtVqHpNR4uf1UHrHWN/+Pk5mZFN1ON/OfaHnCPT+OCU1Kt8WslgR
	DZEZJtVO5KNC5zX+lgYMxjTZ9xWjKZIh4+17qQFAYDGb7oxy4QgpXNO18DzeVBh1kW7FYqd6InF
	EKefSBGxW6nJTk3dJ3S3ORJ4SkERzItXIdaCsPoEld32fAWb6Xb6+HQxv+dmhSEth9DwtqI0H92
	4/uxsgVa9RAKVOZVmLi+MFlz6JZ/8h24tMzw==
X-Google-Smtp-Source: AGHT+IHusydmYb+60/mYolM5grNKdUqMD996medk1CNvk9KNDDE8cc9bcWqn/LVsyVs8k2//Dwhssg==
X-Received: by 2002:a17:902:f611:b0:271:fead:9930 with SMTP id d9443c01a7336-27ed4a78d72mr215723505ad.59.1759218233180;
        Tue, 30 Sep 2025 00:43:53 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-338386f577bsm3535374a91.2.2025.09.30.00.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:43:52 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: corey@minyard.net
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	guojinhui.liam@bytedance.com
Subject: [PATCH v2 2/3] ipmi: Fix __scan_channels() failing to rescan channels
Date: Tue, 30 Sep 2025 15:42:38 +0800
Message-Id: <20250930074239.2353-3-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
References: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

channel_handler() sets intf->channels_ready to true but never
clears it, so __scan_channels() skips any rescan. When the BMC
firmware changes a rescan is required. Allow it by clearing
the flag before starting a new scan.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a6e2e8246ab1..536484b8e52d 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -590,7 +590,8 @@ static void __ipmi_bmc_unregister(struct ipmi_smi *intf);
 static int __ipmi_bmc_register(struct ipmi_smi *intf,
 			       struct ipmi_device_id *id,
 			       bool guid_set, guid_t *guid, int intf_num);
-static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id);
+static int __scan_channels(struct ipmi_smi *intf,
+				struct ipmi_device_id *id, bool rescan);
 
 static void free_ipmi_user(struct kref *ref)
 {
@@ -2657,7 +2658,7 @@ static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
 		if (__ipmi_bmc_register(intf, &id, guid_set, &guid, intf_num))
 			need_waiter(intf); /* Retry later on an error. */
 		else
-			__scan_channels(intf, &id);
+			__scan_channels(intf, &id, false);
 
 
 		if (!intf_set) {
@@ -2677,7 +2678,7 @@ static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
 		goto out_noprocessing;
 	} else if (memcmp(&bmc->fetch_id, &bmc->id, sizeof(bmc->id)))
 		/* Version info changes, scan the channels again. */
-		__scan_channels(intf, &bmc->fetch_id);
+		__scan_channels(intf, &bmc->fetch_id, true);
 
 	bmc->dyn_id_expiry = jiffies + IPMI_DYN_DEV_ID_EXPIRY;
 
@@ -3427,10 +3428,17 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 /*
  * Must be holding intf->bmc_reg_mutex to call this.
  */
-static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id)
+static int __scan_channels(struct ipmi_smi *intf,
+				struct ipmi_device_id *id,
+				bool rescan)
 {
 	int rv;
 
+	if (rescan) {
+		/* Clear channels_ready to force channels rescan. */
+		intf->channels_ready = false;
+	}
+
 	if (ipmi_version_major(id) > 1
 			|| (ipmi_version_major(id) == 1
 			    && ipmi_version_minor(id) >= 5)) {
@@ -3632,7 +3640,7 @@ int ipmi_add_smi(struct module         *owner,
 	}
 
 	mutex_lock(&intf->bmc_reg_mutex);
-	rv = __scan_channels(intf, &id);
+	rv = __scan_channels(intf, &id, false);
 	mutex_unlock(&intf->bmc_reg_mutex);
 	if (rv)
 		goto out_err_bmc_reg;
-- 
2.20.1


