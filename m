Return-Path: <linux-kernel+bounces-807146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F99B4A0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98777AC036
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C8A2EA72A;
	Tue,  9 Sep 2025 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IFPvEfd1"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6AEEA6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757392291; cv=none; b=P40HO0IVgTrh9ZBAqwKxsCNQgRtmJdbXsC/tYQ7YwcAMbAXlSHHTNerf5DD3gRgVxBtlhj1UIPrFKn2rec9+syDpoRWgyyQLs87t8Fguv/aqNiqLF+rSC/AHcaXmOPnNNnb7TjUd7Jx+3MBdf7EbguM7luYgAyj2R7FYwKRBDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757392291; c=relaxed/simple;
	bh=7BprC0DbeD6qKmvTzosE4nm/CrT3xOmcOm4UgYkT4jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJt8MuARLISGUhyXmbJ/lSa9IPnF9CJGsT6zJDuLZIjxThzacofxEkzx9rC2NMpGZ7QSNzONSWvG8qmp4YsR0ltVDQjgye7CeFIo+1cZUeSNgX/S6Kbv1nehW4hvekYYuJTXNkFTDcsbwLv76WkkPEh5AZ270zWXTlZetaVjs1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IFPvEfd1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32d3e17d927so2995929a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757392290; x=1757997090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJrMTVTzUmI8KdqbqvVBLEjvKduKiF1G6YlqRWONqjk=;
        b=IFPvEfd1yAGmjMkVzxPEF2R2xY9bk2jnIUSTE8XEWa1FlyHplB5nf6EGtLKpHYdfEi
         RS6g4Kdlm1gazzzuKyRZvtxJHJBrtpdTTjJU/1hgeHWnm+MamhuGc99OIaGF3gvw9j/L
         0dPhyP0h5+ctzMcoiU2yfTsdDowNxDf5DWFJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757392290; x=1757997090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJrMTVTzUmI8KdqbqvVBLEjvKduKiF1G6YlqRWONqjk=;
        b=XSVc+g1asz6f5hHoDhpH/faubllsBlnP8kyaEBmPWsSpQuIZEhOo73CsLXYuUGZ3pJ
         sekqL+QDrqL5q/KhorDJwKfaHNUOYBUxv8IuKa1Gpd5It+NbOoa1vzAe+0ZxWzd1kW4V
         3IK1PbyrvIY88KDKExllRFEu+RmpnKhvIeU5v+3wb5XJ75a2hvR7RJVpsFlW9SDix5Az
         kZAPQdEC1733pO18zw+rVmpobaHKmcfQcn3Xr0aaqTcAT1GIfEmQCcCKL8h053gNSSQw
         wYJ8Hqb5KdfY8W1Jk1xT3G9Lq5kedzKYpqjnVrSnz27Bf1e/6iuZLZTqPvw72HAdXkAF
         EJug==
X-Forwarded-Encrypted: i=1; AJvYcCXrO2Hl+ugVFVq4sbvrNMAoQHKrXft2180sLahlL65ZYWATr+X7r99TECloO6DUyKuI5xiE9ucxafOD+18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ejQ70SAJr1b3mT9YU86RWT0Q2cWcFBUO+RQs7GTahcXz6xIk
	/bjyhX5EkXBE9VPZAtiZKkmFX6+yFOU1B4jZpUDEwd8IB2OyPIeTVOKIie6NGt340dPcNMc2DeO
	/yGk=
X-Gm-Gg: ASbGncvQgfWo76deuJJYCsxJSH89BoCpYGbJC/miPiOvnaWjnnL3BB5+dZYfFYg1Lf4
	lGjHDNXjdYk6vGqxt3GiBOxwRIYySdfeqTSvXRRLBTKhjfx8fkF8FVrMzxPZKJu6vQ0AHYgNxk7
	fKj0IoupTBrCqZfpWaoPGGEWxA4Wf1mCVPgN+iQUJtXCWS4yOYfsnD5Q/JHKLyIQ5VEfvCHswu+
	J85F3WgYjJVn12mxeRchogHPQkDyyyWh41HwSuT2Wc1dCL8S+j1OZcIN3OnrAWeC4o/sUzZEI2K
	Qd8Fp9t72nvuP9olKnRiMjuXzG6ika7/Gj4cqtJiTQeJHQoZjMFVFcL1guNrbaro2FFHz4Zo5mM
	oNozAV+Nig1vTc8EGU1dsJI97NNQMzD2wvJptr9x47s5Fyj1XXbzJ0oiTADM=
X-Google-Smtp-Source: AGHT+IFY4Z4gXJOmcATM6Vnl3cu6uPdqkK3AAJ0PbXvlX8tne0CDO9n87cv/3kX0RBvTr3oobuVYaQ==
X-Received: by 2002:a17:90b:5185:b0:32b:d851:be44 with SMTP id 98e67ed59e1d1-32d43f0b8e9mr12567213a91.11.1757392289677;
        Mon, 08 Sep 2025 21:31:29 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:337f:225a:40ef:5a60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab176d4esm70646a91.3.2025.09.08.21.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:31:29 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Changhui Zhong <czhong@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] zram: fix slot write race condition
Date: Tue,  9 Sep 2025 13:30:10 +0900
Message-ID: <20250909043110.627435-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250908193040.935144f444ab0e14c2cdde60@linux-foundation.org>
References: <20250908193040.935144f444ab0e14c2cdde60@linux-foundation.org>
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
 drivers/block/zram/zram_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9ac271b82780..dc4a1cdfaf98 100644
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
@@ -1820,11 +1821,13 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 		return -ENOMEM;
 	}
 
+	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
+
 	src = kmap_local_page(page);
 	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
 	kunmap_local(src);
 
-	zram_slot_lock(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, PAGE_SIZE);
@@ -1848,11 +1851,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1890,10 +1888,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return -ENOMEM;
 	}
 
+	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
 	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
 	zcomp_stream_put(zstrm);
 
-	zram_slot_lock(zram, index);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
-- 
2.51.0.384.g4c02a37b29-goog


