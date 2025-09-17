Return-Path: <linux-kernel+bounces-820650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75BAB7D546
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90287178965
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C62FBE0F;
	Wed, 17 Sep 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="rMprJkSN"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA732FBDEA;
	Wed, 17 Sep 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111490; cv=pass; b=qYO1CLug5h9n52ensj8nUdWgAEo1Xpd4pHTFP/BoxRZyhhgXC2WqmpzBB3Y2q6leShuwTf3BVOSNRQ6mGV5ssVwcqHb5EZjhT78MdvlWSb8/ONSK1NfYXRUZLx562VRfta7dPus8jevKiR5xcqeZ3qApEd4IQezUmRKIT7hHaEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111490; c=relaxed/simple;
	bh=B17GYg5auTAkWVCdRWKpLbr4OlUwuYKWU0Iqp+RY+fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhUEW992jVA8KEaNOPoP/L/QlPZTgLySp5aPy5opYEAIY/vv35OHGoev0AlJTM6UKlIFQMekLVsAT73WyjLQbr4YhQ8h7VlgATCOEDT7Kp0DYo9PET1N6tB/42fDRWEDjhhh1GowW3qW/LmjPbUxeG4ob83XeCD7iEmZi2VUKqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=rMprJkSN; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HCI2QP002008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 17 Sep 2025 21:18:02 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 4C36C12418486;
	Wed, 17 Sep 2025 21:18:02 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VUG1dTMA0amh; Wed, 17 Sep 2025 21:17:59 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id D81A111EE222B; Wed, 17 Sep 2025 21:17:58 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758111478;
	cv=none; b=q+pzCNB2uJ8qPtF/tfDmunzkS0Hm+VSPTpzjh/lsoQfaimhD8rMl3SltubQtXetlb41F2H/+ymrTu/ZwTz0jHa8jzTU+ykB2aDWFj0vdye+YTEPAETYvfBz4FNyjvWCkKOrbuDSq0UGsl3IHw85OiCiUAhC6Df+li582oReTsEg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758111478; c=relaxed/relaxed;
	bh=mrFS2WeE2DuciHDNhnemsvIlsB4vcsFJDQytVFcwjBA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=a/9MQsLb1ve5CaiCnPyoQcdJ7t3EmhtIuU1PIgIzzz7DN8dPy8YZWTWZAPpMFGAjYz71NTuoXVlA9Uup4+eZ8XkwFOXFYuis5YPShMk6D43x21nrVPthNopLtls8qYwPUjscdoPJ3EK2DqZ/HJLhWRKyhWhuyfxumQjjwxtuEf0=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org D81A111EE222B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758111478;
	bh=mrFS2WeE2DuciHDNhnemsvIlsB4vcsFJDQytVFcwjBA=;
	h=From:To:Cc:Subject:Date:From;
	b=rMprJkSNXwfixvI/KvYPuDWU2ThRdcup0NF8SckFeJCMLa5mzWAjxW3FzDHnBHKei
	 Qr52qZxw3wQA8u5n/hME7Z5VPB1Ji2Fy3r9QACrfu7gBWR2XKEL3nsQgeV7Z1vsa74
	 gUjOROxaABAkXbuZzB+lJTvytQf8JZUyxr+mzBEo=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: rtl8723bs: sdio: clarify OQT free page comment
Date: Wed, 17 Sep 2025 21:17:54 +0900
Message-ID: <20250917121754.1465051-1-weibu@redadmin.org>
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


