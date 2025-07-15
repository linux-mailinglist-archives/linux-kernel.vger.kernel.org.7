Return-Path: <linux-kernel+bounces-731728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BACB058B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457427B4DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B32D9493;
	Tue, 15 Jul 2025 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="KVkb7jMO"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F42D878C;
	Tue, 15 Jul 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578726; cv=none; b=IJPng4Ehj4OCU4Div7ar54ppc+fQL455Nbb83aekX7A7Kp0xaV+zPyvfecNLxc0mFleKuZUNqu/pr17C0F/5VbAbpUYX2qCxhyVdi4OgrU4JAYqDuBrexR4hEPObsAVUlL4/zhU6YCSkxV5N0BXAkdkw642L8BEXrpGcbWEg8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578726; c=relaxed/simple;
	bh=Yxu6FQwHhhkRhorIrxlY9BdpbQWdym9cjQ4dEhAHzTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z9gA0A9v/eO+p3akzczSJCFKixenxmMHILBkwRQZjw/mfBcN+At6EXpW+yWUP9pImJrggCth9OkyMuL3UgfRO/Pzgj9t7NiZpvn+2sN2ZzNd3XklMnJ8xn3eYhJZ7VIiliARnOZw/uodmjWvzKus7wLgFWATWX3BAavcGZ4kLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=KVkb7jMO; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752578713;
	bh=PdxuukrMJyMvzJ16KhGFmRwb53DnIsrK3r7HucbSbmc=;
	h=From:To:Subject:Date:Message-Id;
	b=KVkb7jMOibljmFjUAAczD7NExhTMZofA6A1vS8onw/VukAkdJa0BpdUQaLerjflWF
	 ml+gyeEV9KIrAFPK/aDHo2K64WAZJO7n6SyziNImAWGjniozeplElK9gZGEAId60u1
	 mflPw/r97vwxlAMocYFnERWybgXdfvheXEIwpvQg=
X-QQ-mid: zesmtpsz3t1752578712tf0188769
X-QQ-Originating-IP: XVdB7d8ltncWpCfKxfEuv57ere8QMwHyZ9NM2AK9eVk=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 19:25:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11091658648405409275
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
	Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/5] dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode/orientation switch
Date: Tue, 15 Jul 2025 19:24:53 +0800
Message-Id: <20250715112456.101-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250715112456.101-1-kernel@airkyi.com>
References: <20250715112456.101-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MmPNY57tR1Xn6g0A9TeECUkHxPvbvQBl3nIZYkP+CjYLJiW3Nb96Uhw2
	GTh93ePrTik//Ow6GZ42lTAlvuMv2OkQYwzmpZnuV5Yvb87wJFPSeB60r+0iqUQ6oG0I1gm
	igVFDKJlxHUCOn2zd37/vKNfR36EzUNBZZGB5wRdIJ/Jw0uTp1sL2S06UN9mA+25neLdplm
	um6ekG1A3c/xhe1JzWzRJZbRER+N1xyic43u0siTAU4OBUqXGc9LBUkurSfT6C5cZ7F4Z9W
	unW9HMsYCzoh7g32aQD0+8mtaNLQVmpKAZaXrBXQxjktycKdBbYuB4q1Unp4BO8aDqG17kc
	GbglWKpfrUBjoTXjz4z8IHVFS+sDCULaYfdBTuWMmJoJl2da1PVESmEaGARBoKO8PEDfxVo
	RS1IxLa45xTHyP7Gu40wOwxDes6X83epd//U3lGJdbxYZZ2b83y4Aqdg7Jwgv1NiWhz7kae
	TXaFC9mWvFAr/ca+wxnEOuv3TTcIkA8Ymx/zfBKDGSdDJ5s3EukKnmvdBeG3pgS5vnpF7V1
	9ltxHFd+1Yf5MzmWmAqC88pwSgGD+X5/H373QGTAmUAHHYdhpRn5T1kw4v65HXVmtT1tZ5w
	Q/9wTpH1oKSwo5DyZYOjFjbOfWRLBGNeZC2H/NinsT9uCTKGoQ+3ZY6hwRW02opKL70YAQv
	A0rEDfT+MVjocM6b8V2ZLVXjKg1heJAPz/uLCVcFDyg9QT/bxiDWd5SvC/rNh+lkwISpKeE
	eN9mK3Il+oWn9ZyE6LEuAmwYKp9K2qu889SHVHEQuRbQquomI+5tblAmTQ+a74ExxiI+wMF
	uUY/hcMg/mtta3KVagROJo4ogBO2xRCEnrxwyafabr7ZGfLjb5VkpYWn/B9pycCJMubj0Uf
	2HshmxBJXs3T0Z4joW1b9FC4B8AYWigSNZBEzWRHgUfqDWXw2fD+HY2579mva56wuOWW2SM
	ywGGR0a+ipE9iVYcj0em8DfXmbGnYvDlGOWEk/VkArad162nw7ij7PkPXzGqNxRKmq8WaPN
	SLfPsffw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Add support for Type-C orientation and altmode switch.
The Type-C controller can be specified to handling switching.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../bindings/phy/rockchip,rk3399-typec-phy.yaml    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
index 91c011f68cd0..a885c6893a90 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
@@ -43,6 +43,20 @@ properties:
     description:
       Phandle to the syscon managing the "general register files" (GRF).
 
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  mode-switch:
+    description: Flag the port as possible handler of altmode switching
+    type: boolean
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the PHY to a TypeC controller for the purpose of
+      handling orientation switching.
+
   dp-port:
     type: object
     additionalProperties: false
-- 
2.49.0



