Return-Path: <linux-kernel+bounces-822157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B48B832E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081B7580040
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113792DEA87;
	Thu, 18 Sep 2025 06:43:28 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E82DCF61;
	Thu, 18 Sep 2025 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177807; cv=none; b=KqwfKBmVcOZJg+Sq5h8DgB+VYwL+6d1YDH/HBUJCYvArvUgViXONrw8rbDIS7sjem7HpCxdYegIiNZ3gqa8b7qYwj0aWFh75ahNKF7PuZMQk+I25PxRJkzahxmKu068f4r93UbsaAXvKtTVqC6DgaOLpEYtn7f739kWx9labAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177807; c=relaxed/simple;
	bh=qTDbXGe3FZ7G4725CPcVc9qujyatZM6FxncFkb2Uuxc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=DxkjTJsf9dq0v4cdGg8HffPkIS546sFXypr04ZQkVdDnK/BcJAooBhcT3U2UD6K9i2vhiP+vlIlCPyybOtwi+7cRpjHntpQbFnnKdnk5EU417Z1AMYaPyEdBhhLyVp+J8Eu7MIfTivmLmRIwhcsFgNDQmTiLMg6eqrinL7TBDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cS5gY1W10z4xPT1;
	Thu, 18 Sep 2025 14:43:21 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 58I6h32H097429;
	Thu, 18 Sep 2025 14:43:03 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 18 Sep 2025 14:43:05 +0800 (CST)
Date: Thu, 18 Sep 2025 14:43:05 +0800 (CST)
X-Zmail-TransId: 2afb68cba9f935c-400a6
X-Mailer: Zmail v1.0
Message-ID: <20250918144305326x9mQuLPvqgyLm4WTJvZ9I@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <alexs@kernel.org>
Cc: <si.yanteng@linux.dev>, <dzm91@hust.edu.cn>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <shao.mingyin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBEb2NzL3poX0NOOiBhZGQgZml4ZWQgZm9ybWF0IGZvciB0aGUgaGVhZGVyIG9mwqBnZnMyLWdsb2Nrcy5yc3Q=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58I6h32H097429
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 18 Sep 2025 14:43:21 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CBAA09.002/4cS5gY1W10z4xPT1

From: shaomingyin <shao.mingyin@zte.com.cn>

add fixed format for the header of gfs2-glocks.rst

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 .../translations/zh_CN/filesystems/gfs2-glocks.rst   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
index 7f094c5781ad..a9c5f8810d20 100644
--- a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
+++ b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
@@ -1,5 +1,17 @@
 .. SPDX-License-Identifier: GPL-2.0

+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/filesystems/gfs2-glocks.rst
+
+:翻译:
+
+ 邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
+
+:校译:
+
+ - 杨涛 yang tao <yang.tao172@zte.com.cn>
+
 ==================
 Glock 内部加锁规则
 ==================
-- 
2.27.0

