Return-Path: <linux-kernel+bounces-755752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B419BB1AB55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F38A4E0530
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A1292936;
	Mon,  4 Aug 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvsNY3s2"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBED1DE8B5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754349362; cv=none; b=Zt53tiaNztAVLGde+XSVx1jSNfibMgFjzsShVslTK6ih7KWnTX5qc9G+z7bomHf8Hi00vUVb/HOQS9Lo4fVQgBs9KlT+OdSfl8/mdVTocOEActGM5VSU8WSmsyjhi1xJMczk7y28m5hhBK9mH5qfq+79Dw8dOQe8Pz0Q5lGtboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754349362; c=relaxed/simple;
	bh=hbEq1Js8AlyKGQUt5xmaKCswYweUQKdmzuSbhBMwHKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDM//kPgUtO1KbN9MaVQ5zK4XELiGLE9dqS8r+ZHOFlgY5n3ssQTqn3bpLYybCt//VCAz+PUnzRU9ucxrXEuUn6ogbh0VaTBf6e8KUOabu1EOoT6cbIAsSBbXwYGE5wEq7St6d2hHztd4eYfndLJX7okjnVIOHYokpE5CYS3kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvsNY3s2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fe26e5a33so59955725ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754349360; x=1754954160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LLlVoqHDMFMIDh4+31o+ONV2fLHn7v9sHgdKTjexS4=;
        b=BvsNY3s2Jq837raVXdbyUux5M+QPo/2MU3rMcxdRFYcUSRBzoqNIZRD3VxwaMTKs3k
         CCX8ip2kzkSrlU5YOgqq/j73WbuFMimBvAtjkcdj9rSSHJl5mZjts1fULuShxK8rwmu9
         WRTO+5mohOg6Ta0w9Ye4MOtlTtSQcZEbBk165XAsuSrC7iQeKzbyXffH+/vAbF4DPxPz
         KfWdjKWpEj9rhKdBX5ypKw9OYJCnamruwR+Vo3hSeroevZ51zcEVaWi5LWprmeiWH/wQ
         IaWEoPOYPgOIcPlARQouSoFDSrhJIjad9L17o/VHe2oDiZMkdEtbNinbewHfVDNHDu3c
         KZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754349360; x=1754954160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LLlVoqHDMFMIDh4+31o+ONV2fLHn7v9sHgdKTjexS4=;
        b=Ebb0tDVNnSZXaXrvZHnHaTIrecYv5fcp2AIUWyfVVjRf75m8wWGRWtVvSnl6FpHlSs
         pRvcP2Iwu59AVrtotHVLe57UvqQKKM60w1HjxIOxcHwcYbSeMKzOk9ovCzju95jECyop
         FJNvmYo8aCM9sPQ6X/HVL8CZIbdW1fvz4coKQC12QMVvPrcoYZxdQbrcSicFQ3LDADbY
         rlIAo3EZbxzzpWxDqY+fwdMedAQsBoJZKzSCOv4OE/B6NmG9eG8tL6e/+RnZpDjTb4er
         KD7Tup0GjLBkcznc4jfyEqwtB7/wuno/1OlhW60rk+9N6syuGsmo+kPKkBJzO7EO3Ssu
         bzHg==
X-Forwarded-Encrypted: i=1; AJvYcCUfD1ukWQ6VxQvEcBXa/+C32ZLLfoaLmFwyAuv/RkQxeq68wjtC5Y+1hel4PhLy2Ov7f1k3jBitgp3XjK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmT/raopznsihTGRx8k3KE7Z0Gxxz9LNshPVLODL8CD952f1Dp
	LeO1aBius8cmGqk6JE/eUyFCEZhrubArzfNON8+wAukmb98Ogx6+DtiYpcRGPVRFQ9EEE+76Yyv
	wtfSxrA==
X-Google-Smtp-Source: AGHT+IF/QZzIgmBa6VwolABoKQDtTpPz3bEroyjsnVJNVCeHAjwJivrabr8q4l1Lq6BpaMaysvV3u9CBYtw=
X-Received: from plcx13.prod.google.com ([2002:a17:903:cd:b0:240:1be2:19ee])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:240:48f4:40d5
 with SMTP id d9443c01a7336-24247023e9cmr137793735ad.39.1754349360090; Mon, 04
 Aug 2025 16:16:00 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:15:50 -0700
In-Reply-To: <20250804231552.1217132-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804231552.1217132-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804231552.1217132-3-surenb@google.com>
Subject: [PATCH v2 2/3] fs/proc/task_mmu: factor out proc_maps_private fields
 used by PROCMAP_QUERY
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Refactor struct proc_maps_private so that the fields used by PROCMAP_QUERY
ioctl are moved into a separate structure. In the next patch this allows
ioctl to reuse some of the functions used for reading /proc/pid/maps
without using file->private_data. This prevents concurrent modification
of file->private_data members by ioctl and /proc/pid/maps readers.

The change is pure code refactoring and has no functional changes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/internal.h   | 15 ++++++----
 fs/proc/task_mmu.c   | 70 ++++++++++++++++++++++----------------------
 fs/proc/task_nommu.c | 14 ++++-----
 3 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 7c235451c5ea..663dc0510315 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -379,16 +379,21 @@ extern void proc_self_init(void);
  * task_[no]mmu.c
  */
 struct mem_size_stats;
-struct proc_maps_private {
-	struct inode *inode;
-	struct task_struct *task;
+
+struct proc_maps_locking_ctx {
 	struct mm_struct *mm;
-	struct vma_iterator iter;
-	loff_t last_pos;
 #ifdef CONFIG_PER_VMA_LOCK
 	bool mmap_locked;
 	struct vm_area_struct *locked_vma;
 #endif
+};
+
+struct proc_maps_private {
+	struct inode *inode;
+	struct task_struct *task;
+	struct vma_iterator iter;
+	loff_t last_pos;
+	struct proc_maps_locking_ctx lock_ctx;
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3d6d8a9f13fc..843577aa7a32 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -132,11 +132,11 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 
 #ifdef CONFIG_PER_VMA_LOCK
 
-static void unlock_vma(struct proc_maps_private *priv)
+static void unlock_vma(struct proc_maps_locking_ctx *lock_ctx)
 {
-	if (priv->locked_vma) {
-		vma_end_read(priv->locked_vma);
-		priv->locked_vma = NULL;
+	if (lock_ctx->locked_vma) {
+		vma_end_read(lock_ctx->locked_vma);
+		lock_ctx->locked_vma = NULL;
 	}
 }
 
@@ -151,14 +151,14 @@ static inline bool lock_vma_range(struct seq_file *m,
 	 * walking the vma tree under rcu read protection.
 	 */
 	if (m->op != &proc_pid_maps_op) {
-		if (mmap_read_lock_killable(priv->mm))
+		if (mmap_read_lock_killable(priv->lock_ctx.mm))
 			return false;
 
-		priv->mmap_locked = true;
+		priv->lock_ctx.mmap_locked = true;
 	} else {
 		rcu_read_lock();
-		priv->locked_vma = NULL;
-		priv->mmap_locked = false;
+		priv->lock_ctx.locked_vma = NULL;
+		priv->lock_ctx.mmap_locked = false;
 	}
 
 	return true;
@@ -166,10 +166,10 @@ static inline bool lock_vma_range(struct seq_file *m,
 
 static inline void unlock_vma_range(struct proc_maps_private *priv)
 {
-	if (priv->mmap_locked) {
-		mmap_read_unlock(priv->mm);
+	if (priv->lock_ctx.mmap_locked) {
+		mmap_read_unlock(priv->lock_ctx.mm);
 	} else {
-		unlock_vma(priv);
+		unlock_vma(&priv->lock_ctx);
 		rcu_read_unlock();
 	}
 }
@@ -179,13 +179,13 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 {
 	struct vm_area_struct *vma;
 
-	if (priv->mmap_locked)
+	if (priv->lock_ctx.mmap_locked)
 		return vma_next(&priv->iter);
 
-	unlock_vma(priv);
-	vma = lock_next_vma(priv->mm, &priv->iter, last_pos);
+	unlock_vma(&priv->lock_ctx);
+	vma = lock_next_vma(priv->lock_ctx.mm, &priv->iter, last_pos);
 	if (!IS_ERR_OR_NULL(vma))
-		priv->locked_vma = vma;
+		priv->lock_ctx.locked_vma = vma;
 
 	return vma;
 }
@@ -193,14 +193,14 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 					 loff_t pos)
 {
-	if (priv->mmap_locked)
+	if (priv->lock_ctx.mmap_locked)
 		return false;
 
 	rcu_read_unlock();
-	mmap_read_lock(priv->mm);
+	mmap_read_lock(priv->lock_ctx.mm);
 	/* Reinitialize the iterator after taking mmap_lock */
 	vma_iter_set(&priv->iter, pos);
-	priv->mmap_locked = true;
+	priv->lock_ctx.mmap_locked = true;
 
 	return true;
 }
@@ -210,12 +210,12 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 static inline bool lock_vma_range(struct seq_file *m,
 				  struct proc_maps_private *priv)
 {
-	return mmap_read_lock_killable(priv->mm) == 0;
+	return mmap_read_lock_killable(priv->lock_ctx.mm) == 0;
 }
 
 static inline void unlock_vma_range(struct proc_maps_private *priv)
 {
-	mmap_read_unlock(priv->mm);
+	mmap_read_unlock(priv->lock_ctx.mm);
 }
 
 static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
@@ -258,7 +258,7 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 		*ppos = vma->vm_end;
 	} else {
 		*ppos = SENTINEL_VMA_GATE;
-		vma = get_gate_vma(priv->mm);
+		vma = get_gate_vma(priv->lock_ctx.mm);
 	}
 
 	return vma;
@@ -278,7 +278,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (!priv->task)
 		return ERR_PTR(-ESRCH);
 
-	mm = priv->mm;
+	mm = priv->lock_ctx.mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		put_task_struct(priv->task);
 		priv->task = NULL;
@@ -318,7 +318,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->lock_ctx.mm;
 
 	if (!priv->task)
 		return;
@@ -339,9 +339,9 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
+		int err = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
@@ -355,8 +355,8 @@ static int proc_map_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->lock_ctx.mm)
+		mmdrop(priv->lock_ctx.mm);
 
 	return seq_release_private(inode, file);
 }
@@ -610,7 +610,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!!karg.build_id_size != !!karg.build_id_addr)
 		return -EINVAL;
 
-	mm = priv->mm;
+	mm = priv->lock_ctx.mm;
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
@@ -1307,7 +1307,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
 	struct mem_size_stats mss = {};
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->lock_ctx.mm;
 	struct vm_area_struct *vma;
 	unsigned long vma_start = 0, last_vma_end = 0;
 	int ret = 0;
@@ -1452,9 +1452,9 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 		goto out_free;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		ret = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
+		ret = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;
 
 		single_release(inode, file);
 		goto out_free;
@@ -1472,8 +1472,8 @@ static int smaps_rollup_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->lock_ctx.mm)
+		mmdrop(priv->lock_ctx.mm);
 
 	kfree(priv);
 	return single_release(inode, file);
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 59bfd61d653a..d362919f4f68 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -204,7 +204,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (!priv->task)
 		return ERR_PTR(-ESRCH);
 
-	mm = priv->mm;
+	mm = priv->lock_ctx.mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		put_task_struct(priv->task);
 		priv->task = NULL;
@@ -226,7 +226,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->lock_ctx.mm;
 
 	if (!priv->task)
 		return;
@@ -259,9 +259,9 @@ static int maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
+		int err = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
@@ -276,8 +276,8 @@ static int map_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->lock_ctx.mm)
+		mmdrop(priv->lock_ctx.mm);
 
 	return seq_release_private(inode, file);
 }
-- 
2.50.1.565.gc32cd1483b-goog


