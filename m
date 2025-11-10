Return-Path: <linux-kernel+bounces-892399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C6C4502C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FBCC4E79E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026352E8B9E;
	Mon, 10 Nov 2025 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dmAkk6KG"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C672E8E16
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752484; cv=none; b=LgkOPo4YWPbCF6yBHerb2TnWl6TtsgDNYbU+EpOPc7bGGygExpVK+GwHlI1U4TwI3oYEr96X3GU5ko5EYIapxKD0t/FSACfxu518scogGrEgBNgiwtZXkCuFrKs8TeXMGGEnUoMEYDu4mia7MZHldVnp+CHksGqlS7/euhieA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752484; c=relaxed/simple;
	bh=HZ7iFC8g2jWgg3RLDaD0ihKgqLcxowR4WiYlLsW8XIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVPkdbig0cmQniriZuq4P+PlZYFEv4JOrAj2Jhu2DYbcnIpNL5jUfjqw/pkXmyQvXuxMoZBX7Rfnjn/Fiqq15PYMgFdZksRusW3hr1ccfymOJh5DJNtJqutYHRzM/tFUKsAXIM/4Hv79sKYLITTdWps9I29D8GC5kLjZaqtP2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dmAkk6KG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bb7799edea8so269747a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762752482; x=1763357282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvapgbH3jkD+AdkhW294xxn0JZbD4KOae/vm4TVUuSk=;
        b=dmAkk6KGbW95Jhuw79sD/vPyaAYyFrz1tv7QdfDuFWPfKsCDhdCtwO41Er2iNjzWmY
         qhMZ30ZY6Egb2Qq+tjZ6UNo+a/1fc4peA+zCxpi6ESieedbhiUtV7Qs2hrf4D46AAJb5
         OtE+FlqvPb0FK7ysNzIxCFpzhKnL4ee7FNo+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762752482; x=1763357282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvapgbH3jkD+AdkhW294xxn0JZbD4KOae/vm4TVUuSk=;
        b=rfAz6+yQPDyO44eTpp4OFJz7EH3N802aRUY0t25gH5he27Gujs1avGp2PM3MbdpLoW
         4mFyo/xiU5k3wKUBuT6rtUc6aanYU7X/XtN/EKxIWvIFIL/7sm4icF492IetDWCqIPpq
         9Aj/mLEqUtvreesF58udj5X2DngPk/Xr0qaq6jW47xEbyMMRWN/u93z9D1YlB23xRifQ
         1HNfSQVFr6jEcxIqA+Sg4PernzWzwUoC8ZLfLiCI8c8yFM0w4kSjm8lh5t/9UjS+0/zw
         W5GbZqeHRRTLDJtVBg4/TC91ZInY40Ac/r1nvbsvqpQOUlfoG4MGm1N2ZcE0EVFTuJPY
         THPQ==
X-Gm-Message-State: AOJu0YxRvecljHSXhQtz2x8bWQLOPOjzZQ6b5UGwCbXiV2CPZ8PLQHF8
	5e57wei7g/xupwkHS5eRJ+rTP1BLTzcDGz7zH3gEUv3h0PLZGB6F6FkT3gD1YufHTA==
X-Gm-Gg: ASbGncvJYd8L6Aggp+x7BJkcM66/yjpLPwkGiZLMGhkUNBoig9MJTVZKUW9GNrGO8OX
	XEEMSN7owTyuiX9JDZ6aZOAGJTO66QHnV4yT+wGMZ6aJqlrBJKtH++MCc93yDuW+N8Q3xhezncA
	/XzaISHzicz30Qk/byGHLUChHMEAXm7ewWBmdws8jryz8nD48qAMkyNc/DJEkK9WAldnKwOG4zQ
	bX7X/FpiDShZQEJ+zpN1QZivDmgRbRHhZUhDgqga99UaefMBb/71pIhLlo68UtdSXGIz3Ihm7U1
	u/KVGYBtmKPyHS3D8WjObXAu7V6KAzwJwDHNhXckJ+2koyoduMWRdXAXuJUxkXCIIe2U9jSmAvV
	7y9aPPoTzofaVw0bhoGSNB7fg/AIWw2MzzDTuriIsvVmYbUPrxDnshR5WxndFJgU5W7LaLEFS+W
	3pmCLvaMrV9wMcKcJ79PD7pGcLuS75S+6OCzS2rw==
X-Google-Smtp-Source: AGHT+IHymLI6kE6r/xB7IR1Kudj8hm5wJJouSqUSb1t5jP8J2KHp1GbLAwBuqPctZvgTviQ0dYbp7w==
X-Received: by 2002:a17:903:2b06:b0:297:f5ad:6708 with SMTP id d9443c01a7336-297f5ad67dbmr66282975ad.43.1762752481882;
        Sun, 09 Nov 2025 21:28:01 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f189:dea3:4254:ff1e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c778a5sm131804095ad.73.2025.11.09.21.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:28:01 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Shin Kawamura <kawasin@google.com>,
	Brian Geffon <bgeffon@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] zram: do not hardcode 4K page size for writeback
Date: Mon, 10 Nov 2025 14:27:41 +0900
Message-ID: <20251110052741.92031-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback operates on physical pages and writes a whole
physical page to a backing device at a time.  We should
not use hard-coded 4K units, as on systems with PAGE_SIZE
larger than 4K this leads to incorrect writeback limit
handling and bd_stat accounting.

Reported-by: Shin Kawamura <kawasin@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 21 +++++++++------------
 drivers/block/zram/zram_drv.c               | 13 ++++++-------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e273c1bb749..afba174e3471 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -211,8 +211,8 @@ reset             	WO	trigger device reset
 mem_used_max      	WO	reset the `mem_used_max` counter (see later)
 mem_limit         	WO	specifies the maximum amount of memory ZRAM can
 				use to store the compressed data
-writeback_limit   	WO	specifies the maximum amount of write IO zram
-				can write out to backing device as 4KB unit
+writeback_limit   	WO	specifies the maximum number of physical pages
+				zram can write out to backing device
 writeback_limit_enable  RW	show and set writeback_limit feature
 comp_algorithm    	RW	show and change the compression algorithm
 algorithm_params	WO	setup compression algorithm parameters
@@ -286,12 +286,9 @@ The bd_stat file represents a device's backing device statistics. It consists of
 a single line of text and contains the following stats separated by whitespace:
 
  ============== =============================================================
- bd_count	size of data written in backing device.
-		Unit: 4K bytes
+ bd_count	the number of physical pages currently stored on backing device
  bd_reads	the number of reads from backing device
-		Unit: 4K bytes
  bd_writes	the number of writes to backing device
-		Unit: 4K bytes
  ============== =============================================================
 
 9) Deactivate
@@ -409,17 +406,17 @@ assigned via /sys/block/zramX/writeback_limit is meaningless.)
 If admin wants to limit writeback as per-day 400M, they could do it
 like below::
 
-	$ MB_SHIFT=20
-	$ 4K_SHIFT=12
-	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
-		/sys/block/zram0/writeback_limit.
+	$ PAGE_SIZE=$(getconf PAGESIZE)
+	$ echo $((419430400/PAGE_SIZE)) > /sys/block/zram0/writeback_limit
 	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
+Note that writeback operates with physical pages, so please make sure that
+the limit value is in PAGE_SIZE units.
+
 If admins want to allow further write again once the budget is exhausted,
 they could do it like below::
 
-	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
-		/sys/block/zram0/writeback_limit
+	$ echo $((419430400/PAGE_SIZE)) > /sys/block/zram0/writeback_limit
 
 If an admin wants to see the remaining writeback budget since last set::
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..51074fed342c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -823,7 +823,7 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		atomic64_inc(&zram->stats.pages_stored);
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+			zram->bd_wb_limit -= 1;
 		spin_unlock(&zram->wb_limit_lock);
 next:
 		zram_slot_unlock(zram, index);
@@ -1529,9 +1529,8 @@ static ssize_t mm_stat_show(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
-#define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
-static ssize_t bd_stat_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t bd_stat_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
@@ -1539,9 +1538,9 @@ static ssize_t bd_stat_show(struct device *dev,
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf,
 			"%8llu %8llu %8llu\n",
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
+			atomic64_read(&zram->stats.bd_count),
+			atomic64_read(&zram->stats.bd_reads),
+			atomic64_read(&zram->stats.bd_writes));
 	up_read(&zram->init_lock);
 
 	return ret;
-- 
2.51.2.1041.gc1ab5b90ca-goog


