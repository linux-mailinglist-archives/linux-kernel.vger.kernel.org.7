Return-Path: <linux-kernel+bounces-739076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6AB0C177
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8205A18C1FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6726229A312;
	Mon, 21 Jul 2025 10:40:10 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9B291157;
	Mon, 21 Jul 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094409; cv=none; b=gFfXgQhJsRVy2VSA3q+0PKcDJsEwsWcLoZm7mzocbO8WZwQ7oaQutgGs8nhoaIaMALJzFEseOTh9VDjTIpNd+SJLcXAHvL6CxVQ7kCQNOPEdjVPu7X4bna1KXJ2onDKIYrC/j2S2V1dz+SRmAUBEifbirKtNPrR782Nv65EyKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094409; c=relaxed/simple;
	bh=PM1VPsrdjO0YYhZC6Dej1QyKtXiLbfGG2zKsH8vSHdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mCQbm0gB87zp1Bn1j+ERHrYFhgnZAC6kV7ABfrDhGAGn2N5HJf+QIpzdbKlhIOBSKZHhvefhEqZDQoUJFWfQE1yV7gQxwqa9j5Cqyq9oJHzAVG4/ChpNxYChlLWzb3qxsAwhETid88cS6CZj85D8h/VOTippTlLCO7argV1x3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpgz7t1753094351t4cd420b2
X-QQ-Originating-IP: O5GI00GzIPKUFNV7bY3KUhaypjVvPaBFabvA01mdUxo=
Received: from localhost.localdomain ( [113.89.235.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 18:39:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12390014289647281348
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
Subject: [PATCH v4 1/4] dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor Co.,Ltd
Date: Mon, 21 Jul 2025 18:38:02 +0800
Message-Id: <20250721103805.531758-2-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721103805.531758-1-nick.li@foursemi.com>
References: <20250721103805.531758-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Ob956G9wEH2T/Ud2ndgMTMvCu5wGWjO13XN0CDnG7VLp4mCwvTMF2at+
	i/8CTe5fPaNyT79k6ekOk7M0ClgzydArYnOfPLoKbcCoBgi6KT2Zkc5G7EMAkbJh7TudHCU
	MdC8Cp6XLdzEJn03yQiTSFKWi5uE4rr51ZcLG6Hl62vBV7YTzFVBtr5Zz2+9tU/K44kfNi2
	ccXTkgU/nd4NBRFZFymSQaBHYh+ksN+P+6XQh+0sFSpvD4pKCzgBMpETHzb5Z3bR03dBxgR
	ubM91xn4P3Cfs9mhN7iKoCK0PvW05BpS+m0nKYWLuQy1fvnREhJbMndGKxhW+StP/iDhYcR
	7/zvUocwrmPuUGk3JAIEPIoaWRKk28beR6nWUHX20zm5pPoNtfP1BCFTQKoTHrZmyL/ebaV
	mXWwrYHo0idceF3QkWtmgzcb5jV3sxn37SEwKd2TOGq9I+MARLf+RIrnB5v15e5Rcc0KI6d
	mlT0rpej+igJXzTLFtY3o0xPxCi50YC1wUmTA/STALGi/VFrRATnmKQGyNAb+npWamS/1q+
	Fhv3N/lKOY4kIn5mbVyW3viEgwcaCFfdRUxYj0/MEYtxiUfw99jQcrFq7HXPR56m5+ESaQE
	spnAvvNnhgTSAx9YwcdPpFNBz/joY4J5JobSsedvphryAP5SM5uIyWZasFj1asCXBy6qaJ8
	vN95Pj0EmQhoHS0LD4hlnr+wBb1+QLn2z6jCZTp/fL5YBT3hG/FLcJWAmVNnwVmJSD7Ophc
	f8o4WzIMAd4Q26ef/Wg4SQdwP/CIkF6ejEPIHcnrNgG04XWgNYnpK0/1H+pzlnrCBzy0eXu
	DFx9bnBK2Xdv7TQA5VNV7VUB2d53Q9vxWfpb4gSs+Q/qWPlRC75Y/9nMxh633luaDr3P92V
	FwO4LlgSpRJOVxq3gb+NNugpSIA1r83NAsAQofNylg5UWQIrNkbtYrZmU3c937ga5FrwqnN
	nW6jrshta3aRE3KIpX/FT5b3p2+4CGCDHIbbcYgbWBl3SuBFYdhB2nfBt4Hurlaa6os0hua
	1BpskJjFSd5W5ENXDHOdA4X6NEqckl/PMBDQ2veUvt2nyiR5TJQ5RCOZf9zbYSDJYbylRsZ
	DA4m2cEG/GP
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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


