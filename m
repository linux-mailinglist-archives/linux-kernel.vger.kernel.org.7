Return-Path: <linux-kernel+bounces-829876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3EB981A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26A2175E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDDD225785;
	Wed, 24 Sep 2025 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmylvc5F"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378054317D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682563; cv=none; b=ferUPWtoFjLk5oPiOOdphF2RydlweCVRWlw4cjRS+hC69RyLSt7+cUaqrQu7pBbLbYodfg4FpGY5mWFOcru8ih+3Izu2QSzJoWtIFoY+XMexPi18fNVpPqwlycUprlstaB+hOzK+6gaQ669DO09ru7Dc69TPkNqYgdc/KbuAWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682563; c=relaxed/simple;
	bh=LP1aZBun3+jkx15ojdj7Rjv65YT07JMoONCYxkI1Gow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4hqxsffgJL4hH7b94JXZTdVTh/Gc/jJ0hb6MEwBWaXeCYSVGd1Uo2h+TciALmeQZoVJM7zJd7yTJ1W0m7kgTd/W/210Uf0SefHGu3RPRkUpd7A4Ke/inWXlMzj0H7Cb0loj4AXJJ/pFHg7dFsegGLI/uqBL2m2GuRcW7yf37rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmylvc5F; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-77f67ba775aso500393b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758682561; x=1759287361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMRETXGFwNVU6M9wzPozyz3115l+hikl117Pr5fgesY=;
        b=nmylvc5FW7xoGzJxyEwoyPrwZH7RtfR9YNnob3HIx8ud1izMxnCTVa+ZAqqOUOy5xa
         Qxj+MQ3kIecTrlVbdNxWN+lX85hcdrR+07yamutM9tlbGl6tIt6lEQuhHD7e92812FVU
         AK8Vxxl8/9GsCnV21dpYgpUIR2lON58ZgwyrpSlElU3ocYcbOcn7dJkmQoQJHbNfAvIA
         2pGzOBwvwcrlGElbs1vbJ03G7IEeLuM49JJAdZHFYYkuP7mwdJySKlPiqsCHiRmhN5Ib
         qCdvzRJOrNDW3pWnMxHA8+PB0Wa/9fAKfNaRJ8ADHK2ANAElLJkqQaPLLOL96XC09hmB
         UhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758682561; x=1759287361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMRETXGFwNVU6M9wzPozyz3115l+hikl117Pr5fgesY=;
        b=jLDWzBlD9iDcxrmpP3SYqZexVM/Ogh0lFAaZhv0/eEERJH6DW53Po1DqfW0CZLoH1H
         YYF43opZoY2QThhlYaRtwihR264/DDiLjq+yERJmI/dgi2AqHuRyxI2oEQDyzFjTPK6x
         HfbiqzgRyFr+9a+nqgoz96meQlIejt2qKNBN6vzrVwXDQxbnxeE6TcDLq9E/iMBckOfa
         O53u5m7bnauh8ZslhC1rhGmqidP7NjSijwVAvmN36vojrJwmWZ7TZSI8tqG5tuU7oYda
         Ake9kCtifJt9zsYcWQFkNCRW/s6/P8DQe9cq9EpDcdFS5iOPgYB/3A0Au3uzBZHjKID0
         OuDQ==
X-Gm-Message-State: AOJu0Yy5B5MM3zfdxNiIE83Kn+Qor35H4pYSufTOnIZuKuitsvRnN7+8
	ZbOuFQbXTH6q2J21oMam9RSF8o36awNwIl9RqUeO9xUJWtEXW7ida2ka
X-Gm-Gg: ASbGnctV3g9I0AOx/NL3wtD3uO+S0lOTL/EBIOn0XmrBNNvTmWQRD5A93qOAJu6azAk
	AJ5qn0+MwbO1oLBXvrT/xh/EM+T5aJcaun8t6+aNzW6rJz0oV2zMdpK1B+HGSJdO0UG72duv5FW
	H6qlyG8XStjzSCGs1GIlI1Gyb8ff2sqdHRwNb8i08uEyIyYWN3suj4RmkLCi+4WlFRJuEsK7joQ
	xBksIU5AT/ULZKtRdii58w3toSbFYk5XZYPC4NSOrVEqyog1CjldxB3g/Kej+qh0PMA3L0TUFwu
	RkfPqR/vbENSm8UPRAH2kxdSFveWc+rR11SS2/6AIsAR8Sik0FF76QsdaLU9sj1UhnRbzlxwG7w
	H/8nu3JaVYJCKXgwudz8Y4HUImEp3NB55u0aQmw5vq1kvqKiOBJk=
X-Google-Smtp-Source: AGHT+IGLsfif3M4Ae4fPfWq/9xMybr4m101+Ydzhkc+JwMmsr4jfwrdsMRN2wX6BznHZWqUGI72+hA==
X-Received: by 2002:a05:6a00:228b:b0:772:5513:ba3b with SMTP id d2e1a72fcca58-77f5388d637mr5388097b3a.5.1758682561472;
        Tue, 23 Sep 2025 19:56:01 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f613dbc5csm1619042b3a.59.2025.09.23.19.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:56:01 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v2 2/2] selinux: improve bucket distribution uniformity of avc_hash()
Date: Wed, 24 Sep 2025 10:55:53 +0800
Message-ID: <5188e81963654bbe9d1e70fe6370a38fdf4ae677.1758633723.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758633723.git.zhanghongru@xiaomi.com>
References: <cover.1758633723.git.zhanghongru@xiaomi.com>
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

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 security/selinux/avc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7a7f88012865..d08f30d57bac 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -146,9 +146,23 @@ static struct kmem_cache *avc_xperms_data_cachep __ro_after_init;
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
+#define C1 0x9E3779B9	/* 2^32 * Golden Ratio, classic constant for Knuth's
+			   multiplicative hashing */
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


