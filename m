Return-Path: <linux-kernel+bounces-814083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DACB54F01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7D97C7CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961FA30FF3F;
	Fri, 12 Sep 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKmaSm4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6030F529
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682798; cv=none; b=aJVVL06j4gJhUnR7pZva0Lzgkr/txVK0xWCORfjpC8B/ZC9qxBduP6dRYAu0il2SCRnsEifPTO4/qVldPknQr+iV7jdClu0Rm9mJbzR/5BJYmIsESXgV4oczqZX7+FeH0CQk9mbUleZWlkxpGQo2B6xA6wLeWcnO1bgt/GJtMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682798; c=relaxed/simple;
	bh=RWcZD9xAE7KcutgA/HLhkTOkAiPLVusWcV5umMhzW+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkGOt/NEuo9wjS3JbeGMJLNN6cYXZozUJHYJ7YVQ3dvOYJ9gT/RjjCmnUi1MMPgtbXYZ8qxkt7TT9YGUeYNwUwFsxHuKceFnTVp9F8r0XDFFBKdDSbQ+lqSj+I9eFUdh644TiSbvOuDbnDe1ySOJoBpWMSq0E6Zd0b7/ZtQESuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKmaSm4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600C5C4CEF1;
	Fri, 12 Sep 2025 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682798;
	bh=RWcZD9xAE7KcutgA/HLhkTOkAiPLVusWcV5umMhzW+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKmaSm4TC14fSBBWlnd6qYTXySZ1IK7M3Kvb2t2/ibWFbLCyJqw2Hn0bZ2ca9TEvO
	 PudERgS92Covz9Hg1FqMW2Ui7fOhGR1T5jVjCCVk30PTpKlLKatZosizpDhhwrAFtH
	 //VtagUUuXoqVSfZTLyQ1JF+hLsWz8AOrzFp3o0+gRt/sY9W/v7VXcYmZQPsLx8uV7
	 MeLFzXZK7J/S5y6P6sO7xVT/QElO7Pwf5pl9BuikNXqkUnSuIPCUKBa3aBw2P2Pwom
	 eBVtrdbgOikLYnHIfc6BHivKezzqKnyGhMWL7UfJQhlQkJR0GANhFAz9XVqTXOpN/J
	 uhGzywRgXBWiA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/4] misc: fastrpc: Cleanup the domain names
Date: Fri, 12 Sep 2025 14:13:01 +0100
Message-ID: <20250912131302.303199-4-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131302.303199-1-srini@kernel.org>
References: <20250912131302.303199-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ling Xu <quic_lxu5@quicinc.com>

Currently the domain ids are added for each instance of domains, this is
totally not scalable approach. Clean this mess and create domain ids for
only domains not its instances.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1dc69d234996..93ec587fcab6 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -27,8 +27,6 @@
 #define MDSP_DOMAIN_ID (1)
 #define SDSP_DOMAIN_ID (2)
 #define CDSP_DOMAIN_ID (3)
-#define CDSP1_DOMAIN_ID (4)
-#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
 #define FASTRPC_MAX_SESSIONS	14
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
@@ -106,8 +104,6 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
-static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
-						"sdsp", "cdsp", "cdsp1" };
 struct fastrpc_phy_page {
 	u64 addr;		/* physical address */
 	u64 size;		/* size of contiguous region */
@@ -2270,6 +2266,20 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	return err;
 }
 
+static int fastrpc_get_domain_id(const char *domain)
+{
+	if (!strncmp(domain, "adsp", 4))
+		return ADSP_DOMAIN_ID;
+	else if (!strncmp(domain, "cdsp", 4))
+		return CDSP_DOMAIN_ID;
+	else if (!strncmp(domain, "mdsp", 4))
+		return MDSP_DOMAIN_ID;
+	else if (!strncmp(domain, "sdsp", 4))
+		return SDSP_DOMAIN_ID;
+
+	return -EINVAL;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2285,15 +2295,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return err;
 	}
 
-	for (i = 0; i < FASTRPC_DEV_MAX; i++) {
-		if (!strcmp(domains[i], domain)) {
-			domain_id = i;
-			break;
-		}
-	}
+	domain_id = fastrpc_get_domain_id(domain);
 
 	if (domain_id < 0) {
-		dev_info(rdev, "FastRPC Invalid Domain ID %d\n", domain_id);
+		dev_info(rdev, "FastRPC Domain %s not supported\n", domain);
 		return -EINVAL;
 	}
 
@@ -2340,21 +2345,20 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
-		/* Unsigned PD offloading is only supported on CDSP and CDSP1 */
+		/* Unsigned PD offloading is only supported on CDSP */
 		data->unsigned_support = false;
-		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
+		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
 			goto err_free_data;
 		break;
 	case CDSP_DOMAIN_ID:
-	case CDSP1_DOMAIN_ID:
 		data->unsigned_support = true;
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
-		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
+		err = fastrpc_device_register(rdev, data, true, domain);
 		if (err)
 			goto err_free_data;
 
-		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
+		err = fastrpc_device_register(rdev, data, false, domain);
 		if (err)
 			goto err_deregister_fdev;
 		break;
-- 
2.50.0


