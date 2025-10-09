Return-Path: <linux-kernel+bounces-847299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A195BBCA7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB34FBD1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A52ECD11;
	Thu,  9 Oct 2025 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv1Oz1Ir"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC42EA173
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032743; cv=none; b=ruV6BPUgNjXq9toeYB6Z8YUYxdDL0qN6FoGvWC1LHgX5k3sFu57AiGngZgXjo2TKcpY1WEaBwv2ds6bQPLV+RaxP+ZUX57I3qxuyamFGugeMgP+VoI2itDmFrfsYbv1E+nid1AXozeII59UGlUS8czAWDDY0vWJJbzNICC0iMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032743; c=relaxed/simple;
	bh=mz4pmSNtikpHGQKcU360KSG8B6f7Exi+ES9uDoE62vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkCOaHLXNYaolATI5KGZxSjEIISOPj5itRlk5VSQoWL02moj8wS3KnapM3vO9eL7UxOiJoHSp/9GHzzpMZWcQtFBDDy0sH8YxXd2yDNeVDstTYrI1CRIl6lvroJgIsA15C9a4FU0O6uT7FZRzj9u+KewNfy6vG/7zdj69sGspvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv1Oz1Ir; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-425911e5661so4815535ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032740; x=1760637540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcE2j/B1mQgeocNkBmpDERPavffRGmULzplmDVYobd8=;
        b=fv1Oz1IrtKJz7vtV98m7X1TC6QL9pKC5xaaleiQVsTYjW3Mh2LF4oetvb5Ui64mioC
         pD+PjYkMjklimC+LkTropkQTWbRDoh63tKFLJ+hJ8MP2kd6uWnGY6AYuwtxfFrs9+Q/C
         36ynLdyvqPtDdn+7CWb3Ji9GHw0BgGaTxK6Pgxnv7f1lBPnmWyYXF0oq+JTbc7QeSesN
         cA7TlKpHVdgspMo5nZ3OBp9+aZZd56OByEsJ9j2qAUw3N43AXSF3G5vDTKIWpuiFTXly
         kernV4UF8ElbA5s10zrDDZEm91JQzFiq6/5w6UuaKKPcNHcdwo0sNsg2xPjAn1QQ3JJ9
         bvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032740; x=1760637540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcE2j/B1mQgeocNkBmpDERPavffRGmULzplmDVYobd8=;
        b=O1LO5dL2ACfGzAJU4Iwm0dMQPw8NRGULTltt5yUFMyAdzYNKdyVtU4tf8F6DrnHebv
         ogwPxirNz7GhVjxVQEQjZSmYsHcO4DKgkRfw/7QoHLXnXz6QqOGWESjNhZHK5Z9D9qQn
         eAkilxtcKxdO7sAcAdyXmXBe5cGPJVbH/5Gvf2kZ+RhdQXNFUkYI97GG6dX4oCuNjJTl
         /VceePrk/OEk+1VO3+b1+G11iqaBaHsmaRYVKvinysG4TAIm4xnQORh5XekFiSA8ab1o
         IM6dlHzdHtdYufANlP9cnXkZa0GIsqGDZFl3TThk13daaEtWAixC4520/7I92mXGPtQw
         9FNw==
X-Forwarded-Encrypted: i=1; AJvYcCVL8NITn7o4RYJLLCM09xxT0K+lmuYn3cONC5D68X9HHMsRXo31UyidIcCsvr+wgoHkYVTgOTagpT5moOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhhPsQm0t/ctTzpjiYGHxW+oFutjIRC2NOXo4QqdCtuW2hUVX
	3afeOlnyXzMW2qMRM1Nk6U1KCgNsb0cYGtUZ3q6DqWFPbnyxFwPqDQ/9
X-Gm-Gg: ASbGncv7WnwY/xtNpPvcKD3RGl8wWUknOfQglbNXFKAy96nWnE3NMjOGo03ZCoLKWiX
	6FgJG5pIyTJEfpIkn/iv3cSojm4mswTgLn0pRiFwzAJHImeoKCpqLZHjCGvZ6W7WZkJVXg+vbx3
	YdpVnw0a5kPqXO4rILOTy/MOlL3dKBI458ymX7rtBnAQl8e9hWeoLDieIE3A+O3GV5TnUEfO/TX
	QDxgZ8wCSmUIheQfUS/VHDoAI3JaFtZ8DETt1P2rkT4agjYXZMbMdHG936N+FRJfDsBfQ+gEaZV
	bix9XgieS3vE4Gr8qE4tdr7+nD4/q/+qAJ5fN3RfiRxwT7USbjPflQBosZHclQrK59Vai1zDhYS
	0Q6KRtxcTMfrZjdQ7RyDBZdXD5GTvUWPZ9WllXCTNaYrxdLVzujaWeS/qsill8xsuP8Ardoh+Jk
	6KYy9FghtAVLZV7rGeiVPy0lx+44w=
X-Google-Smtp-Source: AGHT+IHjqP+G+vhE18sYwPA5Xq+a2h4s4Xorq9ruFfYudOUTjoHfdl8X+oo47RIuEgvRTTKzlg/Fzg==
X-Received: by 2002:a05:6e02:2305:b0:426:7dd6:decd with SMTP id e9e14a558f8ab-42f873f4705mr67420995ab.28.1760032739929;
        Thu, 09 Oct 2025 10:58:59 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:59 -0700 (PDT)
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
Subject: [PATCH v5 12/30] dyndbg: macrofy a 2-index for-loop pattern
Date: Thu,  9 Oct 2025 11:58:16 -0600
Message-ID: <20251009175834.1024308-13-jim.cromie@gmail.com>
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

dynamic-debug has several __sections, each with <vecname>,
num_<vecname>, and it iterates over these with a 2-index for-loop.
These loops are fiddly with the 2 names.

We have only 2 such loops now, but are getting more soon; lets
embed/abstract the fiddlyness in the for_subvec() macro, and avoid
repeating it going forward.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 283926530a43..ddcaa87f3b02 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -128,6 +128,20 @@ do {								\
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a sub-struct member in _box, with array-ref and length
+ */
+#define for_subvec(_i, _sp, _box, _vec)				       \
+	for ((_i) = 0, (_sp) = (_box)->_vec;			       \
+	     (_i) < (_box)->num_##_vec;				       \
+	     (_i)++, (_sp)++)
+
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -155,7 +169,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1220,8 +1234,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-- 
2.51.0


