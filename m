Return-Path: <linux-kernel+bounces-807130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FF8B4A073
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52041B2637F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D12D879C;
	Tue,  9 Sep 2025 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="Wpy1PzDt"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7826F2BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390295; cv=pass; b=k8J4p/FfvsJT2WOgzclx+EMV9SgX9o7Fs0ZjTj6NZxvR67iPz4LGv6g+37Al5ZA31yXU9E1x4kobipDNvkn/p985+C5enxIKZxVqPomJ2SlYgZHLwrYq4Ny9mO0Nr2YBKck+u/LbZUsuoD9aGWLVGAn+kJGVdT1Ysc2y2eGAl8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390295; c=relaxed/simple;
	bh=Z+hMnG2fxpJLQmYFSwzznOnJO274LKvp98j3W0HmHis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKb/ihCEq2IPGRE9o5+lmd8O6GoKAaLLjNPJD5Y/7sdaWxc0Xaxs7nvk8KjnTrNwdlugLcn/Kur9Ti4UK0iayoZNV1GudAZR5ItkqrhET3N9SZo+HgUAkBhC87DgeJKi+2EW3h87/uEDPvQqJFgpCeeQRSxv13aRU0pTF8s+ycM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=Wpy1PzDt; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id D5F2D10A2494E;
	Tue,  9 Sep 2025 12:58:11 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qKDmZJy3mx3X; Tue,  9 Sep 2025 12:58:08 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 4E49210A2494C; Tue,  9 Sep 2025 12:58:08 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757390288;
	cv=none; b=yi2CSh0FC7Mtch7TQ0f92rVP+71Dq86VdazZ8rdP6o1ye7vS8H3Q35R4jiTQ0ertHRFp5Hyk5TYjDaoGWWR0mXEDWM5aCkFSTiZgUmb3lorXQOX+JbDb3LzU85qjyTM4TwruuZcracWKWAeD3LD6HQv3m5LpH8mJYWYRhmJ8wfg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757390288; c=relaxed/relaxed;
	bh=94M6CI9XlJchxWruMx+JgjAJfNASuGSM6Aso/eXZams=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=ikspzZeAmC+bcPI6MKarElVHN/yG49XvPIqYBm6vHCCiRIlLi38LOnrTCWCp5QufVgOQzBT0mJg3arkV56RGDdONWs+alL/YGkwTyxCdD7+94+in6IiG2D7EhQf4ZhN4otan7sp6RtJMfSZ6kRtOO3Lo8qLli8fjaJc6tYA5fOY=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 4E49210A2494C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757390288;
	bh=94M6CI9XlJchxWruMx+JgjAJfNASuGSM6Aso/eXZams=;
	h=From:To:Cc:Subject:Date:From;
	b=Wpy1PzDtCS+YscHqu2OJE7KyqZTfSfggDlvaaryRHB9XISJbyE6ci8FpKpUP+2l7z
	 SzlBIc3CdcQ1jo7gEFGziX1WftEKFOZuMdV2pPzJoCtD0VV6OTglExwSDLv70IzjTj
	 v2N4GZvdChTuRks2JcdLbMpBXSGcGMRkgbjOYbRs=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: rtl8723bs: rtw_efuse.h: simplify copyright banner
Date: Tue,  9 Sep 2025 12:58:04 +0900
Message-ID: <20250909035804.129904-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace the banner-style copyright comment with a single-line comment.
No functional changes.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/include/rtw_efuse.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/stagin=
g/rtl8723bs/include/rtw_efuse.h
index 669565fa1c69..d791e35db769 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -1,9 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*************************************************************************=
*****
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- *************************************************************************=
*****/
+/* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved. */
+
 #ifndef __RTW_EFUSE_H__
 #define __RTW_EFUSE_H__
=20
@@ -95,7 +92,7 @@ void EFUSE_GetEfuseDefinition(struct adapter *padapter, u=
8 efuseType, u8 type, v
 u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 b=
PseudoTest);
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 b=
PseudoTest);
=20
-void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
+void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
=20
 u8 EFUSE_Read1Byte(struct adapter *padapter, u16 Address);
 void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bP=
seudoTest);
--=20
2.47.3


