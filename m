Return-Path: <linux-kernel+bounces-846902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F767BC9609
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED643352278
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9532E92C0;
	Thu,  9 Oct 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IZC1+9zR"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADCD2E92BB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017941; cv=none; b=SlMVkXNABKjKq5KnmkgprBdEkrAH49zwQ5Lrglp0/xjqP/j46+HNMvoZN7AB7V2EnMOSUjLdu2dnFHO8PYKzex7b1Y0DqPM+BJQiDzSFl7stWooYWD3RRZV9Km+dkCWFCKbHHgHLtLFKLbrHoK5K080BszB+EMRogYQaArqNycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017941; c=relaxed/simple;
	bh=226fwwRK/hxnUtfJ10Gtt1cB2BdtnNgr2TcvJSvz3mQ=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=IXCUPrNCCfCPy/G/FAElpoMtfT+RLD9XpPb3A3tCkA/3RPh+ZVG5NOy8SJDG5vRopxoColmOwt7mmIyS98usSXlH4+4qsrrnvJDJ+TBDAlrUfcl/VdOKNcY7YoDc00koFi/xdUfoRcO/zPIC+9z602FybJcZRGUT4WP05eg/f74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IZC1+9zR; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1760017929; x=1760277129;
	bh=LJTjP5lcY6k6Na/oDN618XwMDPQhIZ5CiyuxvlyAgq4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IZC1+9zRHwWXnpB9/7o4nzcRSxnFyTsQv3z2G+0oS91p59sG5sdzxaDKxIpRYba4x
	 bU7Oj9nzh5MSewqsZN8q3KqVFNvF643F2j5hzM3JrYgpmyLNovWs4pMIt1Ry9Q50Zp
	 RO7khU6lyY8yAa6si84gFY98WJzu4nE2BxiSkUU8WjOhipliTuBN7MPQFLjIhrjRLE
	 w5vOK+TGIOQF9F0ryxtnYRRdQUdVo4aRURqTb8zyLwSZpAIo4w9XhghUmGwFk/SA6I
	 1zTeRMVHpUtk1ePIQb6pWKpM1nZLu1KJgHD7A7LmWU+qFk3MBcnv/ZPq1PMo+jDcDI
	 ZPf91z/zQdGjQ==
Date: Thu, 09 Oct 2025 13:52:03 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From: Bryant Boatright <bryant.boatright@proton.me>
Subject: [PATCH] staging: rtl8723bs: Rename camel case functions.
Message-ID: <aOe9_EQ6v8iK2lxp@ubuntu-desk>
Feedback-ID: 74848953:user:proton
X-Pm-Message-ID: 8366156c9c79ba94a2eb50f27298a0efcc762622
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rename two functions from camel case to snake case to follow kernel
style.
- `UpdateBrateTbl` to `update_basic_rate_table`
- `UpdateBrateTblForSoftAP` to `update_basic_rate_table_soft_ap`

Signed-off-by: Bryant Boatright <bryant.boatright@proton.me>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c          | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 4 ++--
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8=
723bs/core/rtw_ap.c
index b12b53a8b3be..67197c7d4a4d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -777,7 +777,7 @@ void start_bss_network(struct adapter *padapter)
 =09update_wireless_mode(padapter);
=20
 =09/* update RRSR after set channel and bandwidth */
-=09UpdateBrateTbl(padapter, pnetwork->supported_rates);
+=09update_basic_rate_table(padapter, pnetwork->supported_rates);
 =09rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rate=
s);
=20
 =09/* update capability after cur_wireless_mode updated */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/stagin=
g/rtl8723bs/core/rtw_mlme_ext.c
index a897c433d2b0..8fe0555ab033 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1062,7 +1062,7 @@ unsigned int OnAssocReq(struct adapter *padapter, uni=
on recv_frame *precv_frame)
 =09/* update station supportRate */
 =09pstat->bssratelen =3D supportRateNum;
 =09memcpy(pstat->bssrateset, supportRate, supportRateNum);
-=09UpdateBrateTblForSoftAP(pstat->bssrateset, pstat->bssratelen);
+=09update_basic_rate_table_soft_ap(pstat->bssrateset, pstat->bssratelen);
=20
 =09/* check RSN/WPA/WPS */
 =09pstat->dot8021xalg =3D 0;
@@ -1450,7 +1450,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, uni=
on recv_frame *precv_frame)
 =09pmlmeinfo->state |=3D WIFI_FW_ASSOC_SUCCESS;
=20
 =09/* Update Basic Rate Table for spec, 2010-12-28 , by thomas */
-=09UpdateBrateTbl(padapter, pmlmeinfo->network.supported_rates);
+=09update_basic_rate_table(padapter, pmlmeinfo->network.supported_rates);
=20
 report_assoc_result:
 =09if (res > 0)
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/stagi=
ng/rtl8723bs/core/rtw_wlan_util.c
index 1def9758852c..74d3f2de360d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -181,7 +181,7 @@ void set_mcs_rate_by_mask(u8 *mcs_set, u32 mask)
 =09mcs_set[3] &=3D mcs_rate_4r;
 }
=20
-void UpdateBrateTbl(struct adapter *Adapter, u8 *mBratesOS)
+void update_basic_rate_table(struct adapter *Adapter, u8 *mBratesOS)
 {
 =09u8 i;
 =09u8 rate;
@@ -203,7 +203,7 @@ void UpdateBrateTbl(struct adapter *Adapter, u8 *mBrate=
sOS)
 =09}
 }
=20
-void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
+void update_basic_rate_table_soft_ap(u8 *bssrateset, u32 bssratelen)
 {
 =09u8 i;
 =09u8 rate;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/sta=
ging/rtl8723bs/include/rtw_mlme_ext.h
index 53fac838c36a..dd5080056e58 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -434,8 +434,8 @@ u8 networktype_to_raid_ex(struct adapter *adapter, stru=
ct sta_info *psta);
=20
 void get_rate_set(struct adapter *padapter, unsigned char *pbssrate, int *=
bssrate_len);
 void set_mcs_rate_by_mask(u8 *mcs_set, u32 mask);
-void UpdateBrateTbl(struct adapter *padapter, u8 *mBratesOS);
-void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen);
+void update_basic_rate_table(struct adapter *padapter, u8 *mBratesOS);
+void update_basic_rate_table_soft_ap(u8 *bssrateset, u32 bssratelen);
=20
 void Save_DM_Func_Flag(struct adapter *padapter);
 void Restore_DM_Func_Flag(struct adapter *padapter);
--=20
2.43.0



