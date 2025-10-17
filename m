Return-Path: <linux-kernel+bounces-857618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E09BE744B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50D21AA0D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761D2D6E66;
	Fri, 17 Oct 2025 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="koLMRnxk"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5D2D3218
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690876; cv=none; b=MXnQ3G+4tcGY8GnjQJeaFJxwbI03LFUXhQxkhvVo2zu/hiQ+rROQjFTA1M0qXQfzNqD31GyPE+XnaPJhPLBX0oQ7NAv+7ilaG8ftschGRqj11dDIT1gzq8EqsKDLP7HtTw65Lg6Nj2RMqhk0apjn2Wwik3YATQB7HOjsKUi8ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690876; c=relaxed/simple;
	bh=Smwkl3d6C9d5R43QKpDslC7vUv+Zi3b+/WBFLL5/d4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0Ve0YB4S2NUpPBcrB88NnVXDUOlP2MXU7MydMWYwsqSKdgVlJRKLnkwVz1gDFgBjCMrLSz799Hl1WDFeXXFUAECq8Y5nOgPPuO9I3A+TtSyUHbvEYzOogeoaEdfQ/aVJrUrDCzlwu1xhVdMCOrEQXrweArzFI/MF0TM8Jkm6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=koLMRnxk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760690871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQckkc68Kr1WClPbN+XkVmK2MPKAUeYvLWYVQK2kNuU=;
	b=koLMRnxkrMt6jAOBgk/S4xdtIwWvyLCBjslANTg11vVCTqT9sDApGmnDDltqD7JexGfDhU
	sNKVKjlaLyfJGLILWBqy5pNU4QrcwH5Zu6393y1cgdiVjoIoeLC5MhZ4j7VgOFeXxacnke
	2u8NtiiKFNK5Y/MruFlNmJmFUtifwL8=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 6/6] smb/server: update some misguided comment of smb2_0_server_cmds proc
Date: Fri, 17 Oct 2025 16:46:10 +0800
Message-ID: <20251017084610.3085644-7-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev>
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
index 0fb517838325..9ddfc2dbe07c 100644
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


