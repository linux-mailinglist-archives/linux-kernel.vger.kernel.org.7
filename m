Return-Path: <linux-kernel+bounces-863353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE5BBF7A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024263AA728
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286C3491CA;
	Tue, 21 Oct 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZtKaCLV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED425EFB6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063833; cv=none; b=VLRQQcUpSmes9aidnt7hFbr2SGGLCb9ov3N3CehkDrWmDroyasy5nhE1n9Fj1Rct9r7W9fId7akVuNTPUxLaAiogs9ejIHGRkUX4C64e3wOv5e4zKXdsNACXtlyGQq4arERHLGdU0UNrYV4xa+lUsEzgIzpTHqlWZX+NrY3C0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063833; c=relaxed/simple;
	bh=PXx5eLkbxk9JSDFEIVcWzFW4mmXCb7V+VCISbaH2UAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jl+fywGEsWVOl69ph/RHpsyc+JR00m//r1BM+qri4qvqS07Blb1fG7PKgbjEPFt4AnKwqXvhGQHUvFds3npAgP49c23qUSIao96vwJdoLxzfSHvB1BIAxkr8YvO+2tIUZFi2K+vsKncgV5I9fdxgbbOMgUjXn4zgZTthBvJBIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZtKaCLV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290aaff555eso56385965ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761063831; x=1761668631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rHjyJNySjOtG/oaWeyGKlZi0ukwWvydylLz+ummOiU=;
        b=hZtKaCLVqeCha9eEmT2+yIO4dbf4Z8I4OGpX8v0jtx+78+JGNJAQUNEGutAaiGNZZp
         koDfoXmVy0lUmU1MXAbFOjPUzqLV3c+srgnm6QgY80cxo2Gq+U3NDhV2omDxLMyrxRsE
         Jkii1+gRP3Om09KytBA3P5tNDvOpMeh5jW49j2ZQPWb7Bl0vn9aHq/d6LP4sRCqa/6nd
         8eXked2Zy0mUDlDII8DSgIfT1nsqgXCyHAQe2lEzj4gRKrxONhc5yXh5L8DsTv/p29sd
         nIqjQ0C/mZ7YU5noXxiD5N2Ty/2Si4LRATLaTXLRwfdsyFr7N9ry2l/aQOcZvO//Gw33
         hciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063831; x=1761668631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rHjyJNySjOtG/oaWeyGKlZi0ukwWvydylLz+ummOiU=;
        b=NQXR0bhxtibChOMp8Dr3JnqHo+XnY2rs4Vel7fx9J0f3IBQ8Yl3pWCiogXyhrxiclY
         8EtU/W90hLyzeNj975nnce87OJOpD4uaoFBySCPEWMckWfoe8Jy33ugoJDa0ucecKv+/
         p+0WpZc4+h/gILiQTmMmGuVF0IZNt9DxcJGeE7D1KswcvS7ziLCvpcsH1Auh8vs9sYwj
         2P59o9A3Q6qgvB2OwTOn6xosCjsLtFPBkORmDRsTmgC2KI5ISpbxH794JArnP454JJOB
         74zBUce1Tyy831kkTICdvBkzOgy15YRxXYN3vN9CAbnhnDJo9iE4QKnMicmyQEwJMg6F
         tO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk5Aewl3d6kFTFhENPbDHz+GQuLCZQ+Qf9airFu0drh6mo6/OXwnOYhdNlzSDVWyX4QZyuznD8Q/yDO1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDARJStXTDw9J+KCG/QFMzejvSfGJQhBOBdrM/xhFr7MuAcRog
	lwtHERHtW7LRmj1Nv4W6vt8xt4cCOIcqE16IegfCGX5ZVJ7rYmCBqq0Z
X-Gm-Gg: ASbGncvAIzxkwkax7e+tpk/x8hABKz7CdIx0dMhTuAxMNn8Jx1Pz/zI4LXe4QfvkUd8
	NQHu6CpXCRtYLJYKScqodlCBs3cBGIPpRtEhPxj/oyEBWoNGC/696OrakUHbrVuDLni9qvoz/2b
	WHdvY7vtO+wSjxKgvhLzzWsnqRA2jQX81vcgko3v0aINJL8hoJmueOQPdmQn/hdCKcE9pY9GwCP
	plQA6dKcfurf3WNTMJVQgNcAo6N3II0gXcJ+OdjQ9ULO8Z8XUreZ+7aBBL0sBfDmhjZbqPSkdGf
	77z++yZAsvdbv5TsTsVg/4oqwYaigWYgAILZYeZsyodQBN68GEHh5jcF9X0qxnQoBD734gR4+SX
	TXQzD6GDnCdpbMTzhexffAo9M3WoGjKSFBbsRhlylLkM5MGiOLch/YnABp0cGsAy8tTJEwnBMlI
	5bcSAvlNW52Kfk55FEwik=
X-Google-Smtp-Source: AGHT+IHkHuRO/cGncKISQZWD1qXwaE7w5T+jTVF2YE5Hm+JwJpfutTKAmSOGddAAEiei3b1lnpM3QA==
X-Received: by 2002:a17:902:f64a:b0:269:9e4d:4c8b with SMTP id d9443c01a7336-290ca403110mr218424325ad.21.1761063830609;
        Tue, 21 Oct 2025 09:23:50 -0700 (PDT)
Received: from LilGuy ([2409:40c2:1050:6e5a:c22e:8b12:2301:3845])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471d5938sm113390265ad.58.2025.10.21.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:23:50 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] mm/damon/sysfs: Remove misleading todo comment in nid_show()
Date: Tue, 21 Oct 2025 21:53:24 +0000
Message-ID: <20251021215323.29734-2-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO comment in nid_show() suggested returning an error if the goal was
not using nid. However, this comment was found to be inaccurate and
misleading.This patch removes the TODO comment without changing any
existing behavior.

This change follows feedback from SJ who pointed out [1] that wiring-order
independence is expected and the function should simply show the last
set value. and [2] checkpatch.pl complain about number of chars per line

No functional code changes were made.

Tested with KUnit:
- Built kernel with KUnit and DAMON sysfs tests enabled.
- Executed KUnit tests:
  ./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests/
- All 25 tests passed, including damon_sysfs_test_add_targets.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Suggested-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/lkml/20251020151315.66260-1-sj@kernel.org/
[2] https://lore.kernel.org/lkml/20251021010847.68473-1-sj@kernel.org/
---
 mm/damon/sysfs-schemes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..760279092b4f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1112,7 +1112,6 @@ static ssize_t nid_show(struct kobject *kobj,
 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
 			damos_sysfs_quota_goal, kobj);

-	/* todo: return error if the goal is not using nid */

 	return sysfs_emit(buf, "%d\n", goal->nid);
 }

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
--
2.51.0


