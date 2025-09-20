Return-Path: <linux-kernel+bounces-825363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265DB8BA99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA071BC218D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC712BB1D;
	Sat, 20 Sep 2025 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="vg4D5vFn"
Received: from outbound.mr.icloud.com (p-west2-cluster6-host2-snip4-9.eps.apple.com [57.103.70.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5ED2629F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.70.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326789; cv=none; b=o+TgxQnRAt1bfuuur4/muVMAyX+qX3Grbd3lWSMIUFVjeq3trWlfIgtKPbeYp6bkDRIMx1UC5bNlT88AgL2g+ZzaH9Q5dK6il5ahf6cD9+3C7e7zoMNM7a+U4s4w/N4mrq7eSCP61eqg6Pt6EoX5elzHsM7iDOUGPf/G0IU9UE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326789; c=relaxed/simple;
	bh=uhiQfkvuBB8QcuFek6LGkWQTls1wfp4c6ReH0bF109E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b76qgM5PS39VC2Tma9T+u8iKiDnL6ZRw7j7CfdJhy2Nd1bTlWR2CE/j6J0vru5KyrWggmfV0lSv9KEwtWuEg7gc+OkqsgO7xyfVTYDuLlkeAfnL8GUSzev2VrzG0chlCXbHekshskAbhPStlxEI/O0b6LF1zt/+4IZx6267dwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com; spf=pass smtp.mailfrom=bryanhinton.com; dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b=vg4D5vFn; arc=none smtp.client-ip=57.103.70.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-10 (Postfix) with UTF8SMTPS id 34AC618000BA;
	Sat, 20 Sep 2025 00:06:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1; bh=U9ZeQCh35puBv44uaN5n9NTG0VCJ7xzTKeG6j0klt68=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=vg4D5vFngtIASvm5+9ZXGm4v2Dktb+J1NIynWhPCttAK8+o8infv3aifkk6hx2JWTPdpZ/eSsjCNAqEyTcZKv42y0+WCRXmhvRPOk77QxfpazxaTUqZyDAvEPNhsQ+4fUxuVnl56skPMnV5Dv/7Ok2GpFiTSTUbfJYe7ZKyFpBtQnGu+fTcgEseg44d/ux7F7HiB8HdSiRbVJYiOpsH1S4aaAOIABV3apllBd5d992TbuwxtsT3/OG14yHAPCcpwVCfUFq4dfqtIRRyywxPyNGJNdUiRI4irZGWu3qxfDOgAgyzXi1Yz11rC6u2ElLY+dK32s541+VSyvNVHKxxtdQ==
mail-alias-created-date: 1643268037438
Received: from localhost (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-10 (Postfix) with UTF8SMTPSA id 7ED25180017C;
	Sat, 20 Sep 2025 00:06:25 +0000 (UTC)
From: bryan@bryanhinton.com
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7981b: OpenWrt One: set console UART to 115200
Date: Fri, 19 Sep 2025 19:06:12 -0500
Message-ID: <20250920000619.2643457-3-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920000619.2643457-1-bryan@bryanhinton.com>
References: <20250920000619.2643457-1-bryan@bryanhinton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EOBQ2Tfsbbv0mlTv9OXdHSO1BDfAAx94
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNyBTYWx0ZWRfX/Rcqg8vC9N7t
 iDiMCiA6IZv1Fb3ANLChfzwDyNquQlBNjmH1F+bp28H2/EVnqpVN3DxGsm9OtWJlX8iNRHFQi3t
 ksBN3R+FTwupf1x674tE5kuGeTVn8XRZzK4wr9b35ZGQXgmDQTEw/FzZO+zOuoaULl+95ajrUXR
 pZxfb5SDyf5/+2Vr1rEQseAX9nZQNWxGxDmoYUyodvfIIwUZ0XqOtz3hnQrUE16KEaRroSR2Pac
 tzF/Dz84YcjJycv3yw+SH/Th0HHbH+K9VpLfIMDkdjZmQaMv1yiGgp1SjhnwvPMTsNaGVH1+U=
X-Proofpoint-ORIG-GUID: EOBQ2Tfsbbv0mlTv9OXdHSO1BDfAAx94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1030 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509190227
X-JNJ: AAAAAAABjQoI1GTOYZxNLTAFLe/A3b20ZKDUCJC9eTtNWwrt0CGMCJqDa8I95QkqXHtnygYshP771JWqF8/M0mTvUAXw3m2XFH4SlS7GtwzBMednVOsx8B1H7/NHC1b5EfWrRBOUgv0fb6x3ym73TQLN+ZhRYW5Sw6QeXkWvFkImHFcgwMLfsQ3pH7OhfdQDsi+n+ZT19Ogl9rijFf0hmxDKQDiucrO6m7TqyXddpq+YbZtTotXu8AVae3Gr8aAJsGaJK6BrdeFpdA5ORtm8ZybNjvvS2oOZy8WHhN/8pRzFcf+UxdUmk90bVwrLgorlp47QRJUJ0BHccB6SBv9q86P5NDeTKwIJs8r0b321iGqzNC8Cuf0A3l/0LnUH0iP9vZW/FGocYMAfnTEK2nhGw2apsX/GMOXhJS6ZB/yk1Nbuf0IOro2CfRD4x5XjAo7/qBTQ/YjzyIYn9G9Spx4R8PK9RGRrlgy2PGf91uw595OF3mv3vJTPI9Q/bbbYaC1aP8NK4q3lljZgyUhtkPMJjl68dyPv2v3OvzghtqBd84JZ4xKs3F5peg5PeVp17QHFRSj4xoffCFPgnwC62I25R9mJutf13Gu+C1rGRBzxN/KtqT1tnb9c+FKtNuEdlWI3y4JDpjB3hR1fI6Vb3srUrBo9VbEYvxXVVh1Go9jfq2cgpy6d8mBt9m/KESj3NEDUnbnCLEx/Wi0OOzIml7g0hVTVV8s=

Use the new uart0 label for the console and make the speed explicit by
adding current-speed = <115200>. This keeps the DTS OS-agnostic: no
bootargs or distribution-specific properties are added.

Verification: Boot-tested with mainline Image+DTB via U-Boot on OpenWrt
One (MT7981B). Serial console active at 115200 baud, and DTB decompile
confirms serial0 alias and stdout-path set correctly.

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 .../arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 4f6cbb491287..1d2c3a21019c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -8,8 +8,21 @@ / {
 	compatible = "openwrt,one", "mediatek,mt7981b";
 	model = "OpenWrt One";
 
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 		device_type = "memory";
 	};
 };
+
+&uart0 {
+	status = "okay";
+	current-speed = <115200>; /* 0x1c200 */
+};
-- 
2.51.0


