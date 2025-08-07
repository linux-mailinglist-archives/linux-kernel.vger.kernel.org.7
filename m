Return-Path: <linux-kernel+bounces-758785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F37B1D3D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6301727C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7D244697;
	Thu,  7 Aug 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMRD30gg"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74D245000
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553498; cv=none; b=o9mvpKjFp+XwDnDjQZtJ/bXnBUMxniAKUpd+3OzTxcVx+CSN+/p6IbLgPLAEVCZTGEMeAI2dsIzY4lDkVM0y2GJ+SioPwojx6VxuNTx04SdkOmWMdIe/5qDjEaEtz2FmTpm2dqLvLRkZSEykaeQJp4Uzad4ICbSWkX6kI2ts4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553498; c=relaxed/simple;
	bh=uTR9bDHZ1Hd2G4zg1rYnqjGriz9dTts/Y6edsR9kBAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8biNjJTeRfUTWpAZ9qCUQhbz2nZIVF/JAFZVtkI3eCKl4XjKOSLX1+tDQjC+GvVeCDrgwiV9rmuHraq+lhPi1hKlshaVB69INFeOPHM4p0IUm8K0vw1W+Sjmnppdxbr3CgJWRSvTlqcKiqbyLMAwdIjxalL2w8i+tCf7OE3EuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMRD30gg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b975b459aso644966e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553494; x=1755158294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h92qlRGpNpOttoa5peB/v55STRwn9jHtqjasT4/y+5w=;
        b=EMRD30ggib9gc4PD5NUMjHSKNBulkb4W53ZDImnVgNSQdlUnyQb8x8nXyLhNeQ8nco
         bwCacs5HoQBxvKCn8P9VGeeYMNWSiKkdqCQkjW+skRfGW1FSDx/E676C+I8qIjJ0M1sk
         euJ1zU5rqfH/TDgzkSp+NdvznGmavtsPAAGqS1tejR+QuVTe5zYM9pKv/QtLnFwrSy0C
         qCVmUWfSew7R5Sb6wuBUZFx+mBNdtTcRQPLjXa3YMcXflYOHtTyBCGGpsbYvKYyJu1em
         /rb7bwt5ETd0z1aqYS6eE/A2kovQ/5dqB4OTpRBhMAZHW0Yk6Ixytuu8Pi4hpYAWOSTM
         K8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553494; x=1755158294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h92qlRGpNpOttoa5peB/v55STRwn9jHtqjasT4/y+5w=;
        b=uh8Yw2rSHB3PEf1FDA3AWjkcLYk4Pt3V3D27p9wKqoexZdVFIfZeeg5I+mbI8ar3g6
         jJifHa3h1/aPAOovZJxUvjQAeefW7k2xyqjLgjuDTayCHQGbaqHdjg616WGBmUR5umMN
         e9YbqtSZEOymm8lavrRRODzoTgVgfkP0K2Kpl4Hb3beF/zCqmdjGaTBFNqw17wSaXK3G
         ybP1ZcPn6S2SdxRpGxf3qj/QZu92SObFYHaWv5/1tAxdMPrw0eXGo1BALgqejRBfKkWh
         WtldHfylfhRzj6tBdgrYX9NExiAZ9m9WPJWWVvfhOuSEqrp6oKTv/vWhNsV2sJ+CSJiG
         Q68g==
X-Forwarded-Encrypted: i=1; AJvYcCVhTztOiqwvK+ibcwjBFbYV2IK006sL2WVRvSOASmnzaHDKOyR2BAlq/MK4Mt+PNiTy89dJ/CbrrooKhNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp07fbXgJUINBzf4Bv++5VyIK+t8iRYOyOCDkwjNX5VvfmVAs6
	b75XIhQldV7/Nc2DdBMg/DZZNTXo/dcgVqXvr1DGmH67wRaPlrggtNVz
X-Gm-Gg: ASbGncv8DsgS0mvw3T6QkwE+fmhUIe+zSVjRh8I+6p3l56B06cLI6AMf9CFjsvTXkCa
	P8ZIPf+uq1Xzse8OZLJi88J2iavgJbP3/T0i2cOLA+yeyg05H62HBiLEwPQ3QQRKjRMSdn664cE
	IfnHAGPtalV0wXGcWvG84MrLxOhmXE2fyAe/nP03qo7mNlggmu47DzpXpVHr3P+368bPKtsn4z1
	6LALsBaG6Gd3dXYaiDJO9mlEPhjrW6lIEtMhUEVf6g6z7VNmX4yllslnzKkQIyTDCnbVoyEi/XW
	TYtOoS+rFg0lK506uBZcd3BojyzPUs+q2gBVHzOwy67vEv397MImcUUB7EWo4RGHgXTDfPsNv0u
	mdPIkm7USGC3p1U4/hA==
X-Google-Smtp-Source: AGHT+IFA0xGtyd8TAvISAHbUul+I0DeGj6jXQhulf4UCTriFlDW6HXVuVy6Cp/dIwNbD/wOAFCuoYg==
X-Received: by 2002:a05:6512:3e08:b0:55b:7345:8386 with SMTP id 2adb3069b0e04-55cb674cc53mr612797e87.17.1754553493585;
        Thu, 07 Aug 2025 00:58:13 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:13 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 1/8] lib/test_vmalloc: add no_block_alloc_test case
Date: Thu,  7 Aug 2025 09:58:03 +0200
Message-Id: <20250807075810.358714-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
References: <20250807075810.358714-1-urezki@gmail.com>
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
2.39.5


