Return-Path: <linux-kernel+bounces-841631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F0CBB7D92
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 088874EEB61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F622DC349;
	Fri,  3 Oct 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG1xezv/"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D451CD15
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515017; cv=none; b=qNB4xucOHpE/5GMP9/PoAIzE8pZHm80gfQTA6VMyIoz6rKzmugn7nV3wAC+8GdQ8WFfyBELPWfVpOZ007wWC42D6r8Vpx5BA19siVtZsBUIC6ZxgHygaU9HJIMnKVeHmLZG5sRDoVZVesFVdRjrBSM9mG5AYlywqLSykadBN+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515017; c=relaxed/simple;
	bh=BwNIfWJoXoYrqVcyGLGK0ZGZsTKaqAnHZe5fUj2oVQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMytGwtttffUg+TLd0xwOenlp5xWm/DMaAtlNU8LB8QnVoHgntguX/jiPziy9b0g2E69rvy4hg8nxze82YbxUxhrsO81xvEbAlnsyAO6y6saiePUwtDv3/zTX0rtGlspufEca062fWMwI1qQti2U8dkB7rXQZTPtXZkKNhVNJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG1xezv/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so836976a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515005; x=1760119805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIqLDFIVHdxcdUk2CXnKw1wmZSXLkp148igPvonnpCk=;
        b=eG1xezv/4FgdNDjxNN3sGK6VD6RG0n+ZQ3Qq8qE8mCSyGfHSCl5Ct0/A6JGyLz9zau
         NV9G+nbxgbamNTZbCCx8AuSxET5/6l+nYoKWl6ZVMOTimioi7oDLVzBKoa8MOjI4YSNS
         vrIRg4l1HtTgI/87X174m6JE9pfuTsSyJeltviDac1LgB/Wp+ROfoc5uqfscVQAqJYff
         IUfN18y8GjTDVUAoFTt+5xm0Eknk/NR8Q9dCTmKurySEpudFofZMOfzzXVkJcKSMtVww
         XO2ReHxBQb58uXclPJMTFGq5qS47bHMWu6gXwnQigiUSfGbZuFdhytJ+LiDoKd5UiLUk
         YaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515005; x=1760119805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIqLDFIVHdxcdUk2CXnKw1wmZSXLkp148igPvonnpCk=;
        b=lUZSqhTGWSse5Fh7Le6XA+XhkHrjoR5QVfCBN8JBF59Yrnrg0P/4d6GnV19jUUmLio
         MSeYaALsvpAjKkEYXGXlB2FOcxGxwUegSE7ruFuFfR8FC2HAJV78pdnIjDOLYUO7BOEw
         V+InDme7vOGEkArgR27SHJb4w5XWv56r42CieiJdXf1GaIVyMBq8ZRq9hgtYXUCkzjsq
         jnM41zAOm62kV5tclIzS4hpFEtxUGmSFIv056L7xeoG2ZayMo6tCi8PKRu/srAdok1w5
         fqd16SVFnl3ZAQdH38pWKjv5YJLLhW8W2neWQ2MYjuXiQcYeNQjEiZFfdWsVOqLhM6kZ
         FcNQ==
X-Gm-Message-State: AOJu0YyLZ5OvWieVSNL/3d+lzr1hWYfTIf8vo7NX9ViCZCoCwOLhHI9c
	ZphNE45c3UwkheVUjNQnFnezAwmqi4oOW5uPuInmNptP8kdaFmEWUtjn
X-Gm-Gg: ASbGncu0aLoIjsxzZ6HXsyTbeYuwy84hgh6TAuJvU6aiG6qF43iSYikrp5aYxu+0b8v
	w0AvP/3d6eq1svsPrZcoyulNeHkPxiUdpxoa2U9QEPWFJSQMYj0iUZVxobufOU5An3oIdXqQ2X0
	sE5IjaV/RsbPPkv8jlYghKShDuorwNCJTjD2q5b6rlKYIU5V8ZKv1zSirfNxTOztTGwCpaMaxEA
	gyfZ6nFCpYxUwvXIu2GManu8RZ1PZdWmUjNGibZaWAAEp8nhFEVFa8I8qfTpTihFBZXRTz9ta++
	ClcTLP0hATL62Do7sqFp+DFa4Lvh4KF8HiuxzgT+NqIjikukMORTvXEqjeUnhjKiCegWt36F9UG
	SEXPGwzB0K2eBKVD/NSKP/ywgtN+x54MzTk3CC++4kHanUZlnGnNvq5Ivhi9wpbGgatj/WRIC5s
	VgkDhEH2QsmBP89vJFXhjYZRxn0gGTSDvt/aCt9bB0dGtgC7FHZQ==
X-Google-Smtp-Source: AGHT+IEKlUUyEeXW3+EsXqOKV5os0N7Esq2wE+7/JIbDWAu/QUEPL95cMZRX/mYx/id0lHdExcOC2A==
X-Received: by 2002:a17:90b:4b8c:b0:338:36ee:8a99 with SMTP id 98e67ed59e1d1-339c273dc45mr4535325a91.11.1759515005329;
        Fri, 03 Oct 2025 11:10:05 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b60998052e1sm5110073a12.0.2025.10.03.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:10:04 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joelagnelf@nvidia.com,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com
Cc: linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH  v2] binder: Fix missing kernel-doc entries in binder.c
Date: Fri,  3 Oct 2025 18:08:49 +0000
Message-Id: <20251003180849.1438872-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several kernel-doc warnings in `drivers/android/binder.c` caused by
undocumented struct members and function parameters.

In particular, add missing documentation for the `@thread` parameter in
binder_free_buf_locked().

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
  - Align `@thread` with other parameters
  - Move `@thread` after `@proc`
  - Update commit subject to "binder:"

v1: https://lore.kernel.org/all/20250925025517.815391-1-kriish.sharma2006@gmail.com/


 drivers/android/binder.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 312b462e349d..d25b79a3d502 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2417,10 +2417,10 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 
 /**
  * struct binder_ptr_fixup - data to be fixed-up in target buffer
- * @offset	offset in target buffer to fixup
- * @skip_size	bytes to skip in copy (fixup will be written later)
- * @fixup_data	data to write at fixup offset
- * @node	list node
+ * @offset:      offset in target buffer to fixup
+ * @skip_size:   bytes to skip in copy (fixup will be written later)
+ * @fixup_data:  data to write at fixup offset
+ * @node:        list node
  *
  * This is used for the pointer fixup list (pf) which is created and consumed
  * during binder_transaction() and is only accessed locally. No
@@ -2437,10 +2437,10 @@ struct binder_ptr_fixup {
 
 /**
  * struct binder_sg_copy - scatter-gather data to be copied
- * @offset		offset in target buffer
- * @sender_uaddr	user address in source buffer
- * @length		bytes to copy
- * @node		list node
+ * @offset:        offset in target buffer
+ * @sender_uaddr:  user address in source buffer
+ * @length:        bytes to copy
+ * @node:          list node
  *
  * This is used for the sg copy list (sgc) which is created and consumed
  * during binder_transaction() and is only accessed locally. No
@@ -3994,14 +3994,15 @@ binder_freeze_notification_done(struct binder_proc *proc,
 
 /**
  * binder_free_buf() - free the specified buffer
- * @proc:	binder proc that owns buffer
- * @buffer:	buffer to be freed
- * @is_failure:	failed to send transaction
+ * @proc:       binder proc that owns buffer
+ * @thread:     binder thread performing the buffer release
+ * @buffer:     buffer to be freed
+ * @is_failure: failed to send transaction
  *
- * If buffer for an async transaction, enqueue the next async
+ * If the buffer is for an async transaction, enqueue the next async
  * transaction from the node.
  *
- * Cleanup buffer and free it.
+ * Cleanup the buffer and free it.
  */
 static void
 binder_free_buf(struct binder_proc *proc,
-- 
2.34.1


