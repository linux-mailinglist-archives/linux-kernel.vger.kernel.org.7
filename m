Return-Path: <linux-kernel+bounces-893547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B361C47B84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FD494FA335
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BB274FE8;
	Mon, 10 Nov 2025 15:46:38 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171628466F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789598; cv=none; b=WXlSpslYG1kUljjD3SmjQ+hY5/MNxOL08MuHh/UzIvIyRxk4M/wqfSOqaAef7slS0sh+A5zsybywevmWO5rfEm3bcNtgATdlzdT0Xf/YmouKZOgAN5pGfMGgzKnsy+v6PKw2FcZsINbjonqYBCP2H/gmo2cc9KRvGbQTWuRbnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789598; c=relaxed/simple;
	bh=dM9bmM9py3GYfWcHuKRXV4WzQoK5kgYEqjdYxCIYtcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1Fz9UZIMzrkREG0OFhmlGE7/M8aw+r5/nGJzad6ZIPV7/53ZYv8lLUzY+4Z94fyCfTwLtmYtqt+lfsR2Aa3doev8NVys1NUpRCcrwYbtd4SuqXGhSeEv1lia1UNH0yb4TMMbbiC4gIt8CpVS6xWkckfG4io18AKbLyMkfxQ5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 431BF204AB;
	Mon, 10 Nov 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA51B14485;
	Mon, 10 Nov 2025 15:46:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aKbzL80IEmlHXQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 10 Nov 2025 15:46:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	francesco@valla.it,
	rrameshbabu@nvidia.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/3] drm/client: log: Implement struct drm_client_funcs.restore
Date: Mon, 10 Nov 2025 16:44:23 +0100
Message-ID: <20251110154616.539328-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154616.539328-1-tzimmermann@suse.de>
References: <20251110154616.539328-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 431BF204AB
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

Restore the log client's output when the DRM core invokes the restore
callback. Follow the existing behavior of fbdev emulation wrt. the
value of the force parameter.

If force is false, acquire the DRM master lock and reprogram the
display. This is the case when the user-space compositor exits and
the DRM core transfers the display back to the in-kernel client. This
also enables drm_log output during reboot and shutdown.

If force is true, reprogram without considering the master lock. This
overrides the current compositor and prints the log to the screen. In
case of system malfunction, users can enter SysRq+v to invoke the
emergency error reporting. See Documentation/admin-guide/sysrq.rst for
more information.

v2:
- s/exists/exits/ in second paragraph of commit description
- fix grammar in commit description

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/clients/drm_log.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 19e55aa0ed74..4d3005273b27 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -315,6 +315,18 @@ static void drm_log_client_unregister(struct drm_client_dev *client)
 	drm_client_release(client);
 }
 
+static int drm_log_client_restore(struct drm_client_dev *client, bool force)
+{
+	int ret;
+
+	if (force)
+		ret = drm_client_modeset_commit_locked(client);
+	else
+		ret = drm_client_modeset_commit(client);
+
+	return ret;
+}
+
 static int drm_log_client_hotplug(struct drm_client_dev *client)
 {
 	struct drm_log *dlog = client_to_drm_log(client);
@@ -348,6 +360,7 @@ static const struct drm_client_funcs drm_log_client_funcs = {
 	.owner		= THIS_MODULE,
 	.free		= drm_log_client_free,
 	.unregister	= drm_log_client_unregister,
+	.restore	= drm_log_client_restore,
 	.hotplug	= drm_log_client_hotplug,
 	.suspend	= drm_log_client_suspend,
 	.resume		= drm_log_client_resume,
-- 
2.51.1


