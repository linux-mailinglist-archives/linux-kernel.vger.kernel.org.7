Return-Path: <linux-kernel+bounces-822148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382BB832A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD62C1C803DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4092DA762;
	Thu, 18 Sep 2025 06:37:07 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9652DA755;
	Thu, 18 Sep 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177427; cv=none; b=m8RETRPuuKhnSL255lix1nHgq8hpH1HO1u5RifdSpEKL0rmnBMxnysBOrlnyIDJjT7h7iHatpqSOiATacykdftvn2a+VeQJPjsRtZSaF4yDfmu70J8UL8oHSOnLtqhvreoE6zRm9KKIj0pmW9zouirxom1R7lItnHePf96yodzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177427; c=relaxed/simple;
	bh=dB2D5X2TaDzSzcQxd72RVX4GNj0RdIORusioHfUXCgQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=iggVJRFHGnSxC9sC1Ui5TvoU3XNJajChV5Ff/795Skac3OBDa0T7qP7Wk+s5KFmrI75WGKwPehhQV0HI5ppUfr1XWX/8m8w3MApD8aXqgkoSB4Hb9Vmzaaalh/bQzL9T4hWM3by9LouG+NpeW3w31M/izGezjNXhm0UO2oX5500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cS5X45Jtlz4xPS7;
	Thu, 18 Sep 2025 14:36:52 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 58I6afdC068792;
	Thu, 18 Sep 2025 14:36:41 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 18 Sep 2025 14:36:43 +0800 (CST)
Date: Thu, 18 Sep 2025 14:36:43 +0800 (CST)
X-Zmail-TransId: 2af968cba87b807-5753a
X-Mailer: Zmail v1.0
Message-ID: <20250918143643417OPRH_RjCXkCa3aCtQEX3Y@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIXSBEb2NzL3poX0NOOiBhbGlnbiB0aXRsZSB1bmRlcmxpbmUgZm9yIHViaWZzLnJzdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58I6afdC068792
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 18 Sep 2025 14:36:52 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CBA884.000/4cS5X45Jtlz4xPS7

From: shaomingyin <shao.mingyin@zte.com.cn>

align title underline for ubifs.rst

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 Documentation/translations/zh_CN/filesystems/ubifs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/filesystems/ubifs.rst b/Documentation/translations/zh_CN/filesystems/ubifs.rst
index 16c28bfd6fc3..2491c059ec25 100644
--- a/Documentation/translations/zh_CN/filesystems/ubifs.rst
+++ b/Documentation/translations/zh_CN/filesystems/ubifs.rst
@@ -17,7 +17,7 @@ UBI 文件系统
 ============

 简介
-============
+====

 UBIFS 文件系统全称为 UBI 文件系统（UBI File System）。UBI 代表无序块镜
 像（Unsorted Block Images）。UBIFS 是一种闪存文件系统，这意味着它专为闪
-- 
2.27.0

