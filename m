Return-Path: <linux-kernel+bounces-842040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E7BB8D51
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237FC3AFF8E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA22274668;
	Sat,  4 Oct 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="pYd0LZgf"
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1E34BA34;
	Sat,  4 Oct 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759581942; cv=none; b=o5/VIk6+8uF0QUd7XmPGIVTUs/P9Cc/jiSuw+SP/rihJX+2QpKH0AW2pfv4W48hhmrdSXSUogo+/LtMQ9PJIdOWbaZ7IZkTZaySHNMYsN3NvBfLTG8g3oASxHtV8FJ9qVWwO/eW21RWpX4RNAVDfgL93/bffVQBJRjkJZVDyqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759581942; c=relaxed/simple;
	bh=QR/lh3QxpQlCba4iDyrEsV2/Q7r7YUgtlx9cK63lcug=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kskyRoQlDprhzliWTSswb/RxtzCvc/BBLObaMr6BHM1GIXwUR6cOYYHbsDPEjUfATRpsFyPNfSb4RMeSalbxrr3cGqJn5ZpRFmQy28NoeeMgPN9/ab/PnI3m5ayFTvOVNsmnTq1YA2q9zqvgosf6DEQAw46MtN0NFvIVVa+MuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=pYd0LZgf; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759581924; x=1759841124;
	bh=TECu1AwZYSMVFzAux5O/EFPsJ/2nsyQcS30gfFj/DSM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pYd0LZgf2cT/os06IGPl1IHQpGZwiiPCJ6Kmqu6dD/dNpcq8oAJmqekXU8ZRAqQgd
	 X7Q70gO48aW0otTSBPqJsBvw2V96qrAgQOa4nEaOA68fKQ2r2/10KzCaokrdI2Zgdz
	 PSz1z2Gu/EyLS8dQ8E1PVBHAzBAZVFaZ0/OYAaH5kH2FY2/Neyyx2eWiv/of9x+QJ+
	 2OJUgOwAdCaAtNSrgnyn6437f6yzzeOY631QLJDvVhxrlUg1PQdq+W1F/M7nAJOr2B
	 mN8sKEx8bgJmt5W+pWd9KFPrMXKVh0L3k0dmbEj3mz22fZo2jPHTiz3nqF0BUEZ8l0
	 cDJBfJp8VFE2g==
Date: Sat, 04 Oct 2025 12:45:16 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Raymond Hackley <raymondhackley@protonmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-rossa: Move touchscreen to common device tree
Message-ID: <20251004123907.84270-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
X-Pm-Message-ID: 68a59a08884522522b02b3c56040bf9396bbf5e9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Every Core Prime uses an Imagis IST3038 touchscreen that is connected to
&blsp_i2c5. Move it to the common device tree.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../qcom/msm8916-samsung-rossa-common.dtsi    | 22 ++++++++++++++++++-
 .../boot/dts/qcom/msm8916-samsung-rossa.dts   | 20 -----------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
index e7f265e3c2ab..e33453c3e51e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -5,7 +5,7 @@
 /* SM5504 MUIC instead of SM5502 */
 /delete-node/ &muic;
=20
-/* Touchscreen varies depending on model variant */
+/* IST3038 instead of Zinitix BT541 */
 /delete-node/ &touchscreen;
=20
 &blsp_i2c1 {
@@ -24,6 +24,26 @@ usb_con: connector {
 =09};
 };
=20
+&blsp_i2c5 {
+=09touchscreen: touchscreen@50 {
+=09=09compatible =3D "imagis,ist3038";
+=09=09reg =3D <0x50>;
+
+=09=09interrupts-extended =3D <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09touchscreen-size-x =3D <480>;
+=09=09touchscreen-size-y =3D <800>;
+
+=09=09vdd-supply =3D <&reg_vdd_tsp_a>;
+=09=09vddio-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-0 =3D <&tsp_int_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
+=09};
+};
+
 /* On rossa backlight is controlled with MIPI DCS commands */
 &clk_pwm {
 =09status =3D "disabled";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-samsung-rossa.dts
index 3413b0970c4a..1981bb71f6a9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts
@@ -16,26 +16,6 @@ &battery {
 =09constant-charge-voltage-max-microvolt =3D <4400000>;
 };
=20
-&blsp_i2c5 {
-=09touchscreen@50 {
-=09=09compatible =3D "imagis,ist3038";
-=09=09reg =3D <0x50>;
-
-=09=09interrupts-extended =3D <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
-
-=09=09touchscreen-size-x =3D <480>;
-=09=09touchscreen-size-y =3D <800>;
-
-=09=09vdd-supply =3D <&reg_vdd_tsp_a>;
-=09=09vddio-supply =3D <&pm8916_l6>;
-
-=09=09pinctrl-0 =3D <&tsp_int_default>;
-=09=09pinctrl-names =3D "default";
-
-=09=09linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
-=09};
-};
-
 &mpss_mem {
 =09/* Firmware for rossa needs more space */
 =09reg =3D <0x0 0x86800000 0x0 0x5800000>;
--=20
2.47.3



