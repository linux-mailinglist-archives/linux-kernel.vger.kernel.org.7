Return-Path: <linux-kernel+bounces-755751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AFFB1AB52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2333174088
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28375291C15;
	Mon,  4 Aug 2025 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ30KFxq"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA610291864
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754349360; cv=none; b=K/RJ5IDvzM1A2mcSDZAYvvMBbD6kc7ytypaRJApiZr+aamg5Kui6IonbBPLHmLyIhSXvOlpVTFWS+rOABNon98FjViDyVPWYpYIZBkOUpyQ/yGV8DaQVonCX+T+HC3pEqlUUP7B8VestiwKZpzLhbUTzNxRNUS2dfQ85v0VhSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754349360; c=relaxed/simple;
	bh=JLzkhn9Ai/ASHzkFTaBGXCUct2ehP9RlVk17yOUGn80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdH8fhQ2jT0ChIHelQ5xpu7iwyxpxIQS9I8lE53jJZu8dYcjdnmGSZ1skb8pNno6L4koGg+7HLf3jUUrXtFYQV+oiezbW7olUKI3BtIwBvB4lB+42duadtFC3uxLhkXDhmL8bNxjLGYMFJA6TB2H5u4hmf9hkLOGMrpNjyKJm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQ30KFxq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so5552359a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754349358; x=1754954158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rATS4q8eQgXRIMxeVI6i3f0N8VShHmldfKu+DIDZEpI=;
        b=DQ30KFxqYOaZXRNTrSxlXldpQUcqbHwHSgynKNa3HXIMdBYFt/K/ixVcgA6JEYMJg7
         6Gm5SXGZdxv2vHFnETBlP+qy5KPhCz6LX/TlAcweeesiDf6grkyvWSwk+f6UrBwxGeDB
         SZojkVFr50Uv477pjsSSKQyUmfFGg1eSFSUM4kqrqfpZYEGPE7PS9aUoJqCFQbnyrDI9
         i0985pUjNZXfyDCoCFOw+zAM4VVbzVMMmh1trDJ7uOTARtGxblcrJfBZTbvGg3Dds8LZ
         d/29d1zT+mlXG/XIy85kLjkOyqiJg+OOQf12aKGxBR6oVaoNrGBoISnM7GqqCtlR+b9z
         mc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754349358; x=1754954158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rATS4q8eQgXRIMxeVI6i3f0N8VShHmldfKu+DIDZEpI=;
        b=Zc2/qd+7uiJtL8D4ZJU89oFdZBlgulSux8kHdlSPXD4LdgQ9/bpubEOOlzu270MtNX
         uyAlbYemsdD8FgcGHMmkarBkAWJ7vJ5cdHu8t40Bw933ICl/YNdu3s/IkZ3XZzlGd9R6
         jktJUm1EaGMHck2z+aM7EKG3U/mzrhutlIH1j6onJzZ5xB2NbcsEZ3XRK4pPKYX0Wr8u
         iaEq3QW6amYY2XUwCZK07zWLxmSuVXXrw/y186O6A5yhP3XeoZZg/hH8pbQ+fAxyeYH4
         Rc5fjisJW+dFkMCUMAHYNMpkfy292QRK/8dVGQZgvgDnCWQmAFOmGRPc8G18FUefFFuq
         S1xw==
X-Forwarded-Encrypted: i=1; AJvYcCX5dvgbVWRZKafkIoZMRqpcYfH99qdknND+bBgAqX1lwkeF+zoGE01yJcGBxccrCDndZ/BNDqoaba6pcrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhr5hF2MpWF2a6owXn5WAnGb0RxMD21mYjl0TX5jWuLMrwcNE5
	1Ksmp7uGT0UjFMp1v2Ay0rHuJ6f6pWwkbXLO74sGglV2CAXNaEnGKFAksOw2iz1Xnk1BHmO5Lwg
	VZBoN2g==
X-Google-Smtp-Source: AGHT+IEuSOf2jMTxPxDkqYSl5LW5Zcze6ynU2QOTKW6hn3gYFMFUvn0B/NfoN2M6d8RkK8dOvKSIuLnzjmM=
X-Received: from pjl8.prod.google.com ([2002:a17:90b:2f88:b0:31e:d618:a29c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a88:b0:31f:867:d6b4
 with SMTP id 98e67ed59e1d1-321161f0711mr16728967a91.10.1754349358011; Mon, 04
 Aug 2025 16:15:58 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:15:49 -0700
In-Reply-To: <20250804231552.1217132-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804231552.1217132-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804231552.1217132-2-surenb@google.com>
Subject: [PATCH v2 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is
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
index 66773685a047..d40854a07ec1 100644
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
2.50.1.565.gc32cd1483b-goog


