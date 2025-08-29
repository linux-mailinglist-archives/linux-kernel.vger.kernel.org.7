Return-Path: <linux-kernel+bounces-792133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68583B3C090
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247AAA63F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE3335BA5;
	Fri, 29 Aug 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="T7oyloWL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FB32A3D1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484558; cv=none; b=QzK8hs+bkj0ignHntK25gzjbEGfETximr0+Ot0/1pzVDC6ZjiYd8TEtjhHc1Ml95T8VfgNEGr1NsZsn8MSNmnTj7/aOKcLOiPL46RN/SSYgtwKE3IHpP8cFXE9sdZ5A90NefVh3hfp+X5yqIzbseIIgM2BTb/41jWwETZSysmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484558; c=relaxed/simple;
	bh=8TDmGbYj0UyXVqHo1ZkM6vIV2MsOIIoNJgd3bubtTaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DN9bVj37x0cVQbybWq/Uk3SHj3YzZOgCfCRpQhFP8yym3x6PjEU67qbriWoBgriVV86FmMDFU6LRxvJ70qsOIE0kgzTW6A+z5+jzNYaWOuSBJn8HpFv4mtpdSVkOnsOlEZJx8Bq/ZALLFvs2muBiQUU4UCl/NLoa14EkE51Pr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=T7oyloWL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b77f59bd8so11576685e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1756484554; x=1757089354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO3fZfxsRC3wtDo2pgMFNvnPCWzRCeuSrbJiTbqH9x8=;
        b=T7oyloWLgl5WRMn72ha/BuiW+wHgeTQWoy9FRLHE5/Jd6wRYh4I5wIEV/qfg7lLnm8
         dX2LFftgroiy2+9WYsExzaG0BUO5qvPmGNIbskCJjt7vyyl3esYKcwZNqHDT2mk8YDSX
         2UkpbyuRSuzKrfCXdsV8R9qcFY7ErviLTQw3b30GtVmdCJ1LGuLfgKj863hhcbjmZu5C
         9UHJG7lSVU5oPmBcb9/7eAG2y6ZBbM1NHAf/J3k4eJNmEtD7yT1l9NpB9Q8UGcDDJxFG
         Wb9COQBjfhD83xee5aStPesBkQ1gqdhItehQ8vv/BSqc4tmpIb2pVeKwwzOUhflvLL++
         Twlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484554; x=1757089354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO3fZfxsRC3wtDo2pgMFNvnPCWzRCeuSrbJiTbqH9x8=;
        b=WACoK1492F78WG8IRLztVMLAerk48jcIvHMYRjo2QclAvfg0v+mWVTqGOjg4Kk2XfT
         UUiHj86pGI57F2+Y0o6jCi/SNI7kYzKExplI+t+yWiHTBX7M5H/IO+4nE1NVRsSDe8AY
         LTmMhNNK80/VDFWgX1ISazau5pXEyym1rvDAlgQloYX3cvkIs1UyWYaglV6s8eoS+pwm
         TKTAWJq0+UTqNs1ZssaZAh+Tiu7wywKpPChtEGV281Symc5xPo/+wn1aMYoyy62/cJZJ
         SZQMw8OjuxqVnPwKTeAkWogZDiLUBTkJBinJPrM8Y+2DIE4YLv+HymSi7hOfDO3QdNps
         oyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrQtBtXUPF4uWUmahS5g+Lo50NA30W3ag0klh6clpc+lhBK3hMrhOlvNHsy/LkbK3GMXk3VNqU3E/Vo0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hCfxIDoPUMvhPGkZ7GlSMFT9t5Cmby1aX+UiRzhajfFYbHwE
	7KMu8YmrJ+SyU+ZCKptD8gwfeTlubyVrXweB9mVo0nAj1hHLYVxx6fR70uoLUbqSAFVZC8xO84V
	QrVGll6k=
X-Gm-Gg: ASbGnctSn6JIXL5WqLcpqk7Ce3xP9F7MAF9RlUQlKdq2XDiD4MBUkqRYH7CZb86q5Uh
	MLIRkSAsBctRbqnmvz3uzvbKDJO5d40wNFALI8lbPiwcIPFnfPvpoBUI0nxmAfA256gjlaCAyOt
	IX8yubiGYGyF4iC0lkC7/nCD66/gWO8T2slnEqngQ3VF2dBqKZ9bluzLSNawth1u86w7lbPGjYO
	p2GU2hnjj0XMCfc1OwenwkHn/3RKYJgfnIe0U2TpPhPW2roxD7rBj19RK4EacVhP6GwSTIn7aSg
	JDkjKo215cQMd81QHo+zvv+W2cvnL0L4WQchhAXM5rNfFf4C6uFUMRZTay4b14ZNTvTYJwgUS3T
	RR/g=
X-Google-Smtp-Source: AGHT+IFvxH2wrrQOL8qFClFcMXg7O03uzVqmqAkC2KXtyit1y23oMAaMh5LuPNjzPv7yownc2pnyxA==
X-Received: by 2002:a05:600c:8b0a:b0:45b:733b:1feb with SMTP id 5b1f17b1804b1-45b733b214dmr88676045e9.10.1756484553840;
        Fri, 29 Aug 2025 09:22:33 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:954])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7d9548edsm30431075e9.5.2025.08.29.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:22:32 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: zpdesc: minor naming and comment corrections
Date: Fri, 29 Aug 2025 17:15:28 +0100
Message-ID: <20250829162212.208258-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829162212.208258-1-hannes@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zpdesc is the page descriptor used by the zsmalloc backend allocator,
which in turn is used by zswap and zram. The zpool layer is gone.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zpdesc.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 25bf5ea0beb8..b8258dc78548 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* zpdesc.h: zswap.zpool memory descriptor
+/* zpdesc.h: zsmalloc pool memory descriptor
  *
  * Written by Alex Shi <alexs@kernel.org>
  *	      Hyeonggon Yoo <42.hyeyoo@gmail.com>
@@ -11,14 +11,14 @@
 #include <linux/pagemap.h>
 
 /*
- * struct zpdesc -	Memory descriptor for zpool memory.
+ * struct zpdesc -	Memory descriptor for zsmalloc pool memory.
  * @flags:		Page flags, mostly unused by zsmalloc.
  * @lru:		Indirectly used by page migration.
  * @movable_ops:	Used by page migration.
- * @next:		Next zpdesc in a zspage in zsmalloc zpool.
- * @handle:		For huge zspage in zsmalloc zpool.
+ * @next:		Next zpdesc in a zspage in zsmalloc pool.
+ * @handle:		For huge zspage in zsmalloc pool.
  * @zspage:		Points to the zspage this zpdesc is a part of.
- * @first_obj_offset:	First object offset in zsmalloc zpool.
+ * @first_obj_offset:	First object offset in zsmalloc pool.
  * @_refcount:		The number of references to this zpdesc.
  *
  * This struct overlays struct page for now. Do not modify without a good
@@ -79,8 +79,8 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
  * zpdesc_folio - The folio allocated for a zpdesc
  * @zp: The zpdesc.
  *
- * Zpdescs are descriptors for zpool memory. The zpool memory itself is
- * allocated as folios that contain the zpool objects, and zpdesc uses specific
+ * Zpdescs are descriptors for zsmalloc memory. The memory itself is allocated
+ * as folios that contain the zsmalloc objects, and zpdesc uses specific
  * fields in the first struct page of the folio - those fields are now accessed
  * by struct zpdesc.
  *
-- 
2.51.0


