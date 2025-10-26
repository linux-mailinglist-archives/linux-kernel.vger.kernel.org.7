Return-Path: <linux-kernel+bounces-870168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5EC0A171
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602003B8535
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2281DF75A;
	Sun, 26 Oct 2025 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Iy9f2T"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C81A314F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440733; cv=none; b=lhKxErPBipT6y5ATdTSy3f8YWJocIqVu0WuOQaiOaWTFHAL3BCvFgQzUF5+VbJYTOYbYO5SGBPJ09jA3jjzqX+DRlL1sZfL5zbOrUW0B0XPhgXxeDwtCHyp3VrMHgl8SzVACPMRSwUQcwv1A43X1643kLkAGIETBCJYTYodvhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440733; c=relaxed/simple;
	bh=U5EN1inT/kWM5m4A5MzxqH+G+G2lk8n2GRDVD/piabQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLBKq350AIeoIGOt0WrB6iuYV5YTIyV5o8DtZP2y/gHMuLQNQ2HWhoveQtXKENNGoIhV7NhJmNahSk71vfIbmGA8KhE4OUEVWzsgaL6/Ipx2+XE1dCDkeVpOYvTZ05iABF8mqYL+PPYxh7oGCHDaKe55Hh0nPvEewn9YZ8ctIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Iy9f2T; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a4176547bfso615493b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761440731; x=1762045531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N36vhbRkSG6GC2TdNjzZ1OMz+RKJl4mIAfGLbGj75+A=;
        b=j1Iy9f2TPRyMJwkKPAyvnPC1tYWEIeFChtNr/s6cVRRys/vLihi499e2NJ7oHEyHrN
         KGrGbLXQGwxWQlbckgT1uODniyVUWl/g4hdoTb3PRsxO8yXa+U0XSVWckRqDAxUXaXMJ
         N/tRdXqjaGCtUDlU4B/KI2KLSBKNgQVMZlkJFumzr4P436F4/CEkBW9MozD8CN0kUVdJ
         zV0f0hsHgpzJzBDk5Uf/uoj/W2QTCyyx4ZmGfT0jRzcbwbU0VeMbN2Pd6oXWcnIJ2pRH
         v7syxewPeEEjzsHCVtpvLxSL37pmn5RUQL3Kt1Ae6ge3+8w7CiFTiWQgV6neqZ26gNdU
         jaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440731; x=1762045531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N36vhbRkSG6GC2TdNjzZ1OMz+RKJl4mIAfGLbGj75+A=;
        b=QBk5Mk9rANeDJwUXuGMVFbIMStFrplRyHsL0SPV4o+gsb3jmNJgd3z9yhLq1wQvG+N
         NSdw/N2rC8octbP+yuZWadFGFMqliH/yLxTj/epFduO9clDg6IkL0D73OmO38xtiG65k
         fcjm1sDaW/L+UVe6AStOcOuxI2IRzXV5KhInllZs6WXsMhLrj6C73pCwv7QK1QfYvDdq
         Sb4Hz2nhoZMgVwt88nQhwBQ4289e7MqdtpUnPwM+d9CMXiKcwVi/VUa7kegwHXPCUDN5
         6hzngarwiGWgrbRgaxKIE8qNodZOHrv9UBO+n8T1ehfzxE2B4oBUhEKRqL+obysyrGbW
         KzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3lkoIhwrAgX1udUMclwNOoyyEmFVkJtzhs0wJ9Qzfiyqt3hi+EnX34KBP8e65W0qMy54wcUfd9qgfvWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zwK9Ill5Jge3Kj1TLFMVy0IK2xs9eyzqLIZwNrm+nXEjOKpm
	FDuDVKOXNlRxhP9dPzZxR73qDnx8T3oJvAGsLLsobPOep4PUjUs0ewkR
X-Gm-Gg: ASbGncs4IoWmLmQJ/+RhqJUyUaiZWpT4As7SXCsgqM8jBVybd96Sqx3XJIwg2PrTEJ/
	jMlgqNJ+6TUdAwu9ohKNPsX9stLoZsWuO3EqclK0Xv1E6YyMkTBaOO08Cd7a8fTwbYxiRVr4u//
	Nz9IPdSOgi4pcdswg2TWCeuWpEhkIciSteO2BuBRb0iatfwq24zVn9v9/QiYRaXYr93mGQsgA2y
	zajgtU4Ff6hA3Ywlcew0TzIZv4MwgGfrBC9X8IuKXhU9XYoCNLOQco0/XAwDygH23shi27hfHcW
	HzFX2db6DOXPLrihz45H7zGv6wqJplGhwggXyISMovPZwiUd5zRLPd6ZSHQvEUkghHcxJXOD+A1
	kcBahNvG9VOW6I0QFDYOfivMC9SRvsXgAlSjGu6I0MYS+UjcoIy27ZkaXp7z//iyFXDVhSfXeRB
	lhIko=
X-Google-Smtp-Source: AGHT+IFqnGHut/11Suj2FeTeWv27UHLAlLr0nFmnErIj4agIj4rm3uNWP4XEpAPa8D23/k1s6P6wnQ==
X-Received: by 2002:a05:6a21:4cc5:b0:340:6a50:7e9d with SMTP id adf61e73a8af0-3406a50809cmr6289528637.54.1761440731426;
        Sat, 25 Oct 2025 18:05:31 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm3371597b3a.36.2025.10.25.18.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 18:05:31 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	axboe@kernel.dk,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	terrelln@fb.com,
	dsterba@suse.com
Cc: muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	zhongjinji@honor.com,
	liulu.liu@honor.com,
	feng.han@honor.com,
	jinji zhong <jinji.z.zhong@gmail.com>
Subject: [RFC PATCH 1/3] mm/memcontrol: Introduce per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:08 +0000
Message-ID: <18d8e6b876ea3ae98bff710474423a9a530f4a8a.1761439133.git.jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Android, applications have varying tolerance for decompression speed.
Background and lightweight applications tolerate slower decompression
better than large, foreground applications. They are suitable for
algorithms like ZSTD, which has a high compression ratio but slower
decompression. Other applications may prefer algorithms with faster
decompression.

This patch introduces a per-cgroup compression priority mechanism.
Different compression priorities map to different algorithms. This
allows administrators to select the appropriate compression algorithm
on a per-cgroup basis.
---
 include/linux/memcontrol.h | 19 +++++++++++++++++++
 mm/memcontrol.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..a91670b8c469 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -228,6 +228,9 @@ struct mem_cgroup {
 
 	int swappiness;
 
+	/* The priority of the compression algorithm used by the cgroup. */
+	int comp_priority;
+
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
 	struct cgroup_file events_local_file;
@@ -523,6 +526,22 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 	return memcg;
 }
 
+#define DEF_COMP_PRIORITY 0
+
+/*
+* get_cgroup_comp_priority - Get the compression priority of the memcg
+* @page: Pointer to the page.
+* Returns the compression priority of the memcg the page belongs to.
+*/
+static inline int get_cgroup_comp_priority(struct page *page)
+{
+	struct mem_cgroup *memcg = folio_memcg(page_folio(page));
+	if (!memcg)
+		return DEF_COMP_PRIORITY;
+
+	return memcg->comp_priority;
+}
+
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
  * @folio: Pointer to the folio.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..436cbc8ddcc2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5356,6 +5356,31 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int swap_comp_priority_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->comp_priority));
+	return 0;
+}
+
+static ssize_t swap_comp_priority_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int comp_priority;
+	ssize_t parse_ret = kstrtoint(strstrip(buf), 10, &comp_priority);
+
+	if (parse_ret)
+		return parse_ret;
+
+	if (comp_priority < 0)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->comp_priority, comp_priority);
+	return nbytes;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5388,6 +5413,12 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.comp_priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_comp_priority_show,
+		.write = swap_comp_priority_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.48.1


