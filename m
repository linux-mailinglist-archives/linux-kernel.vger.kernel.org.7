Return-Path: <linux-kernel+bounces-760497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB19B1EC1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F571C82B95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC815283C9C;
	Fri,  8 Aug 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tom1YOuC"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EEA283FD8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666939; cv=none; b=tNOC5VtZO+6rs221j1fIokT8hGd1qwj87YQB5pNyBX+O6kGuthcLacrcOY8aV5Am7Gc2dNM0vNtGu8aALJAfdH8X2xvEM8qWDPcrKBHhKTvJbgURkSnXW9vqgMjjQQ5XZe6zctRoLfWh6TX19pmTju4tA0C8P93qru0jnskTL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666939; c=relaxed/simple;
	bh=XKTEUe7EpZmwdErMVrUj/4YyKjdTs+8FZq2bP4a5ses=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HU615CspZsXEX/vDG2yKs+fXJNWCwghTLGSob26ZNZT3mCF4TNQOOna0/AaRRCyvD7wIPMo+cR1pWHPiMJOLZ0T1q9dAUPl0MbRnI0irCnQQU8ncE0VKdfBP+PzjnMoM0DegpuN4IOCGeiHAB1tm4geZXZzh8yZYVLM2Kn+4IV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tom1YOuC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-240012b74dfso17968755ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754666935; x=1755271735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S8RI3/a/LEClfHbNax20K5D92my9/tqwTk/caS4KXZA=;
        b=Tom1YOuCa1wHyPTmsR3kIN8s9VxJc/jKSRKg+S2DgyvWB5kpKmmFV7QTM0X1pPlhuU
         4uIjhAHo18ykbAJE0GwyFSCeeXclb0lAPZjyM4rMLV34I37jIp4pQe6tlNV1v6630b/2
         p7kiWkoNax5zE2NDNWbBz6SuL4ctIo+3+sUp0SU8ZGXIcydcA+Vc1/GY3YzO5EspUXjb
         sQMPe16dbWHP7Tkfpu5hqHeOxQlfpvYwybm4YFH+m6PuWwvNzcZ3Dfq98Con/ASsf41V
         M/Ud6x29aRC4Hpb7lPr3n4J44yK6x2M8HJjilMBGiAMNS0UJFADyIHTUgrnTE1isn1US
         NUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666935; x=1755271735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8RI3/a/LEClfHbNax20K5D92my9/tqwTk/caS4KXZA=;
        b=EYIxGIHJVgD6XM4nzdLPE29tTfI41Bv2662j2/KinPrAzEshobnmp9mPK3K1Lm8Hag
         KXWyF4u5a9CZV/2gwu7Nb8RGPt3mJW1Y1oxd+WdqjhoroEoc3osFOstPo2rlu4FA6IBq
         56K8exvpIAGhtKAdmCnnCqzIvwrpUOEClTGe7ERAmg0P1NwZRVnPUdmhTswQjRA+nttO
         JLYw9sB0aJZxt8LORzRqE0iJM6a4qNHx7TGcoBmyXwCvRordxrDTQeA1AG9Dke4HwCoO
         k5mJ3LXWqY3KhHlMhXCnTH/P1uvSlNqRC0BCRyrdnHtJbUKT9Ze3QIj7i8ponzqFJKfo
         Q8hA==
X-Forwarded-Encrypted: i=1; AJvYcCWmVtKAJfGtF9eW4jH9XswkGo8QmjxCNEMQGwlM8dtsTUIZmOVNNRn67pzvJNO1yNn9fEuC4S6CDW1pJm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3rdPhS9ghSKp1k4FV6U/B5AXJ51PdqLSSjO1bvozqT7VTb4X
	4appWG60Kb41q2Ev7cyzFn0iAOi2kP12seI3pSGdf7VReLbwTYEVaIS8cS31K7nQPmudJVGQKEB
	lGDWH9g==
X-Google-Smtp-Source: AGHT+IE+DfdsmL2T51tGBXmSDKHhykJ4R796cnuth2Y+HKuXvkKdRqWEuUnZeBDrebjvi1qQ6D/RrsYt7R4=
X-Received: from plzt11.prod.google.com ([2002:a17:902:bc4b:b0:23d:ecc7:14e6])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc6:b0:242:9bbc:3644
 with SMTP id d9443c01a7336-242c225a177mr50512595ad.54.1754666935527; Fri, 08
 Aug 2025 08:28:55 -0700 (PDT)
Date: Fri,  8 Aug 2025 08:28:47 -0700
In-Reply-To: <20250808152850.2580887-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808152850.2580887-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808152850.2580887-2-surenb@google.com>
Subject: [PATCH v4 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is
 concurrently modified
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com, 
	SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl operation
correctness while the vma is being concurrently modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: SeongJae Park <sj@kernel.org>
Acked-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/proc/proc-maps-race.c | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 94bba4553130..a546475db550 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -32,6 +32,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -317,6 +319,25 @@ static bool capture_mod_pattern(FIXTURE_DATA(proc_maps_race) *self,
 	       strcmp(restored_first_line->text, self->first_line.text) == 0;
 }
 
+static bool query_addr_at(int maps_fd, void *addr,
+			  unsigned long *vma_start, unsigned long *vma_end)
+{
+	struct procmap_query q;
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	/* Find the VMA at the split address */
+	q.query_addr = (unsigned long long)addr;
+	q.query_flags = 0;
+	if (ioctl(maps_fd, PROCMAP_QUERY, &q))
+		return false;
+
+	*vma_start = q.vma_start;
+	*vma_end = q.vma_end;
+
+	return true;
+}
+
 static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
 {
 	return mmap(self->mod_info->addr, self->page_size, self->mod_info->prot | PROT_EXEC,
@@ -559,6 +580,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
+		unsigned long vma_start;
+		unsigned long vma_end;
 
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
@@ -595,6 +618,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 		first_line_changed = strcmp(new_first_line.text, self->first_line.text) != 0;
 		ASSERT_EQ(last_line_changed, first_line_changed);
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+					  &vma_start, &vma_end));
+		/*
+		 * The vma at the split address can be either the same as
+		 * original one (if read before the split) or the same as the
+		 * first line in the second page (if read after the split).
+		 */
+		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+			     vma_end == self->last_line.end_addr) ||
+			    (vma_start == split_first_line.start_addr &&
+			     vma_end == split_first_line.end_addr));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -636,6 +672,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	start_test_loop(&start_ts, self->verbose);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
 		/* Check if we read vmas after shrinking it */
@@ -662,6 +701,16 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 					"Expand result invalid", self));
 		}
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, &vma_start, &vma_end));
+		/*
+		 * The vma should stay at the same address and have either the
+		 * original size of 3 pages or 1 page if read after shrinking.
+		 */
+		ASSERT_TRUE(vma_start == self->last_line.start_addr &&
+			    (vma_end - vma_start == self->page_size * 3 ||
+			     vma_end - vma_start == self->page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -703,6 +752,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	start_test_loop(&start_ts, self->verbose);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
 		/* Check if we read vmas after remapping it */
@@ -729,6 +781,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 					"Remap restore result invalid", self));
 		}
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+					  &vma_start, &vma_end));
+		/*
+		 * The vma should either stay at the same address and have the
+		 * original size of 3 pages or we should find the remapped vma
+		 * at the remap destination address with size of 1 page.
+		 */
+		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+			     vma_end - vma_start == self->page_size * 3) ||
+			    (vma_start == self->last_line.start_addr + self->page_size &&
+			     vma_end - vma_start == self->page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
-- 
2.50.1.703.g449372360f-goog


