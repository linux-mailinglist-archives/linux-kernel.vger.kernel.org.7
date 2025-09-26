Return-Path: <linux-kernel+bounces-833640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2BBA2863
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484C938402D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032FB27B341;
	Fri, 26 Sep 2025 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAqJU7u/"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0527A12D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867823; cv=none; b=bfYUhfI0NM79NAreXseJe2XzpXHJs2+tH6BvkpXCBFchxjaKjUGhekKZZGUyknWT5Qn6rURwqOiUhy/p9SOOcmK+xlsw+zL52buMaOCUAP/mtzRYQ2tQV+Zl6RvDMVEzwlm9A3LNL+8GQBhy9rvAw6yo1aTSsrbSBULd8PiOr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867823; c=relaxed/simple;
	bh=u6Sq2YURwtuu5QNEEMlKl7xX/uAJZnHBmjr5auxbeg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGC6tMMkZ1AaDqJ3kpCYTXl4RIimMk2KIsdIY78n5N1B4ElK448cSSolAep2HVyI7flb1Q2+MxWQf9mTV30jDpX5f0GsyGxXWjo1H7xzZgxLCLqdWof6UE9EFOqhicIvIvVfoLf175pTNCj2SIHKM6do3kgFQP7WC+gtufeb/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAqJU7u/; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-26e68904f0eso19575175ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758867820; x=1759472620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+IWmkPAlMQiBvEu/U0MvJdvKLaUfjFQa+8mon/ZBiY=;
        b=OAqJU7u/21pfPzvaNE3Epov7BHffzNaL6Uoe3nRutQsaq6BL1pFFv70v3Ac3xZlGUO
         L37/zEPR9sMrjEyk0jQ/lX/iNvaMdyZUDoxZ40UqDb1uVDp2KTq3J4TTxwf9Ti3RB/q9
         j9Prubd0l76GWkjdW6WPfoPEwTqCB3ImGwtcKy2uAOVamHPnis+/boeCYrZ1oXrDSsh6
         eqZFAZJ8u9MzO7b2RHxuUW4Qxz+FQxUwj++X8YI8nZAM10O049JryjX6g+Qd07Bs4hk/
         la5O/0VXEUySt13VhbAeligm7sP+EkLWubEGvIjnUX1MWZsd73yrkHlOoW4noYiXjRmg
         vR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758867820; x=1759472620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+IWmkPAlMQiBvEu/U0MvJdvKLaUfjFQa+8mon/ZBiY=;
        b=XthRWeW3FQ9zA6snuBym8XPbR5kyZ5uObplwOAGkWQDEj/TsskRSL7bCmwyWD0vj/0
         TqRS4gkQrGoHg0E5bbl1iOpwUN7UkPT0Le2YdaxeSB0z7bTxU6RGaFm/n7sR3JRQ7jjH
         qCiRdWhqZgAl52saoGAstbW/hMXn7vfIuxTmlKMjSefSr/XuokabXHoFECO5D4Y1LMQk
         zsnXCYZL3q4viMcLePMTnnJsNi3w+1F/QbPyKewUoRMJUkHwISvsf5rSNEiYiUfa5lgw
         QSKXmXCiiQ9JU/MnCZXhJABk/RtotLGSW62glCNipeFuRTV5cXQAaxD6uSlUMe43ReFp
         yRow==
X-Gm-Message-State: AOJu0YwDl7p4ArlgR0cWZHr7ERg/okXuYs0nM9vzyuDh1qvNFcOfkUdB
	cc8/w03M+m5Kgv6l1cz+XYytuL7O+S+CsE074kd+pAd/YuMAipPFBRJC
X-Gm-Gg: ASbGnctCOyaqJK0jVlQ8YegfBHkaty3FCV+uLiiJaXuUpSVqeBsNtM8z5jSlNl6pBgK
	YdVAjd+rla1Rx/hWO2bzZu4M2B8hT0jd2yG0EYKLrIMYUg3J8RMqlmHyeYqt06qFbSW+xwYrfbL
	qEch3dO8XN2XFeXLVgXHkl4yMrmbQFZQMPjyIjRj9S7M0rCQQLUkA8WCJPOpT4oXu4oNC+uZf2R
	jfxCRNtSTTqyaUDwrp4JrLqJrSiNqK7riE2rimp6ghn783kyntOQkl/A9I44bBvGYaHGCAE4kt5
	uAfAmFqudkUIBGgQozCNoZ+9YzJM0qtYiAuimEjnkGyqkro37ktolM3qa8iSywM/ZN+6TWV3NSh
	nHt/S5D6EyzPohry5K/kR/7OCb2iuoM6oAiXP/oktAy/zPeM9thE=
X-Google-Smtp-Source: AGHT+IGMdkjfopWJVTl5U8eSEKamt5UYh2lxs0dBr+wzV2Rf8C6wXp6A4BGv3sEN+utd4O11ehuJeA==
X-Received: by 2002:a17:903:37cf:b0:27d:69de:edca with SMTP id d9443c01a7336-27ed4a16b89mr67720485ad.13.1758867820429;
        Thu, 25 Sep 2025 23:23:40 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69ab0aesm42856845ad.113.2025.09.25.23.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:23:40 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v3 2/2] selinux: improve bucket distribution uniformity of avc_hash()
Date: Fri, 26 Sep 2025 14:23:33 +0800
Message-ID: <000bce8f11d06684f70a29705dfd417747475b1a.1758859391.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758859391.git.zhanghongru@xiaomi.com>
References: <cover.1758859391.git.zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

Under heavy stress testing (on an 8-core system sustaining over 50,000
authentication events per second), sample once per second and take the
mean of 1800 samples:

1. Bucket utilization rate and length of longest chain
+--------------------------+-----------------------------------------+
|                          | bucket utilization rate / longest chain |
|                          +--------------------+--------------------+
|                          |      no-patch      |     with-patch     |
+--------------------------+--------------------+--------------------+
|  512 nodes,  512 buckets |      52.5%/7.5     |     58.2%/6.2      |
+--------------------------+--------------------+--------------------+
| 1024 nodes,  512 buckets |      68.9%/12.1    |     82.4%/8.9      |
+--------------------------+--------------------+--------------------+
| 2048 nodes,  512 buckets |      83.7%/19.4    |     94.8%/15.2     |
+--------------------------+--------------------+--------------------+
| 8192 nodes, 8192 buckets |      49.5%/11.4    |     61.9%/6.6      |
+--------------------------+--------------------+--------------------+

2. avc_search_node latency (total latency of hash operation and table
lookup)
+--------------------------+-----------------------------------------+
|                          |   latency of function avc_search_node   |
|                          +--------------------+--------------------+
|                          |      no-patch      |     with-patch     |
+--------------------------+--------------------+--------------------+
|  512 nodes,  512 buckets |        87ns        |        79ns        |
+--------------------------+--------------------+--------------------+
| 1024 nodes,  512 buckets |        97ns        |        91ns        |
+--------------------------+--------------------+--------------------+
| 2048 nodes,  512 buckets |       118ns        |       110ns        |
+--------------------------+--------------------+--------------------+
| 8192 nodes, 8192 buckets |       106ns        |        94ns        |
+--------------------------+--------------------+--------------------+

Although the multiplication in the new hash algorithm has higher overhead
than the bitwise operations in the original algorithm, the data shows
that the new algorithm achieves better distribution, reducing average
lookup time. Consequently, the total latency of hashing and table lookup
is lower than before.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 security/selinux/avc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7a7f88012865..fc631d1097bc 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -146,9 +146,24 @@ static struct kmem_cache *avc_xperms_data_cachep __ro_after_init;
 static struct kmem_cache *avc_xperms_decision_cachep __ro_after_init;
 static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
+/*
+ * Advantages of this hash design:
+ *     - Minimized collisions: Different inputs won't produce similar
+ *       contributions
+ *     - Bit diffusion: Each constant effectively scrambles input bits
+ *     - Mathematical guarantee: These constants are theoretically analyzed
+ *       and empirically validated
+ *     - Complementarity: Three constants complement each other at the
+ *       binary level
+ */
+#define C1 0x9E3779B9	/* 2^32 multiplied by Golden Ratio, classic constant
+			 * for Knuth's multiplicative hashing
+			 */
+#define C2 0x85EBCA77	/* Large prime-like properties */
+#define C3 0xC2B2AE35	/* Large prime-like properties, MurmurHash3 constant */
 static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
+	return (ssid * C1 + tsid * C2 + tclass * C3) & (avc_cache_slots - 1);
 }
 
 /**
-- 
2.43.0


