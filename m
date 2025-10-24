Return-Path: <linux-kernel+bounces-869275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A8C077ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216613B3F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE533FE17;
	Fri, 24 Oct 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KCwrSrbu"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95B1DFE22
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325629; cv=none; b=as4TBq9jaqx+tFafyXdspT3P7dob3ECf/Bvh/2cbQWr4MD1rR5Fexa+QNkZ9B+bLl/TpPNbqzSy1XuKJIDQYHTWTc1tziF1y/zLgUm2IgU4dk75ZWYSSFWbkNVbgVf8EQzhYxqFoNjcfBgRyL2YutBHRYrdEx0hi0YC3+h/txiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325629; c=relaxed/simple;
	bh=w9ejRtO+ZLg5CHBUs0+6HaHm72+PHbE63jAWOtUg3yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qetekbInvBjRRlYturPcj5wdBtnjzdRZV/PP+fSvL+uHiZcU3fQiRiZZLU5DklxNt+/zAwmYaHOJ4twX4omddh1wQ5hnw/bJQze6Hy2wApbmhDWh07xDGIFIGwPnuoYsY9Lh6iBORytj+IL3LNHSdgM0oBuL9mkqGpMhwltze4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KCwrSrbu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so324557f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761325625; x=1761930425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTI0WrdtdIM0l0EagSMX46E8zaYjfQnvEEG1YbIgJSk=;
        b=KCwrSrbuEY1C+4/sMFaa565Sif6IElPS4jkWMhJU1buAtRbhcG2nCjKmPp/Qj1F3Fu
         BYOg+sZj9sY75ONGFHvHn+/kPjfYAbdZW6ApHKX7x7SyRzXUEoMdIxzeMD0ZWUel5GGk
         qnKWBIp1H2O4NISPCsyKmvk1hiqCdufQqxb07MhxDRY8ABX3IdlbPq3sIhAR0/2uK//p
         9aiw+tN+AskQJCvcjB+oIPTl+LWuW4XlviEHwJlsKKkwgErn42npUW4bnMW9vu5DiyWJ
         I7f5V1X9oB8SZBNa3rxzJpMj136/GlJ4P64HAYPHZMGfnYSvlvRG/p157kSdswxJdcDX
         V8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325625; x=1761930425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTI0WrdtdIM0l0EagSMX46E8zaYjfQnvEEG1YbIgJSk=;
        b=TjTwBdUa5h84rucgnaFg7pksasqxTlH4sRPmf5gN4ouQK8Lhe5fmDBBtMdKTu/rm4F
         liqtEdA/iYjAjMWMGGcfky1x8CtKeaJlzP37m+2ktHUy26lRoMXikY5f/W8Ep3f9Be7A
         nl4xDnoB+CR7uIaYbJjqbpweRQzKn+0xgz6V8qK8VUbreuHKFBpLA5ajOHGxQ3F1gIik
         UHd1muNjWml+dYcjXPR3t8Edf3Qu7naZYCHMH3BCgd6QmOXoSyFck36JZbJp12ywv+Fe
         XJLIZRqHhlOxDC/RXX41QuLrbl6tBbsQ6543NBLSmT+tNHoBPSmWxlSTT5NaqLtQ92Y8
         3DzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1q6g6rstQSOmjsBs02+h665OZ3MYF5aMzs58guTaBiWiwlLIgPBJePIpmGo121qRJ38/3RUUQe5P0228=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5svLR9JZeWYZeXJkRNWN9dKoIxl8QcW+L4DsBggChlbPxIsIa
	NxHhMQqs5Dff2m7AX09XsZXrpcNk5wtSuQB9XSx3MyNsTS7jl8de2XzPiuz6um+Ktjc=
X-Gm-Gg: ASbGnct89iSnJk34b2ZSB1EXcb7v+InBmI0YsuspVpJUN6lZ9gNTpGh1TRSCLvL+Oyx
	qi3C7UwOVYXi4eYMQxv+hj1ZHlsO13FmgJCiM+KFI0a5YQCa33bUe+nmxAXtA4DkA7nvrXCQrDc
	ZddIIbaOlZkv4Tkn3QEIOejoXflQ5NJw6fPNQfeX53+YYQZTPJDbind3vMXiBcUE9l5hoHNUsYM
	zqGOrYf28TI1zhzuhAQpV0V/bioyo2LUL2UW5xwkGbP5fVkMjPSWvqQu+F9pYa68NkeGq7s/JsC
	jE7sEBNuLSK5oYSE8TJCGx3o3bEU5/lCSdl6ciArf0s3Vz4IXEcBuR8zvCYOVby7wtfOiMzsLQ0
	obQuC13O8aOcIsSaWgWQotbj85q6Z0Bmv0P4ARVTYoj5K3eo4nrflUsJG5WB0NQmvBHb4F0QVdg
	xpQAtOM4Z1uiJY4fAc8hJ4BLyFJwIasMsegwG85bSX2UzjjY4lvPpWc1K/dKtUPiAi53lAdHfv3
	Par2VJDQMxuGmXP
X-Google-Smtp-Source: AGHT+IH88Xk2C96TCjVzuAAuYBe7oCUt2+32odpGfIEDb57P3nOWXPyKaYzrle+HrREbbngoJJbt7g==
X-Received: by 2002:a05:6000:2911:b0:3ed:e1d8:bd7c with SMTP id ffacd0b85a97d-4284e531aeemr6206406f8f.2.1761325624937;
        Fri, 24 Oct 2025 10:07:04 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429898acd69sm10349411f8f.24.2025.10.24.10.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:07:04 -0700 (PDT)
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
Subject: [PATCH 2/3] slab: convert setup_slub_debug() to use __core_param_cb()
Date: Fri, 24 Oct 2025 19:06:53 +0200
Message-ID: <9674b34861394088c7853edf8e9d2b439fd4b42f.1761324765.git.ptesarik@suse.com>
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

Use __core_param_cb() to parse the "slab_debug" kernel parameter instead of
the obsolescent __setup(). For now, the parameter is not exposed in sysfs,
and no get ops is provided.

There is a slight change in behavior. Before this patch, the following
parameter would silently turn on full debugging for all slabs:

  slub_debug_yada_yada_gotta_love_this=hail_satan!

This syntax is now rejected, and the parameter will be passed to user
space, making the kernel a holier place.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 mm/slub.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 26faebcf27a2b..b124087b95f32 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1863,7 +1863,7 @@ parse_slub_debug_flags(const char *str, slab_flags_t *flags, const char **slabs,
 		return NULL;
 }
 
-static int __init setup_slub_debug(char *val)
+static int __init setup_slub_debug(const char *str, const struct kernel_param *kp)
 {
 	slab_flags_t flags;
 	slab_flags_t global_flags;
@@ -1871,10 +1871,9 @@ static int __init setup_slub_debug(char *val)
 	const char *slab_list;
 	bool global_slub_debug_changed = false;
 	bool slab_list_specified = false;
-	const char *str = val;
 
 	global_flags = DEBUG_DEFAULT_FLAGS;
-	if (*str++ != '=' || !*str)
+	if (!str || !*str)
 		/*
 		 * No options specified. Switch on full debugging.
 		 */
@@ -1918,11 +1917,15 @@ static int __init setup_slub_debug(char *val)
 	     static_branch_unlikely(&init_on_free)) &&
 	    (slub_debug & SLAB_POISON))
 		pr_info("mem auto-init: SLAB_POISON will take precedence over init_on_alloc/init_on_free\n");
-	return 1;
+	return 0;
 }
 
-__setup("slab_debug", setup_slub_debug);
-__setup_param("slub_debug", slub_debug, setup_slub_debug, 0);
+static const struct kernel_param_ops param_ops_slab_debug __initconst = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = setup_slub_debug,
+};
+__core_param_cb(slab_debug, &param_ops_slab_debug, NULL, 0);
+__core_param_cb(slub_debug, &param_ops_slab_debug, NULL, 0);
 
 /*
  * kmem_cache_flags - apply debugging options to the cache
-- 
2.51.0


