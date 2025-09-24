Return-Path: <linux-kernel+bounces-829875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F9BB9819D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D35172B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD62236E8;
	Wed, 24 Sep 2025 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YASNqLEv"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79119221F06
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682549; cv=none; b=tIi4Kf4OrJf2UfCBE2Q2xmEdLQg5xgXvNUq3GaHwuWnjldayQm5QtLhtSHNqqTiSwZRRg3t/ZUrgkMVJ21O/KIWAxdmnmNmRucskVKD8m1RiAoiyIj5vdjPqchKAI/UcbrbiZpwetJhm5m9Igt0AThbbvCp4KVRpqczE7yb2xoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682549; c=relaxed/simple;
	bh=OelFJmvx0NhE6nKyLjoHzfbmYUaetqukKA+N9t1a5OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAZBf93rO1sdNgoyTUkjfMzgR4up38y3iHP+AtLeeHSayXS3EoouLHliUqCAbiVgHhZXy2uyctV2WQnezPBGyQl1YsdVhWodjpZkWAKyN2sSf7gKhFs7Uf+Hu3h/ABeyHNYigkPR5367DZRqBcLInu5HRB45LXMZNqP5CuNRQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YASNqLEv; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b553412a19bso2431439a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758682546; x=1759287346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wpopjzKvn+DxHJvP3HonHhrSV+mOoMbKIX1RB72zO4=;
        b=YASNqLEv4+Uil8rPGNoTGnu7wGTbtuQUVuTL0/qm1kwDefVrb+E0bF6YChZA8ouzhz
         oSLyM4dZZU3kVzqN5TquodY/QLaZnNSrOEYFLI7p3e3eCeaOH7wCxBVyNz5jpMFGIsjo
         uhDLZn+VtWPrtjXTD+C8/4xKodrATZxhacfBL601cnHoKxRez84OAUjYpo9mUOHQlBnJ
         WmBC/LEmqzs2h8jH7fUeOQ5j60d3JW1xUyTpZN1Mj+o0mKRtdxxdb6MCm1cdcRZMX2Gs
         TYppYmTSXQ2LDyFVrmCMybSm8hoZuq5DCYRM5yI4RilSBsQeT3PMxx9Sd+W5Iwdzj4hz
         Eeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758682546; x=1759287346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wpopjzKvn+DxHJvP3HonHhrSV+mOoMbKIX1RB72zO4=;
        b=VMSdg5Ig1g4bPAav98CdCPkLNlxrVpaiD1O+ULNMlr7n0YTYijW88GGCFJvcvCYyBY
         BbzLxp6bGjKnPOg+WN9ShaQ2oPOoAFFMOHn/BFkTzmseEuf+Y070ITV+7G4Avys8Vw6E
         tvvcSga0Mg2B/jNRdxsdArZOJ8x9aG4ehtdSGocus4GWTDij2reWRrr53QuhVFcG8bJO
         v15ps8k3QboHc1l9cs0m2jYk9MGPBW2fILPQYzJS0Fu2A7extdIoi4WtAsjupk98jsdV
         8j/4h/qattl2AHachfqhaUc9upkBleETu5YPnLJYcrz3/fpDRqDN01A4cgBpHeT+hvYN
         Vszg==
X-Gm-Message-State: AOJu0YzPwhLJFDgD4Yy3j49Til/YVZ3duQwnFeJOfVU52rCMpn/kj6ou
	A7vob5OxaDhllwr1jpi9Kk8D1vNQUhsCNvL9FmxDkmpoG1Qk+yzAyzeo
X-Gm-Gg: ASbGncu+Y15VJs4XNEFshtos6nsgF9qrfmKqInlJRRhVKdSgC18FENE5upjYn0X7iM3
	6j0IJ1qNbClXCsb4NWvhyFJH0JhFaHPti4QZO3ZH6fD2ubCNjHfhpfK1N8gnlrZTflvkd7jU580
	xgFllL/iEAxfCyLROc1bofYE0HoZ06qYpBJxbpN48otk9E5m6t9d6dtRYvghpQ4x2OFGuOICbPF
	KEltmKm6dfZcET7D643iPv2Z3ixQhLqu2Vd5yBKLP6eyP7XlPt/i2rdRYROE2Nrnouiffz0nHdE
	bSef8NzhvIJXwZHAfaJu9BDLklPPy9XORKEKyY3dXFeAc91ktzGYOWyqSkXExuYsse+bNFS99r2
	5w5YG5ESrg0fQ7XgvyoTjIifLvlr7y32JW7bwr2aNqk771YuVj0UrmGGoPr2Kjg==
X-Google-Smtp-Source: AGHT+IHlMT3OoBwZiCqloBHBH4oPcFBqVbAtlNUyZLqKjEwFADFX+IZZjws5+IemEAMIYHHY72dOuw==
X-Received: by 2002:a17:902:cecb:b0:273:c463:7b2c with SMTP id d9443c01a7336-27cc128c1eamr53859085ad.3.1758682545587;
        Tue, 23 Sep 2025 19:55:45 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016b675sm171075835ad.36.2025.09.23.19.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:55:45 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v2 1/2] selinux: Make avc cache slot size configurable during boot
Date: Wed, 24 Sep 2025 10:55:38 +0800
Message-ID: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758633723.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758633723.git.zhanghongru@xiaomi.com>
References: <cover.1758633723.git.zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

An actual call stack is as follows:
 => avc_compute_av
 => avc_perm_nonode
 => avc_has_perm_noaudit
 => selinux_capable
 => security_capable
 => capable
 => __sched_setscheduler
 => do_sched_setscheduler
 => __arm64_sys_sched_setscheduler
 => invoke_syscall
 => el0_svc_common
 => do_el0_svc
 => el0_svc
 => el0t_64_sync_handler
 => el0t_64_sync

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node latency increase.

Make avc cache slot size also configurable, and with fine tuning, we can
mitigate long time irqs off with slightly avc_search_node performance
regression.

Theoretically, the main overhead is memory consumption.

avc_search_node avg latency test results (about 100,000,000 times) on
Qcom SM8750, 6.6.30-android15-8:

Case 1:
+---------+---------------------+------------------------+
|         | no-patch (512/512)  | with-patch (512/512)   |
+---------+---------------------+------------------------+
| latency |        85 ns        |         87 ns          |
+---------+---------------------+------------------------+

Case 2:
+---------+---------------------+------------------------+
|         | no-patch (8192/512) | with-patch (8192/8192) |
+---------+---------------------+------------------------+
| latency |        277 ns       |         106 ns         |
+---------+---------------------+------------------------+

Case 1 shows 512 nodes configuration has ~2% performance regression
with patch.
Case 2 shows 8192 nodes configuration has ~61% latency benifit with
patch.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 security/selinux/avc.c                        | 68 +++++++++++++------
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..70dc6d659117 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6620,6 +6620,10 @@
 			1 -- enable.
 			Default value is 1.
 
+	selinux_avc_cache_slots= [SELINUX] Set the avc cache slot size.
+			Format: <int> (must be >0, power of 2)
+			Default: 512
+
 	serialnumber	[BUGS=X86-32]
 
 	sev=option[,option...] [X86-64]
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 430b0e23ee00..7a7f88012865 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -34,7 +34,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/avc.h>
 
-#define AVC_CACHE_SLOTS			512
+static int avc_cache_slots __ro_after_init = 512;
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
 
@@ -68,9 +68,13 @@ struct avc_xperms_node {
 	struct list_head xpd_head; /* list head of extended_perms_decision */
 };
 
+struct avc_slot {
+	struct hlist_head	slot;		/* head for avc_node->list */
+	spinlock_t		slot_lock;	/* lock for writes */
+};
+
 struct avc_cache {
-	struct hlist_head	slots[AVC_CACHE_SLOTS]; /* head for avc_node->list */
-	spinlock_t		slots_lock[AVC_CACHE_SLOTS]; /* lock for writes */
+	struct avc_slot		*slots;
 	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
 	atomic_t		active_nodes;
 	u32			latest_notif;	/* latest revocation notification */
@@ -93,14 +97,34 @@ struct selinux_avc {
 
 static struct selinux_avc selinux_avc;
 
+static int __init set_selinux_avc_cache_slots(char *str)
+{
+	int val;
+
+	if ((kstrtoint(str, 0, &val)) || !is_power_of_2(val)) {
+		pr_warn("Unable to set selinux_avc_cache_slots, use default value\n");
+		return 1;
+	}
+
+	avc_cache_slots = val;
+
+	return 1;
+}
+__setup("selinux_avc_cache_slots=", set_selinux_avc_cache_slots);
+
 void selinux_avc_init(void)
 {
 	int i;
 
+	selinux_avc.avc_cache.slots =
+		kmalloc_array(avc_cache_slots, sizeof(struct avc_slot), GFP_KERNEL);
+	if (!selinux_avc.avc_cache.slots)
+		panic("SELinux: No memory to alloc avc cache slots\n");
+
 	selinux_avc.avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
-		spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
+	for (i = 0; i < avc_cache_slots; i++) {
+		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i].slot);
+		spin_lock_init(&selinux_avc.avc_cache.slots[i].slot_lock);
 	}
 	atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
 	atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
@@ -124,7 +148,7 @@ static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
 static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
+	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
 }
 
 /**
@@ -150,8 +174,8 @@ int avc_get_hash_stats(char *page)
 
 	slots_used = 0;
 	max_chain_len = 0;
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &selinux_avc.avc_cache.slots[i];
+	for (i = 0; i < avc_cache_slots; i++) {
+		head = &selinux_avc.avc_cache.slots[i].slot;
 		if (!hlist_empty(head)) {
 			slots_used++;
 			chain_len = 0;
@@ -167,7 +191,7 @@ int avc_get_hash_stats(char *page)
 	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
 			 "longest chain: %d\n",
 			 atomic_read(&selinux_avc.avc_cache.active_nodes),
-			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
+			 slots_used, avc_cache_slots, max_chain_len);
 }
 
 /*
@@ -463,11 +487,11 @@ static inline int avc_reclaim_node(void)
 	struct hlist_head *head;
 	spinlock_t *lock;
 
-	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
+	for (try = 0, ecx = 0; try < avc_cache_slots; try++) {
 		hvalue = atomic_inc_return(&selinux_avc.avc_cache.lru_hint) &
-			(AVC_CACHE_SLOTS - 1);
-		head = &selinux_avc.avc_cache.slots[hvalue];
-		lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+			(avc_cache_slots - 1);
+		head = &selinux_avc.avc_cache.slots[hvalue].slot;
+		lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 
 		if (!spin_trylock_irqsave(lock, flags))
 			continue;
@@ -524,7 +548,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 	struct hlist_head *head;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &selinux_avc.avc_cache.slots[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
 	hlist_for_each_entry_rcu(node, head, list) {
 		if (ssid == node->ae.ssid &&
 		    tclass == node->ae.tclass &&
@@ -625,8 +649,8 @@ static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
 	}
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &selinux_avc.avc_cache.slots[hvalue];
-	lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
+	lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 	spin_lock_irqsave(lock, flag);
 	hlist_for_each_entry(pos, head, list) {
 		if (pos->ae.ssid == ssid &&
@@ -846,8 +870,8 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
 	/* Lock the target slot */
 	hvalue = avc_hash(ssid, tsid, tclass);
 
-	head = &selinux_avc.avc_cache.slots[hvalue];
-	lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
+	lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 
 	spin_lock_irqsave(lock, flag);
 
@@ -929,9 +953,9 @@ static void avc_flush(void)
 	unsigned long flag;
 	int i;
 
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &selinux_avc.avc_cache.slots[i];
-		lock = &selinux_avc.avc_cache.slots_lock[i];
+	for (i = 0; i < avc_cache_slots; i++) {
+		head = &selinux_avc.avc_cache.slots[i].slot;
+		lock = &selinux_avc.avc_cache.slots[i].slot_lock;
 
 		spin_lock_irqsave(lock, flag);
 		/*
-- 
2.43.0


