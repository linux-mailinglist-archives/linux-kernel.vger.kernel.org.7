Return-Path: <linux-kernel+bounces-892084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFBCC444D9
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 19:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FB23B01DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F105230264;
	Sun,  9 Nov 2025 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfFWJIcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECA21CFF6
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711634; cv=none; b=h2GtxVarXHVsJ8NAk1H4b+eqlgqIreCIoorjN+UQoR3ZIJchv72qYZH3GNkpFayGH0E8ofgPqEEWScfScEP0XtVn/rzWLoE6iJ9nOa1sQRSYdrXeVmGcy3Xomov7CQ6D5dxudA3ZWwxnrNyv+g5J4fygtE9HVyyWslHQI9h6oyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711634; c=relaxed/simple;
	bh=kaO5/IVrebOzmYLwKVSEsBGlfzzeuU+iOQME8bN/Vgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEHUZUu8Pfs+DIBJcNciLFgkdjgcx2tfDLtzTwPgsG9tMUNn5dHZY/vYCbo82MWRRq1oxIrzfP6mR1OzkEGfcoRnSEbKiZLpeJsK5TuPNZRws3vSvPhv//374f48sEqner4Bbyo3bE7uJEKdFiDegiKrIyHdAIPfYuM/bylsgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfFWJIcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B83C4CEF8;
	Sun,  9 Nov 2025 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762711634;
	bh=kaO5/IVrebOzmYLwKVSEsBGlfzzeuU+iOQME8bN/Vgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfFWJIcMlKISISBM1E6H9raA2HPW4eVb8izpDAHamiPCRjD9yz+rZZO+Q2fJ3fIXx
	 l1CrIWkSYtNrr/srw+vokFdC8aiM6GL5aGBKc6F8r4V5qMYs0AxX9bTPuHWRPhh6n2
	 y0NWPsbo9B6lxCCQd8dhvtmkirgpH0ZDyIFEMIxcynaGsxqLqL5fsUYr6cfgTCtjvw
	 Zx3Q+0RBAImo8DEEGO2wRWn+jYk8COlkpo7xghPZVTF2XugmThkdlwkZZM2bYJrJDa
	 VtbMFW7txrWkaU9GSXR6/PG4XJG+RJx3GkyPJ7c9xO8tp1noYhZAKeu4H1Q3GQ2+W+
	 13LM5qdxHEEhw==
Date: Sun, 9 Nov 2025 19:07:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 4/4] mm: Use ARRAY_END() instead of open-coding it
Message-ID: <9646a1d194a5d2f310d4272f9c240453e68c2147.1762711279.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1758806023.git.alx@kernel.org>
 <cover.1762711279.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1762711279.git.alx@kernel.org>

Cc: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 mm/kmemleak.c      | 2 +-
 mm/memcontrol-v1.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1ac56ceb29b6..fe33f2edfe07 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -510,7 +510,7 @@ static void mem_pool_free(struct kmemleak_object *object)
 {
 	unsigned long flags;
 
-	if (object < mem_pool || object >= mem_pool + ARRAY_SIZE(mem_pool)) {
+	if (object < mem_pool || object >= ARRAY_END(mem_pool)) {
 		kmem_cache_free(object_cache, object);
 		return;
 	}
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..b2f37bd939fa 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1794,7 +1794,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 
 	mem_cgroup_flush_stats(memcg);
 
-	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
+	for (stat = stats; stat < ARRAY_END(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
 			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
 						   false));
@@ -1805,7 +1805,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 		seq_putc(m, '\n');
 	}
 
-	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
+	for (stat = stats; stat < ARRAY_END(stats); stat++) {
 
 		seq_printf(m, "hierarchical_%s=%lu", stat->name,
 			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
-- 
2.51.0


