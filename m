Return-Path: <linux-kernel+bounces-736306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB39B09B53
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76606A615C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B32040AB;
	Fri, 18 Jul 2025 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="D2KjmatZ"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2A1F1537;
	Fri, 18 Jul 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820012; cv=none; b=MspFW8hu3OBrgWiH3AueuSp0MjZJ6LpVuAbYuRv2Ig0CeJT7IEZbI9RyC1N6axpnEoFJUFuNtcnqt5hLN1QynUQ9p7BU0HSyqqM9BY3j8DF8uMpMcK5dnCgKBrLpmPFfoQx79mhm8eMeyv9mT9cBBszU1VvZOhBqKaYvU97cr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820012; c=relaxed/simple;
	bh=cMI243em/Iua13FhAOHwdU6NhJAGp+wNFbIqwJW/Prc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JYV8oqOVGz3sjzBubgS8nUfInXmFOndVkxpjK/tSqq5wKkX48m9mnDTQX9mz657KX0LJiHGcN6fyRDKzfl5k0vLxrEKy1ad3qGCccwJ38EVQ8+n8wNyjgV2D9xJimd91SEucD4m9uD9AXk70QCc63RpmjdEGDEdb+vce7YHXh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=D2KjmatZ; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752819994;
	bh=SfD49mysx56ByrkZgSzhxvm/5yDPMJ1rme9Y1NDR4zs=;
	h=From:To:Subject:Date:Message-Id;
	b=D2KjmatZ2jq70gbNVldHQTvwcVnCd3nSODRvsISXyV5nhccL8xt4yZ2Ovh82et8TY
	 nKQCIdY/3Z2NmH8iEA0fnI5s6vmf+hoIrqpPJAppg14552Qt5AHKL0oNZuoRQJAoSB
	 /KnsHLVjf4uLSCDuzo10MGDN7BwoWhkWQz8ZrNM4=
X-QQ-mid: zesmtpgz7t1752819989t339e2657
X-QQ-Originating-IP: eoutYZ05PQmrVxRHP07fLErhbre+iSdNkklahpAft/g=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 14:26:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5159759228802639268
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/5] dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
Date: Fri, 18 Jul 2025 14:26:15 +0800
Message-Id: <20250718062619.99-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718062619.99-1-kernel@airkyi.com>
References: <20250718062619.99-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M7SN0LSU40tUh1tbWjviPABbAKjH73lD45JHVl5BG1a5/djikRK9bBZH
	cKK99v+VmD018no2MPSZxvrN6rBmQ14L093c3u+VH+psPXQxc/mL5SZECbBBbclaLynDgwk
	OU1Hgjb1qP4Nb91rO9Dk0Xy/cVm9ixNFcPx6uyicskYxBIELZPR1EXzZed4AdH5db5RwGL/
	K+vf9vjvfubqdCLOM5+vuds8EWtwjEFGpQR8UqkLectFa9a61X80ZEuTCvR5CA8FXVCvWrJ
	he/aDah8GWBwZrSaHjqk5HeuAJIONozUuSdPBn52q9peoQxBTkqv7FPoqFZUUdpuGnRla7l
	+y+X3jLwgl6hOIlXSt/DByvDl4OOMV9HuFPithabFs4YvlV5Kp4ocQwpbPzNnzu/ZnbrADT
	lqdwHOgXKlP8djMKDCY53m6OpmiRQxfbfG6McAoStT4lMG1U54A4nhPWJ2EDVCkYYGWnYAi
	BCQ5Tb2JgU91fuEMSyAJAZgni9JYc/1bQHUPnHfkufrURB8aAgPrtVyWfbt03mgUh70v3cP
	1RkYSWQFqvtIqM13/syrhy5Fdc7i41nMEPVnVAF30IFNwYcurlDdfAj334Gp8BPCe9DONbA
	GMSqX0z+Ta4GUsKamrPE1/wXWFTXc7JPXpUDHVyO10giJwvGe8gxvAq/6IMKbPpVZ/OMLpA
	RtfSMIdfA3GzP8EBBmQAERrF7a03KZkVREAbfP2MCh5tAA/2wZw++JdocTOhZPL9CuCJThv
	UJQQFqCNbn77QhqZ0AVI8UXjgx86OYBqNJRTr5TyRkHUPPHJ/iHdXGs5RBJHRIb20Qmexot
	lwXXgUBN6oI203ZYtnrH5J52cwt/aIe34aMd0K7Ha3tN8dholOWYbyIlrBoUaXT5NJoMleQ
	oLBQy/Nm+ckXQvuguETaXwmu0fLIUM5h5GJKpGDon3b0wKBmUNaHxcTmEAFfjG+OsDGKJ5k
	Bj0YAlvt97hwczLXLAtXAPpBpqyuMr/JQXUVOcr4Jrvuh1g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The RK3399 has two USB/DP combo PHY. With the help of external Type-C
controller, the PHY can switch altmode between USB and DP.

Their connection diagram is shown below:

external Type-C Chip0 ---> USB/DP PHY0 ---+
                                          | <----> CDN-DP controller
external Type-C Chip1 ---> USB/DP PHY1 ---+

This patch add new "mode-switch" property for dp-port to indicate
whether the PHY can handle altmode switching.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v2:
- Reuse dp-port/usb3-port in rk3399-typec-phy binding.

 .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
index 91c011f68cd0..d503de7c7569 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
@@ -51,6 +51,10 @@ properties:
       '#phy-cells':
         const: 0
 
+      mode-switch:
+        description: Flag the port as possible handler of altmode switching
+        type: boolean
+
       port:
         $ref: /schemas/graph.yaml#/properties/port
         description: Connection to USB Type-C connector
-- 
2.49.0



