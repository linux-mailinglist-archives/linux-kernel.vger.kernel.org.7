Return-Path: <linux-kernel+bounces-847307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA1ABCA817
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 680524FCBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C8B2F39A1;
	Thu,  9 Oct 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7SxxyGA"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4082F0C67
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032753; cv=none; b=TvSaSP/8/mdAF2ZiFY3nwMj5PuplnTWNyb5u1QrJJH/DcmPpq3J/Z2O3hDAiQRjEzbzz4/xo6VhR4jeWeSn/AuRrqn4KZ84tnB/pToDlpXoYH/WtvPttJeXtX9SUt97yO5naWpZF4H455lUACKNeQicBpWK3xMTmMU6NBsFkS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032753; c=relaxed/simple;
	bh=pchdw9wUalctnHO9hp3VAWlykvz40o38hAkRsbvrcx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe71eMJXiK07zuSzz1Y4x1O14bWK2REJjR0TLjzcmxD7+YarqLlJvaAbqj+IFVlDKck2z+evTorW4HA1OE7pBfJpwRCPBtRdCfJdmcAEg/j3Z6e5/7CJRwza/sKaJKVA1ikApwHs82yyIr8AOteORpZUIE7Mxy//jSQaML0yxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7SxxyGA; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-93607aec358so23444639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032750; x=1760637550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkrhZds/ll2Xl8Nzf4vLphQpqfGvsMLkRQg1rNtfyx0=;
        b=C7SxxyGAQck52iMSXSU9iQ+6clofXeUbJ4cHo2JMVYz05UbNyj+VUDkWwLamnq7r+7
         e04leJ5cp4MpfHKHCHHEhOEyYWcR0v43qokfFjIPVom/DXtBfx8LYs3t7VkY7nXYv3Ce
         gHsV7nZiq1Lj0Sa6wrdNuZegzoBKyIY+9fSJFToDb0IT4Qzr7k8Z6pzozYUHeqNJfSEj
         3wnuJkBmisBhJ0nxC3DXhWSYVHJIJ4FvFvNh88uZ8tyazcpTui09+jT47OkjkxMzIhrN
         w3jaNDbpQ3BFrxvjD5JGmDowoRZ4vbULxKq+GwcJs7B+JPCbQ9EO1FFUdFvKewA8PGJx
         otKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032750; x=1760637550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkrhZds/ll2Xl8Nzf4vLphQpqfGvsMLkRQg1rNtfyx0=;
        b=JbRsWJ9KzWm2ytPrNjTtd01TCvunHs13rIbjs+uKNk5JU2CWTILC5AbjYZ4ujfHerh
         V2tjiY6vBc1vRyOM+jiHFBQ+uZ3aZJFZD1EUGCSp45hzmqQPTw8M1S38Tjbe8QuedcrH
         ysntRt8pwalEVcXWfGfrQO1+bhKIto3W2jK+yqXJazaDzZFtB3YE2a/zgSx3EczKk2Fg
         zmB3Di5OFt4b9r/4diw3FMD7jtcyy6wMc1limJIyFRVpZd5MAMOjzGv8Mi3Iow0KsZfY
         38jTzp4bJxkm/a7ALJNrKSBwfxlFZphKaxoRgDNjYH5mW2MI2BLbtYRc7L0XlwFhbBZX
         9oNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpd2+0Gx65aP9LWX2ebnulV6qwFgKBhy++Pgtkx62Cz7rFg+jAYvnFgja6UaCU1VItGZDRdMD55OW1FA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiLsylFfV6WlQ14Uz29zuD+4mv+EaeyryYaVNthe1ZRzQfBPwm
	i8IS6jFcpaApSb8VUqjFhLbdPGLfjj0H/ou7HjZfO3hFdN9bXDzG24PI
X-Gm-Gg: ASbGncv5llclw2yydLFeAYds8edIL/AJNwy+cbmAg/0qs3yebKP001DfNLFO1v2khcZ
	HqEhoBFSYNgJlo/DG/Nkm3ddBDvWPk9jZlhnUoDsrbDJvT+nLUvGyW64GM5A96yO+x034WoNtnQ
	6Ryh3H7bmbQNtSWK7flN+VH+b/biduZiFdIN/zEO+p3E2K6z+W5+1hJKz7t3pmdYNbH2tFziuqN
	B1S8Lsdvgbr5HM5I5Q8vt6Q0oudXItWJnleMLi+5+1WYIPMUyvHYgsW/QzbqZY/yAvrb0lxU41U
	GVcgJ8FMcQRljCG43QHR0aheJyd78QX5svE4d1ykqHOlPsLGhAxdLA79LUY6CIYk+6KO5Hrs4OD
	wjQQCHDmDAdvB6Jld7e98dt/KZgEZOpe1QSoq3JoMXp0IJHbriC+7PayceDfVRB9VExlz6vFLiR
	h3kFvf1hZBexAm4y1fXYJrHBoKvrt9on3GIBiCJQ==
X-Google-Smtp-Source: AGHT+IFUtIEt4hZGGPIJzsczKNqnueKXhXvFJxzwNM//vyW6z4t8ra586gGXxFd/BYpLugooChengg==
X-Received: by 2002:a05:6602:492:b0:900:1fa2:5919 with SMTP id ca18e2360f4ac-93bd19882e8mr959644239f.9.1760032749970;
        Thu, 09 Oct 2025 10:59:09 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 21/30] dyndbg: detect class_id reservation conflicts
Date: Thu,  9 Oct 2025 11:58:25 -0600
Message-ID: <20251009175834.1024308-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a module _DEFINEs 2 or more classmaps, it must devise them to share
the per-module 0..62 class-id space; ie their respective base,+length
reservations cannot overlap.

To detect conflicts at modprobe, add ddebug_class_range_overlap(),
call it from ddebug_add_module(), and WARN and return -EINVAL when
they're detected.

This insures that class_id -> classname lookup has just 1 answer, so
the 1st-found search in find-class-name works properly.

test_dynamic_debug.c:

If built with -DFORCE_CLASSID_CONFLICT, the test-modules invoke 2
conflicting DYNAMIC_DEBUG_CLASSMAP_DEFINE() declarations, into parent
and the _submod.  These conflict with one of the good ones in the
parent (D2_CORE..etc), causing the modprobe(s) to warn

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
- USE doesnt need conflict test against DEFINE
  infact its wrong-headed - of course theyd overlap.
---
 lib/dynamic_debug.c      | 40 +++++++++++++++++++++++++++++++++-------
 lib/test_dynamic_debug.c |  8 ++++++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 54f93d1d0ff2..f94ee518ed62 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1267,6 +1267,22 @@ static void ddebug_apply_class_users(const struct _ddebug_info *di)
 	(_dst)->info._vec.len = nc;					\
 })
 
+static int __maybe_unused
+ddebug_class_range_overlap(struct _ddebug_class_map *cm,
+			   u64 *reserved_ids)
+{
+	u64 range = (((1ULL << cm->length) - 1) << cm->base);
+
+	if (range & *reserved_ids) {
+		pr_err("[%d..%d] on %s conflicts with %llx\n", cm->base,
+		       cm->base + cm->length - 1, cm->class_names[0],
+		       *reserved_ids);
+		return -EINVAL;
+	}
+	*reserved_ids |= range;
+	return 0;
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1276,6 +1292,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
+	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1290,15 +1307,20 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	}
 	INIT_LIST_HEAD(&dt->link);
 	/*
-	 * For built-in modules, di-> referents live in .rodata and is
-	 * are immortal. For loaded modules, name points at the name[]
-	 * member of struct module, which lives at least as long as
-	 * this struct ddebug_table.
+	 * For built-in modules, di-> referents live in .*data and are
+	 * immortal. For loaded modules, di points at the dyndbg_info
+	 * member of its struct module, which lives at least as
+	 * long as this struct ddebug_table.
 	 */
 	dt->info = *di;
-	dd_mark_vector_subrange(i, dt, cm, di, maps);
-	dd_mark_vector_subrange(i, dt, cli, di, users);
-	/* now di may be stale */
+	dd_mark_vector_subrange(i, dt, cm, &dt->info, maps);
+	dd_mark_vector_subrange(i, dt, cli, &dt->info, users);
+	/* now di is stale */
+
+	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	for_subvec(i, cm, &dt->info, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1312,6 +1334,10 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	vpr_info("%3u debug prints in module %s\n",
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
+cleanup:
+	WARN_ONCE("dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	kfree(dt);
+	return -EINVAL;
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 6c4548f63512..1ba4be9a403a 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -128,6 +128,14 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
 DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
 
+#ifdef FORCE_CLASSID_CONFLICT
+/*
+ * Enable with -Dflag on compile to test overlapping class-id range
+ * detection.  This should warn on modprobes.
+ */
+DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+#endif
+
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
 /*
-- 
2.51.0


