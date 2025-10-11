Return-Path: <linux-kernel+bounces-848980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D5BCEF39
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA9324F0C74
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E85D2405ED;
	Sat, 11 Oct 2025 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="ULzbKR7Q"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24262367DF;
	Sat, 11 Oct 2025 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153638; cv=none; b=qDYt+PA/JA5ll7cdn7zHatp7xbvGK7A1CbiAEebRvhJLzuLQ7+QUtEXYHQi7Zz1Wee77ZDhr3eIFxQXTKXcPy5gE2FCOnYMZVRaSl+OqmJWQ+bXekVZPZkgfGfrLT0uTYbrKzPzMaTAjacBWFJv+NQzfFozsSQ3Vzr8sNZ/Hg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153638; c=relaxed/simple;
	bh=3OiqcRrs7DLfC1hTPje6cpCre8EW3o9TnIIexoI2iuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fpwR3hOf71PHK/c8taeGfi3CO/Za2JMe06ldTWStsyf8dQzleEpMKboca+I/W21z1tCSRtjH2+0wvdSH6yKd4de9Emg71KzIhR0gFDpU2WQDJf4quYLizeaQSdAGsKjg30GoQtNbU7ddZhMiElCfvbIZiqjKA2cQPigHVIzw6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=ULzbKR7Q; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760153587;
	bh=cDiOxEFqYuonRjIga1t9o2u02p12TN3hXALWFcjKD9c=;
	h=From:To:Subject:Date:Message-Id;
	b=ULzbKR7QcbMf0nqC2RApmSGAa83W4Fcpxw5GOgeoJGTcfRtYTvBjdZS1uDF9wL/yk
	 zHm1l9mTjFd1maOSE8+iUxnqzAkuq7Gqr8ml4i8UJDA5WGijwKEzJZdjDtjVhaXId+
	 8M+0wvuqeSj82wTJ7LjVRr5kM9HrZ4oUBpDcggCw=
X-QQ-mid: zesmtpgz4t1760153586t91072ef4
X-QQ-Originating-IP: aEg4UWYxB0z7r83n8X2tWwn2jWviUUfrqwKQvlQMsCk=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 11:33:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15608153798208442778
From: Chaoyi Chen <kernel@airkyi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 7/8] arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
Date: Sat, 11 Oct 2025 11:32:32 +0800
Message-Id: <20251011033233.97-8-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011033233.97-1-kernel@airkyi.com>
References: <20251011033233.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OQhZ3T0tjf0azpAA8cGSOxM6rfkTHq2GDbtxwIkrrjaK0gql4EL/dTl0
	pXF3V/BhqFbdQr55S0pIm+2oRV+/kvAqkCQngHFr8KMn82yuSvtuTZ2n6ZKOYLgC2x/L+HP
	pS/IZ8mo50OGMD5lK4dxvtCAXgOGx1Ax/apMTVjfgSqJkrknIpg0OJ+mn+oI/oT6zcdMua1
	TCz9TgoyZp7fL562Axniz9Dm+8+pKg41vU+7L5z5E0X7s+UYKGEbqMxF3UK/ipo7ZpgLsSg
	DpAb+qnb4T/bZS10p9XHDxxAlYIYRij7Lpm8EoZrG2NgBerkinCk2Bkchry2lfDPC9ciWsL
	4EISFFwpTbW33vabFeVycdqWqHNnuak8MMdItQ+8NTmgOtfv3QBHkDxt6cnYBNmRKEcT6jP
	WrGrTfnvj23TLkfLHDsDgktQIgp3HrObBGqorh/5NpKoLqHpRlNDhThinE36L7b8mZmGuF9
	vVWJA7fHItseSzMV3VVX/gj0gAhyFgLbvX2fxOb4qpGIUFa/kAjqtwsa0rwKn3vyP3hKdq2
	kSlSg6oQprIXswDL/3Ouh8TZbgj7D5NvXQ5nlbOKolobFnih8UC9dd+l+DvEo3atlBoLK8p
	4KYxPAy65co5Kyw6D6dcRmmqZfqcpiYUPSgzLXDTQJM9d0BE24Wf9FVbG+fADHNThT/YC4j
	ILpKX684h0L9cW2S5Rtrr/OheH/wRliJ4Q0elNxlTPbcKHzZ8wIzNKpAJqOqX+5Cn5kRuF5
	PbW8ieXQNqYoY7MlucIzAiovozIa+JVOLEZaGw1AWcLUhmiIOy+Ytkr5kYQyMvl70bZFcCJ
	t18BCDWdlhiaq/AyXT/r7jXFmMHcaux61FQkzEP1InUHm69OSSyNpQt+j7OTFhe/vr8FUDV
	sIttHsIQ8aXw7P8zsuyh0fEyJkNIkRjJU5PdVDnGRT8f/EYO/aVp/lcqC8/LYQxbESK7vAk
	vW/cfhXYf7WnCd/4ugm9fdlw5BvOIrPUajOtaPUx4l63IwnDjhEMxQ6kRCzGRSlap6Gr0q3
	5y2O5FNK5CoxdJmTpPB3413NiFK2LD3kOp0EVpoORSW2rQn2jP
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Let's make the ports nodes of cdn_dp in the same style as the other
display interface, and match the style of ports's yaml.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

(no changes since v5)

Changes in v4:
- Remove unnecessary #address/#size-cells

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
index 4dcceb9136b7..93b42820998f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
@@ -618,7 +618,11 @@ cdn_dp: dp@fec00000 {
 		status = "disabled";
 
 		ports {
-			dp_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -632,6 +636,10 @@ dp_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_dp>;
 				};
 			};
+
+			dp_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.49.0


