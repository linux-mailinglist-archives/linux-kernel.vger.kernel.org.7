Return-Path: <linux-kernel+bounces-797155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD48B40CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1552D1B63990
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA972308F1A;
	Tue,  2 Sep 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMmmN/hS"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F33594B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835977; cv=none; b=EmlUeSAVeyzT4bwrNySUfoWVtflD6OeGIQnkEVcoQ90HmTU0rGR9uwaGMq280umRyzLa2NJu5o3JxBeZvz0ZF8EzNNd5OXvfcsyLarHvOH8zPn86ffAWNMLt+4yi5sUOrPO0uoDtMXgdO+qoqzjBuMhK/6RcjVz3VvomEA/SYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835977; c=relaxed/simple;
	bh=ff8WKSKB1O9TVRrfMWl0CREYtluWZ/Sl+GMmIX8c1zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V21LYSEgcAWXDQd11NnotaVcVGDF3/CguQBKc8GjyZc5f3hMEI5yrPrvElMP7U74+ZHts3KEG9+Sge1l7TUW0gufAy4VKgl5vB+8LH8GRRS2fJ8MD6ExdkjlN2Ss1mw5bRwydYBuBnP5NnvF/yU4DiU6Kyh6+Pj5Jtm4hA5brhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMmmN/hS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso3741524a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756835974; x=1757440774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAH4RbURzzHRpIvpNMqt11PG9TMIAwCZWf6ncjCc04w=;
        b=BMmmN/hSbAD5c5B6eYb8tXHEZwx9VSEjpbJ9AIqrq1VD22Akp30PW8ASr5PQXKDA3B
         4JKE1bCYMqQVSVAAPQdXI5e0xhXE6AtTecxf2Gudj5dImOMBNmkBoN0Tk3D3FUViDE/e
         DtWRQW4Z8secA0dlYEDxR+nu5IpRrl4YwmA5Pepo49kGGE/5ymcuBnVcdZ0JKbYU7wlt
         Mob/hyyUC4C6/1ecQesnXQygZXss43tInU4HsKcn3jzzw0AkleR9FU8OoZ5FSGQ5LWge
         WBtZITt8bVd9fVVN2CsI163i2DDrDIXajecYgRSQTOmeyr8hgFzjfFYBxojCxi88EVoC
         koLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835974; x=1757440774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAH4RbURzzHRpIvpNMqt11PG9TMIAwCZWf6ncjCc04w=;
        b=jSeM4n80eLZiFArRIqI5iFTyN8rJ/+cLoUnjOWRC3OGGmOqguIYJPdlaiyBBuoV/ju
         IIV5B27GIek3zPaE3qrwlui5RR5LcwRMtdzNNI76EV9eHbBOkWC002i2gTCwR3C6koIY
         +Ol6Nbyk4PsBgNL7yhrlybfobJZXaUNFuCZwz9REoKz7b3iv5DCGGUlnc07CYa6YmNSy
         4zaD9EnRo3rxzeEE/DNL//nVlzNGsYx9NStk2hKgQVYZ0Dbxm4rGyPDTbMBPkc7K8nyv
         s+M9pWwwGy4mu+YH4otBd98mFSpyooZTefaIOr1uoJxLKQ5EqwLYzQc72nNHqDjNXopN
         hQ4g==
X-Gm-Message-State: AOJu0YwFiHPlok3NLi7G01vXsX1RUiMSwPajDIzXXYi0BcloMzqSA0zm
	wZNk+XfTLAYeKPX2yVdUbT1sL9gcxNYK6je/JS2NXqIhJAj0OA6y7f51L0vpAA==
X-Gm-Gg: ASbGncu+AwgBZVNj84m8gHE3gx7z+6/S0C+X7yxKrowteqY91+9olZdPUPkTaLkP/YS
	qhTHGLoa1J6Om3SBLlmedPSf47+RegFOVeq+rFXn72hoP0fltzj2szItk7S0xu4Q1sPkmV62Ak1
	zvK6z9LwlSJKLJaBbrRZHiFKeLxqgCMYZZbrZohCqwp32hBn7tUjXQnWI9xwEqZ7UO549nMC1kJ
	XXmE51LgzcXFwC3PNl0CFU4ELHRBDj2ojZ0jSOeVY1lTxiEfljUoFWG3lVGvhkKUJIseH5BJElJ
	6qnq3D/HTmZMmyKPzdwo/7yTTyUByAFhQZYr3QBMySr7s9whTN7+CG1MXlzd0eIxBWPLsXaTWJQ
	j0CXzadLoLEb3a8kmWyHS52yXNaJP6gE0mJp/MSTnw4XqbEFM+qSdBgoWWjlBYmwf
X-Google-Smtp-Source: AGHT+IE69QSW4qvs9ks5N2BD/7L6YYxrDKxFR+dkOnLAl+rVNC07mTwlZHlby7K2v2qk1lnap3nZ0A==
X-Received: by 2002:a17:903:2412:b0:249:c2ee:af2a with SMTP id d9443c01a7336-249c2eeb25fmr158523805ad.11.1756835974450;
        Tue, 02 Sep 2025 10:59:34 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24a92f89809sm98463435ad.2.2025.09.02.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:59:33 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] mm: Fix kernel stack tagging for certain configs
Date: Tue,  2 Sep 2025 10:59:03 -0700
Message-ID: <20250902175903.1124555-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4ef905bda61f ("mm: tag kernel stack pages") began marking pages
that were being used for the kernel stack.

There are 3 cases where kernel pages are allocated for kernel stacks:
CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
respectively.

In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
than 0, and pages are tagged as expected. In the third case,
THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
This meant that in those configs, the stack tagging was a no-op, and led
to smatch build warnings.

We definitely have at least 1 page we want tagged at this point, so fix
it by using a do {} while loop instead of a for loop.

Fixes: 4ef905bda61f ("mm: tag kernel stack pages")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202508300929.TrRovUMu-lkp@intel.com/
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 kernel/fork.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1b394426ab4a..9b13cb83e1c6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -448,14 +448,15 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	} else {
 		void *stack = task_stack_page(tsk);
 		struct page *page = virt_to_head_page(stack);
-		int i;
+		int i = 0;
 
 		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++, page++)
-			__SetPageStack(page);
+		do {
+			__SetPageStack(page++);
+		} while (++i < THREAD_SIZE / PAGE_SIZE);
 	}
 }
 
@@ -474,10 +475,11 @@ void exit_task_stack_account(struct task_struct *tsk)
 		}
 	} else {
 		struct page *page = virt_to_head_page(task_stack_page(tsk));
-		int i;
+		int i = 0;
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++, page++)
-			__ClearPageStack(page);
+		do {
+			__ClearPageStack(page++);
+		} while (++i < THREAD_SIZE / PAGE_SIZE);
 	}
 }
 
-- 
2.51.0


