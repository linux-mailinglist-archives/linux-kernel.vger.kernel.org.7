Return-Path: <linux-kernel+bounces-844241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DFFBC15BE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8782219A2474
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB992E11D5;
	Tue,  7 Oct 2025 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXvaiUMQ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CA2E0927
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839654; cv=none; b=tmFV8hAGLv7KarD+pmgVRPmX1yx4Cqid5xiQ21tycTN9n8+05jj5oy0ZDT/dUx/eClLf3SzHjxatxdUzlvNWTfhPwom1EambRuP6CgdEeEk11qwaaULeCE9uFyUZ9Et/ASt1d8NfCi/CYVnKHzZW8KaN2ubR4oCOS34PUZunovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839654; c=relaxed/simple;
	bh=BZ744rPyTvPlpKIvtyJ5im9XXhgJMtaH0OmahL3Q9qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIFncz5HpBtn1DVyiIOZHLRBTb8lu0HHzcSGmjcTj8pre/wfdmA6zR9wPiFNKFAiDW3NTUsCN6D2oQ7Jz4OpsCXC2hYLOG2F5/Tx3beBqDT9bNW/UfgnPahi+gmC2nAikuqtVMhw30+Df3xwrJX+SnCHmynO/32xVpY5uc4Yxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXvaiUMQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so7357330e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839651; x=1760444451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KootqZKBoInJ70ZxwqKSLGt1yUrzmx1MeMaiDcSe4Sc=;
        b=VXvaiUMQckNvakkzbBL2LT/j/eVu61DoJcscmi4Vl8oz/aUTrU00HkvlXbtffiKHV3
         0WJuz2fNS/q0TanbX04TFl6HJ2Sd0uKE/u8nUR7HDbwVXz/AUXKM8GUnl7rTYqwZHdfC
         KI3/BJENqXKmq1csXyjU5Qvvgkh+hPRLgKbbuzbRlZ8b2WOZYJjwZsGJogIHRBIAjsqp
         UyE/grmGxO0F/TcqwzBukNIccZy+xZjjODFSm5P7X4m4QFQ2KRk634Fygj+d05u2wpQe
         j7YOw9GQIU8cHZaHGL/gLKZHzIRaO7pLkLsBXKbzp3fW5A/T3KlG0lMLyUJ0qqdmMGuC
         ckAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839651; x=1760444451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KootqZKBoInJ70ZxwqKSLGt1yUrzmx1MeMaiDcSe4Sc=;
        b=NugsTRA1gvBqzSC58/qrZfJr9z7TEQjl8wg/dl6VO4iHaKHVTQpB1C2B0mOXqYpCU4
         j6HjFPoscrKZww5cvQAzV1So60STcx4UhWlgGv5zqygQsI1Iaa85ZLkIYuFGLB08R7TU
         VrAfp2p7IxHZjO2rAtyfJ/uxJY4sbOfsXwf0pUTnhpUxasKqpa61oLFUc/U5Gdn0S4UC
         mtt0WI5A8DaiPmJ0VzcVXqMzvirYDROEzVLlFE4L9GNO8bPb+AC8gDymE/VQ5Ke1O2C1
         spSYp5UNzIy41OuV4fQCXrF83TLLZ36wKpUSdbW/6AhHb0rALPWkax8N69DaN6IOtdkP
         mEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrJ89pxg1J+SPgg69ciEKq9MrMKbzSlisrBUb5W7I8/IdKqBV1UPGO3kzrre4GODjf2s/S0yz19gI3KWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/V3EBwMqQcdMXQeTJh+UXOpd5pPvJ57dRuWYiZFZXgQPxkDIk
	RA1GagXcq2BUgXHcAicvgfnURH+yyDdUBHG0Jar1a4CMkJIP6c8BlKZ3
X-Gm-Gg: ASbGncuQC/FYAuF1HJ9t/gpl9KdHhGUOqgYyqGGYb/LltxNK8rlMKvW8WvkmyQaulMc
	X0/Mky4cLAiawRrrYo9C7Kf2CYcLZL+68K+jrJxjYNZ8mZLP/nyQx6qcsGiS9jjIBahH3hg9aXA
	tD4dmsOikaEov8hpvE7i8Mbki2w7cz+z/hwGLzfEkqz3F77na7bhOeaAL350DmJ5CZ3BUG+2+f9
	RCMa6LvJP8fNnjOjGEjuPeVuRA3OtD0M3jbZ050MjHCncivhd8ijVL/Q4oj+ClfWs2wV+ZtSVgC
	f4aZ4wrjizhgN2VikxsRiA4H9stfeUXx2wFojxAtAQAK6NP353CDBKfL3LujJLTvqrCcVztu3Pf
	cD/B4C1GkL1FlhIW4ZG/lsL3ypEn3OF1IgexqrEru
X-Google-Smtp-Source: AGHT+IFPlX7EPJQfg4e0mUBd4WzqghnQVqlWdKVCToHj5t8/+iKkFTtFbq1tKN4IiRVof3fLjH1x1w==
X-Received: by 2002:a05:6512:230c:b0:56c:386b:9bc with SMTP id 2adb3069b0e04-58cb956bb11mr4722191e87.5.1759839651048;
        Tue, 07 Oct 2025 05:20:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:50 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 10/10] mm: kvmalloc: Add non-blocking support for vmalloc
Date: Tue,  7 Oct 2025 14:20:35 +0200
Message-ID: <20251007122035.56347-11-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend __kvmalloc_node_noprof() to handle non-blocking GFP flags
(GFP_NOWAIT and GFP_ATOMIC). Previously such flags were rejected,
returning NULL. With this change:

- kvmalloc() can fall back to vmalloc() if non-blocking contexts;
- for non-blocking allocations the VM_ALLOW_HUGE_VMAP option is
  disabled, since the huge mapping path still contains might_sleep();
- documentation update to reflect that GFP_NOWAIT and GFP_ATOMIC
  are now supported.

Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/slub.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 584a5ff1828b..3de0719e24e9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7018,7 +7018,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
  * Uses kmalloc to get the memory but if the allocation fails then falls back
  * to the vmalloc allocator. Use kvfree for freeing the memory.
  *
- * GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the __GFP_NORETRY modifier.
+ * GFP_NOWAIT and GFP_ATOMIC are supported, the __GFP_NORETRY modifier is not.
  * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
  * preferable to the vmalloc fallback, due to visible performance drawbacks.
  *
@@ -7027,6 +7027,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
 void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
 			     gfp_t flags, int node)
 {
+	bool allow_block;
 	void *ret;
 
 	/*
@@ -7039,16 +7040,22 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
-	/* non-sleeping allocations are not supported by vmalloc */
-	if (!gfpflags_allow_blocking(flags))
-		return NULL;
-
 	/* Don't even allow crazy sizes */
 	if (unlikely(size > INT_MAX)) {
 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
 		return NULL;
 	}
 
+	/*
+	 * For non-blocking the VM_ALLOW_HUGE_VMAP is not used
+	 * because the huge-mapping path in vmalloc contains at
+	 * least one might_sleep() call.
+	 *
+	 * TODO: Revise huge-mapping path to support non-blocking
+	 * flags.
+	 */
+	allow_block = gfpflags_allow_blocking(flags);
+
 	/*
 	 * kvmalloc() can always use VM_ALLOW_HUGE_VMAP,
 	 * since the callers already cannot assume anything
@@ -7056,7 +7063,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
 	 * protection games.
 	 */
 	return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VMALLOC_END,
-			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+			flags, PAGE_KERNEL, allow_block ? VM_ALLOW_HUGE_VMAP:0,
 			node, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(__kvmalloc_node_noprof);
-- 
2.47.3


