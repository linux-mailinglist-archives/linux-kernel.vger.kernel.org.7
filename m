Return-Path: <linux-kernel+bounces-854652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A3BDEFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89469484F03
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C92798FD;
	Wed, 15 Oct 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2wH7hDz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51252741AB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537934; cv=none; b=p5IrDL7E3zLc8NvuYPa8cAQd6AiukKuDaMpNgV5Flp5clRy9u14YzT3lFbd7c+ERoOQccPQkXMLCAckwSOobSaeirWSPBGHGV3iqpe2TKSrBsqYCAcHuis2oZroKpeVztPjEIdTb8LdTp8pQ15M47GlGRN8rUlm+2+XaGOSuq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537934; c=relaxed/simple;
	bh=M3JDOPbFjkClAC4UX2vhrNDOfN9b6bNYa0hiNAn1emM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNxIyOvfMPuH2ZVxEQKhY1vrR2V3yxnYQPjqgCd/GqiH71CgQ4KBIdBH8QNkGQXnX/zoXxZK1F+JAIZckl4wQWTVQMPOcsyYoifQZVb/dtzyp0SRskXzCP74VyZ+ubtTEsWJXxC+LPfT+4of0WcfkRLQAoHnGrDdZ4YMsArihxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2wH7hDz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2909448641eso110085ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537932; x=1761142732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHmEXjchUo7p5MNeEkw3mVcK0Ae4ArUpPhVglZardsE=;
        b=E2wH7hDzkRL8PDMBeI58qq8pdyGWoikElGN309zi0u6ZTb1JapYfMPznTFuqZRZ2UB
         3mZ/Qs/+Io1RctJyUUxKvqV+D7EQCmcWS/6E3fFjkEw+jQl7Rmtvs7BrmPy5evCmmiGJ
         jxeNVba1Oa3GYxFYXVaT96nevEw5qc9H64tU0Rc4VsyExhps/G4PhgMZACV90vBxWSP4
         VYRSw5kqiQwpy6A96SoU597khVuy13j0taQh4ZM3OoYMYYon8qfPhm27AyncFFUHZAza
         EIheK9S9Wypf2cyAlr88lDViKiap4eAtW8mRWX0GK+1PcKH9/5yi41ZSYagXDhMBXacG
         dt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537932; x=1761142732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHmEXjchUo7p5MNeEkw3mVcK0Ae4ArUpPhVglZardsE=;
        b=YMC/9InCuyEmR9MRCjX6qymXDMvfGCZ3I1ARvVT9Ji69Wq/lv5yUucFvdipK+QCPvR
         ueYjTr+W94WVkXVYw12IsiSgZzI463A9vddpdbIig69XXCT5nqZ0gIL1MiLn6b2OvbTN
         DvSrvucX76/SEhrceizdE0MgwKKQ8ToBaUjme9pt2iy+2Dl//9DZu3U52BY3n+1njazV
         lCr6auULMq1SoUzMhVSLsBhXpXvJA1rKOXT37qTJytgvRQhxKimuHpBsChCH06V0cSXt
         nQbTGHhBh0a9GC/6FXkFM6IZg+iIbdpsscOBBB2k7VKtizI+82p2oSAhCu94zr0WNGQA
         jdyg==
X-Forwarded-Encrypted: i=1; AJvYcCVZz1bz68gaY5ZR/Q2kUEjBxDeGNRZbykrNNXLuZNg0itO8Zo2tFbiSBKZcc/yPeMpHGkIFexLqlV74M74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8SKzJzHAwnPVcB4JbuQKCp7M4gwk9+yx3WbUQcg/HV3doQvEV
	jqxB7nBFN+0MYA7xbYV1TztncXTCUuNvNsDs0W4FuZLsHGiNeXDrH+QZ
X-Gm-Gg: ASbGncsihz27teZHOxHCoMdxvQmFzL/88NXehxqs3rwMlqHjCPERIpvegRY69Z4zzMU
	pT3w/+CDN7odGd6Ics3IkKLymLy40+8QJsTwdQB2JpD0tCCsLSdS0NoCuuY1Jandk51in6xyxKq
	68X9b2SG0B9/EoAoyVgfWxRAMn5GXOkNn25xGNj8zpfZDZNSnTUtRAhZRZlOg5PNO9+4AjakKMQ
	4SaCuE8mb1WtjakK6iqkURow9YwU/M5skx2vKaMepIpKapwWZgJZ7gePb7Hdzy/k5BNmw0TSr89
	tRyvq4yyZZvjUl3GQ64FSqEgRLCIX6m/GRZ5uUjR72CRnMofPt2DBsyl7BCRS/LwCO3QTAugqew
	eQmOtV5erHup6G3Bvxb8sbEwUZRpv8y6iEnLUWh8NmhZCqqwvcbHY5M/E958BMywKxocvhgWVFT
	5+KHrtpA==
X-Google-Smtp-Source: AGHT+IGPkoQEyym4vrrdjP+BNzpJr8ZiqPYTLWrM9emXz1prPZyu27GMgJiwVA1OnHpVqgCC5eI05A==
X-Received: by 2002:a17:902:cece:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-29091b162f4mr3433615ad.17.1760537931868;
        Wed, 15 Oct 2025 07:18:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b80:80c6:cd21:3ff9:2bca:36d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f32d6fsm199561445ad.96.2025.10.15.07.18.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 07:18:50 -0700 (PDT)
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
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v10 mm-new 9/9] Documentation: add BPF-based THP policy management
Date: Wed, 15 Oct 2025 22:17:16 +0800
Message-Id: <20251015141716.887-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251015141716.887-1-laoar.shao@gmail.com>
References: <20251015141716.887-1-laoar.shao@gmail.com>
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
index 1654211cc6cf..f6991c674329 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -738,3 +738,42 @@ support enabled just fine as always. No difference can be noted in
 hugetlbfs other than there will be less overall fragmentation. All
 usual features belonging to hugetlbfs are preserved and
 unaffected. libhugetlbfs will also work fine as usual.
+
+BPF THP
+=======
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
+This is currently an experimental feature. CONFIG_BPF_THP (EXPERIMENTAL) must be
+enabled to use it. Only one BPF program can be attached at a time, but the
+program can be updated dynamically to adjust policies without requiring affected
+tasks to be restarted.
-- 
2.47.3


