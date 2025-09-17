Return-Path: <linux-kernel+bounces-820014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D1B7C53F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E3FD4E1723
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6442820DB;
	Wed, 17 Sep 2025 06:00:38 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2422156D;
	Wed, 17 Sep 2025 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088838; cv=none; b=KTms3j+e/YPEmIzO7p6L7zcD6iSeeICTHBKx2rn598/eFAG2baQoLy8w4W+1NCeFwVzRYAQ0+lW5i34bQb284Tj3NZpE9XavXAPbwdNfnHZzPCCzJuOzhC31zZ8GhGR7xJ58Ayp/tnPivXKTMOyUXpDy9fc1emmrxtTAmMUvJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088838; c=relaxed/simple;
	bh=/DNBC11wV0nXKmculC8fWaHGqrXeDrR5/gp9I0ROIVM=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=SGUyOmqW9yh3bbzHTeKWv2tYXS1ZZsFhq+mZEHvYmtyJXPIN9qYYCcJmip7CcGj4r7qq5q2B3RwW5GZM5B0eVlYABLMQxTM3gKMSrmtRJR3NB/fddkdhwU0vLlOiseph+e80I/t43wgr/O7DutSBOa6H4QyyncilR8W51a0mKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cRSmb2MK2z501bS;
	Wed, 17 Sep 2025 14:00:31 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 58H608AV043934;
	Wed, 17 Sep 2025 14:00:08 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 17 Sep 2025 14:00:10 +0800 (CST)
Date: Wed, 17 Sep 2025 14:00:10 +0800 (CST)
X-Zmail-TransId: 2afc68ca4e6a4a6-738b6
X-Mailer: Zmail v1.0
Message-ID: <20250917140010636SMB_b6UYttZyOP2L0K93O@zte.com.cn>
In-Reply-To: <20250917135406432vKZ2pELx-bRkvOdfP10Zb@zte.com.cn>
References: 20250917135406432vKZ2pELx-bRkvOdfP10Zb@zte.com.cn
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
Subject: =?UTF-8?B?W1BBVENIIHY0IDIvNF0gRG9jcy96aF9DTjogVHJhbnNsYXRlIHNrYnVmZi5yc3QgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58H608AV043934
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 17 Sep 2025 14:00:31 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CA4E7F.000/4cRSmb2MK2z501bS

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate the "skbuff.rst" into Simplified Chinese.

Update the translation through commit 9facd94114b5
("skbuff: render the checksum comment to documentation")

Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
---
../translations/zh_CN/networking/index.rst   |  2 +-
../translations/zh_CN/networking/skbuff.rst  | 44 +++++++++++++++++++
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

