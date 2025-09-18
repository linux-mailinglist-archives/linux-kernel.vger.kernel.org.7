Return-Path: <linux-kernel+bounces-822202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9AEB8347B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725EB1C21FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F92EA49C;
	Thu, 18 Sep 2025 07:14:22 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16E2E9EDD;
	Thu, 18 Sep 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179662; cv=none; b=gYVeVKovamSBprNHjXYBfdrxbCrgcJZwY9a0wkAgpKjQ9agX3qg8Niue361+u91iBppguBfBQ1GKEekQuePXUjjE10Mzl1mXqPTgKJ48H0+RvNNeVv4ztdZ3C/ffVsR6wii+8OcJtE/Q8cBNT+MTB2G577d0GJLo/1WhYmN1TYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179662; c=relaxed/simple;
	bh=H8+TQ8fpOavRr+SUvGo2D54Zmln8r2srjkYbcoSpEpM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=fCciyJf+eRZwJ3EhaFO0YKQ756ekt4I2vviGQ2ODKNsDaQki1LvxOFxc6L3rUI5Quih3+/TsxcJn23Clg9MIMBder7riKa+kkKL+1NPuCGdZj6ct8EmvjFYAlJ6dmrClyaGeg1WLhbnaFTN1wKr9fVEazIye8Lt2L5wSMPmzzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cS6M43qpsz5PM3V;
	Thu, 18 Sep 2025 15:14:08 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 58I7DlLb032075;
	Thu, 18 Sep 2025 15:13:47 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 18 Sep 2025 15:13:49 +0800 (CST)
Date: Thu, 18 Sep 2025 15:13:49 +0800 (CST)
X-Zmail-TransId: 2afa68cbb12d399-8809b
X-Mailer: Zmail v1.0
Message-ID: <20250918151349743KS4zJHQOoG-yPHSeAY3dv@zte.com.cn>
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
        <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBEb2NzL3poX0NOOiBhZGQgZml4ZWQgZm9ybWF0IGZvciB0aGUgaGVhZGVyIG9mwqBnZnMyLWdsb2Nrcy5yc3Q=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58I7DlLb032075
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 18 Sep 2025 15:14:08 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CBB140.002/4cS6M43qpsz5PM3V

From: shaomingyin <shao.mingyin@zte.com.cn>

add fixed format for the header of gfs2-glocks.rst

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2:
remove the "-" for only one proofreader
 .../translations/zh_CN/filesystems/gfs2-glocks.rst   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
index 7f094c5781ad..abfd2f2f94e9 100644
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
+ 杨涛 yang tao <yang.tao172@zte.com.cn>
+
 ==================
 Glock 内部加锁规则
 ==================
-- 
2.27.0

