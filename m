Return-Path: <linux-kernel+bounces-773349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D201EB29EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB334E39F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3A310761;
	Mon, 18 Aug 2025 10:00:29 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9121CC49;
	Mon, 18 Aug 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511228; cv=none; b=HLrPkHw8GYH4QZMyng8G2TJThDu6hapK1N68lgjVNkeIraR5wXfRK6kmSLYva59WmLt6V8mM1t70A7644JkJMV6DcKQtFRokC53UASpFrT+SVnLXdc5o8rlYUkxm0YCOMMZvNRekGlasIhQzcllDPHgqvfjMZi2uloVEY3ZVtQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511228; c=relaxed/simple;
	bh=2NxO0Gc3+LC1yksxA/fojlVlxNxTP7hES0U6g0mu7B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuVPZdcZ3Qn1dZp4BBJfWbk33infmEhofdJp7HNpnpiOJfTeqfX7J7MIhdlTDoMra36BiG4/blzR6iIEMwIPwVVcOR0yry8BO9F7wMCfJXNr1jzgEoaXCQAOWnThQNXVSs5MdtU+/8Dmyor2EHsli9IWfdyTddLMsO4kJ4bq/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.154])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fbaa9cfe;
	Mon, 18 Aug 2025 18:00:16 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add HINLINK
Date: Mon, 18 Aug 2025 18:00:06 +0800
Message-Id: <20250818100009.170202-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818100009.170202-1-amadeus@jmu.edu.cn>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98bc9f57fe03a2kunm3d9619f636a237
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0xMVh9MH05LGkwYGhpITFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKTk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++

Add vendor prefix for HINLINK, which is an SBC manufacturer.

Link: https://www.hinlink.cn/
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a92261b10c52..7ce1970d3125 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -648,6 +648,8 @@ patternProperties:
     description: HiDeep Inc.
   "^himax,.*":
     description: Himax Technologies, Inc.
+  "^hinlink,.*":
+    description: Shenzhen HINLINK Technology Co., Ltd.
   "^hirschmann,.*":
     description: Hirschmann Automation and Control GmbH
   "^hisi,.*":
-- 
2.25.1


