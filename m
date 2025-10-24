Return-Path: <linux-kernel+bounces-869274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E3C077B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3801B88BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5B31D751;
	Fri, 24 Oct 2025 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f6NhLz7f"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B21EFF8B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325628; cv=none; b=NBnhT4iIacrN4yT3RFREBnKiWLxAhY/ln6X9jukLg7DWvlnYRTUwn3/3TgcQuW/dMpI/XYI6P941fZ1tzGUIPS9UAJzcaMJ5nnW0Qg4sFJDlwXYiwsdX0Dg96CvlT0zL6m+t1yd5AHwbHCyWZcxtInhCV6oukZXEfY5UjBqsYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325628; c=relaxed/simple;
	bh=bm7qKyas3/K7dfZdBRUukM4arBqH/DL6nfMkyng71Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnFKi9KZvhyJxjUloSfLYLGdDhyZ5vu9Wc4/KMh9CK7dgQ3b4lv20ZT2pU/fRYUK9a0DcQtwicqF7v+ilHIbglDKPFDtsFwZXiI2LhwfVsclo+xjXsAGOmmt0ByGekiQOvEIUwRc5aQj70fDTSXleSoDEZ/SnaR9l0ieqj91Kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f6NhLz7f; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-40d0c517f90so222365f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761325624; x=1761930424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkvZhdbwE0zHe1scRt6PXV1u04HKt3doe8wAYGFveK0=;
        b=f6NhLz7fUC/pcx+52XXk1RxUFna+MLKEg9MM16lAvdDPH/CLFYowV0Q+8VWY9EzAEe
         IjqZHcp0hszfLPMcxQmx6E7nSW4qWezMVQNyzAwKWdER9EsqO6oI4Bqf86IfR1FHqQoP
         bdOO8NnkZXC1a7tbeYPEsohFZ1JkQLcHp8ugsfZoKdXJ/9ogsWDL0AUh4oHYSsSP1hJs
         0NoQoZTobiJGlKxuWEUbFUxkGNxIN6hkiam8rsH/OPtzit7FQ2UyHSYuHOpNAVzIwYVI
         VO/Y0uDVyyr+03HiKG6QCqSrQagO0SqPfdhr6rOD+HYb3XNOzAOO7o1KouVWVrBiMLkH
         nXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325624; x=1761930424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkvZhdbwE0zHe1scRt6PXV1u04HKt3doe8wAYGFveK0=;
        b=OvCaLTvlxBljoQkwOu47dMO0aMuRZ2+9FS/Mk6hN8IuXTUT8N7l//bgMxT/EopGRCL
         DLRRcf3omhWBASl7Qq66mq4iilmBGLcIpb1DwJARLumAF4JnqzYFvtOT9LzCXHYYDM1B
         QNKcJjfRvtt7zdKaaBcDRzhFobwGacPK3pE5stlVM1NDSxTWmmOWKUHaMF6TYp8Dsfwf
         pI24TSXbtgvgCzZpTTomkpCMN3xCEWVefw5jqZNp9oHgQn3yL75V4vLO49aug49LSeCq
         jDd5IqhMrrgsMTFSgSQ3AED6HyrAMx1Uo6ZsmZktaS3HPsO1soUdzDdeamFHt9bRbuT1
         ae4w==
X-Forwarded-Encrypted: i=1; AJvYcCW8X/k50SAvpWgJ3ZsVOPRi3gUycgGRFH2mKrAm6Rs39SKdCbfVHoaWWC4rfj7u/1Q3HglTGOIkF/hdrG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26WMXgsNmpWrJ1FzBvSx73VAYtr19ZoKx+f9RnDUkRwMnSuW0
	VmELq57tfh5fX+zD9jkTk5OfFz5nYQN2JE7s9uH0ef9MkiKj5O8J+ObBKKS0Yfl9buY=
X-Gm-Gg: ASbGnctyCPWLTn9Lso9y4MTVT6sXAZAWtUcGqabhqksMO0jv73GGHDfzEwgMT1O3+zD
	VyNnWvrVGnq4LRASmEUTITO2Ed6ECI5tjuBZlFrFbdS4tup/OCUm+gJWp0kxdjPnn1aGZn2dAuM
	mjh1SHF81eDv3gcvP7uySqbuUaUuZbAEwSV3DmCPz7sYFkN79heZ8UtzNYmSECAXKQ9fdhHSJBn
	y2ZvfoSGMjqPmTHKlR/JbDQPzUIBgVrp/atTULep8DNNmpSu+siGmNwCdMUXwOrjF2MjXF6rncE
	Oc1O20vq5u/9NP2nAgNqalqM5C2LoNBhds/tYbTr6N7Bye5c6dVqNjDCZE0n3B+sMBqDKLw/G/0
	ftxBGhGRIf0nfhwko7QHJAF0kOfzOP3By/9m8exT4g7+9+QLPxtuwy6MLIQ18Oi+KLnnyFoqYST
	Y9kbECVoKBgrrBMQ/Ned+mip7UuLh+2Q+21k66w3MX6qb1H+Lv6A4X0Lu1apYQjb0GSR7bJEehL
	ln+CQ==
X-Google-Smtp-Source: AGHT+IFOdIsSVVzn/A38btcKv1b4yLc5cSpEdQBdQ3LC20PhUez9LVJyrDwpHJch1FqbP+zb9YQfjw==
X-Received: by 2002:a5d:5d0a:0:b0:426:f590:3cab with SMTP id ffacd0b85a97d-42704ca9e0amr10525949f8f.0.1761325623887;
        Fri, 24 Oct 2025 10:07:03 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429898ec1dfsm10336995f8f.43.2025.10.24.10.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:07:03 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 1/3] slab: constify slab debug strings
Date: Fri, 24 Oct 2025 19:06:52 +0200
Message-ID: <819095b921f6ae03bb54fd69ee4020e2a3aef675.1761324765.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761324765.git.ptesarik@suse.com>
References: <cover.1761324765.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the string passed to slab_debug is never modified, use pointers to
const char in all places where it is processed.

No functional changes intended.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 mm/slub.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 708848d3512c5..26faebcf27a2b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -978,7 +978,7 @@ static slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
 static slab_flags_t slub_debug;
 #endif
 
-static char *slub_debug_string;
+static const char *slub_debug_string __ro_after_init;
 static int disable_higher_order_debug;
 
 /*
@@ -1785,8 +1785,8 @@ static inline int free_consistency_checks(struct kmem_cache *s,
  *
  * returns the start of next block if there's any, or NULL
  */
-static char *
-parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
+static const char *
+parse_slub_debug_flags(const char *str, slab_flags_t *flags, const char **slabs, bool init)
 {
 	bool higher_order_disable = false;
 
@@ -1863,14 +1863,15 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
 		return NULL;
 }
 
-static int __init setup_slub_debug(char *str)
+static int __init setup_slub_debug(char *val)
 {
 	slab_flags_t flags;
 	slab_flags_t global_flags;
-	char *saved_str;
-	char *slab_list;
+	const char *saved_str;
+	const char *slab_list;
 	bool global_slub_debug_changed = false;
 	bool slab_list_specified = false;
+	const char *str = val;
 
 	global_flags = DEBUG_DEFAULT_FLAGS;
 	if (*str++ != '=' || !*str)
@@ -1935,9 +1936,9 @@ __setup_param("slub_debug", slub_debug, setup_slub_debug, 0);
  */
 slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name)
 {
-	char *iter;
+	const char *iter;
 	size_t len;
-	char *next_block;
+	const char *next_block;
 	slab_flags_t block_flags;
 	slab_flags_t slub_debug_local = slub_debug;
 
@@ -1961,7 +1962,7 @@ slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name)
 			continue;
 		/* Found a block that has a slab list, search it */
 		while (*iter) {
-			char *end, *glob;
+			const char *end, *glob;
 			size_t cmplen;
 
 			end = strchrnul(iter, ',');
-- 
2.51.0


