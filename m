Return-Path: <linux-kernel+bounces-729225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A4B03392
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3846017551F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725082E3713;
	Mon, 14 Jul 2025 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MLvdSck5"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A691184
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752451773; cv=none; b=fjlxYxBVmS0iWvmp9s80WJARskdBVNqogeYjJjQIQbH/Ubw/qKn4QDD4L+Dhsl9FdAoYkIQi7xGtSUqS9Q3YIqporRxD6qjRPly4C/VfYpIKI3w3yMoUkaVzyRTzlZ7yfpjugOKcKozTGvsRG/VhPouvSy2qh79vi8VKlAfh+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752451773; c=relaxed/simple;
	bh=LE3IJGYYePi2fKV1Y7ZR+GfIYeEsLwmPpX+TRHokJuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHoN9tZm4B4XOfLtvtQpUcNRqavX0C1Qh41JSCHCh0efu1fURC9PQ5FeUXq3Uu98Ldb2Ltnd6H3up8oKXfmvqdCbM762YwbIg5qsE3ooBqa2ox6JK+UCWGHCZAlJVyRm9vaw4Zu2sjl4ev+f/BS/9KEPVklCzgGzmeFaJljBpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MLvdSck5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=/deh9zCm+C+PCGyxZtDj+fk3vRbXSt75AeDoB+NUaPk=; b=MLvdSck5lO7W7KEW
	sdqonv8Qt1g5Z/KpZOQfZ7Y6JpLOPmOvDGTuo5Deg5ChbYa81BclYD5k33LRrOeyA00YbSbwUDJZs
	Ys5ogzRs3g3a3i7tIxw2Jegor2UjZzPHfkjNq37aOiFBYq0QP+g1e1CISc3TA8J48O4WdfMvVGmBf
	2YNIXCtDANF4PFHCkolrie2X/QiDT3w+hm00TcNXaZAq9bFjtadOn0SH/ffiD5dttizN+9CD6M5p6
	GUHutL+McSUwgd48sEiq+0x/87KrKrj7/vGB2/dJLUNmYRAS+XjTqTpy3RUqAVgLMmQe+2owP8dmY
	BGiVrAtw4bpcSvUWxQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ub6l5-00FpHr-30;
	Mon, 14 Jul 2025 00:09:28 +0000
From: linux@treblig.org
To: akpm@linux-foundation.org,
	terrelln@fb.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] lib/xxhash: Comment out unused functions
Date: Mon, 14 Jul 2025 01:09:27 +0100
Message-ID: <20250714000927.294767-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

xxh32_digest() and xxh32_update() were added in 2017 in the original
xxhash commit, but have remained unused.

While I've mostly been deleting unused functions, this is a general
library and I see erofs is using other bits of xxh32, so it didn't
seem right just to delete them.

Comment them out with #if 0.
(Which checkpatch rightly warns about)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/xxhash.h | 4 ++++
 lib/xxhash.c           | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/xxhash.h b/include/linux/xxhash.h
index df42511438d0..46d513a0212a 100644
--- a/include/linux/xxhash.h
+++ b/include/linux/xxhash.h
@@ -177,6 +177,9 @@ struct xxh64_state {
  */
 void xxh32_reset(struct xxh32_state *state, uint32_t seed);
 
+#if 0
+/* Currently unused, feel free to uncomment them if you use them. */
+
 /**
  * xxh32_update() - hash the data given and update the xxh32 state
  *
@@ -202,6 +205,7 @@ int xxh32_update(struct xxh32_state *state, const void *input, size_t length);
  * Return: The xxh32 hash stored in the state.
  */
 uint32_t xxh32_digest(const struct xxh32_state *state);
+#endif
 
 /**
  * xxh64_reset() - reset the xxh64 state to start a new hashing operation
diff --git a/lib/xxhash.c b/lib/xxhash.c
index b5bd567aa6b3..988a22e9a139 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -267,6 +267,7 @@ void xxh64_reset(struct xxh64_state *statePtr, const uint64_t seed)
 }
 EXPORT_SYMBOL(xxh64_reset);
 
+#if 0
 int xxh32_update(struct xxh32_state *state, const void *input, const size_t len)
 {
 	const uint8_t *p = (const uint8_t *)input;
@@ -373,6 +374,7 @@ uint32_t xxh32_digest(const struct xxh32_state *state)
 	return h32;
 }
 EXPORT_SYMBOL(xxh32_digest);
+#endif
 
 int xxh64_update(struct xxh64_state *state, const void *input, const size_t len)
 {
-- 
2.50.1


