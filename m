Return-Path: <linux-kernel+bounces-822259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5BB8366D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19B524E2262
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3002EBDEA;
	Thu, 18 Sep 2025 07:57:38 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3B2EA154;
	Thu, 18 Sep 2025 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182257; cv=none; b=UUbRPNLk1yhQJbg9DWjnj3YihW1a5T/cpiSJwEWNSnGKPW5tRD6ETcwtC9kwKY4p2bNFUSjXP4LYul2FceWz5LvNvs8PaT0xgXEK7JNncQtp5oXX7WlOoOAOy7mnatGDRrwZ042EfA/YY9X/seu3XUR3d9hBGh80VhjHrEtvrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182257; c=relaxed/simple;
	bh=vKSOnufrF3bx+U6wur8L0pEWCkbcstxIhREck14B3p4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=CkAa4UikEDE4TVqE4OPl/oi1ArT5NbHMczM3LJrhdNQ10KXz/Hu7mgm7x3DSDPazp7M4Tie4q4WDEauoQmE28V2dHK2FDhgTqWrRDE1Hgd2zD69aYzsYv0jukN7ifz6BhqEUOPjw4coFV4F4YO3gg/rA1NKJ2kdUr2B6T7QUBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cS7K44970z4xPSf;
	Thu, 18 Sep 2025 15:57:28 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 58I7umf9025173;
	Thu, 18 Sep 2025 15:56:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 18 Sep 2025 15:56:50 +0800 (CST)
Date: Thu, 18 Sep 2025 15:56:50 +0800 (CST)
X-Zmail-TransId: 2af968cbbb42b6c-d881e
X-Mailer: Zmail v1.0
Message-ID: <202509181556503857h2V0skOmjONfEzUrZ-ok@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIXSBEb2NzL3poX0NOOiBmaXggdGhlIGZvcm1hdCBvZiBwcm9vZnJlYWRlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58I7umf9025173
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 18 Sep 2025 15:57:28 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CBBB68.001/4cS7K44970z4xPSf

From: shaomingyin <shao.mingyin@zte.com.cn>

fix the format of proofreader for
Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
Documentation/translations/zh_CN/filesystems/gfs2.rst
Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
Documentation/translations/zh_CN/filesystems/ubifs.rst

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst | 2 +-
 Documentation/translations/zh_CN/filesystems/gfs2.rst         | 4 ++--
 .../translations/zh_CN/filesystems/ubifs-authentication.rst   | 2 +-
 Documentation/translations/zh_CN/filesystems/ubifs.rst        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst b/Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
index f5c3337ae9f9..3975c4544118 100644
--- a/Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
+++ b/Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
@@ -10,7 +10,7 @@

 :校译:

-   - 杨涛 yang tao <yang.tao172@zte.com.cn>
+   杨涛 yang tao <yang.tao172@zte.com.cn>

 ===============
 uevents 与 GFS2
diff --git a/Documentation/translations/zh_CN/filesystems/gfs2.rst b/Documentation/translations/zh_CN/filesystems/gfs2.rst
index 301a6af257b1..ffa62b12b019 100644
--- a/Documentation/translations/zh_CN/filesystems/gfs2.rst
+++ b/Documentation/translations/zh_CN/filesystems/gfs2.rst
@@ -6,11 +6,11 @@

 :翻译:

- 邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
+   邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>

 :校译:

- - 杨涛 yang tao <yang.tao172@zte.com.cn>
+   杨涛 yang tao <yang.tao172@zte.com.cn>

 =====================================
 全局文件系统 2 (Global File System 2)
diff --git a/Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst b/Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
index aebd6a8e4b7c..0e7cf7707e26 100644
--- a/Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
+++ b/Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
@@ -10,7 +10,7 @@

 :校译:

-   - 杨涛 yang tao <yang.tao172@zte.com.cn>
+   杨涛 yang tao <yang.tao172@zte.com.cn>

 =============
 UBIFS认证支持
diff --git a/Documentation/translations/zh_CN/filesystems/ubifs.rst b/Documentation/translations/zh_CN/filesystems/ubifs.rst
index 16c28bfd6fc3..51b7366446f8 100644
--- a/Documentation/translations/zh_CN/filesystems/ubifs.rst
+++ b/Documentation/translations/zh_CN/filesystems/ubifs.rst
@@ -10,7 +10,7 @@

 :校译:

-   - 杨涛 yang tao <yang.tao172@zte.com.cn>
+   杨涛 yang tao <yang.tao172@zte.com.cn>

 ============
 UBI 文件系统
-- 
2.27.0

