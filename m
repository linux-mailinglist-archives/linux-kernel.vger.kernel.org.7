Return-Path: <linux-kernel+bounces-887536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA5C38790
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FE144EC496
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ACC1A9FBA;
	Thu,  6 Nov 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLdvknL5"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849F4D8CE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388773; cv=none; b=NukI4bNfUup1NAc+xGKUnAvZ9fMTvQDw0bK3mwI0oMUqyqFch2Twsl79s4a7gC59QSOe4k168c/JNALrOjeXo5u4CotDw6gP1ks3utnjaJ3wTFX+T+bdVWUeq9h9Y87T7Ez/SlsGjo8joMIP/is8dKEtVUkad6KlSg0dBr6aNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388773; c=relaxed/simple;
	bh=4MYN7EAgWnSODODG6A19x6ijHGlK8gmMv8zjON/zh+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcPv8a453jfWD3HO+H477Te3aBI0WTFxjNl1EC8bUybyNT/BhoB/YBSE2WsnpvpoPg8cw0beW/qTWTVcxYrpS0joemXvoKdeZF74PbLK1K7K/yAIQJGoJv/Qxgv0C/NvABM+575iLXykFlJyi4eDDVIcn6vP7iQXHfY04EX/Ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLdvknL5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-781014f4e12so3915787b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388771; x=1762993571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj6rW30AFi0w9W9uK7Qpyv8PnHs6M2XJTUrrQLC3IC8=;
        b=BLdvknL5PQxwSWGcKz//ajzKsjybP2gL0i6pb0u1PauO8nW3YppEtUE3j//YjRXYus
         4pDmvrKEyzOZZsLnLf4njfKClfuJfPqaCbjEGura/QDOi1LL+OfLBqUB3lYEICU+yUTQ
         M+Itm4Q2I5eyAA0fNHGth3JaW4EWzn92QciUT4x/qjh07sIKJfrc6fzpLeo3iCXw8wN4
         CqulfAGsQ8FjYzWCqJ06CqSI8YR2MZdTt4uzsRbpZRYmWnBWAuO7kFox9UNadWvMCQRM
         oxTiHAjuv/EhV0LlCZ44vanOG7ZYH1j8QcLOPSu7fxlu+vx6MOGaZYRaBmkRQPXgkFFR
         /MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388771; x=1762993571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj6rW30AFi0w9W9uK7Qpyv8PnHs6M2XJTUrrQLC3IC8=;
        b=rLFBNfSlvk6bIAOe3E5Xx0gMsAifvM8m8BBdEaB423WO/VD6D2V5OfFRto0PmI9Fo2
         wSNXrWvX3RDh/U3PEhcNhizC+ZHI8fJ4l+f2HG7ltYmQajc3da+8M3xHwjwXcBTQJLZ+
         FvDBpBI7kA9nmRSHlfSDQlgmVGewh+ePNDpVkErjpThBTXqCoMbECkI9vS22/F8pEaf/
         zaLtDAphkz0fOpyhERWTdtEDCDFW9JhJLbSljrCkAQTOaKeFO70D8HEUCFjzdpeqNmPO
         5/8T5r9UT3ke9buC8mupcM9ScWYnG3TNJFEmdkemahZ5u2LCDyzAtNxSktl2Lu+H6u1F
         a8Og==
X-Forwarded-Encrypted: i=1; AJvYcCXbLSVPE/i59PMtr6E9KFJBP8P66nepP91hfmKC35KmzqYiRvmH3MEst6zvxrTREsdDB2jXWf/3huV/t64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyhyfzprmhqPdLl8g4oq+yL1lWj3HGq1uJD9RFz2Oe9HJD09s
	rx1wh8uYBSEOqu6bF+0NeS1err57HHwVmQ7E/f8f1WDMuFFRiowGNsR7
X-Gm-Gg: ASbGncuxudlDWI7c01hkHUZDjwKoDuj04WvKuX0ieXfFPJWAGLI5Yc/pneHtLylGbXY
	a8fkuAHs2o5RLKEktc5kyv/ERFk3TfoTZMJmQwPX8rHem4Igein2FhYGKqmDhsMfKSC8B3jPGZZ
	N1FXEMJjmzURaUAlvrvreKhrnE71T4wDvtOB0wJmMWf8LoMhYfOUqzttuum4PK36fB9UIEiBHBd
	pFKd7L/uVA9tzUPqD4simvM836oWqMAN9lwGrk+rpCKUoaVuFPVlhbpD/2rJvJIrpytwWxoNM7q
	5bdtNjYhkXxrWcpcrwfWSI0Baq13VRYs6fusHVlXcwoR1yMzdA9o8taJgbcm4XGgSkAjMBdHUml
	DNBoGn8vXaY1kjCeDErs05RDH4Pew3UTudMPY+VO/Q2K+IYWA2Wd1+DokPwSsoLghxptAH0KkiN
	az9OApoENk/A==
X-Google-Smtp-Source: AGHT+IFS2iWAxEnztB5To7sq/L7ysBy9qfC2JiggfaKdL+MGbkE7IAtmPDihj9rg7WJDwBFUgndIyQ==
X-Received: by 2002:a05:690c:8d14:b0:784:8b82:98d2 with SMTP id 00721157ae682-786a4213583mr42199497b3.70.1762388770706;
        Wed, 05 Nov 2025 16:26:10 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b159b666sm3400747b3.39.2025.11.05.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:10 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 1/5] psp: report basic stats from the core
Date: Wed,  5 Nov 2025 16:26:02 -0800
Message-ID: <20251106002608.1578518-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Track and report stats common to all psp devices from the core. A
'stale-event' is when the core marks the rx state of an active
psp_assoc as incapable of authenticating psp encapsulated data.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - don't return skb->len from psp_nl_get_stats_dumpit() on success and
      EMSGSIZE

 Documentation/netlink/specs/psp.yaml | 40 +++++++++++++++
 include/net/psp/types.h              |  9 ++++
 include/uapi/linux/psp.h             | 10 ++++
 net/psp/psp-nl-gen.c                 | 19 +++++++
 net/psp/psp-nl-gen.h                 |  2 +
 net/psp/psp_nl.c                     | 74 ++++++++++++++++++++++++++++
 net/psp/psp_sock.c                   |  4 +-
 7 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 944429e5c9a8..914148221384 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -76,6 +76,28 @@ attribute-sets:
         name: spi
         doc: Security Parameters Index (SPI) of the association.
         type: u32
+  -
+    name: stats
+    attributes:
+      -
+        name: dev-id
+        doc: PSP device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: key-rotations
+        type: uint
+        doc: |
+          Number of key rotations during the lifetime of the device.
+          Kernel statistic.
+      -
+        name: stale-events
+        type: uint
+        doc: |
+          Number of times a socket's Rx got shut down due to using
+          a key which went stale (fully rotated out).
+          Kernel statistic.
 
 operations:
   list:
@@ -177,6 +199,24 @@ operations:
         pre: psp-assoc-device-get-locked
         post: psp-device-unlock
 
+    -
+      name: get-stats
+      doc: Get device statistics.
+      attribute-set: stats
+      do:
+        request:
+          attributes:
+            - dev-id
+        reply: &stats-all
+          attributes:
+            - dev-id
+            - key-rotations
+            - stale-events
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+      dump:
+        reply: *stats-all
+
 mcast-groups:
   list:
     -
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 31cee64b7c86..5b0ccaac3882 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -59,6 +59,10 @@ struct psp_dev_config {
  *			device key
  * @stale_assocs:	associations which use a rotated out key
  *
+ * @stats:	statistics maintained by the core
+ * @stats.rotations:	See stats attr key-rotations
+ * @stats.stales:	See stats attr stale-events
+ *
  * @rcu:	RCU head for freeing the structure
  */
 struct psp_dev {
@@ -81,6 +85,11 @@ struct psp_dev {
 	struct list_head prev_assocs;
 	struct list_head stale_assocs;
 
+	struct {
+		unsigned long rotations;
+		unsigned long stales;
+	} stats;
+
 	struct rcu_head rcu;
 };
 
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index 607c42c39ba5..31592760ad79 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -45,6 +45,15 @@ enum {
 	PSP_A_KEYS_MAX = (__PSP_A_KEYS_MAX - 1)
 };
 
+enum {
+	PSP_A_STATS_DEV_ID = 1,
+	PSP_A_STATS_KEY_ROTATIONS,
+	PSP_A_STATS_STALE_EVENTS,
+
+	__PSP_A_STATS_MAX,
+	PSP_A_STATS_MAX = (__PSP_A_STATS_MAX - 1)
+};
+
 enum {
 	PSP_CMD_DEV_GET = 1,
 	PSP_CMD_DEV_ADD_NTF,
@@ -55,6 +64,7 @@ enum {
 	PSP_CMD_KEY_ROTATE_NTF,
 	PSP_CMD_RX_ASSOC,
 	PSP_CMD_TX_ASSOC,
+	PSP_CMD_GET_STATS,
 
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 9fdd6f831803..73f8b06d66f0 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -47,6 +47,11 @@ static const struct nla_policy psp_tx_assoc_nl_policy[PSP_A_ASSOC_SOCK_FD + 1] =
 	[PSP_A_ASSOC_SOCK_FD] = { .type = NLA_U32, },
 };
 
+/* PSP_CMD_GET_STATS - do */
+static const struct nla_policy psp_get_stats_nl_policy[PSP_A_STATS_DEV_ID + 1] = {
+	[PSP_A_STATS_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] = {
 	{
@@ -99,6 +104,20 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.maxattr	= PSP_A_ASSOC_SOCK_FD,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= PSP_CMD_GET_STATS,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_get_stats_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_get_stats_nl_policy,
+		.maxattr	= PSP_A_STATS_DEV_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= PSP_CMD_GET_STATS,
+		.dumpit	= psp_nl_get_stats_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group psp_nl_mcgrps[] = {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 25268ed11fb5..5bc3b5d5a53e 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -28,6 +28,8 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_get_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 
 enum {
 	PSP_NLGRP_MGMT,
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 8aaca62744c3..f990cccbe99c 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -262,6 +262,7 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 		     psd->generation & ~PSP_GEN_VALID_MASK);
 
 	psp_assocs_key_rotated(psd);
+	psd->stats.rotations++;
 
 	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
 	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
@@ -503,3 +504,76 @@ int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return err;
 }
+
+static int
+psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
+		  const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, PSP_A_STATS_DEV_ID, psd->id) ||
+	    nla_put_uint(rsp, PSP_A_STATS_KEY_ROTATIONS,
+			 psd->stats.rotations) ||
+	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales))
+		goto err_cancel_msg;
+
+	genlmsg_end(rsp, hdr);
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int err;
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	err = psp_nl_stats_fill(psd, rsp, info);
+	if (err)
+		goto err_free_msg;
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
+}
+
+static int
+psp_nl_stats_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
+			    struct psp_dev *psd)
+{
+	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+		return 0;
+
+	return psp_nl_stats_fill(psd, rsp, genl_info_dump(cb));
+}
+
+int psp_nl_get_stats_dumpit(struct sk_buff *rsp, struct netlink_callback *cb)
+{
+	struct psp_dev *psd;
+	int err = 0;
+
+	mutex_lock(&psp_devs_lock);
+	xa_for_each_start(&psp_devs, cb->args[0], psd, cb->args[0]) {
+		mutex_lock(&psd->lock);
+		err = psp_nl_stats_get_dumpit_one(rsp, cb, psd);
+		mutex_unlock(&psd->lock);
+		if (err)
+			break;
+	}
+	mutex_unlock(&psp_devs_lock);
+
+	return err;
+}
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a931d825d1cc..f785672b7df6 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -253,8 +253,10 @@ void psp_assocs_key_rotated(struct psp_dev *psd)
 	/* Mark the stale associations as invalid, they will no longer
 	 * be able to Rx any traffic.
 	 */
-	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
+	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list) {
 		pas->generation |= ~PSP_GEN_VALID_MASK;
+		psd->stats.stales++;
+	}
 	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
 	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
 
-- 
2.47.3


