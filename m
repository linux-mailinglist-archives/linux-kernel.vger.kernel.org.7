Return-Path: <linux-kernel+bounces-807158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B192CB4A0EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157467B3031
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1542EC566;
	Tue,  9 Sep 2025 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfjGtuh3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E6211706
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393525; cv=none; b=Z7PtPIrWzT1JdUM/ve+Xt8k8QtugztHPxiiVlGoAYMoKtZGT/HS0/zm8mpHHzsRfZ3N3xwxgbxNpymxHDH5cPzR3BqY3VvfDaKJjCBmYSOkw3hyA4d2z105FGZXiCN5V3ikz7ivf9CNhDLEUx6yBzecShdrfIFwUUbT41KZXsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393525; c=relaxed/simple;
	bh=x8VD93zI//O173NdJM5LXc5a35t6Bki9+AMpcHxEaOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hg6rkle04qIWVVGXDa5UD+Qry4xKXBg2wlVn7z4u+c4j9QR4A2OGTG8Kp0lmE8PbARN2FPrvB4LL7pbbs9BZD5Ip02a/h8Ky6mUkMiReij7thGvmtjraaIookPK//4AKskfVKvC8aHScwm1Hw5s3bQQhqCLei7qQlQJAtuQXc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kfjGtuh3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b520c9c291dso3176796a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757393523; x=1757998323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxTekYZw4n/8+pZjM2Wb4q6TEJbbwCkXd1Sr0QZaf6U=;
        b=kfjGtuh3QAS1aGpIO0f+Z1dM2OfZm7/NMiPiaRpY7lsH/vOkGB+pjyUy4pOx/RABV4
         MGlcOD8k8k92FVVuc2vMqWFzeTW4+q77QIOGqItk4d4eaH94FpZCN/owoH5wBZRPk35H
         t1FeNfbl9+J6mKlgca6AAYx75hx6CrYrmHbDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757393523; x=1757998323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxTekYZw4n/8+pZjM2Wb4q6TEJbbwCkXd1Sr0QZaf6U=;
        b=L/UApYJyk4O143WQ+Bhl7DCMxve+5N4JZKiufI2zdXEVQE3Xak7UFjFQE9PaCeYJWH
         uomoAg4bSl2QsXjjaxRYJKk4scj2DW/W/aPibauji0fGjSE8jWk/JsHi2Ie/CDLyPMzP
         0GZufh/AjUkGz8wm1y/C/bMAKh1mUip7lOf4pmNeWsB3DW6Y4qKAa7SZpoksQjHHmT7g
         WYsuALqyklzP0X0LTU9/YgSNFCv4Zzc2P/d8s3CDl3rda+rIi14ZhwLeGFrzQs737mSa
         18+gm26ZMRPDKNhKDfMRYbSrnc/203cnQ1IZOjdSoOwgWUiQs1THZH3vZstLHVERGnTD
         CGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSKsqElrBk9KbIgQc0uBXkxHS7CkOZNm4ta+lriRDBQdYpvq7tvGhjNBJR9zq0XjbxNZ9wGicxp/kjcFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvDEOFc/tKOn+nrtRGIIjz50p8gl70OR6XeyRmUiFIVxMNzoG
	KetwSTm8X4pVI9iNqBxbFqcEqECM0IqAvS85I+tJhKS0w6/ghfX+F/Y6+0ptver2xQ==
X-Gm-Gg: ASbGnctEHsCYMmuXZPcDlL3erCKrMR+/BVcrCJyOd89HRBrK+GcoSwHPb3cDeolA8kb
	BVMfnLYTAjPr+9kwiEKvznNgI3zyJfp5FbFv4Tp+GrZfYYMZ6aXb4iwpgJrgZxJoDhGHSMhSQ2I
	uzHmS6gCgkO5VFBLF6L5y7wqWMqH4raz+T3vJaysF2OVDBS7kp61VdiEB5kaxP6Bk4/ljVvMSIL
	sMkrtYrzVHhZoxJfQdCbmP74IS4fzC7QfP89ptQiaD0nttXLMZSM80alJTuRENxqwsYI4xmSuWH
	s+x63TUIylkaqI5s6Bo8K9a79uQL0lttb2VF6oXWE6d5uwOe102Hv6BZwko/fe5Ps7VtpKoTO4g
	MCgF4kGU2713xhqs2Eb9AFSH3fjnM/DDAa11FSCBH2004qtxX
X-Google-Smtp-Source: AGHT+IHELyfgjQV2lzS3L+EPdr6RMiKi7ZVHtI7OWwvlxUWsJr5Q80qDuYZaQ1tDaB9WjaWbwYFEhQ==
X-Received: by 2002:a17:903:2287:b0:24c:82ad:a503 with SMTP id d9443c01a7336-2517446f905mr133387135ad.41.1757393523236;
        Mon, 08 Sep 2025 21:52:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:337f:225a:40ef:5a60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm199723815ad.138.2025.09.08.21.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:52:02 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Changhui Zhong <czhong@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCHv2] zram: fix slot write race condition
Date: Tue,  9 Sep 2025 13:48:35 +0900
Message-ID: <20250909045150.635345-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parallel concurrent writes to the same zram index result in
leaked zsmalloc handles.  Schematically we can have something
like this:

CPU0                              CPU1
zram_slot_lock()
zs_free(handle)
zram_slot_lock()
				zram_slot_lock()
				zs_free(handle)
				zram_slot_lock()

compress			compress
handle = zs_malloc()		handle = zs_malloc()
zram_slot_lock
zram_set_handle(handle)
zram_slot_lock
				zram_slot_lock
				zram_set_handle(handle)
				zram_slot_lock

Either CPU0 or CPU1 zsmalloc handle will leak because zs_free()
is done too early.  In fact, we need to reset zram entry right
before we set its new handle, all under the same slot lock scope.

Cc: stable@vger.kernel.org
Reported-by: Changhui Zhong <czhong@redhat.com>
Closes: https://lore.kernel.org/all/CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=ksN6EcvyypAtFDOUf30A@mail.gmail.com/
Fixes: 71268035f5d73 ("zram: free slot memory early during write")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9ac271b82780..78b56cd7698e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1788,6 +1788,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 				  u32 index)
 {
 	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
 	zram_set_flag(zram, index, ZRAM_SAME);
 	zram_set_handle(zram, index, fill);
 	zram_slot_unlock(zram, index);
@@ -1825,6 +1826,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	kunmap_local(src);
 
 	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, PAGE_SIZE);
@@ -1848,11 +1850,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	unsigned long element;
 	bool same_filled;
 
-	/* First, free memory allocated to this slot (if any) */
-	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
-	zram_slot_unlock(zram, index);
-
 	mem = kmap_local_page(page);
 	same_filled = page_same_filled(mem, &element);
 	kunmap_local(mem);
@@ -1894,6 +1891,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zstrm);
 
 	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
-- 
2.51.0.384.g4c02a37b29-goog


