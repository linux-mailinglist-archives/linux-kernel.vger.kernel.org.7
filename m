Return-Path: <linux-kernel+bounces-791129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17201B3B24F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD1216948D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1021E9905;
	Fri, 29 Aug 2025 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9HUcpm3"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13622CA52
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444409; cv=none; b=aGF0o1CCZH8A7TW2iKAWyJacFtEGmPDbVGC9UirXC/3duFSN5S5E0ggwc8lBNSlHjTHy0MEaFpnYBOwv/Pa9Ffizp+CNtpAbtf5U8SKYAx+1Q/Akc+N5L8WcLVPx1NoFko71TY7JqjkCM9L9FMxxIUQmbAwtYU6eKohbLVXo0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444409; c=relaxed/simple;
	bh=rO6rnsqZjWA3RF52gv3XcgwAmEGZO8f2uvwIuKKDfBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCBzyIkfY2LNgRuyCOkMERSWGuu2Kng6090Rv0q4DS6sEOdIH9/qeYq5hpnKjB/Nzf5QSR4RNUK1NYiONsI3WuyJEFpMIvef6PnVaQAM4kQ9b1PxgyCqOQNlI1yaZSAw5IS/DLLkScOyDzjVe+ukkP5YEyI/MlgmV9Xc6VFKigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9HUcpm3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49d3b48d8aso1154208a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756444407; x=1757049207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXFscyXVZO+o95fwx2W92cXlYphrwpyKb66RXu3hq9Y=;
        b=U9HUcpm3vfw8VO5z6cIdQeRRg/6bIWYBGq8rR+ZVS2yYo0tQiCu9OCZLbpA0XwA8ZA
         SPMtKkmgQpgjW99FPvKFLAd9l2B2yYzd3LGtmUL51JneEabLtT2lEHAHCYGPc8PFkizg
         GaUFNhKPVQUBFzs7oOeIZT9B651K66LkWTskOGvDTDDjcfqiDtX3QSXTuJAK5v2bM2U6
         TIvC96ZZeynfJ5l9buQcRu5002WagwjF/WjTT1+tHh19tqVJVyeYrizdP24yFTpprBL1
         zuwrW2rmilOeA7PzHBSGw3A69Q6HtDuYnU6NPH2RlvCAXTCkx2r0iyKPd5xVNPH1UycO
         WFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756444407; x=1757049207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXFscyXVZO+o95fwx2W92cXlYphrwpyKb66RXu3hq9Y=;
        b=C+q3DrbAfm4Dh8Aoic3NThkNGQjHCbjqBWheYii8xJIAj1qs/x8Gn5ET8M/yKgcvh3
         IrLj4rzUa9oIpW8DlLuq9pk0SM2hGjwA022CZ+K14mAmzipt6mcW8EY9l/VUaOES9aKM
         hiiLpeesmCwpd/dasH3snYZyevhYusdERbgKdAY2aGZbWXcizYKq0rSFVuOtEWXeaxJp
         EHgUzZj+LF/NfKQhg/nkIiVCLCAHX9rQqr54QlypgDX59h+YfbPgFlxAzQjoxXD3z/9d
         W/Uz9jdXLDjYr6JuowugJYGGZ79s6YCXn+4ZxJyUyJlgqfBfySE2tWA0N6k71NrG9UD1
         LNbA==
X-Gm-Message-State: AOJu0Yy1NM13F6XhUhvrMvWx/RkFENVmcV+VGhblh2Z7uE1FFKCB3C9a
	MMJeFUwGT170k435Pd2IsXwnf1ucIQyNTooOB2C7zWYYvTnm5MACGRdl
X-Gm-Gg: ASbGncsR1mq8eCCWzPvnEvigtQXa4+ks/NXzEBfOj4G0xHqnuMHxW688gIjJXkmK4B7
	VsuryppIe09T/PO8oGXgcjMwrfscEC+Abl7HQoVEc5MBpYqT/ORLEsHoZwJrDQZphUFLw3wBwQq
	CbHH1IubDYsefwqzOJjXcx9zvaXqh0h7S0jlYafA3ancc3fP7nY3keIf9HkeSWsFttfxc1sQxfR
	ah1soDfodRQvvUKB9NNgg6rONyzqyuzoU4inPSo7JZVogSrkudT8spJlY/WpDSslRrWAQiULWUN
	zwZrTBRzNV57JbkE9q6fJIhccbg5bODfAMs1SmWRvtH93kGzfNAN4rGQoQXf+dDhJbJF8JClI/5
	H3mPcCIKIoluyaIRO6qAH0dAYdfvqNbn1Qyn+A1sTTZE2fvMU+HEJmk4RQ2A2
X-Google-Smtp-Source: AGHT+IFhaLxIq01A8FU8eDpUIpw50v3rG0WsO3HpyWkyY1dTG4yOOm0PhjgmHQmMy7uxhY9q1PvLAQ==
X-Received: by 2002:a17:903:1249:b0:240:7247:f738 with SMTP id d9443c01a7336-2462edee76fmr355050665ad.1.1756444407248;
        Thu, 28 Aug 2025 22:13:27 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ade38sm1006073a12.34.2025.08.28.22.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:13:26 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Qianqiang Liu <qianqiang.liu@163.com>
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH] panic: use angle-bracket include for panic.h
Date: Fri, 29 Aug 2025 13:13:02 +0800
Message-ID: <20250829051312.33773-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace quoted includes of panic.h with `#include <linux/panic.h>` for
consistency across the kernel.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/crash_core.c    | 2 +-
 kernel/printk/nbcon.c  | 2 +-
 kernel/printk/printk.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index bb38bbaf3a26..a5e8523dd6eb 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
-#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/buildid.h>
@@ -23,6 +22,7 @@
 #include <linux/btf.h>
 #include <linux/objtool.h>
 #include <linux/delay.h>
+#include <linux/panic.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 171480135830..558ef3177976 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,7 +2,6 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
-#include "linux/panic.h"
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/console.h>
@@ -13,6 +12,7 @@
 #include <linux/irqflags.h>
 #include <linux/kthread.h>
 #include <linux/minmax.h>
+#include <linux/panic.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/slab.h>
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 236f03937107..5aee9ffb16b9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -17,7 +17,6 @@
  *	01Mar01 Andrew Morton
  */
 
-#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
@@ -49,6 +48,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/panic.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
-- 
2.43.0


