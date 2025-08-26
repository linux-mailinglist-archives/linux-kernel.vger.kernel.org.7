Return-Path: <linux-kernel+bounces-786860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E737FB36D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE3563CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7A231A21;
	Tue, 26 Aug 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nYTQ268J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nYTQ268J"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB49265CB3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220191; cv=none; b=sl3p37deQZaBFy9m+msWXnS1KwqbaxSe2NS4qLphfShMkh1zZZAmzXbRtDJ6lFfLElePunh99+ZDOK5Ud1wcM2yZSiYts0fIhQ/nX2baGC8a6Xjse9pjZXwHx+aLbbV8ZG+kz5/QMohA7Jch5cN3s6maiZFmQOzCApRXbrBV2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220191; c=relaxed/simple;
	bh=E43UQldvPIXJQkXye2xOeDjT5ILlUuBjtUd7Y9Fa22U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUW+vl7DFChdmE0lVBX8YaoESCwi2timinj1aY/DRCBa4pZXKH1I96qO2CF9+WnKnloVL6yvUxWU2ogSy8ZwtU46QkJ7l2sC5kZYvCB0iDtiUxF9j+6WpIvGoV12nefR1kmd4BeXSdPB1IEPkwYDY6qvFCbaHqo1lmvCRE9H1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nYTQ268J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nYTQ268J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B76F1F38F;
	Tue, 26 Aug 2025 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756220188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GwQoxtVyUUAfeaSlxLGfKSMF6Xm2EeIRDK2kD9x/0s=;
	b=nYTQ268JOuUNC2VcmCgObTdtpXGddY/9lgjHWgC2DcPcigetNUkmCu3YW5r+wUPBv6PU5H
	heDvZsh8TahnSPvJwG7ZH40vhyuc2OYPxA3LYH874dIMYWW/LcNli5XSPhlNzCHOJEPTer
	ozp/hrz3f5glM1IkGOJ8nIm8+VVQmGg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756220188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GwQoxtVyUUAfeaSlxLGfKSMF6Xm2EeIRDK2kD9x/0s=;
	b=nYTQ268JOuUNC2VcmCgObTdtpXGddY/9lgjHWgC2DcPcigetNUkmCu3YW5r+wUPBv6PU5H
	heDvZsh8TahnSPvJwG7ZH40vhyuc2OYPxA3LYH874dIMYWW/LcNli5XSPhlNzCHOJEPTer
	ozp/hrz3f5glM1IkGOJ8nIm8+VVQmGg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D646813A31;
	Tue, 26 Aug 2025 14:56:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OwveMhvLrWjDTwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 26 Aug 2025 14:56:27 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 3/3] drivers/xen/gntdev: use xen_pv_domain() instead of cached value
Date: Tue, 26 Aug 2025 16:56:08 +0200
Message-ID: <20250826145608.10352-4-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826145608.10352-1-jgross@suse.com>
References: <20250826145608.10352-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Eliminate the use_ptemod variable by replacing its use cases with
xen_pv_domain().

Instead of passing the xen_pv_domain() return value to
gntdev_ioctl_dmabuf_exp_from_refs(), use xen_pv_domain() in that
function.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/gntdev-dmabuf.c |  7 +++----
 drivers/xen/gntdev-dmabuf.h |  2 +-
 drivers/xen/gntdev.c        | 33 ++++++++++++++-------------------
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 82855105ab85..550980dd3b0b 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -720,16 +720,15 @@ static void dmabuf_imp_release_all(struct gntdev_dmabuf_priv *priv)
 
 /* DMA buffer IOCTL support. */
 
-long gntdev_ioctl_dmabuf_exp_from_refs(struct gntdev_priv *priv, int use_ptemod,
+long gntdev_ioctl_dmabuf_exp_from_refs(struct gntdev_priv *priv,
 				       struct ioctl_gntdev_dmabuf_exp_from_refs __user *u)
 {
 	struct ioctl_gntdev_dmabuf_exp_from_refs op;
 	u32 *refs;
 	long ret;
 
-	if (use_ptemod) {
-		pr_debug("Cannot provide dma-buf: use_ptemode %d\n",
-			 use_ptemod);
+	if (xen_pv_domain()) {
+		pr_debug("Cannot provide dma-buf in a PV domain\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/xen/gntdev-dmabuf.h b/drivers/xen/gntdev-dmabuf.h
index 3d9b9cf9d5a1..9adf96ac74d3 100644
--- a/drivers/xen/gntdev-dmabuf.h
+++ b/drivers/xen/gntdev-dmabuf.h
@@ -18,7 +18,7 @@ struct gntdev_dmabuf_priv *gntdev_dmabuf_init(struct file *filp);
 
 void gntdev_dmabuf_fini(struct gntdev_dmabuf_priv *priv);
 
-long gntdev_ioctl_dmabuf_exp_from_refs(struct gntdev_priv *priv, int use_ptemod,
+long gntdev_ioctl_dmabuf_exp_from_refs(struct gntdev_priv *priv,
 				       struct ioctl_gntdev_dmabuf_exp_from_refs __user *u);
 
 long gntdev_ioctl_dmabuf_exp_wait_released(struct gntdev_priv *priv,
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 74491967f2ae..91ba5078c9d9 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -73,9 +73,6 @@ module_param(limit, uint, 0644);
 MODULE_PARM_DESC(limit,
 	"Maximum number of grants that may be mapped by one mapping request");
 
-/* True in PV mode, false otherwise */
-static int use_ptemod;
-
 static void unmap_grant_pages(struct gntdev_grant_map *map,
 			      int offset, int pages);
 
@@ -163,7 +160,7 @@ struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
 	    NULL == add->pages     ||
 	    NULL == add->being_removed)
 		goto err;
-	if (use_ptemod) {
+	if (xen_pv_domain()) {
 		add->kmap_ops   = kvmalloc_array(count, sizeof(add->kmap_ops[0]),
 						 GFP_KERNEL);
 		add->kunmap_ops = kvmalloc_array(count, sizeof(add->kunmap_ops[0]),
@@ -211,7 +208,7 @@ struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
 		add->grants[i].ref = INVALID_GRANT_REF;
 		add->map_ops[i].handle = INVALID_GRANT_HANDLE;
 		add->unmap_ops[i].handle = INVALID_GRANT_HANDLE;
-		if (use_ptemod) {
+		if (xen_pv_domain()) {
 			add->kmap_ops[i].handle = INVALID_GRANT_HANDLE;
 			add->kunmap_ops[i].handle = INVALID_GRANT_HANDLE;
 		}
@@ -268,7 +265,7 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 	if (!refcount_dec_and_test(&map->users))
 		return;
 
-	if (map->pages && !use_ptemod) {
+	if (map->pages && !xen_pv_domain()) {
 		/*
 		 * Increment the reference count.  This ensures that the
 		 * subsequent call to unmap_grant_pages() will not wind up
@@ -298,7 +295,7 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 		 */
 	}
 
-	if (use_ptemod && map->notifier_init)
+	if (xen_pv_domain() && map->notifier_init)
 		mmu_interval_notifier_remove(&map->notifier);
 
 	if (map->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
@@ -334,7 +331,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 	size_t alloced = 0;
 	int i, err = 0;
 
-	if (!use_ptemod) {
+	if (!xen_pv_domain()) {
 		/* Note: it could already be mapped */
 		if (map->map_ops[0].handle != INVALID_GRANT_HANDLE)
 			return 0;
@@ -389,7 +386,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 		if (map->flags & GNTMAP_device_map)
 			map->unmap_ops[i].dev_bus_addr = map->map_ops[i].dev_bus_addr;
 
-		if (use_ptemod) {
+		if (xen_pv_domain()) {
 			if (map->kmap_ops[i].status == GNTST_okay) {
 				alloced++;
 				map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
@@ -421,7 +418,7 @@ static void __unmap_grant_pages_done(int result,
 			map->unmap_ops[offset+i].handle,
 			map->unmap_ops[offset+i].status);
 		map->unmap_ops[offset+i].handle = INVALID_GRANT_HANDLE;
-		if (use_ptemod) {
+		if (xen_pv_domain()) {
 			if (map->kunmap_ops[offset + i].status == GNTST_okay &&
 			    map->kunmap_ops[offset + i].handle != INVALID_GRANT_HANDLE)
 				successful_unmaps++;
@@ -464,7 +461,7 @@ static void __unmap_grant_pages(struct gntdev_grant_map *map, int offset,
 	}
 
 	map->unmap_data.unmap_ops = map->unmap_ops + offset;
-	map->unmap_data.kunmap_ops = use_ptemod ? map->kunmap_ops + offset : NULL;
+	map->unmap_data.kunmap_ops = xen_pv_domain() ? map->kunmap_ops + offset : NULL;
 	map->unmap_data.pages = map->pages + offset;
 	map->unmap_data.count = pages;
 	map->unmap_data.done = __unmap_grant_pages_done;
@@ -1039,7 +1036,7 @@ static long gntdev_ioctl(struct file *flip,
 
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
 	case IOCTL_GNTDEV_DMABUF_EXP_FROM_REFS:
-		return gntdev_ioctl_dmabuf_exp_from_refs(priv, use_ptemod, ptr);
+		return gntdev_ioctl_dmabuf_exp_from_refs(priv, ptr);
 
 	case IOCTL_GNTDEV_DMABUF_EXP_WAIT_RELEASED:
 		return gntdev_ioctl_dmabuf_exp_wait_released(priv, ptr);
@@ -1086,7 +1083,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 
 	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP | VM_MIXEDMAP);
 
-	if (use_ptemod)
+	if (xen_pv_domain())
 		vm_flags_set(vma, VM_DONTCOPY);
 
 	vma->vm_private_data = map;
@@ -1102,7 +1099,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 
 	map->pages_vm_start = vma->vm_start;
 
-	if (use_ptemod) {
+	if (xen_pv_domain()) {
 		err = mmu_interval_notifier_insert_locked(
 			&map->notifier, vma->vm_mm, vma->vm_start,
 			vma->vm_end - vma->vm_start, &gntdev_mmu_ops);
@@ -1113,7 +1110,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	}
 	mutex_unlock(&priv->lock);
 
-	if (use_ptemod) {
+	if (xen_pv_domain()) {
 		/*
 		 * gntdev takes the address of the PTE in find_grant_ptes() and
 		 * passes it to the hypervisor in gntdev_map_grant_pages(). The
@@ -1139,7 +1136,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	if (err)
 		goto out_put_map;
 
-	if (!use_ptemod) {
+	if (!xen_pv_domain()) {
 		err = vm_map_pages_zero(vma, map->pages, map->count);
 		if (err)
 			goto out_put_map;
@@ -1154,7 +1151,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 out_unlock_put:
 	mutex_unlock(&priv->lock);
 out_put_map:
-	if (use_ptemod)
+	if (xen_pv_domain())
 		unmap_grant_pages(map, 0, map->count);
 	gntdev_put_map(priv, map);
 	return err;
@@ -1183,8 +1180,6 @@ static int __init gntdev_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
-	use_ptemod = xen_pv_domain();
-
 	err = misc_register(&gntdev_miscdev);
 	if (err != 0) {
 		pr_err("Could not register gntdev device\n");
-- 
2.43.0


