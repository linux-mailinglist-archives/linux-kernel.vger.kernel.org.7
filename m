Return-Path: <linux-kernel+bounces-775897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECFB2C640
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89886563179
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6766A3375CF;
	Tue, 19 Aug 2025 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/JDhJjk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5B19C540
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611307; cv=none; b=jLeKzeuEl0tx1SdExtF3gsGOr/S1Y1qTxQxIZ5nKQ8AoUS/+u4f122+JmjUcV4Ej/0u9airkIXebcntijdQshamOOBvK1ftogvQeI7STJ79G7r6AO6rTatvCvwAMK9ClkMoMuADxR0C728uocIKKiIJ215MdnmMi0S6wEdKmoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611307; c=relaxed/simple;
	bh=YfJYeNuK5s6n+6K9DDdIvhqVIE3tNH0UjNo9blGT8Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cN5REU8d6j0f6Te4w85sP55/fQurAZwrYKKjBY3nlbbvtUnmDMBCoIH46PRoHyVnox+4aCXuUiby8zhud9pqTDW7MdJ1epv/lvim2MffYtf7EmPu0FCWh3+iXv/eAtUPxD6sidJcFjgJqRj6lESSk8wCNjsa4+F16ETK3pr7L0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/JDhJjk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so4691417a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755611305; x=1756216105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vr68yBZi3TFfbnXKqi+esYUOPsHcYPZ3pVlLEo5gGLw=;
        b=m/JDhJjkg85K+05RA7Cbte1+/q3Q+VKwQVmP1XjGw25k61fppsu9ajG7GHBXyQE0xg
         waAC82LD+9V4AVttf2fgNjt0mWg8skf1NPaeXddCUhtoZXA1JE/JOFup2/PKJhK1QkZ0
         cAVqvTqlmnmfuWm2WmaCEPb9b/56kObO3UZYtdagqcDXBgi9zwFCW4Vm7L3kwfl3e6LH
         ss6IQ6kISfsQwjoHsBYpqV18Cyx1WTq0Pg14eTYNq4RMYydnYqnaFMuxE/c65v53He8f
         pPtgkeLAlpoSm42X2pA/EY5gVGCbAcomVEqQkJCNGmvJZTJ5k2wcYbmOpoYxt7nEePgK
         ArIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611305; x=1756216105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr68yBZi3TFfbnXKqi+esYUOPsHcYPZ3pVlLEo5gGLw=;
        b=gOHEVAOmtkVER1ln2HuLAX456vSpQBNqAY+HYqDN7LIJGgyqdJ937drnfmdcSsRAnN
         7MnSe4iJMhzgQHODHxeLiavvNWB5XMi8sMXnFj4sFMnnt3mwtKCoQGkdjQ1pv3PmCTx8
         6AqQboT3rf99tDkMgEredcsFibvF32YLGbUjNybxjSLTkKVzh/yR1Yx26atat8BzgWDt
         cRmuPS46Xbx1bvameZUl3EBHUrZ/p0CfOp1YQl+manCIDJU99XIVn2LBJmk1YA7b4+Vy
         6ThqtGvti2M/AlDT+gw0iI6QPotGOnX1Xfz63nPFPK8UXnQuHdgZxh8xkbQ9oCnKZuT1
         qDBA==
X-Forwarded-Encrypted: i=1; AJvYcCWtDp+2YbfLt97du3Ih6PgzLeeLbtiartHPcEqWDLWfeV4KPDjf0Z/jl9RmcCRQSxOdP9en7FLT+HJ4k9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOXvl9CUO+/0prnd7uX1mCxQdOMbH7ojSTRNDm3HEMPlLwd6z
	0I2ldRQ9FOgLpX9za5q38mddEzLgH3fBUMddrWBxaJaDbsyWtwTtCY8HTO9qzadD
X-Gm-Gg: ASbGncve4XO+uztnXC0pntoUS9zPKaWO61CJnHGBpBF7McM42g7M2esGykeD2fKZO8n
	FA3rBTqx6ElKY3v819b+9ovoSyL2yd8fTvbSUsOxWRHYFWfrEFgxSquc4mZEhxKQXUwp/WwNnN2
	XuBdCGSXlR8z2TtMxAneREH9euEshKKNVEpSAGXFFcYTId49pWD6dfVU1ommf+6PY8pnkmCh9ln
	hzr0hhAIsiJgFJx0s+lJe8FPQsmrDRREoPBidQdB9lk9YDzk9ITSdaBHC3HV9Ly5qksE24JbrKp
	RtTKBtLmXPU+JTs2SkHFsIn0GEvElJ7DqyHYlDhYqq/esIubgJpFlNR5usTtI3Il4+l/bapXx2n
	GRBQz+KN/PJRbVGKG6vKa2toJNcKWhs81
X-Google-Smtp-Source: AGHT+IFmyQHU0KuB7WvcyotnFbvRy12e45ykFdU1u5ZoWix/rIQxSCTZPZ3xcSSDMU+wjxXxseQ9Pw==
X-Received: by 2002:a17:90a:da87:b0:321:3715:9a3 with SMTP id 98e67ed59e1d1-324d37ea418mr3137717a91.17.1755611305484;
        Tue, 19 Aug 2025 06:48:25 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5ad0f7sm10719364a12.2.2025.08.19.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:48:24 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH] mm/cma: add 'available count' and 'total count' to trace_cma_alloc_start
Date: Tue, 19 Aug 2025 21:48:17 +0800
Message-Id: <20250819134817.247495-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

This makes cma info more intuitive during debugging.

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 include/trace/events/cma.h | 17 ++++++++++++-----
 mm/cma.c                   |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 383c09f583ac..fbe70008ffc7 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -38,25 +38,32 @@ TRACE_EVENT(cma_release,
 
 TRACE_EVENT(cma_alloc_start,
 
-	TP_PROTO(const char *name, unsigned long count, unsigned int align),
+	TP_PROTO(const char *name, unsigned long request_count, unsigned long available_count,
+		unsigned long total_count, unsigned int align),
 
-	TP_ARGS(name, count, align),
+	TP_ARGS(name, request_count, available_count, total_count, align),
 
 	TP_STRUCT__entry(
 		__string(name, name)
-		__field(unsigned long, count)
+		__field(unsigned long, request_count)
+		__field(unsigned long, available_count)
+		__field(unsigned long, total_count)
 		__field(unsigned int, align)
 	),
 
 	TP_fast_assign(
 		__assign_str(name);
-		__entry->count = count;
+		__entry->count = request_count;
+		__entry->available_count = available_count;
+		__entry->total_count = total_count;
 		__entry->align = align;
 	),
 
 	TP_printk("name=%s count=%lu align=%u",
 		  __get_str(name),
-		  __entry->count,
+		  __entry->request_count,
+		  __entry->available_count,
+		  __entry->total_count,
 		  __entry->align)
 );
 
diff --git a/mm/cma.c b/mm/cma.c
index 2ffa4befb99a..e56ec64d0567 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -864,7 +864,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 	if (!count)
 		return page;
 
-	trace_cma_alloc_start(name, count, align);
+	trace_cma_alloc_start(name, count, cma->available_count, cma->count, align);
 
 	for (r = 0; r < cma->nranges; r++) {
 		page = NULL;
-- 
2.34.1


