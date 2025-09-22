Return-Path: <linux-kernel+bounces-826853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12FB8F7E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AD1638D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DD2FF142;
	Mon, 22 Sep 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxOQewYQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE92FE589
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529541; cv=none; b=ECN7iHA9dW9hdCtvPs7op7k8ptuYa2Zma8FBys4NpCvjdtvkwaWDvQGHWZ9miQsaLgXKX6S6izH4NRGQU6FmmiTHYZiUA4JRvfR7IOtqb8k1K0HDsCDxvr5kumJV1UDXv2mF0IprWGildaNio/BGmH6tSYpXWoWuUyMy9eMqPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529541; c=relaxed/simple;
	bh=1nOit7L901ciKDvZFF0ZGSU41kUhZnHJmGmuaYNl9iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXeVXBj0WAuXWV2kM6MqzFpl/RqQGvGRwLokNZaMaG1RYUNzvvImMZozQZcpZKdHLujEQ1OxGDFCa+YzvztfMVNmIFOQU8cY7LzsnJRy0He+bvdZZ0ixBxZefKfLDWBERcYzh7luaHAJxk/X3u9BOYjfNiPVBc9LrufN+9TQLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxOQewYQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24456ce0b96so44694115ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758529539; x=1759134339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqXsmgz8VSljccR1uhYEoagIoznilh6RRWXXSXAcx0E=;
        b=LxOQewYQLgeWenV8irZeXl7TV4XsGvFnWM2NXdRBRHUO9X6ZxmCEQZ9kNNaf3CvhD9
         wSGz38ixM91e/Kr+SumWFm+5ejqXn0N6LtDtrPfg/LOqFaFFYKOZo93qRCccYdFHiWL4
         55ZZfzJna7HSun8adDBx9DbfZYyeUt12d42ngWjorCw2AXRHRd9Xk5Fugzv8A9gZDTlq
         Jn7j8x0DfQ495Un2ZNAc2ZAcHEYO/NYTwGjUfr0qItcswwLaG43glM5tpqTa56epRdnl
         2ea1boWZ+gKWhvbw85DTyxunkcyZNWNZh4kTUeMT041XacfuhPa5NF06XsKHoDOJgpM+
         e2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529539; x=1759134339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqXsmgz8VSljccR1uhYEoagIoznilh6RRWXXSXAcx0E=;
        b=RSW49bTDqYQDGmzbLJHZqXmpxnA2SKZLnb2TeBO3J1PGKN4SCbhEQwAAsZrZRgSMSR
         mrV93LnagnhEN6TXAPI6emHjGFfAE3Pcs2hDOUaMj92cbWEGEJoUoe9gdQ2zff7fPjAx
         ukoiQX4spq6XzQ5YkFBTewO7pgx5Ad1K+ClvwrVLjUqflPKGBnRL/+lxBYaCHbEaPMYP
         59gkpwEw0y76dxVyLDPOL4Y74EFAtohvIL+BNhYQExVtOJItJ2LmpwSMEr/J4RXAMFfr
         l8u5l6718JvatLtkTo1bY7Td4q8Ej53E8BeWgUj8Q1KaulJUB5Affb0/3GtrPJjxA/6V
         wW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIOHFH1RP5D0YaPvFLq8q6i8BdxWXpFPCy7m5cYGyuDc/5bI9mzChpUbst/uBdqn/x0FgTBZZeF8WfY08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpbNHux3x1TJRJxiLD4RRgKtIfYd5K4twrbrmAhN07StfU/mY
	JZXQfhNwRec8FwDSxbSMRv4bR16c2wqHljRtCuQN971i+UDkoWcbFiGYRV6Y8lp+
X-Gm-Gg: ASbGncvyZUW4e16b/gIEfTZiBR0zM3VCjlfbfUqaB5GQSX3gmaCff5kw5mdUKTMNGUw
	eWvEz/3XzsHjEUf1/XL74prtiMvrpU2buG35TXDbX0XvEKyLYUoJl0MfmS2ns7c0Z9oAEedM5zJ
	RwmWCPZpuVs6/qoAEby0ZhYpwTCs/gxni3ffgLzfluaRxNXpxhN0wbLff1WWboRYDb/2oUU4GJe
	3Fav5g+fS+yKleqzpMkwCccVpwJaeJJ5R0XCVPPnckaVzF9yqqkHOdzJbr9ZxZnTm/hZ0J2UWzP
	y9Am3aWXqqliEivyaIlCoN6XyHlvUlTaSRDQlJn8BZNi+GmqLr9mn0yGNa/qs17THzDKRs1Sf0s
	XUF6NgT9swFpTygyWojmS6ofkglUo3JcjTb9sr17k7rMAqBMy4BAes7ouhbAAGpWp+LN9sLaWoM
	gOyRekms1YbAdKK64KwzjfiUfahtM=
X-Google-Smtp-Source: AGHT+IE9+KfnCYjwY3LV3+hiy0NVCLHwdJNMHkdelsG799pI4exAmvZyR/HiwfzO2gyJXIJKn5rgjA==
X-Received: by 2002:a17:903:98d:b0:272:a227:245b with SMTP id d9443c01a7336-272a2274fc9mr80880615ad.17.1758529539008;
        Mon, 22 Sep 2025 01:25:39 -0700 (PDT)
Received: from rajasilinuxtest.zztcpmrl4zvulnxionwmgqorff.rx.internal.cloudapp.net ([40.81.226.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980318743sm122818375ad.118.2025.09.22.01.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:25:38 -0700 (PDT)
From: rajasimandalos@gmail.com
To: linux-cifs@vger.kernel.org
Cc: sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	linux-kernel@vger.kernel.org,
	Rajasi Mandal <rajasimandal@microsoft.com>
Subject: [PATCH 2/2] cifs: client: allow changing multichannel mount options on remount
Date: Mon, 22 Sep 2025 08:24:17 +0000
Message-ID: <20250922082417.816331-2-rajasimandalos@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922082417.816331-1-rajasimandalos@gmail.com>
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajasi Mandal <rajasimandal@microsoft.com>

Previously, the client did not properly update the session's channel
state when multichannel or max_channels mount options were changed
during remount. This led to inconsistent behavior and prevented
enabling or disabling multichannel support without a full
unmount/remount.

Enable dynamic reconfiguration of multichannel and max_channels
options during remount by introducing smb3_sync_ses_chan_max() to
safely update the session's chan_max field, and smb3_sync_ses_channels()
to synchronize the session's channels with the new configuration.
Replace cifs_disable_secondary_channels() with
cifs_decrease_secondary_channels(), which now takes a from_reconfigure
argument for more flexible channel cleanup. Update the remount logic
to detect changes in multichannel or max_channels and trigger the
appropriate session/channel updates.

With this change, users can safely change multichannel and
max_channels options on remount, and the client will correctly adjust
the session's channel state to match the new configuration.

Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
---
 fs/smb/client/cifsproto.h  |  2 +-
 fs/smb/client/fs_context.c | 29 ++++++++++++++++++
 fs/smb/client/fs_context.h |  2 +-
 fs/smb/client/sess.c       | 35 +++++++++++++++-------
 fs/smb/client/smb2pdu.c    | 60 ++++++++++++++++++++++++++++++--------
 fs/smb/client/smb2pdu.h    |  2 ++
 6 files changed, 105 insertions(+), 25 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index e8fba98690ce..ec3118457b26 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -667,7 +667,7 @@ bool
 cifs_chan_is_iface_active(struct cifs_ses *ses,
 			  struct TCP_Server_Info *server);
 void
-cifs_disable_secondary_channels(struct cifs_ses *ses);
+cifs_decrease_secondary_channels(struct cifs_ses *ses, bool from_reconfigure);
 void
 cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
 int
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 43552b44f613..96e80c70f25d 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1015,6 +1015,22 @@ int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb, struct cifs_se
 	return 0;
 }
 
+/**
+ * smb3_sync_ses_chan_max - Synchronize the session's maximum channel count
+ * @ses: pointer to the old CIFS session structure
+ * @max_channels: new maximum number of channels to allow
+ *
+ * Updates the session's chan_max field to the new value, protecting the update
+ * with the session's channel lock. This should be called whenever the maximum
+ * allowed channels for a session changes (e.g., after a remount or reconfigure).
+ */
+void smb3_sync_ses_chan_max(struct cifs_ses *ses, unsigned int max_channels)
+{
+	spin_lock(&ses->chan_lock);
+	ses->chan_max = max_channels;
+	spin_unlock(&ses->chan_lock);
+}
+
 static int smb3_reconfigure(struct fs_context *fc)
 {
 	struct smb3_fs_context *ctx = smb3_fc2context(fc);
@@ -1097,6 +1113,18 @@ static int smb3_reconfigure(struct fs_context *fc)
 		ses->password2 = new_password2;
 	}
 
+	/*
+	 * If multichannel or max_channels has changed, update the session's channels accordingly.
+	 * This may add or remove channels to match the new configuration.
+	 */
+	if ((ctx->multichannel != cifs_sb->ctx->multichannel) ||
+		(ctx->max_channels != cifs_sb->ctx->max_channels)) {
+		//Synchronize ses->chan_max with the new mount context
+		smb3_sync_ses_chan_max(ses, ctx->max_channels);
+		//Now update the session's channels to match the new configuration
+		rc = smb3_sync_ses_channels(cifs_sb);
+	}
+
 	mutex_unlock(&ses->session_mutex);
 
 	STEAL_STRING(cifs_sb, ctx, domainname);
@@ -1110,6 +1138,7 @@ static int smb3_reconfigure(struct fs_context *fc)
 	smb3_cleanup_fs_context_contents(cifs_sb->ctx);
 	rc = smb3_fs_context_dup(cifs_sb->ctx, ctx);
 	smb3_update_mnt_flags(cifs_sb);
+
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	if (!rc)
 		rc = dfs_cache_remount_fs(cifs_sb);
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index b0fec6b9a23b..a75185858285 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -371,7 +371,7 @@ static inline struct smb3_fs_context *smb3_fc2context(const struct fs_context *f
 extern int smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx);
 extern int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
 extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
-
+extern void smb3_sync_ses_chan_max(struct cifs_ses *ses, unsigned int max_channels);
 /*
  * max deferred close timeout (jiffies) - 2^30
  */
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 0a8c2fcc9ded..42b5481c884a 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -264,13 +264,16 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 	return new_chan_count - old_chan_count;
 }
 
-/*
- * called when multichannel is disabled by the server.
- * this always gets called from smb2_reconnect
- * and cannot get called in parallel threads.
+/**
+ * cifs_decrease_secondary_channels - Reduce the number of active secondary channels
+ * @ses: pointer to the CIFS session structure
+ * @from_reconfigure: if true, only reduce to chan_max; if false, reduce to a single channel
+ *
+ * This function disables and cleans up extra secondary channels for a CIFS session.
+ * If called during reconfiguration, it reduces the channel count to the new maximum (chan_max).
+ * Otherwise, it disables all but the primary channel.
  */
-void
-cifs_disable_secondary_channels(struct cifs_ses *ses)
+void cifs_decrease_secondary_channels(struct cifs_ses *ses, bool from_reconfigure)
 {
 	int i, chan_count;
 	struct TCP_Server_Info *server;
@@ -281,12 +284,13 @@ cifs_disable_secondary_channels(struct cifs_ses *ses)
 	if (chan_count == 1)
 		goto done;
 
-	ses->chan_count = 1;
-
-	/* for all secondary channels reset the need reconnect bit */
-	ses->chans_need_reconnect &= 1;
+	// Update the chan_count to the new maximum
+	if (from_reconfigure)
+		ses->chan_count = ses->chan_max;
+	else
+		ses->chan_count = 1;
 
-	for (i = 1; i < chan_count; i++) {
+	for (i = ses->chan_max ; i < chan_count; i++) {
 		iface = ses->chans[i].iface;
 		server = ses->chans[i].server;
 
@@ -318,6 +322,15 @@ cifs_disable_secondary_channels(struct cifs_ses *ses)
 		spin_lock(&ses->chan_lock);
 	}
 
+	/* For extra secondary channels, reset the need reconnect bit */
+	if (ses->chan_count == 1) {
+		cifs_server_dbg(VFS, "server does not support multichannel anymore. Disable all other channels\n");
+		ses->chans_need_reconnect &= 1;
+	} else {
+		cifs_server_dbg(VFS, "Disable extra secondary channels\n");
+		ses->chans_need_reconnect &= ((1UL << ses->chan_max) - 1);
+	}
+
 done:
 	spin_unlock(&ses->chan_lock);
 }
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c3b9d3f6210f..bf9a8dc0e8fc 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -168,7 +168,7 @@ smb2_hdr_assemble(struct smb2_hdr *shdr, __le16 smb2_cmd,
 static int
 cifs_chan_skip_or_disable(struct cifs_ses *ses,
 			  struct TCP_Server_Info *server,
-			  bool from_reconnect)
+			  bool from_reconnect, bool from_reconfigure)
 {
 	struct TCP_Server_Info *pserver;
 	unsigned int chan_index;
@@ -206,10 +206,49 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
 		return -EHOSTDOWN;
 	}
 
-	cifs_server_dbg(VFS,
-		"server does not support multichannel anymore. Disable all other channels\n");
-	cifs_disable_secondary_channels(ses);
+	cifs_decrease_secondary_channels(ses, from_reconfigure);
 
+	return 0;
+}
+
+/**
+ * smb3_sync_ses_channels - Synchronize session channels
+ * with new configuration (cifs_sb_info version)
+ * @cifs_sb: pointer to the CIFS superblock info structure
+ * Returns 0 on success or -EINVAL if scaling is already in progress.
+ */
+int smb3_sync_ses_channels(struct cifs_sb_info *cifs_sb)
+{
+	struct cifs_ses *ses = cifs_sb_master_tcon(cifs_sb)->ses;
+	struct smb3_fs_context *ctx = cifs_sb->ctx;
+	bool from_reconnect = false;
+
+	/* Prevent concurrent scaling operations */
+	spin_lock(&ses->ses_lock);
+	if (ses->flags & CIFS_SES_FLAG_SCALE_CHANNELS) {
+		spin_unlock(&ses->ses_lock);
+		return -EINVAL;
+	}
+	ses->flags |= CIFS_SES_FLAG_SCALE_CHANNELS;
+	spin_unlock(&ses->ses_lock);
+
+	/*
+	 * If the old max_channels is less than the new chan_max,
+	 * try to add channels to reach the new maximum.
+	 * Otherwise, disable or skip extra channels to match the new configuration.
+	 */
+	if (ctx->max_channels < ses->chan_max) {
+		mutex_unlock(&ses->session_mutex);
+		cifs_try_adding_channels(ses);
+		mutex_lock(&ses->session_mutex);
+	} else {
+		cifs_chan_skip_or_disable(ses, ses->server, from_reconnect, true);
+	}
+
+	/* Clear scaling flag after operation */
+	spin_lock(&ses->ses_lock);
+	ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
+	spin_unlock(&ses->ses_lock);
 
 	return 0;
 }
@@ -356,7 +395,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (ses->chan_count > 1 &&
 	    !(server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
 		rc = cifs_chan_skip_or_disable(ses, server,
-					       from_reconnect);
+					       from_reconnect, false);
 		if (rc) {
 			mutex_unlock(&ses->session_mutex);
 			goto out;
@@ -439,7 +478,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 			 */
 
 			rc = cifs_chan_skip_or_disable(ses, server,
-						       from_reconnect);
+						       from_reconnect, false);
 			goto skip_add_channels;
 		} else if (rc)
 			cifs_dbg(FYI, "%s: failed to query server interfaces: %d\n",
@@ -1105,8 +1144,7 @@ SMB2_negotiate(const unsigned int xid,
 		req->SecurityMode = 0;
 
 	req->Capabilities = cpu_to_le32(server->vals->req_capabilities);
-	if (ses->chan_max > 1)
-		req->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
+	req->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
 
 	/* ClientGUID must be zero for SMB2.02 dialect */
 	if (server->vals->protocol_id == SMB20_PROT_ID)
@@ -1310,10 +1348,8 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	if (!pneg_inbuf)
 		return -ENOMEM;
 
-	pneg_inbuf->Capabilities =
-			cpu_to_le32(server->vals->req_capabilities);
-	if (tcon->ses->chan_max > 1)
-		pneg_inbuf->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
+	pneg_inbuf->Capabilities = cpu_to_le32(server->vals->req_capabilities);
+	pneg_inbuf->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
 
 	memcpy(pneg_inbuf->Guid, server->client_guid,
 					SMB2_CLIENT_GUID_SIZE);
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 3c09a58dfd07..d3f63a4ef426 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -420,6 +420,8 @@ struct smb2_create_ea_ctx {
 	struct smb2_file_full_ea_info ea;
 } __packed;
 
+int smb3_sync_ses_channels(struct cifs_sb_info *cifs_sb);
+
 #define SMB2_WSL_XATTR_UID		"$LXUID"
 #define SMB2_WSL_XATTR_GID		"$LXGID"
 #define SMB2_WSL_XATTR_MODE		"$LXMOD"
-- 
2.43.0


