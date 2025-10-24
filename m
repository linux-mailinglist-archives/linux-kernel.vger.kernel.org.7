Return-Path: <linux-kernel+bounces-869277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89144C077BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE671C4631A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B23431EC;
	Fri, 24 Oct 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JcjjHzZS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CE32142E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325631; cv=none; b=Be1QyIB0unzI+xrKyfpiGDTpamaD6xpCjLFWlS93XlU9JGbxGWi1MzwPjtHOeLymTbrCsyJSxPdzd5rcFqB++zThuqpyZXXW5ykRSF6bcG5uzaxBeTaQxb9bq3n1nBov5wNQuEuqGJ7Dk7JQRae8l+j8OYs6xJ+AO1fZqQFLMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325631; c=relaxed/simple;
	bh=VsKpn86hsIBAqUvnGUuoxEVqUFOxhPODp5ffTeuSetM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnE1qHdoPcrDGlrYKnUMtBXvAytGITsJVybOYkr4aiIymBOX0grL0EESCv+JU0NRJRT0DUMkAUT2646N8oC1nje97p9lk9kaTV1OdFMlclqvCs1ASomEDhwt9+ICeCth6KBuPXVlwlRY9No9GrwWRA4CwdHyALtyKMrCfL2L/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JcjjHzZS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471810a77c1so1953325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761325626; x=1761930426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym8aETYBXAJKvWbueelLx1UUH7YGGFArm90KzvTaVUw=;
        b=JcjjHzZSu7RBaQak8AeMiF9PYvevXxQUAXRa3kWjHfeFkIgR537HbeEzS+DVwjbMXh
         W8T9MT3HIxQzm4NQDwe2JdD/RExFNYwdkNhgFFQSnbWZQi7uAwdU6hL6jcrN2Jd8Xw8t
         yiKD17tkHYht47PctqGkQkZNQ9DAZo1hsmyCtZZVuzpGdmHYpkujZ/XMUbjjI+5KmVNi
         87hW3cijFfZOwBVPYnFWWJ5Oiq204lu4yMXCoKcnlEa8E4vKD0OLgM1pH2py/IElnx/0
         cvCaS61KiEVOBM3NzaSQbp/8nk+Td+l3AOnLTIIawoyOIy0ZWMMxzYehxt/NCgDxdVmC
         7VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325626; x=1761930426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym8aETYBXAJKvWbueelLx1UUH7YGGFArm90KzvTaVUw=;
        b=RMXSdZkFRBR1NS+L8/maggHuK7EgNLBzKUZgnoveBEg7pE962QhUSUy4aUMGIkbrXw
         4YqtF2c2Dh+InCLzRitxVVoqKZGafoCIgltfREKsdf49ortpBoyBqQKIHqWF7EHBtUvO
         cPbdnAjMCGqZ+K/0VXyLcGIx+vZ+zjn8O6HOrn4RV1zWiUDTwj9H0WRy9vTbnmqNARS0
         cwHHqBeqYEXevfSjD0BYUDDG4KQE+PLJpCWuLsx0XIdWkisqSkz28R76UEJXLvfdKl8d
         2uY0t6EREnIW8QSgSVg2+Hu39WsJWWAlues1MKUk/sS/h43uCWJBpI8w3NZzAGmf083V
         ZMnA==
X-Forwarded-Encrypted: i=1; AJvYcCWrSYPfEIAKw24f8OhxbcoR/QVcAPW0lZ3Ho3oQgQPB7ipLsrVkSNaUzoEp0axCM/Z/v10hGjtePXzbx5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4huwbSE3jQoeylsqwlBCGuv1ferEtlHO4Db554Ke3XZVoggmR
	EhrIlG7CTY9E1pj+QOULslpI7Lm9NI6WvFqCYD2O6jqxSoKGlJxY12ISr6H4w6zxmZA=
X-Gm-Gg: ASbGncv7ZDEzreaMTA+9ctZE0wDsDzeVS14u5e+ZYUAmvA5ZS5yXJANlzu3OnMfUXlk
	9IprF57u7TUZd59c4VKZOxvWVD6Tpj7rogsCq4tk32ZX0a2IgzfNwd7EpovU29uxwCgwuZZz1Dm
	Abe8k1b8BiJi+kzufnEOXsY9kbiEt4/ZChBZgBXYrd9BCQBZY2rmgKoCit9Ob9nlqUMSL9Pwccs
	mmhE+T4F4KGQAzEwiFMpl6fNUtJxPDG38OUZ257xgm2eJCG9xLO2/zmmax9jXQq8pdMsa8g2Xme
	PswliI+PTD0avCY/Yyraa+PZ9yqoteC4cuxclBpM2VWvwMvOO4p908BQ8b57/FkllmDpFmzxHIR
	GiN1hIJnKPohOR4pnh+OSrWCXQgaTOwtYZfjm+LrB+Fp5TCnEkDORKUMMXmKN7fGXrWRZ/jho+T
	kY3ZMfFY5HBNXmDOe4/mZtdpiCCFWgH+71KtSV5T4/iTZ0oUeQ0MaesunyVvbOSsFsgLs4WQ7Qf
	cTqug==
X-Google-Smtp-Source: AGHT+IFJ/xF8oNJztRWfc273+XYd3dJHzM8CNxqHRb8nUro5n4D1a8pHx6sozSot99S9MPoKnjvpNQ==
X-Received: by 2002:a05:600c:c4a7:b0:475:d7fe:87a5 with SMTP id 5b1f17b1804b1-475d7fe88b4mr11897735e9.6.1761325626248;
        Fri, 24 Oct 2025 10:07:06 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47494a91c47sm91921345e9.1.2025.10.24.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:07:05 -0700 (PDT)
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
Subject: [PATCH 3/3] slab: use new API for remaining command line parameters
Date: Fri, 24 Oct 2025 19:06:54 +0200
Message-ID: <6ae7e0ddc72b7619203c07dd5103a598e12f713b.1761324765.git.ptesarik@suse.com>
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

Use core_param() and __core_param_cb() instead of __setup() or
__setup_param() to improve syntax checking and error messages.

Replace get_option() with kstrtouint(), because:
* the latter accepts a pointer to const char,
* these parameters should not accept ranges,
* error value can be passed directly to parser.

There is one more change apart from the parsing of numeric parameters:
slub_strict_numa parameter name must match exactly. Before this patch the
kernel would silently accept any option that starts with the name as an
undocumented alias.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 mm/slub.c | 57 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b124087b95f32..482460ff3abca 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -8119,46 +8119,53 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
  *		Kmalloc subsystem
  *******************************************************************/
 
-static int __init setup_slub_min_order(char *str)
+static int __init setup_slub_min_order(const char *str, const struct kernel_param *kp)
 {
-	get_option(&str, (int *)&slub_min_order);
+	int ret;
+
+	ret = kstrtouint(str, 0, &slub_min_order);
+	if (ret)
+		return ret;
 
 	if (slub_min_order > slub_max_order)
 		slub_max_order = slub_min_order;
 
-	return 1;
+	return 0;
 }
 
-__setup("slab_min_order=", setup_slub_min_order);
-__setup_param("slub_min_order=", slub_min_order, setup_slub_min_order, 0);
-
+static const struct kernel_param_ops param_ops_slab_min_order __initconst = {
+	.set = setup_slub_min_order,
+};
+__core_param_cb(slab_min_order, &param_ops_slab_min_order, &slub_min_order, 0);
+__core_param_cb(slub_min_order, &param_ops_slab_min_order, &slub_min_order, 0);
 
-static int __init setup_slub_max_order(char *str)
+static int __init setup_slub_max_order(const char *str, const struct kernel_param *kp)
 {
-	get_option(&str, (int *)&slub_max_order);
+	int ret;
+
+	ret = kstrtouint(str, 0, &slub_max_order);
+	if (ret)
+		return ret;
+
 	slub_max_order = min_t(unsigned int, slub_max_order, MAX_PAGE_ORDER);
 
 	if (slub_min_order > slub_max_order)
 		slub_min_order = slub_max_order;
 
-	return 1;
+	return 0;
 }
 
-__setup("slab_max_order=", setup_slub_max_order);
-__setup_param("slub_max_order=", slub_max_order, setup_slub_max_order, 0);
-
-static int __init setup_slub_min_objects(char *str)
-{
-	get_option(&str, (int *)&slub_min_objects);
-
-	return 1;
-}
+static const struct kernel_param_ops param_ops_slab_max_order __initconst = {
+	.set = setup_slub_max_order,
+};
+__core_param_cb(slab_max_order, &param_ops_slab_max_order, &slub_max_order, 0);
+__core_param_cb(slub_max_order, &param_ops_slab_max_order, &slub_max_order, 0);
 
-__setup("slab_min_objects=", setup_slub_min_objects);
-__setup_param("slub_min_objects=", slub_min_objects, setup_slub_min_objects, 0);
+core_param(slab_min_objects, slub_min_objects, uint, 0);
+core_param(slub_min_objects, slub_min_objects, uint, 0);
 
 #ifdef CONFIG_NUMA
-static int __init setup_slab_strict_numa(char *str)
+static int __init setup_slab_strict_numa(const char *str, const struct kernel_param *kp)
 {
 	if (nr_node_ids > 1) {
 		static_branch_enable(&strict_numa);
@@ -8167,10 +8174,14 @@ static int __init setup_slab_strict_numa(char *str)
 		pr_warn("slab_strict_numa parameter set on non NUMA system.\n");
 	}
 
-	return 1;
+	return 0;
 }
 
-__setup("slab_strict_numa", setup_slab_strict_numa);
+static const struct kernel_param_ops param_ops_slab_strict_numa __initconst = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = setup_slab_strict_numa,
+};
+__core_param_cb(slab_strict_numa, &param_ops_slab_strict_numa, NULL, 0);
 #endif
 
 
-- 
2.51.0


