Return-Path: <linux-kernel+bounces-749146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B583B14AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DD1AA0B81
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF182874F9;
	Tue, 29 Jul 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="rgfsEa4+"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043F287253;
	Tue, 29 Jul 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779701; cv=none; b=gM3VijnIvk1SACpdV3yF1bPelQDxU9+JObiDWTWH6YimGPCE07WLc6Ftu2qhe5Dxee3E6ZS1Kl1wIM83jOnEgpYYQCOKZVjlunwLf3YYE5lCAKnOp/wNEtN3P8vnCyL2NoEil/J/Kca6Ac9Y/bCWe8vZmx59P2dHGaqIFy5oQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779701; c=relaxed/simple;
	bh=IFjBh/IsLkSBy3BP+55MVOlJYanvu03dU7s+TFtZgr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uONVdvlTPc+ioVyy+Eqj0Giz+4ZTH+ZsUY1hQCYNkZKYhDb58NMstYZAQw0cN4owL0mCjMwrrFreR9zFdbk+Ed7AkumuUM+UVEgx41/14NiyoOMB5vu9jtEIhItQu15y07LxphHVtsBLF3NX9I6xxLz+Dhn+dp2G7LGykMEVJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=rgfsEa4+; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753779661;
	bh=cVsfyWOIHeXBsAv/pI+LuirkOLN75phRnl2QMAl6n60=;
	h=From:To:Subject:Date:Message-Id;
	b=rgfsEa4+7aRZXcoMmqiddOJYRc/xopB0FbdZYNZNSsjt9BWUGghhGIIgaF7rhmMA4
	 BsOapiDXxV7zLvad32+rjnNdruhuntbzcwKY3Hxp93zVihxF8wAGlhwCbsV8PGdnBB
	 O1nCR7WM17OSgKoeCqspd98Ksx/KWt07qXTq6CMw=
X-QQ-mid: zesmtpgz1t1753779654t826cd32d
X-QQ-Originating-IP: jRSwjG6rFafhFW5ehktwFr25xj18ygtqPc25P+oepJE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 29 Jul 2025 17:00:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7649534104477773387
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/5] arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
Date: Tue, 29 Jul 2025 17:00:31 +0800
Message-Id: <20250729090032.97-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250729090032.97-1-kernel@airkyi.com>
References: <20250729090032.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OMdukQY98W2HQxJc1PF1vIo+UWLudmLtX0Jxbv1z4uVMlmDCHdb1Ftfx
	/wIZEDfCoeMCD+Cyq9Cb+ATv2PLGy7Dmf16qlHHqKRc6V3Ifm2jpCYwaCKNFPj8iyo9Shw1
	oDjbZLDhpt6uPlJ6/KIHK+Dr4cGxzVc3RMQv3/Xq7gbfDU66mC9rLjOtAJhIm/hruHJKmSU
	EidHzcdEzmUfGoZioKWam5FuTucFfB5xAH5awSWZ7nlfo+S4kaNrn29UF8q5EO52oMVsp3s
	dOmrYAqHDcYaPYYqVz07jH/sYhbh58zkb5htU4YeEbw1ag5Smw/0QD6pb2eI4bbhUb3cuMa
	xXpgJPu3fKLfAVTviONDilUO6gU7P00giZb5LkflUEjDSFeVSoeMGxr/zjKyFqJSWvp0Bbq
	sSHvwG+Wd11HCIihiRfk09DGvxs0C6mRlJ2iMaIiPQWSBrRIsfIAjshUNzBZnOFtJ67rlct
	wTC12meB+g0WB25gOWyL31z+cSZF+DO8r7CKBu1lZiiLTFdktkYNn/ou8oUUeN9AI5Z9uRD
	1B1jIIieOW5vjkF553jJ0izL5V5WmsS4vymq9LvkBRBH2T6Dk+gO+y1M/0OsPrIW7NjNYQF
	lsfJ7ZpmgZlyRl1YaJColBHB3LYI/uXxzG4bEJQObPeNYKI3R4G/EbkMF3JdQXlxNqA4qSS
	8PiBz73lm970+ASy69NdbsjxZ2RH9WE1et1MHqWkucnxU02vbkQ0ySthMWeoqmxM6wCSy1p
	azDwMJ7OlLBOmFCzmkXVZKrHdhX5oiLi4bQvbFvbS6yXkfG3Ivy9qhbsaTpgpko/8zCZh6f
	ioZavRLpzxDQGllPZX+wAVtW3waC8KbThLQyAR2mW2qxYTLyLxu+eGiXMvDYnhoYSEigQE2
	UjkS559AIFfW4Y3mGiE5cwVMRDBPpESIA0+EKAxfBBPLFtGJlBqWxl+oYDkPkwsGnVhR8Tj
	j+Fb19H55Uk+MmffZOvodAcnBWNIB+iqrrXNe8ywj1eAOmeyvLaPiy88lK6wLsRe89Y/8SD
	SjzxZBAakrDH/oCwhc
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
index 9d5f5b083e3c..edeb177bc433 100644
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
 
@@ -632,6 +636,12 @@ dp_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_dp>;
 				};
 			};
+
+			dp_out: port@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 	};
 
-- 
2.49.0


