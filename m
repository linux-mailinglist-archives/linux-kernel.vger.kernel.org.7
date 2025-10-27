Return-Path: <linux-kernel+bounces-870803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0BC0BBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5904348742
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0382772D;
	Mon, 27 Oct 2025 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hz4GnQKz"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D01BC58
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535018; cv=none; b=RtmR8FeTEqQJPHo4L2nASam0bk5JQ+N4qSQRDDVMKeK6SydEtal64/qQ3xcoEx3Ofn6odDe9bk4yZZRshLJPXFhscctK96IxAlJFcYpxNPTJE624FZb/+JPaLWHSlH0lsiC2I6L61LiqmyEHFUGl70bD9C4EGdxaxXYqiKGjafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535018; c=relaxed/simple;
	bh=VTARBaTpTODpW0haIb7PDNWe/JD+LwU8S9/7AGyvMTY=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=Tk4wf3OZbKAUqY5mD60ckA+mWb5WT/BD787vAaQT4ctP8XBGI+ZcsbCDpWoCvwge1ye8XTf+Tq+OLmNeInb8+Whe10xTXflXMorfxpOM1PyuenFvORXR4rTpwFft4BSzMs7FRXjCwQwTLyscZFHFk3AAXMr+djziGN1FdILLRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hz4GnQKz; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761535012; bh=stzLUCzkNul917MZrE2iPdNYMyfJtsDmIaIrJi019dU=;
	h=From:To:Subject:Date;
	b=hz4GnQKz7h6Aq/mzikW9vTt68FxRvJS/aD5PwQy+Ex9DSZIvHHm10K27nI7ol0wRH
	 TmATQkS9K2R1evpsBf1QCa0h4hfozphu6T364A6bcP9g3HZyW4zpdKUgwAeQ3tS7c9
	 ISa8jKqrj54hrO5aoULnF+mEgxp/CE4lvo6NQcpU=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 432814DC; Mon, 27 Oct 2025 11:16:50 +0800
X-QQ-mid: xmsmtpt1761535010tc43gqnxb
Message-ID: <tencent_7EF61E8ABB90946288975CE501E2D9673C06@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2RAwtjD01Dg9EHTOB2Zs5/YqmsPo6Nb0B+uQFHuK5AmfdOpIZYu
	 CkmWOC+JYFlzjQOSkcgABqjLsp2BrHKo6orYs0fCUVOCXTTqkM5y9SbdMeymoXmQIF9v6pPEz/P9
	 vt7LrzJEvfMrfigjBuf9izWLliwgLslRIuXkC5z2lc4AA3VrcIzDUaWZXThvWWuTfNrmH/b9X0uB
	 DCRNlmUqbZPGJzDSqtEwG5xpGRxsVxOUVAjEZ6pVZqIUfsPhOTHVaTdWO3lrPb9y+IQbjzxvwA8l
	 yeVdfsy1N60ujFN60nBJQMLqcCXDNRhAIwXF/eR+lt+qvYbsjGRWN15ldBigY9qtzTLKwvTmlmkR
	 S+XxMzJwmv/20dHrGhZNY8+3FW/qama2ZpvToX5oLcsDUI8nJILOHMxYvtf6FYTprhFF50xAsgyl
	 nFSCEGLH4rXpXJPy501eyx2zkGI/35Wq47sBfzV55LSJrgngaiD2dFrLQIbc5pa+q/kgbSxh3Qrs
	 IrfduILRDOmuvJ7fnDzk27yQxH4oCa2GZ43EE+mP0KIPaMNEUtm+1Xy5r9TT002W612AmB1LPG/n
	 sV+IRazOsaV7RqCp6dHfgGjJiBSGze79BM4JjqcwU6YPKIntl4W1ZGr0UepRZshDjPbO5WBp/wkA
	 g8+wEfn/9YvlHH2WqKauE5AGUkF93FsiMxv8E2Cl+A1ObxvDJ4I8hhiJfKMaMUKAQqa0aVGryxPW
	 vUPrYnpq7B61u39E6zCccoeZEfuHCKF7L/WD9Va5b8iM1oh/skaNk+/039O0wT86mIhzlTDTA+6n
	 SkKRf+rKzk7KCj78L12TcuZJXfW8r9//39aQl3a8v1/xHsa21mgqVmhYm50SzXxRLNDBp7WS+ipt
	 2W8kLskP3M8pqj9qAPJGq983rLCR56LwCA+Gq2e9igU3degeLC8mB4uJ1lLM9t5iXmWLRIAlCc0a
	 WPbthhwS/vtteXameW50fmZeAfGSjUJ5w31s9RIcoNywejtD53r1Uh9eycrRbHVuUQc/6zUsiL95
	 5/TIglXwoSLGcXv33LhZQIrWoXRig=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Subject: [PATCH] drm/nouveau: Resolve the issue of VGA not detecting disconnection
Date: Mon, 27 Oct 2025 11:16:48 +0800
X-OQ-MSGID: <20251027031648.73856-1-2564278112@qq.com>
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


