Return-Path: <linux-kernel+bounces-750463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE82B15B92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BC7A6BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860A275AFE;
	Wed, 30 Jul 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUHpzfkN"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACA27467B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867803; cv=none; b=JMc5Wl4ekBt6K8NIp2xcjA4Rg8FDU1g63t4+9tBlV8rKD++fOFRUvxTTuC4iAi7xtoILeBFZv0T8afHHq8+WtJPfxsSCS2VQW8T5sp+CPb5azEYfyHNX5U2LeBABve43WDRScXFMA03OTGfU7IeQvWZB3BJHA5pDMCe4yYjPrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867803; c=relaxed/simple;
	bh=5dgm8QJmb1y3lQDQkDPV0FaZsW33rfPUVwIw+yQAhQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZS47DSm7eQdm1Yby6a6uCbKCmaR7UGPmrQ9osMPaFkfU9NurA2J3F1YX6vOs6HBJ3XDXZJuk0kMkavVDCD1dDy2pbdaETtWUoRksmBWE0w9sJq/b/l0zLcB+wGmLbOOSBIjlNFMmhpbUy6OWmK3hidRIsK6GKSh04Hd6pQ0vK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUHpzfkN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-75ce8f8a3a1so3817489b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867801; x=1754472601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu+M0/uIPWDSjTwSlyDMCHQ4E58hfAmwYKc2WXq227M=;
        b=UUHpzfkN4C0CGSHOMRQi5+vwTxxEQdIzWwJ6U/iAaOBV//sqglORdxidYIodBMq8Wo
         0x/OjlyBJpdy0DvOWNha24ebMxU9Y6q+Q4ot8B6j6fAoXCnIBVbZBx6wLFGV55JxrXwK
         j//Xtc5QIQ01TG1FfdUTpNReaL5qC7vHAcWJ0GzY1QW3YOiCD/UgeIYZONy2TRZ3lhmt
         U8dGSnExQJi1IhlfatYRZyZoGKcOdW51rIOOT1CPEWddE4RUXq4KNNX2H9crbDRHO18t
         PfkIUW8k9c9LbPcHTKttwq3LZwaNrohJFL/dsY2333SS3AGFbtjF6r/s/AWgreeN/KKs
         pJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867801; x=1754472601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu+M0/uIPWDSjTwSlyDMCHQ4E58hfAmwYKc2WXq227M=;
        b=s3rJeOuR0x72t/0mCKHteu9oZD5GFEt/us06YhY8fwYbYfz2m03+KNfUqiDxVhCVOC
         wlMvmtxRaBj+gs6WZMPZQVP6RJlnAuB6UekScIppcjTE5PLQIbhg9rnt3eDRZN70T8YN
         35Z86tLRg/fGoE/X+fuJfQuYQTrXIC/rySTwYCzD03sheh+S5qI0zUqYUjP5o+A/YBjk
         XhxZVFdd2kXfR6068rFh/21YXmjarI1gnyRLJv6ldYF3MILutY4C5v/kh12nwKtcmsPE
         x+wlOB0uvSAc04fDrC3aFpUGQ7Bg/ajbt/ld25/QUTg6NSAUbB3n/d982qlZVk68Her4
         TYng==
X-Gm-Message-State: AOJu0Yzk/eHQZc03i3kmSbdPedANKExQx4tFF6t6GqVz76sLCOa1DIh6
	MIABXFFn5WW6uxZ5LnhzcjTVETseA5qCKaw5TokLqCW+d5U6DBHWA/SC/Z68WZIoYwKptfZ6giZ
	QaAoT
X-Gm-Gg: ASbGncsktyXtjE+qPJa2CfZhbQRpC51pRqVWhwu7ehV7bWnsSGJgdq8vVpbIDKmMb6a
	fOQ8vrSDbn+6rsT0yqXUvlGZ5uEyPg/jquk0eGTRD68t2trESTi2mB4+kKipRJ19HYd/NJ+wuyp
	4QnhpwKEHU6pTbUWnxEjKqvCifYIurCi1p/2fbltwQoWoqWvBcyQvFnaO+D1m1SlFJ2yMqiZr4n
	rwJWGCh4rhdgj/KL6qhJFR4KaPqwJ/ba4pROUSZrJ8TRK/C1d91AZxNgFBRBbjdbDIQ40mBgZAM
	KqypM6LFSvME0oDcxNmIlLk5ZY6WYkeLAA/vENigHhjUWduiuce2FzT4NAKt8L4tXPXBHyBI2xT
	osVdqk2k+YF5LyWkhDa/b658=
X-Google-Smtp-Source: AGHT+IEaqMhp9wt/vc4KBbRw+vOpiZc3CbcTUS+/uPYT7mnw3RyDbEwb+0HDQqI/sNr/Say0lfIuDQ==
X-Received: by 2002:a17:903:4b08:b0:240:3dea:b269 with SMTP id d9443c01a7336-24096b658a9mr39237495ad.48.1753867801249;
        Wed, 30 Jul 2025 02:30:01 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24009e53876sm74902245ad.2.2025.07.30.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:00 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [RFC PATCH  1/6] of: reserved-memory: Add reserved_mem_device_init()
Date: Wed, 30 Jul 2025 14:59:30 +0530
Message-Id: <88dbf7486b820bd713598f20efd51e327b9ff755.1753865268.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1753865268.git.viresh.kumar@linaro.org>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds reserved_mem_device_init() helper to attach the specified
reserved-memory region to the device.

This is required to attach a reserved-memory region with a non-DT
device.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/of_reserved_mem.c    | 64 ++++++++++++++++++++-------------
 include/linux/of_reserved_mem.h |  7 ++++
 2 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..e0a86c3fa656 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -606,6 +606,45 @@ struct rmem_assigned_device {
 static LIST_HEAD(of_rmem_assigned_device_list);
 static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
 
+/**
+ * reserved_mem_device_init() - assign reserved memory region to given device
+ * @dev:	Pointer to the device to configure
+ * @rmem:	Pointer to the reserved memory region
+ *
+ * This function assigns the @rmem reserved memory region to the @dev device.
+ *
+ * Returns error code or zero on success.
+ */
+int reserved_mem_device_init(struct device *dev, struct reserved_mem *rmem)
+{
+	struct rmem_assigned_device *rd;
+	int ret;
+
+	if (!dev || !rmem || !rmem->ops || !rmem->ops->device_init)
+		return -EINVAL;
+
+	rd = kmalloc(sizeof(*rd), GFP_KERNEL);
+	if (!rd)
+		return -ENOMEM;
+
+	ret = rmem->ops->device_init(rmem, dev);
+	if (ret == 0) {
+		rd->dev = dev;
+		rd->rmem = rmem;
+
+		mutex_lock(&of_rmem_assigned_device_mutex);
+		list_add(&rd->list, &of_rmem_assigned_device_list);
+		mutex_unlock(&of_rmem_assigned_device_mutex);
+
+		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
+	} else {
+		kfree(rd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(reserved_mem_device_init);
+
 /**
  * of_reserved_mem_device_init_by_idx() - assign reserved memory region to
  *					  given device
@@ -624,10 +663,8 @@ static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx)
 {
-	struct rmem_assigned_device *rd;
 	struct device_node *target;
 	struct reserved_mem *rmem;
-	int ret;
 
 	if (!np || !dev)
 		return -EINVAL;
@@ -644,28 +681,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 	rmem = of_reserved_mem_lookup(target);
 	of_node_put(target);
 
-	if (!rmem || !rmem->ops || !rmem->ops->device_init)
-		return -EINVAL;
-
-	rd = kmalloc(sizeof(struct rmem_assigned_device), GFP_KERNEL);
-	if (!rd)
-		return -ENOMEM;
-
-	ret = rmem->ops->device_init(rmem, dev);
-	if (ret == 0) {
-		rd->dev = dev;
-		rd->rmem = rmem;
-
-		mutex_lock(&of_rmem_assigned_device_mutex);
-		list_add(&rd->list, &of_rmem_assigned_device_list);
-		mutex_unlock(&of_rmem_assigned_device_mutex);
-
-		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
-	} else {
-		kfree(rd);
-	}
-
-	return ret;
+	return reserved_mem_device_init(dev, rmem);
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_by_idx);
 
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index f573423359f4..3933f1d39e9a 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -37,6 +37,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 int of_reserved_mem_device_init_by_name(struct device *dev,
 					struct device_node *np,
 					const char *name);
+int reserved_mem_device_init(struct device *dev, struct reserved_mem *rmem);
 void of_reserved_mem_device_release(struct device *dev);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
@@ -64,6 +65,12 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 	return -ENOSYS;
 }
 
+static inline int reserved_mem_device_init(struct device *dev,
+					   struct reserved_mem *rmem)
+{
+	return -ENOSYS;
+}
+
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
-- 
2.31.1.272.g89b43f80a514


