Return-Path: <linux-kernel+bounces-812888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D76B53DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D2CAC1A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192B322DCA;
	Thu, 11 Sep 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUjOz4Hr"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21272E8B6F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626752; cv=none; b=lY5C1f9Hg1LLrG1HY3Bh+kFFZU3dCqM88HZByT7yzJ55C5Xv5CIpLkPX5nol4k9r4/9ZQvNx63Cy81qPVZ2BHr8WDvsLyGh9GEyQWlldtzUu5fcsdxnZOCC6pfrOTYrMBaaQNrCbda3EvlrBDUb3ZlKrw1xBUlGY0gVadi6H3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626752; c=relaxed/simple;
	bh=aeDWjd1XVoWEBDg5Eyu5c86Bx9UHoc1Fx952BSdfPh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLn/b1J9uUwMrp+UdwspN8fXQu9idYrF+qmIIzL4JNqBocoUlUqw8W9aEKp1yPVBEZCCPdDGjlK8EDmK4Esy+dRL/lkRqRkAyuJzHat+8IEEGa76craomNWh8qcDzBdD++yfGu1pvyHGEisHqwc34C8uTPe/jraBPL+WvJD5LHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUjOz4Hr; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88432e1af6dso91937639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626749; x=1758231549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C//yQQeTu+jEQ0EAFTF0I0EUgCZDFyfAeN4kEIk2I9c=;
        b=KUjOz4HrnO7pU0GJv8BhgJ3FZ5dJDVh5roXhuK4LmUDFJh0zYJXQOaxG9PCjOVE/Wr
         zU4Yqwe1LfhapfcJn9oH60nOzL0LjZ7BA05eKuH0Ex5PiYpu98/2lrIvWLX2dWfamJaI
         3KmfGMgTfgm6pMZjpgWS7coLUpnMv8G1/yBnXQjHooqNbl9xJU6FiGw/inw7NShomQR1
         jUhTFdPNm4r1abPq+Gwct86IR7yhbUaM7UaVl5ijvEcIdsqul1XZGVyakwAFNUXtt83R
         xb99v6RlfJDHV3LiNKb7kiRpQIc+xlRoENxgm1C30AQXyfhOmxJSZ1L88c5V80yGxaGh
         mfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626749; x=1758231549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C//yQQeTu+jEQ0EAFTF0I0EUgCZDFyfAeN4kEIk2I9c=;
        b=PB1T1Tqznrf0Sz6MoN6TAbEVN3GGe9WAEPWbWhxfVC55Od+oFwAxNW1UV3w2rx0iGL
         UsPCaJAiUzs7P1oTtMmhZnvyKHrY8cxn5u5R6s1v3ZK1gjau1sfJSrCr7i2xE+F/Lvvo
         QW8g2qHKzzqPIQvmgxkjNMjYMkYYgFVoTwfZdIXp+Rmop33JO8Sw49qML4FuG3BjEgO/
         rrRXgsIz4lR6/PBJjwgPKN2qWRpq94Xk6hNiK/TH32ocl2/t1es17hz904DY8IDE6GbQ
         xHLZW1IXQ0SxBAmMVYL280NzdD6XseXaRQgHmBJx4kmBmA9yNZAmyay5YffaryizorvP
         COjw==
X-Forwarded-Encrypted: i=1; AJvYcCWWbzh0fPRznrd5JIs5d88x9nPkPEHNphxlvuvb4GsyB11obyu7QubnRWg5FxWXDKxQB9qwUnpLI0Lq10M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MJrcFOrfmVJChTXxmcMicVOEfvm+8MolxGgiEmf66l0SByJn
	1CV9Yj6oHACTDb0ePPNipnqbmkYwAghy3V7zhydI9B7Nf1klftWNICkd
X-Gm-Gg: ASbGncv9uuL1Fozm64eqar+hRuSoMA/zPuAOA0uL/h52QxRUuApFCXwYPw4Xv+U542w
	6eNZXyQkehQpTSnF6WK/XH4kUY2DBvf3dQNnPu3x99nQnpEwG7nB6lqBmVfr1JlHn+rrLlwp3Xf
	Pch3ja6Wl1wCDjEjEC9ZfSfmrXL3bsAXXCRrDm0SPQweCK5d2D4YSAi5ieibTUK9xVz7VWfh6H7
	HoSywFdGu4vTLT35I0Pb2q1Mxt3K5cks9BwbX4SRbh6hijPyxYu51lTBr1Qr2PFsRLwr9pUOStC
	VD6hJ3Ajd/2Fnl+eebu8QcILG3/Cv7LQRuKUd4lILTjjcvNEfQQAwnCBA9cSxgpyEZ6DZoxpKX8
	o8iubo6twRrP3s64dSi0t2xHpQwOw4ZSU0rJHqGVG8EbdeAPfq/mTlp8CiIIaA4pq3Xma9yZR8I
	+k3G9Mcq+9VO6ilkxgDDLNx4EI
X-Google-Smtp-Source: AGHT+IEpa3ns1mvC1S52O8YWI40otKMGoW9WOmC/VcZ+5bFrA/7iKWELB83NSsPYI3FR7mXchVaQpA==
X-Received: by 2002:a05:6602:2dcb:b0:887:7a86:93e with SMTP id ca18e2360f4ac-890343323b9mr122515039f.11.1757626748722;
        Thu, 11 Sep 2025 14:39:08 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 21/30] dyndbg: detect class_id reservation conflicts
Date: Thu, 11 Sep 2025 15:38:14 -0600
Message-ID: <20250911213823.374806-22-jim.cromie@gmail.com>
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
 lib/dynamic_debug.c      | 27 +++++++++++++++++++++++++++
 lib/test_dynamic_debug.c |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 54f93d1d0ff2..b6a5219d71af 100644
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
@@ -1300,6 +1317,11 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_mark_vector_subrange(i, dt, cli, di, users);
 	/* now di may be stale */
 
+	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	for_subvec(i, cm, di, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
+
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1312,6 +1334,11 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	vpr_info("%3u debug prints in module %s\n",
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
+cleanup:
+	WARN_ONCE("dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	kfree(dt);
+	return -EINVAL;
+
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


