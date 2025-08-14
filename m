Return-Path: <linux-kernel+bounces-768779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C08B2655C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9A59E5DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03E2FE048;
	Thu, 14 Aug 2025 12:28:51 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD752264CF;
	Thu, 14 Aug 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174531; cv=none; b=QldFIHj/P174O+0Csr3W/IZrR941zPvLI0Y/8vawV2Is+BfT/oEZDdA36qU5cvpD8TYueemwRU5fF06hEAtniNys4Kp59r5YToMMiDVIRvz0jsWAfPd2Y3TtSjIpKPvLpRnrn5/SrjVIbKnWdCSd5tWIx+I+ScuFNa83dKTzaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174531; c=relaxed/simple;
	bh=8xx0v++E2X24TTjRB2GImLBQxE6J4zlYevYDhKIBE1E=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=UdvQLiAwac/ZB4AVn3FDlDuELvTYYJRzEteaD5GrNRSXMTbcXUAtHkqIPFSJ217fbDKSdaDMZz9PfSTeFUFPTkUn4G6sPMVcCT8y6JCJuXLtR8sauSVr17MWoD+jsNHVl08QGyKffv4wbuEym1lWJZ1plbpf8ogJE17EDRimK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c2l093Rlpz7rYv6;
	Thu, 14 Aug 2025 20:28:41 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 57ECSbiQ092876;
	Thu, 14 Aug 2025 20:28:37 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 14 Aug 2025 20:28:40 +0800 (CST)
Date: Thu, 14 Aug 2025 20:28:40 +0800 (CST)
X-Zmail-TransId: 2afa689dd678ffffffffa38-72e2b
X-Mailer: Zmail v1.0
Message-ID: <202508142028407445nvZxgf2l-bOvTMm2v-zs@zte.com.cn>
In-Reply-To: <20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn>
References: 20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <fan.yu9@zte.com.cn>,
        <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDIvNCB2Ml0gRG9jcy96aF9DTjogVHJhbnNsYXRlIHNrYnVmZi5yc3QgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57ECSbiQ092876
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 14 Aug 2025 20:28:41 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 689DD679.000/4c2l093Rlpz7rYv6

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate the "skbuff.rst" into Simplified Chinese.

Update the translation through commit 9facd94114b5
("skbuff: render the checksum comment to documentation")

Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
---
 .../translations/zh_CN/networking/index.rst   |  2 +-
 .../translations/zh_CN/networking/skbuff.rst  | 44 +++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/networking/skbuff.rst

diff --git a/Documentation/translations/zh_CN/networking/index.rst b/Documentation/translations/zh_CN/networking/index.rst
index 6e1c1df4a980..e03b5d5d39ee 100644
--- a/Documentation/translations/zh_CN/networking/index.rst
+++ b/Documentation/translations/zh_CN/networking/index.rst
@@ -28,6 +28,7 @@
    netmem
    alias
    mptcp-sysctl
+   skbuff

 Todolist:

@@ -126,7 +127,6 @@ Todolist:
 *   sctp
 *   secid
 *   seg6-sysctl
-*   skbuff
 *   smc-sysctl
 *   sriov
 *   statistics
diff --git a/Documentation/translations/zh_CN/networking/skbuff.rst b/Documentation/translations/zh_CN/networking/skbuff.rst
new file mode 100644
index 000000000000..2624ea8e8e05
--- /dev/null
+++ b/Documentation/translations/zh_CN/networking/skbuff.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/networking/skbuff.rst
+
+:翻译:
+
+   王亚鑫 Wang Yaxin <wang.yaxin@zte.com.cn>
+
+struct sk_buff
+==============
+
+:c:type:`sk_buff` 是表示数据包的主要网络结构体。
+
+基本sk_buff几何结构
+-------------------
+
+.. kernel-doc:: include/linux/skbuff.h
+   :doc: Basic sk_buff geometry
+
+共享skb和skb克隆
+----------------
+
+:c:member:`sk_buff.users` 是一个简单的引用计数，允许
+多个实体保持 struct sk_buff 存活。 ``sk_buff.users != 1``
+的 skb 被称为共享 skb（参见 skb_shared()）。
+
+skb_clone() 允许快速复制 skb。不会复制任何数据缓冲区，
+但调用者会获得一个新的元数据结构体（struct sk_buff）。
+&skb_shared_info.refcount 表示指向同一数据包数据的
+skb 数量（即克隆）。
+
+数据引用和无头skb
+-----------------
+
+.. kernel-doc:: include/linux/skbuff.h
+   :doc: dataref and headerless skbs
+
+校验和信息
+----------
+
+.. kernel-doc:: include/linux/skbuff.h
+   :doc: skb checksums
-- 
2.25.1

