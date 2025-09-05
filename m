Return-Path: <linux-kernel+bounces-802436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90197B45264
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0FD580810
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E132D288527;
	Fri,  5 Sep 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sa273jt7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF627F727
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062951; cv=none; b=QLnUt7VLMMeeEMlq7FhD6Rk5e5sB4xq+eBH1DJTF4eH7b+1wPXPv3dYLhHMiD2df67yjbuhXHuSHYgVWrelvUEGIWFiHsvjC3VJ84BnFQYcwn1nLW3Th6E4h0hJrHu5gIgfB2Yn6WWTwkR6wLdFn6sUFfcLj3B2KIqvplCZwqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062951; c=relaxed/simple;
	bh=UQcbGKc3PcWIuxAr5YFqM3VR2i3hOODc5K8LZ8GXK+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g44Lp4pMuC/KA2jbGFcgSCz1GVI4YOUAeteKdq+XD4oV50UbD9yREod2c8Lu9nFcjPNRUmxwlIUEoTfs/uP4V5d/1g1l/do5BpYbfUmQMLcUTKBpc1wwnHjuLMBClK9FUZGOa35YLByeQDQY+bixrW28wE9gdZEnVLeb+ohY0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sa273jt7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so13593105e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062947; x=1757667747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so/ei/Zwf4uiYOD9SARxwrfwJo9mF5tdxWABKFHMvPE=;
        b=Sa273jt7Wp8QURf5JUMEu4+htmGbEQdUx3rhe5UplxJb5XBFpkqKC3A/sLIMiVAy52
         HSG6Zl7AWAS72n/SUmm4tJwbFkL+C0wuvpoDi9VT0u6eMBPCjWl4dcNIwJFvJJ7lbZhN
         7aLNrrElC7MkiOxc8c1cs8l6RfnoEGm4Yml+ddQFuHQ3xddXFTOK/KHci2Xa7K5wyiFD
         BJp5MNTUM1bzZ5rNHXNMXVx9uAJ/HjmXSWsAXLkOyJ4AveHwBY1b47AjCzG287KTRzqX
         Pc70oPFFQGuiMLXjfljeBiOWK/lbvt1spd8WC/RdAYi+z6M+cn3Vcg2TG8XZSL1uDSVO
         Im2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062947; x=1757667747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so/ei/Zwf4uiYOD9SARxwrfwJo9mF5tdxWABKFHMvPE=;
        b=TghytJ+QgP+XZqYjAU18xLKgUatJC5vHiC8sBxxwbVmMwuWLOp0qqmWu1kfNe21KCv
         GDJKo3T/qJW/Uwj06WFhbsNzcJTXWPYR2pHKVCkSBj7DIx8VW4VQGfdL9ojbexmXfW47
         AF4BVmg1dzLYSnRuGkp7G7wXgAg3vfT6WKAzxrH3pxXQUpyC9qXBFkjt3QXM+QiKN2d1
         SIDQB7mDR2g63je1l1Cev+aVUGjrS/zHIYIClrUCqShnhy46QX0jN7W8LbO+in1stnvu
         MzEPJd6H+ptZ4MTHXg4e0QcoOrSCUegzwLypGPebGwDjp5bq5Fa3VfTHQAgNNZXPrE5R
         SAGA==
X-Gm-Message-State: AOJu0YzPaZFCx8oowg3U8E6SATsj2iHgR/IB0TGUDNggs3cRpQM2LhBX
	27rSbFPAmFjGKDOTsX/9UfWZ1diShcMN4I7cITcuVp7cz+pLBGd8TUu/j1PyjARhY2f+5jqopaN
	HKVfn
X-Gm-Gg: ASbGncsvPqpTui3BEU612HyJOF4i9IntnqiKvrxSmLBmhAXUHTQLGl+80gSjECASP/7
	sDmCeDjU+9zlLmmTWGQsM0qXfTAS/s4DOijwAclu3U7mYfq8R6GNd+9xc670Rps0J+uNygn+ko7
	W7Q7YzqCCf2KgojGJxfWtHpfISPIxpo2QLirOCwb5M5m9S+22S+O9wNWBXXA+XNPr6oGTyeo6z5
	sKBv1WTcEyz6wbopaTdWr34eUaDUvXdhZit6FhUbSXg0KLOmg4fzKFwy6JhQuaiNOEbqZ+gNt4L
	Wzk/wWDQTfTt9070XLMLR6w2YM9wVPXE+2u4Cbxe+ESGE+2Ib9rlQ/3/20AIaQpHhMNaA+seOuj
	KqQWBSWFry94+5K9U5H8pxBtY8vHxNHacLH1Bel3s8vpSmJM=
X-Google-Smtp-Source: AGHT+IGRHRMGSvM+wo1T01vbYlD+RFgUW7bFF5vWopmhgt8kELX5Ze7cGpuSkPQ4KMXV8c1lzb9vgQ==
X-Received: by 2002:a05:600c:3b8c:b0:45c:b53e:331e with SMTP id 5b1f17b1804b1-45cb53e3394mr79627345e9.7.1757062947127;
        Fri, 05 Sep 2025 02:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35324565e9.5.2025.09.05.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:02:26 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/3] fs: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:02:12 +0200
Message-ID: <20250905090214.102375-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090214.102375-1-marco.crivellari@suse.com>
References: <20250905090214.102375-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/afs/callback.c                |  4 ++--
 fs/afs/write.c                   |  2 +-
 fs/bcachefs/btree_write_buffer.c |  2 +-
 fs/bcachefs/io_read.c            | 12 ++++++------
 fs/bcachefs/journal_io.c         |  2 +-
 fs/btrfs/block-group.c           |  2 +-
 fs/btrfs/extent_map.c            |  2 +-
 fs/btrfs/space-info.c            |  4 ++--
 fs/btrfs/zoned.c                 |  2 +-
 fs/ext4/mballoc.c                |  2 +-
 fs/netfs/objects.c               |  2 +-
 fs/netfs/read_collect.c          |  2 +-
 fs/netfs/write_collect.c         |  2 +-
 fs/nfsd/filecache.c              |  2 +-
 fs/notify/mark.c                 |  4 ++--
 fs/quota/dquot.c                 |  2 +-
 16 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 69e1dd55b160..894d2bad6b6c 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -42,7 +42,7 @@ static void afs_volume_init_callback(struct afs_volume *volume)
 	list_for_each_entry(vnode, &volume->open_mmaps, cb_mmap_link) {
 		if (vnode->cb_v_check != atomic_read(&volume->cb_v_break)) {
 			afs_clear_cb_promise(vnode, afs_cb_promise_clear_vol_init_cb);
-			queue_work(system_unbound_wq, &vnode->cb_work);
+			queue_work(system_dfl_wq, &vnode->cb_work);
 		}
 	}
 
@@ -90,7 +90,7 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 		if (reason != afs_cb_break_for_deleted &&
 		    vnode->status.type == AFS_FTYPE_FILE &&
 		    atomic_read(&vnode->cb_nr_mmap))
-			queue_work(system_unbound_wq, &vnode->cb_work);
+			queue_work(system_dfl_wq, &vnode->cb_work);
 
 		trace_afs_cb_break(&vnode->fid, vnode->cb_break, reason, true);
 	} else {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 18b0a9f1615e..fe3421435e05 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -172,7 +172,7 @@ static void afs_issue_write_worker(struct work_struct *work)
 void afs_issue_write(struct netfs_io_subrequest *subreq)
 {
 	subreq->work.func = afs_issue_write_worker;
-	if (!queue_work(system_unbound_wq, &subreq->work))
+	if (!queue_work(system_dfl_wq, &subreq->work))
 		WARN_ON_ONCE(1);
 }
 
diff --git a/fs/bcachefs/btree_write_buffer.c b/fs/bcachefs/btree_write_buffer.c
index adbe576ec77e..8b9cd4cfd488 100644
--- a/fs/bcachefs/btree_write_buffer.c
+++ b/fs/bcachefs/btree_write_buffer.c
@@ -822,7 +822,7 @@ int bch2_journal_keys_to_write_buffer_end(struct bch_fs *c, struct journal_keys_
 
 	if (bch2_btree_write_buffer_should_flush(c) &&
 	    __bch2_write_ref_tryget(c, BCH_WRITE_REF_btree_write_buffer) &&
-	    !queue_work(system_unbound_wq, &c->btree_write_buffer.flush_work))
+	    !queue_work(system_dfl_wq, &c->btree_write_buffer.flush_work))
 		bch2_write_ref_put(c, BCH_WRITE_REF_btree_write_buffer);
 
 	if (dst->wb == &wb->flushing)
diff --git a/fs/bcachefs/io_read.c b/fs/bcachefs/io_read.c
index 417bb0c7bbfa..1b05ad45220c 100644
--- a/fs/bcachefs/io_read.c
+++ b/fs/bcachefs/io_read.c
@@ -553,7 +553,7 @@ static void bch2_rbio_error(struct bch_read_bio *rbio,
 
 	if (bch2_err_matches(ret, BCH_ERR_data_read_retry)) {
 		bch2_rbio_punt(rbio, bch2_rbio_retry,
-			       RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+			       RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 	} else {
 		rbio = bch2_rbio_free(rbio);
 
@@ -833,13 +833,13 @@ static void __bch2_read_endio(struct work_struct *work)
 	memalloc_nofs_restore(nofs_flags);
 	return;
 csum_err:
-	bch2_rbio_punt(rbio, bch2_read_csum_err, RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+	bch2_rbio_punt(rbio, bch2_read_csum_err, RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 	goto out;
 decompression_err:
-	bch2_rbio_punt(rbio, bch2_read_decompress_err, RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+	bch2_rbio_punt(rbio, bch2_read_decompress_err, RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 	goto out;
 decrypt_err:
-	bch2_rbio_punt(rbio, bch2_read_decrypt_err, RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+	bch2_rbio_punt(rbio, bch2_read_decrypt_err, RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 	goto out;
 }
 
@@ -859,7 +859,7 @@ static void bch2_read_endio(struct bio *bio)
 		rbio->bio.bi_end_io = rbio->end_io;
 
 	if (unlikely(bio->bi_status)) {
-		bch2_rbio_punt(rbio, bch2_read_io_err, RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+		bch2_rbio_punt(rbio, bch2_read_io_err, RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 		return;
 	}
 
@@ -878,7 +878,7 @@ static void bch2_read_endio(struct bio *bio)
 	    rbio->promote ||
 	    crc_is_compressed(rbio->pick.crc) ||
 	    bch2_csum_type_is_encryption(rbio->pick.crc.csum_type))
-		context = RBIO_CONTEXT_UNBOUND,	wq = system_unbound_wq;
+		context = RBIO_CONTEXT_UNBOUND,	wq = system_dfl_wq;
 	else if (rbio->pick.crc.csum_type)
 		context = RBIO_CONTEXT_HIGHPRI,	wq = system_highpri_wq;
 
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 1b7961f4f609..298be7748e99 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1256,7 +1256,7 @@ int bch2_journal_read(struct bch_fs *c,
 		    percpu_ref_tryget(&ca->io_ref[READ]))
 			closure_call(&ca->journal.read,
 				     bch2_journal_read_device,
-				     system_unbound_wq,
+				     system_dfl_wq,
 				     &jlist.cl);
 		else
 			degraded = true;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a8129f1ce78c..eb25a4acd54d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2026,7 +2026,7 @@ void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
 	btrfs_reclaim_sweep(fs_info);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (!list_empty(&fs_info->reclaim_bgs))
-		queue_work(system_unbound_wq, &fs_info->reclaim_bgs_work);
+		queue_work(system_dfl_wq, &fs_info->reclaim_bgs_work);
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 7f46abbd6311..812823b93b66 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1373,7 +1373,7 @@ void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	if (atomic64_cmpxchg(&fs_info->em_shrinker_nr_to_scan, 0, nr_to_scan) != 0)
 		return;
 
-	queue_work(system_unbound_wq, &fs_info->em_shrinker_work);
+	queue_work(system_dfl_wq, &fs_info->em_shrinker_work);
 }
 
 void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ff089e3e4103..719d8d13d63e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1764,7 +1764,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 							  space_info->flags,
 							  orig_bytes, flush,
 							  "enospc");
-				queue_work(system_unbound_wq, async_work);
+				queue_work(system_dfl_wq, async_work);
 			}
 		} else {
 			list_add_tail(&ticket.list,
@@ -1781,7 +1781,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		    need_preemptive_reclaim(fs_info, space_info)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
-			queue_work(system_unbound_wq,
+			queue_work(system_dfl_wq,
 				   &fs_info->preempt_reclaim_work);
 		}
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fb8b8b29c169..7ab51a1e857e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2429,7 +2429,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 	atomic_inc(&eb->refs);
 	bg->last_eb = eb;
 	INIT_WORK(&bg->zone_finish_work, btrfs_zone_finish_endio_workfn);
-	queue_work(system_unbound_wq, &bg->zone_finish_work);
+	queue_work(system_dfl_wq, &bg->zone_finish_work);
 }
 
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0d523e9fb3d5..689950520e28 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3927,7 +3927,7 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 		list_splice_tail(&freed_data_list, &sbi->s_discard_list);
 		spin_unlock(&sbi->s_md_lock);
 		if (wake)
-			queue_work(system_unbound_wq, &sbi->s_discard_work);
+			queue_work(system_dfl_wq, &sbi->s_discard_work);
 	} else {
 		list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
 			kmem_cache_free(ext4_free_data_cachep, entry);
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index dc6b41ef18b0..da9cf4747728 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -159,7 +159,7 @@ void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
 		if (dead) {
 			if (was_async) {
 				rreq->work.func = netfs_free_request;
-				if (!queue_work(system_unbound_wq, &rreq->work))
+				if (!queue_work(system_dfl_wq, &rreq->work))
 					WARN_ON(1);
 			} else {
 				netfs_free_request(&rreq->work);
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 23c75755ad4e..3f64a9f6c688 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -474,7 +474,7 @@ void netfs_wake_read_collector(struct netfs_io_request *rreq)
 	    !test_bit(NETFS_RREQ_RETRYING, &rreq->flags)) {
 		if (!work_pending(&rreq->work)) {
 			netfs_get_request(rreq, netfs_rreq_trace_get_work);
-			if (!queue_work(system_unbound_wq, &rreq->work))
+			if (!queue_work(system_dfl_wq, &rreq->work))
 				netfs_put_request(rreq, true, netfs_rreq_trace_put_work_nq);
 		}
 	} else {
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 3fca59e6475d..7ef3859e36d0 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -451,7 +451,7 @@ void netfs_wake_write_collector(struct netfs_io_request *wreq, bool was_async)
 {
 	if (!work_pending(&wreq->work)) {
 		netfs_get_request(wreq, netfs_rreq_trace_get_work);
-		if (!queue_work(system_unbound_wq, &wreq->work))
+		if (!queue_work(system_dfl_wq, &wreq->work))
 			netfs_put_request(wreq, was_async, netfs_rreq_trace_put_work_nq);
 	}
 }
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ab85e6a2454f..910fde3240a9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -113,7 +113,7 @@ static void
 nfsd_file_schedule_laundrette(void)
 {
 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
+		queue_delayed_work(system_dfl_wq, &nfsd_filecache_laundrette,
 				   NFSD_LAUNDRETTE_DELAY);
 }
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d7..55a03bb05aa1 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -428,7 +428,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		conn->destroy_next = connector_destroy_list;
 		connector_destroy_list = conn;
 		spin_unlock(&destroy_lock);
-		queue_work(system_unbound_wq, &connector_reaper_work);
+		queue_work(system_dfl_wq, &connector_reaper_work);
 	}
 	/*
 	 * Note that we didn't update flags telling whether inode cares about
@@ -439,7 +439,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	spin_lock(&destroy_lock);
 	list_add(&mark->g_list, &destroy_list);
 	spin_unlock(&destroy_lock);
-	queue_delayed_work(system_unbound_wq, &reaper_work,
+	queue_delayed_work(system_dfl_wq, &reaper_work,
 			   FSNOTIFY_REAPER_DELAY);
 }
 EXPORT_SYMBOL_GPL(fsnotify_put_mark);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 825c5c2e0962..39d9756a9cef 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -881,7 +881,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(system_dfl_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
-- 
2.51.0


