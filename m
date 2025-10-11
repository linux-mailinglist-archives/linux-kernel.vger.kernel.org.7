Return-Path: <linux-kernel+bounces-849270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509BBCFB3B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D23264E11C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3155283FE7;
	Sat, 11 Oct 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="r6xpKVio"
Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD31A08BC
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760209098; cv=none; b=cmm3HVN6PUIXjSRWVqv3fdP69SIa+/Ap2Z2NSUzcSFGgmUCEK6EOaFKuNTIDzeKmX9Mt0ynzakbJ+R9kze9HfV3WUQswHJYsjy698eKgBJ4ZWrvnWkgn2UKaQ6dls5RaVg3D3sR/0sP7BgJnmEW1ZYAookZC/D4hZx+3b9x2xqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760209098; c=relaxed/simple;
	bh=1v8nHY4EpqYJa5+tPbItKCvOHDogDdxlqBPb40TYXvI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y7uh8xQTfFeHthlw3MvjEj6gtjgVXsxMDcbls0E1JPejI0I9w4Gw8KATjoEoJ4ZwT4ILwyhAScBYSH4vxUyFOZsfUGOMGW4PSmW1QnJltQAwL3JQDnnNQiCRDsm89ktv10D869LDRuSfzle/ZB3x3wSHZrIP9mfz1ngAFr/6cPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=r6xpKVio; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760209087; x=1760468287;
	bh=cnHuHQrVVXZKpXeZNEipH+LyE/5HXlwHBeSny7rKcS8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=r6xpKVioJXUbvIl1i6WAq3wRqejMRWv1E5J3nSlAqgNUHjoIhn5dfQyAnOWIb/FjG
	 8UlvDnG3+C5GGJyDHzcau4UymBQe1L2+Vw56pOfngCEs5qxCcjr3Y1SPAZH6V6V29P
	 awxabGRdGXfh2RoJV6l9foia+PNb4W+iz3hoaUi57135lsgFPDu7/dMhniLfYOjMd6
	 lFRwtby3Kf0uH950Nbsgx4rcISoLKmPhY7KQUvHAl0hbDQW/lmeleyTT0WbPO7Sm8C
	 AU3GylGEkOIaLBSUevRMQooGO9SWrM95fQJQ+cFMt/wHlB4Fc9sIzUHDYqdZvTEH9S
	 qSVi7z6UpVk9Q==
Date: Sat, 11 Oct 2025 18:58:00 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Raymond Hackley <raymondhackley@protonmail.com>
Subject: [PATCH] ARM: dts: qcom: qcom-msm8226-samsung-ms013g: add simple-framebuffer
Message-ID: <20251011185750.743615-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
X-Pm-Message-ID: c3fd6412242376b6324f202df282fc65579a2ae6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add simple-framebuffer, necessary power-domains and clocks for ms013g.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../dts/qcom/qcom-msm8226-samsung-ms013g.dts  | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-ms013g.dts b/arch/=
arm/boot/dts/qcom/qcom-msm8226-samsung-ms013g.dts
index 08b50dc63923..80fe2916501a 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-ms013g.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-ms013g.dts
@@ -13,13 +13,37 @@ / {
 =09chassis-type =3D "handset";
=20
 =09aliases {
+=09=09display0 =3D &framebuffer0;
 =09=09mmc0 =3D &sdhc_1; /* SDC1 eMMC slot */
 =09=09mmc1 =3D &sdhc_2; /* SDC2 SD card slot */
 =09=09serial0 =3D &blsp1_uart3;
 =09};
=20
 =09chosen {
-=09=09stdout-path =3D "serial0:115200n8";
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <1>;
+=09=09ranges;
+
+=09=09stdout-path =3D "display0";
+
+=09=09framebuffer0: framebuffer@3200000 {
+=09=09=09compatible =3D "simple-framebuffer";
+=09=09=09reg =3D <0x03200000 0x800000>;
+=09=09=09memory-region =3D <&cont_splash_region>;
+
+=09=09=09width =3D <720>;
+=09=09=09height =3D <1280>;
+=09=09=09stride =3D <(720 * 3)>;
+=09=09=09format =3D "r8g8b8";
+
+=09=09=09clocks =3D <&mmcc MDSS_AHB_CLK>,
+=09=09=09=09 <&mmcc MDSS_AXI_CLK>,
+=09=09=09=09 <&mmcc MDSS_BYTE0_CLK>,
+=09=09=09=09 <&mmcc MDSS_MDP_CLK>,
+=09=09=09=09 <&mmcc MDSS_PCLK0_CLK>,
+=09=09=09=09 <&mmcc MDSS_VSYNC_CLK>;
+=09=09=09power-domains =3D <&mmcc MDSS_GDSC>;
+=09=09};
 =09};
=20
 =09gpio-hall-sensor {
@@ -93,6 +117,11 @@ reg_vdd_tsp_a: regulator-vdd-tsp-a {
 =09};
=20
 =09reserved-memory {
+=09=09cont_splash_region: cont-splash@3200000 {
+=09=09=09reg =3D <0x03200000 0x800000>;
+=09=09=09no-map;
+=09=09};
+
 =09=09smem_region: smem@fa00000 {
 =09=09=09reg =3D <0x0fa00000 0x100000>;
 =09=09=09no-map;
--=20
2.47.3



