Return-Path: <linux-kernel+bounces-858673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79ABEB638
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A521AE0CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07E2FC86B;
	Fri, 17 Oct 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iqEBbqsz"
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C911D5ABA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729426; cv=none; b=PFMSawmGinvwyvl3epFfGfp+Va3+hKZfWbH/OYVD9SDsmxHo4Dv2v1H4BhvoTKaE5FzuVe0g/ruxzeHC2l1sdySadEswMDDP0pL3fQo3FdI1BcTOIw5fLQfj/+oSjTcTLf8SCn1aKKHrUtoqpuTXD/g9QB46FKsCiQEgLY5fZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729426; c=relaxed/simple;
	bh=6RT3JtlulKLUnhnz8zcUfbFxYUf9YDFWOKriEy8vET8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=JVh/eCx3YyKrIyTjflThhwyjDMEGdRDN+Bp1Mmd/WcGg++IcWnR5yU9p0A9qVVewwUhHuGvKzr1XxRoGq/y8r7wxb5DCpvaiGB18NQE+Vj0IyzxlqjIoZI49Npswu8f2vdf5qlqXC/VUuhTpp/Wgu04ka8Bu0+0EP9BZ8FBu/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=iqEBbqsz; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760729407; x=1760988607;
	bh=6RT3JtlulKLUnhnz8zcUfbFxYUf9YDFWOKriEy8vET8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iqEBbqsz4QPNMGCU8IIU6kwK2HBXxqSIBxFQYQCxyGYCfyh7CIQFz8ShYGDfUwmBb
	 7/kh/LvqFjkm6zx7KARKmRqO/t6EZdWFZNhtq2u5OW2ESKwbZehY9V33izg7DWr2ip
	 0nabzjb1Aq9lS2Mz3o+LRJSc+jKqQe19QRIfHdkAbf5JsXpJWlpvXucz8Tj7TKoVtp
	 qyLsruPbzA3cRRaXkDhaibSj/7mNKRUrTquS6toJtzTcGbqJAsm2sbty0Pm4/GEAk0
	 yj+VtQIaJr3hdhvIUmIz+PZrnhUrbmsxusJDU38W8GkWYd5pZsLlNYwTIQX6ENlkLo
	 t8j05ThFZ7D/A==
Date: Fri, 17 Oct 2025 19:30:01 +0000
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
From: Yannis Bolliger <yannis.bolliger@protonmail.com>
Subject: [PATCH] extcon: usbc-tusb320: Make typec-power-opmode optional
Message-ID: <aPKZJ6WTZlhSOyST@yaene-desktop>
Feedback-ID: 22612187:user:proton
X-Pm-Message-ID: 8b22bec5ec77fd0d754ec66c255469f73072efa4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The driver returned an error in the probe function when a usb c
connector is configured in the DT without a "typec-power-opmode"
property. This property is used to initialize the CURRENT_MODE_ADVERTISE
register of the TUSB320, which is unused when operating as a UFP.
Requiring this property causes unnecessary configuration overhead and
inconsistency with the USB connector DT bindings, which do not specify
it as required.

This change makes typec-power-opmode optional. When the property is not
present, the driver will skip programming the CURRENT_MODE_ADVERTISE
register and rely on the hardware default.

Signed-off-by: Yannis Bolliger <yannis.bolliger@protonmail.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-u=
sbc-tusb320.c
index 2eab341de6b7..b8ff91010e63 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -454,20 +454,17 @@ static int tusb320_typec_probe(struct i2c_client *cli=
ent,
 =09priv->port_type =3D priv->cap.type;
=20
 =09/* This goes into register 0x8 field CURRENT_MODE_ADVERTISE */
-=09ret =3D fwnode_property_read_string(connector, "typec-power-opmode", &c=
ap_str);
-=09if (ret)
-=09=09goto err_put;
-
-=09ret =3D typec_find_pwr_opmode(cap_str);
-=09if (ret < 0)
-=09=09goto err_put;
-
-=09priv->pwr_opmode =3D ret;
-
-=09/* Initialize the hardware with the devicetree settings. */
-=09ret =3D tusb320_set_adv_pwr_mode(priv);
-=09if (ret)
-=09=09goto err_put;
+=09if (!fwnode_property_read_string(connector, "typec-power-opmode",
+=09=09=09=09=09 &cap_str)) {
+=09=09ret =3D typec_find_pwr_opmode(cap_str);
+=09=09if (ret < 0)
+=09=09=09goto err_put;
+=09=09priv->pwr_opmode =3D ret;
+=09=09/* Initialize the hardware with the devicetree settings. */
+=09=09ret =3D tusb320_set_adv_pwr_mode(priv);
+=09=09if (ret)
+=09=09=09goto err_put;
+=09}
=20
 =09priv->cap.revision=09=09=3D USB_TYPEC_REV_1_1;
 =09priv->cap.accessory[0]=09=09=3D TYPEC_ACCESSORY_AUDIO;
--=20
2.51.0



