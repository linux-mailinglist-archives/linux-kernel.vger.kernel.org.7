Return-Path: <linux-kernel+bounces-861046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D933FBF1ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664A84FDF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58373203BE;
	Mon, 20 Oct 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUHh+lpg"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE30312839
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968169; cv=none; b=tZPXzCN5RaQHb3VxUVlgXgQi7GCUGne496Zag4nt4eyaSpGLdOdzJJF3Ha0wxz8XkRkCIZfrEdhcbkAoP5JkK2ZG/+XUTfUTIkTPcEdQoLgS57MQm9+Ly4my/MbRoShcminTSCdYHdZgkMKCASa9V9sPUzQ9+Ormt+GuopcBIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968169; c=relaxed/simple;
	bh=p17ZizgoQVksKXqVHWJyQifEDEkpvqNU3oIZSQcrjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH/LmOBiyjUo5Ud7eS5HL1HH5NAgST01cSwKnWJ7xsxq9tUohmJAXxhYeg+gpL+rsvwIpqZ4mVx2fX2QsQQ8falUsWBA8upI12rXkf9jJ6ZzF1n7a1ZsEoSoSzIuOVWwJ9l+98PtVnmJ37T5CSqF/+AsYQ4bxiDZW3yuP3akEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUHh+lpg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so5378808a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968167; x=1761572967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6bZDBMwFOcBCtJWO0TclacmqT6GC+h7O4/sHJWRg3w=;
        b=CUHh+lpgDjCOqKp2LVY1HQTFVpa3xkDfs5Wrcb7GpRCV78WhPyIlhqybqtrFucPwaE
         Y3AQrxxAnI4KI6E/OZJogCe97I6zDKmPg2jIxl1n+255GU56+UUuU/VfqXUV/Qv6V4IA
         ad60gc64LsNpe1LwIRqrKP+j+7FrzHgBkn6FwvEae7N2Hnk9CQDsOyFevV7PGJPSzLbA
         mRqEo1Z7bMZjQkmfqWs87XjzrJ3xwwnbXUKUHBElC6O/V92J32EySAF8VY7OeX+TbCo9
         ZE/ql8BOGRMm+Ca9guKN5ZUvKWorRIlOOdHOTHBXSAwUWGxrmLQUDHcA5FjWjsKsbCGE
         6a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968167; x=1761572967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6bZDBMwFOcBCtJWO0TclacmqT6GC+h7O4/sHJWRg3w=;
        b=hw5ur13pfK7xTvwc9U0OCTnOPDjmLNU9u+jxNbMEWLt5/eVGQ+dpaYZowsTvPnmKLi
         dRaG6HL1vysWYDWr7OPtP2azWk62OM3SHu03aYyLFQiGZZtlmMs7G+IeJqAs0eEG+Gwk
         G8ecl3mFWJkNQahKQ5cdwmwv9D9AGI8SselNb5y1wfqPPJxf7Kgp66NDWq9x9hpY4/OG
         m0nx0xLxMeQ9Eim/FzoDi+pV8cZ40bmx87G0VtEKutgNRifZMdZ+8nzgmeEuEQ60ista
         eDPvXhI/Aa2PxSEW8ZYRDGyF8fbRryc5gl1qb8LFx5uAw22+3AUaOuUcwRT1qYBaOtoC
         aMmA==
X-Forwarded-Encrypted: i=1; AJvYcCVWTY1YykLFGtjUPC5Y0ENsspoeTilFrY/KPO+l7Q3yzQ0KlRVxtygnqps3EveZGZRyFXEB2vuIp9aHVfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqFpvaw6qa4NnDmDNid4r/j51pKeE0WYIyLJCteSbIKnUd6SX
	559ySENgdnky3oVa17I05d1RIG7B2Dlx6NN4SyjEjSXfqOqawu1GMfqk
X-Gm-Gg: ASbGncvu6+khJEBFTy5mhwq0z63/eg6UatLq81DiE7e/wIjlTc7f+NUXwIPYoHUfRVe
	J8lf+vTtXV2Wp6fXZY+KXwLU/z8tPlhcEF2JO78fuIEnTyIh51BO/p4wW7Bt98k8NbVf08pD2Ez
	p9rOVveyDT3X4CnLEqbTpC/4YyTXjYSqCtMpXHGZe5zzGb4jisB5vKpzX9rrJ681RIp8Wpv4SXu
	JqWprK51aURAxSAcC5DndU8BJAoDdqDV4FXJ74G5xwOhd6RNh2mfFiI8dyvNXTbg4xDyYuvh6yT
	mVWJFWYyvKoc8PxyjO1mOd6DBT9mGIOwW8YR2EgBv2VYTproPagggLi5xzwhUY3bvDRiuSOErJe
	oL3iXUVen9cCa8Ij3vsQisiLVBUfiT/czr//ApUvZSj1nRgrB+l2PEU8E00SLHBOF5IACsnTdq6
	OCaZRwJxysMMUHMOUcsA1xILVc2pMqaZWwJxR7raIauD9tAYYcVTKCS/T267vlGVVxUE5Cq+WN2
	g==
X-Google-Smtp-Source: AGHT+IELKtv6EJjONr0SWqhG/TrSK017y4BhyQmolq816W8WZ6Bqz/9ErZ3xNKisln/cCasioXjGEg==
X-Received: by 2002:a17:90b:28c4:b0:32e:d649:f98c with SMTP id 98e67ed59e1d1-33bcf85d5a8mr16303056a91.1.1760968166624;
        Mon, 20 Oct 2025 06:49:26 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cc9:d444:c07a:121f:22da:3f7b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bdd02793dsm4507349a91.3.2025.10.20.06.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:49:26 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC net-next PATCH 1/2] net: Add ndo_write_rx_config and helper structs and functions.
Date: Mon, 20 Oct 2025 19:18:56 +0530
Message-ID: <20251020134857.5820-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ndo_write_rx_config callback and following helper structs/functions:

	rx_config_work - To schedule the callback and handle synchronization

	read_snapshot/update_snapshot - Helper functions to read/update the
		 rx_config snapshot

	set_and_schedule_rx_config - Helper function to call ndo_set_rx_mode
		 and schedule ndo_write_rx_config

	execute_write_rx_config - Helper function that will be scheduled
		 by rx_work->config_write

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
I expect that shallow copy should be good enough as rx_config should consist exclusively 
of integer types (primitives and arrays)

Would flushing the work queue be necessary for functions like *_init_hw()?

 include/linux/netdevice.h | 38 ++++++++++++++++++++++++++++++-
 net/core/dev.c            | 48 +++++++++++++++++++++++++++++++++++----
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..37a48e41a004 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1100,7 +1100,12 @@ struct netdev_net_notifier {
  * void (*ndo_set_rx_mode)(struct net_device *dev);
  *	This function is called device changes address list filtering.
  *	If driver handles unicast address filtering, it should set
- *	IFF_UNICAST_FLT in its priv_flags.
+ *	IFF_UNICAST_FLT in its priv_flags. This sets up the snapshot of
+ *	rx_config that will be written to the device.
+ *
+ * void (*ndo_write_rx_config)(struct net_device *dev);
+ *	This function is scheduled immediately after ndo_set_rx_mode to
+ *	write rx_config to the device.
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1421,6 +1426,7 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_write_rx_config)(struct net_device *dev);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1767,6 +1773,12 @@ enum netdev_reg_state {
 	NETREG_DUMMY,		/* dummy device for NAPI poll */
 };
 
+struct rx_config_work {
+	struct work_struct config_write;
+	struct net_device *dev;
+	spinlock_t config_lock;
+};
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -2082,6 +2094,8 @@ enum netdev_reg_state {
  *			dev_list, one per address-family.
  *	@hwprov: Tracks which PTP performs hardware packet time stamping.
  *
+ *	@rx_work: helper struct to schedule rx config write to the hardware.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2559,6 +2573,8 @@ struct net_device {
 
 	struct hwtstamp_provider __rcu	*hwprov;
 
+	struct rx_config_work *rx_work;
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
@@ -2734,6 +2750,26 @@ void dev_net_set(struct net_device *dev, struct net *net)
 	write_pnet(&dev->nd_net, net);
 }
 
+#define update_snapshot(config_ptr, type)						\
+	do {										\
+		typeof((config_ptr)) rx_config = ((type *)(dev->priv))->rx_config;	\
+		unsigned long flags;							\
+		spin_lock_irqsave(&((dev)->rx_work->config_lock), flags);		\
+		*rx_config = *(config_ptr);						\
+		spin_unlock_irqrestore(&((dev)->rx_work->config_lock), flags);		\
+	} while (0)
+
+#define read_snapshot(config_ptr, type)							\
+	do {										\
+		typeof((config_ptr)) rx_config = ((type *)(dev->priv))->rx_config;	\
+		unsigned long flags;							\
+		spin_lock_irqsave(&((dev)->rx_work->config_lock), flags);		\
+		*(config_ptr) = *rx_config;						\
+		spin_unlock_irqrestore(&((dev)->rx_work->config_lock), flags);		\
+	} while (0)
+
+void set_and_schedule_rx_config(struct net_device *dev, bool flush);
+
 /**
  *	netdev_priv - access network device private data
  *	@dev: network device
diff --git a/net/core/dev.c b/net/core/dev.c
index 2acfa44927da..24eeaec5881b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9524,6 +9524,37 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+static void execute_write_rx_config(struct work_struct *param)
+{
+	struct rx_config_work *rx_work = container_of(param,
+					 struct rx_config_work,
+					 config_write);
+	struct net_device *dev = rx_work->dev;
+
+	// This path should not be hit outside the work item
+	WARN_ON(!dev->netdev_ops->ndo_write_rx_config);
+	dev->netdev_ops->ndo_write_rx_config(dev);
+}
+
+/*
+ *	Sets up the rx_config snapshot and schedules write_rx_config. If
+ *	it's necessary to wait for completion of write_rx_config, set
+ *	flush to true.
+ */
+void set_and_schedule_rx_config(struct net_device *dev, bool flush)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (ops->ndo_set_rx_mode)
+		ops->ndo_set_rx_mode(dev);
+
+	if (ops->ndo_write_rx_config) {
+		schedule_work(&dev->rx_work->config_write);
+		if (flush)
+			flush_work(&dev->rx_work->config_write);
+	}
+}
+
 /*
  *	Upload unicast and multicast address lists to device and
  *	configure RX filtering. When the device doesn't support unicast
@@ -9532,8 +9563,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9554,8 +9583,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, false);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
@@ -11946,6 +11974,15 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	INIT_LIST_HEAD(&dev->ptype_all);
 	INIT_LIST_HEAD(&dev->ptype_specific);
 	INIT_LIST_HEAD(&dev->net_notifier_list);
+
+	dev->rx_work = kmalloc(sizeof(*dev->rx_work), GFP_KERNEL);
+	if (!dev->rx_work)
+		goto free_all;
+
+	dev->rx_work->dev = dev;
+	spin_lock_init(&dev->rx_work->config_lock);
+	INIT_WORK(&dev->rx_work->config_write, execute_write_rx_config);
+
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
 #endif
@@ -12083,6 +12120,9 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	cancel_work_sync(&dev->rx_work->config_write);
+	kfree(dev->rx_work);
+
 	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
 	WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
 
-- 
2.47.3


