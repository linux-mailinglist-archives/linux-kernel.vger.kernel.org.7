Return-Path: <linux-kernel+bounces-825036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE5B8AC45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BAC7A656D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D9322A09;
	Fri, 19 Sep 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="MsyqofTV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="HF6fV8bQ";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="JxkV6Y21";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="GoKuVAn1"
Received: from sender5.mail.selcloud.ru (sender5.mail.selcloud.ru [5.8.75.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893EE318157
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303045; cv=none; b=EfgjKilnt1QH1fjChkPEWxa5hRIbl68IYzqx0Z81oHgZ0n6v45dRab3eLBY8RGLCkYXftjGxqNGHDzkGn+6w9nnvSBbaPzlhFuWE3KX2eoQIogADrSseQHc3h2LB+MmGc2736wnthtyUJCI8VtnGlL8nwTmwClJoE9dpO86njgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303045; c=relaxed/simple;
	bh=C5MKNpgIWgSoFRKIo5ea7Z5mGG2FJeGNwZWOrBY/LRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rwzpdP4YiE8N3d1Tfb8B+RC86hYUQOzfWta622jEcWp4K10xGFxzzvpn29Q86pXkamjF9eZ2WhF4nqEhcVk2TIaCOPUcNHXQtgB9cMUKuxDH18iT5LVQ8KZGHk3CigwZsdWV6rhsdVhyWTbUtUQEHVupdqyrMY8U7ZP2EKuxlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=MsyqofTV; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=HF6fV8bQ; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=JxkV6Y21; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=GoKuVAn1; arc=none smtp.client-ip=5.8.75.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:List-id:
	List-Unsubscribe:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ny6NEmjoH9ftptRF2+bHJvuF94mMpbmtsOdlIynZ17M=; t=1758303040; x=1758475840;
	 b=MsyqofTVfvWomrcdWUqtjuEOmdPkN5uv+MVCT5aeEjeK9k1ptv9SK7wJt21HllIqvBthTOi1un
	z+nGZdCN3JhrkoPmbMPZcbaHs1Edoe996BjY4G0MIDmtmr58TjD/EDe9/tkNa9ZVSNaor8LAd3uyk
	/XrVCnfAprvfzZky/asA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:List-id:List-Unsubscribe:
	Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ny6NEmjoH9ftptRF2+bHJvuF94mMpbmtsOdlIynZ17M=; t=1758303040; x=1758475840;
	 b=HF6fV8bQyUJyK9L5hnxdF377s6c1nxNyRoAkQ1EtRgi7tGk/xsIBDiLmOC7qztN5S40DCth28D
	+iVL4sXfWxEWv/ES3UvTiD1Kf4OjoX62wbLlFoYcUSB2iD9NTtJT9nNmNvwaUlMp+05mhn5geqYB8
	52zvuUiPfCVOnsADqh9U=;
Precedence: bulk
X-Issuen: 1221286
X-User: 72278292
X-Postmaster-Msgtype: 3849
Feedback-ID: 1221286:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20250910.101619
X-SMTPUID: mlgnr59
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1758302071; bh=Ny6NEmjoH9ftptRF2+bHJvu
	F94mMpbmtsOdlIynZ17M=; b=JxkV6Y21xNxpfqsPoydzXkKA0MnNKq1eoEMuEwtzASE5WgcZgG
	N2Z1seb71q5R2WUuZqKPbGtUf9HLz38oyVXLx8EqqNMBr4/h+YVE4OXW2O6RTGrssT3R4P8qZ/M
	pl53wEkhkwxhvUHd8JUjkSLe9mw2PMBusf861YZGIqH6YIDbFTeFDG6hH4HpDbApbGp2r5ekdbI
	gEvP7DqO+55YhQoG3VedBmp07udNc6nt07ItUTttbxyFa79LoQL1PlT58D5xyzI05a2EYCvqo5D
	0SVo8k24SpTN2tCxA799+7/GXGRTbIt9v2KNxH+l2wVcUJLedxxXBXjXt2088w9DAtQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1758302071; bh=Ny6NEmjoH9ftptRF2+bHJvu
	F94mMpbmtsOdlIynZ17M=; b=GoKuVAn1ZFhKYwdjSvHIeKwoalf3vAaSQSmKX/3CJUgVvuH0tk
	W+ZQqXjCVUuRQb6n1t69U2ETAOhRVB4hK1Cw==;
Message-ID: <76e0b252-ecbe-4d86-b210-79eb803e0fd7@foxido.dev>
Date: Fri, 19 Sep 2025 20:14:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] maple: fix incorrect rewinding in
 mas_empty_area_rev
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250918182544.1400748-1-foxido@foxido.dev>
 <4a72mtf5n4mzirudx3z2z6b72ropqs7f4kp2dlezkib4k5em56@hiw63iieahph>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <4a72mtf5n4mzirudx3z2z6b72ropqs7f4kp2dlezkib4k5em56@hiw63iieahph>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 23:20, Liam R. Howlett wrote:

Sorry, I kinda overrushed with this patch and it turned out it wasn't 
complete. I apologize for that

Below you can find new patch with regression tests. I'll ignore some of 
your comments (and some of them are fixed) for now, so we can find 
common ground about semantics of empty_area* functions and later, if 
it's really is a bug and not my misunderstanding, I will send v2 for review.

 > * Gladyshev Ilya <foxido@foxido.dev> [250918 14:26]:
 >> Previously, mas_empty_area_rev was rewinding to the previous node if
 >> some offset was cached. This could lead to incorrect results because a
 >> useful gap could be skipped. However, this was never triggered in the
 >> kernel because mm subsystem calls mas_empty_area_rev on non cached mas.
 >
 > Can you please produce a test case, ideally in lib/test_maple_tree.c or
 > tools/testing/radix_tree/maple.c that triggers your issue?  I add all
 > new tests to one of these places so the error does not return.
 >
 > You can build maple in tools/testing/radix_tree/ and run it to run the
 > tests.
 >
 > It also helps understand the issue.
 >
 >>
 >> This patch unifies the rewind logic between mas_empty_area_rev and
 >> mas_empty_area, so they both rewind in their correct directions.
 >
 > How are these unified?  They are still different functions..?  What is
 > the correct direction, in your opinion?

For mas_empty_area we should move towards first slot, for 
mas_empty_area_rev we should move towards last slot. In both cases 
empty_area function will rescan last saved child / gap and won't miss 
anything.
 From 17707e1117a4d4be23f257c3b911c0a36f55b116 Mon Sep 17 00:00:00 2001
From: Gladyshev Ilya <foxido@foxido.dev>
Date: Fri, 19 Sep 2025 20:00:26 +0300
Subject: [PATCH] maple: fix incorrect rewinding in empty_area functions

todo: full description
Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
  lib/maple_tree.c                 | 40 ++++++++++++++--------
  tools/testing/radix-tree/maple.c | 57 ++++++++++++++++++++++++++++++++
  2 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b4ee2d29d7a9..3cc1596e231b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4985,13 +4985,10 @@ static inline bool mas_rewind_node(struct 
ma_state *mas)
   */
  static inline bool mas_skip_node(struct ma_state *mas)
  {
-	if (mas_is_err(mas))
-		return false;
-
  	do {
  		if (mte_is_root(mas->node)) {
  			if (mas->offset >= mas_data_end(mas)) {
-				mas_set_err(mas, -EBUSY);
+				mas->offset = mas_data_end(mas);
  				return false;
  			}
  		} else {
@@ -5003,6 +5000,22 @@ static inline bool mas_skip_node(struct ma_state 
*mas)
  	return true;
  }

+/*
+ * mas_skip_node_err() - Wraps mas_skip_node and errors if there is no 
next node
+ */
+static inline bool mas_skip_node_err(struct ma_state *mas)
+{
+	if (mas_is_err(mas))
+		return false;
+
+	if (!mas_skip_node(mas)) {
+		mas_set_err(mas, -EBUSY);
+		return false;
+	}
+
+	return true;
+}
+
  /*
   * mas_awalk() - Allocation walk.  Search from low address to high, 
for a gap of
   * @size
@@ -5024,7 +5037,7 @@ static inline void mas_awalk(struct ma_state *mas, 
unsigned long size)
  	 */
  	while (!mas_is_err(mas) && !mas_anode_descend(mas, size)) {
  		if (last == mas->node)
-			mas_skip_node(mas);
+			mas_skip_node_err(mas);
  		else
  			last = mas->node;
  	}
@@ -5089,8 +5102,8 @@ int mas_empty_area(struct ma_state *mas, unsigned 
long min,
  		mas_start(mas);
  	else if (mas->offset >= 2)
  		mas->offset -= 2;
-	else if (!mas_skip_node(mas))
-		return -EBUSY;
+	else
+		mas_rewind_node(mas);

  	/* Empty set */
  	if (mas_is_none(mas) || mas_is_ptr(mas))
@@ -5128,7 +5141,7 @@ EXPORT_SYMBOL_GPL(mas_empty_area);
  int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
  		unsigned long max, unsigned long size)
  {
-	struct maple_enode *last = mas->node;
+	struct maple_enode *last;

  	if (min > max)
  		return -EINVAL;
@@ -5138,21 +5151,22 @@ int mas_empty_area_rev(struct ma_state *mas, 
unsigned long min,

  	if (mas_is_start(mas))
  		mas_start(mas);
-	else if ((mas->offset < 2) && (!mas_rewind_node(mas)))
-		return -EBUSY;

  	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
  		return mas_sparse_area(mas, min, max, size, false);
-	else if (mas->offset >= 2)
-		mas->offset -= 2;
-	else
+	else if (!mas->offset)
  		mas->offset = mas_data_end(mas);
+	else if (mas->offset <= mas_data_end(mas) - 2)
+		mas->offset = mas->offset + 2;
+	else
+		mas_skip_node(mas);


  	/* The start of the window can only be within these values. */
  	mas->index = min;
  	mas->last = max;

+	last = mas->node;
  	while (!mas_rev_awalk(mas, size, &min, &max)) {
  		if (last == mas->node) {
  			if (!mas_rewind_node(mas))
diff --git a/tools/testing/radix-tree/maple.c 
b/tools/testing/radix-tree/maple.c
index 172700fb7784..bb424f94de1b 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36655,9 +36655,66 @@ static void test_spanning_store_regression(void)
  	__mt_destroy(&tree);
  }

+static void test_cached_empty_area_rev_regression(void)
+{
+	struct maple_tree tree = MTREE_INIT(&tree, MT_FLAGS_ALLOC_RANGE);
+	MA_STATE(mas, &tree, 0, 0);
+	void *const dataptr = (void *)0x13370;
+
+	for (int i = 1; i <= 10; ++i) {
+		unsigned long start = i * 10000;
+		unsigned long end = start + 1000;
+		mas_set_range(&mas, start, end);
+		mas_store_gfp(&mas, dataptr, GFP_KERNEL);
+	}
+
+	/* NOTE: Still looks unneccecarry for me, but without it cached offset 
in mas::offset is too incorrect.
+	 * Probably couldn't be allowed without disabling caching at all
+	*/
+	mas_reset(&mas);
+
+	for (int i = 1; i < 10; ++i) {
+		/* NOTE: Wasn't working here without mas_reset */
+		// mas_reset(&mas);
+		mas_empty_area_rev(&mas, 0, 200000, 10);
+		BUG_ON(mas.index != 199991);
+	}
+
+	/* Cleanup. */
+	__mt_destroy(&tree);
+}
+
+static void test_cached_empty_area_regression(void)
+{
+	struct maple_tree tree = MTREE_INIT(&tree, MT_FLAGS_ALLOC_RANGE);
+	MA_STATE(mas, &tree, 0, 0);
+	void *const dataptr = (void *)0x13370;
+
+	for (int i = 1; i <= 10; ++i) {
+		unsigned long start = i * 10000;
+		unsigned long end = start + 1000;
+		mas_set_range(&mas, start, end);
+		mas_store_gfp(&mas, dataptr, GFP_KERNEL);
+	}
+
+	mas_reset(&mas);
+
+	for (int i = 1; i < 10; ++i) {
+		/* NOTE: Wasn't working here without mas_reset */
+		// mas_reset(&mas);
+		int res = mas_empty_area(&mas, 0, 200000, 10);
+		BUG_ON(mas.index != 0);
+		BUG_ON(res);
+	}
+
+	/* Cleanup. */
+	__mt_destroy(&tree);
+}
  static void regression_tests(void)
  {
  	test_spanning_store_regression();
+	test_cached_empty_area_regression();
+	test_cached_empty_area_rev_regression();
  }

  void maple_tree_tests(void)

base-commit: cbf658dd09419f1ef9de11b9604e950bdd5c170b
-- 
2.51.0


