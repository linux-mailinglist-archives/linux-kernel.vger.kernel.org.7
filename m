Return-Path: <linux-kernel+bounces-847293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF0BCA7E7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07D6482CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD5F257427;
	Thu,  9 Oct 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4N6nPYf"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522B258EF6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032738; cv=none; b=lV0zfUOqJIEpRUbN4TaFneNiYvWEFeOH1iArobaf4Y11UhJkfhgbe4Cec+Gu1w1jyZv8AGNJVIkDsom8swcgIZ/1xYIXd0BdV+uS0BUU+Oc3DoHNmLJGyS8g6Ty9v6qJ+qUOUYQXcjatYvjNSDdo3PE0Y4q/2/N4xiRgui/Mbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032738; c=relaxed/simple;
	bh=hD0GIkum0W39jX0UxEzb2WfDmaFO56evPVGPATON4xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXqL4j048roKLD1tu2Z4j0WPVtR6lUj+mzPK8DqVU2KJSklH2iUEfrrHWj88Cf8VMMJlGWa4Qw68anPMe+rTds9ws6kysDdExtJXbUrGT1tzmryDDVRx7xRq0Y7XL5hsVa1VVtb4p1qNhmRFCzStlUdDuc1w3W0QX6xXVE/25bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4N6nPYf; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88703c873d5so41943539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032735; x=1760637535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxHzW7+krO7PJKBXdtqexN2OJeKAsxXfOckL+sZhGvs=;
        b=k4N6nPYf5h6luSr4mQwcNc/229h5wy8Ow3KZ+Lda5FP7cl8AU7r6qzBUWnQlzQOO5p
         a/z/8M7kGORt6e4AP3xPGs4OFDZDk13JPGOKP8qOt/w4zrY3Ty1M/el+OwH4WsCUKM/H
         QsFLMOgqOgFtDWzp7ahehwz/aqPDewBbiCJRuhPQlKonEdO6f7L4uEYcrGpgI1SlGpeL
         WHG5KIciZt5DTpFFu1werxKmuGnyYgJ3hk5CfR26GUbN8bR2PAAhCXOTTEMxTrzxPhx6
         MhNmrYcU1/QcSt/tTUN/iI6npF1DjlJ6wZNI75HqTkFzLLyfnw8CWQ3BCBV1rLwqVPxv
         HxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032735; x=1760637535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxHzW7+krO7PJKBXdtqexN2OJeKAsxXfOckL+sZhGvs=;
        b=WTl58EdMTnOrZ+D4znEpA7Cl8piwxZ7Mi8m6sDzUVLbakFEvRfTn86D+NvUviSPt+U
         1Dd//NMpQ/iDfeJEdagNGSyuPmEGxqHmAuw2iBDr4Yx7ZuMJJj1s9uWHkTXZ2Lf/rQg/
         /Z27GeMbsluzhj7E1QVlmvjjD1m20F5BPLouIPL7qNVTCQgeF8XQsnmPxH/g9Cq8mZAl
         3DsBHJK9+TW5eRHyezvH6ijraCaSrELeszI0KKPkdx/AKeU7xtcVWmZoigRlWP0S9Kp3
         gA2gfjkbmssoHdFrCOP9DBNXfZ49J4l6GIdm8wzMiXSvgMrdWZZce9ApXfUW+SUE/nzm
         EY4A==
X-Forwarded-Encrypted: i=1; AJvYcCVzBdb/ACiArECpt2zUICs91ZfOdEm6hJ+hXf1xdPbup6JbvMZyLMwP5lcjLsRaXn33xcgUs5ux339GsWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvImRUUj+B53aL0kJ3qU65/MPrVSvcari5rCsmZnYHW3O1Yma
	/KN/DD1NaWQ1iBOtMbnP8stTBJ8j7CoKaP3IkgaN5s2xJZ+uaExURTQF
X-Gm-Gg: ASbGncumcEg3PxSkQBWmUBsar1oFMKD4HSO/YtNap9ZPPmwUlRz7cPdpidh8RYtLD9a
	xQYoLnV5cSeurFtkANJRH0OHHWtHeeAYJiQvEGMLZM8HWFWZXx+j/0s7eyHwVKHKdsrSul1R/nE
	00IFXymBM9kQxoPU6VadqklwESA2ueUOh3NkhUEhxgbapmdknfKEvLiQK/I9ExsVoaNSbu3bu2J
	AI3noWONKUoFASv/vmHEyPAp8cgEVrVjoqF2aJt5YisTVBQKYDqqs3ZZhKs8tLM0i3cYU9hjULr
	erIAIkjr/RlF7ZOIHAvNjqaIilBcQgBx0xn9S2vEM1YHSs9pZkpBdJxIc1dmBGCpca5minL7Y44
	TdgbnA4DcMFdc4zjT9DJKftFOswHAT/GKomOFEH+dQrpy5mE5lnTFtzdVLWDuE+38e7fAY0rEDk
	Ilzh0ZndcrU6LZdALOutlXGswvAT8=
X-Google-Smtp-Source: AGHT+IFEQVqHItn96Kc8TDNYahdPGtpH8o28572tm7Q+v8IZnToKzjnD+Tl3S+JyYpse/uqZNmWfdQ==
X-Received: by 2002:a05:6e02:1b0d:b0:424:6c8e:617f with SMTP id e9e14a558f8ab-42f87368781mr57791605ab.8.1760032735463;
        Thu, 09 Oct 2025 10:58:55 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:54 -0700 (PDT)
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
Subject: [PATCH v5 08/30] dyndbg: reduce verbose/debug clutter
Date: Thu,  9 Oct 2025 11:58:12 -0600
Message-ID: <20251009175834.1024308-9-jim.cromie@gmail.com>
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


