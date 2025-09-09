Return-Path: <linux-kernel+bounces-807179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE643B4A140
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3241B269DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1D42F9C2D;
	Tue,  9 Sep 2025 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="xgccHTth"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08B3597A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396030; cv=pass; b=KkbNpGUPMsUhEpPnIlvCLsmt9kC6vMN0sARr1cwRsE1rITlqQNDBo4Zt+rglezcHMDu4O01e74xUyC1RBGiY5vXIcL6vZmrttk5PRopxrv91nWAghZCVtNT8bGywrjyJi2Ioyq6UwaOglRAMVXqNXfd/XbSPi9Mr/dxdv73A8As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396030; c=relaxed/simple;
	bh=Jiu9IkpCu/PhD8blolrlBLuSV/bRiQPpG3U0Bpj0fIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBC9M8Ye5Ejfrd6A6S0G9V3Qs4842F+DGa/15UvQJe23rIUHR3ExyMW3HIhuySIWe3N5T2x0CsbDYxjsVaVTgBciYWKUdmPyPtAOnhC4d/gHaUSHlSHWw6NmE9AmNn+DO4pKalopny7QpBQT3B753kn3PxkwAeywwGopfic9/6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=xgccHTth; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 1BA0E10A2494E;
	Tue,  9 Sep 2025 14:33:46 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zI28cWgu0xBq; Tue,  9 Sep 2025 14:33:42 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id CBAFD10A2494C; Tue,  9 Sep 2025 14:33:42 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757396022;
	cv=none; b=CDBKTDcc8Lb8se7VrpURCzw/GlwNfQayML1fysTNxscyxsC5b58Pec/Z00ejLSYRgDRZJf/SkBqsDOE9t3F0+BRqmB9rb4tEjGfH1zZDgd5WdIxcfjhnAA1ctqcSt9TWD/1UU4vhafPM22LIoNwRmuy5xWskIb7I2EOQbhYIxU4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757396022; c=relaxed/relaxed;
	bh=8A2BTSpE6bRBxzMuwWo4ycK919iclxMMLpgmuPjlQRg=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ZY0seLZ4Iz6vrlHhnDxFRn7nPMEg6Ks0Y6HR86lImypuoiKe3zakkdfULtibANldc1cMo+cbP5iBJGtD4cK7htrFxf/mywrZHoW966Zm1KCme5aFv/TVuAg+jEQ7MEvfkh9a9trQZ9ioEdnSi8ojnKf06i8o4em98YdtmMg2dwM=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org CBAFD10A2494C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757396022;
	bh=8A2BTSpE6bRBxzMuwWo4ycK919iclxMMLpgmuPjlQRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xgccHTthhODA6cE2MA88DeLpFEEF0V90fy6pJSX8sKkGtvXCi9cw7stUndkrsJ3kQ
	 qgyvnZizcZx9kZO62wxZ0t9UiRLei0eAZ1KAR262UAzHFJImFrAFfpaNZLFDp+YzmK
	 SfzHdxh7y1hU6ZeC8XnUesp5SDFIaWWyet+0t6eM=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v2 2/2] staging: rtl8723bs: rtw_efuse.h: fix double space in PwrState parameter
Date: Tue,  9 Sep 2025 14:33:27 +0900
Message-ID: <20250909053327.140763-2-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909053327.140763-1-weibu@redadmin.org>
References: <20250909035804.129904-1-weibu@redadmin.org>
 <20250909053327.140763-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix coding style by removing a double space before the PwrState parameter.
No functional changes.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/include/rtw_efuse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/stagin=
g/rtl8723bs/include/rtw_efuse.h
index ac7d6ef454c3..d791e35db769 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -92,7 +92,7 @@ void EFUSE_GetEfuseDefinition(struct adapter *padapter, u=
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


