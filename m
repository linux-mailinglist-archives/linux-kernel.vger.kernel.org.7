Return-Path: <linux-kernel+bounces-820698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D09B7E2F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30EF6233D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0D62F25F3;
	Wed, 17 Sep 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="jWyBzGQN"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02D18A6CF;
	Wed, 17 Sep 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112956; cv=pass; b=lgJlXOsAUkYdTYt8xbd0vtAwT2DIrLfKWfwo84Jva+JtUyK/7FMwoRa1wssv1k6hvufO5PbHQZCjqzkdx0Dz3xygOUAWf/VlRynKLryZihprmBmES77PrNUugA/YpKP30wlAwnlVU9wlVxJ3cQ4wh3/DqFaOzLKXbwN81loTAI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112956; c=relaxed/simple;
	bh=B17GYg5auTAkWVCdRWKpLbr4OlUwuYKWU0Iqp+RY+fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXe8Jd/1xHB4dbz7L0v9dZzMvre7gGmY58KESDUEXJ0lKFNE9GI3o2M8cLEMVoC+bQGKq4Sp0IY8leEhboDYspHUcOfbQ1XrnXR5X+7+Q2JeeFBOGWStqMZun4kyPOSi9CvBSouQgTIlKRye36A9Ht+t6A6lwxZTovXLYnqv3VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=jWyBzGQN; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HCgSGf035281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 17 Sep 2025 21:42:29 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 5F1431241848A;
	Wed, 17 Sep 2025 21:42:28 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8bgp2gKtn_2l; Wed, 17 Sep 2025 21:42:24 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 8C97112418488; Wed, 17 Sep 2025 21:42:24 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758112944;
	cv=none; b=DJVIadfV7JAJRQyTl9BGBGLTXr2xRkbp70Sjv/QdjJKr3ObmIwmyMwQ1Y9UMeUX+Rh1lSElxRlD1t6LN0bPEESr01/PgIZfMRhbB/uDchS6NRC/Md6t7feJhW4++6+2ZgfHpGopuaMqxchbIeSJnckvo9IuEnMJGMCsH0Sr6Y7k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758112944; c=relaxed/relaxed;
	bh=mrFS2WeE2DuciHDNhnemsvIlsB4vcsFJDQytVFcwjBA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=vizSkB+UPdxYlq2Xq69odT+bZYIp1sId56S6xJvqWrBARvTJMIjqNubEaDkEjWT95tifsq+yETz1UcIW9MGk4FJ7GCXhMaoB6Ni6M5XOJQiHtbta3tVq5VNtGQQO/6M2ByujeT0ZHpQl9sD51paEVZY0gWJfPymzSvFgEyaPTMU=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 8C97112418488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758112944;
	bh=mrFS2WeE2DuciHDNhnemsvIlsB4vcsFJDQytVFcwjBA=;
	h=From:To:Cc:Subject:Date:From;
	b=jWyBzGQN4bQa3RLaF2YUyg936cp0D/7zJB2HrOs175vLZDQMhermiFJIVYZpsmKPM
	 /4d2+D58oXK4QgpB8Fj8FdYxdWfIPvO2Ka+tUtexWiBBR2z/QwSJ9W9Muw/Na7OMqw
	 Pz6JYYtGOqlbPuoVpg+bnjBfRRgUWu3QHPsKO6/Y=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: rtl8723bs: sdio: clarify OQT free page comment
Date: Wed, 17 Sep 2025 21:42:21 +0900
Message-ID: <20250917124221.1466298-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Clarify the comment above HalQueryTxBufferStatus8723BSdio() to use
"TX OQT free page count" wording consistent with SDIO_REG_OQT_FREE_PG.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index 8736c124f857..0ee50b4a1149 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -997,10 +997,7 @@ u8 HalQueryTxBufferStatus8723BSdio(struct adapter *ada=
pter)
 	return true;
 }
=20
-/*  */
-/*	Description: */
-/*		Query SDIO Local register to get the current number of TX OQT Free Spa=
ce. */
-/*  */
+/* Read the TX OQT free page count from the SDIO local register. */
 void HalQueryTxOQTBufferStatus8723BSdio(struct adapter *adapter)
 {
 	struct hal_com_data *haldata =3D GET_HAL_DATA(adapter);
--=20
2.47.3


