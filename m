Return-Path: <linux-kernel+bounces-870802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921DDC0BB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D0A3B745C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA22D239A;
	Mon, 27 Oct 2025 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b3tt8XYV"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E722D4C3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761534783; cv=none; b=Or9GdifEPxuysFLblk5TcFpaPNXMEx4mge68dLwH6+6S+jUFuI5VnXaSUzMbZSjrfkZGGz0B5moV8GbgWop2GINuXZYxMkEr8AgWLxb53zU0esfIsiSz3qJis8PKgdj55OuKSswJCjMxcr6o7D/GSByy0olRFA0spIcEWDKxUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761534783; c=relaxed/simple;
	bh=VTARBaTpTODpW0haIb7PDNWe/JD+LwU8S9/7AGyvMTY=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=aujNECcwcSNtAatZ1mZriamfqFUp/a92yswXc45AE7MBE0XcIijObOPG9iE4DsLJRX0sDc4NfFZv3/Mt7lOLOietQUpJqJFALSXUSGJXH/yXp+8FbzMqS0y6yJ0mYcLb3SRZbxzaetbUMQzF98xLk+L0rY/S7cLFWpGROzuGgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b3tt8XYV; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761534469; bh=stzLUCzkNul917MZrE2iPdNYMyfJtsDmIaIrJi019dU=;
	h=From:To:Subject:Date;
	b=b3tt8XYVlHXtCcQiBEtCyFtIIizNiIBwWio76R7fbnbrei2jJ1VSm2OMIsqkEu3Nc
	 mc1chCJBZnYhQv/TOCTKAozCxsjn7WzDWCgRwD2Sjum4IslBiqePQ4EKg8VsxoFO/3
	 st3N9g4By39BDHwrQk0FjEjs/9unKPT/wd08OVpc=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 1EF3064E; Mon, 27 Oct 2025 11:07:47 +0800
X-QQ-mid: xmsmtpt1761534467txd3bei18
Message-ID: <tencent_5382628D577DA53322CAA700F6308AB29006@qq.com>
X-QQ-XMAILINFO: M2Ecasen3dvfUnuLHJcpGs0/zjsVt6LcyzyKl40UA6rlGsaXEZ9r3hGPJPtBum
	 pfuwQiLtchCkCVmniWk3SJ9itZq/ecyq7UzZQwfK9X5IN37LGDZaUCBtiUTBcVpljWuqT+J2H2mM
	 iSuCQH5B8ikIDypFINTNiYkuLE0NPxZTCuR0wzdTGkGGHtvrD/gBTYPUDcU9cEW4P5Drf8MGSQvb
	 8cM6qWKY2Pw597xNhvIb9P3KABzo7Q3cPjvG5shtuvW/ca1CwNPxkpI3zx9wq8BPdJMh5pSFFGPX
	 Wl7ziDgIt22hQihVYBbB2yHgHz2vG2B4xYxL15AEF4IzAIvsz3eMqGDSJrZos4m3QqW1ZxE1mYw0
	 KFHi2wgKj7j6Yn2uSwj5a9GjzPL0XmowHnc/ZY7epx+PqWmdErlf2Wf4qwFyuIqWON1gQKvTb+Su
	 cGOjS4VcppaEVGurqC2hsd0h4w+O9yRSjudst+DP7qBuTVeKXJOF8KJ+RMB/IzNS+t/1ZmkeUNKi
	 GoHTSX5l9TZYqimqMGjSagSSNStKsakF7eROxeA3nmokFAdrKL2/c6jP8q1ukb237q30CTyF3Rd3
	 fYiApVxszuH8Q2NOZZdkLV48jYo9Omd5/449KpYGIFnh7lIM5f+AhVkti+7TxSK6hkVL5ukVX5b0
	 I481ITJxhUswc9wCWSHUUT3oYtX344tSYXt1mwMu/MSxD+66jk66PGhqh71xTgNBFJiisB+joXbz
	 oDiPXzKVKYtVat4gWH9ZoKqZcacKJa/urRKiB7bfUg3QIycVBE0jUrqtfRotamkFbnk16P1/ixOa
	 JJFeqZOndzcg7h1JKgJdlljwf13ahlGF6Q/HobfTCZvrKhlfPKYQqdeG944Z18y2xGXyiQ1k7kMI
	 9W/VbLPZoDnpRJlYLANUEAmaMhEMO6wPrJV9ROJ6SIkKnpSrII7ZDnfjHu9cRwqRIiPG/EEB0kEZ
	 8wtWVnV8r7ReD1Qkf1lg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: 2564278112@qq.com
To: lyude@redhat.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlie@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jiangwang@kylinos.cn
Subject: [PATCH] drm/nouveau: Resolve the issue of VGA not being recognized or disconnected
Date: Mon, 27 Oct 2025 11:07:42 +0800
X-OQ-MSGID: <20251027030742.69802-1-2564278112@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Jiang <jiangwang@kylinos.cn>

When using the GT730, I found that the VGA could recognize when it was plugged in,
but could not detect when it was disconnected.
The reason is that the polled flag for the connector is missing DRM_CONNECTOR_POLL_DISCONNECT.

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 63621b1510f6..dfff01edf65a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1421,7 +1421,7 @@ nouveau_connector_create(struct drm_device *dev, int index)
 	connector->doublescan_allowed = false;
 
 	drm_connector_helper_add(connector, &nouveau_connector_helper_funcs);
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT;
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
 
 	if (nvif_object_constructed(&nv_connector->conn.object)) {
 		ret = nvif_conn_event_ctor(&nv_connector->conn, "kmsHotplug",
-- 
2.25.1


