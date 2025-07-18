Return-Path: <linux-kernel+bounces-736842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFEB0A3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D32172621
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726A12D9ED3;
	Fri, 18 Jul 2025 12:13:26 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC350215F42;
	Fri, 18 Jul 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840806; cv=none; b=g6YP7/wn+hR/TNszi/OuKvJ5X4nk6/3YeK9c/etdFPnOKjXUEaxs4n+i+yktZMPuyjOucKCaPCMe6309BNdURZYm4wYpSTbkw8AIzEcN77S2haqaLMPIi9NXbVaWMsgw8GBvVdrYzaFBpraeFynRchholKtTBdTFCVxgJqJx8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840806; c=relaxed/simple;
	bh=rs0Jrxz0vRepAeCwsVCMO/UiEo/apDCQ/z41u/EWCXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfN4LeV5/WglkouGVsa1nXAMNuzCCRVFM4xaqlirOFwiIlwWx9KpYm1AdwQOxTJYQBvzUjM4TjFUx6ZH7a6UuLQldLnreUIgDY3Lys29aif2gc50mqkeVxG7CCW4YUzMAeoG406ya+WKU0XQNgdkWltanVUodoN7+oZiK2cqho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpsz21t1752840749tc1baef34
X-QQ-Originating-IP: k+7Z/22s+xsYjJCHqZOVNIROGwloEObo4DIqJ1I/i/8=
Received: from localhost.localdomain ( [113.89.232.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 20:12:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8113494319884698280
EX-QQ-RecipientCnt: 14
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor Co.,Ltd
Date: Fri, 18 Jul 2025 20:12:18 +0800
Message-Id: <20250718121221.76957-2-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718121221.76957-1-nick.li@foursemi.com>
References: <20250718121221.76957-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NH+njjzUOij/YnoNbHhfKlFkgfnF8Z1VY07g5FxuSqm9hBHB+EiEN62O
	NjTdwRjMmwv+wf82aJFeILbO6yeuwEW7fLShFSusrxMWzX4MgHTcCBDwew71bKfTQEmS2Ni
	E+PxmiBBmIFEXMbisdfSP87tRDJCaDb3dRNF2GDUQ7gXRZ1FW6TjxyFtVuAmgG0gzh2KsFl
	XlMg0t5sgSH61dJcEp/d/T6A/WP91S9638Hz6IgSfeCtXqum/gvweJtXQBq/wxFheFFo0V1
	gTPB8r177SLQbVNEKpVGGayGo+tMzvsFcqQ6gir6EoNaBGNavmtUxUV9QryomBrKKmAdDjM
	VCWU5z7vsB1CHBNqdgH59HZWWzj8pQPwpyOj02iyvlMt7y1yfb9mq+cVYHCYMWg5MFqQRCb
	WYhKPV9ZLVT1GV/USo1wiQfO01Hw1/Jv548KbDujYzLMwvTykDZcifuShnws3oePJG2YnKs
	R/QZtqsjBLBkZ9Kejb4KmQKtRFuwo9CQBZxrtYuaEIlSMKFqd38BzWOyTinczeLR7FVXDPU
	28f6m157O0wImw+b5nAKFUkTR2/s3i5Q58x44W3X/8CoFppUig/FxJAwd2Qy4+iUTje7hZ6
	CH90gTXcfB2Y3GnFIoSTH2yU4alW741sFA+PSjh/+YJGUNytCevq6aydSkxQy1uLNCTU4R2
	iuL526Y4YM/2jB/VLK4iphSG6nQJerPfOTolDwgLdQJCF8/PaCJBBnZBWL+lTL0Gt1IkW5L
	IQPL+XlVeZKIagkRADUzQm5EtbNbI7efElQrxzfIPW3CaMvl1vZwxsiaixSjdDkUo9LjCLG
	P8EOQfbPypv1eDSOTnvBeqsHzfTPgIT4C0UIWaPjBcuZ+8HMG5KdhUE9HOn+Lr98cc94mZm
	4DBr87VvXixZs8kHFHx5FyXaq5NaAvYoytHVd+HoOCN9HqW0VwxMOn8u0ghyVDdpjrE61Zi
	CQ7TLcvzl+j65sLl/NMdSB6qMJgCVH7uxT+s2Dn64xtKkAfPkQHAJpRCiA8E1Ax0r66mCub
	iJzV6LP3xwgbm7GCYGbpQ0Z5lCtvLcWqozB8dd2FXZrX6UAuA1PN450xwTHS6TZph+jwhpY
	m9EWl4gGoHHMpMGlkFN9vBagDQuVsZTRUkfGIR2v8oqSb6PILQvBe0jMtTgKTD7igRr5hxl
	q1Xi
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

From: Nick Li <nick.li@foursemi.com>

Add vendor prefix for Shanghai FourSemi Semiconductor Co.,Ltd
Link: https://en.foursemi.com/

Signed-off-by: Nick Li <nick.li@foursemi.com>
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


