Return-Path: <linux-kernel+bounces-860034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF94BEF2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73F32348BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4C29B233;
	Mon, 20 Oct 2025 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awt91vO4"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70529B777
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930241; cv=none; b=of7Httg75dz+qbMHjbagPGE3hXBxWla38udKm0DcajMQ9ruTxaN7yoIQCii3JerSbUUxoiumlWfNPIGIYtIjwEAqumXiE7qp4FLDdmKFym2oU9P5OvnchxFGtZRJj8VUke5FkxsLRTa/30QE6fg06cQTrlh72CVKwqnp5IVwAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930241; c=relaxed/simple;
	bh=sTyjq4lpHpE1Tag4v7BrWtTUyfVl+9Yq5BWJCJuucZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoN0BQku0yhrFtK7CS3VRv+jGu7WagTxZPSl+s2zBaqUO+/Ccq45TupZpvM10YSkTTgYy/THTXIeiauuOS1mr5kYFtEjadc5y1mr3gG2lVY/P8d856mT6lRtS7t21vq/ns1IPRb9WpCosyo5xQ/BSORbei7pywPLb26MfL3vBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awt91vO4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29292eca5dbso7383445ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930239; x=1761535039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYdtRER+63D5fwP+dPFGkrD4tSBc+ZR0Nj1GwO3r8rs=;
        b=awt91vO4bDyg6BC107x/vOpmB4wLxzVF5dNdNwcXwB124WZfBJizAS5Aaj/gJT9JiS
         YVQ1nsRzSgPSdnMK88ewCrWVir/xYtIsBAuyjylfWLakwJGz+p1LiEAj0jgx3ABX5xbW
         bfatyQq/Xcldh5nDu3Nb6n6PPiShCwNJ8oxfLQ7gViOcUtAMAHQd2xBHJfzvG2wTTDme
         0NxGKsf3S4h2vQQRRekqtt+ceS4jpUVbBW7p0odDSzTZQgaHS0+pS5ikSvCF6v7xN1lA
         Mdo2I3LMlgv2riILDHWoAdSi7pg51rPn6JGdtFu4dzRRkANHgq3VmqbpMIpTFw9FB/8I
         eNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930239; x=1761535039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYdtRER+63D5fwP+dPFGkrD4tSBc+ZR0Nj1GwO3r8rs=;
        b=EZFwpP4vqJIDiGcdJKdjpcOLcE/+jm4zu03q7T/57VQE32W31TqFHSZS6I3Fx5oMEM
         zKmfHt0/weRiGhnTjN9zufEn+rl3lQZSKI9dkOv6dWFcdc2tYgRC95BYIgQCILkFDDjk
         1UVw4YCN+iW3VQyCa1BVkjx7WHAPW+jmgC1HgW/IclMIFfIoLKJ5XqAyiJoizaKu2F4v
         k4n+pLD96kAtBI4POIsQ22gshluixvDSRXVhkgTqC70xQcin6a4igRPi5KMwflNn/q8A
         AOBrWJDSRmgO4bTrXBBtVxREinloWyS4+4B01utJ+JaHOnb/L8EGwiR8Pu4voTK0PdkC
         ZTLg==
X-Forwarded-Encrypted: i=1; AJvYcCWPewaFSlk4Kt1UjqCG4diqffrB/NAeJ3Ww9QBVDWPEOuXrrHDIbgn1sVb7KG3Zp3+D9zW0Otuw0oASmLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybArkxtP3IlgEDYUksZuSS+yazAH4Guq8bdbxRwHyqYT3qQttg
	leSc0lR3SyR3DIC4L2yQ7fIO5Pyy6qOMyK9ZTXXcCUv82QacOTq7B263
X-Gm-Gg: ASbGnctZYknlUNsTEeX6xj8FswIIQQ6D2nYf3SNeoO15btD390L1i++r1g1Su9UTOwx
	9LQ4Bfjoluv7ZJK/tAC178JspwUR3JdLgAN2tsZFCJeusYuWLEbMXdLhrm0e6zAZYCBu4rJt8rK
	cyRogGH+7gj2YbKrs5ySEgwnwMufbxMVXSlIWfk6IrDIbJr36e3F70zoiLjZ4E5mqvdiK1qbwDx
	Kg8aRIXAfEVVe67Ybf+rt0EAyTJnCLhIj/WYDI8+Bj7NZnrIvObw58i3wx0QH/iDVPel5mVS2YV
	WarBglcCoqZlROTQ0N0O9rpPCPpC+uIG7do/Z23eLechBoH7tJmui9D+wV71+jfH083r7g73B4/
	55ix8ZTcwkbi5SxKxyNupBzVGBEI04PcGCh2P63fLtBttOD6bXrzNK2Km7/qmOFEjJrxn0PZtFg
	e/mVerVxZrAWgIu3E1W7goiPLdPADMybrqapwHcmDroBvvbQ==
X-Google-Smtp-Source: AGHT+IGo/kUBmmZVSBiCCtDWJPQhX6W2PzXxnBQ3p+r5Rs/M8lNok3r/Ez1M0M2GbDWgxzLf0C8R3g==
X-Received: by 2002:a17:902:dac5:b0:267:6754:8fd9 with SMTP id d9443c01a7336-290ca216ad6mr166008035ad.39.1760930238858;
        Sun, 19 Oct 2025 20:17:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:3815:5989:6e28:9b6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fddfesm66373435ad.88.2025.10.19.20.17.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:17:18 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 mm-new 06/10] mm: bpf-thp: add support for global mode
Date: Mon, 20 Oct 2025 11:16:51 +0800
Message-Id: <20251020031655.1093-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251020031655.1093-1-laoar.shao@gmail.com>
References: <20251020031655.1093-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-process BPF-THP mode is unsuitable for managing shared resources
such as shmem THP and file-backed THP. This aligns with known cgroup
limitations for similar scenarios [0].

Introduce a global BPF-THP mode to address this gap. When registered:
- All existing per-process instances are disabled
- New per-process registrations are blocked
- Existing per-process instances remain registered (no forced unregistration)

The global mode takes precedence over per-process instances. Updates are
type-isolated: global instances can only be updated by new global
instances, and per-process instances by new per-process instances.

Link: https://lore.kernel.org/linux-mm/YwNold0GMOappUxc@slm.duckdns.org/ [0]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/huge_memory_bpf.c | 109 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
index e8894c10d1d9..cad1ca6f59a4 100644
--- a/mm/huge_memory_bpf.c
+++ b/mm/huge_memory_bpf.c
@@ -33,6 +33,28 @@ struct bpf_thp_ops {
 };
 
 static DEFINE_SPINLOCK(thp_ops_lock);
+static struct bpf_thp_ops __rcu *bpf_thp_global; /* global mode */
+
+static unsigned long
+bpf_hook_thp_get_orders_global(struct vm_area_struct *vma,
+			       enum tva_type type,
+			       unsigned long orders)
+{
+	thp_order_fn_t *bpf_hook_thp_get_order;
+	int bpf_order;
+
+	rcu_read_lock();
+	bpf_hook_thp_get_order = rcu_dereference(bpf_thp_global->thp_get_order);
+	if (!bpf_hook_thp_get_order)
+		goto out;
+
+	bpf_order = bpf_hook_thp_get_order(vma, type, orders);
+	orders &= BIT(bpf_order);
+
+out:
+	rcu_read_unlock();
+	return orders;
+}
 
 unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
 				      enum tva_type type,
@@ -45,6 +67,10 @@ unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
 	if (!mm)
 		return orders;
 
+	/* Global BPF-THP takes precedence over per-process BPF-THP. */
+	if (rcu_access_pointer(bpf_thp_global))
+		return bpf_hook_thp_get_orders_global(vma, type, orders);
+
 	rcu_read_lock();
 	bpf_thp = rcu_dereference(mm->bpf_mm.bpf_thp);
 	if (!bpf_thp || !bpf_thp->thp_get_order)
@@ -177,6 +203,23 @@ static int bpf_thp_init_member(const struct btf_type *t,
 	return 0;
 }
 
+static int bpf_thp_reg_gloabl(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *ops = kdata;
+
+	/* Protect the global pointer bpf_thp_global from concurrent writes. */
+	spin_lock(&thp_ops_lock);
+	/* Only one instance is allowed. */
+	if (rcu_access_pointer(bpf_thp_global)) {
+		spin_unlock(&thp_ops_lock);
+		return -EBUSY;
+	}
+
+	rcu_assign_pointer(bpf_thp_global, ops);
+	spin_unlock(&thp_ops_lock);
+	return 0;
+}
+
 static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_thp_ops *bpf_thp = kdata;
@@ -187,6 +230,11 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 	pid_t pid;
 
 	pid = bpf_thp->pid;
+
+	/* Fallback to global mode if pid is not set. */
+	if (!pid)
+		return bpf_thp_reg_gloabl(kdata, link);
+
 	p = find_get_task_by_vpid(pid);
 	if (!p)
 		return -ESRCH;
@@ -207,8 +255,10 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 	 * might register this task simultaneously.
 	 */
 	spin_lock(&thp_ops_lock);
-	/* Each process is exclusively managed by a single BPF-THP. */
-	if (rcu_access_pointer(mm->bpf_mm.bpf_thp))
+	/* Each process is exclusively managed by a single BPF-THP.
+	 * Global mode disables per-process instances.
+	 */
+	if (rcu_access_pointer(mm->bpf_mm.bpf_thp) || rcu_access_pointer(bpf_thp_global))
 		goto out_lock;
 	err = 0;
 	rcu_assign_pointer(mm->bpf_mm.bpf_thp, bpf_thp);
@@ -224,12 +274,33 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 	return err;
 }
 
+static void bpf_thp_unreg_global(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *bpf_thp;
+
+	spin_lock(&thp_ops_lock);
+	if (!rcu_access_pointer(bpf_thp_global)) {
+		spin_unlock(&thp_ops_lock);
+		return;
+	}
+
+	bpf_thp = rcu_replace_pointer(bpf_thp_global, NULL,
+				      lockdep_is_held(&thp_ops_lock));
+	WARN_ON_ONCE(!bpf_thp);
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+}
+
 static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_thp_ops *bpf_thp = kdata;
 	struct bpf_mm_ops *bpf_mm;
 	struct list_head *pos, *n;
 
+	if (!bpf_thp->pid)
+		return bpf_thp_unreg_global(kdata, link);
+
 	spin_lock(&thp_ops_lock);
 	list_for_each_safe(pos, n, &bpf_thp->mm_list) {
 		bpf_mm = list_entry(pos, struct bpf_mm_ops, bpf_thp_list);
@@ -242,6 +313,31 @@ static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
 	synchronize_rcu();
 }
 
+static int bpf_thp_update_global(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *old_bpf_thp = old_kdata;
+	struct bpf_thp_ops *bpf_thp = kdata;
+	struct bpf_thp_ops *old_global;
+
+	if (!old_bpf_thp || !bpf_thp)
+		return -EINVAL;
+
+	spin_lock(&thp_ops_lock);
+	/* BPF-THP global instance has already been removed. */
+	if (!rcu_access_pointer(bpf_thp_global)) {
+		spin_unlock(&thp_ops_lock);
+		return -ENOENT;
+	}
+
+	old_global = rcu_replace_pointer(bpf_thp_global, bpf_thp,
+					 lockdep_is_held(&thp_ops_lock));
+	WARN_ON_ONCE(!old_global);
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+	return 0;
+}
+
 static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
 {
 	struct bpf_thp_ops *old_bpf_thp = old_kdata;
@@ -249,6 +345,15 @@ static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
 	struct bpf_mm_ops *bpf_mm;
 	struct list_head *pos, *n;
 
+	/* Updates are confined to instances of the same scope:
+	 * global to global, process-local to process-local.
+	 */
+	if (!!old_bpf_thp->pid != !!bpf_thp->pid)
+		return -EINVAL;
+
+	if (!old_bpf_thp->pid)
+		return bpf_thp_update_global(kdata, old_kdata, link);
+
 	INIT_LIST_HEAD(&bpf_thp->mm_list);
 
 	/* Could be optimized to a per-instance lock if this lock becomes a bottleneck. */
-- 
2.47.3


