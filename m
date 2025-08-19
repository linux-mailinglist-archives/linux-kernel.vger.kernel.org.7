Return-Path: <linux-kernel+bounces-774787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E358B2B77F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C4A3A5D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049C72D5C86;
	Tue, 19 Aug 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzIz/FRu"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0332D3EEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574023; cv=none; b=iwzrxcnWC/kWaj0rqKd7RmQRsPBl9iJ2Rz6o/K4Sx7vkR4FYWM+49Dn6xe3aK1w1Zz0Pir1f6ocf7AhdDET1+RL8SJ8TH+jRauFb8PZXbzQnJ7W4f4pLV7dWvDOvsxBeW/5YlXVGBFstQF0gHRnHwoW3BJlyPfYOVFNTUHBB9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574023; c=relaxed/simple;
	bh=YfJYeNuK5s6n+6K9DDdIvhqVIE3tNH0UjNo9blGT8Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ipaRFpooc9CQwI6hnOB5CbA/Z3Fr/gz1VM/1W/v+BQX8AuOoC6QRm8bCE2WNWwC1RUwvEXVtVvqB33uRqvKNY/CFNjkKHMH97I8nzEP0VhKgBOKRCXD08l5sHo/eB5CNOMq6dWzdlGAHlMrMYBPHbmqzK7jSib0FBU9VFuasa+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzIz/FRu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-244580536efso33746925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755574021; x=1756178821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vr68yBZi3TFfbnXKqi+esYUOPsHcYPZ3pVlLEo5gGLw=;
        b=ZzIz/FRuuKKPXVqpzKcFFcYmHsAAl56spvGbzCnKOdhtcaPbaNFjieTJCFa69i40Gy
         myucmdQcgYhJ1QP2UqAhiVxrnlJNnjFzxGp4vbrJP/RKCeNsSS+FvCRoCGsRDXbN13dr
         0hEmqXJ/cRYEHG0gETdzLIckvCgrUNKEFNAov5XyaIijke1SUvrX+CmB6ADuq9ulqBpY
         d8TNxDghJ4poQUF3c3K6BfIJnSD3FJwN842Q/sXUO8v0dsMDq+MwTtZ5DV2tISmnjgqg
         sPBGNe/HVGDmpAVxy/LmBYx09KeUPeo3tEtK243IZjdH9BaiokiTXXl2MF5zEpUyx4BQ
         CxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574021; x=1756178821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr68yBZi3TFfbnXKqi+esYUOPsHcYPZ3pVlLEo5gGLw=;
        b=v3vv3tw/fDjqJi/cY2XDzQWAFTV82hYZg8R11o4lTix34JC1IOXovDeg1xZGLvWC5F
         7RfxnVMLqF3QQzCymiCFHerb8N8SjkMhvLOPjM1wci4LADc/s6185QKsbFj6la9sfENR
         I5afwLUG9i5CQwLH5hUF89Wi4nVM+V241v40J/HFFd6Ez1lq5oE/eW9s0HAZsAoINV3E
         t3OCoPp7Sy876Cy0VsObkeXMsbKmz6z/usoxJaYnFypV0Qas6riL+W2pVaZFDzWrzZo1
         I4tsEAgSy07SgXNAu7wlb8K86KG6iWk2xJgauT2GTTROSieBZbkvzAvJCV77RByfcy+M
         H99w==
X-Forwarded-Encrypted: i=1; AJvYcCXKuvTqvGxuPA+0jsDoG3ITLppxFeC278rp/Q1rPC6+xqP5yD5Ri3SO60AHC5GPRAbOn2jWx3lMG8OCIPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxpH5Iib7cc49K4lOMXJ2VyWZmvmwCBGTu5GzsU8ElwYXf8D4
	nLE76UXT45VBnzSrK5Jfof4iW4LArPwUCS7Vu7HaKprGuv6qyW9LRFvs
X-Gm-Gg: ASbGnctArKY6PHakr9nxOqb5ckYAKoGfUQXN1NDuX7qdtGvq7TLU8/Cw8EsnkSNw1Sa
	oCi7+NEOQX7nnHT+XBC3kml3JbDH1TZsoWJc8XJHjJoCh+cdWi2GDEaYlGJwH/iOggChkZPzHqe
	GegDPhjJ/YIapBj0JoBPZUKyJuhPBqOqA6qHPs49XUA8q1fF6inaBNw2ZrySSYNCYI10kUf3uVp
	bbh1Vl6ToXMN+ZIZSZUK1odaR3vXxzdSL3O2kYcTp96V+eBsj4rOsttmE/28EP8xlyVeuOZyV/b
	xgLroA+9tlMSnS1Eq17IVeyxdxNs2jIrnWoD/9F9q2ILBHKfOFERl+NroEU3wLLTB+qza/ttDFb
	IxVQO5KCnk7AYCcXRowha1UI5DDeW7JqNdhDYvu3VqKX0PYperRseh2AYvoGLxK82OH2JsZkcyR
	A=
X-Google-Smtp-Source: AGHT+IFwjWO9fZD3g8LIFOJO7X2Wija0jcyJGdc8SrAd/SCDg7XngqtnwRQL5pP5IA0IXoJApdAKBA==
X-Received: by 2002:a17:903:3c4e:b0:23d:fa9a:80ac with SMTP id d9443c01a7336-245e031010dmr12452115ad.16.1755574021175;
        Mon, 18 Aug 2025 20:27:01 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d99csm93979715ad.24.2025.08.18.20.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:27:00 -0700 (PDT)
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
Subject: [PATCH] mm/cma: add available_count and total count in trace_cma_alloc_start
Date: Tue, 19 Aug 2025 11:26:54 +0800
Message-Id: <20250819032654.4345-1-gxxa03070307@gmail.com>
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


