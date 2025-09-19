Return-Path: <linux-kernel+bounces-824584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F270B899BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A34617E4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3157B23B62A;
	Fri, 19 Sep 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jaVaMUFL"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672322541B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287220; cv=none; b=FlNYnTw3Kd6qw706MCZcCDYVUMOZP4Fk0HbZ5FYMeQqNGR+VJQks3B9DMrYlkT8DVPuO/lb8LJCGRLFG92iRnOS7s9CO9XXcdv8X8sQz3+F5Qa9pzlBEUMhVDbtXC+iOjOW+slZm1fje/02C4agEb9WXr5XY787DVrCfE8jAutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287220; c=relaxed/simple;
	bh=Gza32SKoO3l1Cxp11yE7x1EtLYd/1eQwu8OxMPOOBuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOgTtqkqEIdXk2D6O2YoXdb6KB0p+pipQOluXNmNlXzHVVhrBc0Y2+4A4pcKHTUnsHQF6o4otMxCM6pp3bhbHjcro39/z1fbPSA3aEsVELiaAT3B7ZlDMYMuotds+C9MY/qm46V1QO7XB30T+BF3GokwTpTxE9GwFpsdpkBtGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jaVaMUFL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2680cf68265so15920595ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287218; x=1758892018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urmko1apH8CcrUCNE6fCIsulid4np4tADfs+rqxRds4=;
        b=jaVaMUFLBvkQl00wFJ74x0+km4Mlw3eOfdQoUv4Y4f4TzNi0CO5fWjWfoPn6oiVtmW
         ILvZpAwzitJLNt8ytnl2dmr/wVSOt5rQsYWzzMh5nxzjfcKaj4MOI5zeGyv6MMt6mKOn
         qskiu2SVsMeJ1OmT11kGRKDSBwaiC9opIW3UKfPD1dOfaffESCNY24O+3BnQVFLLqfIw
         LexCnWDOnzBLH5uvZx36vLDwIVZCQp02thmrUetSXrkNSFZGSv2OtLULieC3UKOBe8c+
         K+RD2v2mrpjJIQPAYa6fIq1SGi57SC8dC4LJqEa5PxspNcLWVbGoIYy8/B6Yz02fguKW
         0V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287218; x=1758892018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urmko1apH8CcrUCNE6fCIsulid4np4tADfs+rqxRds4=;
        b=kWcHhdXRdHM0iz2/rSh7Wx6mKOLJwi9V3dxcNDGNXo2MlgK6RhxccyRtiSNWztwQT8
         O3PtrjcaXdO1JpIK0B7tEUuJvI8asP5cc1Dl7Vm6+nt/1xtJDcywCtLqKCuETlo8lbgF
         rq+fhzZVdWWnQjjLa3P2u7y5+yHt9q6SRRm8HCewMwNQEaGNMJTMlavLRadcvetW/39L
         /kXvTDmph9RfSblHxgNjwdZYetZ26UX17DJfon0vIgRK5CAw4kvHFbNPFNFGedoSRqlD
         iqbIIXlx8hcrXVHVde7FcxR/nU4EMfwBVIcyDI/S1bsRrRHnfYgxBYfdbqwFTDAyACfN
         apdg==
X-Gm-Message-State: AOJu0YzzvM9uE6rqysOEnRbm7VdmPocLypN6GUjNNRezfVmPUILQt4ve
	/jnp9+Zp9zNJt3TM0kxWtXmgvMdGb6mFxKtEJcvPnPAjD8+eq+sU8VSxCkhoaVMkAu8=
X-Gm-Gg: ASbGncvY4gYCzVFfhZycgNnLdZ6tf6tvV2AsYw0eiNCKIfXeXLZuJR6ok7m3DYv5mG/
	j7pr1uKR5DhkeiD+aJnaj8EQtxDY4GIMPYuwn++mnBttrd4m7u0sEO8b8SE2fwfRhfOqNWgNu4z
	tfUP1gDmfFLB6GHc55gOCsqJuRdnjCDoBhLZdTYTF+1zF5k3bdQ1+gCIJtNan7PjB9z3nLZgNkc
	jeh/ZvtaUkf/AhJXk1TJaSu39JLApTvJ+quZMvEz5vjTRedyb37fN7MTiKN4AmkYQIuead4rXOC
	tS6cRibM9jA7znB9dqVFnIlSE/fZATpIlTUNU1OkLCVmIsCr8WIOVI5kc2qTtLPPaszl9is68En
	V9XRgaW7nwYD/B1/0vlpOgnMDeOd1jJKMVTU7DxX/GhfQMknvMqSV1cjkrQ==
X-Google-Smtp-Source: AGHT+IGQm2BwTZf4DiWqvF+5ZIqZW3gwljLzK2HSeWpzsuqCCgPkWpl1dn6miiJgWhzknn4pwOCtSg==
X-Received: by 2002:a17:903:17cf:b0:264:567b:dd92 with SMTP id d9443c01a7336-269ba55253fmr48189625ad.52.1758287218434;
        Fri, 19 Sep 2025 06:06:58 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:58 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 8/8] mshare: selftests: Add test case to demostrate that mshare partly supports THP
Date: Fri, 19 Sep 2025 21:06:20 +0800
Message-Id: <20250919130620.56518-8-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, mshare doesn't support madvise(MADV_HUGEPAGE) to make pages
become THP page.

Thus we need to set /sys/kernel/mm/transparent_hugepage/shmem_enabled
to 'always', enabling mshare to acquire THP pages in a best effort way.

This case is quit simple that set up a mshare memory with 2MB size,
than use memset to fill the physical memory and verify whether THP
was allocated by reading memory.stat.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/memory.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
index 4bb0d22b9c03..5132210b1465 100644
--- a/tools/testing/selftests/mshare/memory.c
+++ b/tools/testing/selftests/mshare/memory.c
@@ -68,4 +68,22 @@ TEST_F(memory, swap)
 	ASSERT_GT(swap_size, MB(2) * 9 / 10);
 }
 
+TEST_F(memory, thp)
+{
+	/* fill physical memory */
+	memset(self->addr, 0x01, MB(2));
+
+	size_t huge = read_huge_from_cgroup(self->cgroup);
+
+	/*
+	 * mshare only allocate in the best effort way, and
+	 * don't support madvise(MADV_HUGEPAGE) to change pages
+	 * into THP or khuged to replace pages with THP.
+	 */
+	ksft_print_msg("Tip: Please enable transparent hugepages for shmem before running this test.\n"
+			"For example: echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled\n");
+
+	ASSERT_GE(huge, MB(2));
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


