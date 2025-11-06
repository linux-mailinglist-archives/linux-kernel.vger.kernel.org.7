Return-Path: <linux-kernel+bounces-887654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE6C38CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728633AEBE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855025524C;
	Thu,  6 Nov 2025 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="CMpCFxli"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C023183A;
	Thu,  6 Nov 2025 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394886; cv=none; b=N7TXRCnoYfPZGmJ3izMZavAxDWNi11rfeDavI9EbZdvodDs91tV++EJLrDSvnDX0toUBF94Fz1lHkxL2LkbjZcP4wMPFWqBd/6tZl1Pp9dWTjgXFTbkdulV/w9JTIlRY2SOO3qOK8uBKVOJGFyws0eR6G1/2+fwr6qSHwdcfP68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394886; c=relaxed/simple;
	bh=e+hVU1RC2LYfYzZmWNnPMdE+z/tJGbuEiNFlNe9HImA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iDJ8onTDuCgPX4lUlbpgQ8o8CsGimSLZASxSWsSmDDEaViu8qoIShB/ZvP1aSVExBX7gGXEAalckdnfIg98YQubfMJ2oGyRqiGOfDooVruM7ndFWKz1ufF880cZa2z8VBvmEdSJvjh4yOElwg94mpfLHpZbV3jmBnieOgDlGyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=CMpCFxli; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762394813;
	bh=vMnx+1Z0AQ+IaQ+rncoQKPgi68bObdKKAtspniD0a0Q=;
	h=From:To:Subject:Date:Message-Id;
	b=CMpCFxlinqhCcXioaU+1CIgiZcAeVgeyPI99SbsvPODXihbiTC8nCvl5lYhqiPy9E
	 77tx9UPJCI6jWp/3Y/E/nai7Cghu7ZP2S1/j3CK/zaP/7mNf85MH1QymYxU3ACjb6I
	 EA6aUgJQrPGPDINuXCwLkQSRJfAIiU7ehIN4WyV8=
X-QQ-mid: esmtpgz15t1762394812ta4938bad
X-QQ-Originating-IP: kCOxFyGhvUgtQVW7lgiKC2yFp3VgIVWm+DtouM+o6Gs=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 10:06:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4724032086787846867
From: Chaoyi Chen <kernel@airkyi.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 2/9] dt-bindings: phy: rockchip-inno-dsidphy: Add compatible for rk3506
Date: Thu,  6 Nov 2025 10:06:25 +0800
Message-Id: <20251106020632.92-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251106020632.92-1-kernel@airkyi.com>
References: <20251106020632.92-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OanpiDkno5AWnu1kQ4CCcJbB5Kv81QjBSegSBNeN7MWLveon9DgMBezS
	BIShNojkiNr/sa7nHgs/0Vu8oagasq5OTe4VDsjO2uiwNcBqsqNXxh892faVevjMWuwnxTN
	lgfPKfHySElUMRxuPHQE8Hl+o3i1x1LDwczybs0j/6izzGJaqCUKlY+izvpZuCA4Qi3QZUW
	SRWSJZC6ZGlRMMFePG3FeI0PBjVcdkgQXsFK9VMYVCbBKa4bAG5nr6kzaofVNGOL68nIlHR
	IvaSnQZpQFikg9FZU19b9Q1XwF3pW8OJH6cFjtanmUWNr3CKIJ29XiD9hBsydS8Zw0jKcNT
	BSpdOByunyYARuGOPeSVdX59Q+9250S2hEbogMosTXm0mCpoKb2ay+B90yt2FaHjCAt+xm7
	zni9xrcDsw2flv+yyNxhzjRw2ItW9nBL8KwLiK7tWOK4JMjS2H/woap1wllK4UFTmp94mAB
	kYg05wzcC6jXgmEfGZ7DsBkp7xxpOiwdR1tfwQwQ82mr5gyorbMzoUC4oIxEElsLdRt7RJL
	lQaVkLL4kuKMcoxQeB/6wYV6sJZgy3yK3/KpwzB2/Jkee5zi7xC14mhGyHLlCCq/6GB1UQ5
	Uj0kReasxskT8byZ2AZOl60AUoPRwHQ5psB6ZXCqD5GkRjLPi+9E9uBa/C56uCSKYNfMHXA
	cJ3suRAzmSBZSwmBJnj7JFAcjCJm0b+4SMKB/aDyqj4Y5Qa5/7LHba2Io7+alSVddxVDnpD
	0ASuOyCfMpNKlOUC8Pyjsx/5mPOi2oGf2Vm7X5VkzBnMtbSUulAgwy/lMDIu4wG6qRbqy3g
	YiiazW0//wdx5qGDHFC1WjaD6TVVmHClOM69GlyeE/ZQejNmnJVqlEpJihzNaxT9xXBVArb
	0QrJoYcNvxobJD6h9a6n+0FA+z3GcsCYWXA8yLrPC4okC8J2oSuX74KBsde7cCnRCwldJ/B
	kECvX7Y3DR99U11+6EEIX1zx6fLnZfbBZBbTz3CilfCFj5qYm1klTWxCtKc9JjcdZhhsuLu
	txsgqwEwUFGtAeUPlgbcrry3+YlHU=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Document a compatible string for the rk3506 dsi-dphy.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
index 46e64fa293d5..83e7c825860c 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
@@ -18,6 +18,7 @@ properties:
       - rockchip,px30-dsi-dphy
       - rockchip,rk3128-dsi-dphy
       - rockchip,rk3368-dsi-dphy
+      - rockchip,rk3506-dsi-dphy
       - rockchip,rk3568-dsi-dphy
       - rockchip,rv1126-dsi-dphy
 
-- 
2.51.1



