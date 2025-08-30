Return-Path: <linux-kernel+bounces-792690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1616B3C7A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF3A5A1031
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231A267B89;
	Sat, 30 Aug 2025 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G02sQrDi"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB3191F6A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756525675; cv=none; b=gxLfT82Id17Yb7pFvoy6p1jopK0opym3NeyDazSwU3edVgbaX5Yv3qfo6iAfVJVaYD+KQlwH3fOjU+FLbYS6D/8rX8jc9asJsYaWuRZJroQevkttWHrhf3aMGXBmlB67q3eEAF6o5IxxAgWlFfBjO21m4lDiQdRLYlXBlOYd7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756525675; c=relaxed/simple;
	bh=a+5VQ+kTp83MOGO/ooZ5We8LXpS9XV5nxKS64KCRtv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3FRrwLWFvrlJt7Q/J+HvGb4fOKyXYoqttcNKvDkJliovCehE2cxunaJ5EhDvd4T0daSuI889cQ2bgpsdFh6U8q5FcuzNcwwLCX5ZsdIfQoyxlQOuPZR9BDu5nVHWdVhDPEroSx/o60FXBrjXUWQbdvKlBQ2cLYnCuvuFHoTunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G02sQrDi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so219309b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756525673; x=1757130473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2/fTYqyaBTbwpgo0An7jaT7XL2U1DhZhZo81MDgLHY=;
        b=G02sQrDiH4SgPOnnUXppvm7wul9lV5o8U1UBrfu4jEFQZTV3Sr/HzoN33tyye2ZiM1
         LzKcN9EeWTvNkSiOHlqLbgFJTMTzLDux3I7WwqDYckdJRxexD5ZEHbu8RPG14P8+iiu7
         Fq9IiU/ahUPxeAXtcfTRagbS+4VnksNVFHXKn1x8u6pVNZCOGBQVDXPMdG1BJ5gNIEM6
         2/1JRt9KBjJqh/Y4nAK/UnFd9yj3Em4nUDS+LeidlaVC6zfmnji4KsE5sxlaFIbTcOgM
         +rwcaS/1k4QIHT3JUQHLO/VJuvU14PfCudmLcEfXem25n6U4Lj5TSltcikOhpOHKoOK/
         mjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756525673; x=1757130473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2/fTYqyaBTbwpgo0An7jaT7XL2U1DhZhZo81MDgLHY=;
        b=N9/ezz/F5RS+t1qi4EYpQNdUhNv3Z6KMhwQUhGwLR92xEzpep2xHFBAA29bPFGmTVt
         JzWtMMiBeWa3kxfoGc2AgtVblubT+jmQLlNZBoeUBhKqfx/zAZYg8XecpcrqWw2ERTaD
         cTMIy43nPrbYiVf7ntrtkgU39Q6MzLtpMFvZhrZ21xeltyPIyv6xLyz4AHKa6GLf44cG
         1QDEok3zaD6wvCP8BaTzkX9zaYCzlqH31IB4ZeBA8SJo35Uvi2HAK/YQtxmUpE75fbEg
         jAh6uRYEl1I6NFSc9HDUAokI1h9M58IAIKV5598RvJu55rok9144CCCUkln0gbtkHmxU
         WXHw==
X-Gm-Message-State: AOJu0YwO7lkSNFh3BqpPHLLo6T19OW1Iq/KsmbHfjuXn98CU5km+phK6
	U/FYNgYH0zuli3HL1sIrLNX4NDceFdEpAGbgVcLqOzO8DIHphbrMyOEF
X-Gm-Gg: ASbGnctXBDddKe7NNkFuyAgNT2TNRwmb6Gmfz5BPH6ZXzU9UUvJyL4MeDXiOBLvAIU8
	HGNsBPLzBQlNMjWlbKRdBdf6a/NSTHr+dOS20SZVmquRbsr70CpNO06+qa+yIafgyg4Y4ELKhVR
	aNMhAmOU0QwXFR3YlzrP5PcTCBFbLlZsOg56sDkVhVnf6WegjF2XUt5DsENeO0Aff1VJ7YE59rA
	Ty4VjRmytiBm0VaWMMRMh/2tAWhCJ5enVXpPT2PvSY7qLfCUnQACQcUQ/UayoOA171D2eNDjnSC
	ZcDgYJCZhbT8AFZYUQMxeNsrh0LylujsdwQbHEdKb1Yj4E0z8zg3xWRGJyttbeFdllqxYIYljYe
	lwdYbXTnBlr7QRurWmsj3J00ArQ==
X-Google-Smtp-Source: AGHT+IEMUOTTpvLMbolO+IXe1S6PRSxHMgqxOU9soR4dq9x7m5tSAn/EQ70/OQyCkognPBo3oY67LQ==
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr1114145b3a.4.1756525673320;
        Fri, 29 Aug 2025 20:47:53 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4ba1d8sm3895377b3a.51.2025.08.29.20.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 20:47:52 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 01/02] scripts/gdb/cpus: Add support for get_current_task for powerpc book3s64
Date: Sat, 30 Aug 2025 09:15:34 +0530
Message-ID: <cc4af3fa0fcda2a52cbbab05463e0ad0561fd017.1756521755.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support to query p $lx_current() for ppc64 book3s64.
This allows us to utilize gdb scripts functions like:

function lx_current
function lx_task_by_pid
function lx_thread_info
function lx_thread_info_by_pid

e.g.
(gdb) p $lx_current()->comm
$1 = "swapper\000\000\000\000\000\000\000\00

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 scripts/gdb/linux/constants.py.in |  1 +
 scripts/gdb/linux/cpus.py         | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index c3886739a028..154db10fe94a 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -152,6 +152,7 @@ if IS_BUILTIN(CONFIG_ARM64):
     LX_VALUE(CONFIG_ARM64_VA_BITS)
     LX_VALUE(CONFIG_PAGE_SHIFT)
     LX_VALUE(CONFIG_ARCH_FORCE_MAX_ORDER)
+LX_CONFIG(CONFIG_PPC_BOOK3S_64)
 LX_CONFIG(CONFIG_SPARSEMEM)
 LX_CONFIG(CONFIG_SPARSEMEM_EXTREME)
 LX_CONFIG(CONFIG_SPARSEMEM_VMEMMAP)
diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 6edf4ef61636..c250de14ac19 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -13,7 +13,7 @@

 import gdb

-from linux import tasks, utils
+from linux import tasks, utils, constants


 task_type = utils.CachedType("struct task_struct")
@@ -207,6 +207,21 @@ def get_current_task(cpu):
             current_task = scratch_reg.cast(task_ptr_type)

         return current_task.dereference()
+    elif utils.is_target_arch("powerpc"):
+        if not constants.LX_CONFIG_PPC_BOOK3S_64:
+            raise gdb.GdbError('For now only supported for BOOK3S_64')
+
+        msr = gdb.parse_and_eval("(unsigned long)$msr")
+        # PR (Problem State) should be 0 for kernel mode
+        in_kernel = msr & (0x1 << 14) == 0
+        if in_kernel:
+            paca_ptr_type = gdb.lookup_type("struct paca_struct").pointer()
+            paca_ptr = gdb.parse_and_eval("$r13")
+            paca = paca_ptr.cast(paca_ptr_type).dereference()
+            return paca["__current"].cast(task_ptr_type).dereference()
+        else:
+            raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
+                               "while running in userspace (Problem State)")
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
--
2.50.1


