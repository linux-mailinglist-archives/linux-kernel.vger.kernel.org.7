Return-Path: <linux-kernel+bounces-827478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0AB91DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95E63B7404
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE72DEA89;
	Mon, 22 Sep 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R5Q94wru";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g8iP3Ckm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R5Q94wru";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g8iP3Ckm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723E2836F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553983; cv=none; b=sKd/SIDIhV2roTbJWLL9RfRXZ9V9CEpSqHZmYQ7yy3PBmrRG/4Xslx/ggE8Ta9uqCBCcIV+c/WBaszvD8Gjx3oiyBXhrjwtQ3FKoUVmvYRfOjj5yehK/Asstp6HnVYQRtNPeKwwCaJsb47SfXEUuoapwm/njWvG3qCq9LTgTUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553983; c=relaxed/simple;
	bh=W2MiAeKT/PpUdqaJHr/nu6EjcnO1treoMo0+c39fcIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFp646K+Yb6dk+ApabqJ7clgBErHTaLF600XEiHdQYNsAwjz7FsiJCgp4sgUsTboO7eCqx97fXDxMRkyV1clmWxXxBHTDYKva1WYe+CtEhu9bSq4tEgK7ckbbrpDNCW7PqC5UqypPUmZqmhg2PofJTbV3X2kLbdqhUuCGU268jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R5Q94wru; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g8iP3Ckm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R5Q94wru; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g8iP3Ckm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 906F21F395;
	Mon, 22 Sep 2025 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758553979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4LeobZZCXAiyB0HIEqZ5K95uUEhlhXloBIYiWc7Sec=;
	b=R5Q94wruBizo/sUhN2GTsvldgJdpwCe/AtP1RP9HT5BDduGQ4tlgr32lNCGwNInmJqdO7m
	g7WpppVthfw7V4qB88RWzPEpey+kgkDI7IJ8UgT1jSLz94EAQpeHLtCSNb8E7B8IXAgvhN
	nAHbSEtnb//f7kQU4uJI/s0Nsl8Iew8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758553979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4LeobZZCXAiyB0HIEqZ5K95uUEhlhXloBIYiWc7Sec=;
	b=g8iP3Ckm8nWpSr8jHzdnHugBJlIVIopJsEps+7e6yjPQwcWHeZ6EWwv7PWSQ63rDWMl+ww
	OqSotRvql4hz7cDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R5Q94wru;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g8iP3Ckm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758553979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4LeobZZCXAiyB0HIEqZ5K95uUEhlhXloBIYiWc7Sec=;
	b=R5Q94wruBizo/sUhN2GTsvldgJdpwCe/AtP1RP9HT5BDduGQ4tlgr32lNCGwNInmJqdO7m
	g7WpppVthfw7V4qB88RWzPEpey+kgkDI7IJ8UgT1jSLz94EAQpeHLtCSNb8E7B8IXAgvhN
	nAHbSEtnb//f7kQU4uJI/s0Nsl8Iew8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758553979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4LeobZZCXAiyB0HIEqZ5K95uUEhlhXloBIYiWc7Sec=;
	b=g8iP3Ckm8nWpSr8jHzdnHugBJlIVIopJsEps+7e6yjPQwcWHeZ6EWwv7PWSQ63rDWMl+ww
	OqSotRvql4hz7cDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1454E1388C;
	Mon, 22 Sep 2025 15:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ulxsM3pn0WgfHwAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Mon, 22 Sep 2025 15:12:58 +0000
Date: Mon, 22 Sep 2025 12:12:56 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: rajasimandalos@gmail.com
Cc: linux-cifs@vger.kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-kernel@vger.kernel.org, Rajasi Mandal <rajasimandal@microsoft.com>
Subject: Re: [PATCH 2/2] cifs: client: allow changing multichannel mount
 options on remount
Message-ID: <4htyleuklcdod3togdqcjl5w7g3j5cmwcc4bww5knlwgwhtsbd@a7s2fa2nvcup>
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
 <20250922082417.816331-2-rajasimandalos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250922082417.816331-2-rajasimandalos@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 906F21F395
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On 09/22, rajasimandalos@gmail.com wrote:
>From: Rajasi Mandal <rajasimandal@microsoft.com>
>
>Previously, the client did not properly update the session's channel
>state when multichannel or max_channels mount options were changed
>during remount. This led to inconsistent behavior and prevented
>enabling or disabling multichannel support without a full
>unmount/remount.
>
>Enable dynamic reconfiguration of multichannel and max_channels
>options during remount by introducing smb3_sync_ses_chan_max() to
>safely update the session's chan_max field, and smb3_sync_ses_channels()
>to synchronize the session's channels with the new configuration.
>Replace cifs_disable_secondary_channels() with
>cifs_decrease_secondary_channels(), which now takes a from_reconfigure
>argument for more flexible channel cleanup. Update the remount logic
>to detect changes in multichannel or max_channels and trigger the
>appropriate session/channel updates.
>
>With this change, users can safely change multichannel and
>max_channels options on remount, and the client will correctly adjust
>the session's channel state to match the new configuration.
>
>Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
>---
> fs/smb/client/cifsproto.h  |  2 +-
> fs/smb/client/fs_context.c | 29 ++++++++++++++++++
> fs/smb/client/fs_context.h |  2 +-
> fs/smb/client/sess.c       | 35 +++++++++++++++-------
> fs/smb/client/smb2pdu.c    | 60 ++++++++++++++++++++++++++++++--------
> fs/smb/client/smb2pdu.h    |  2 ++
> 6 files changed, 105 insertions(+), 25 deletions(-)

I think the fix is necessary, and the implementation works (at least
with the simple case I tested).  I just think we now have too many
functions related to channel adding/removing/updating and they're all
too similar.  IMHO they could all be merged into a single "update
channels" one.

Do you think it's possible to do that?  Probably would require a bit
more work, but at least we would end up with a centralized place to deal
with channel management.

>diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
>index e8fba98690ce..ec3118457b26 100644
>--- a/fs/smb/client/cifsproto.h
>+++ b/fs/smb/client/cifsproto.h
>@@ -667,7 +667,7 @@ bool
> cifs_chan_is_iface_active(struct cifs_ses *ses,
> 			  struct TCP_Server_Info *server);
> void
>-cifs_disable_secondary_channels(struct cifs_ses *ses);
>+cifs_decrease_secondary_channels(struct cifs_ses *ses, bool from_reconfigure);
> void
> cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
> int
>diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
>index 43552b44f613..96e80c70f25d 100644
>--- a/fs/smb/client/fs_context.c
>+++ b/fs/smb/client/fs_context.c
>@@ -1015,6 +1015,22 @@ int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb, struct cifs_se
> 	return 0;
> }
>
>+/**
>+ * smb3_sync_ses_chan_max - Synchronize the session's maximum channel count
>+ * @ses: pointer to the old CIFS session structure
>+ * @max_channels: new maximum number of channels to allow
>+ *
>+ * Updates the session's chan_max field to the new value, protecting the update
>+ * with the session's channel lock. This should be called whenever the maximum
>+ * allowed channels for a session changes (e.g., after a remount or reconfigure).
>+ */
>+void smb3_sync_ses_chan_max(struct cifs_ses *ses, unsigned int max_channels)
>+{
>+	spin_lock(&ses->chan_lock);
>+	ses->chan_max = max_channels;
>+	spin_unlock(&ses->chan_lock);
>+}
>+
> static int smb3_reconfigure(struct fs_context *fc)
> {
> 	struct smb3_fs_context *ctx = smb3_fc2context(fc);
>@@ -1097,6 +1113,18 @@ static int smb3_reconfigure(struct fs_context *fc)
> 		ses->password2 = new_password2;
> 	}
>
>+	/*
>+	 * If multichannel or max_channels has changed, update the session's channels accordingly.
>+	 * This may add or remove channels to match the new configuration.
>+	 */
>+	if ((ctx->multichannel != cifs_sb->ctx->multichannel) ||
>+		(ctx->max_channels != cifs_sb->ctx->max_channels)) {
>+		//Synchronize ses->chan_max with the new mount context
>+		smb3_sync_ses_chan_max(ses, ctx->max_channels);
>+		//Now update the session's channels to match the new configuration
>+		rc = smb3_sync_ses_channels(cifs_sb);
>+	}
>+
> 	mutex_unlock(&ses->session_mutex);
>
> 	STEAL_STRING(cifs_sb, ctx, domainname);
>@@ -1110,6 +1138,7 @@ static int smb3_reconfigure(struct fs_context *fc)
> 	smb3_cleanup_fs_context_contents(cifs_sb->ctx);
> 	rc = smb3_fs_context_dup(cifs_sb->ctx, ctx);
> 	smb3_update_mnt_flags(cifs_sb);
>+
> #ifdef CONFIG_CIFS_DFS_UPCALL
> 	if (!rc)
> 		rc = dfs_cache_remount_fs(cifs_sb);
>diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
>index b0fec6b9a23b..a75185858285 100644
>--- a/fs/smb/client/fs_context.h
>+++ b/fs/smb/client/fs_context.h
>@@ -371,7 +371,7 @@ static inline struct smb3_fs_context *smb3_fc2context(const struct fs_context *f
> extern int smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx);
> extern int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
> extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
>-
>+extern void smb3_sync_ses_chan_max(struct cifs_ses *ses, unsigned int max_channels);
> /*
>  * max deferred close timeout (jiffies) - 2^30
>  */
>diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
>index 0a8c2fcc9ded..42b5481c884a 100644
>--- a/fs/smb/client/sess.c
>+++ b/fs/smb/client/sess.c
>@@ -264,13 +264,16 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
> 	return new_chan_count - old_chan_count;
> }
>
>-/*
>- * called when multichannel is disabled by the server.
>- * this always gets called from smb2_reconnect
>- * and cannot get called in parallel threads.
>+/**
>+ * cifs_decrease_secondary_channels - Reduce the number of active secondary channels
>+ * @ses: pointer to the CIFS session structure
>+ * @from_reconfigure: if true, only reduce to chan_max; if false, reduce to a single channel
>+ *
>+ * This function disables and cleans up extra secondary channels for a CIFS session.
>+ * If called during reconfiguration, it reduces the channel count to the new maximum (chan_max).
>+ * Otherwise, it disables all but the primary channel.
>  */
>-void
>-cifs_disable_secondary_channels(struct cifs_ses *ses)
>+void cifs_decrease_secondary_channels(struct cifs_ses *ses, bool from_reconfigure)
> {
> 	int i, chan_count;
> 	struct TCP_Server_Info *server;
>@@ -281,12 +284,13 @@ cifs_disable_secondary_channels(struct cifs_ses *ses)
> 	if (chan_count == 1)
> 		goto done;
>
>-	ses->chan_count = 1;
>-
>-	/* for all secondary channels reset the need reconnect bit */
>-	ses->chans_need_reconnect &= 1;
>+	// Update the chan_count to the new maximum
>+	if (from_reconfigure)
>+		ses->chan_count = ses->chan_max;
>+	else
>+		ses->chan_count = 1;
>
>-	for (i = 1; i < chan_count; i++) {
>+	for (i = ses->chan_max ; i < chan_count; i++) {
> 		iface = ses->chans[i].iface;
> 		server = ses->chans[i].server;
>
>@@ -318,6 +322,15 @@ cifs_disable_secondary_channels(struct cifs_ses *ses)
> 		spin_lock(&ses->chan_lock);
> 	}
>
>+	/* For extra secondary channels, reset the need reconnect bit */
>+	if (ses->chan_count == 1) {
>+		cifs_server_dbg(VFS, "server does not support multichannel anymore. Disable all other channels\n");
>+		ses->chans_need_reconnect &= 1;
>+	} else {
>+		cifs_server_dbg(VFS, "Disable extra secondary channels\n");
>+		ses->chans_need_reconnect &= ((1UL << ses->chan_max) - 1);
>+	}
>+
> done:
> 	spin_unlock(&ses->chan_lock);
> }
>diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
>index c3b9d3f6210f..bf9a8dc0e8fc 100644
>--- a/fs/smb/client/smb2pdu.c
>+++ b/fs/smb/client/smb2pdu.c
>@@ -168,7 +168,7 @@ smb2_hdr_assemble(struct smb2_hdr *shdr, __le16 smb2_cmd,
> static int
> cifs_chan_skip_or_disable(struct cifs_ses *ses,
> 			  struct TCP_Server_Info *server,
>-			  bool from_reconnect)
>+			  bool from_reconnect, bool from_reconfigure)
> {
> 	struct TCP_Server_Info *pserver;
> 	unsigned int chan_index;
>@@ -206,10 +206,49 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
> 		return -EHOSTDOWN;
> 	}
>
>-	cifs_server_dbg(VFS,
>-		"server does not support multichannel anymore. Disable all other channels\n");
>-	cifs_disable_secondary_channels(ses);
>+	cifs_decrease_secondary_channels(ses, from_reconfigure);
>
>+	return 0;
>+}
>+
>+/**
>+ * smb3_sync_ses_channels - Synchronize session channels
>+ * with new configuration (cifs_sb_info version)
>+ * @cifs_sb: pointer to the CIFS superblock info structure
>+ * Returns 0 on success or -EINVAL if scaling is already in progress.
>+ */
>+int smb3_sync_ses_channels(struct cifs_sb_info *cifs_sb)
>+{
>+	struct cifs_ses *ses = cifs_sb_master_tcon(cifs_sb)->ses;
>+	struct smb3_fs_context *ctx = cifs_sb->ctx;
>+	bool from_reconnect = false;
>+
>+	/* Prevent concurrent scaling operations */
>+	spin_lock(&ses->ses_lock);
>+	if (ses->flags & CIFS_SES_FLAG_SCALE_CHANNELS) {
>+		spin_unlock(&ses->ses_lock);
>+		return -EINVAL;
>+	}
>+	ses->flags |= CIFS_SES_FLAG_SCALE_CHANNELS;
>+	spin_unlock(&ses->ses_lock);
>+
>+	/*
>+	 * If the old max_channels is less than the new chan_max,
>+	 * try to add channels to reach the new maximum.
>+	 * Otherwise, disable or skip extra channels to match the new configuration.
>+	 */
>+	if (ctx->max_channels < ses->chan_max) {
>+		mutex_unlock(&ses->session_mutex);
>+		cifs_try_adding_channels(ses);
>+		mutex_lock(&ses->session_mutex);
>+	} else {
>+		cifs_chan_skip_or_disable(ses, ses->server, from_reconnect, true);
>+	}
>+
>+	/* Clear scaling flag after operation */
>+	spin_lock(&ses->ses_lock);
>+	ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
>+	spin_unlock(&ses->ses_lock);
>
> 	return 0;
> }
>@@ -356,7 +395,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
> 	if (ses->chan_count > 1 &&
> 	    !(server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
> 		rc = cifs_chan_skip_or_disable(ses, server,
>-					       from_reconnect);
>+					       from_reconnect, false);
> 		if (rc) {
> 			mutex_unlock(&ses->session_mutex);
> 			goto out;
>@@ -439,7 +478,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
> 			 */
>
> 			rc = cifs_chan_skip_or_disable(ses, server,
>-						       from_reconnect);
>+						       from_reconnect, false);
> 			goto skip_add_channels;
> 		} else if (rc)
> 			cifs_dbg(FYI, "%s: failed to query server interfaces: %d\n",

(for all hunks above) Can we stick to /* */ comments instead of //
please?

>@@ -1105,8 +1144,7 @@ SMB2_negotiate(const unsigned int xid,
> 		req->SecurityMode = 0;
>
> 	req->Capabilities = cpu_to_le32(server->vals->req_capabilities);
>-	if (ses->chan_max > 1)
>-		req->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
>+	req->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
>
> 	/* ClientGUID must be zero for SMB2.02 dialect */
> 	if (server->vals->protocol_id == SMB20_PROT_ID)
>@@ -1310,10 +1348,8 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
> 	if (!pneg_inbuf)
> 		return -ENOMEM;
>
>-	pneg_inbuf->Capabilities =
>-			cpu_to_le32(server->vals->req_capabilities);
>-	if (tcon->ses->chan_max > 1)
>-		pneg_inbuf->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
>+	pneg_inbuf->Capabilities = cpu_to_le32(server->vals->req_capabilities);
>+	pneg_inbuf->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);

This effectively makes query_interfaces worker run even with
max_channels=1 -- just a heads up because it didn't look like your
original intention.


Cheers,

Enzo

