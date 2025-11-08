Return-Path: <linux-kernel+bounces-891727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF1C4354F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515753B2BED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0CC287508;
	Sat,  8 Nov 2025 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbObin2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34D28B407
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640443; cv=none; b=t0M6yWuBx7xf0g3fOxrgxNjiW1SnyrBOfhf/QKoJNuDxn5WiMwr9JRbL8sZ8HqnWdEDP8rv+8iP0tHU8hnA0cQYCFUeY3p7DMegjXJLDxClKRtcLkEZXGDq2nUD5VNN2ezx2q3Ljf/1ED21KPxA2JtxD0pUl58XFBuVCEMbrhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640443; c=relaxed/simple;
	bh=kaO5/IVrebOzmYLwKVSEsBGlfzzeuU+iOQME8bN/Vgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbb8mvCwqYv2kQUUwWxHlNalKENuL6NT2wks/gNflk2/bvqhb15k+zYmhzgiNfm3IYEYL8dRveVVStIyaTeqqS5coZSQRM9EUNseWW5InDdE4SJXTbvh27GGqmlsYVOy9+bM7il4KUXL7nsUVODP35Uz/CiM4ZYz9vx+zPsw0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbObin2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E34C113D0;
	Sat,  8 Nov 2025 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762640443;
	bh=kaO5/IVrebOzmYLwKVSEsBGlfzzeuU+iOQME8bN/Vgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbObin2I4+M3iJGSBJQ8EoGOSMIOY9Ogudxz00X2fTasZX5I3Uz9nxV760dS5ln1q
	 GvbGaMNKUQgCwtiLDiSdjzH1sBMopfSy2a5s9tM/bmoIT24S6ap3F77DNsiXYjlYLz
	 vvA9KphcWJrlVjOXuCcCp04v153Zpuhj87S+0wnC7IHmPupx6GDXcMFZKXB2ej/1OS
	 bUDzKFiU27bSaU0zkhzxqlbESGN9BTx4rzdqvn1YvWSOnT3cLz3h8tM6REJcdSmQMm
	 0Hjw66sfWqrsfyNneC+ne85kPZ2mJpUSHXzg+I8HZCBz/6xpobs/GeS2yfNfugDXva
	 u33ms1X96ElMw==
Date: Sat, 8 Nov 2025 23:20:38 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/4] mm: Use ARRAY_END() instead of open-coding it
Message-ID: <094878542457310b784a60bbd2d444d129c61b66.1762637046.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1762637046.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1762637046.git.alx@kernel.org>

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


