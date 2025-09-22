Return-Path: <linux-kernel+bounces-826982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B8B8FCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B04917F5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F0E2877F1;
	Mon, 22 Sep 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hrZuo7QI"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B327EC80
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534119; cv=none; b=TvmXrswWjME6s3EEqm61ZOj1uluo7k6n1+npay8Y85qNu8IJXdd5rXv8X2OQqxlNkDuDPorUp1AhFUrRVPJRfJKmfre74X7/6oNqdOFjWsKJ8vhhBcdUKhdnPqRNrCtIvmeVCW5VbvoZkte/rD6oUrczQYqCXKKXrzNz+sQYmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534119; c=relaxed/simple;
	bh=rDbjJqfrVT3iYKOdxeeeDu98RNknKj03jGwDUTalysI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5fq7oK2kVsJYGMyG5Oq0fHH2ohkb1/WSjylD0ZYyedBMuaL4AiGUO51dnjUqlnR8iPFnnhS8uYz0aNyVHRec9BHik6EWMEAtD/udpQZg3v60AlbegZh/w3py6Yb6qV8Qc5H6crWpInquijG2yJfxBsPhdPAnU+ysBnvRrg3Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hrZuo7QI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-25669596955so37716995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534117; x=1759138917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ilme44nSGxyu5goRsold31IBeaqSjRBg4bzvILaBH90=;
        b=hrZuo7QIz+/F8CRd7boT8sJ8wSADHpsnqQvLrOTlqTomWeihHofRkwiirkmeNcP4Ig
         9VBYP8/jZ1xhf307i3q+GWXHAXZGtk+2HapQV9uXHUZNq5CwWkSmLXniGMmq92KmGqVB
         NYf5CG/4XDKDb9UIJsxDwrSkFbQPY3LQFv7jq3PhueaV0zm9BupIqpsw3+JlPpSHu03/
         tzwVCd08cs4YcHyTJ09bM2BHZaVLFqckradmG/FwfxKbslVkVlAURud+YBQpEsPBzkBC
         J576DHuII6nj69Lp4DsAnEQQodAjm50mW+xzmvrCtjE1/9nEygJeaAr4QGHR7alaLgJR
         Kqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534117; x=1759138917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ilme44nSGxyu5goRsold31IBeaqSjRBg4bzvILaBH90=;
        b=C9b7sC+oU2mKEGAFgvLswOzivjzjQDc9J7e/ygXYGz7xjTEdrJ1qLv1pqvtcV4p8DB
         QnhnqcGuWuwVzMB/IRhRkHvOdIihB9FGvA27BQcZPUfll+mV7gQPCFkSo9Pq2rwVSH7c
         7LqTsjZOkC4Cxeybj9mR8vD6MmHc/dQ5X8T2bPOqz6y74VJIH3u3zafUFykNQjXL7K/z
         jwNADJ47ir9a3Fm6usx82es0ZTc58vqz0XpEtXjaFq2HcxwGRRcxRTkAk0ntUPqRDoxL
         NH0sOxJiIiNBhp4goZRW9jIx+WVe+7ks94P6smRuXFpHU/5fHQmX7wYL8N4SnxvV4jLi
         T7yg==
X-Forwarded-Encrypted: i=1; AJvYcCUEYAvDdLPE6PZopyLzOEEQGHi4ILdfCayOK6RINLq00szCASY0JxO0N6L5ZvFpeU1c4Gw9xhZfSHHuEoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1pIsJEIU7Y/f++/KOesgJHxCs2G24mUy0m7ZwMG/zl7I95Dt
	evXeULsDJlQLsd1Sh73JSGj2FCjkwRY4qtpE840/mcc8gzFDlRkbXfLtQLNzVzV2T40=
X-Gm-Gg: ASbGncuXiRO0mxD9QvFCe+YC2Sra4P+6HHhv0CxWlzmwkukkS4UgXxn1PNCZcxLXRVU
	Z1GqkUdfV9AIH+zfCvKyYGUUQzEOl4pgFCYaCTV1LIXLhnct1hIQpX/apcqb/jdqiCllvB9cLyX
	6itkh7bPY6vJmYnGvkTD/7iQTgxYJB7IirSJ49ZG8DIgLWGDTN4/U4w9pimDCDghz+4NoDez+Sq
	8RH+d+d37p1l0v8MGZSRpm0kCxb2fgBjhObpQZjTYxp6OOw2jvA1hqsh7+uGwRpGDZh09q7ZxuI
	oKTSkBC4k/4YihqRE0b0fi1VkmfCy9iogKCArV7Kuhikz6rX9xgk6Kjt4gX+0+VIWa7R9Amh5Mp
	UC78IaYUqb7vyWjSLPA118ZUBA5s=
X-Google-Smtp-Source: AGHT+IHTVxBH3sMWN6WpoQ12cRY11DoelBPBAV269/lJBRXXkxnuVmCr/ewlC/t72yrjY6SteGk+jA==
X-Received: by 2002:a17:902:e810:b0:272:dee1:c133 with SMTP id d9443c01a7336-272dee1c1afmr91385565ad.22.1758534116735;
        Mon, 22 Sep 2025 02:41:56 -0700 (PDT)
Received: from localhost ([106.38.226.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm127745565ad.15.2025.09.22.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:41:56 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 1/3] sched: Introduce a new flag PF_DONT_HUNG.
Date: Mon, 22 Sep 2025 17:41:44 +0800
Message-Id: <20250922094146.708272-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, long waits can trigger hung task warnings. However, some
warnings are undesirable and unnecessary - for example, a hung task
warning triggered when a background kworker waits for writeback
completion during resource cleanup(like the context of
mem_cgroup_css_free()). This kworker does not affect any user behavior
and there is no erroneous behavior at the kernel code level, yet it
triggers an annoying hung task warning.

This patch adds a new flag to task_struct to instruct the hung task
detector to ignore such cases, as suggested by Andrew Morton in [1].
Also introduces current_set/clear_flags() to prepare for the next patch.

[1]: https://lore.kernel.org/cgroups/20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org/

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/linux/sched.h | 12 +++++++++++-
 kernel/hung_task.c    |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..cd70ff051b2a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1718,6 +1718,16 @@ static inline char task_state_to_char(struct task_struct *tsk)
 	return task_index_to_char(task_state_index(tsk));
 }
 
+static inline void current_set_flags(unsigned int flags)
+{
+	current->flags |= flags;
+}
+
+static inline void current_clear_flags(unsigned int flags)
+{
+	current->flags &= ~flags;
+}
+
 extern struct pid *cad_pid;
 
 /*
@@ -1747,7 +1757,7 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF__HOLE__00800000	0x00800000
+#define PF_DONT_HUNG		0x00800000	/* Don't trigger hung task warning when waiting for something */
 #define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..b16d72276d01 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -208,6 +208,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		t->last_switch_time = jiffies;
 		return;
 	}
+
+	if (t->flags & PF_DONT_HUNG) {
+		t->last_switch_time = jiffies;
+		return;
+	}
+
 	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
 		return;
 
-- 
2.39.5


