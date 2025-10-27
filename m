Return-Path: <linux-kernel+bounces-870947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1EC0C0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF28634AC65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239632DEA67;
	Mon, 27 Oct 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hMAMY1ca"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C712DE1FA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549333; cv=none; b=jN4KfgWVDD3DNUKDzM+1S5m6vVt28ZoyHUKXUcKRqma9fYLOy8NMN8ThPW0EmADjnRfcycQ18mfbwYuuDrk1q6spnAu36UlzFn2JXd5ZYA8TuNmvD9UzClNM+JMyw32yEeVsP703JzMi/zgzro5SAHYENTN2jsWL+hNhpcp3ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549333; c=relaxed/simple;
	bh=GI8sZqXt3KCf55k3GW8kAFhfrSAAlqp6DwxYahiWZR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2BknW7UXt4EXk/CTJTSs039L3jyDxknysRUU9sgQR8nRkoTJ34rE0DiQ5Lk8CaXhUTLcrECmhrsYig0XX63yS5pyO7grVnYW+kRqTJfPuO79ynEHFyJ0IK9UFeFro+fckq5QX4bs0eUGxK5DdK4NFr5qTmiT+TrDNn4ufjBAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hMAMY1ca; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761549329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+zbYQSRYbpuT9HfdZ1yegnfGPQwfg9RHt4r+8oTMtI=;
	b=hMAMY1cahDZgyg1+Rv8G4lE+ytC2BOtz+S6sdcQpHkG3pJxaSVIXxsu/v8Jw/aAbC1K1lr
	BAi1fxFT4rMM6EQvCYBwaSl27rSTehlFsBmCk3ijpzCoinknp3DYfzSuKWyFn2ty60Bmdv
	Dq1yBTAYxo5cugpKn0ZTB1w30BH6U/0=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org,
	christophe.jaillet@wanadoo.fr
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v4 04/24] smb: move SMB1_PROTO_NUMBER to common/smbglob.h
Date: Mon, 27 Oct 2025 15:12:56 +0800
Message-ID: <20251027071316.3468472-5-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ZhangGuoDong <zhangguodong@kylinos.cn>

Replace the constant of client with SMB1_PROTO_NUMBER, then move the
macro definition from server/smb_common.h to common/smbglob.h.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/smb/client/misc.c       | 2 +-
 fs/smb/common/smbglob.h    | 2 ++
 fs/smb/server/smb_common.h | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index e10123d8cd7d..340c44dc7b5b 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -318,7 +318,7 @@ static int
 check_smb_hdr(struct smb_hdr *smb)
 {
 	/* does it have the right SMB "signature" ? */
-	if (*(__le32 *) smb->Protocol != cpu_to_le32(0x424d53ff)) {
+	if (*(__le32 *) smb->Protocol != SMB1_PROTO_NUMBER) {
 		cifs_dbg(VFS, "Bad protocol string signature header 0x%x\n",
 			 *(unsigned int *)smb->Protocol);
 		return 1;
diff --git a/fs/smb/common/smbglob.h b/fs/smb/common/smbglob.h
index b258199b0d75..fa3d30dc6022 100644
--- a/fs/smb/common/smbglob.h
+++ b/fs/smb/common/smbglob.h
@@ -9,6 +9,8 @@
 #ifndef _COMMON_SMB_GLOB_H
 #define _COMMON_SMB_GLOB_H
 
+#define SMB1_PROTO_NUMBER		cpu_to_le32(0x424d53ff)
+
 struct smb_version_values {
 	char		*version_string;
 	__u16		protocol_id;
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index f126c61c7275..c3258a3231e4 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -151,7 +151,6 @@
 		FILE_EXECUTE | FILE_DELETE_CHILD | \
 		FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
 
-#define SMB1_PROTO_NUMBER		cpu_to_le32(0x424d53ff)
 #define SMB_COM_NEGOTIATE		0x72
 #define SMB1_CLIENT_GUID_SIZE		(16)
 
-- 
2.43.0


