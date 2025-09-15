Return-Path: <linux-kernel+bounces-817867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE1B587BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7659E1B25996
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42E2D8387;
	Mon, 15 Sep 2025 22:44:43 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506AD221282
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976282; cv=none; b=WAapN3LpvmtZ+AAhxNCQyfv7qbZd/Vt03uZ0pRqlhEsZi1zyyxqDtftEx+msv5GL2E8ddG267GCbjp3XmVpwUD0aX6G94ksjb6wj6m7TulLx5RiXtQpCBp1bPBkXN1Jp9oWLEc+LazBMcYFc5CZqL97f5hznisS7Dt6VAHgpByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976282; c=relaxed/simple;
	bh=FoDhXKL27FrqFbdKgo4qvaWBWJzf83x/wDOeD8TZ98k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHRo4wYp0bVhlzmM+rNOKdnl01PKRrXFbAjkZzFNJqfy+rosuIPPkE7kMP5Diq2X76Pg7xgBE+FeASQ1fjPBzLslzAaw0cUbo0I9DCTtAe2+cIeFvtZ5QtkYlQWZ1hhAzCh7BJ2Fjem0Os6/u3HlqNJOCnuF+5KK7ALA5lJqF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26495aa4967so3880445ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976281; x=1758581081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4h6TvvGvdfthwq8yZuD7RXg5Y5KodTn8R97NT7K6NI=;
        b=o0zvCdczkmsiSxE+rfOBRc0z86WfS+viVIyWgSwfkuavPTgIEtBf1aF+EJO67TVCR2
         eOcIpoByRWhdUOA/7gFOjOzlIxz4Pmf8Pctix5igH9i5JC1uTxlA2BWfagA8NE4yN4Qn
         5tlDfzODHIT9GVFSxYrvTJn+VyWOHZxj80FucaINQl+wkpH+QjCL26+k9r9pcD6iaAUi
         RPfzraiC3TjMxRA3pHHClaNBNxWH5ad1L/i3pqa9cdqurUsNS7W0gdGMylX2tJn8pN47
         /0mjv0fIdbmSPK4MT4bd2iV62jmitKEdH/B/tUTROD9VxmhamojBcRi4Ig0upMmOIw5H
         HRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+cu1ncW4CMN11TnXHsU1rNHYoFm8szRu6Iefk/F8pdq5SqGkpICZ7ukJDQKUY5eczZoM6yWocyM35bDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCw/VmQL/gSAd8vHiRd3P5CdErdRXZa0stcVjzzvFaJh237jiz
	byq44lMG8f6KYg0OcZagIMH6q/4Vihsiu8leLNmxjX3NZOBri5mUQabW
X-Gm-Gg: ASbGncvobTazlI+BRKEPwywnv0sePc9QFVL2Ydm+ujoJQ5ZL691iVlfRazSbPOux3Ki
	C2vNNJuayFV8j5nYC5ZcOfvzhnlVpn/VmWZXER96DfDRM0sDBwu9MgMaGbeMAKkf9C+gmAeT2Ue
	ED1ZpQ9E25UEGBVmi8ByYqLRKrQwhtZQgFcINjeOUegRA8pFUQfg4ZaVOMVHm/GOMpDo1IGAb5+
	5meYqacQienxaqZ457Y2iQmMZkZR88VXpeYX2H4Q50GHkk1xkw9Vjxfi4aRGrk/77A4jWmfq18G
	qZB0XiAeFLThZ7ZAUih+CXhnOcBa4cb97hjTYWI1xEuSdQ11EjYwrlFcHUO8KLY6bZT8PQ3E6N4
	cGzd8ZekCLvZQfm/UMSboj2bZ1izOkE8IzDHBOdHA2v2ws0PptOZa5irdeEYtoeKbOkCxolkFWg
	UJ/PyxzOB+mw==
X-Google-Smtp-Source: AGHT+IHVxjXZpD31bCIVHV7+Q1p6w2ZxDlVfrTJXcV+ZPNp+MWwHnfZ/vC/wORtLF/jAvuHJqOJ52g==
X-Received: by 2002:a17:902:ec85:b0:267:bd8d:1b6 with SMTP id d9443c01a7336-267bd8d09c0mr10685795ad.6.1757976280635;
        Mon, 15 Sep 2025 15:44:40 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc53a1sm142718715ad.2.2025.09.15.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:44:40 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Norbert Szetei <norbert@doyensec.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Dawei Li <set_pte_at@outlook.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list),
	Yunseong Kim <ysk@kzalloc.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: Fix race condition in RPC handle list access
Date: Mon, 15 Sep 2025 22:44:09 +0000
Message-ID: <20250915224408.1132493-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'sess->rpc_handle_list' XArray manages RPC handles within a ksmbd
session. Access to this list is intended to be protected by
'sess->rpc_lock' (an rw_semaphore). However, the locking implementation was
flawed, leading to potential race conditions.

In ksmbd_session_rpc_open(), the code incorrectly acquired only a read lock
before calling xa_store() and xa_erase(). Since these operations modify
the XArray structure, a write lock is required to ensure exclusive access
and prevent data corruption from concurrent modifications.

Furthermore, ksmbd_session_rpc_method() accessed the list using xa_load()
without holding any lock at all. This could lead to reading inconsistent
data or a potential use-after-free if an entry is concurrently removed and
the pointer is dereferenced.

Fix these issues by:
1. Using down_write() and up_write() in ksmbd_session_rpc_open()
   to ensure exclusive access during XArray modification, and ensuring
   the lock is correctly released on error paths.
2. Adding down_read() and up_read() in ksmbd_session_rpc_method()
   to safely protect the lookup.

Fixes: a1f46c99d9ea ("ksmbd: fix use-after-free in ksmbd_session_rpc_open")
Fixes: b685757c7b08 ("ksmbd: Implements sess->rpc_handle_list as xarray")
Cc: stable@vger.kernel.org
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 fs/smb/server/mgmt/user_session.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 9dec4c2940bc..b36d0676dbe5 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -104,29 +104,32 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	if (!entry)
 		return -ENOMEM;
 
-	down_read(&sess->rpc_lock);
 	entry->method = method;
 	entry->id = id = ksmbd_ipc_id_alloc();
 	if (id < 0)
 		goto free_entry;
+
+	down_write(&sess->rpc_lock);
 	old = xa_store(&sess->rpc_handle_list, id, entry, KSMBD_DEFAULT_GFP);
-	if (xa_is_err(old))
+	if (xa_is_err(old)) {
+		up_write(&sess->rpc_lock);
 		goto free_id;
+	}
 
 	resp = ksmbd_rpc_open(sess, id);
-	if (!resp)
-		goto erase_xa;
+	if (!resp) {
+		xa_erase(&sess->rpc_handle_list, entry->id);
+		up_write(&sess->rpc_lock);
+		goto free_id;
+	}
 
-	up_read(&sess->rpc_lock);
+	up_write(&sess->rpc_lock);
 	kvfree(resp);
 	return id;
-erase_xa:
-	xa_erase(&sess->rpc_handle_list, entry->id);
 free_id:
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
 	kfree(entry);
-	up_read(&sess->rpc_lock);
 	return -EINVAL;
 }
 
@@ -144,9 +147,14 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
+	int method;
 
+	down_read(&sess->rpc_lock);
 	entry = xa_load(&sess->rpc_handle_list, id);
-	return entry ? entry->method : 0;
+	method = entry ? entry->method : 0;
+	up_read(&sess->rpc_lock);
+
+	return method;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
-- 
2.51.0


