Return-Path: <linux-kernel+bounces-665339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7086AC67E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F7D7A2911
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442127A92F;
	Wed, 28 May 2025 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gbk96h/i"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF527A917
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429922; cv=none; b=t2dK5IpWlm0jC/l+JpMEvVDUxAEMLChY95yHrZb8ReItr+KsVayyMccu0WuQttQ92zYw21TOVI3Ro5vAlve7JBUVYgoiZzeUC08exC0RQfsmHc+oavbtHZkA0gwbbV/OYqku+NIQ8SnRcZGrj16McDL2thFuhsRa35JbTHONKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429922; c=relaxed/simple;
	bh=AlBhvJpL+ZxjXrIug0I6z5UpQ2bBMocBU3ycBy27pRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftdWVCZ/MCDWulmFCN0HX2RKbUC5RSV0HNiG2+n8fYriihtv3yQgMbhBh3QTJxbQTFdmQAlBt5FjD/CdFo+facSTyGTTaMZvUfdvY0ocq16X9aJm0FW1ptw5QdhNpzLA09nouuj4tEZ3DUUGZz27CRBUz5WPyHgFKn5pSPkQHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gbk96h/i; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
DKIM-Signature: a=rsa-sha256; b=gbk96h/iuTYW8you7S2tyt1pVBCjE5T9hLlpwVj1zezbKIxRDDjuQ2VLMOqdb/5KKAxP3+pGFuu+dchjj2o6/B4inKtrwPzyk/A7FjVjgYPlp3z+1S7T0Gd/cfYQsqu6DoNHArMZdDf+2DyUSPLk3A4X9f4faIJOB76vZjSsLS5qsUTtP6NY3IzvHfZmRWtsBhFMjIxjxAkQytI338x8Oc0Yw+mNhNIXmMBr+ExSLO54uAoWTN5uIrtE4xTeHKNmFxghZGnFXjZ912pklSPMOJ647VErN5sipGU/cius1MIrnb26+fb2swP08DklEwh4BkvlVjqHtHv/qi6qWwY5+Q==; s=purelymail3; d=purelymail.com; v=1; bh=AlBhvJpL+ZxjXrIug0I6z5UpQ2bBMocBU3ycBy27pRM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68229:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 715274949;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 28 May 2025 10:58:24 +0000 (UTC)
From: Umer Uddin <umer.uddin@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] arm64: dts: exynos990: Add CMU_HSI1 node
Date: Wed, 28 May 2025 11:58:21 +0100
Message-ID: <20250528105821.158140-2-umer.uddin@mentallysanemainliners.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250528105821.158140-1-umer.uddin@mentallysanemainliners.org>
References: <20250528105821.158140-1-umer.uddin@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

CMU_HSI1 is a new clock controller that provides clocks for the
DesignWare MMC Controller, PCIE subsystem and UFS subsystem.

Signed-off-by: Umer Uddin <umer.uddin@mentallysanemainliners.org>
---
 arch/arm64/boot/dts/exynos/exynos990.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos990.dtsi b/arch/arm64/boot/dt=
s/exynos/exynos990.dtsi
index dd7f99f51..4ab6e35f0 100644
--- a/arch/arm64/boot/dts/exynos/exynos990.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos990.dtsi
@@ -254,6 +254,25 @@ cmu_hsi0: clock-controller@10a00000 {
 =09=09=09=09      "dpgtc";
 =09=09};
=20
+=09=09cmu_hsi1: clock-controller@13000000 {
+=09=09=09compatible =3D "samsung,exynos990-cmu-hsi1";
+=09=09=09reg =3D <0x13000000 0x8000>;
+=09=09=09#clock-cells =3D <1>;
+
+=09=09=09clocks =3D <&oscclk>,
+=09=09=09=09 <&cmu_top CLK_DOUT_CMU_HSI1_BUS>,
+=09=09=09=09 <&cmu_top CLK_DOUT_CMU_HSI1_MMC_CARD>,
+=09=09=09=09 <&cmu_top CLK_DOUT_CMU_HSI1_PCIE>,
+=09=09=09=09 <&cmu_top CLK_DOUT_CMU_HSI1_UFS_CARD>,
+=09=09=09=09 <&cmu_top CLK_DOUT_CMU_HSI1_UFS_EMBD>;
+=09=09=09clock-names =3D "oscclk",
+=09=09=09=09      "bus",
+=09=09=09=09      "mmc_card",
+=09=09=09=09      "pcie",
+=09=09=09=09      "ufs_card",
+=09=09=09=09      "ufs_embd";
+=09=09};
+
 =09=09pinctrl_hsi1: pinctrl@13040000 {
 =09=09=09compatible =3D "samsung,exynos990-pinctrl";
 =09=09=09reg =3D <0x13040000 0x1000>;
--=20
2.47.2


