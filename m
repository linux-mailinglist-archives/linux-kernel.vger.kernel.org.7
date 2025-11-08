Return-Path: <linux-kernel+bounces-891332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30320C42749
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A723C34B98D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894622D2382;
	Sat,  8 Nov 2025 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f9GY3D9H"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC96285073
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762577722; cv=none; b=oNl25SLA2dBN2jVNmZBJpdxa/h9SOrlU3eA+RC65XUt1mIhiIzvUgcruZVM87sC2aIZe4ROZQ4fTgYa0VqCdm2xnNkrGYkRE0KEYQjAMBA7cZbM+w1FKH4mygqbrszgKeMemuTmgf88/kYkVuYOJxY7nTfh7OHLILpVYpAGMdCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762577722; c=relaxed/simple;
	bh=zkIgqJpYEtIMxIht+vWzpR2DVTdI2jLj+P9y1s8Tntg=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bk0T4UZFJ2ZFyvXpu0X21rRjADVV6TlMoW5uDWALJ/oKbl6XShRaAezdRPjAJ2JKh2CQErkNgaaNHPZwHuAEm8NLp/TNyIJDyfIdwCR3iVEYgLnEewaw03Tg55d1RpjLiNWryt/zkQhI8gkC4t+6sElMx9Mw9ub2iGX2Xw6m26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f9GY3D9H; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1762577712; x=1762836912;
	bh=L9FF1rZmR8NSXXipfh/1vEUKFhu0ysBNUiH4OZkdsL8=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=f9GY3D9HkzL3N5L9qKt1oXZbkaL7p229u/5puo87gblTaEcgwt5cv+pJa6uNlX1Oc
	 ICa0Soqe04VW3Cncam4bfghqWAOnBNvla8WEx/IEs+gnAcyRFy7eGtBlXqN2N4JGhe
	 v20FCEZ6Ih/ik40aNpch07XKjPyx/HGTOF/IMhxVtsMQHxc++gaGT6nOnKDkrvC+Dd
	 d3Z6rLJ2zUUovLnkHsCMfFwrPI0RHsOf1ulmnyv3IlQILg77kcxdnFUMFFDPFhCwEj
	 TEpE3BModb/pE9G3C0f2/kt6jL2HcatD3CQQah0+FwQi4nVoPKhqtz34q9+SfIgCSL
	 m1xmkLMof5xOg==
Date: Sat, 08 Nov 2025 04:55:07 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From: Bryant Boatright <bryant.boatright@proton.me>
Subject: [PATCH 2/3] staging: rtl8723bs: Rename camel case argument
Message-ID: <6013b38bfb1824aae82cd0c0a466d6af7d53ae63.1762576396.git.bryant.boatright@proton.me>
In-Reply-To: <cover.1762576396.git.bryant.boatright@proton.me>
References: <cover.1762576396.git.bryant.boatright@proton.me>
Feedback-ID: 74848953:user:proton
X-Pm-Message-ID: ce981b59ea3da74b37d0e8f59a4d235ce5f8ccd8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adhere to Linux kernel style.

Reported by checkpatch:

CHECK: Avoid CamelCase: <bw_40MHz>

Signed-off-by: Bryant Boatright <bryant.boatright@proton.me>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 18 +++++++++---------
 drivers/staging/rtl8723bs/include/ieee80211.h  |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/stagi=
ng/rtl8723bs/core/rtw_ieee80211.c
index ed00cec80911..d0bb09177bdf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1077,26 +1077,26 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork=
)
 }
=20
 /* show MCS rate, unit: 100Kbps */
-u16 rtw_mcs_rate(u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate)
+u16 rtw_mcs_rate(u8 bw_40_mhz, u8 short_GI, unsigned char *MCS_rate)
 {
 =09u16 max_rate =3D 0;
=20
 =09if (MCS_rate[0] & BIT(7))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650=
);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?1500:1350):((short_GI)?722:65=
0);
 =09else if (MCS_rate[0] & BIT(6))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585=
);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?1350:1215):((short_GI)?650:58=
5);
 =09else if (MCS_rate[0] & BIT(5))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520=
);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?1200:1080):((short_GI)?578:52=
0);
 =09else if (MCS_rate[0] & BIT(4))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?900:810):((short_GI)?433:390)=
;
 =09else if (MCS_rate[0] & BIT(3))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?600:540):((short_GI)?289:260)=
;
 =09else if (MCS_rate[0] & BIT(2))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?450:405):((short_GI)?217:195)=
;
 =09else if (MCS_rate[0] & BIT(1))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?300:270):((short_GI)?144:130)=
;
 =09else if (MCS_rate[0] & BIT(0))
-=09=09max_rate =3D (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
+=09=09max_rate =3D (bw_40_mhz) ? ((short_GI)?150:135):((short_GI)?72:65);
=20
 =09return max_rate;
 }
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/stagin=
g/rtl8723bs/include/ieee80211.h
index e94efe8f964b..79354f009087 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -781,7 +781,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork);
=20
 void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr);
=20
-u16 rtw_mcs_rate(u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate);
+u16 rtw_mcs_rate(u8 bw_40_mhz, u8 short_GI, unsigned char *MCS_rate);
=20
 int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u=
8 *action);
 const char *action_public_str(u8 action);
--=20
2.43.0



