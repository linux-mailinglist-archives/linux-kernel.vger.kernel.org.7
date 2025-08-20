Return-Path: <linux-kernel+bounces-776799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342EB2D19C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C30B582ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941B12773CC;
	Wed, 20 Aug 2025 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTN7pK8o"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93100277026
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654816; cv=none; b=CsnIOtCWO7T0xFpEBgVbqrLzKdx8uoQY1fjRGdTo7vZuSySAofk9J/33ivrWHVITWI+Yv7ah4if27HdSiCc46Vx4CkPzTNC3DN8KCfTdC5/Ze8mPiKdenH10hy1njWoAz3a78r/Tp1byfpyGjtpbC1dJ5m7UeO9TAWfQUtZsdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654816; c=relaxed/simple;
	bh=ZNwi/yEuUi87jYWfZ2YxZJWmAjNGJdigA0EKwFHkr9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMSTNb0JWIm2bmMYzTORwWjFxrNwZFTlCaAWABZaXt80VwO+dElqUk5EJqywPaeedJS5o8lq5SzEbq3zfmPjkdVwOmO5pAzgL8Z7MvMUU5F0BdOSte6hdTiGd02BY7VdLbIh/tBBBMDw1NsIaNFU8HSsHNSoudq0AJncHW3CZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTN7pK8o; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so3893947b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755654814; x=1756259614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c1D99Xbmak+B110RHN1ZX6H5hATGTeflPPiUc4DEOQ=;
        b=JTN7pK8o0ATP8n4YRIlHeGtVrBv6li4BlntLv/1o/vgzxpbVyJvi+3Jt0IuYRylfLO
         AhAl1ywpOcro6e7TsJeYO5c4x7MUHtbPVuzMRy/7lydgtAXAyZWpubQIgGciFB0VQRzB
         CK2RxncQBwPa+34x4734hwDaMPIOpiTPxrDbQ8tWqmO+jOHBxjtML13zYuq6EE4UkkMz
         sb+/RwSoEuqNQqkKNU0lCiLyM4ULaCwda7dmbzqLGKwJzqOoZRjwhQrxKZajd8M5xHlY
         VyV5NpM01i/PW048QguCBWh/P7H8jyShRYNT3p7PKdoRX0dWBdcOerDEuYwHUzR+GY7o
         puTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755654814; x=1756259614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c1D99Xbmak+B110RHN1ZX6H5hATGTeflPPiUc4DEOQ=;
        b=kPEMZWT8b/5JA4WoOwMSlNUcSC5oAl/kUaAfw2P9kG2lTBRplOeEsmOI0H2mSnaRQh
         d4MxkKZ3qXFnM4XhY4YM3DbobJQRZMU/FqZOgK06+CStMZYpEC5Jlqov6Tczpu6FBGJb
         YZxE6k1sFIet4dVAOZduc+RnbxQG6Zb1l0fBrMcEobOgs8LvzEu5l9+yu/zZF/cEmT3R
         uswgKd7P4Qd9T5lR5ecCOTV+MuWYtzY9H++qDkSyRM9vJTGD8/vzJRAr84oaDXSL8XxG
         8s3pYph7XPXqBTt+TBk+BRoshVEi5iTaLIeW4u+TvQPlRhEizJopGnKasQHy83YWlY92
         zJkA==
X-Forwarded-Encrypted: i=1; AJvYcCXjSlKvWcYAXGatIIxgpM60XQIkCZikxtouI9cDpmoD0Kz+3PQXx/kJWf0IWrmaT+VKB277ghw819D2M54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZnAoTQGIbtJehOtFIf0NhqPaVsHTBcn473pId+qHdz4fqruVm
	zZlMCONl4Y7lIGuT4RieiuCbkttBsuzl4xWEh6B59Td5cep+vow2fGNa
X-Gm-Gg: ASbGncsNkOsnYN6kfxA8ElOBOlzlURMa82s+Rp2ePhXTzheE8559Helcibtn1y6LhmV
	+ktibbBUZW2KKMjuryKCLyUJbCcfxDiuHC55BAxdQkBNPBMMDfl0LJEEFs97Fu1bepYL1fIyq+i
	Fu/zqQ0iy3mYxWKp/tnFLh/OIe9VYFyEiYCErXBocKlpF/EN8zo9HKLdaJ47EE7ZsVEZR2uiy1K
	8Ve+Un/CT5WuBxU2LMJyFAO9XzOFQTCTpxXQ/5ykibJLXT7x2iOpnp3eXqwNg1pmznOluidLF0I
	Eg108ZPHVA5DdzKFrwMsxhFrEH5910r+G4eLRPmYwkNXC/smrS1Z7n3WPioiPFS0+ONsw1oS1nF
	mZl8ZE8Ygk9RgT0oepwTj/dV+OCfjpDDr
X-Google-Smtp-Source: AGHT+IGq2iFdP7a8AR7YmJmB0ZO+5+HaC+y6WtFG4B6TW1nA4UBSlu7RjV3jcs06N4nOxPKn3zzXNw==
X-Received: by 2002:a05:6a00:22d1:b0:76e:885a:c32b with SMTP id d2e1a72fcca58-76e8ddf4504mr1560582b3a.25.1755654813778;
        Tue, 19 Aug 2025 18:53:33 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d541c68sm3784244b3a.93.2025.08.19.18.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 18:53:33 -0700 (PDT)
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
Subject: [PATCH v2 1/1] mm/cma: add 'available count' and 'total count' to trace_cma_alloc_start
Date: Wed, 20 Aug 2025 09:53:26 +0800
Message-Id: <d30f91137e3a296152463ea65474e1ca56f4eda3.1755654367.git.gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755654367.git.gaoxiang17@xiaomi.com>
References: <cover.1755654367.git.gaoxiang17@xiaomi.com>
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
 include/trace/events/cma.h | 19 +++++++++++++------
 mm/cma.c                   |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 383c09f583ac..5655ac521fb5 100644
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
 
-	TP_printk("name=%s count=%lu align=%u",
+	TP_printk("name=%s count=%lu request_count=%lu total_count=%lu align=%u",
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


