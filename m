Return-Path: <linux-kernel+bounces-857871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C2BE81E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4CA565379
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28831E0ED;
	Fri, 17 Oct 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v8KMjGQh"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976A31CA4C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698048; cv=none; b=KsPDo7l3CH6+vgzmHFj62dcGYINC5xuGiGb0utpoQ8dWXyGNwN+U2Mooe4d6qtN7wdwQk5NpvLkEXJ2zfXN4xyFoFVIUWbioN9MN1U4CedI7+jxGpng2V8/kOcYaryyNOkpdSjuyalob69ACBskfOGnm040lt8HqIj8ANmtbVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698048; c=relaxed/simple;
	bh=nZUS6gfRCnWHR2PlTcF00h3XbFItns9vJu+Zy2lv5S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkhhDMHqpMg9dJQJcQwXFrFTc8wDIbnd2sDNtpOITSedksVTGpNPnr8ilPU0KCJTWK8b8zoalXWbYPz9w8R9HqUzjZV36yfu+WTl5ql+LFz1nhYjPQGEDxq8h3tgEKchLER4pMSOpRVempVHNhNjhSgALB3oVoLUVIp0qHYZfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v8KMjGQh; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760698044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5efMjCW0y1u13VzQpJkPhSCCtNBBW6zz612984MrWw=;
	b=v8KMjGQhoUYaY3C5qNU49rQ4Kg6dzWiOwOLv0CfqnDhrKbdAJEDeOfWp8S83740S7OW+4h
	56+Rjpbx39c7lCWMVKj4k7GVhfTtRZJ/tmf7qjxmVaOxT0Vh6B6f6PABavrnnajUDLLalB
	6/k1vXHH6R+U2LRu1qNTeDDO3GLZV/4=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 6/6] smb/server: update some misguided comment of smb2_0_server_cmds proc
Date: Fri, 17 Oct 2025 18:46:12 +0800
Message-ID: <20251017104613.3094031-7-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

These functions return error code rather than always returning 0.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 06e4c21ad4a8..52cb0519b974 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2168,7 +2168,7 @@ static int smb2_create_open_flags(bool file_present, __le32 access,
  * smb2_tree_disconnect() - handler for smb tree connect request
  * @work:	smb work containing request buffer
  *
- * Return:      0
+ * Return:      0 on success, otherwise error
  */
 int smb2_tree_disconnect(struct ksmbd_work *work)
 {
@@ -2232,7 +2232,7 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
  * smb2_session_logoff() - handler for session log off request
  * @work:	smb work containing request buffer
  *
- * Return:      0
+ * Return:      0 on success, otherwise error
  */
 int smb2_session_logoff(struct ksmbd_work *work)
 {
@@ -5844,7 +5844,7 @@ static noinline int smb2_close_pipe(struct ksmbd_work *work)
  * smb2_close() - handler for smb2 close file command
  * @work:	smb work containing close request buffer
  *
- * Return:	0
+ * Return:	0 on success, otherwise error
  */
 int smb2_close(struct ksmbd_work *work)
 {
@@ -5969,7 +5969,7 @@ int smb2_close(struct ksmbd_work *work)
  * smb2_echo() - handler for smb2 echo(ping) command
  * @work:	smb work containing echo request buffer
  *
- * Return:	0
+ * Return:	0 on success, otherwise error
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-- 
2.43.0


