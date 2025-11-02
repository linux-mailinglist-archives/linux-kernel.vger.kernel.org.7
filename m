Return-Path: <linux-kernel+bounces-881974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A2C295A3
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A2C188CD57
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBE91F4CBB;
	Sun,  2 Nov 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="W26AloMC"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879F79F2;
	Sun,  2 Nov 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110148; cv=pass; b=RSyUglEXXKc0asqIcJqMbfYkDPm2qZVa4lXd76E4KgOzGpS5QOPKXmleCMJwKrFJjwb0pQwFjKVtr4w45HdkXvHYlz20HN/4rdEZFJ3VJuF2ptLKFSkfu+Px7ZydNIbBetSdYcP/v0LLXrEErnzYYGWndlMaQBjfMnRC9MNkhPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110148; c=relaxed/simple;
	bh=uW41SGp+KLAtrXCBgHOFhuCPtjHCnsJ0Ik2QgG6MNDc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=iksfQ2mP4cp/tRHaj9utIYTbmqPn28IrU/YbsWJp1fYVb/A6hcCz+KiE96Rr01Bi6GgSew2RFrwNrXu93A3rDXTrdSCjZLnZN21xAHZtvQBnmczTGGal24eGADBzYYZiM+fYc0wTNAJzrdgMLk9jQ2EalLXLobRuyF2NiIiFlOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=W26AloMC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1762110132; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CD4tDJpCukeJezFEw2kSzhiRKB8iv8iNRALUAxENoGypRv6J+g5A7Go3/SKKtm5LjIMfSSGtO182S7dpKMwcFAc9MoUdHxdehQceesl/DIXpRmRlHZzLKJVnndpLr5OtuRKt35HNUh755QJk2cBKefY7SzGJNSaj005ujlg+mFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762110132; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZY6jDkRPdA6CWdxMWs9aEGnkJdWPXA4kDIjAJU/tycs=; 
	b=QMwSx2kbci5go+ZH4c1RtA5CFOdp23sqk7c7vx9fzV0kYgVuC4fY+6a/uHn4sbRqAw7x/+wCK6eNWo6MAHNTDsl+gcEL0k6jMb7z7NF3Cu6M3bJfpyCFc1jWXNu0UPTHk97bWIq2b2mgGVBSlabo8o6FvI1s6n9fZHofNRbEmDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762110132;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=ZY6jDkRPdA6CWdxMWs9aEGnkJdWPXA4kDIjAJU/tycs=;
	b=W26AloMCqplQav8MABHSJasbcZ9s/6Wvx8Xt16nUxqYmhaFgIysOzO5Csdloj+Nx
	nJ8TnkYXDXIuVwqE3xtYtIuXM1GSkcCT6T3vcjC6WIlI6VfsYS9ovbjrPnUH5DU9+FH
	SYaeGPomTP5P20cngTkXoNGjp6l9xqvgKviZQ7Lk=
Received: by mx.zohomail.com with SMTPS id 1762110129191488.5069062313564;
	Sun, 2 Nov 2025 11:02:09 -0800 (PST)
Message-ID: <5d1ae6eb34378570ed1f9b62d945c95bda8a5b86.camel@rong.moe>
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Add
 charge_types:Fast (Rapid Charge)
From: Rong Zhang <i@rong.moe>
To: Jelle van der Waa <jelle@vdwaa.nl>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ikepanhc@gmail.com>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,  "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
In-Reply-To: <dfa70284-04ce-482d-8d79-cc0ee8b4bf6d@vdwaa.nl>
References: <20251020192443.33088-1-i@rong.moe>
	 <dfa70284-04ce-482d-8d79-cc0ee8b4bf6d@vdwaa.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Nov 2025 02:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-5 
X-ZohoMailClient: External

Hi Jelle,

On Sun, 2025-11-02 at 17:09 +0100, Jelle van der Waa wrote:
> On 10/20/25 21:24, Rong Zhang wrote:
> > The GBMD/SBMC interface on IdeaPad/ThinkBook supports Rapid Charge mode
> > (charge_types: Fast) in addition to Conservation Mode (charge_types:
> > Long_Life).
> >=20
> > This patchset exposes these two modes while carefully maintaining their
> > mutually exclusive state, which aligns with the behavior of manufacture=
r
> > utilities on Windows.
> >=20
> > Tested on ThinkBook 14 G7+ ASP.
>=20
> Tested this patch on my Lenovo Ideapad U330p, it now advertises that=20
> `Fast` is a supported charge_type although my laptop does not seem to=20
> support it:
>=20
> [root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
> Fast [Standard] Long_Life
> [root@archlinux jelle]# echo 'Fast' >=20
> /sys/class/power_supply/BAT1/charge_types
> [root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
> Fast [Standard] Long_Life

Ahh, then we need an approach to determine if it is supported on a
specific device.

Glancing at the disassembled DSDT.dsl of my device, I found:

   Method (GBMD, 0, NotSerialized)
   {
   	[...]
   	If ((One =3D=3D QCGS))
   	{
   		Local0 |=3D 0x00020000
   	}
   	[...]
   }

BIT(17) of GBMD is 1 on my device. Maybe QCGS means "Quick CharGe
Supported?"

With this assumption, I did some random Internet digging. The same bit
on other devices is called QKSP ("QuicK charge SuPported?"), SQCG
("Support Quick CharGe?"), or QCBX (see below).

   Method (GBMD, 0, NotSerialized)
   {
   	[...]
   	If ((One =3D=3D QCBX))
   	{
   		If ((One =3D=3D QCHO))
   		{
   			Local0 |=3D 0x04
   		}
   	}
   	[...]
   	If ((One =3D=3D QCBX))
   	{
   		Local0 |=3D 0x00020000
   	}
   	[...]
   }

https://badland.io/static/acpidump.txt

0x04 is BIT(2)/GBMD_RAPID_CHARGE_STATE_BIT. With all these pieces of
information, I presume BIT(17) of GBMD is what we are searching for.

> I'm wondering if the battery extension API allows to not advertise a=20
> property if it isn't supported or if it should at least return -EINVAL.

We can achieve this by defining multiple struct power_supply_ext. See
drivers/power/supply/cros_charge-control.c.

Could you test the patch below (based on "review-ilpo-next")?

@Ilpo:

This patch series has been merge into your "review-ilpo-next" branch.

Should I reorganize the series and send a [PATCH v2]? Or should I just
send the patch below (after adding a commit message, ofc)?

> Greetings,
>=20
> Jelle van der Waa

Thanks,
Rong

---
diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platfor=
m/x86/lenovo/ideapad-laptop.c
index 931a72a2a487..b9927493cb93 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -75,6 +75,7 @@ enum {
 enum {
 	GBMD_RAPID_CHARGE_STATE_BIT =3D 2,
 	GBMD_CONSERVATION_STATE_BIT =3D 5,
+	GBMD_RAPID_CHARGE_SUPPORTED_BIT =3D 17,
 };
=20
 enum {
@@ -180,6 +181,7 @@ struct ideapad_private {
 	struct ideapad_dytc_priv *dytc;
 	struct dentry *debug;
 	struct acpi_battery_hook battery_hook;
+	const struct power_supply_ext *battery_ext;
 	unsigned long cfg;
 	unsigned long r_touchpad_val;
 	struct {
@@ -2119,30 +2121,42 @@ static const enum power_supply_property ideapad_pow=
er_supply_props[] =3D {
 	POWER_SUPPLY_PROP_CHARGE_TYPES,
 };
=20
-static const struct power_supply_ext ideapad_battery_ext =3D {
-	.name			=3D "ideapad_laptop",
-	.properties		=3D ideapad_power_supply_props,
-	.num_properties		=3D ARRAY_SIZE(ideapad_power_supply_props),
-	.charge_types		=3D (BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
-				   BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
-				   BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE)),
-	.get_property		=3D ideapad_psy_ext_get_prop,
-	.set_property		=3D ideapad_psy_ext_set_prop,
-	.property_is_writeable	=3D ideapad_psy_prop_is_writeable,
-};
+#define DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(_name, _charge_types)			\
+	static const struct power_supply_ext _name =3D {					\
+		.name			=3D "ideapad_laptop",				\
+		.properties		=3D ideapad_power_supply_props,			\
+		.num_properties		=3D ARRAY_SIZE(ideapad_power_supply_props),	\
+		.charge_types		=3D _charge_types,				\
+		.get_property		=3D ideapad_psy_ext_get_prop,			\
+		.set_property		=3D ideapad_psy_ext_set_prop,			\
+		.property_is_writeable	=3D ideapad_psy_prop_is_writeable,		\
+	}
+
+DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v1,
+	(BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
+	 BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
+);
+
+DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v2,
+	(BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
+	 BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
+	 BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
+);
=20
 static int ideapad_battery_add(struct power_supply *battery, struct acpi_b=
attery_hook *hook)
 {
 	struct ideapad_private *priv =3D container_of(hook, struct ideapad_privat=
e, battery_hook);
=20
-	return power_supply_register_extension(battery, &ideapad_battery_ext,
+	return power_supply_register_extension(battery, priv->battery_ext,
 					       &priv->platform_device->dev, priv);
 }
=20
 static int ideapad_battery_remove(struct power_supply *battery,
 				  struct acpi_battery_hook *hook)
 {
-	power_supply_unregister_extension(battery, &ideapad_battery_ext);
+	struct ideapad_private *priv =3D container_of(hook, struct ideapad_privat=
e, battery_hook);
+
+	power_supply_unregister_extension(battery, priv->battery_ext);
=20
 	return 0;
 }
@@ -2167,14 +2181,22 @@ static int ideapad_check_features(struct ideapad_pr=
ivate *priv)
 		priv->features.fan_mode =3D true;
=20
 	if (acpi_has_method(handle, "GBMD") && acpi_has_method(handle, "SBMC")) {
-		priv->features.conservation_mode =3D true;
-		priv->battery_hook.add_battery =3D ideapad_battery_add;
-		priv->battery_hook.remove_battery =3D ideapad_battery_remove;
-		priv->battery_hook.name =3D "Ideapad Battery Extension";
-
-		err =3D devm_battery_hook_register(&priv->platform_device->dev, &priv->b=
attery_hook);
-		if (err)
-			return err;
+		/* Not acquiring gbmd_sbmc_mutex as race condition is impossible on init=
 */
+		if (!eval_gbmd(handle, &val)) {
+			priv->features.conservation_mode =3D true;
+			priv->battery_ext =3D test_bit(GBMD_RAPID_CHARGE_SUPPORTED_BIT, &val)
+					  ? &ideapad_battery_ext_v2
+					  : &ideapad_battery_ext_v1;
+
+			priv->battery_hook.add_battery =3D ideapad_battery_add;
+			priv->battery_hook.remove_battery =3D ideapad_battery_remove;
+			priv->battery_hook.name =3D "Ideapad Battery Extension";
+
+			err =3D devm_battery_hook_register(&priv->platform_device->dev,
+							 &priv->battery_hook);
+			if (err)
+				return err;
+		}
 	}
=20
 	if (acpi_has_method(handle, "DYTC"))

