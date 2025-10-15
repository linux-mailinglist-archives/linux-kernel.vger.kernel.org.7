Return-Path: <linux-kernel+bounces-854639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F6BDEF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37FC3AA8D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2A1EDA03;
	Wed, 15 Oct 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwjaxyGJ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF62748F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537736; cv=none; b=XOLZJ15bwu0NpanRhwHxy7WmWMMOP+0BQv1I9Vtzh2Q2ITJuTyR4ulyRAC/CPoYkoOGSTGWxLNLdWHXqhBi9V0JI9GglsJFyXFq2lZqM+gHz7DAHIy3WJWK27KdihHWyccFDxsXoER63fkPh2sF/uTcKCtSygO+z0YcEiPK4x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537736; c=relaxed/simple;
	bh=2NH42ngz5BjrOXep0+T+NJ9fLWNf0+qyZb1AnIDUWaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mIvbl1uA5Niic3CG9sZGs7SuMhSS6qEhsg0+vtv/lXajYhH8hlWFRT7N9WlVTbVMlOgq36bjVUKFxBvS5OPMhToYOjnOIJtpnTkswH3zmwwyPynk/aaV1qPHcRrwJgoMSMHqRGHqgGbEkWX1fKoBmu5qc8UJX+gA4P/XIxH9PxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwjaxyGJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781db5068b8so5275536b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537734; x=1761142534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsBPhxeyDo7XubBbSOL5sXpSroAunmb7PEWnljn0cZg=;
        b=lwjaxyGJNAo4B/ZvOptaRcy9ejbCS7ZnbK7Wb7HisT/2u9VrWLqqg0vABafnX0idgC
         JyRjF5iafEq/w3Sp9Yx0McHm3QtBhUsQhtOghZobvxRckbSX8NJQ6z1xM9pX4d8wkdbl
         S9EfpPDBTgxORdG6X/0XrPOileyrDWNK51vqdGqT+dF66lm73UZeVdzI1Zujvseru3sk
         53G0FByg0lMGPYcEg2/FCmjfS877HTb90xjtFsTYCXTawnC4PiogNm1geJMsXZf2f4Az
         aIlEP2h2jrT4AJADauczWH6ZyLhk8g97KJx+P02o3lvb+FiqEsWhKj+b3eowVZQMmtQb
         uUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537734; x=1761142534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsBPhxeyDo7XubBbSOL5sXpSroAunmb7PEWnljn0cZg=;
        b=TZp5fC54Ie5VRmPRBMisXAoecDB5I9DwHH0pCfTWoUs58/YX4Qzs4SLuzTUzabY2Pp
         4gN8JxaB3emfnKBUqBvuzjLGKHYZfge6UJubpeA69tgi7Q5bkfgxI006Q78aGNTRndUI
         bJhdfHu4GUuyzG5RF+rvBYlE1bItcUbD+3rs4XWefPH5QA9Uu1wmjvFUr+1ms+SoBT7J
         ZvlXa/XcsHRbuwSlvZ+BfhjoEUFewzUh5doS5wFfoiE3DZJl2ED/InbByPc+gtyWuHOa
         J21XFomkUToED+lb1ZAUeDk9a4qJt71OyMvHijU6jAjS2jdEgQPXUhHFk7u2f/CcSbxL
         +dhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs+emlQI34T1wtT4L5NnviYfzJnEBZfZBEc5qfBik1JI4duYrW0vsMuq8hGEDr4rmEsYzH2zE8eCtAqjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhJ7psftt6A89KsG8kmGE4+lJXiA862Kw/eppRieM/OADkNEK
	8lvfX9yrz8T/kfRQ8OpqhqujHmgfLNYhIWEF3vx4VNaWytL0H8Dc0aNb
X-Gm-Gg: ASbGncssNuPy+6Wq2k/mmyIXm8DHjxuFzkQGS/auXR9NHtkJYaqRjaL0H/HY2gEcwr6
	yhDozitiK/XpI/bBIM1Cr7wiA1L1NhlturMgvWJr/yWozqEfZvlTjd2wdiho48OR/DeYAzhBWs0
	FlQ//1hylrepK9cyoIgjP0FysRtu/BSjpVAoAHqMjYBB8KaI/nJC9+39IptGyuaD0CaYKwGgT1Z
	ZVWb99YhnG+jJhntDizm7gIjCvex613hZnfTrk3vqZec6dGWDwJe/j5AM1XIe7qRvQ4UdBYCspI
	3zbX7P5gN/t0RaV75s4q5gvv6K1UXbQkyhgV+F0oiDFW6BznulJuL4cS8kN5Wz7ZyDjyZVMeg33
	IV8VIT6QCnFYs0RWHhaBvqHA6bt+TEcI8i8mM6ectWoHyAjAgrTR5vsHwAby3crEuoUL96mWfW0
	s9k0JiP5qwjVpzhp+VEtfu0E0RHuAjQjx8xyhNzINM3rq0PM0paMQbzaJFjPbb
X-Google-Smtp-Source: AGHT+IHDPZTz5uXFv1v6brQ0zwT6bPhuD1aOTwH/T80neFH6VufpAVd7st231F+cgFdFXYzM34i+JQ==
X-Received: by 2002:a05:6a21:6d9f:b0:252:2bfe:b65a with SMTP id adf61e73a8af0-32da80bbc79mr35587318637.7.1760537733666;
        Wed, 15 Oct 2025 07:15:33 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0606fesm19172051b3a.12.2025.10.15.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:15:33 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	athieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/1] rv: Fix the invalid address access when reading enabled_monitors
Date: Wed, 15 Oct 2025 22:14:45 +0800
Message-Id: <20251015141445.969-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When executing the following command (reproducible 100%), a kernel oops
occurs:

  # cat /sys/kernel/debug/tracing/rv/enabled_monitors

  [dmesg]
  BUG: unable to handle page fault for address: ffffffffffffffd0
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 3ddf828067 P4D 3ddf829067 PUD 3ddf82b067 PMD 0
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 479 UID: 0 PID: 15237 Comm: cat Kdump: loaded Not tainted 6.18.0-rc1 #25 PREEMPT(voluntary)
  Hardware name: Lenovo ThinkSystem SR645 V3 MB,Genoa,DDR5,Oahu,1U/SB27B31174, BIOS KAE139B-5.70 06/11/2025
  RIP: 0010:enabled_monitors_next+0x41/0x60
  Code: c0 66 a6 bb 75 24 eb 2d 66 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 44 00 00 48 8b 50 40 48 8d 42 c0 48 81 fa c0 66 a6 bb 74 0b <80> 78 10 00 74 e9 c3 cc cc cc cc 31 c0 c3 cc cc cc cc 66 66 2e 0f
  RSP: 0018:ff565a8b1e653d38 EFLAGS: 00010203
  RAX: ffffffffffffffc0 RBX: ff41e057260eabb8 RCX: 0000000000000001
  RDX: 0000000000000000 RSI: ffffffffbba66640 RDI: ff41e057260eabb8
  RBP: 0000000000000000 R08: ffffffffbb313406 R09: 0000000000000034
  R10: 0000000000000000 R11: 0000000000000004 R12: ff565a8b1e653dd0
  R13: ff565a8b1e653da8 R14: ffffffffbba66640 R15: 0000000000000000
  FS:  00007f8da78a4740(0000) GS:ff41e076cde6e000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffffffffd0 CR3: 00000001b6b26005 CR4: 0000000000f71ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   seq_read_iter+0x2ed/0x480
   seq_read+0x12e/0x160
   vfs_read+0xc1/0x370
   ? count_memcg_events+0xb6/0x170
   ksys_read+0x6b/0xe0
   do_syscall_64+0x89/0x810
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f8da79a0321

[Root Cause]
enabled_monitors_start() calls enabled_monitors_next() and passes the
address of a struct rv_monitor instead of the address of its embedded
list_head.

Commit de090d1ccae1 ("rv: Fix wrong type cast in enabled_monitors_next()")
assumes that the argument p refers to a list_head (the embedded list
anchor). This leads to the miscalculated address for the corresponding
struct rv_monitor object.

Here’s what happens in detail:

  1. Address of rv_monitors_list = 0xffffffffbba666c0
     crash> p &rv_monitors_list
     $1 = (struct list_head *) 0xffffffffbba666c0 <rv_monitors_list>

  2. offset of rv_monitor.list = 0x40
     crash> rv_monitor.list -x
     struct rv_monitor {
       [0x40] struct list_head list;
     }

  3. In enabled_monitors_start(): The local variable mon is assigned
     using list_entry(), resulting in:
         mon = &rv_monitors_list - 0x40 = 0xffffffffbba66680

  4. In enabled_monitors_next(): The argument p becomes
     &rv_monitors_list - 0x40. However, container_of() subtracts the
     offset of rv_monitor.list again, making mon equal to
     &rv_monitors_list - 0x80. This double subtraction results in an
     invalid address and triggers the page fault.

Fix the issue by returning the address of the list_head from both
enabled_monitors_start() and enabled_monitors_next() instead of the
address of struct rv_monitor.

The following verifications make sure the issue is fixed:
1. Without enabling any monitors
   # cat /sys/kernel/debug/tracing/rv/enabled_monitors
   <No output; no kernel oops.>

2. Enable monitor and reading enabled_monitors: Test #1
   # echo 1 > /sys/kernel/debug/tracing/rv/monitors/wwnr/enable
   # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/sleep/enable
   # cat /sys/kernel/debug/tracing/rv/enabled_monitors
   wwnr
   rtapp:sleep

3. Enable monitor and reading enabled_monitors: Test #2
   # echo 0 > /sys/kernel/debug/tracing/rv/monitors/wwnr/enable
   # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/sleep/enable
   # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/pagefault/enable
   # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/enable 
   # cat /sys/kernel/debug/tracing/rv/enabled_monitors
   rtapp
   rtapp:sleep
   rtapp:pagefault
   
Fixes: de090d1ccae1 ("rv: Fix wrong type cast in enabled_monitors_next()")
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 kernel/trace/rv/rv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 48338520376f..021cc9bc57ab 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
 		if (mon->enabled)
-			return mon;
+			return &mon->list;
 	}
 
 	return NULL;
@@ -509,23 +509,21 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 {
-	struct rv_monitor *mon;
+	struct list_head *lh = &rv_monitors_list;
 	loff_t l;
 
 	mutex_lock(&rv_interface_lock);
 
-	if (list_empty(&rv_monitors_list))
+	if (list_empty(lh))
 		return NULL;
 
-	mon = list_entry(&rv_monitors_list, struct rv_monitor, list);
-
 	for (l = 0; l <= *pos; ) {
-		mon = enabled_monitors_next(m, mon, &l);
-		if (!mon)
+		lh = enabled_monitors_next(m, lh, &l);
+		if (!lh)
 			break;
 	}
 
-	return mon;
+	return lh;
 }
 
 /*
-- 
2.43.0


