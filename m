Return-Path: <linux-kernel+bounces-812876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85073B53DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408BB188F268
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6672E2838;
	Thu, 11 Sep 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WogDl5sU"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66B2E0B4E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626738; cv=none; b=S4LQ2QnxI0rHOTgFGrLmXkqm0k55hxKCiZAfhlPTHzewQ78T0pVXd7ymYStzeYUZjD947FRzpIVLLK7HUq2a+Ze4WfwQkolnJNWwYs11zG295CAjSv7jXxgD9NsywNuB//kfyg6Cr93T2gXUj6vtsTjQFfokPxsn8iYkI7dhU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626738; c=relaxed/simple;
	bh=hD0GIkum0W39jX0UxEzb2WfDmaFO56evPVGPATON4xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGhIUH0YWFDhd4EThysPLrE5klgyX+dYafW4M9j3CGjnNwSHcC36ckdxMpsAjJ6DCj+Onip0yzl/PHZJ41YwG0qOoZ9lU5xGCagv6dt89rnU5Ao1TpyEcAq6oYx/PiWdW27SpifdWxRaK9gnPaVupruIjMk3+8FxA7hEv1ohmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WogDl5sU; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8876462a34aso45618539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626735; x=1758231535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxHzW7+krO7PJKBXdtqexN2OJeKAsxXfOckL+sZhGvs=;
        b=WogDl5sUPNIPZH9azW7u7rFL6iSgVuIV1udFahONSX+5SqTcjL+HnrLhSMm6Bdrmn2
         h0UMNUE4/onZqEyNC4hBNAEYg/Fmd5LkIhqlCBSHX4PzZkFx9SHW83r5zZQ1Ka3vngzF
         KW2WGAK4b/PDu1xj0LnKDQvW0w2I7am6jkSKjYYbgg9i09k8xKeIQ5euRdta2AwElPu0
         +qFQlmedwhg0SQ6DiZ0fvLuFkwhbDnFvF2+zGKZPfj+KDYghPezk2Geio9QhbrLVE5bO
         C8cNQyW9GeR6dpd4iHFl7AmCqT0biLwvJjJb98czxzUWxPV4XglY8iu+Clb88hTwVcDJ
         lRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626735; x=1758231535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxHzW7+krO7PJKBXdtqexN2OJeKAsxXfOckL+sZhGvs=;
        b=os2qVg2raqX+o9Ea7d1n2Iw5bJtaykUTdGz97cvksZOzQg0/LyPxXPd7gBuJTVsMs5
         brBmgX+TUeLUo22yJSfQejEncq5C0R1CVL1X9LqqrpVnf4aDyPhlGzQws3iO1pZGoVta
         BvbCwJqxCCX6HR+0x8wySitba8tFUdWJwQrfvegaWELmdlTkhCn7JhBZ46M1RktpRJaW
         XFv1D4y8Zhv1ue4/dMATzcdi9aqt9mANBc2ArECZLVaL4nOowwG1obgd4aVTzRSnS9OZ
         1Lcs0B+J1m3LH65hrU781/yg5H8FkPNbpV6N5aMMfDREXG4Y12ub+WriK9sCw+m8aqli
         17UA==
X-Forwarded-Encrypted: i=1; AJvYcCUj48bDR6roqnzxJm/dF13WhiZ0/xcc86EM+82/AYUmWzzZjvrDoA2nwXrmT2DN4cL6HibfWkZdCkBJAhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGH1veDNKO5/sFyppMKPDfdjqtsIWYHJ2ZXyuv3KV1plnyMFNG
	ZWlLtHlQ3oWmXYcydC8nh+Fi5CRnBK8Zjlym2WWoKESmQCe7zEVxll2T
X-Gm-Gg: ASbGnctODjEqB/ukAY60H9NO6xx6MWe/PiItWenxcFaaAZwCZ3lYrCVFeEN5ZsIGX5N
	MjmfoO9WNnFtXYo+/lVtmsdDrFSaFG/tkLM3pSS/9eNyXL5FRjD3Mgfmsjt4JBUC5TGaTdb8XkG
	rUj5s/jXSIwJanV8/Vfc8hqSo4lsPSyfK2n0yAmJns2QnlP8ikGWH/WT/+ZdyHJ80hb77uhdDt/
	8V2Oa7siC7PxoXHupRu0eZVzBY0Al+4IP5gIUluCvStRVWJTfFqpI8zEUxHH/DeuVM62wHxXl8u
	pCtY7xSJuMCMguTVh1P/KhzPVeS1iFV4H8qT62U3AB4sjXsYEQCSIkKwpzql/DiD5Tvl+BMBCHd
	c+lEQmvClXuSNGH9ZE8tvrAp0dP525s+0/2c+ol/BDqRkg69+vFHd28Lm7Zw60fJVXllmjx/TSi
	CG2wg=
X-Google-Smtp-Source: AGHT+IGh9KtrmwUXbBUhRbdqOIpY0X9fwGiso9A7YS8mL36vMA5p6Pja1GH+UWJw/1itbJF3jNefkA==
X-Received: by 2002:a05:6602:6cc4:b0:886:c53c:9172 with SMTP id ca18e2360f4ac-89034fbf057mr112259139f.18.1757626735164;
        Thu, 11 Sep 2025 14:38:55 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:54 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 08/30] dyndbg: reduce verbose/debug clutter
Date: Thu, 11 Sep 2025 15:38:01 -0600
Message-ID: <20250911213823.374806-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd line is like 1st, with result, not procedure.
   2nd line is just status, retold in 4th, with more info.

New output:

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 *flagsp=0x1 *maskp=0xffffffff
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

Also reduce verbose=3 messages in ddebug_add_module

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
-v2 squash several verbose cleanups together
---
 lib/dynamic_debug.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2751056a5240..d9268d051a10 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -264,9 +264,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -499,7 +496,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -513,7 +509,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -529,7 +524,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -539,7 +534,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -557,10 +552,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
@@ -1234,11 +1226,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.51.0


