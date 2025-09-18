Return-Path: <linux-kernel+bounces-756023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34031B1AEDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6466E3B6BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA722422B;
	Tue,  5 Aug 2025 06:54:29 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D831DF258;
	Tue,  5 Aug 2025 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376868; cv=none; b=JJfmzK61N8DneFflzaLuNUxswJShuzSwQx7pNClSxIUp7kuaDo8cl+LhdStdZXlHpfNow4KSb/AWoRoNZnIiJ8DsbDp3RCwUD3RivjaR5jZBqtHIfr9QavsFhXsfPbUpFvV2tfEsCAHE9jCGZyRsGWFnip2q84J7euGAhUqufy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376868; c=relaxed/simple;
	bh=f4wtnMuK7prSopOjB6a/p2BQqQ+I/8XSkFa6dJ/6B98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0+4/kDXY2jw37TXzMAq5bEp4/n/esFZSDTTvcmkQMsZrlntO5o3ofQx1W2XiUShhaWxAv6rt9GX/T6FFEZ/NiDp1sZkrGV8gW3Ix4S/e24eZhAT1kQNTqDQnHsXW3F0mUZzvdalnMHGxhrZ9ZIcOLa3MwgWj/AI0SS2nq4lJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bx40c0kkdzKHMWT;
	Tue,  5 Aug 2025 14:54:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 23AB41A07BB;
	Tue,  5 Aug 2025 14:54:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3chObqpForbmECg--.23530S5;
	Tue, 05 Aug 2025 14:54:22 +0800 (CST)
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
To: sfrench@samba.org,
	pshilov@microsoft.com
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH V2 1/4] smb: client: rename server mid_lock to mid_queue_lock
Date: Tue,  5 Aug 2025 14:47:05 +0800
Message-Id: <20250805064708.332465-2-wangzhaolong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250805064708.332465-1-wangzhaolong@huaweicloud.com>
References: <20250805064708.332465-1-wangzhaolong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chObqpForbmECg--.23530S5
X-Coremail-Antispam: 1UD129KBjvAXoW3ur1UtF18GF45Xw1ruw1Dtrb_yoW8Zr4xKo
	Z7X3s5Zr4UWryktryFyrn3tF18Xa4DKayUJrsYkr15Aasaka4jvrWUtw15JFWYv39rArsF
	v34xJFnYga4DJF1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYL7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8573DUUUUU==
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/

This is step 1/4 of a patch series to fix mid_q_entry memory leaks
caused by race conditions in callback execution.

The current mid_lock name is somewhat ambiguous about what it protects.
To prepare for splitting this lock into separate, more granular locks,
this patch renames mid_lock to mid_queue_lock to clearly indicate its
specific responsibility for protecting the pending_mid_q list and
related queue operations.

No functional changes are made in this patch - it only prepares the
codebase for the lock splitting that follows.

- mid_queue_lock for queue operations
- mid_counter_lock for mid counter operations
- per-mid locks for individual mid state management

Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
---
 fs/smb/client/cifs_debug.c    |  8 ++++----
 fs/smb/client/cifsglob.h      |  4 ++--
 fs/smb/client/connect.c       | 20 +++++++++----------
 fs/smb/client/smb1ops.c       | 10 +++++-----
 fs/smb/client/smb2ops.c       | 26 ++++++++++++-------------
 fs/smb/client/smb2transport.c |  4 ++--
 fs/smb/client/transport.c     | 36 +++++++++++++++++------------------
 7 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index f1cea365b6f1..80d6a51b8c11 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -58,11 +58,11 @@ void cifs_dump_mids(struct TCP_Server_Info *server)
 
 	if (server == NULL)
 		return;
 
 	cifs_dbg(VFS, "Dump pending requests:\n");
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	list_for_each_entry(mid_entry, &server->pending_mid_q, qhead) {
 		cifs_dbg(VFS, "State: %d Cmd: %d Pid: %d Cbdata: %p Mid %llu\n",
 			 mid_entry->mid_state,
 			 le16_to_cpu(mid_entry->command),
 			 mid_entry->pid,
@@ -81,11 +81,11 @@ void cifs_dump_mids(struct TCP_Server_Info *server)
 			cifs_dump_detail(mid_entry->resp_buf, server);
 			cifs_dump_mem("existing buf: ",
 				mid_entry->resp_buf, 62);
 		}
 	}
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 #endif /* CONFIG_CIFS_DEBUG2 */
 }
 
 #ifdef CONFIG_PROC_FS
 static void cifs_debug_tcon(struct seq_file *m, struct cifs_tcon *tcon)
@@ -670,20 +670,20 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				if (list_empty(&chan_server->pending_mid_q))
 					continue;
 
 				seq_printf(m, "\n\tServer ConnectionId: 0x%llx",
 					   chan_server->conn_id);
-				spin_lock(&chan_server->mid_lock);
+				spin_lock(&chan_server->mid_queue_lock);
 				list_for_each_entry(mid_entry, &chan_server->pending_mid_q, qhead) {
 					seq_printf(m, "\n\t\tState: %d com: %d pid: %d cbdata: %p mid %llu",
 						   mid_entry->mid_state,
 						   le16_to_cpu(mid_entry->command),
 						   mid_entry->pid,
 						   mid_entry->callback_data,
 						   mid_entry->mid);
 				}
-				spin_unlock(&chan_server->mid_lock);
+				spin_unlock(&chan_server->mid_queue_lock);
 			}
 			spin_unlock(&ses->chan_lock);
 			seq_puts(m, "\n--\n");
 		}
 		if (i == 0)
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 19dd901fe8ab..ecd568793ce7 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -730,11 +730,11 @@ struct TCP_Server_Info {
 #ifdef CONFIG_NET_NS
 	struct net *net;
 #endif
 	wait_queue_head_t response_q;
 	wait_queue_head_t request_q; /* if more than maxmpx to srvr must block*/
-	spinlock_t mid_lock;  /* protect mid queue and it's entries */
+	spinlock_t mid_queue_lock;  /* protect mid queue */
 	struct list_head pending_mid_q;
 	bool noblocksnd;		/* use blocking sendmsg */
 	bool noautotune;		/* do not autotune send buf sizes */
 	bool nosharesock;
 	bool tcp_nodelay;
@@ -2005,11 +2005,11 @@ require use of the stronger protocol */
  * cifs_tcp_ses_lock		cifs_tcp_ses_list		sesInfoAlloc
  * GlobalMid_Lock		GlobalMaxActiveXid		init_cifs
  *				GlobalCurrentXid
  *				GlobalTotalActiveXid
  * TCP_Server_Info->srv_lock	(anything in struct not protected by another lock and can change)
- * TCP_Server_Info->mid_lock	TCP_Server_Info->pending_mid_q	cifs_get_tcp_session
+ * TCP_Server_Info->mid_queue_lock	TCP_Server_Info->pending_mid_q	cifs_get_tcp_session
  *				->CurrentMid
  *				(any changes in mid_q_entry fields)
  * TCP_Server_Info->req_lock	TCP_Server_Info->in_flight	cifs_get_tcp_session
  *				->credits
  *				->echo_credits
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 5eec8957f2a9..e4b577ca48d5 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -319,19 +319,19 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	server->lstrp = jiffies;
 
 	/* mark submitted MIDs for retry and issue callback */
 	INIT_LIST_HEAD(&retry_list);
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
 		kref_get(&mid->refcount);
 		if (mid->mid_state == MID_REQUEST_SUBMITTED)
 			mid->mid_state = MID_RETRY_NEEDED;
 		list_move(&mid->qhead, &retry_list);
 		mid->mid_flags |= MID_DELETED;
 	}
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 	cifs_server_unlock(server);
 
 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
 	list_for_each_entry_safe(mid, nmid, &retry_list, qhead) {
 		list_del_init(&mid->qhead);
@@ -882,17 +882,17 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 * server, so reconnect would not signal connection
 			 * aborted error to mid's callbacks. Note that for this
 			 * server there should be exactly one pending mid
 			 * corresponding to SMB1/SMB2 Negotiate packet.
 			 */
-			spin_lock(&server->mid_lock);
+			spin_lock(&server->mid_queue_lock);
 			list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
 				kref_get(&mid->refcount);
 				list_move(&mid->qhead, &dispose_list);
 				mid->mid_flags |= MID_DELETED;
 			}
-			spin_unlock(&server->mid_lock);
+			spin_unlock(&server->mid_queue_lock);
 
 			/* Now try to reconnect once with NetBIOS session. */
 			server->with_rfc1001 = true;
 			rc = cifs_reconnect_once(server);
 
@@ -955,26 +955,26 @@ void
 dequeue_mid(struct mid_q_entry *mid, bool malformed)
 {
 #ifdef CONFIG_CIFS_STATS2
 	mid->when_received = jiffies;
 #endif
-	spin_lock(&mid->server->mid_lock);
+	spin_lock(&mid->server->mid_queue_lock);
 	if (!malformed)
 		mid->mid_state = MID_RESPONSE_RECEIVED;
 	else
 		mid->mid_state = MID_RESPONSE_MALFORMED;
 	/*
 	 * Trying to handle/dequeue a mid after the send_recv()
 	 * function has finished processing it is a bug.
 	 */
 	if (mid->mid_flags & MID_DELETED) {
-		spin_unlock(&mid->server->mid_lock);
+		spin_unlock(&mid->server->mid_queue_lock);
 		pr_warn_once("trying to dequeue a deleted mid\n");
 	} else {
 		list_del_init(&mid->qhead);
 		mid->mid_flags |= MID_DELETED;
-		spin_unlock(&mid->server->mid_lock);
+		spin_unlock(&mid->server->mid_queue_lock);
 	}
 }
 
 static unsigned int
 smb2_get_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
@@ -1099,20 +1099,20 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 	if (!list_empty(&server->pending_mid_q)) {
 		struct mid_q_entry *mid_entry;
 		struct list_head *tmp, *tmp2;
 		LIST_HEAD(dispose_list);
 
-		spin_lock(&server->mid_lock);
+		spin_lock(&server->mid_queue_lock);
 		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
 			mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
 			cifs_dbg(FYI, "Clearing mid %llu\n", mid_entry->mid);
 			kref_get(&mid_entry->refcount);
 			mid_entry->mid_state = MID_SHUTDOWN;
 			list_move(&mid_entry->qhead, &dispose_list);
 			mid_entry->mid_flags |= MID_DELETED;
 		}
-		spin_unlock(&server->mid_lock);
+		spin_unlock(&server->mid_queue_lock);
 
 		/* now walk dispose list and issue callbacks */
 		list_for_each_safe(tmp, tmp2, &dispose_list) {
 			mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
 			cifs_dbg(FYI, "Callback mid %llu\n", mid_entry->mid);
@@ -1820,11 +1820,11 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	tcp_ses->reconnect_instance = 1;
 	tcp_ses->lstrp = jiffies;
 	tcp_ses->compression.requested = ctx->compress;
 	spin_lock_init(&tcp_ses->req_lock);
 	spin_lock_init(&tcp_ses->srv_lock);
-	spin_lock_init(&tcp_ses->mid_lock);
+	spin_lock_init(&tcp_ses->mid_queue_lock);
 	INIT_LIST_HEAD(&tcp_ses->tcp_ses_list);
 	INIT_LIST_HEAD(&tcp_ses->smb_ses_list);
 	INIT_DELAYED_WORK(&tcp_ses->echo, cifs_echo_request);
 	INIT_DELAYED_WORK(&tcp_ses->reconnect, smb2_reconnect_server);
 	mutex_init(&tcp_ses->reconnect_mutex);
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index e364b6515af3..a1442f697706 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -93,21 +93,21 @@ static struct mid_q_entry *
 cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 {
 	struct smb_hdr *buf = (struct smb_hdr *)buffer;
 	struct mid_q_entry *mid;
 
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	list_for_each_entry(mid, &server->pending_mid_q, qhead) {
 		if (compare_mid(mid->mid, buf) &&
 		    mid->mid_state == MID_REQUEST_SUBMITTED &&
 		    le16_to_cpu(mid->command) == buf->Command) {
 			kref_get(&mid->refcount);
-			spin_unlock(&server->mid_lock);
+			spin_unlock(&server->mid_queue_lock);
 			return mid;
 		}
 	}
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 	return NULL;
 }
 
 static void
 cifs_add_credits(struct TCP_Server_Info *server,
@@ -167,11 +167,11 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
 {
 	__u64 mid = 0;
 	__u16 last_mid, cur_mid;
 	bool collision, reconnect = false;
 
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 
 	/* mid is 16 bit only for CIFS/SMB */
 	cur_mid = (__u16)((server->CurrentMid) & 0xffff);
 	/* we do not want to loop forever */
 	last_mid = cur_mid;
@@ -226,11 +226,11 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
 			server->CurrentMid = mid;
 			break;
 		}
 		cur_mid++;
 	}
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 
 	if (reconnect) {
 		cifs_signal_cifsd_for_reconnect(server, false);
 	}
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1b4a31894f43..c714707249c7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -372,23 +372,23 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 static __u64
 smb2_get_next_mid(struct TCP_Server_Info *server)
 {
 	__u64 mid;
 	/* for SMB2 we need the current value */
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	mid = server->CurrentMid++;
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 	return mid;
 }
 
 static void
 smb2_revert_current_mid(struct TCP_Server_Info *server, const unsigned int val)
 {
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	if (server->CurrentMid >= val)
 		server->CurrentMid -= val;
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 }
 
 static struct mid_q_entry *
 __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 {
@@ -399,25 +399,25 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 	if (shdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM) {
 		cifs_server_dbg(VFS, "Encrypted frame parsing not supported yet\n");
 		return NULL;
 	}
 
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	list_for_each_entry(mid, &server->pending_mid_q, qhead) {
 		if ((mid->mid == wire_mid) &&
 		    (mid->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (mid->command == shdr->Command)) {
 			kref_get(&mid->refcount);
 			if (dequeue) {
 				list_del_init(&mid->qhead);
 				mid->mid_flags |= MID_DELETED;
 			}
-			spin_unlock(&server->mid_lock);
+			spin_unlock(&server->mid_queue_lock);
 			return mid;
 		}
 	}
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 	return NULL;
 }
 
 static struct mid_q_entry *
 smb2_find_mid(struct TCP_Server_Info *server, char *buf)
@@ -458,13 +458,13 @@ smb2_negotiate(const unsigned int xid,
 	       struct cifs_ses *ses,
 	       struct TCP_Server_Info *server)
 {
 	int rc;
 
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	server->CurrentMid = 0;
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 	rc = SMB2_negotiate(xid, ses, server);
 	return rc;
 }
 
 static inline unsigned int
@@ -4807,22 +4807,22 @@ static void smb2_decrypt_offload(struct work_struct *work)
 
 			mid->callback(mid);
 		} else {
 			spin_lock(&dw->server->srv_lock);
 			if (dw->server->tcpStatus == CifsNeedReconnect) {
-				spin_lock(&dw->server->mid_lock);
+				spin_lock(&dw->server->mid_queue_lock);
 				mid->mid_state = MID_RETRY_NEEDED;
-				spin_unlock(&dw->server->mid_lock);
+				spin_unlock(&dw->server->mid_queue_lock);
 				spin_unlock(&dw->server->srv_lock);
 				mid->callback(mid);
 			} else {
-				spin_lock(&dw->server->mid_lock);
+				spin_lock(&dw->server->mid_queue_lock);
 				mid->mid_state = MID_REQUEST_SUBMITTED;
 				mid->mid_flags &= ~(MID_DELETED);
 				list_add_tail(&mid->qhead,
 					&dw->server->pending_mid_q);
-				spin_unlock(&dw->server->mid_lock);
+				spin_unlock(&dw->server->mid_queue_lock);
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
 		release_mid(mid);
 	}
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 475b36c27f65..ff9ef7fcd010 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -838,13 +838,13 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	spin_unlock(&ses->ses_lock);
 
 	*mid = smb2_mid_entry_alloc(shdr, server);
 	if (*mid == NULL)
 		return -ENOMEM;
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	list_add_tail(&(*mid)->qhead, &server->pending_mid_q);
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 
 	return 0;
 }
 
 int
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 191783f553ce..12dc927aa4a2 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -158,16 +158,16 @@ void __release_mid(struct kref *refcount)
 }
 
 void
 delete_mid(struct mid_q_entry *mid)
 {
-	spin_lock(&mid->server->mid_lock);
+	spin_lock(&mid->server->mid_queue_lock);
 	if (!(mid->mid_flags & MID_DELETED)) {
 		list_del_init(&mid->qhead);
 		mid->mid_flags |= MID_DELETED;
 	}
-	spin_unlock(&mid->server->mid_lock);
+	spin_unlock(&mid->server->mid_queue_lock);
 
 	release_mid(mid);
 }
 
 /*
@@ -714,13 +714,13 @@ static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
 	spin_unlock(&ses->ses_lock);
 
 	*ppmidQ = alloc_mid(in_buf, ses->server);
 	if (*ppmidQ == NULL)
 		return -ENOMEM;
-	spin_lock(&ses->server->mid_lock);
+	spin_lock(&ses->server->mid_queue_lock);
 	list_add_tail(&(*ppmidQ)->qhead, &ses->server->pending_mid_q);
-	spin_unlock(&ses->server->mid_lock);
+	spin_unlock(&ses->server->mid_queue_lock);
 	return 0;
 }
 
 static int
 wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
@@ -817,13 +817,13 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	mid->callback_data = cbdata;
 	mid->handle = handle;
 	mid->mid_state = MID_REQUEST_SUBMITTED;
 
 	/* put it on the pending_mid_q */
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	list_add_tail(&mid->qhead, &server->pending_mid_q);
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 
 	/*
 	 * Need to store the time in mid before calling I/O. For call_async,
 	 * I/O response may come back and free the mid entry on another thread.
 	 */
@@ -878,14 +878,14 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: cmd=%d mid=%llu state=%d\n",
 		 __func__, le16_to_cpu(mid->command), mid->mid, mid->mid_state);
 
-	spin_lock(&server->mid_lock);
+	spin_lock(&server->mid_queue_lock);
 	switch (mid->mid_state) {
 	case MID_RESPONSE_READY:
-		spin_unlock(&server->mid_lock);
+		spin_unlock(&server->mid_queue_lock);
 		return rc;
 	case MID_RETRY_NEEDED:
 		rc = -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:
@@ -900,17 +900,17 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 	default:
 		if (!(mid->mid_flags & MID_DELETED)) {
 			list_del_init(&mid->qhead);
 			mid->mid_flags |= MID_DELETED;
 		}
-		spin_unlock(&server->mid_lock);
+		spin_unlock(&server->mid_queue_lock);
 		cifs_server_dbg(VFS, "%s: invalid mid state mid=%llu state=%d\n",
 			 __func__, mid->mid, mid->mid_state);
 		rc = -EIO;
 		goto sync_mid_done;
 	}
-	spin_unlock(&server->mid_lock);
+	spin_unlock(&server->mid_queue_lock);
 
 sync_mid_done:
 	release_mid(mid);
 	return rc;
 }
@@ -1211,19 +1211,19 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if (rc != 0) {
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
 				 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
 			send_cancel(server, &rqst[i], midQ[i]);
-			spin_lock(&server->mid_lock);
+			spin_lock(&server->mid_queue_lock);
 			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
 			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
 			    midQ[i]->mid_state == MID_RESPONSE_RECEIVED) {
 				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
 			}
-			spin_unlock(&server->mid_lock);
+			spin_unlock(&server->mid_queue_lock);
 		}
 	}
 
 	for (i = 0; i < num_rqst; i++) {
 		if (rc < 0)
@@ -1421,20 +1421,20 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		goto out;
 
 	rc = wait_for_response(server, midQ);
 	if (rc != 0) {
 		send_cancel(server, &rqst, midQ);
-		spin_lock(&server->mid_lock);
+		spin_lock(&server->mid_queue_lock);
 		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
 		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 			/* no longer considered to be "in-flight" */
 			midQ->callback = release_mid;
-			spin_unlock(&server->mid_lock);
+			spin_unlock(&server->mid_queue_lock);
 			add_credits(server, &credits, 0);
 			return rc;
 		}
-		spin_unlock(&server->mid_lock);
+		spin_unlock(&server->mid_queue_lock);
 	}
 
 	rc = cifs_sync_mid_result(midQ, server);
 	if (rc != 0) {
 		add_credits(server, &credits, 0);
@@ -1603,19 +1603,19 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		}
 
 		rc = wait_for_response(server, midQ);
 		if (rc) {
 			send_cancel(server, &rqst, midQ);
-			spin_lock(&server->mid_lock);
+			spin_lock(&server->mid_queue_lock);
 			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
 			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 				/* no longer considered to be "in-flight" */
 				midQ->callback = release_mid;
-				spin_unlock(&server->mid_lock);
+				spin_unlock(&server->mid_queue_lock);
 				return rc;
 			}
-			spin_unlock(&server->mid_lock);
+			spin_unlock(&server->mid_queue_lock);
 		}
 
 		/* We got the response - restart system call. */
 		rstart = 1;
 		spin_lock(&server->srv_lock);
-- 
2.39.2


