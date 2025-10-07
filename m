Return-Path: <linux-kernel+bounces-844232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A7BC159D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D073B042B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EE42DD5EB;
	Tue,  7 Oct 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqyI/UpF"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3162D94B8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839644; cv=none; b=Cqrv7EIem/UvIRh4RSp85DGFzF0CVKbl5jRdQHbzGr2ZSd1aaOzD111P29bUah24sHnwcd9koCAOxP86BSuomGbE8oA8NT/dvWM9cxLRVlbdfjPvdhA2Owe+cREexwQx/h5noWdD0sh2yRRLhoyy0rv4BG7RSa58jmnADplxzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839644; c=relaxed/simple;
	bh=997qQQu2kGJpN3V77byc+mN3wx8H8MkzOoZfy80SWDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKFIoRJM6MDL2HdAkCQV+rvGY9aeQOKmfYHvVzUe+QLiqJWS1EqyhXfLO0O+xwDMidoKWe/+z5PvB6OIt7g6flqxh0nKHATU6lpz25anI8lhQYMoUdIULHnvwiDJyPcB3ho0PcpPtFSGvaCZLTjK5AG/hCa0nJQmA7ylPZ9OtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqyI/UpF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso7635516e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839640; x=1760444440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fNdEfsbjEkSdVOKy7pPxlOS+w8ubFh5YKBkVpFvsGU=;
        b=AqyI/UpFesJp4yNQJoqI67p2tNT7r2wL9FdV4wDRq50PgI5oFrLAHahfs9Cp0yACfc
         AmWa383J1e8u0ayfrCsw/ipp2IibzR6Fnt6GM28tn37b1i3qBrLwjS1mVmM6DZOcbzDf
         sQCT3BxeuUwFtKv7zPJv3GoofwnZEV826pL/N63C2b7ZBC/eRq6d4Xr7CD00xYFyqs1N
         F95TaB38+fzaG5nADBNvz/cR5y5dPGhHpc4id2WtZA9L4aJfUczrw6wABbzZ6FBAj0lB
         NL18PYsKK+K3CAGzs/FkRZOPl7PDROhO5UEhOQD5k0ckclaoT1Zv87jke/waLdV025Q0
         nydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839640; x=1760444440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fNdEfsbjEkSdVOKy7pPxlOS+w8ubFh5YKBkVpFvsGU=;
        b=nFOknFeMclA8OlmSfl9psydQKWnQkqjzwKztIJEZxgQCgMkwGcqnyjNXf8UbfZLrkK
         LLfBm6ebqbE0CbqXwx9li9oXKH1VhzJmGyFjZG5ho4EpNZOy7WYrzD27wvCCIGjle34a
         0KE7kORoI7qbKcK+QWtWcEj8BbqjwJRJMgDpgxJRAwy//GxYuazPWYhT7IlByBbBroMG
         pRtN/1pMXfiHfPdl+im4RYBR18bxgXdI3zZJst2Lstt3IRs+Qk5K6FYEF3RQ4oEY6KZS
         X+rhCeMjSo+KxG1F0IniYeRNeqJ9fL7ia6GA0E69gUpjazR91+v43glWJc6tkOZu6mxz
         09Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXnTAfus2zBEQawWrO9p7klclHziy6Qi17l2MDRWO6WaCu+sBo9Dk9UGV1xgmpjT5eBvNXCI4rATqNzqHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJOnh1/BMPOnIv1gDbBc+djdCFSf6XXhVWKtBNxzU+Dr/HkGFm
	uokvI8c93gIsqEGOL7fe/fcBfEaDs/5qhOvv64vgUPtM3gx1uEFJaECN
X-Gm-Gg: ASbGncs6uZopOFK7yNhGb8LRNNfUvIUsDQ0vTijsa28Fjxm9b56JXavdS5GTE1w8Sf+
	oW8NAe3toEFIeNebqGsSD4mElcbYUVF8pdIikk/az+UJnhl8TvddAFguSm5OIbqCTmGCeofeeRt
	+8uFZnoaJRBYjYgWww9YIHwnXemsJg4447UwhwXM9zzHEKwLppOLg2nhIucCpTRlw5amPNCbyBB
	wC9imxITmY26EaSXOpuF221DbeSCx5XRAWf0Arr2ZOH3/O69k93l5R3YdU7L0p8/R8bgE1pwiD7
	zXZls6wkOxPGd7Xjfwhrb6aDqe5h5/TsGwqJAVG7JSVK6P81Mz2PwZIET5Zpd4g80ldk7Og/dVM
	KJha4TPOGkhPSQnvSRYanghe1ajsjqNyVeeSPyd3i
X-Google-Smtp-Source: AGHT+IEiEq8/PRMLU22U8tMd2sr9kO2YecTFI/gyGlkW1+LEry1NgULscngcTZ0ZEHQCDOWqZ/Rlig==
X-Received: by 2002:a05:6512:23aa:b0:587:7f2d:2577 with SMTP id 2adb3069b0e04-58cbc39a817mr5138049e87.43.1759839640112;
        Tue, 07 Oct 2025 05:20:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:39 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v4 01/10] lib/test_vmalloc: add no_block_alloc_test case
Date: Tue,  7 Oct 2025 14:20:26 +0200
Message-ID: <20251007122035.56347-2-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new test case "no_block_alloc_test" that verifies
non-blocking allocations using __vmalloc() with GFP_ATOMIC and
GFP_NOWAIT flags.

It is recommended to build kernel with CONFIG_DEBUG_ATOMIC_SLEEP
enabled to help catch "sleeping while atomic" issues. This test
ensures that memory allocation logic under atomic constraints
does not inadvertently sleep.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 2815658ccc37..aae5f4910aff 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -54,6 +54,7 @@ __param(int, run_test_mask, 7,
 		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
 		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
 		"\t\tid: 1024, name: vm_map_ram_test\n"
+		"\t\tid: 2048, name: no_block_alloc_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -283,6 +284,30 @@ static int fix_size_alloc_test(void)
 	return 0;
 }
 
+static int no_block_alloc_test(void)
+{
+	void *ptr;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		bool use_atomic = !!(get_random_u8() % 2);
+		gfp_t gfp = use_atomic ? GFP_ATOMIC : GFP_NOWAIT;
+		unsigned long size = (nr_pages > 0 ? nr_pages : 1) * PAGE_SIZE;
+
+		preempt_disable();
+		ptr = __vmalloc(size, gfp);
+		preempt_enable();
+
+		if (!ptr)
+			return -1;
+
+		*((__u8 *)ptr) = 0;
+		vfree(ptr);
+	}
+
+	return 0;
+}
+
 static int
 pcpu_alloc_test(void)
 {
@@ -411,6 +436,7 @@ static struct test_case_desc test_case_array[] = {
 	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test, },
 	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test, },
 	{ "vm_map_ram_test", vm_map_ram_test, },
+	{ "no_block_alloc_test", no_block_alloc_test, true },
 	/* Add a new test case here. */
 };
 
-- 
2.47.3


