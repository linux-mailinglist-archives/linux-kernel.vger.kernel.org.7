Return-Path: <linux-kernel+bounces-667863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B0AC8ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2C14E3D11
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D522A7F8;
	Fri, 30 May 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JF2KgJ8c"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17C2253A0
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597354; cv=none; b=jsRxn8ZZcIVgT29UGn2+A86aRY6HpD3f96GhatWN4vXwoKzqNWGXdmCb/U6eOVojWKeescczasPjxjaotOeZackouOwJKrBWKvDZ5b+eD1eQPLxnElfdB7eOq1tVmcv6Y2Rqvb5VCa3LAhReORD8ejyP+qf2jfk6yTNpJIODZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597354; c=relaxed/simple;
	bh=VCOCu6O/NADHfF14Am0W07s7tA5GTZgRlngfMicR/Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7s+ySDq3H3kTkNTftmsCdKfTEGXzVGAFowU6r+K1RXj6yNJcwV6qvwvh45js6vt6Kqx9A8ebhwrlkIyPqXoisHlbfkcJSXQpfOjJPm90zGBqgUK8Q+PTiZ4NznXwzGgzF5qshAT/LR6RIps1W91QmRqDPYBNhCeBd4J3tW9t+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JF2KgJ8c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23526264386so8607445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597352; x=1749202152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGQ/MSD2aq8Zt0uX+CveEn5QJtfmVtywDoJlykkJ748=;
        b=JF2KgJ8cx2NSohpk333GW3x0my23qoG68NSIxWf5sYIpcvmj7bxkarfiGI+IITH+wK
         aTcwd7A9kmW/XD7Nqc9N8Cp0KUzCcOoCrWY9y8mRvBC8RtHBmWtQtCgKUwu143NGBm2o
         /L4ATUoviWRFPR6BmI6F/OeXAPiKS/5DIk6/4VIxNsCSFCOLtMLv257BUSqfhvQAnYM8
         7OhsnPp33+CBv9gcOf6K9XyCogI5HvwzR36gX5UNssqDkEnYLBsshsJPvwi5Z+pNJY+6
         tUzmm3lBJiRrwHSHt6NOPup1OvuIhn+pW7nz6kM09D44SIZ21LGlph6fmlCi80Hy891o
         Tu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597352; x=1749202152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGQ/MSD2aq8Zt0uX+CveEn5QJtfmVtywDoJlykkJ748=;
        b=cUEgOjKkwtzuf9T6iYgvMGXoB/PTTZzwrRrzmfxEiLF9Zr224s5NHmWJ9LMKGjHWy+
         vR5sDUSpyzGjauZfHIOcKkUzezyg6ofdO1KN8Hq3tThl9vB7IIRSbmoEnbgsJWaVu/NB
         et2KhsLYFDvvIp3O1zvrAo3+GVmgCdw6MaatkKMwoc3UTrDac92HRt70J2iJupk2IdRf
         vn0dynnQZWOa7AC8j4v2k8eXxX53+HnQa4w1fPzlOHjD+N4LTqgxLH1+QK1yta6nGowo
         LPrOlcDX3UonahplVFgr1LcVAdNo/Ye+AwFDz70VbamCDSvvnOPsRZprTWhjTjp9L1+j
         /O3A==
X-Forwarded-Encrypted: i=1; AJvYcCW8eEwOiMtV3XidR9dz723atBiYGyodYwWyiWRWDb7ytuM7IbQPGJYF5g0pO/cQ8lYnxrndSeZUX4KQLgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwFPMt+KgqiAJXS2Ng6mjld726JMa+sjszcr2Vx0a4EHVQsIW
	PibKww0yIybbMkAteShfm/drAhqAs7mCHTJD1mRkmAeetJ6P+R5i6zKZoogg7IsQowg=
X-Gm-Gg: ASbGncuf+HlU7mMSXlCV3VMS79IhnD6Ef/XRfHsJ9eacF/5pK0l1I4DyGdGk0eZQq9h
	N0KhueAifWGzH9/UTFFAKcc8ViR8zJzUnskBx3ypA3EGW5Db0IHVRIetyW6F+ZV/jCmYP7fIQCs
	o03nTlTYhxHuXdb1XkBSAjxyITblHO7xWT8GCT2K3rayXiVqr6gw/ex/JzEndr2m1I3jQkmKNOw
	NTOTAUkyug3zi2CoiLMnKz+qzb4/U8iMc6gpgkmZuaXkIt4ziZsrQ+fzwtZ45dQFeeGemfkEdcf
	Os5rhP581hBCPxB4JxYj15FGnlWOtVAVP3d1VfR8k1oERxziecvqHGsKCGSJLJQPmjgyWAHNkfk
	Wxt3jytLAEQ==
X-Google-Smtp-Source: AGHT+IHXNv6SBDXy0RRoZRael/cpWOT8NPAPr0x/A4zO15FUEF6dVXWmKj+6rOHNmQu7F4oEsyx/Vw==
X-Received: by 2002:a17:90b:3a82:b0:311:ab20:159d with SMTP id 98e67ed59e1d1-3124163a55amr3859759a91.19.1748597351985;
        Fri, 30 May 2025 02:29:11 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.28.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:29:11 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 03/35] RPAL: add service registration interface
Date: Fri, 30 May 2025 17:27:31 +0800
Message-Id: <f3d83dbf77500433986cdfb649bf603ea9031961.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every rpal service should be registered and managed. Each RPAL service has
a 64-bit key as its unique identifier, the key should never repeat before
kernel reboot. Each RPAL service has an ID to indicate which 512GB virtual
address space it can use. Any alive RPAL service has its unique ID, which
will never be reused until the service dead.

This patch adds a registration interface for RPAL services. Newly
registered rpal_service instances are assigned a key that increments
starting from 1. The 64-bit length of the key ensures that keys are almost
impossible to exhaust before system reboot. Meanwhile, a bitmap is used to
allocate IDs, ensuring no duplicate IDs are assigned. RPAL services are
managed via a hash list, which facilitates quick lookup of the
corresponding rpal_service by key.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/service.c | 130 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h    |  31 ++++++++++
 2 files changed, 161 insertions(+)

diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index c8e609798d4f..609c9550540d 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -13,13 +13,56 @@
 
 #include "internal.h"
 
+static DECLARE_BITMAP(rpal_id_bitmap, RPAL_NR_ID);
+static atomic64_t service_key_counter;
+static DEFINE_HASHTABLE(service_hash_table, ilog2(RPAL_NR_ID));
+DEFINE_SPINLOCK(hash_table_lock);
 static struct kmem_cache *service_cache;
 
+static inline void rpal_free_service_id(int id)
+{
+	clear_bit(id, rpal_id_bitmap);
+}
+
 static void __rpal_put_service(struct rpal_service *rs)
 {
 	kmem_cache_free(service_cache, rs);
 }
 
+static int rpal_alloc_service_id(void)
+{
+	int id;
+
+	do {
+		id = find_first_zero_bit(rpal_id_bitmap, RPAL_NR_ID);
+		if (id == RPAL_NR_ID) {
+			id = RPAL_INVALID_ID;
+			break;
+		}
+	} while (test_and_set_bit(id, rpal_id_bitmap));
+
+	return id;
+}
+
+static bool is_valid_id(int id)
+{
+	return id >= 0 && id < RPAL_NR_ID;
+}
+
+static u64 rpal_alloc_service_key(void)
+{
+	u64 key;
+
+	/* confirm we do not run out keys */
+	if (unlikely(atomic64_read(&service_key_counter) == _AC(-1, UL))) {
+		rpal_err("key is exhausted\n");
+		return RPAL_INVALID_KEY;
+	}
+
+	key = atomic64_fetch_inc(&service_key_counter);
+	return key;
+}
+
 struct rpal_service *rpal_get_service(struct rpal_service *rs)
 {
 	if (!rs)
@@ -37,6 +80,90 @@ void rpal_put_service(struct rpal_service *rs)
 		__rpal_put_service(rs);
 }
 
+static u32 get_hash_key(u64 key)
+{
+	return key % RPAL_NR_ID;
+}
+
+struct rpal_service *rpal_get_service_by_key(u64 key)
+{
+	struct rpal_service *rs, *rsp;
+	u32 hash_key = get_hash_key(key);
+
+	rs = NULL;
+	hash_for_each_possible(service_hash_table, rsp, hlist, hash_key) {
+		if (rsp->key == key) {
+			rs = rsp;
+			break;
+		}
+	}
+	return rpal_get_service(rs);
+}
+
+static void insert_service(struct rpal_service *rs)
+{
+	unsigned long flags;
+	int hash_key;
+
+	hash_key = get_hash_key(rs->key);
+
+	spin_lock_irqsave(&hash_table_lock, flags);
+	hash_add(service_hash_table, &rs->hlist, hash_key);
+	spin_unlock_irqrestore(&hash_table_lock, flags);
+}
+
+static void delete_service(struct rpal_service *rs)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hash_table_lock, flags);
+	hash_del(&rs->hlist);
+	spin_unlock_irqrestore(&hash_table_lock, flags);
+}
+
+struct rpal_service *rpal_register_service(void)
+{
+	struct rpal_service *rs;
+
+	if (!rpal_inited)
+		return NULL;
+
+	rs = kmem_cache_zalloc(service_cache, GFP_KERNEL);
+	if (!rs)
+		goto alloc_fail;
+
+	rs->id = rpal_alloc_service_id();
+	if (!is_valid_id(rs->id))
+		goto id_fail;
+
+	rs->key = rpal_alloc_service_key();
+	if (unlikely(rs->key == RPAL_INVALID_KEY))
+		goto key_fail;
+
+	atomic_set(&rs->refcnt, 1);
+
+	insert_service(rs);
+
+	return rs;
+
+key_fail:
+	kmem_cache_free(service_cache, rs);
+id_fail:
+	rpal_free_service_id(rs->id);
+alloc_fail:
+	return NULL;
+}
+
+void rpal_unregister_service(struct rpal_service *rs)
+{
+	if (!rs)
+		return;
+
+	delete_service(rs);
+
+	rpal_put_service(rs);
+}
+
 int __init rpal_service_init(void)
 {
 	service_cache = kmem_cache_create("rpal_service_cache",
@@ -47,6 +174,9 @@ int __init rpal_service_init(void)
 		return -1;
 	}
 
+	bitmap_zero(rpal_id_bitmap, RPAL_NR_ID);
+	atomic64_set(&service_key_counter, RPAL_FIRST_KEY);
+
 	return 0;
 }
 
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 73468884cc5d..75c5acf33844 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -11,13 +11,40 @@
 
 #include <linux/sched.h>
 #include <linux/types.h>
+#include <linux/hashtable.h>
 #include <linux/atomic.h>
 
 #define RPAL_ERROR_MSG "rpal error: "
 #define rpal_err(x...) pr_err(RPAL_ERROR_MSG x)
 #define rpal_err_ratelimited(x...) pr_err_ratelimited(RPAL_ERROR_MSG x)
 
+/*
+ * The first 512GB is reserved due to mmap_min_addr.
+ * The last 512GB is dropped since stack will be initially
+ * allocated at TASK_SIZE_MAX.
+ */
+#define RPAL_NR_ID 254
+#define RPAL_INVALID_ID -1
+#define RPAL_FIRST_KEY _AC(1, UL)
+#define RPAL_INVALID_KEY _AC(0, UL)
+
+/*
+ * Each RPAL service has a 64-bit key as its unique identifier, and
+ * the 64-bit length ensures that the key will never repeat before
+ * the kernel reboot.
+ *
+ * Each RPAL service has an ID to indicate which 512GB virtual address
+ * space it can use. All alive RPAL processes have unique IDs, ensuring
+ * their address spaces do not overlap. When a process exits, its ID
+ * is released, allowing newly started RPAL services to reuse the ID.
+ */
 struct rpal_service {
+	/* Unique identifier for RPAL service */
+	u64 key;
+	/* virtual address space id */
+	int id;
+	/* Hashtable list for this struct */
+	struct hlist_node hlist;
 	/* reference count of this struct */
 	atomic_t refcnt;
 };
@@ -40,4 +67,8 @@ struct rpal_service *rpal_get_service(struct rpal_service *rs);
  * @param rs The struct rpal_service to put.
  */
 void rpal_put_service(struct rpal_service *rs);
+
+void rpal_unregister_service(struct rpal_service *rs);
+struct rpal_service *rpal_register_service(void);
+struct rpal_service *rpal_get_service_by_key(u64 key);
 #endif
-- 
2.20.1


