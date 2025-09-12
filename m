Return-Path: <linux-kernel+bounces-813563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1CB54789
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F45565749
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226F2676E6;
	Fri, 12 Sep 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+CHxa0s"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86432D7DF8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669070; cv=none; b=K6npIxzd5uGThxSvJAIACImZuAKAIx6vYH+/XqZm79rgM06WTnPo7uctga+mrt1vfDj7TYTF4xuVT6eq6M8ouoPtJixT3HA/elz6jtoMPkRBkm5WzYBHQvCFP4ODe7HWPLmX8PwY1y+K2A1PDWYTzwn3bnqtqqbSFqd4O8L6tO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669070; c=relaxed/simple;
	bh=2XRqmPu/gyPzYkQ/gDwq5Xo2kuz0OOwm+H4kdZL2QK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t965QTTlVxhVDF1GzyfO3+OB5fn2T1avWFbcelW1DK86kITw43BF4o47vGBOb+vyvPRkJrc6BP0I0o2WS2N5UobBkRMH1C8N1Lj3csct8l3jhmOonpKVOqFz7ZY3ZoBHTV/cWcy9Jot9neoOvRnckDIuW5XSRVcV/tcGNAt+5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+CHxa0s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de5246dc4so2970905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757669067; x=1758273867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9rrTbw+eB4e+CPFH41yk8s4K4dTs5VqUYsOCYmEbOc=;
        b=h+CHxa0sThKZbrkvrq0zf+v+4lEha27SdUezYq+t6nv4N4+EKN6TX0t0ZYeNkzXNTG
         1OiQabLZd7m9qhdPE/aqIFMy5wYiJYCI2Co86d72MrFLU1/OlckX/GJ7OVPlq0NJ1EgE
         oUJjyzqZH3BRRErbqIwVUujj7FbkxSABnByAgwHbRF2JEJ4UhXNn2K4jMZrGGmemk4DF
         IGy5GdmlIcRh+08rEFvmhcoEdpaD6YMsJCyCc0HYnFUIgUr/waUkOyOVWzii6HdveFbg
         G0ZfAg6OrgeY3Wjb3R7X9osllHWj06Uk9dpz8Jbxk8KRwWtGIBBTSR6uAZMPAoigw06N
         f4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669067; x=1758273867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9rrTbw+eB4e+CPFH41yk8s4K4dTs5VqUYsOCYmEbOc=;
        b=grfHbA6vJaR92dfawhcdkVfxtZBEdqcNoS4hkeCnxV3l2JS8dtry0e22GNYBkHuL4Y
         MPJhXWT7JN0AL+HXKh9U+HYkg/UT30LxB8oKIHrnxb0Fu2xlEKppD00g2fcjtBFIO1Ya
         x5q8TblZNMh51curzvQCGDDJb/J98nIBuEIwvQaWS6SjnXnV6VD5KAb/P8CejetqOrCX
         d8sNzH1F8WzdNQSmmtl+3yH22NlaQqr++BkLpczft86o9Qic08B7m0AkGu33tZCOuBRy
         nSscaZ2kyy5jkArFLrMHMrCtRNVnMwlhcd9MlI9sqfxJf2A2kwCW2Usxr0Zrasf9LAUS
         znLw==
X-Forwarded-Encrypted: i=1; AJvYcCWdEjknNrxazE5szo0Zl8pExYTLzgysJjRkbBp/AoX9L7dWSqsUHmIvk58pziKoHLRe7bSvLGbB3x9/4ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGrj8RPxIvJrJjRznY1bX26UZAUq1Ehv/qt0hvYoYM2QvFoYk
	ReffHWk21CdZ4s4XsLqKYNwW/LC4Sm8Hyh2p9yP27w7VkZWw9J9ETy8q5EhqrY29jzM=
X-Gm-Gg: ASbGncsEoStbn3G5qGRTu06hndkgvDSdbq0zK4ZBFqkA0agDx4CdLqXOURAXsDZn3Qf
	4RoW4oYYlb937NQ4XLuTS+LKkDLEs1goFZPeqrWtr5yrSwqVaBzJ9L4ZbMlvur11mCdMF9nKy6z
	XGHNkTpFAhd77kAhd2C4fsQwxpc4H+JZ61kyv3/TyNckmpNVtgOf9iWNUFxDa7PFoynXPa0pBkH
	V3evnp1igUozDKcju4jP17KNadlse6GuAKwGohc+0z1FXjZ910SJIKGYZQSgwesant35JmAAbuw
	RK9lP5/aRr1/9k73UOPA2gXHW1bmZ/BlY+j6g3O1OkB847tHOz4ZYjU9THn8oaTMgcemZJ9xO3x
	6s0yCq3KT8kGLMVgwRic3VCx31PNMeG6xmy/eSn9jY4Ja
X-Google-Smtp-Source: AGHT+IE42/Da93gcZaWH4jt7HlET0DZgR6QWug+CItVQm8/AXegxB88mjk+GQjzGdqsFMrTXdt/zCw==
X-Received: by 2002:a05:600c:8707:b0:45c:b627:a4e3 with SMTP id 5b1f17b1804b1-45f21e65defmr9620055e9.1.1757669067036;
        Fri, 12 Sep 2025 02:24:27 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ee8sm58316745e9.18.2025.09.12.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:24:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] firmware: arm_scmi: Simplify printks with pOF format
Date: Fri, 12 Sep 2025 11:24:24 +0200
Message-ID: <20250912092423.162497-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=2XRqmPu/gyPzYkQ/gDwq5Xo2kuz0OOwm+H4kdZL2QK0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBow+bHzkYb9jiI6adZWT5vC+h+63SkbrshWqua+
 SRh/nNgqiWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMPmxwAKCRDBN2bmhouD
 13WEEACMYeZPtMnfhYuqkZkuOioVkNzJzK3QySfZ7SJbXkF/v6FzAI7NOXPneNlEq0KKScuP0BB
 Z+RTu4qmNEzzHkd274TAECf+z9nluPNzJHfPSqJ5uk6HrbKUIH2asRQtbDDi3AeM1eZz7SedHV6
 Ilb2lJU90+yfwleMpZAMZjFLgglLMsx9mQk+vO4aN1jOAmZJyBYiSNS7HPfLsvYp8uvGtlW1qlc
 MNIfMpeaWnzaqNG8co1SoU2nNpGcFHYCbQw3AIr8Rtmo/2Fb4ysn1TuzqZWB5rfWAxUwbpq5meD
 2/6X5ZW4Cim5M3vwNrbs8+wA3xUeEEWZtA48prdbIg7EuTmIdLPEgOhpXXHVrgGhrim8ND2Rwo+
 kZy5wTyMbF/Icvccbg8xYWlUI2BHiLdk+XxTNPN/eJrvE2M368N42rpW5qMj2bFOquaN1YoAtyN
 SS/lMQs2au7XgiXT5qknZQSRVs2sqwL8F2kl+XM/BnTSx+dXKIzgUyzpmd7Z/pTPrVQwRrDjhsX
 zVSYRD1AWdDgwNUrVNwf8D7RFTChLbryEk7dApxisvHsuq+kPCZac0tq1BT3E89bMqkymU9evZU
 agH1nslUUaJa55LdFqhcRE+Q5xf8jq7YAlfrXzD/RxIkZpHfLouZFdAQKEHh6yWwgZv2qdlZNdD aGZrxwlmlukU7gg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Print full device node name with %pOF format, so the code will be a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/arm_scmi/bus.c                | 13 ++++++-------
 drivers/firmware/arm_scmi/transports/mailbox.c |  7 +++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 24e59ddf85e7..c7698cfaa4e8 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -401,8 +401,8 @@ static void scmi_device_release(struct device *dev)
 
 static void __scmi_device_destroy(struct scmi_device *scmi_dev)
 {
-	pr_debug("(%s) Destroying SCMI device '%s' for protocol 0x%x (%s)\n",
-		 of_node_full_name(scmi_dev->dev.parent->of_node),
+	pr_debug("(%pOF) Destroying SCMI device '%s' for protocol 0x%x (%s)\n",
+		 scmi_dev->dev.parent->of_node,
 		 dev_name(&scmi_dev->dev), scmi_dev->protocol_id,
 		 scmi_dev->name);
 
@@ -474,9 +474,8 @@ __scmi_device_create(struct device_node *np, struct device *parent,
 	if (retval)
 		goto put_dev;
 
-	pr_debug("(%s) Created SCMI device '%s' for protocol 0x%x (%s)\n",
-		 of_node_full_name(parent->of_node),
-		 dev_name(&scmi_dev->dev), protocol, name);
+	pr_debug("(%pOF) Created SCMI device '%s' for protocol 0x%x (%s)\n",
+		 parent->of_node, dev_name(&scmi_dev->dev), protocol, name);
 
 	return scmi_dev;
 put_dev:
@@ -493,8 +492,8 @@ _scmi_device_create(struct device_node *np, struct device *parent,
 
 	sdev = __scmi_device_create(np, parent, protocol, name);
 	if (!sdev)
-		pr_err("(%s) Failed to create device for protocol 0x%x (%s)\n",
-		       of_node_full_name(parent->of_node), protocol, name);
+		pr_err("(%pOF) Failed to create device for protocol 0x%x (%s)\n",
+		       parent->of_node, protocol, name);
 
 	return sdev;
 }
diff --git a/drivers/firmware/arm_scmi/transports/mailbox.c b/drivers/firmware/arm_scmi/transports/mailbox.c
index bd041c99b92b..ae0f67e6cc45 100644
--- a/drivers/firmware/arm_scmi/transports/mailbox.c
+++ b/drivers/firmware/arm_scmi/transports/mailbox.c
@@ -127,8 +127,8 @@ static int mailbox_chan_validate(struct device *cdev, int *a2p_rx_chan,
 	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh != 2) ||
 	    (num_mb == 4 && num_sh != 2)) {
 		dev_warn(cdev,
-			 "Invalid channel descriptor for '%s' - mbs:%d  shm:%d\n",
-			 of_node_full_name(np), num_mb, num_sh);
+			 "Invalid channel descriptor for '%pOF' - mbs:%d  shm:%d\n",
+			 np, num_mb, num_sh);
 		return -EINVAL;
 	}
 
@@ -140,8 +140,7 @@ static int mailbox_chan_validate(struct device *cdev, int *a2p_rx_chan,
 					of_parse_phandle(np, "shmem", 1);
 
 		if (!np_tx || !np_rx || np_tx == np_rx) {
-			dev_warn(cdev, "Invalid shmem descriptor for '%s'\n",
-				 of_node_full_name(np));
+			dev_warn(cdev, "Invalid shmem descriptor for '%pOF'\n", np);
 			ret = -EINVAL;
 		}
 	}
-- 
2.48.1


