Return-Path: <linux-kernel+bounces-894045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F5C49229
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E37188DBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57428A701;
	Mon, 10 Nov 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="k1PyXYPn"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCE1E1E1C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804236; cv=none; b=q0s/z9E1NhYU1y9wVAPDp/EEKN+A4nEHEp0IcObYboL+03eitDeuRo3sFC4rKLx+rkaGlzmKpImmfgdrZcnjbzuyd1H82HgGY4rZ7P0J8HyX5HL33dM+LJ3YoXBfWQvTIjWowWbVtx5tRkWc6YScvChEXDKWfTr9zOMY1/nD80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804236; c=relaxed/simple;
	bh=pM+ryh+peS3MW7J36lM3F3DF53GT4/xEBxyaLV7SsEo=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpk1xhmS4jcB1F+C2/8YUrPdA7rOMrtelY5mcdsbNUn1xSi4o7paN19kR7BNzBddhC79ijmMtNCxuJ6fsDIX2UMncUP76c3VRHCxC3YB2jlq/zszz7rFGKKLEZmF4xmTmsMqUpo6GBU/tN/kQiMaiL2ZN2a9bXZWyF2ZnRm4FQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=k1PyXYPn; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1762804232; x=1763063432;
	bh=pM+ryh+peS3MW7J36lM3F3DF53GT4/xEBxyaLV7SsEo=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k1PyXYPnS1hOwIp8tBT4jeX0zVLMYb1xFP6sjB2qVO+oi9YopbuJ8FGoD2FVVxPGI
	 RvOacKEzeGqGsBygTjg8PYo9ejPHpeksgsmGX2F6kFDYqpR6k+vSuStpIxjTrvYFLF
	 7FMfdR60pApoRSAjWVSUZZjNIckdT4smNkbFGNOWEwRA+DVLsi37AXR6loyc4JXVvL
	 kAQYheMfEG7+laJih5N0C+kGQJ9uORqQAV+Ponmy33HJ78cKTsbt+6hQM88KGjnUYC
	 1vw6Ayo52xykwgprtq+G+y7duPEvEaxI0swr0kfLPEqPiwO7rqy7iwmNFpQoeo80en
	 GM/9xT7sSzNyg==
Date: Mon, 10 Nov 2025 19:50:26 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Michael Straube <straube.linux@gmail.com>
From: Bryant Boatright <bryant.boatright@proton.me>
Subject: [PATCH v2 3/3] staging: rtl8723bs: Rename camel case variiable
Message-ID: <680467c25692e94629734a690e64881279bd4d2b.1762803720.git.bryant.boatright@proton.me>
In-Reply-To: <cover.1762803720.git.bryant.boatright@proton.me>
References: <cover.1762803720.git.bryant.boatright@proton.me>
Feedback-ID: 74848953:user:proton
X-Pm-Message-ID: cac8bc0eff9b48661c6c9425293f09977afc86e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Avoid CamelCase: <rateLen>

Signed-off-by: Bryant Boatright <bryant.boatright@proton.me>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/stagi=
ng/rtl8723bs/core/rtw_ieee80211.c
index f22f8a95f372..40220f1ab582 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -285,7 +285,7 @@ uint rtw_get_rateset_len(u8 *rateset)
 int rtw_generate_ie(struct registry_priv *pregistrypriv)
 {
 =09u8 wireless_mode;
-=09int=09sz =3D 0, rateLen;
+=09int=09sz =3D 0, rate_len;
 =09struct wlan_bssid_ex *pdev_network =3D &pregistrypriv->dev_network;
 =09u8 *ie =3D pdev_network->ies;
=20
@@ -320,13 +320,13 @@ int rtw_generate_ie(struct registry_priv *pregistrypr=
iv)
=20
 =09rtw_set_supported_rate(pdev_network->supported_rates, wireless_mode);
=20
-=09rateLen =3D rtw_get_rateset_len(pdev_network->supported_rates);
+=09rate_len =3D rtw_get_rateset_len(pdev_network->supported_rates);
=20
-=09if (rateLen > 8) {
+=09if (rate_len > 8) {
 =09=09ie =3D rtw_set_ie(ie, WLAN_EID_SUPP_RATES, 8, pdev_network->supporte=
d_rates, &sz);
-=09=09/* ie =3D rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pd=
ev_network->supported_rates + 8), &sz); */
+=09=09/* ie =3D rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (p=
dev_network->supported_rates + 8), &sz); */
 =09} else {
-=09=09ie =3D rtw_set_ie(ie, WLAN_EID_SUPP_RATES, rateLen, pdev_network->su=
pported_rates, &sz);
+=09=09ie =3D rtw_set_ie(ie, WLAN_EID_SUPP_RATES, rate_len, pdev_network->s=
upported_rates, &sz);
 =09}
=20
 =09/* DS parameter set */
@@ -336,8 +336,8 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv=
)
=20
 =09ie =3D rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->co=
nfiguration.atim_window), &sz);
=20
-=09if (rateLen > 8)
-=09=09ie =3D rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_=
network->supported_rates + 8), &sz);
+=09if (rate_len > 8)
+=09=09ie =3D rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (pdev=
_network->supported_rates + 8), &sz);
=20
 =09/* HT Cap. */
 =09if ((pregistrypriv->wireless_mode & WIRELESS_11_24N) &&
--=20
2.43.0



