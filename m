Return-Path: <linux-kernel+bounces-833837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF8FBA32F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFEFD4E2259
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208EF2BE620;
	Fri, 26 Sep 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZTZNqqX"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF912C21FA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879327; cv=none; b=o5BPjKTTKhaU82ajbALWnQkDrFwrWZJApgY7HMBGz3JXI2AA8EVQiFth9oqmxeJfWWSr+lXnqtgqzzxuw5XQ1OiE0Pq4Mu4z95EMCsxYH7rgsgevp2Ew+CeMIE7HjZ7D1x108squwV313qabpr3/PXmjB9Pv71//qMkX5C8HYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879327; c=relaxed/simple;
	bh=UBiranDCCKyEzq2tHLJoYwbpNJseAjiAQrhPN7Tvoyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XI1iaoNJLwZBoLrlXMRe0syw0TfOi3IYAOfcY7AefiPSv9iTrrQnOrmz4SdKuciB7SdalHtN5WIdeiN2MCBbO1sq86u90upkqiDo8tHfm659STtGizyWDZjZe5jHimRSsNmc04+OrzKZiQxJIDtjoEUBMNDS9qnDQgeOO+p9YJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZTZNqqX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b57de3f63c8so522827a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879325; x=1759484125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huK0MPI+64vH11fsWziyabmXxqecdshCDlVy93FTD7M=;
        b=TZTZNqqXH+AfeJ44oI7xZfdHiyZfUVc36Sbzn8bU6P3ojXxKXwPchN/xSYUw+Q0zKy
         R2EdxBuB6bCnR/VCKuteb6e3Drc+ulJehOIy3mL7CEvYPjoQv0vX4o5eQXCD0boZ9/jh
         0U5plxSxr5g7+k4zk+A0aAhpLG+p0SpDn/NNfzGn37ujpQaKHHYmtEOqcUqxICfuAZIA
         VhBnbTStPdJueLt+6J1ePe7jKDnSiVutxHXQD5u+JL0TEBnxtvIfKnFojzyMl9yhLaxj
         HyRNHwCvpDpzSUXizriFjI0x8Sb1hay8fwKZrmXySw+6hBpdlCsJCWU7QBivdGBbd5nZ
         bJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879325; x=1759484125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huK0MPI+64vH11fsWziyabmXxqecdshCDlVy93FTD7M=;
        b=rs5N3Y2Vy7kGDBSbNldCPIzQGPuOLlsZA8btjCJlc1/7H0i/QFaq8GlgPvrIoIUY+Z
         XfLyk1s/f6E8Qro3lmH0S4v8GE16I15ym6p9dZLZIgAXwLOig5gZpqxo/TCsbk0AENOu
         4P9NtWze4kY2y7fpl9SfxqzIV6WRVVkNdyoF3+xRIzJtHtDWv7wAKQgwk6Dloijkpiu5
         IXue84hNuBCqX+YS9nVve1WIe8HLsV+GgIzT6tJeJwR/n3mHAFNQhLhtIw2LeWXbAH/Z
         W8ELhNPAzky2DmuJBtFCpRH0HhhouyvcwXUuwjFl+7CZdvbAxE7SAclwx6C0LgxcDpL3
         3I+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2GmMzq49FyvGPCo8BWonU92vcYJprHIJkKkGAOydzfg/zpSW1/say6AZNvReV0uG8fbrzmuDaHLKt1HI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvraoa5seSo/zgTMnSB7AvR6B1MLtkm15je+6ukOXWloJqGztA
	hrfgFny/qrok7TJzZOMrcaFsMXV1HEXyJA3tlvR+1ecKnE1hkzfljdA4
X-Gm-Gg: ASbGncsC6IcADe9Xbu9wL9cSmwlb+AnabsdNVFAixn9luQf16XVflLUbSvNdEHY8ilW
	eLCuiYTgZiikaCFHfMWcZ5ETJX//WxB97G/gTEhxh5ahZn8gA46fEc+IXGYaIh2k/qsckYRsqqt
	xXqWKp+Id0hHFHtBBdWoHMxxqVypH4RPa+5WrUfRjJ3AMEiFcDnvFgvMcTfKmBSw3dS3HDMMqBm
	gttbtHgpdRmwMWekaHjGxYYnzkSM4X5PeX6Iu2tyrzVj4mrWLhelvWDOSuKeDmdHRyYba5XX2y8
	InWYW+jIVSDIFlESZ6GwryR1cPegEewl7ubvZXwzeVCBhF6oPANE5t+kL6/qoM2LRWaK5SL6yI9
	ZxylEl2ISA0TncbOoPiU3H+hlm6U/xXwiFcGIIHaM+OfaoA2YzWHtJ2YWXCpLcCOM4ksmrFelr5
	9yTW1qEmKIYtVd
X-Google-Smtp-Source: AGHT+IGaBFISMjqZ56jhqOkqG6YgWjBFJGtoPxP49Jy/1yngaLT4ocjmKacYDQWcrmZR3MpcJrfLmA==
X-Received: by 2002:a17:903:1c2:b0:26b:5346:5857 with SMTP id d9443c01a7336-27ed4a3719bmr75144915ad.24.1758879324875;
        Fri, 26 Sep 2025 02:35:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:35:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 12/12] Documentation: add BPF-based THP policy management
Date: Fri, 26 Sep 2025 17:33:43 +0800
Message-Id: <20250926093343.1000-13-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1654211cc6cf..fa03bcdb8854 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -738,3 +738,42 @@ support enabled just fine as always. No difference can be noted in
 hugetlbfs other than there will be less overall fragmentation. All
 usual features belonging to hugetlbfs are preserved and
 unaffected. libhugetlbfs will also work fine as usual.
+
+BPF-based THP adjustment
+========================
+
+Overview
+--------
+
+When the system is configured with "always" or "madvise" THP mode, a BPF program
+can be used to adjust THP allocation policies dynamically. This enables
+fine-grained control over THP decisions based on various factors including
+workload identity, allocation context, and system memory pressure.
+
+Program Interface
+-----------------
+
+This feature implements a struct_ops BPF program with the following interface::
+
+  int thp_get_order(struct vm_area_struct *vma,
+                    enum tva_type type,
+                    unsigned long orders);
+
+Parameters::
+
+  @vma: vm_area_struct associated with the THP allocation
+  @type: TVA type for current @vma
+  @orders: Bitmask of available THP orders for this allocation
+
+Return value::
+
+  The suggested THP order for allocation from the BPF program. Must be
+  a valid, available order.
+
+Implementation Notes
+--------------------
+
+This is currently an experimental feature.
+CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL must be enabled to use it.
+Only one BPF program can be attached at a time, but the program can be updated
+dynamically to adjust policies without requiring affected tasks to be restarted.
-- 
2.47.3


