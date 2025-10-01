Return-Path: <linux-kernel+bounces-839419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD4BB1968
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76227ADEAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F172D8781;
	Wed,  1 Oct 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTEzvWte"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2602D47EA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346813; cv=none; b=jnehhXaRn17kCQFWG6sPAnnIM5KdXdzzjAFIBYWXQtfHn1JSOcOJofaXRlYY982eh06fZhSEtMnE5Zfi/UPygMACPbtjpRLhuoiEyidcGs/TywGw49ovuK5gKpx/jcr5u0QqzOGTW/eClk0qQdVAqd/zTHcJJipC50RoQ5hqB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346813; c=relaxed/simple;
	bh=997qQQu2kGJpN3V77byc+mN3wx8H8MkzOoZfy80SWDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEEwpx/yuUySUceTbZusrtt2skGhPoCa/mWrHAw6yyGVMuyGy/78HNQZAKJ0xXnQrty2wCJUO/4NleOnu9ERVhNvjBgH4xFoE+q4TV/Mc5DYr7X4V3i/6xKquBGjtADvmTiqDkHcA5DOmC9YN9Jbm5lKXO0SOD1zBZq1NcB9iIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTEzvWte; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57933d3e498so249590e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346810; x=1759951610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fNdEfsbjEkSdVOKy7pPxlOS+w8ubFh5YKBkVpFvsGU=;
        b=JTEzvWteaM7tBvdRvIFgjyNbPhb+bHtxxNa5i8J64HzpLdKMLHNxMWvM95AsQNJ/3c
         gCQi4l5QkxPixzTwxZne7Q6JxK3SCxmtUaaqb9JeKmM5bfdq6E+7t7d2DLLzLj+olHsJ
         DdjLx/5oAMQJ4zA+DWI6D5cyZq6IJBjySYKbURbO1uTbAu24JE2hBk+ZvjUGEa1wDBUD
         UODGol9BdUb6exOMQsdJD18VYHGhFyGBWTeamTIwYTlPBRXHFVBFcnUWKHQQPfoHKuC7
         ppKVbUziKvZ726JiEWEasV0aVyfa0hFsAuAiRZv1BJUW0J2AQcsdvQDCLicunZBnkfYD
         gL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346810; x=1759951610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fNdEfsbjEkSdVOKy7pPxlOS+w8ubFh5YKBkVpFvsGU=;
        b=UEiZlQeSmNnG6LjZy5HuesXJSdkN6HP71aADT0fu9vyFmJkG6DJgYEgCEseYXfWVEG
         apdd9IaBueWAtJ/DRtc4yZbOzQzwy6NiswFzn5MuUYdf1f5yr0yByXJPIGcqQJ0epgyE
         5zaVi0EvSoEcbnghOdIMrxQ0tZ4JBXbHxpRl+9lTibiSn25bb3IUCOI1+RcNvgWtAQi3
         X+N72QLZpXavPCuK0DudPNUjMFsGZ9nSTuYsuQNOHwAMccBGSv0PQXtgUgkYCAwY4yW3
         mNu/zqr3U4Ij6IBpaKhrfSn03G6P84BM5SgW4IMhQ4OyqCwwgHg6Q7UoC/ZPCYUMsjDa
         W6sg==
X-Forwarded-Encrypted: i=1; AJvYcCU3uSQdiIMSu0sDFfq7RUUmjBG1YBGIqof7ZWwz72Hnp3Wy8E2DmEsqmTE+P1q19BUkdRJ+PpYqHOgRBKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2zv2jVIgndwmXCnCuuQEQZSEiynh7as2Ck+iz4f5Vcb3Ae+1
	g1WbZnh51XijHxBH1Fe8O1OZjBxYBYV0Du3Ev43vtw6rsZKgBmlAZCBn
X-Gm-Gg: ASbGnctuADt3pbYiUg3kYEVJicWZCYGObh5LHgXMGUrV0fRDbVqXUwVVsC+rQMz0bdq
	KJKALhi2pr/xMMKnukDADl3PHmwj6+Qo39lMshTdJ+xhwsUkRYft3cyWqfdSlhUBHz0DQkrQUcx
	HDVN6qvyO3kQhkV/fKq6Zi6IT+xURgWZbxwoQ5XaHr4a7J6/Q85axfKA+9845MCt+377sTkIKT/
	vpUdEObNFAntpoIB7fYrzOnmUcTDEvJa2WT1ESorapJjmzbgutjQllqlsJNlg6eUXv5xKGc2iTO
	HOHkjCfFloejAJfZmp7VOnQ6RAsyBK3kB/6OXPo6LLVWZb/xhO+Y9ffVxlfyWk8T/QRvIk8SGJq
	xDZHlJlZ8D19vnHXOjLMZe0VtdFIISkTvGKJXIqY1
X-Google-Smtp-Source: AGHT+IEfEWBm8M6AzhkYd4fot4+nTsgt3Zq6rjXCLPpDwAaNb3Xiqdqgs47Zz3Hyyexv8rR1mHCSLw==
X-Received: by 2002:a05:6512:10c4:b0:577:285f:32bd with SMTP id 2adb3069b0e04-58af9f6739cmr1140787e87.26.1759346810036;
        Wed, 01 Oct 2025 12:26:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:49 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v3 01/10] lib/test_vmalloc: add no_block_alloc_test case
Date: Wed,  1 Oct 2025 21:26:37 +0200
Message-ID: <20251001192647.195204-2-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
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


