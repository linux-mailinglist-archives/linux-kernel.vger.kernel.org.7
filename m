Return-Path: <linux-kernel+bounces-817710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FD5B5858C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290904C60D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC632882B2;
	Mon, 15 Sep 2025 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXMXHrIP"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84E298CC7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965957; cv=none; b=PmoUMKcTzZTS+lUS9pQgRuFzWQTypqjEkIW3MYIDO6uRHVvWNs4ta8tda223mFZI6uoL8fMM9woOcf2hlyD9g0P8yZFhPKkqlq7+ShWHtyPaTC2A/4D+NVLOqA6cIOntaGFbMh1GFygRLYp5NA7hkA5WVsU8WeZnUrTccHGKOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965957; c=relaxed/simple;
	bh=aKMdDFEMo/oVD6fE5n37VpWwZBts1CGWoQryXnCpJOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pg+rGECRn5kylFxRP5lCVAsrLAdHTESbNmav7I3fZBtxUMa0FGa0okYE1b4r0m6F2ELK+FlHwrGBRHN7/8wFqO4aza7OdwJAQNlQS6obWxC9vJr0p52U2Idp++1Qc1p4HPv3IpN8OX5QLQ7n3KDVnGD3PlnF5j8YLctzTIYGwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXMXHrIP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77422201fd8so3846143b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965956; x=1758570756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+/YCFUq0Yen9BegMvuM42I97kIDxgCZBi/LyO4DIQY=;
        b=MXMXHrIP7R7cskyC29tITw7ljpYYDVtJiJS8oMP9zXIRi3uVwVeLsmfpFI3DFYxtNL
         efuEbSUoP1jMOeEDATMjSoH+nrkr09s4VMnMEwQlDO2x3KX6cfjpHVxRVBYeMtsTN5xF
         VTvXdd8w8E+ygftuzu3PyKwGmKiXe61h0HJMKYlvfyOt3Nhprefjf/CRPMEVN3msZlPj
         q7QGdd+ElFRWc0mRJ3btRCI0AxhGll57FZEEcniofwAHq92WyjSoOcCdifn9bfwXDI5n
         oG6G6e0gl+jxtadaWE/CBsHNW3scmDF1ADpzCnUUSXDPPDxBolX/YPhNILnOqt6/WbiF
         52ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965956; x=1758570756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+/YCFUq0Yen9BegMvuM42I97kIDxgCZBi/LyO4DIQY=;
        b=JXg5IbvoYN1hxFU6bRWk+oOj/pINXwrLwLpUiVGjXY+Gh08wZ+6GSLb43NQ2ZYVRZR
         1frLzFf+gxKxqSUUpBP+YYNOhWEh8WB23SsFIWlXvOYKeowK5nP6jP6qIU40D2RwdvTF
         0zlHqkk/2z9niHXKS95Y0MrKUu0Qc/xOcD8vUEIUCNF/ryHMplQnZuxjWnbWWJ1TpuBo
         SRobj/QejlMyLDkZxNpd/Cmoj/gf5DI3n7OJiyLrnFr5Z9YMDxMOTYRq5reRGNjKZAjj
         HTGjAG+4TGJZqRnQpicNOZY00ymW0Or50mbjbT5+QKINef0LL3272uStGTybA1qNdz39
         9t2A==
X-Forwarded-Encrypted: i=1; AJvYcCUDrntvNWCj0jOwLsnhx/Z2xGN8aG/wWFg4Quts1MoSINnrkVAcrzlIwjkGqxzL6H4E6kxhk2iwjCanZW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wLhWk0kSU2o5G3uubqTb+as0A1D1ICb7Ydp6opVlP4UgzrQP
	yaFqeD96I17oL2PVtR+f5BOB/XDYEEzUn4EvSYYIezK8Qf7th0kRQ63O4S9y8VKnyh1/uSBiMg=
	=
X-Google-Smtp-Source: AGHT+IELU+Ic0v9pK24z6KtPtYVZqHgqvjb+y/T+z6SpzU6YQC5S9+eHZfr6wIXl6+CEbQ7nMg5OLJCk
X-Received: from pjab9.prod.google.com ([2002:a17:90a:1009:b0:32e:d02:d541])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da9:b0:262:6310:3fb9
 with SMTP id adf61e73a8af0-26263104373mr10578957637.34.1757965955716; Mon, 15
 Sep 2025 12:52:35 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:52 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-12-fvdl@google.com>
Subject: [RFC PATCH 11/12] mm/cma: rebalance CMA when changing cma_first_limit
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

To keep things consistent, rebalance CMA when changing the
cma_first_limit sysctl.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/page_alloc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dc59aaa63ae6..da1cab63995c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6640,6 +6640,24 @@ static int percpu_pagelist_high_fraction_sysctl_handler(const struct ctl_table *
 	return ret;
 }
 
+#ifdef CONFIG_CMA
+static int cma_first_limit_sysctl_handler(const struct ctl_table *table,
+				int write, void *buffer, size_t *length,
+				loff_t *ppos)
+{
+	int ret, nid;
+
+	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (ret || !write)
+		return ret;
+
+	for_each_node_state(nid, N_MEMORY)
+		balance_node_cma(nid, NULL);
+
+	return 0;
+}
+#endif
+
 static const struct ctl_table page_alloc_sysctl_table[] = {
 	{
 		.procname	= "min_free_kbytes",
@@ -6723,7 +6741,7 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.data		= &cma_first_limit,
 		.maxlen		= sizeof(cma_first_limit),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= cma_first_limit_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
-- 
2.51.0.384.g4c02a37b29-goog


