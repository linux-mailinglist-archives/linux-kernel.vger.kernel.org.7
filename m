Return-Path: <linux-kernel+bounces-778630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11338B2E836
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8355C1BC7129
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA715296BB6;
	Wed, 20 Aug 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkkVofOb"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63D1F91C8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755729546; cv=none; b=YVmS21+lpO+/jh2SKDgwt+TgRMy+zF6xcwYh1ZTF58N1EMp7DZbRJiKui5vx3/tgGdUYGRKqHw+nSzNBwtk+a6kG0aCJ7PwUxhQNmEs2ctnZrwhWuU0k164euRddwWN8C0+V83ycTpXOOhkbOej2QwaVtkS0oI/kI45h9xN1EpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755729546; c=relaxed/simple;
	bh=OARnjVyy4CdXFldyz1GUsDlmrzCrmqGTY6HtBpp9iVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfvUbMMxdNbrYyIBR5AuEESn83OqCp72D6zvk5xNPDPNf+Ny3TfAZOg47Co7ClAuaGpHOwX4GYwP0rFH+12TLF0xpjT6O8ofnF57+GXQXOIoPGbB0bFu1/9YTMSg1ibUfuLGpGm83lXP/ksTJfJTI3QqsqG2zZ4skehIDNsDRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkkVofOb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4717ba0d5dso290105a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755729544; x=1756334344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJAUp0f86jBeS4uWt/dNu5JNfGORO8BSJEV2L8Fn0fw=;
        b=nkkVofObsRr+up8WQ443yTffPqu5bkoFnJ92+Dx4iud4uscgS73nDPYl+XRvKoSD29
         YUkxRyu4NbfoyP4ZFH12imhWVxgEbuhCyOx6iwP7QiMTDIv6njgDo6exD8lxEV32fjwx
         VSDbC6Se7sq1YSD4Y3nnhs4RZGDHlGI3R3B8R3kVNAKQZw6H5imSzPJb3xHv6AKsUoNY
         YSaXqJgP3jBhe0DthKFS1xxAd9SOUkLR4kJ4FWa6Evmil1nEmgqXBIZon/7hEn9xP4DP
         drbsKfbeVALas0KIr+OUEJukT+gscXnySN/SogqyW2OJc0KsMdm9yHBmJoaNpmx0UETY
         0wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755729544; x=1756334344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJAUp0f86jBeS4uWt/dNu5JNfGORO8BSJEV2L8Fn0fw=;
        b=fAdW+7cL5aKp3Kjv62Rtn1CJBNfwpuuXIaxqG5sdpdyLKbOGvJfo2Br5bEDl3bUFhz
         hCj5jI/atUobyrtWa/ef+CVYutkPxw5EGMLZxuHTmnHvXWW95h+NgN7IoPDXneGS1Ogb
         VTiotcZnIVqInePqpM/aWAUdBxozRAkrKvS0cxtO9tJhrNpIO1OleQL0UfR0UYhK37WI
         Z+ard881sZtO5rVyH1hbz0Qsgf77ILvyTsN6iEQCT3DIFphBXndJGT2eZBBggBWe0CtT
         O3FMxv8/ROzC/Y7gqeTJzdP9PEijWuPqXs7OTp9esw7UadbnWD+JO0oajKBrpVqGjGp4
         AeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKscKiQssMIteh+ckIw2zOs5unhQKm9q5zaYKwvl355Gr6E2hPJIBMBxHQs9xQmNV059MOewYqfSdxZss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZe+MMmoMfc0W9oljyjoapGaLPchu9VvzvRhIMDEsmBdZmFpr
	IM5uCuY+41TV8q7rdh4/d4M3ddIIDepZz72FV0tl8hl5F+l6k9N26bF/
X-Gm-Gg: ASbGncvLqSPRUB1gFqkisXBIsGA8KNROBLj2vttpSxXxUAEYQ4AzuXOutOJnV7xOyO5
	rvGa5nPmIOLEgT476lEptt4qgTH0XoxEzhoyEc2pjoRFf3BiHcw34nKkb0a2MWCdXrqI3bOJ9Wy
	oVPXWERaf3CJyCzatmz1do70m9GNTMTA16zeuDsLE/AD9EdRVhj6263/Pr83exYdXoeHlIFWuS0
	VmkoKOETbREduQAFFxKe0OrJxkGLcDbrICTP8q2MixbY7QWMYKG8AduRbsE9r2tX3JRWYUuE6S9
	pJcAkwpxydNhigSgbVploob08ZW4QGeJkgwFh9zYTxWDc+hHHoMuYqYqNN9d70yT+G0P7VZawzw
	nKGT+PEp25CVwecHmlJ7fvs0P2KQNsRn+bdyKMVeUXh0=
X-Google-Smtp-Source: AGHT+IHpteoZV/YEAVlSStTaxwqQKN/L3bbOeivrQziXxVnHiek/V0RyadSpB97WmgxYnLZEVc2G4w==
X-Received: by 2002:a17:903:1a8b:b0:243:a32:1f0d with SMTP id d9443c01a7336-24602e40e54mr2053785ad.18.1755729543830;
        Wed, 20 Aug 2025 15:39:03 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f6f982f3sm19739555ad.23.2025.08.20.15.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:39:03 -0700 (PDT)
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
Subject: [PATCH v3 1/1] mm/cma: add 'available count' and 'total count' to trace_cma_alloc_start
Date: Thu, 21 Aug 2025 06:38:55 +0800
Message-Id: <8a79284879c529f467478552825154b018076e95.1755729178.git.gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755729178.git.gaoxiang17@xiaomi.com>
References: <cover.1755729178.git.gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

This makes cma info more intuitive during debugging.

Show up in the trace as:

	279.814717: cma_alloc_start: name=reserved request_count=4 available_count=8096 total_count=8192 align=0
	309.790580: cma_alloc_start: name=reserved request_count=4 available_count=8092 total_count=8192 align=0
	317.046609: cma_alloc_start: name=reserved request_count=4 available_count=8088 total_count=8192 align=0

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 include/trace/events/cma.h | 19 +++++++++++++------
 mm/cma.c                   |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 383c09f583ac..37195edf2498 100644
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
+		__entry->request_count = request_count;
+		__entry->available_count = available_count;
+		__entry->total_count = total_count;
 		__entry->align = align;
 	),
 
-	TP_printk("name=%s count=%lu align=%u",
+	TP_printk("name=%s request_count=%lu available_count=%lu total_count=%lu align=%u",
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


