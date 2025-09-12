Return-Path: <linux-kernel+bounces-814674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06AB5572A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1791D60C32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4933A010;
	Fri, 12 Sep 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNtIf5dJ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105E2848B0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706844; cv=none; b=FlC1NtRxUP26rkuP96wohTCMmLojUoVz7yCnOdytu66BKL17hauHMxVvBQQcuWIHhlPSgRFyomO9xiFA0YM0hh6ezX4aclh9Enm4KMcFU3Ft/0fcUzA+MOVMxeh7IcUa4tW96ki8zBfNMJGzcLsMqUjTP2BMWg9L5wVLKuSITYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706844; c=relaxed/simple;
	bh=6cXgFykumMGSAobanM946a8yCweHLAexqmweAhTT/O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaZNBirBNFaom18LNp06XcwAT1t1S1eVZWmPUajl4R+Zaz6plWCxGwc09hjvZ5MZbhs7/ZexvbaGZvvlLO3P5VZe30KMB7WywNMl9Reu4j+mqIN/pKnA4jCbq8yQoMhngctVTa/oLEX/RlxU92k2JY2Xh4EqGKuYjYYr3Ys6Fe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNtIf5dJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1819514f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706840; x=1758311640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRFKheYw65XtHsXGttpFWft6Q64Fu052vOHTho4zEao=;
        b=gNtIf5dJ9radHwUPCFXWn2iGJxMldL+0AKbrv1R0pD4eZFo8w/mpBHtFT5Igdd8o2t
         vdaUTELAWEMk19ja6HaEnkkDXwaXEwAD5jFbYIHyZPC2gGA1GZahqebBHQk/NZNLucZj
         1S2uNBv01l1Fmrb/bH7HLkTojIXfxTFEsHKEpl6ElOet636LfrW8q/5ISf/LZ0w50MlB
         Tu9E1cfRnU9gtzSccyyHEAh1rYh0+aAPabngK5LErAOfO0FFynoAYijRoebW4fHvYT0K
         x3B/oGw9ih+FHr1EHQRCtgLKBaS1KeRcaN0nwdohdAocr/ELTtU9Pt2+S8HIAedYc8+t
         Ivbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706840; x=1758311640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRFKheYw65XtHsXGttpFWft6Q64Fu052vOHTho4zEao=;
        b=roIcY00DBh7ItF46iCivWJoC6JzEKEEvzhA9b1DoRLb2lV8cyXCFxEREJhGiqhKJmG
         xFNAWcLFI2PwuMKbyQBDNTtLqeVgmzYu/wc9uDFp1360VGentTa6BG0DqUWu+uXWM9GD
         FKrWQLsM6YECnB4B7pHlR+oXRrI3MHzQ7lEXGIiiFWJOTGRJ1ZmHBs3d8sZqxYgFdYbj
         +5Ntym04+uG+WMya5KDWOb73e63OyACWBwtNFyZBoCg5eSb+vJIiVWDSVAO21HrYZaE3
         zs8bq7D+z54dzUXlGBx1JRjwmK6td/wjWGL7pW0R9o5zdq5fWYP+XuQrl3CDHPfkRakv
         t34A==
X-Forwarded-Encrypted: i=1; AJvYcCWUMCPERhJtJSa63Go6kfuO+tl25s9LAD1OVD3ZEGxasjtszOkaoHcFZDGA02qOKe3uQ5jCVM3mHSP1ADs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrprhoje/EVoQ5herY+vG6u5LqO1HIvtv6UrtBBQZpSGYdjMZ
	AgxRR4jKSMUaQGPWJomydHxr8iQN+wyAriF5bAvzhP3QB/g6GgV9HcP7
X-Gm-Gg: ASbGncudPIxF80wdNYwI4xk2mGDyEr6MPCMmRllE88MTd1Z8SM5Nf1ZnCxkD1yg5Npn
	ukTmUYQgGM/sPxVfG2vngw6x+FWBVOPXELf3q6tdL95OKuor2OEEXKj6ETMPg+dk0nNiR8FzAqT
	EMByGQZq0Ue2jPuBXeZ0CmMl14Pp7xs8TSBrtGWt5Hk1YhzOHqxN/57i0lL6bZr2P9nVYRY8bld
	GmMajlYkKVKxEkQUKmQVSYlHx6LWxF3Mo7tSw6vkI7buHgxhwxkUidK5mH8uUK+LurnJ2VX06h0
	30fLVyXIOZmhnHrDIPSAIRH15RyrwZO5fK7Lm785KjCCtuHNq9lL9KlgIlCZ+y2Xa7/kx39GMxO
	niJsSXUtLv+68FlwfgxYys9pCVq26d+YHT4uz/wiu0Vn9PokGwACBiwV+iFKRtg==
X-Google-Smtp-Source: AGHT+IEK0LKxCJMa3T/FE1yn9jWxr5RDOTIv2yx6yaJq5FGhArNPULJ6e1clvwsJhm+STF6/Bbsbjw==
X-Received: by 2002:a5d:5886:0:b0:3e6:116a:8fdf with SMTP id ffacd0b85a97d-3e7658bcb87mr4036656f8f.13.1757706839452;
        Fri, 12 Sep 2025 12:53:59 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:53:59 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 05/15] genetlink: add test case for family with invalid ops
Date: Fri, 12 Sep 2025 22:53:28 +0300
Message-Id: <20250912195339.20635-6-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case that verifies error handling when registering
a genetlink family with invalid operations where both doit
and dumpit callbacks are NULL.

The test registers incorrect_ops_genl_family which contains a command with:
- .doit = NULL
- .dumpit = NULL
and expects the registration to fail with -EINVAL.

This validates proper validation of genetlink operations during family
registration.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index 1db5d15a6f2c..245f3b0f4fbb 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -1089,6 +1089,33 @@ static struct genl_family incorrect_genl_family = {
 	.policy = my_genl_policy,
 };
 
+enum {
+	INCORRECT_OP_WITH_NULL,
+};
+
+// Generic Netlink operations with incorrect ops
+static const struct genl_ops incorrect_ops_with_null[] = {
+	{
+		.cmd = INCORRECT_OP_WITH_NULL,
+		.flags = 0,
+		.policy = my_genl_policy, // random policy
+		.doit = NULL, // doit and dumpit are NULL --> kernel will send -EINVAL
+		.dumpit = NULL,
+	},
+};
+
+// genl_family struct with incorrect ops
+static struct genl_family incorrect_ops_genl_family = {
+	.hdrsize = 0,
+	.name = "INCORRECT",
+	.version = 1,
+	.maxattr = 1,
+	.netnsok = true,
+	.ops = incorrect_ops_with_null, // ops contain NULL
+	.n_ops = ARRAY_SIZE(incorrect_ops_with_null),
+	.policy = my_genl_policy, // random policy
+};
+
 static int __init init_netlink(void)
 {
 	int rc;
@@ -1116,6 +1143,16 @@ static int __init init_netlink(void)
 	return rc;
 }
 
+static int __init incorrect_ops_netlink(void)
+{
+	int ret;
+
+	ret = genl_register_family(&incorrect_ops_genl_family);
+	if (ret != -EINVAL)
+		return ret;
+	return 0;
+}
+
 static int __init incorrect_init_netlink(void)
 {
 	int rc;
@@ -1241,6 +1278,10 @@ static int __init module_netlink_init(void)
 	if (ret)
 		goto err_sysfs;
 
+	ret = incorrect_ops_netlink();
+	if (ret)
+		goto err_sysfs;
+
 	ret = init_netlink();
 	if (ret)
 		goto err_sysfs;
-- 
2.34.1


