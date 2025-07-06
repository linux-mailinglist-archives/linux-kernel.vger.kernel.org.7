Return-Path: <linux-kernel+bounces-713020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B3AF121B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42E91C40303
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A92580EC;
	Wed,  2 Jul 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZbiidNSA"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A61256C9F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452657; cv=none; b=kWCAPWnvKFDUIoGV2XnodNvthiHi59oohGtkOVzasU1OkFs5OmYu7UWzvHXxx6McgcAnhlZInFhjiCxyVs8ZoeBrm63M/Wkc5iGRPRUJ7Wsrr7YEx1t8QzlN3Vm0z+dSzg6nPuNyOzpl6nXcG1Kf6CP5nzzW4VmrroHRxcdmx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452657; c=relaxed/simple;
	bh=5TsIlHMOqUqTuoTUEe3ywov4SmaUQtSaropRxRMo6AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MP+jsuLuit5mOk/gxkkI+QEKjmD6spin6I3rmq1P97lhExF4xx2MQDw3suhLOm7pS935rRTVJSgMZU29jfGiPmypb9ndxLiiw1XV2nxpzb69N+wIrRsj3OjnIEWoHOlJCS1YH0+J5euhVFd6SlKqnxCMuRCRMx1VswSV4AqZIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZbiidNSA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so6473708a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751452655; x=1752057455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dp8QDDHxGgYM4d2YqBrz5e3aQ8kR4QlztrSv4nHpc30=;
        b=ZbiidNSAqBGi7irEax03Zz4+zKjAv5nxGJke2tpJCunnHTZLLR7HSvn2BNpneHJdZi
         VXbfo0yhxwzeZBKxZCOtm9XipVM+AOiQIiykNtO9a3fbop9IfAZZQO6HjSlq9GPeKFZg
         7a5MMJbMA32P4hMSYz7xPugRJZcClheRPFdDwJfBYLNEy2zY5H3g/47uRsFlk71Ee6dH
         b5yopNOlDLhdpsGDMS4OrdOZb3nmWaKnEAAOHIDjSuxEq9LDuJyud97kDdbLFxiY/1k3
         cFB9qqXz52HakpUtME8Lr27mJ62ovOCXwTJIEnX5sXm5S9N1/B0MhzDDTZNcUo3AJYEF
         rnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452655; x=1752057455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dp8QDDHxGgYM4d2YqBrz5e3aQ8kR4QlztrSv4nHpc30=;
        b=u08+hfX2W/kiAv2vT0IEDT+pY7pHBFsNNuhPADucRokOGmRZ7BGU+qg3iB1WGDJpsD
         5wsRIAxncM+eG38cjGf8zv06uVrRq2Q5VWiY5Eo7AfSqt/SdQDhYedzkC1EQzakQjfy2
         3HQ8+jJiZUmj8Vx8NS4GmN7RgevEPeIApP4/kHzfQKUKpImaPFKdjB3J6z1cF8AN527k
         WopidSYT4AsWkbh/+lbOpxOnWqhXwyVBfhfHlsgi+GK3RXcKspbhaPlXQQvJ9JSySmaI
         nQmdigHGDdkt5/kIpkX7OWOsl4zHRJcPh3QX36M9LwxeM1TEip2050gQmvjh/pLzuzoQ
         Lm7w==
X-Forwarded-Encrypted: i=1; AJvYcCWR0psRf5/b+y8/KmjyXgOIjObz7zRqWQFIVtKXRz0xm9A6GvS7iGbb55MXFw508pAFh+PW/93oMpQcUCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgobTyd9PnAtIOi6+lJgq9nsV54Vs8sHuPTEAsJEqNAohGJLc
	OJq0CtMdQLHfL9fGGegOPQFsKarHiAbaPiRvMfQ6KYt2x5Y5OWqquU6zUv0SzFDwzyo=
X-Gm-Gg: ASbGncsaxbPthLpkPwbwQxbV2IRFcKrY/yzeGyUs7rCsJdp513Xs4S2bXzFK9dQa+Nq
	CIbLxM022IOUoVlKRL8tcHUC0+eonVukAGO/qQ7c6ECV/s+GMl3x45XPam3lkofPgK+UFEYCxUR
	jpy80gXJGwEbsY4mhV99Ml51QVAVNkT1IKeruOtfB7n9wY0M3PiV6GjUBpJF9mcm67oDtsMaTgd
	lGvMjv5EPQSJR+ZKBACmIEJlbhgTkSanK8MQren4eAOPEvgKlPuykfir7Ihn9mJ2tOh4FX1Fodo
	kvyruMmsNbCe+YmHsN5U7Uiq52Z5orycqeLHexK6m87oo2khKe7J/kLTTfzI60OemgO43l8QTZV
	2yQbwkEQ=
X-Google-Smtp-Source: AGHT+IE3rKt5WHNJuMqRNYlFDXT8dSxi19usBdAhzGgY+n3rXRZOSIXnkXSl67UdwZvDarrui7g/Eg==
X-Received: by 2002:a17:90b:2547:b0:313:d6ce:6c6e with SMTP id 98e67ed59e1d1-31a90b26982mr3763532a91.8.1751452655134;
        Wed, 02 Jul 2025 03:37:35 -0700 (PDT)
Received: from vexas.. ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e23a3sm14201200a91.29.2025.07.02.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:37:34 -0700 (PDT)
From: Zigit Zo <zuozhijie@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: zuozhijie@bytedance.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during probing
Date: Wed,  2 Jul 2025 18:37:22 +0800
Message-ID: <20250702103722.576219-1-zuozhijie@bytedance.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
the virtio-net driver is still probing with rtnl_lock() hold, this will
cause a recursive mutex in netdev_notify_peers().

Fix it by temporarily save the announce status while probing, and then in
virtnet_open(), if it sees a delayed announce work is there, it starts to
schedule the virtnet_config_changed_work().

Another possible solution is to directly check whether rtnl_is_locked()
and call __netdev_notify_peers(), but in that way means we need to relies
on netdev_queue to schedule the arp packets after ndo_open(), which we
thought is not very intuitive.

We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
QEMU sending the announce_self rapidly while booting.

[  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
[  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
[  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
[  494.168260] Call Trace:
[  494.168329]  <TASK>
[  494.168389]  __schedule+0x27c/0x6b0
[  494.168495]  schedule+0x33/0x110
[  494.168585]  schedule_preempt_disabled+0x15/0x30
[  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
[  494.168835]  __mutex_lock_slowpath+0x13/0x20
[  494.168949]  mutex_lock+0x3c/0x50
[  494.169039]  rtnl_lock+0x15/0x20
[  494.169128]  netdev_notify_peers+0x12/0x30
[  494.169240]  virtnet_config_changed_work+0x152/0x1a0
[  494.169377]  virtnet_probe+0xa48/0xe00
[  494.169484]  ? vp_get+0x4d/0x100
[  494.169574]  virtio_dev_probe+0x1e9/0x310
[  494.169682]  really_probe+0x1c7/0x410
[  494.169783]  __driver_probe_device+0x8c/0x180
[  494.169901]  driver_probe_device+0x24/0xd0
[  494.170011]  __driver_attach+0x10b/0x210
[  494.170117]  ? __pfx___driver_attach+0x10/0x10
[  494.170237]  bus_for_each_dev+0x8d/0xf0
[  494.170341]  driver_attach+0x1e/0x30
[  494.170440]  bus_add_driver+0x14e/0x290
[  494.170548]  driver_register+0x5e/0x130
[  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
[  494.170788]  register_virtio_driver+0x20/0x40
[  494.170905]  virtio_net_driver_init+0x97/0xb0
[  494.171022]  do_one_initcall+0x5e/0x340
[  494.171128]  do_initcalls+0x107/0x230
[  494.171228]  ? __pfx_kernel_init+0x10/0x10
[  494.171340]  kernel_init_freeable+0x134/0x210
[  494.171462]  kernel_init+0x1b/0x200
[  494.171560]  ret_from_fork+0x47/0x70
[  494.171659]  ? __pfx_kernel_init+0x10/0x10
[  494.171769]  ret_from_fork_asm+0x1b/0x30
[  494.171875]  </TASK>

Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
---
v1 -> v2:
- Check vi->status in virtnet_open().
v1:
- https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
---
 drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..859add98909b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3151,6 +3151,10 @@ static int virtnet_open(struct net_device *dev)
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
+		if (vi->status & VIRTIO_NET_S_ANNOUNCE) {
+			vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
+			schedule_work(&vi->config_work);
+		}
 		virtio_config_driver_enable(vi->vdev);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
@@ -6215,33 +6219,34 @@ static void virtnet_config_changed_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
 		container_of(work, struct virtnet_info, config_work);
-	u16 v;
+	u16 v, changed;
 
 	if (virtio_cread_feature(vi->vdev, VIRTIO_NET_F_STATUS,
 				 struct virtio_net_config, status, &v) < 0)
 		return;
 
-	if (v & VIRTIO_NET_S_ANNOUNCE) {
+	changed = vi->status ^ v;
+
+	/* Assume the device will clear announce status when ack received. */
+	if ((changed & VIRTIO_NET_S_ANNOUNCE) && (v & VIRTIO_NET_S_ANNOUNCE)) {
 		netdev_notify_peers(vi->dev);
 		virtnet_ack_link_announce(vi);
+		v &= ~VIRTIO_NET_S_ANNOUNCE;
 	}
 
-	/* Ignore unknown (future) status bits */
-	v &= VIRTIO_NET_S_LINK_UP;
-
-	if (vi->status == v)
-		return;
-
-	vi->status = v;
-
-	if (vi->status & VIRTIO_NET_S_LINK_UP) {
-		virtnet_update_settings(vi);
-		netif_carrier_on(vi->dev);
-		netif_tx_wake_all_queues(vi->dev);
-	} else {
-		netif_carrier_off(vi->dev);
-		netif_tx_stop_all_queues(vi->dev);
+	if (changed & VIRTIO_NET_S_LINK_UP) {
+		if (v & VIRTIO_NET_S_LINK_UP) {
+			virtnet_update_settings(vi);
+			netif_carrier_on(vi->dev);
+			netif_tx_wake_all_queues(vi->dev);
+		} else {
+			netif_carrier_off(vi->dev);
+			netif_tx_stop_all_queues(vi->dev);
+		}
 	}
+
+	/* Ignore unknown (future) status bits */
+	vi->status = v & (VIRTIO_NET_S_LINK_UP | VIRTIO_NET_S_ANNOUNCE);
 }
 
 static void virtnet_config_changed(struct virtio_device *vdev)
@@ -7030,6 +7035,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+		/* If there's (rarely) an announcement, the actual work will be
+		 * scheduled on ndo_open() to avoid recursive rtnl_lock() here.
+		 */
+		vi->status = VIRTIO_NET_S_ANNOUNCE;
 		virtnet_config_changed_work(&vi->config_work);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;

base-commit: 34a500caf48c47d5171f4aa1f237da39b07c6157
-- 
2.49.0


