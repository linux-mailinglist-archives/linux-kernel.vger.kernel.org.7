Return-Path: <linux-kernel+bounces-894043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EBC49247
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC263A82E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30C6336EFD;
	Mon, 10 Nov 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cSj4BM4d"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7022F16E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804202; cv=none; b=SXdxYfXz8xFnYjyt8zO566X12NywIb5AKmphdy3zoMbnWlmHnF0yQKesgbQ6VI+ss40UIxyM3suMznPSFMKTAEN9p7b7qYN6rQwibXwmHdy+FO90zSJ+MomQ0IcaoZFTDfSOXFlPUZNJejEljVbi7m5sLXvcv32oOvn4CFxIDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804202; c=relaxed/simple;
	bh=kwI1ysU7OoOAYwjztLjWKYg+hv4i/B2igL/e3SbTj6g=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRfNNZwPNQKKLRy+JpqIfW/P28hFmfjMiEsFm7N562se/vUKMUPuBU0WfZL2Du0JGFES77q55xB5x/NTShv9VQ547wVAFqMxd5KCH3eKh5ipTNyHJdpCvn2cn6BLuMW+BLrUZwW8zx9i5uBksCfwCVKQ6zs9i7EJLHIlo4fH8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cSj4BM4d; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1762804191; x=1763063391;
	bh=fwy2b9N1qenHnH40yBPHy9NN7Uvh+/7mX2jkCge5Mc0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cSj4BM4drSdxPe0zmKypwCJBFDLdSlGV+v4NTrzaUO7EDktbKEL31MkuQ5sSeekfy
	 O1MiTgBkewt3NdAVLu13HG2JhkkGv5LOi5fdRzq7ppmS94BvJ/ioNWboLmu7tSY24X
	 b/bJNJg4cfAlTmeW1jWJYti9St1VRVA9mWQB+ywGVUbc97hMw1dCZpRrfVqCgkW48I
	 GvmHJuADgrpdSyt3Y1A9l75tMjqUkIWGj7jweG089DSLTWn9oV+GIMVXXp5QDw7nM+
	 TBOQygKTs7vO10BZ2Xm1JHGdGLQpYBwRN5R2bap3rlAMJ7RNGZVSdTef4FeNLwG8BD
	 SzVmemQBGBhzA==
Date: Mon, 10 Nov 2025 19:49:46 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Michael Straube <straube.linux@gmail.com>
From: Bryant Boatright <bryant.boatright@proton.me>
Subject: [PATCH v2 2/3] staging: rtl8723bs: Rename camel case argument
Message-ID: <6fa67d3588ac82dadd715bcb9c16d4e79dac506e.1762803720.git.bryant.boatright@proton.me>
In-Reply-To: <cover.1762803720.git.bryant.boatright@proton.me>
References: <cover.1762803720.git.bryant.boatright@proton.me>
Feedback-ID: 74848953:user:proton
X-Pm-Message-ID: 2e0705a150208333325d65ea39b3b221e9b3674b
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
index d25fd538305a..f22f8a95f372 100644
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
index f94db820d335..cf0bfe3e19ba 100644
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



