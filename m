Return-Path: <linux-kernel+bounces-733480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408EB0752F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516557B09DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2582F433C;
	Wed, 16 Jul 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C3/OtXtD"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5E2F3C20
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667051; cv=none; b=IXuMmPjpeRSj1wc0dFc+w4rrK/+LcWu6CSHyotR0zR4VrzsMAUiwkQ3l30dpMc8vOYmVesKhZ2/8xOqyfr6XGyWg3N5RBYZMd0bmgHrLWFk/xzgPrVt2Jnr+K4ZaLnVWygUDy2HFZr+lmbEZMVTf3V37iAXYg7QaBP8v57SMZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667051; c=relaxed/simple;
	bh=csn7WYtvsUdjHkQMbcST2wsNn0ffcZxw8hDRTLxE6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWcdI2LpjYdzUkB+Rp2e6WxCsKTNV6hhc/PLaVouLPppKb2BqmbnacH5jR8269D9hwtUD5tqUqnsuP3SsCXXY6UPkaEGcbekEaQyakGnG1MmK+61CPdsRSVGaxv3i0xOuG8voTL9Tea721uQtYXtnBrdVEcEpwv9iAiiaeuOR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C3/OtXtD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31c978688dso3375729a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752667049; x=1753271849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLRTtR8co0X61jWgkdjoqtJ4EJUXMSFsfzr4OSlttHI=;
        b=C3/OtXtDnvVJGuFJf8nY9NDTgU3fmyHQp+gokBMNUcTRQdRuuGvm4xknpHBMjCRjTJ
         H3aXCUckswLpQ07ocQDPDHnn9F9UrVECNpBVaNzrowEMiX9XUhqSjPKvESvS7L6qWZxg
         1pS6nlg9gnHJbjrPSa62EUhJu3gA7NsxliNt/kZ6kvfuL5Qt0IMRYsi0RktLnapiySVp
         brgzkUvLeOLoJafJXJNMb262efzaEGY8Iz2NqLjhqhVNX2aNYhNUvahnPXzs+wXNbsCC
         OH408Ru/u0RMmJX9mVn26RVGkQsWIBkV/+iX/A5nWbMZJVlDhpKnEVraBdulh5rPr91/
         NaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667049; x=1753271849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLRTtR8co0X61jWgkdjoqtJ4EJUXMSFsfzr4OSlttHI=;
        b=Klr5DKgDyp9pNRjiBCYGMtkjFv7Aw72cjBKPrdtS4IRis5jJ8xC2FXa0UmLGx3HBOd
         RfQNbB6Lhu0i0j1K74XUheNV2PGVLr2U/+o0cEIkZi0QdbMZbpP4o/S9rKQVSdQkXC7H
         J37orx2N/Wz1IKittumPYVn2+aTznC4ruAUYUS20QiXgKN6F15vmEFB9dcPoVYVVvhtr
         RO//SE3nU/8fJHbKNLZk8bpzAjRCs5KClqHiKoC1gNhvgrVh+ti2IKzh+w5VEqEH4n02
         8X5eFiIjQZ1Rr7zw1wFwehRA4cIlOeWlu/pXgb7ayKcnfFYBMXypXVkcfgyXvjZEQFR1
         e6+g==
X-Forwarded-Encrypted: i=1; AJvYcCWMk71m2WeAw9piSB4wnCy32GM/tGU6moYZrWkjSFnqLeRAiGUj/tQLfYUsJMlayvS187/DEk/ElPBkZnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqyqHe7Rk3MPqgRYGIriDu5cvhz5k8w3nMoRTB6oy7rEwf/eP
	oPnX2mX7ivtwjNRg1IQnvZ4QU4sD4F65ymtL1UyexVz66zHl6a6AR3dtu7RNLw0XJLd30q6ltF0
	KtT0ePCY=
X-Gm-Gg: ASbGncu9+OtvobGH+i5uTYk1Bh8rx+NUVuWyYOEkFd5S5vsTs39BqGQU7+lLzRTXeI+
	hhaP522WhIdcOAo/Xde7g9JJT3utFWuFiz6nGBGt3Uc+Eu3XVcps7nx+KY7Mgs0eBALTbzSBuKS
	uBq/FsmG6w21+OtoWS7SzIvFUm7NYh5y3JqFxM89lvHOzHQqKAGgE20SvfAaxBwO4yRFzDbbtrU
	IFaKoVIt4FwgTB/SzEuclzWBT4rqosVKfWpyAqfH0yh50JshdCJ5l3422cl7MceQcU65rlON1gW
	gvux3L7uadf8NZe5TJKv49N3s64WIKV0R9Qr1APtBx4TodZsCpcJcegO2Tn5NhCfBK5QK5AXS2w
	PNvCA0UztYcbv6ujQLt6eoDMYmZrogNM1
X-Google-Smtp-Source: AGHT+IEQPkNtoh9bRZW+IJ62bS4hVLKInbUmsPl/kIaslUF8mapeIjngutJf68Y6R1ZJMkkbtdUZ7Q==
X-Received: by 2002:a17:90b:1c89:b0:313:2768:3f6b with SMTP id 98e67ed59e1d1-31c9e77ce91mr4104373a91.27.1752667048532;
        Wed, 16 Jul 2025 04:57:28 -0700 (PDT)
Received: from vexas.. ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f29ddcbsm1292668a91.36.2025.07.16.04.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:57:28 -0700 (PDT)
From: Zigit Zo <zuozhijie@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: zuozhijie@bytedance.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com
Subject: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during probe()
Date: Wed, 16 Jul 2025 19:57:17 +0800
Message-ID: <20250716115717.1472430-1-zuozhijie@bytedance.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deadlock appears in a stack trace like:

  virtnet_probe()
    rtnl_lock()
    virtio_config_changed_work()
      netdev_notify_peers()
        rtnl_lock()

It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
virtio-net driver is still probing.

The config_work in probe() will get scheduled until virtnet_open() enables
the config change notification via virtio_config_driver_enable().

Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
---
v3 -> v2:
* Simplify the changes.
v1 -> v2:
* Check vi->status in virtnet_open().
* https://lore.kernel.org/netdev/20250702103722.576219-1-zuozhijie@bytedance.com/
v1:
* https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5d674eb9a0f2..82b4a2a2b8c4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -7059,7 +7059,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
-		virtnet_config_changed_work(&vi->config_work);
+		virtio_config_changed(vi->vdev);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
 		virtnet_update_settings(vi);

base-commit: dae7f9cbd1909de2b0bccc30afef95c23f93e477
-- 
2.49.0


