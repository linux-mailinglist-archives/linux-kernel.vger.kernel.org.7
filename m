Return-Path: <linux-kernel+bounces-815793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57EB56B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CF0161CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262E2C18A;
	Sun, 14 Sep 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mh1R1s8S"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82C635
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873899; cv=none; b=NA/FHmPS+nhlrn8qpQzIi1saCxob9BwOZrAdVgvdu5rUlTINrzTI97JbfIdc23IxE3qFNwMVPdOakV2CxC7okTXLQQJlBLWjXfizlKC1BgiAdA7Fob7t4RvlqDs5MktlaZif5ciZ8grDL47o21H4OsRyjfFjogkh+D1GZsW5ZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873899; c=relaxed/simple;
	bh=2cGC2IX7m/qq5OqemImtqzbxOfAoC13cZti4xGjvr2M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=COzEbq23+a6DVd7niJq9Z+es/PvXJxnsLnGAvYZHQgZ0AcBIZIA5K8lo76x2aEfwb7l+wkiyCr+2lks65+NPoGqTEOWJft938DZbutypd8VaZxWvH/6GoAk8dP8GkGb5hlMVGRYvjOyir/zZ64P6eXw/+aWsIz9OvewuNXGshCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mh1R1s8S; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25bdf8126ceso65073865ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873896; x=1758478696; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bi0k3TpX+saOMQswzu6XG0cElzWGEVMTmu4d6zBBHZg=;
        b=mh1R1s8SthdO5u85FADH/UbV87H6cQCdcU8uwuTZrDawsFcTugopwkDcT3Z/Yo214C
         /1cI/zpaCNubGnqMcLJR5AaKUNzYSXAcJD7E8+uiONNCqjM5ZEyK0WMgHYojBTvyrvhC
         m7iRcaTDja7ljzqGtXoEld5THGUggv9Kc90q8N+pWoyN8sarx6prcD+yHzs6XIpjOGLV
         AT0LldVqfmut0cIZTqWkIo8wSX29Nb/wlT06aMvejf5OFt/UQIq/ODoYnM/Y9XzGyzff
         ICal47aNZQI0tpJT6paZcEmxAnoZvuhKYfaPDADCltK3v0Fdt3E874aAVd1zoDptEdao
         FYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873896; x=1758478696;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bi0k3TpX+saOMQswzu6XG0cElzWGEVMTmu4d6zBBHZg=;
        b=lf+WDwCnfIXT1MIKHzF/m/bGXT6Bs1EBS5GSVL2IGPHtiBLiGK0PGxUzRPe4LoZREH
         GNUXwqOxE3Cv4/Ptbtm9qRUT7c5mAng5/8MKHjRWWcgPOkND7V3qUDsXHokKWcFGu8ju
         pYUfILpwMU+Lsya3r3uF2jRwImAM2XghK5TB15bUSxIY/3cM7byyuSXrlOTQ4cGX8sA2
         HnD6HuafepP2iWhZkeWl3+Lq57wndPoAwVkxwOFd3YvhKPV2E1QfnvdZ38wFpHbgYOy/
         TlEfsrY7CkTLdF32rCxaeYzFO8H0LiNbCdkHDMShI5e9avU6Taz2FIZ/uZZU4YXD9sTF
         k1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8DpCb4IXAUrXuxBC1Oz0wf31P9ckn7seEEe7FoBJOOz8Tf1QKD8iGG4wtZTG751v35HY8U7oVq7+pw88=@vger.kernel.org
X-Gm-Message-State: AOJu0YytNXtrxn944TAsb8wutvTmAU6KodcL6NNA3Z+2YzykUQ/gbHp5
	1YgMuw6EbqE9A8dmTp8PI7vXkpJOj/AXcZniDTVQhM21+RN3XKXN4XTxjbN+tLFOO82cMfzKb8s
	0XmLq2Bp2fA==
X-Google-Smtp-Source: AGHT+IHTbTCs1wnw2lFNLVJJ8yhyLkuzjt3S0GvGOyaObENDRkwG86pcQRHmlGQUqT79gvZ1avanwlpjwPix
X-Received: from plei5.prod.google.com ([2002:a17:902:e485:b0:245:f002:d659])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc45:b0:261:1abb:e302
 with SMTP id d9443c01a7336-2611abbf094mr65953605ad.14.1757873895767; Sun, 14
 Sep 2025 11:18:15 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:18:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181808.1957729-1-irogers@google.com>
Subject: [PATCH v1] perf maps: Ensure kmap is set up for all inserts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__maps__fixup_overlap_and_insert may split or directly insert a map,
when doing this the map may need to have a kmap set up for the sake of
the kmaps. The missing kmap set up fails the check_invariants test in
maps, later "Internal error" reports from map__kmap and ultimately
causes segfaults.

Similar fixes were added in commit e0e4e0b8b7fa ("perf maps: Add
missing map__set_kmap_maps() when replacing a kernel map") and commit
25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel
maps") but they missed cases. To try to reduce the risk of this,
update the kmap directly following any manual insert. This identified
another problem in maps__copy_from.

Fixes: e0e4e0b8b7fa ("perf maps: Add missing map__set_kmap_maps() when replacing a kernel map")
Fixes: 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel maps")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 85b2a93a59ac..779f6230130a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -477,6 +477,7 @@ static int __maps__insert(struct maps *maps, struct map *new)
 	}
 	/* Insert the value at the end. */
 	maps_by_address[nr_maps] = map__get(new);
+	map__set_kmap_maps(new, maps);
 	if (maps_by_name)
 		maps_by_name[nr_maps] = map__get(new);
 
@@ -502,8 +503,6 @@ static int __maps__insert(struct maps *maps, struct map *new)
 	if (map__end(new) < map__start(new))
 		RC_CHK_ACCESS(maps)->ends_broken = true;
 
-	map__set_kmap_maps(new, maps);
-
 	return 0;
 }
 
@@ -891,6 +890,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 		if (before) {
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = before;
+			map__set_kmap_maps(before, maps);
 
 			if (maps_by_name) {
 				map__put(maps_by_name[ni]);
@@ -918,6 +918,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			 */
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = map__get(new);
+			map__set_kmap_maps(new, maps);
 
 			if (maps_by_name) {
 				map__put(maps_by_name[ni]);
@@ -942,14 +943,13 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				 */
 				map__put(maps_by_address[i]);
 				maps_by_address[i] = map__get(new);
+				map__set_kmap_maps(new, maps);
 
 				if (maps_by_name) {
 					map__put(maps_by_name[ni]);
 					maps_by_name[ni] = map__get(new);
 				}
 
-				map__set_kmap_maps(new, maps);
-
 				check_invariants(maps);
 				return err;
 			}
@@ -1019,6 +1019,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 				err = unwind__prepare_access(dest, new, NULL);
 				if (!err) {
 					dest_maps_by_address[i] = new;
+					map__set_kmap_maps(new, dest);
 					if (dest_maps_by_name)
 						dest_maps_by_name[i] = map__get(new);
 					RC_CHK_ACCESS(dest)->nr_maps = i + 1;
-- 
2.51.0.384.g4c02a37b29-goog


