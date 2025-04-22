Return-Path: <linux-kernel+bounces-613448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA29A95CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B565A3B8F28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2E1B3935;
	Tue, 22 Apr 2025 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY8coCPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC317A2ED;
	Tue, 22 Apr 2025 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294837; cv=none; b=BHrUGllz8pIABriPcMVnTjQf99qRfYTojGrYw1/7d91X/c1jsvCmzVdZJZmUsGJ3G/BUI39qJ9OgV5uWt9DezQoKKPUF4XmEkDTTtAr4ap5QZGgznc5UDQz9dMwbz01i4L3wP+NovYRTjeQHWFbFBK6gZfKfjUsBnQi6FqJYBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294837; c=relaxed/simple;
	bh=HT6/2/GedgWpF6igAvBUqPc/BsGvXccamOg4GedgCHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RaEGOoX8SRR05+GGfW/iDu1VC0LeN+RqnnqYV8MD5fnB4LCOGIOvMRfYcfIdEUhboUfyyOOjV6cNdVm1WyNOadPWFE43DAafIWRE38ALHVoVAjmtqTO2tdYxe3FniE/qU92l7CaeCdrtgVoqEf/AeYvEQBvKSeB5flkmLG3lGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY8coCPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35088C4CEED;
	Tue, 22 Apr 2025 04:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745294837;
	bh=HT6/2/GedgWpF6igAvBUqPc/BsGvXccamOg4GedgCHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sY8coCPSNTRcdxP54pj86Tdynk5EWRGTvyu0B383gZac0j+wO+OJmKp38Wk7B8fjT
	 328vdbs1cFyZxHxMjRO99juX06mXyAsh+OvnH8AdKZzdLgd16kVxbWZIUmt+3dc+cX
	 f1N6y2yGzq1TWOmQZa61VljgnSBXx9uApvUPMN7e5L1hMDPOqmklHt/jhRDHBpiMh/
	 /k6vA+yYvurxi+Pqgm7g3CPZKt1Dx47+jEzTcajX0WQ4UrKRgwhC+0j9cVhfJZK0Ut
	 4FGWJg36hvlgR8ovpXsXprIFRpl2ucFg2R1b3stLA2fBgh4Nml4WaYGOYGpRPzW54M
	 sE13VGJiuAT0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A18C369D3;
	Tue, 22 Apr 2025 04:07:17 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 22 Apr 2025 12:07:09 +0800
Subject: [PATCH 2/7] firmware: stratix10-svc: Implement ID pool management
 for asynchronous operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-sip_svc_upstream-v1-2-088059190f31@altera.com>
References: <20250422-sip_svc_upstream-v1-0-088059190f31@altera.com>
In-Reply-To: <20250422-sip_svc_upstream-v1-0-088059190f31@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745294834; l=6225;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=5FyTpVzGBXpgVnqCoQDLP/cb2s1zL/TKwkYIX3LjCZk=;
 b=i4EG4ANlyeGOw0WqNjVz9rR2U0WauNg2IuBUPbZUTD7JTWijgffCxzkM3V6AiwtF3GXryqQJu
 f36VSJczlc3BSriYdpUlhC4XFQfPGawyORiDr0G1N4zN9BDmRk2YXxT
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

From: Mahesh Rao <mahesh.rao@altera.com>

Implement ID pool management API's which will be
used for Stratix10 Asynchronous communication with
Secure Device Manager. These API's will be used
in subsequent patches for ID management in asynchronous
operations.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/firmware/stratix10-svc.c | 191 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3d42d4b18b7299d0a9e5110159e06253dfeddf88..f487b6a7ef7b7cf7fdb4b4132d7a92b601803d8a 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -170,10 +170,201 @@ struct stratix10_svc_chan {
 	spinlock_t lock;
 };
 
+/**
+ * struct stratix10_sip_id_pool - Structure representing a pool of IDs for
+ *                                asynchronous operations.
+ * @head:         The head index of the ID pool.
+ * @size:         The total size of the ID pool.
+ * @id_mask:      Pointer to an array representing the mask of allocated IDs.
+ * @lock:         Mutex lock to protect access to the ID pool.
+ */
+struct stratix10_sip_id_pool {
+	unsigned long head;
+	unsigned long size;
+	unsigned long *id_mask;
+	struct mutex lock;
+};
+
 static LIST_HEAD(svc_ctrl);
 static LIST_HEAD(svc_data_mem);
 static DEFINE_MUTEX(svc_mem_lock);
 
+/**
+ * stratix10_id_pool_create - Create a new ID pool for Stratix10 async operation
+ * @size: The size of the ID pool to create
+ *
+ * This function allocates and initializes a new ID pool structure for
+ * Stratix10 async operations. It allocates memory for the ID pool structure
+ * and the associated bitmaps for ID management.
+ *
+ * Return: Pointer to the newly created ID pool structure, or NULL on failure.
+ */
+static struct stratix10_sip_id_pool *stratix10_id_pool_create(unsigned long size)
+{
+	struct stratix10_sip_id_pool *id_pool = NULL;
+
+	if (size == 0)
+		return NULL;
+
+	id_pool = kzalloc(sizeof(*id_pool), GFP_KERNEL);
+	if (!id_pool)
+		return NULL;
+
+	id_pool->size = size;
+
+	id_pool->id_mask = bitmap_zalloc(size, GFP_KERNEL);
+	if (!id_pool->id_mask) {
+		kfree(id_pool);
+		return NULL;
+	}
+
+	id_pool->head = 0;
+
+	mutex_init(&id_pool->lock);
+
+	return id_pool;
+}
+
+/**
+ * stratix10_id_pool_destroy - Destroy an ID pool for Stratix10 async operation
+ * @id_pool: Pointer to the ID pool structure
+ *
+ * This function destroys an ID pool for Stratix10 async operations. It first
+ * checks if the ID pool is valid, then frees the associated bitmap and the
+ * ID pool structure itself.
+ *
+ * Return: 0 on success, -EINVAL if the ID pool is invalid.
+ */
+static int stratix10_id_pool_destroy(struct stratix10_sip_id_pool *id_pool)
+{
+	if (!id_pool)
+		return -EINVAL;
+
+	mutex_lock(&id_pool->lock);
+
+	if (id_pool->id_mask)
+		bitmap_free(id_pool->id_mask);
+
+	mutex_unlock(&id_pool->lock);
+	mutex_destroy(&id_pool->lock);
+
+	kfree(id_pool);
+
+	return 0;
+}
+
+/**
+ * stratix10_reserve_id - Reserve an ID in the ID pool
+ * @id_pool: Pointer to the ID pool structure
+ * @id: The ID to be reserved
+ *
+ * This function reserves an ID in the given ID pool. It first checks if the
+ * ID pool is valid and if the ID is within the valid range.
+ *
+ * Return:
+ * 0 on success,
+ * -EINVAL if the ID pool is invalid, the ID is out of range, or the ID is
+ * already reserved.
+ */
+static int stratix10_reserve_id(struct stratix10_sip_id_pool *id_pool, unsigned long id)
+{
+	if (!id_pool)
+		return -EINVAL;
+
+	if (id >= id_pool->size)
+		return -EINVAL;
+
+	mutex_lock(&id_pool->lock);
+
+	if (test_bit(id, id_pool->id_mask)) {
+		mutex_unlock(&id_pool->lock);
+		return -EINVAL;
+	}
+	set_bit(id, id_pool->id_mask);
+
+	mutex_unlock(&id_pool->lock);
+	return 0;
+}
+
+/**
+ * stratix10_allocate_id - Allocate an ID from the ID pool
+ * @id_pool: Pointer to the ID pool structure
+ *
+ * This function allocates an ID from the given ID pool. It searches for the
+ * next available ID in the pool, marks it as allocated, and returns it.
+ *
+ * Return:
+ * A non-negative integer representing the allocated ID on success
+ * -EINVAL if the id_pool is NULL
+ * -ENOMEM if no IDs are available in the pool
+ */
+static int stratix10_allocate_id(struct stratix10_sip_id_pool *id_pool)
+{
+	unsigned long tries = 0;
+	int id;
+
+	if (!id_pool)
+		return -EINVAL;
+
+	if (id_pool->head >= id_pool->size)
+		return -ENOMEM;
+
+	mutex_lock(&id_pool->lock);
+
+	do {
+		id_pool->head = find_next_zero_bit(id_pool->id_mask,
+						   id_pool->size, id_pool->head);
+		if (id_pool->head >= id_pool->size) {
+			id_pool->head = 0;
+			tries++;
+		}
+		/* cycle through the whole bitmap at least once*/
+	} while (tries < 2 && test_bit(id_pool->head, id_pool->id_mask));
+
+	if (tries >= 2) {
+		mutex_unlock(&id_pool->lock);
+		return -ENOMEM;
+	}
+
+	set_bit(id_pool->head, id_pool->id_mask);
+	id = id_pool->head;
+	id_pool->head = (id_pool->head + 1) % id_pool->size;
+	mutex_unlock(&id_pool->lock);
+	return id;
+}
+
+/**
+ * stratix10_deallocate_id - Deallocate an ID in the ID pool
+ * @id_pool: Pointer to the ID pool structure
+ * @id: The ID to be deallocated
+ *
+ * This function deallocates an ID in the given ID pool. It first checks if the
+ * ID pool is valid and if the ID is within the valid range.
+ *
+ * Return:
+ * 0 on success,
+ * -EINVAL if the ID pool is invalid, the ID is out of range, or the ID is
+ * not set.
+ */
+static int stratix10_deallocate_id(struct stratix10_sip_id_pool *id_pool, unsigned long id)
+{
+	if (!id_pool)
+		return -EINVAL;
+
+	if (id >= id_pool->size)
+		return -EINVAL;
+
+	mutex_lock(&id_pool->lock);
+	if (!test_bit(id, id_pool->id_mask)) {
+		mutex_unlock(&id_pool->lock);
+		return -EINVAL;
+	}
+	clear_bit(id, id_pool->id_mask);
+	mutex_unlock(&id_pool->lock);
+
+	return 0;
+}
+
 /**
  * svc_pa_to_va() - translate physical address to virtual address
  * @addr: to be translated physical address

-- 
2.35.3



