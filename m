Return-Path: <linux-kernel+bounces-729123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D00AB0320E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951D53BBD12
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570AE27AC31;
	Sun, 13 Jul 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="wSbUNT2K"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7135955
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752423458; cv=none; b=OEzR0rY937+oUKcAgHHCg9Qn425rqoGsl/fkXGANBegw/iZYnVpjlcjVUxyILdMcJ8JhLqDLKP8djqn/2QSM+b21EqFYff+L2+GuUTcwzXBqqbl55y6FHTSHJq3i6AEDUOG3Jxf39U1GE46KHPkg1vxrsR6USPCr5KJiPIfOJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752423458; c=relaxed/simple;
	bh=d7UT31cxNNFRqrlz9iMYspz1t4lxiopYZnjnth2SQbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYjgAQVtrmGGYmb4inkxlafN4tXWc+JDK7auuh8wnUbu7hqf+MqFI2cbGNNOnUHYdun2YtjqlHEmWSCrskrk1H1cdDE129Muf1UxvwwsoP1QtG+K3A//y9RHAi0NUNoLDgefYiKeR9NCGfFCF1SZaiwacbR4kXzd+sefRUdijKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=wSbUNT2K; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752423452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VBNIyz9cuBjZoJtZIql5gATNUxrtX/L4E0kfIQR1FVU=;
	b=wSbUNT2KQf7F6owQb126AXQgG8NAE5vzWO37zgz0zVVHPYo3SjAxF9KpgjaeF9wQ0WUnzH
	6QAF2GSmc3/3j8WqQy4heZSF2t4e1sITjnWPs/4EDqFMxPADOy0cSoFz5mQpfvl/ttjwAI
	EML6PYD+M1MKlurhRg+9S6t+nQHh5HpsuVI3Co/gqD+JcuTlTRvPvIc7vLfpi9bKFF2i8I
	i3izdpylYASUYmq37wbDWOSJLS9VP5NFLP3ohGm5CZVCYTUXk5W988iKMS7vT6rK9TNF5u
	NtqkynsT42/z/YWegbfZo8fl6dS3clrLbFZkvkuJlOoDxYZG46v5JCwWHCEbWA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] arm64: dts: rockchip: Add rtc0 alias for NanoPi R5S + R5C
Date: Sun, 13 Jul 2025 18:16:36 +0200
Message-ID: <20250713161723.270963-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The RTC_HCTOSYS_DEVICE module defaults to rtc0 and should (highly)
preferable be assigned to a battery backed RTC module as it is used to
(re)initialize the system clock.

The R5S and R5C have a connector for a RTC battery which is used by
HYM8563 RTC. Both devices also have another RTC from the rk809 PMIC.
To make sure the HYM8563 is always assigned rtc0, add an alias for it.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index a28b4af10d13..f4d042bdd328 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -18,6 +18,7 @@ / {
 	aliases {
 		mmc0 = &sdmmc0;
 		mmc1 = &sdhci;
+		rtc0 = &hym8563;
 	};
 
 	chosen: chosen {
-- 
2.50.0


