Return-Path: <linux-kernel+bounces-806451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC6B496ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762FE4E03E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E643128AB;
	Mon,  8 Sep 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="JFafQsHn"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E223128BD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352583; cv=pass; b=oSfhBJhC3/sk29OR8OGYZoKtD5ASOYqBWNrnOvjd+s9Fj0keaSONCF35UtoeSxpb1hvo4gR5x/qy6b5a8PHQkqTsE7xPVBqFAudAVJeic9lDzp0qxRBZ2dPjP5YOFSu85OCn0BvvNyJSLO/vIwYkZIZ6ZY0UtjsPBnfVJOoSbt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352583; c=relaxed/simple;
	bh=Outa1seiw0Jw/DitDf8MCsEt0I6mlxIUZg/kSOj2Lgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAiU9UklIAy/ovpHXb62cN/WHjnjVPX/B5lXEVY3YICX7fO3GTguv127+gnAqvuwuMFY15eTk8CJARvAJBYzlh9XTBmdVWHc3mONz+N1Uf/DVfgirLbkYXj2lfXw5+IGzxZ2U3ZtHMHQBSP+2Gv1GqX5hD1NS5DOVQran23HJCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=JFafQsHn; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 43E8410A2494C;
	Tue,  9 Sep 2025 02:29:32 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3E_pwIbrZ-_9; Tue,  9 Sep 2025 02:29:28 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 05F82109C12BC; Tue,  9 Sep 2025 02:29:28 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757352568;
	cv=none; b=PkYTCWDybOf3qs1W9yS56T1cN2qfFqS+TGULKDec90fwvLobCu2tkdeQKAEviFZwsZwQ7gqQr1ur4m4h5Clfs9Z66+OmahsiHD7/VdEjYY/c2KMsJnLiDpAWDOpO1clZEKFv/iSaX9JYEcEH1sbK6e9ZkJ8IOt7PaykVvvEWN3E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757352568; c=relaxed/relaxed;
	bh=kZxHrX2DwqiQCCEPyMM3pu+6SFKHCaFNVhDazdiwPQY=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=JDDUtGhOoQvmv+aytVcnRX/3gcIcuv0J0VyhrOL9ntyzOX4HpFp7FUKu82qIsFAPk9Br8TIHUGwIrr6C0YfyvzDSbXiehGcRG9CCYToyNjoH6CnUSA2eUlpLn20k9tRESqXqcaOvRiRLxJbWvMSyEZJJxeZbZG96bqRSggdSsmk=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 05F82109C12BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757352568;
	bh=kZxHrX2DwqiQCCEPyMM3pu+6SFKHCaFNVhDazdiwPQY=;
	h=From:To:Cc:Subject:Date:From;
	b=JFafQsHnZs01hvH5YhcGRXgryP6HnBY+Kg0vzVYuSn26SiKQwpVyNioPy9gV1Mu6e
	 jYj2YTHUccLIXvxtl14qv2sEfuVej2mysacUA9ePaI5ukfT4g99/u5Vg3+lqEvRFhw
	 UqR1nJ7LcSVQJN80TV6zF1l/CcY3F3tuZQy/TPWs=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v2] staging: rtl8723bs: fix function definition style in hal_com_phycfg.c
Date: Tue,  9 Sep 2025 02:29:25 +0900
Message-ID: <20250908172925.58312-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several function definitions in this file did not follow the kernel
coding style, spreading arguments across multiple lines.

As requested by Dan Carpenter, fix all instances to place the function
parameters and the closing parenthesis on the same line as the function
name, improving readability and conforming to style guidelines.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 33 ++++---------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/stagi=
ng/rtl8723bs/hal/hal_com_phycfg.c
index 75ed731bbb14..fa987a797b16 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -61,8 +61,6 @@ phy_SetTxPowerByRateBase(struct adapter *Adapter, u8 RfPa=
th,
=20
 static void
 phy_StoreTxPowerByRateBase(struct adapter *padapter)
-{
-	u8 path, base;
=20
 	for (path =3D RF_PATH_A; path <=3D RF_PATH_B; ++path) {
 		base =3D PHY_GetTxPowerByRate(padapter, path, MGN_11M);
@@ -80,9 +78,7 @@ u8 PHY_GetRateSectionIndexOfTxPowerByRate(struct adapter =
*padapter, u32 RegAddr,
 u8 PHY_GetRateSectionIndexOfTxPowerByRate(struct adapter *padapter, u32 Re=
gAddr, u32 BitMask)
 u8 PHY_GetRateSectionIndexOfTxPowerByRate(struct adapter *padapter, u32 Re=
gAddr, u32 BitMask)
 	struct dm_odm_t *pDM_Odm =3D &pHalData->odmpriv;
-	u8	index =3D 0;
-
-	if (pDM_Odm->PhyRegPgVersion =3D=3D 0) {
+u8 PHY_GetRateSectionIndexOfTxPowerByRate(struct adapter *padapter, u32 Re=
gAddr, u32 BitMask)
 		switch (RegAddr) {
 		case rTxAGC_A_Rate18_06:
 			index =3D 0;
@@ -137,16 +133,8 @@ void PHY_GetRateValuesOfTxPowerByRate(struct adapter *=
padapter, u32 RegAddr, u32
=20
         switch (RegAddr) {
         case rTxAGC_A_Rate18_06:
-        case rTxAGC_B_Rate18_06:
-                RateIndex[0] =3D PHY_GetRateIndexOfTxPowerByRate(MGN_6M);
-                RateIndex[1] =3D PHY_GetRateIndexOfTxPowerByRate(MGN_9M);
-                RateIndex[2] =3D PHY_GetRateIndexOfTxPowerByRate(MGN_12M);
-                RateIndex[3] =3D PHY_GetRateIndexOfTxPowerByRate(MGN_18M);
-                for (i =3D 0; i < 4; ++i)
-                        PwrByRateVal[i] =3D (s8)(((Value >> (i * 8 + 4)) &=
 0xF) * 10 +
-                                               ((Value >> (i * 8)) & 0xF));
-                *RateNum =3D 4;
-                break;
+void
+PHY_GetRateValuesOfTxPowerByRate(struct adapter *padapter, u32 RegAddr, u3=
2 BitMask, u32 Value, u8 *RateIndex, s8 *PwrByRateVal, u8 *RateNum)
=20
         /* add the rest of cases here ... */
=20
@@ -425,10 +413,8 @@ void PHY_SetTxPowerIndexByRateSection(
 static void phy_ConvertTxPowerByRateInDbmToRelativeValues(struct adapter *=
padapter) 					     ARRAY_SIZE(cckRates));
=20
 	} else if (RateSection =3D=3D OFDM) {
-		u8 ofdmRates[]  =3D {MGN_6M, MGN_9M, MGN_12M, MGN_18M, MGN_24M, MGN_36M,=
 MGN_48M, MGN_54M}; 		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, ofdmRates,
-					       ARRAY_SIZE(ofdmRates));
+static void
+phy_ConvertTxPowerByRateInDbmToRelativeValues(struct adapter *padapter)
=20
 	} else if (RateSection =3D=3D HT_MCS0_MCS7) {
 		u8 htRates1T[]  =3D {MGN_MCS0, MGN_MCS1, MGN_MCS2, MGN_MCS3, MGN_MCS4, M=
GN_MCS5, MGN_MCS6, MGN_MCS7};
@@ -498,14 +484,7 @@ u8 PHY_GetTxPowerIndexBase(struct adapter *padapter, u=
8 RFPath, u8 Rate, enum ch
 	case MGN_5_5M:
 		index =3D 2;
 		break;
-	case MGN_11M:
-		index =3D 3;
-		break;
-	case MGN_6M:
-		index =3D 4;
-		break;
-	case MGN_9M:
-		index =3D 5;
+u8 PHY_GetTxPowerIndexBase(struct adapter *padapter, u8 RFPath, u8 Rate, e=
num channel_width BandWidth, u8 Channel)
 		break;
 	case MGN_12M:
 		index =3D 6;
--=20
2.47.3


