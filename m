Return-Path: <linux-kernel+bounces-726846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D71B011ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B5A1C25743
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386DC1A08CA;
	Fri, 11 Jul 2025 04:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPTcg/WD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90461A0B0E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206804; cv=none; b=HpwAlWD8aWoEJrX/NwpCES9ekM3YQ3M/bbioxPlkqQCQSpWEwgPzcJ00bb1baGBN/M8bGNzJDum4GscUewrpY/AwB6cNmoQGy57tIKxCwSQx25kDXvy+n5s+YL1hYdpM1nUNJtGn3exMhxgcYPIa+d+KWM84e19vXI9AXIVXlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206804; c=relaxed/simple;
	bh=SDiFjXIEY2k6EMivsiiZ56S4N+J1jLx/2bscGVPuYxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVJe+l7rlPO9BQUECwbVPF5vQANS8r5yumbUlQz8UVyjSkTTx5FgC9Ebbblw0KKBq/ol3eMgz1OgT5EORXyiOIQsE/AOXQu2GnSwMaCVC/VBy2Qh+yXN206JER0X5tjN/NJB6QP1qLSP8Wv3wM5RhON4Kbf5B/aZa4YOt92UyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPTcg/WD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752206800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJknBKO1gBSr73F5TeVtWsmcBQA8Lx7LIgsYwMB0ZDw=;
	b=HPTcg/WDJ4QADk4fjbPLqcRMSdKrYTST3acCMEwW4tdhd6+vH2rervvy1p/EuSPn3C3Nrs
	themw9fqeEeQNEpUPjOJeaLxpaojyoG/5sfaMTSSv+BQVx1rBpfT6dQ+2OvRgB0VDG74ny
	nVeDu5GOOrKoWzwRM4uy3TIRJQs+K/s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-k7gJBKogMC-KM-ws_bsRqA-1; Fri,
 11 Jul 2025 00:06:34 -0400
X-MC-Unique: k7gJBKogMC-KM-ws_bsRqA-1
X-Mimecast-MFC-AGG-ID: k7gJBKogMC-KM-ws_bsRqA_1752206792
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0F8D1800366;
	Fri, 11 Jul 2025 04:06:32 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.116.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90AA41977029;
	Fri, 11 Jul 2025 04:06:26 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Date: Fri, 11 Jul 2025 12:06:23 +0800
Message-ID: <20250711040623.12605-1-litian@redhat.com>
In-Reply-To: <20250710024603.10162-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.

Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This new flag change was not made to hv_netvsc resulting in the VF being
assinged an IPv6.

Suggested-by: Cathy Avery <cavery@redhat.com>

Signed-off-by: Li Tian <litian@redhat.com>
---
 drivers/net/hyperv/netvsc_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c41a025c66f0..8be9bce66a4e 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	if (!ndev)
 		return NOTIFY_DONE;
 
-	/* set slave flag before open to prevent IPv6 addrconf */
+	/* Set slave flag and no addrconf flag before open
+	 * to prevent IPv6 addrconf.
+	 */
 	vf_netdev->flags |= IFF_SLAVE;
+	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
 	return NOTIFY_DONE;
 }
 
-- 
2.50.0


