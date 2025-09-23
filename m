Return-Path: <linux-kernel+bounces-828694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E73B95370
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A16817A524
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8C31A06F;
	Tue, 23 Sep 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW4FKGuP"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6531400E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619208; cv=none; b=PEftM+A77Qft2uSbrBnSqnglwmqzKWBUmr5DSA06FJBQ5bsd65exMRUD4VJ7svlMjtcRBjHg0dYOfQrYiFmpahPSR0RjHU6GvUbPnRjwy+OnAlrWo4yplkVbjIgQKXXlODx99Hyerz7hUEXr/0SR6lv6MwgvW/SFOHw59SEKi4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619208; c=relaxed/simple;
	bh=CFGQIdYFoGZnnU6HvNyb+l/ee08KR/O3dY2p3tvi2KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qenUQwJzEhuLXFeWhGKvN/qpLEQ+1sQTpX5pNNEZGXMIIzSrRxy1mfaIsx3WyJxyaR5X640bPTSoqTZSuwQzESCvUlZnsQwIHicTzYryPi7rZnDJI4iJXsRaTYVfjXpZrGaaDGRjUnJWJDCTH9xHkHk6yKz7qeocFOmMvPnw15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW4FKGuP; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77716518125so2780996b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619206; x=1759224006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dhwpit34XfPXoxddyaGU725cO1ftVUG1qXMhrs3MVM=;
        b=SW4FKGuPfURhChAQQBLyYIK+tcDYGYl0M6QbnAaZRjGcN3zq9TkEDQp6joJ56Mtjf/
         S+PZqpilRK6bDAR7Mf5UD7MBfa0rhwQG4aajfvyRUypK2pMSZhtiyNhOxEigI3WvhUF0
         sQe25yX+gG0jK3G90K0OMZz9A6oICn2tvXaDczPSVL5yXfgLI9FfK9Z6jiTe0lWEa/Er
         rY6yxP2GBqWE9yol6GNiprdCpVHqKwFal9wrZqnY0Zd1b6OckGGEGmUWla5AXbch/XwG
         srs1zWsPDozhYjg50BWMVlg59vREJc9wKtEZW7s//A7l3oZkdfVDBGoynVhaawrXTWFG
         SloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619206; x=1759224006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dhwpit34XfPXoxddyaGU725cO1ftVUG1qXMhrs3MVM=;
        b=WjUvUagL8nQvOkuUaPgUAE8yYTpBY7w9L8Hd/f8uDJmC3V6VySwvwop5NVWIEglS4W
         bKy9AUqsc93B1Ja44SYfh8dnyE+nB5ytCDckrlgW1udr0XaRR9xNSfTATanFlcfrX4Eq
         ITLpfs7VGrATiDjy44X2DuZ1QxFevNHMcTbq/recO+wnt6Lei6gOEsE+GSASNExl+CTE
         IPlD5ReH7YNYMZqm1/ZArDbgSUP8uUEwDFEFDqEqcJawl4f9UvSRSNS1gwcCKyiT5LUh
         D4m82/spPhGDf9Ukl3aejGgV5aU5eYFU8rMLZQ8e5mGndm3y89W+GZWBgiVeSqhU6aF8
         3Iwg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Xa7A6zM41+WhepYnR6va4FbuDP8cjbyOxWlxBqLqrrH0t34It5y4fx+O0BHKJ5LEa9JIiAX462qhxNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzrY3Qx6stb15Sa4HJqpVKyF2tbhm2d5oTNUirfMtbUxdi0m59
	9YjgL33b29Ls0uUV4XVo8nkV2NFcqrG8U5dnuOsJRvJolN66UTC8hX5s
X-Gm-Gg: ASbGncuG5HAN4zqZZkO1wnRGZN3cbGKxml3puD/gBWpXGd3LzX7bZWPlocSb0DO9kQI
	1pf3dZEUj/B6MlW4iVy6TrsSF0S+N4CbYYTBjBGmq5IwF17mrilF0gcS4A/Dcj76K8xtGkvS3br
	Oi6YL8KUrl8cxmK2JrVgqJpyiPWMw7a2YmUtaDYjDM8vf+7tea+60eYIr/Sm/zvJp6DyVem/5CV
	EJ9xoK8APUliO1JY53bck3/2RDyQKwhjOnrU+vocPtLzsnO3Hgk3h0W178cjamsQt0pRzpRkydx
	IMUNErreNDmY8/gxxDgusV0RNCs5VZHpZtwnre1ISkFWN0nWti6zwiAuIw+mGmpoqnZzwVxY/9S
	IB6/lwouwUG4LJAt2Oc0=
X-Google-Smtp-Source: AGHT+IGN+oSAolzbRO4iqlc6th7lLVX5x7Ige0JdxEZG8Rmzq2x+xKdBh/O3pTSpSmY3qaBwUhTWFw==
X-Received: by 2002:a05:6a20:a11a:b0:263:af5:f1c0 with SMTP id adf61e73a8af0-2cfe2a5d75cmr2793346637.15.1758619206429;
        Tue, 23 Sep 2025 02:20:06 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm14114941b3a.82.2025.09.23.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:20:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to fprobe_fgraph_entry
Date: Tue, 23 Sep 2025 17:20:00 +0800
Message-ID: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fprobe_entry() is used by fgraph_ops, so rename it to
fprobe_fgraph_entry to be more distinctive.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/fprobe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6a205903b1ed..1785fba367c9 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,8 +254,8 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-			struct ftrace_regs *fregs)
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
@@ -340,7 +340,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-NOKPROBE_SYMBOL(fprobe_entry);
+NOKPROBE_SYMBOL(fprobe_fgraph_entry);
 
 static void fprobe_return(struct ftrace_graph_ret *trace,
 			  struct fgraph_ops *gops,
@@ -379,7 +379,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_entry,
+	.entryfunc	= fprobe_fgraph_entry,
 	.retfunc	= fprobe_return,
 };
 static int fprobe_graph_active;
-- 
2.51.0


