Return-Path: <linux-kernel+bounces-785035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6FB344F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202115E3143
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1E3043D3;
	Mon, 25 Aug 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QGsFtqFh"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902D303CAD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133913; cv=none; b=GzbpG7f8GJ54Pj2naGrHQc4Xz30BMV0M2rtak+/clgos/suV3ACRoU8oKt4OZOF6Zvuo32OK9N1y5mNo6O/Ez91xw59OtWlGwTrPQTdd2KAjrRe+yvGCMf9APoGrzVKQElmKe/IAXDuEcEoZsB77lC6eUG32MGiAr516MZJ5AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133913; c=relaxed/simple;
	bh=Uo8Uq5CGd42i/IUZX2QiGqJ9jwcLrhXXcAVNfr2ZqI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/OyhPAdOdf8n7bxgzASWCm0ZQDnYmXWzos3jX58chLHUAx0+XN2TvKsBhLGXAG6dvy2/5SjqVkg4tipCpW+bLAUD9G6Oi58s+l6GQi4oDrKfSdQgxE6JCuGYsHO1oijqGShTjzj+9O8g3/84exLDGpFN3L8PwZb5UrSvzepGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QGsFtqFh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7704799d798so1233632b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133911; x=1756738711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=QGsFtqFhAsWiT5DHzRrcZIkFseotRWf0ZyUGuG1gpt/scQNOJ+LDowbCSjIYiL7lvD
         ZVgQOwQBKqUcJ5sZRALrxQTSjMuZzrLaZQ08wElEmd6BulKiYlPXP9WiKFhw3ZiAus8v
         7j+vLjeuuckQYq2/oBkC9N5vPR5jNVmuLw4GxDJDSVPQ84AcBaUngr73nzaTo2Hq64Od
         8+hpxSGuT/qzEnkGCDBy5zhH8XGFWoZ7oy60E6BomNQiYca0bpGKiv+5Ouq45LljLJ+j
         0iIBGNy2voplCvJrZbROQsAP9jAE2Za9ppwmGVAY6b44VjLxn5zXq1gQQXbPQAOOMgC2
         8RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133911; x=1756738711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=M0BEw1ItxzBh8F6lfQjwpumXFbVLQwEpXJcERwT3BY1U1ICAL/Hj309zGSLH85oB03
         Ci5WMr9VXnKSVu/K4ybBCgXwaN4M1ng7g7kXd4bGdPvUPQBkuKrM3Daw79w5v3wUI3FL
         WyakK4g9LzrNP6MwGRc0xclAViGJ2OJKNV6BH6Sj7oxlcf3fvmVme+e1PSj+vBwfNLdr
         bw1Ox4Aqc0A7hjqMMZR3/IUs8s8B73eU2Vww+uqWFxc6MDxagmx4aPCSsUDZFHcmcUgo
         KNBNbqpgcPNNstcy3zIPQXjq/DdIbM30hLZtGNWakH+FVzUfKClTWLrwDsTXpnnGypbp
         P7vA==
X-Gm-Message-State: AOJu0YyNs2vDRRKC/ePFSLnGsjh8Yg3Q7fn10+c/Wzl15EDwY0lkbvWj
	rm/cBd/DDgCGOSJlG7jKErCfTmeOGXt2Z438c+zi9xbjfpkJeg0vKhmvM6pZ/r5HtpA=
X-Gm-Gg: ASbGncsk913td74WgrFidBP/eUS7vn619bZ8TUk/7VAR4kkcjMmBv+KNmuVSu71G06L
	w8rEDXbtmrJmd3tYaVwfbQy4c7Lv+p/B+hrSI4cF1z1ESrCueAZnyOVDv1wCaCm8xaZGGm6VrVp
	Ovn3BgbDX+MEe8wxnZGpCNIO9lUDzy/YaUh12K3tBFYpJPPbTMW/b8U5lTaE3rx9pSLaH0rQ+Fm
	bQNRbzTJDim72NjPGhtQ8z+bZwMmSdFmdF4j8GSoHBAyZcZmYKinL9eTcdaMCzx76NOKWJ1Shvc
	LRHZsSC0SR4DDZRQUgN8nbw+QkjGlp1eDGbGt91ULygslimTQE8ra2eaRuL/KRmrHWeYd5QjYh8
	MP6nUlk+ndiUQBXCGibQqxuD+pMWU+Jyux3I1jWH5cFhK91Z0mAxoDsiIZniu
X-Google-Smtp-Source: AGHT+IFUi1/2GefYrlbJCoIFczVXEJy1x3XUrow95S+g3t2wLpPX4iH95FuGRMW+srrK0U8C6BeQcg==
X-Received: by 2002:a05:6a00:10d1:b0:76e:7aee:35f2 with SMTP id d2e1a72fcca58-7702fc15031mr13371786b3a.30.1756133911092;
        Mon, 25 Aug 2025 07:58:31 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:30 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] mshare: selftests: Add test case to demostrate that mshare doesn't support THP
Date: Mon, 25 Aug 2025 22:57:19 +0800
Message-Id: <20250825145719.29455-17-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This case is quit simple by using madvise(MADV_HUGEPAGE), but for verifying
the size of THP memory, we need to setup the memcg and attach test
process to this memcg before perform the test.

Because mshare doesn't support THP feature, the size of THP memory should
be 0 even though we use madivse.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
index 7754c0e33506..2a415ce7bc01 100644
--- a/tools/testing/selftests/mshare/memory.c
+++ b/tools/testing/selftests/mshare/memory.c
@@ -68,4 +68,15 @@ TEST_F(memory, swap)
 	ASSERT_GT(swap_size, GB(1) * 9 / 10);
 }
 
+TEST_F(memory, thp)
+{
+	ASSERT_NE(madvise(self->addr, self->allocate_size, MADV_HUGEPAGE), -1);
+	/* touch 1G */
+	memset(self->addr, 0x01, GB(1));
+
+	size_t huge = read_huge_from_cgroup(self->cgroup);
+	/* mshare don't support THP now */
+	ASSERT_EQ(huge, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


