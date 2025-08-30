Return-Path: <linux-kernel+bounces-792835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8675EB3C992
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52010586719
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35E2571BD;
	Sat, 30 Aug 2025 09:00:18 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED82561B6;
	Sat, 30 Aug 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756544417; cv=none; b=dt/HpzEn06GZ7nBOlGGH+kHpXBuvEHmv++a7VyGiN8qkthA/KT05RG2mC8Z+A2z1pIU3ZqrHONaewHHr81zhhKWSgW/3Wj903VxqIzdHfZgjAr4qZJiF7kr20Mvhi+7L5yguzyyx1h2WLBZTg+cF38OdjtVAdlkjcKeCpZqvfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756544417; c=relaxed/simple;
	bh=sUjBORaukm0iF8UijzEOGFVJeMKt27WwITXAs6P73N0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=EPmYHGjkT/oh0iw4C8zPwoXb8wV7brr/Nhs2C3/9QOwW6Ci/lHRdKPon9o74ywtN7m3R0EXBrRwTogcDjZ8CFVt0woOHerlJxWEZ/N2IXtQ2uLb9V4AorPPChlgmp1PzsF488+SZBOxGAXIIATtchtPZb7fu4T6J7LpXFeQNAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cDTcC6SYkz6G48F;
	Sat, 30 Aug 2025 17:00:11 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 57U903dm043350;
	Sat, 30 Aug 2025 17:00:03 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 30 Aug 2025 17:00:04 +0800 (CST)
Date: Sat, 30 Aug 2025 17:00:04 +0800 (CST)
X-Zmail-TransId: 2afc68b2bd94b9e-fe4c4
X-Mailer: Zmail v1.0
Message-ID: <20250830170004703gQ1JY1--w89DB0JaCwkYv@zte.com.cn>
In-Reply-To: <2025083016571123360dlV3pxVqfCY35MOQnma@zte.com.cn>
References: 2025083016571123360dlV3pxVqfCY35MOQnma@zte.com.cn
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
        <qiu.yutan@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDIvNCB2M10gRG9jcy96aF9DTjogVHJhbnNsYXRlIHNrYnVmZi5yc3QgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57U903dm043350
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sat, 30 Aug 2025 17:00:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B2BD9B.001/4cDTcC6SYkz6G48F

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate the "skbuff.rst" into Simplified Chinese.

Update the translation through commit 9facd94114b5
("skbuff: render the checksum comment to documentation")

Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
---
v2->v3:
1. add reviewer tag

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

