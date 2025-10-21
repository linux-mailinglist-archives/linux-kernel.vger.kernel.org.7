Return-Path: <linux-kernel+bounces-863851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5FFBF947E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1018818A814A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038B18DB01;
	Tue, 21 Oct 2025 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJqNQRmz"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDBB242D60
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090335; cv=none; b=lAu6/cL9K1JPzsKeNgKAeby7+g8X7wQCFRWPbKEHpevdyOFH4pS+Ha8ugQiYpZyqC6mqVVl262nbDbW6S/cpJgjnEvaBzxoEjwLzmntnvu6ntKPgF4o5JRe5gIFdZdiorMqifZ/PXfenI85F07fGIOZqOFy0HlRXZSpSsP1zHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090335; c=relaxed/simple;
	bh=Iuv+TVjL8/davbUEdtP/rFdWfwa7qesnnpAEfKArBQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDqHjBp2BjrPzkTnXR88xPNCB57sviQ+e+rJxeQFeT4zxsXV3G++x6dN4OUMQ2MxkxXs3xF9sq6EnJwepZjy4P21hPVEombBVUkj1xGrjMVtuHGBO8+VqHaONhDMQ/+9GL+lh89+3us5MJ/f/neyYqjE7Whz6PsaAobIMg8Dh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJqNQRmz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46b303f7469so49684425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761090332; x=1761695132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OafmaFEEMiW3DYw/6kVfDpX+aIzCwIqDzz1UgpECPjI=;
        b=QJqNQRmzDii1bfos3DapTsipVo95DrcRHdC2qjeLc45pnh2GwClIufGOM6qw0V87zK
         YVtSm/pNBPr4QlOIPPdwo/P5pzeJPenxsNGTuG3PuBQVj3nQrlQKq6yMUdK0vUJC5dgP
         kPjfnjkknN7bqzdNGAF2VUhCObZ7Hbop7VjIB8COwx76tA6ktDl2xDeSl73WHgm0rB7t
         DxDP2YOJRBEnJxCm9jNBSGTaRlnO4Uy0SPJ6o/Z5DYbPRA8Y+P1CM7/uww+EClvXpfje
         PfwKRu3pXJAQY2Fn9+D++a3zOIVq4thaFxTDOkYA20Uc0ulB3tx6oZUbaK+UFWUJ21Wn
         gVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090332; x=1761695132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OafmaFEEMiW3DYw/6kVfDpX+aIzCwIqDzz1UgpECPjI=;
        b=INhNFef7VVU1cvlY4EzYKeDxXJZvcP+fFe4ijvNcz/rF9jiXYu22WcEMkWMdMUgqgv
         8mPng5NbOLsDSQTFd8aJTe7JUbIT4lWCfonnXSc0NTbOHydiYbxDb1QmwbTu2/fgxu/n
         wBxKgJBSqzwpd67fo3hXEQMgP4BZhUjgpzwWRhAis2ZfXhUOHqYwX2MlpdkTEJLk/bl9
         ptVKA7QSoWA1pRGDp/05kRLKW0l3C6LRlUgchqu62oERE77ydn6PdlQAETVy0ULtKUCi
         vaTELoHb6j5DhGl/hRWxdiXw+q9jZm1yEvO8Jiz9cvH2iE8cJjLpaOUn5vUKjoORLUhP
         uujg==
X-Forwarded-Encrypted: i=1; AJvYcCXsfoFwNAswUx6YpmUuIcanzr18finm+yt+rMIywRSqTefEvXmM5NDc0sR1QSqCPX+UzGSshwyer50777M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0lvXfFGSEnocxQzy9NnoUBzWYAXDdKZ74dgt7rAkFdSQCWdP
	CBiKsEf91PmWRjseJEHSwhrGKdCZiZ6zKX2xcrh3qnR9zsH9w7+8AFCPtMFwLadI/Nk=
X-Gm-Gg: ASbGncsnj45qUhRnzDSFbgC9L1BOoVcMA1ZKIH8JqraG2E+zv85HIEAJel+FO8mh3z2
	nmTqp4wN0gtZT4qmN0bZ/O3DsNyyOeXZMNWLD59ODkL3+LjNkKcPSBQGWlzDIXORZ2SMBuJ8hKC
	+7tNqZyXKlxFz3qAaedp42lXKq4cHg9/f/YP0NBhMT9czqo/udLDaNqLSkNz7WT+TFLTDO0WgFJ
	QjMQupbkdZGvkJkAUnXwbw2i6Lp5UJ9qNT9rjA8CjofoAr1+gQSAJVbIe3o3jLmYHER3QUJs52D
	mpxkNDYMBG9sSojpmDlX9S+UOdhsjeGV2/4Nja+/cb/rXNA5tEDJbVoIJ6hHBe9Vcfy412EI5tI
	OU/WlGR66rgqLZkXg0pplmCEBKQ8wvjQ0Z8nr4cp6+9rT1pKy+JkrnGHtTkNrkbYA3xgL9elmvk
	amhflT4BrNPTJuTxRBZm3ab1UQMtQmBs31NOgkz5vPqexJIgIq9i5lVDjmI3I3VtPRq3t3uWLl8
	fT7qCreaR9FZci2AWW2E7ZEwqRk
X-Google-Smtp-Source: AGHT+IHDFi/uarH0TV/fP4fWWWvcBI7LxoChkgr58/si1RVzykVqlT2kD7TRyiAf+r5B+dX8qqG1Mw==
X-Received: by 2002:a5d:5d02:0:b0:428:3fbb:83ff with SMTP id ffacd0b85a97d-4283fbb8dc6mr6439834f8f.7.1761090331776;
        Tue, 21 Oct 2025 16:45:31 -0700 (PDT)
Received: from linaro.org (host86-130-206-17.range86-130.btcentralplus.com. [86.130.206.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a1056sm22247870f8f.2.2025.10.21.16.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:45:30 -0700 (PDT)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	james.clark@linaro.org,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 1/1] coresight: fix issue where coresight component has no claimtags
Date: Wed, 22 Oct 2025 00:45:20 +0100
Message-Id: <20251021234520.3355-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20251021234520.3355-1-mike.leach@linaro.org>
References: <20251021234520.3355-1-mike.leach@linaro.org>
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
 drivers/hwtracing/coresight/coresight-core.c | 26 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h |  8 ++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 3267192f0c1c..ce4eade8a1e3 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -131,6 +131,22 @@ coresight_find_out_connection(struct coresight_device *csdev,
 	return ERR_PTR(-ENODEV);
 }
 
+/*
+ * Reading CLIAMSET returns  a bitfield representing the number of claim tags
+ * implemented from bit 0 to bit nTag-1, valid bits set to 1.
+ *
+ * Claim protocol requires 2 bits so test for highest bit required,
+ * bit 1 -  CORESIGHT_CLAIM_SELF_HOSTED_BIT
+ *
+ * return true if sufficient claim tags implemented for protocol
+ */
+static bool coresight_claim_tags_implemented_unlocked(struct csdev_access *csa)
+{
+	u32 claim_bits_impl = FIELD_GET(CORESIGHT_CLAIM_BITS_MAX_MASK,
+			 csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMSET));
+	return ((claim_bits_impl & CORESIGHT_CLAIM_SELF_HOSTED_BIT) != 0);
+}
+
 static u32 coresight_read_claim_tags_unlocked(struct coresight_device *csdev)
 {
 	return FIELD_GET(CORESIGHT_CLAIM_MASK,
@@ -156,6 +172,9 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag);
 
 void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa)
 {
+	if (!coresight_claim_tags_implemented_unlocked(csa))
+		return;
+
 	csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
 				     CORESIGHT_CLAIMCLR);
 	isb();
@@ -181,6 +200,10 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
 		return -EINVAL;
 
 	csa = &csdev->access;
+
+	if (!coresight_claim_tags_implemented_unlocked(csa))
+		return 0;
+
 	tag = coresight_read_claim_tags_unlocked(csdev);
 
 	switch (tag) {
@@ -237,6 +260,9 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 	if (WARN_ON(!csdev))
 		return;
 
+	if (!coresight_claim_tags_implemented_unlocked(&csdev->access))
+		return;
+
 	if (coresight_read_claim_tags_unlocked(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
 		coresight_clear_self_claim_tag_unlocked(&csdev->access);
 	else
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 33e22b1ba043..f93cbc9bb36a 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -41,6 +41,14 @@ extern const struct device_type coresight_dev_type[];
 #define CORESIGHT_CLAIM_SELF_HOSTED	2
 #define CORESIGHT_CLAIM_INVALID		3
 
+/*
+ * Coresight specification defines a maximum of 8 claim tag bits.
+ * The precise number is implementation defined, and may be obtained by
+ * reading the CLAIMSET register.
+ */
+#define CORESIGHT_CLAIM_BITS_MAX_MASK	GENMASK(7, 0)
+#define CORESIGHT_CLAIM_SELF_HOSTED_BIT	BIT(1)
+
 #define TIMEOUT_US		100
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
 
-- 
2.32.0


