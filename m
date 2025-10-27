Return-Path: <linux-kernel+bounces-872717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75BC11DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0D2188D64E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3034FF63;
	Mon, 27 Oct 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvl2vl+/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4C32D0FF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604555; cv=none; b=e5e+HqO1hj3y8RIM7uV4gGgVjQRY0mYM9hPk/o/mH46qNNAVJO9dGoaJLEKyV8hBD9W+r4wYYIjcH0UYiohkNf40+09uPQIZY3PxyM/t/SAt/+3cDOr2KCWTvnFItapk5ixwj4pEZPimq+Xfq+eGSzFNo7nZk2t4FGS6zC9NLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604555; c=relaxed/simple;
	bh=ZrcTOL1vKT/Dd/eQ0GiUIcSzIaqFbdPot7lU8DtZW/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQzDrWuSbTbNPSXafaupoc7kDAZe+emKsbB4eP4UOqXh47xX7ZajaMEGUOEQr1YHm7fIRzKEs0Xi9oFzsC6CVwX77D3Moa/Q/abQa96peY+3BA4adw/Ig4U1tAX7G1vUbMrcZPc+2LDPrD1CUeRoTJEt6RJqIZ875hitFDJUdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kvl2vl+/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47103b6058fso38211175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761604552; x=1762209352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx6qce1QvYPrCvX+nnNjmWVayPG89i/5tERfc8V0M5I=;
        b=kvl2vl+/sNI97QhHi5o2dUrOCKqcWUa5yfUy2eMChM5GJ9jkQRwTkGl+VHIkP7JfyD
         0t/BmnNtHLIYqxvoBUjNkGpD+S3lFITB0QJBqkKQ3zRLyB8Sq7yKquGwtpC52ZPXh/N5
         8bIgQYkqEZLqIy2toufuyZrJS/bVSKb+3to5aT+6/2nvOJv22EM5V2udjqkd4xXBZV/V
         jRsMXoY+jFzh8PgB8yj5skXODBoQ1zho8klxSIlLT11jY720M2N+FlmDNJMy8nWQTINq
         ua/qkzuV50CqUwv1llmvn+4+XIRqkHDNeS9+0Ct9mQGCRwy3kRqoZO5xKiQo1/n0hfB6
         4AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604552; x=1762209352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx6qce1QvYPrCvX+nnNjmWVayPG89i/5tERfc8V0M5I=;
        b=Z+lk9rixD5C7f/1u5DA5PWDNijHEcLU5TYDXxz9u3LyI2NUGfrjYowuLMd7yqqWkuB
         QqjK6DU+9TfEKAfEPgNfKv+TXQxRO6L1EIxg0l69g8tpu5de8/HEDCtPkpikmw6gNSn2
         NDiTyjOt2f4ePh4vVxj73bdov42R0Dmfp0XWRQD8qFDTeLTebN9/dTrsVeuF4Jyfeha1
         Lgo3QzR6XlV1+N3L9Bltzcq7J/jmGyEfqIYe4V5fvvbOFcZjWFMhyik/FCUxjjJiR2t5
         WflCyKRgR2jNkEe9W/LB+096r8zMK9q7sDEE0IpCopuJFDUMMWZJmM6vi5FCyCgr4rV2
         D/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCViq6GhuULgce668mUKLrNWnxfCWsHteu8HwrxPifA/Pyxa3FEyIkJogSwBxnSlr1cfUZdSQHOgNhafA2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/BekYI7gdPjVMLUe5EY6bMLPf9NpjpaCpdoY5xfzZ6hMcQ6T
	qiYf3rXs6RvwPIwu6H9QbgB68NcxjsC77hQIkrkngtZGOzdkHs59yjwwRm8+9BPLxhg=
X-Gm-Gg: ASbGncvLVBGujdHauNcn1OQo4eIlgDau7xG/WP3C8bmUc24lCqAIRqPgoHlJE8EStF0
	xT8+d2Hn/CXXA149yjBTyL1r9fC8NMjlcY7D+wu8GO3UAcGUvuhxHvYH4y92q+IyFXXwSZoyZdA
	tjn1tWM4u0pDb4c973z6P38VGnVwFjcadISqMomX2Albj9FEgb5Ge5Iss3+wpC58wOKw0sokq5E
	n+bIyxS4org3zIComsRgP6Rcxe5E3Qfp+sz/g5kcGr/BbHrb//WUpLYW8jLSkcniUwZFMXpfAkT
	QatIAm6FBSeeARqDLC2Fj0E1l538ZOYhbZpsBtmzr4IOOw5TULGRvOtkWJmJysWNEQkc1Xg+jn+
	D3rOIAspxtqwt0PrtVYxlFqDZbCmRg2IdjQOAxt2OmE94HjilICN5KG6Ot8A+CqEftNKzjDCYSa
	9PjNxfV7Wr/qiUOgaCY4Ixo7cRMM9rshERO3hRLisX8Hwwktg6ZeYutXp6gwWeTCCFQO2PyNgIZ
	ycj4bC49PeZm/auJhehRGoX578L
X-Google-Smtp-Source: AGHT+IEI18RlKvu3sL7/TxLhdbwGpT52FovIZ8TtiIYoo2vbR/zws0/ySXLOf1ihsMWG10P23FTF6g==
X-Received: by 2002:a05:600c:4f07:b0:46e:1a60:c995 with SMTP id 5b1f17b1804b1-477181098d4mr9866555e9.2.1761604551834;
        Mon, 27 Oct 2025 15:35:51 -0700 (PDT)
Received: from linaro.org (host86-130-206-17.range86-130.btcentralplus.com. [86.130.206.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddad455fsm79826845e9.2.2025.10.27.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:35:51 -0700 (PDT)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	james.clark@linaro.org,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 1/1] coresight: fix issue where coresight component has no claimtags
Date: Mon, 27 Oct 2025 22:35:45 +0000
Message-Id: <20251027223545.2801-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20251027223545.2801-1-mike.leach@linaro.org>
References: <20251027223545.2801-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coresight components have 0 to 8 claim tag bits. ARM recommends 4 and
the implemented claim tag protocol uses two of these.

If a component has insufficient claim tags then the protocol incorrectly
returns an error when attempting to claim a component.

Fix by reading CLAIMSET to establish then actual number of claim tags
and return success when attempting to claim a component were there are
insufficient tags to implement the protocol.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 46 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-priv.h | 10 +++++
 include/linux/coresight.h                    | 15 +++++++
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 3267192f0c1c..61b4902b0ead 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -131,6 +131,39 @@ coresight_find_out_connection(struct coresight_device *csdev,
 	return ERR_PTR(-ENODEV);
 }
 
+/*
+ * Reading CLAiMSET returns  a bitfield representing the number of claim tags
+ * implemented from bit 0 to bit nTag-1, valid bits set to 1.
+ *
+ * Claim protocol requires 2 bits so test for MS bit required,
+ * bit 1 -  CORESIGHT_CLAIM_BIT_PROTOCOL_HI
+ *
+ * return true if sufficient claim tags implemented for protocol
+ */
+static bool coresight_claim_tags_implemented_unlocked(struct csdev_access *csa)
+{
+	u32 claim_bits_impl = FIELD_GET(CORESIGHT_CLAIM_BITS_MAX_MASK,
+			 csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMSET));
+	return ((claim_bits_impl & CORESIGHT_CLAIM_BIT_PROTOCOL_HI) != 0);
+}
+
+/*
+ * check if we can use the claim tag protocol.
+ *
+ * If currently unknown - read register to determine if sufficient tags and
+ * save value, otherwise return current value.
+ */
+static bool coresight_check_use_claim_tag_unlocked(struct coresight_device *csdev)
+{
+	if (csdev->claim_tag_info == CS_CLAIM_TAG_UNKNOWN) {
+		if (coresight_claim_tags_implemented_unlocked(&csdev->access))
+			csdev->claim_tag_info = CS_CLAIM_TAG_STD_PROTOCOL;
+		else
+			csdev->claim_tag_info = CS_CLAIM_TAG_NOT_IMPL;
+	}
+	return (csdev->claim_tag_info == CS_CLAIM_TAG_STD_PROTOCOL);
+}
+
 static u32 coresight_read_claim_tags_unlocked(struct coresight_device *csdev)
 {
 	return FIELD_GET(CORESIGHT_CLAIM_MASK,
@@ -156,6 +189,9 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag);
 
 void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa)
 {
+	if (!coresight_claim_tags_implemented_unlocked(csa))
+		return;
+
 	csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
 				     CORESIGHT_CLAIMCLR);
 	isb();
@@ -175,12 +211,13 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
 int coresight_claim_device_unlocked(struct coresight_device *csdev)
 {
 	int tag;
-	struct csdev_access *csa;
 
 	if (WARN_ON(!csdev))
 		return -EINVAL;
 
-	csa = &csdev->access;
+	if (!coresight_check_use_claim_tag_unlocked(csdev))
+		return 0;
+
 	tag = coresight_read_claim_tags_unlocked(csdev);
 
 	switch (tag) {
@@ -190,7 +227,7 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
 			return 0;
 
 		/* There was a race setting the tag, clean up and fail */
-		coresight_clear_self_claim_tag_unlocked(csa);
+		coresight_clear_self_claim_tag_unlocked(&csdev->access);
 		dev_dbg(&csdev->dev, "Busy: Couldn't set self claim tag");
 		return -EBUSY;
 
@@ -237,6 +274,9 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 	if (WARN_ON(!csdev))
 		return;
 
+	if (!coresight_check_use_claim_tag_unlocked(csdev))
+		return;
+
 	if (coresight_read_claim_tags_unlocked(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
 		coresight_clear_self_claim_tag_unlocked(&csdev->access);
 	else
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 33e22b1ba043..270f179c8535 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -41,6 +41,16 @@ extern const struct device_type coresight_dev_type[];
 #define CORESIGHT_CLAIM_SELF_HOSTED	2
 #define CORESIGHT_CLAIM_INVALID		3
 
+/*
+ * Coresight specification defines a maximum of 8 claim tag bits.
+ * The precise number is implementation defined, and may be obtained by
+ * reading the CLAIMSET register.
+ */
+#define CORESIGHT_CLAIM_BITS_MAX_MASK	GENMASK(7, 0)
+
+/* MS Bit required by the protocol */
+#define CORESIGHT_CLAIM_BIT_PROTOCOL_HI	BIT(1)
+
 #define TIMEOUT_US		100
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 6de59ce8ef8c..fefe4317a793 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -242,6 +242,19 @@ struct coresight_trace_id_map {
 	raw_spinlock_t lock;
 };
 
+/*
+ * Coresight claim tag info:
+ * CS_CLAIM_TAG_UNKNOWN      - not yet checked.
+ * CS_CLAIM_TAG_STD_PROTOCOL - using standard claim/release protocol.
+ * CS_CLAIM_TAG_NOT_IMPL     - no claim tags available.
+ */
+enum coresight_claim_tag_info {
+	CS_CLAIM_TAG_UNKNOWN,
+	CS_CLAIM_TAG_STD_PROTOCOL,
+	CS_CLAIM_TAG_NOT_IMPL,
+};
+
+
 /**
  * struct coresight_device - representation of a device as used by the framework
  * @pdata:	Platform data with device connections associated to this device.
@@ -265,6 +278,7 @@ struct coresight_trace_id_map {
  *		CS_MODE_SYSFS. Otherwise it must be accessed from inside the
  *		spinlock.
  * @orphan:	true if the component has connections that haven't been linked.
+ * @claim_tag_info: how the device is using claim tags.
  * @sysfs_sink_activated: 'true' when a sink has been selected for use via sysfs
  *		by writing a 1 to the 'enable_sink' file.  A sink can be
  *		activated but not yet enabled.  Enabling for a _sink_ happens
@@ -291,6 +305,7 @@ struct coresight_device {
 	local_t	mode;
 	int refcnt;
 	bool orphan;
+	enum coresight_claim_tag_info claim_tag_info;
 	/* sink specific fields */
 	bool sysfs_sink_activated;
 	struct dev_ext_attribute *ea;
-- 
2.32.0


