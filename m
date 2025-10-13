Return-Path: <linux-kernel+bounces-850809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 556DBBD3D57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B576E3439F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1DB30FC04;
	Mon, 13 Oct 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwMBQcd8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F530F7E7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367216; cv=none; b=roXUgR+0mhwHwopEkah65GfUYY8pn+b+yyYo0vR0N4Wp4rxQTbQ9+xnNo2gF2P+mUCH7S4/VQPO8iLM4wwfsLah+eZjafgVVQp0c4XX8zZXuh0pC1xuhI1mWwJ6iEzRQfU/jbQPxP65KqVWs6M3NjyZWbBGjzqySReZNQaDcbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367216; c=relaxed/simple;
	bh=kO++hqsqbVoh9SPKYKuZkXB0HqP9mKYieWTgGp5QmOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB3Hy7NWUNZWoVyJRbpaV2OaSNoYD1D/bcTBTcjSWNs6hqipugxtxmn5hbeUtfkqZWsLU/Q/6o2PuZ51/rHWCCWg0w5Zk2xtIeK56Mhst3yqvlPDPh8X+X+ZHEHOJal9HXSqRGITl6XrfazwxudnEtmYWRomiMuvOBqRohRoIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwMBQcd8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so44343325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367212; x=1760972012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/S0lTizHDTDClQAPhS8aQBa6cUKMUxs8/coO2Ar/bs=;
        b=LwMBQcd87j/WrjYxRbL4Gl5oLQsOynEFPHXfyrYWH3SHXhURp90qFhlvm1LVwBPIBm
         cnEOAUH+La7y81fMqZ/0A0CSYV/xxJ0ROju+R0m6i32eXqKakYB9gMibCQOWlk7qo/ko
         LYaFNhHVxSoRLvaaGFqrfeBAqk19dJRjnAKhQ6uzUPApDMVbRbi8/nCH7Tf9fqFXPwxU
         q5QVTCSDQthgVmP5BvrVunuUi99gEtHH2lclEUgMqGlD3dLL42e7TlOcaRG2LAu3dI0t
         vDRn+a+7AsbqAV6GxozDuvUQn3PGTdXtflTiWj42llGP4L7ik6Aa0K376qitBlVppAfW
         ABwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367212; x=1760972012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/S0lTizHDTDClQAPhS8aQBa6cUKMUxs8/coO2Ar/bs=;
        b=MsETaK+j77TC9S2y3r0ATs97Kln7T8hpQXetYPlO7XSIFaDrlfxM1qsy6QVHNAEqti
         E2CdXNIhMrHlZMYHCUuOuAL3mcmz2HLkgcuhYzuAAW2GSD4xp9y9P+s+XQwXBRWu6ShB
         AeP5UjkLrvYWcSOj1FUR9Gq+PKEvZB2p7dNfsxZb0G4yfRT5GtmM2pSG71X5LeOSj7bC
         X0IcNnlaWjFsFbuz7z/8XvISj8l/dFvDQXfGIEy9wFj0svJ72+DrVx55T6wETjr1MBVk
         nYUPmt3BeOCcTeoDE+WUATYRNAzmIkWu7bX4Vd9ogfvDbTzgspoPwPL+CpoD6rje7u1g
         JI0w==
X-Forwarded-Encrypted: i=1; AJvYcCWZjxxK9SPjtXQmZsAE+hbmmtlGNB3D8DQeMoX75l3wk0khreSddgj+CfHHT9ETBJvbADyg0ou2lhQ4uWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKBMnS7g5yB+v9eDB7Ylk1JvsmV6voFISl9yRLTQ4tg/N3s0u
	8Cw9RSBIQIkdFXhmD737a/xQATkoBXXRyzHFng3xeBVdp2xA8oyAnhv4
X-Gm-Gg: ASbGnctOiXUORVAurIQALwRnmGobPr4bqjHQXrO0HIl9C9TREJpdMWVq5iRLfBZHrpK
	E/NxIz77iwDBuzOSryfDIOZFElr32Ech/c1+x3erj1B23VG2dt/LC4EwWuuCvDFfoMrN4Sphj9W
	lWMtKJCTAZfFEbxGqCBI066WkHLG0ysYRfJ54HHL3p6BvNMSRK+8vr1jBoZDfV7PNoJZX/0Vb2L
	Xwxds+9by4ZnW3mZ/UIDjOVLksYI3O9ntlYdibo4pcDlRwTifhEA8T4VXWqQDhSxOOaNJiVyels
	JGNOECl8bYvb/bnXSOXBcpONLz/5Dp/8+SHh2C29GWtp0v/e9JcYs0+oawp4zgoPRidmJKC7Rd4
	egHs4dCol/s/TwzXO4KVLxY/86M+rmxS2ZxY=
X-Google-Smtp-Source: AGHT+IG30NLodqm5i6iZDMho0lRpiDey3nRByT9wCK+VDN0c//YQ5bDi8+c0ePHSQFGrSdh/9vp0GA==
X-Received: by 2002:a05:600c:1394:b0:46e:432f:32ab with SMTP id 5b1f17b1804b1-46fa9b1704emr157969575e9.33.1760367212016;
        Mon, 13 Oct 2025 07:53:32 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:31 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 06/24] net: clarify the meaning of netdev_config members
Date: Mon, 13 Oct 2025 15:54:08 +0100
Message-ID: <fa4a6200c614f9f6652624b03e46b3bfa2539a72.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

hds_thresh and hds_config are both inside struct netdev_config
but have quite different semantics. hds_config is the user config
with ternary semantics (on/off/unset). hds_thresh is a straight
up value, populated by the driver at init and only modified by
user space. We don't expect the drivers to have to pick a special
hds_thresh value based on other configuration.

The two approaches have different advantages and downsides.
hds_thresh ("direct value") gives core easy access to current
device settings, but there's no way to express whether the value
comes from the user. It also requires the initialization by
the driver.

hds_config ("user config values") tells us what user wanted, but
doesn't give us the current value in the core.

Try to explain this a bit in the comments, so at we make a conscious
choice for new values which semantics we expect.

Move the init inside ethtool_ringparam_get_cfg() to reflect the semantics.
Commit 216a61d33c07 ("net: ethtool: fix ethtool_ringparam_get_cfg()
returns a hds_thresh value always as 0.") added the setting for the
benefit of netdevsim which doesn't touch the value at all on get.
Again, this is just to clarify the intention, shouldn't cause any
functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: applied clarification on relationship b/w HDS thresh and config]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 20 ++++++++++++++++++--
 net/ethtool/common.c        |  3 ++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..9d5dde36c2e5 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -6,11 +6,27 @@
 
 /**
  * struct netdev_config - queue-related configuration for a netdev
- * @hds_thresh:		HDS Threshold value.
- * @hds_config:		HDS value from userspace.
  */
 struct netdev_config {
+	/* Direct value
+	 *
+	 * Driver default is expected to be fixed, and set in this struct
+	 * at init. From that point on user may change the value. There is
+	 * no explicit way to "unset" / restore driver default. Used only
+	 * when @hds_config is set.
+	 */
+	/** @hds_thresh: HDS Threshold value (ETHTOOL_A_RINGS_HDS_THRESH).
+	 */
 	u32	hds_thresh;
+
+	/* User config values
+	 *
+	 * Contain user configuration. If "set" driver must obey.
+	 * If "unset" driver is free to decide, and may change its choice
+	 * as other parameters change.
+	 */
+	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
+	 */
 	u8	hds_config;
 };
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 55223ebc2a7e..eeb257d9ab48 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -902,12 +902,13 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 	memset(param, 0, sizeof(*param));
 	memset(kparam, 0, sizeof(*kparam));
 
+	kparam->hds_thresh = dev->cfg->hds_thresh;
+
 	param->cmd = ETHTOOL_GRINGPARAM;
 	dev->ethtool_ops->get_ringparam(dev, param, kparam, extack);
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
-	kparam->hds_thresh = dev->cfg->hds_thresh;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
-- 
2.49.0


