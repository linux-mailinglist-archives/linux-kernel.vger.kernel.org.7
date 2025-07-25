Return-Path: <linux-kernel+bounces-745317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4620CB11856
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16C61CE15BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF2E2882A9;
	Fri, 25 Jul 2025 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MAK4wzpz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fIBE8o4B"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA90286D6F;
	Fri, 25 Jul 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424093; cv=none; b=VmR2tvMWVBibSsvgrC23LzBseb3pT0SaAh21mOTjjirxJMBg142PBR/Nbs3B3g4BBTlLSvE8bOmt4qdt8kXXFGyDeiwWNLZdE2DwLrO79iMFu7ev7PW43/2JlZcLYcHaHJKc0Q0I0kE4TXTqC3J+ic1KSvAwFDBtz8M6TLOi5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424093; c=relaxed/simple;
	bh=pi8B3IGVYFpDOtzARcOJvQKR/vak+tLRSnfX4Hhr/nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka1/Sd8wKa2JY1+bL/OTlVs14Jcp+eEj4m6/4D8RHErAfJBPCKdyg0x0qmCrkM5xhoJpeAcAwNu1xI+1MnFxa+y41N9+l3OQBXJ6j/paQp7kU8g/dxFOCRDCruvFQunohdS+P3w+8txYuhIlDsqqg+YAqAlSkDTMduHEJMSp98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MAK4wzpz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fIBE8o4B reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424092; x=1784960092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+sr+Nipva+MMpw/BZL34N9U3TlRdkIHSSqX24CZFONM=;
  b=MAK4wzpzpX9J66p+TunJH36vBVeJooaqnasv+KTKLKcXE03xGtZ8grVo
   nqyS6EfCX/yemcikNke2lDbCiO7WZ899ev/qnbzKGYesDVLooie54ao8f
   UgQHlk8pOiPIgZF1pVn0Y1+phz1hOelUEqNqjjEvGZIt3QIN1YoOyQYi6
   0tQMzLYiHm52aRApqsT8wb4FiQ8pMWGXJkU28DfL5pVk8JtiHxLmhBTxU
   I81s58reJLT6e53i+XPTTvvi/L579suKmMczKb2Gm89yW57rB3iQFzzFl
   FYQeFPYlNHtuEvMHgnBgbvMg+VCGsYiE2JeAp0W23Bef8yJgCM7/5kixB
   g==;
X-CSE-ConnectionGUID: 3i1G2ulQSHmiy9uTaxpzIA==
X-CSE-MsgGUID: x7sgTuTnQACDINcf9zXY9A==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413068"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:30 +0200
X-CheckPoint: {688320C6-10-943DFC15-D71A48EE}
X-MAIL-CPID: 2E6577C811EC6F57F3F62CCAE5A4A99C_5
X-Control-Analysis: str=0001.0A002123.68832071.001E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1012D173654;
	Fri, 25 Jul 2025 08:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+sr+Nipva+MMpw/BZL34N9U3TlRdkIHSSqX24CZFONM=;
	b=fIBE8o4BAp5+91+w/p5FRSNScpcISHAYuY6fbU4f4jMpZP+ayM3BRqLExDnFO1eVdN+hOe
	pS/IGogVpelIFGK8+SnCPQ/dl0Ypd0PwmqYDDzZhDurcCi0QO/DjgrONqT6TIhKxDFuM/R
	krc7zf5ZW9T4P3c7YHUMeuwmM7aBNWlVLsGGovucrMErFmL5Nn+da7lwTPWLL16jPSt7vz
	ha1NkBJ//B2VbFBsd8HEQdXK70xJR6c5c2lQZHMPaAJjVrptl1PzBZq2vQFS8cOB4vkKyS
	xI6pcaLivh7ltTvV0kAetqodcX957ihtCzQFRlvaQBOyzedXWHSUhXnv2DyUSg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] ARM: dts: ls1021a: remove property 'snps,host-vbus-glitches'
Date: Fri, 25 Jul 2025 08:13:34 +0200
Message-ID: <20250725061339.266125-10-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
References: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Commit 7e0685a0c4c27 ("arm64: dts: ls1012a: fix DWC3 USB VBUS glitch issue")
erroneously added this to ls1021a as well. Despite that apparently the
workaround has already been applied unconditional at
commit a6ba1e453174 ("usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally")

Remove it to fix CHECK_DTBS warning:
  usb@3100000 (snps,dwc3): Unevaluated properties are not allowed ('snps,host-vbus-glitches' was unexpected)

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 3879cfc3efc99..d8a43c5aac80b 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -799,7 +799,6 @@ usb3: usb@3100000 {
 			snps,dis_rxdet_inp3_quirk;
 			usb3-lpm-capable;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			snps,host-vbus-glitches;
 		};
 
 		pcie@3400000 {
-- 
2.43.0


