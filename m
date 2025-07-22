Return-Path: <linux-kernel+bounces-741240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422F2B0E1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB243AB4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D1327CCF0;
	Tue, 22 Jul 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX4mnIWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011727BF6C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201852; cv=none; b=K0Ch9qbZc9u1tHb+BRZZ9apAFDIudd9tRRMDhClBZ3ftoC0PHH1sMH5f0Og8QlxvCJ7CEbv8VVjUlSloKJ7jyLXR6N88Z79Y4AdRwUEJNVTgavv5bjWgdZkTaCzFahzuL3bebmzEZBrLiwP2R2+D4TWHoSWXlKGgxk8gQq+Ynzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201852; c=relaxed/simple;
	bh=e9luvZNPKoTvOkTOBa7iTO8P0AzULg40Kk4hUIZYBvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFcOrkAiGL2AK5H9/mhuqLlean+YdddeWQZAJ4eFBCel9jLUeRQEBeXkB0tqz67ftwQ8qA3eH80Pst1OvccrZmnGzAKZmy49OiPNZX363LtLRoLHm9gte03LOyV2eB6ixCU8f4+SQVnop5XtQy6nQOnxOnBvDl1DmbWb06FaN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX4mnIWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4054C4CEF6;
	Tue, 22 Jul 2025 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201852;
	bh=e9luvZNPKoTvOkTOBa7iTO8P0AzULg40Kk4hUIZYBvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MX4mnIWpdRtWdJQJ0pgh7/HeBfbvFieSuuNdP03FP5LYOW8nsYcRlh25yzCn5cmfP
	 ne4k9JhbTYXDt5tTe7dKMIcQzc5h3h/6wm0eOZJhZg/mcIgioideZjEiPaLXLzeYtS
	 ELekzVUGta84I3oRHcIY/Z3Kn3D96iKtPaRcJhQ1bb31zdoI2FLl6yGGZ4A/Ub5JQ9
	 d4ViCZpsJoaNw5nV9DPP1FtSTa7J35x7Dlm4AF2lnDFsOkv+wUyO3239IMZ4i74enw
	 SA5InfW4R5bN3s7K6cI9AwCJpCqxY6IkrmRgJY8lwq16e7kWE04rQemchqzWwCDurs
	 E8/6SyIXO4MmA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: gregkh@linuxfoundation.org
Cc: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org,
	Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 2/5] firmware: stratix10-svc: Implement ID pool management for asynchronous operations
Date: Tue, 22 Jul 2025 11:30:42 -0500
Message-ID: <20250722163045.168186-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20250722163045.168186-1-dinguyen@kernel.org>
References: <20250722163045.168186-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahesh Rao <mahesh.rao@altera.com>

Implement ID pool management API's which will be
used for Stratix10 Asynchronous communication with
Secure Device Manager. These API's will be used
in subsequent patches for ID management in
asynchronous operations.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 194 +++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 73c77b8e9f2b..a8c57963da99 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -170,6 +170,21 @@ struct stratix10_svc_chan {
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
 /* svc_mem_lock protects access to the svc_data_mem list for
@@ -177,6 +192,185 @@ static LIST_HEAD(svc_data_mem);
  */
 static DEFINE_MUTEX(svc_mem_lock);
 
+/**
+ * stratix10_id_pool_create - Create a new ID pool for Stratix10
+ * async operation
+ * @size: The size of the ID pool to create
+ *
+ * This function allocates and initializes a new ID pool structure
+ * for Stratix10 async operations. It allocates memory for the ID
+ * pool structure and the associated bitmaps for ID management.
+ *
+ * Return: Pointer to the newly created ID pool structure, or NULL
+ * on failure.
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
+ * This function reserves an ID in the given ID pool. It first checks if
+ * the ID pool is valid and if the ID is within the valid range.
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
+ * This function allocates an ID from the given ID pool. It searches for
+ * the next available ID in the pool, marks it as allocated,
+ * and returns it.
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
+ * This function deallocates an ID in the given ID pool. It first
+ * checks if the ID pool is valid and if the ID is within the valid
+ * range.
+ *
+ * Return:
+ * 0 on success,
+ * -EINVAL if the ID pool is invalid, the ID is out of range, or the
+ * ID is not set.
+ */
+static int stratix10_deallocate_id(struct stratix10_sip_id_pool *id_pool, unsigned long id)
+{
+	int ret = -EINVAL;
+
+	if (!id_pool)
+		return ret;
+
+	if (id >= id_pool->size)
+		return ret;
+
+	mutex_lock(&id_pool->lock);
+	if (test_bit(id, id_pool->id_mask)) {
+		clear_bit(id, id_pool->id_mask);
+		ret = 0;
+	}
+	mutex_unlock(&id_pool->lock);
+
+	return ret;
+}
+
 /**
  * svc_pa_to_va() - translate physical address to virtual address
  * @addr: to be translated physical address
-- 
2.42.0.411.g813d9a9188


