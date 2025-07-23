Return-Path: <linux-kernel+bounces-742159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE7B0EE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B818914AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065228506D;
	Wed, 23 Jul 2025 09:10:32 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD79284681;
	Wed, 23 Jul 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261831; cv=none; b=BDyK2guw3AT5AvjNc2deiLxiug6dp6uFAHCS/f9P1ikPCBKzmUzkajqHEXxvOsBDBb/CvA2tUISsf078Zy5fm0f5GKro4QoerUBD3NQCmcB/C+7cQw2dDZ21XLhWBN+sIe9mtiA24b/rIwbLx/5sLX8orj+EA14IUOKNSmioEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261831; c=relaxed/simple;
	bh=PM1VPsrdjO0YYhZC6Dej1QyKtXiLbfGG2zKsH8vSHdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SD8nEU3TFT0ov+GjPpRtcoXX5uDGEGqnkzGYwXmp0cK2o0h90JJKOXT1WF7iK9kd0NhZGZsCgegXApCfeCXcy9uYtqZ3obnh7OjyREMKFd0OOSoY1GiGRSpU6bvwoYoFSeFvE3vIpZk+DLpmFCAf/umAjiDReN2zeLcWg+viGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz5t1753261782t33bb06d1
X-QQ-Originating-IP: 87V1k3nUNlWghQC7T6XSvNSIAYjIn2dp964L5xBjvjI=
Received: from localhost.localdomain ( [183.17.231.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 17:09:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2544636101494092667
EX-QQ-RecipientCnt: 15
From: Nick <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/5] dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor Co.,Ltd
Date: Wed, 23 Jul 2025 17:09:30 +0800
Message-Id: <20250723090934.480055-2-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723090934.480055-1-nick.li@foursemi.com>
References: <20250723090934.480055-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MxRSPV+z0HAofvtj4gW+BjMaKhMYbU/UAsTLgqPZAN6ATwqhdaUhJK3P
	X2XKtA4SzZLc/rMdE7MmshahRgapm+isy4mO8QhzAwrmgw65fzw4kx0xMcaGwa47pnoLh4n
	ZBu9stfkrXCng+Q3WDd9OjV+CUNdQrOyiT6cpW2swCe4MlmnKbO/tcDzgWcEhLgZmwxa7jN
	IG1Gqi0iYw2bo7QLH8BfOQY1iyFeGJM2wakDr9JK33KdoSf5Cr7qnlMFhWvuLjESlBKdY8B
	2/Kf5X4VO8FECALZ2/n7ToNzHUE1GRc6CmdUOc4njeMoIn2r89U5uWIRYlDY0pkcBbX4k2g
	GR17yJNtJQlBMxuIZ6jxX8cPrhEZKz4PJjfhOuLUTKp6rgUSvw1ftUOAvcAtN18simXrUJc
	/KLyFvFr5DdROH5C6z0aBdDIOqKsebHRCY3rdewukHvhITZsGkBAFjl9ft35DNlKvj2S/ak
	Tq38zkUVBOuU4+aeC8ACAaXbIQRiDQjhH0CQQI9jxgl/mCKmsSXvoifWjVodzzV9sKYRocF
	OqSWyzSGewQPzcufAVCVp1zN9zvNBXsuRpfLeMMCXcI6plB8cKyLdjeq4JA5PnAchU+st6Y
	yQL2qKGEyM6tvIO81lbU4ZW9uM0NaWV5vmJe8WHfBvxRuiGu2Mbi31/jD3+O09Oo728G+G0
	YCDxy7mWCbP0rGXmzU6Qb6o8AMtAivZeyGad0aJ4pZsvntGeyXYIrAkm62X82keuj7vpxbo
	rLLtUDpWdw3BnszmyPrL6K9wkGFauVItO9cq2+6LYeYgYAW8IEzNfMh7WO6y70Z7Tct5xbw
	+ItWM+guGlsOjb7uBI8PglKYbMRTPgiAP1LsYgMkfMLVR+q/64+iTJ12Nf2t/8Tlzfdy9Iy
	GEMbhvy6W2nzlXXu6N8r3YhrPZFXhKJ4/s7gJ2YiebJNW4TglwquhtEj18dXdKlrQFJaeis
	aVfYllgwgOB60RgXrl3DoMu3nH9DIxVBARkOnAgXSFbjAvQJxbDkWRXeyqVrzIXg5Y2L4fW
	tgSGpo6Sv5Q5T4o5/SWD5fuJCJw6Ja1uGG7gUP6XTjAvK44TIdh3nO2zOAh6rF83bOoVtvP
	g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

From: Nick Li <nick.li@foursemi.com>

Add vendor prefix for Shanghai FourSemi Semiconductor Co.,Ltd
Link: https://en.foursemi.com/

Signed-off-by: Nick Li <nick.li@foursemi.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 99e86271c..f692e3b29 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -547,6 +547,8 @@ patternProperties:
     description: FocalTech Systems Co.,Ltd
   "^forlinx,.*":
     description: Baoding Forlinx Embedded Technology Co., Ltd.
+  "^foursemi,.*":
+    description: Shanghai FourSemi Semiconductor Co.,Ltd.
   "^freebox,.*":
     description: Freebox SAS
   "^freecom,.*":
-- 
2.39.5


