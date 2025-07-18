Return-Path: <linux-kernel+bounces-736540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E5B09E44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BBE1C2508F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC4329826D;
	Fri, 18 Jul 2025 08:44:37 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC182296150;
	Fri, 18 Jul 2025 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828276; cv=none; b=T0mngC1F5RLIHJLmceYLia5vFAID+FYmXZ4/vz85l257cj1qSZOUugkkUjmdpMGC1oD8OIxzR3KI4zFB6Vf9PEP4zXGnuFHJRwlESLwABT5xJj4q4ErOXsAa8xXFQpMtU57WRi40E0TNGqUmmmQWGvZrd4/Wop9+7ZQZ74BG3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828276; c=relaxed/simple;
	bh=dQUKLmv0b8SNRCE+D8tBV2Y0hFzTOan73ishk3fAWjU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=H7lXe88JPrmmW9iYTqxTOKX7DnO0YCvmdjZ2jnm3VFDyKTE7xSkb7jeekW+HlqGn3A1YJVjfcuKldE3slJop/OMHaFokwWdmBG/OlCJDhtJcOiTjyZad4deaA2Do7RyEr6yPTldw4iD9pfeyURdmMdx3hYQ9lgDVahAXDrAbsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bk3Hp19lBz5B13X;
	Fri, 18 Jul 2025 16:44:22 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 56I8i7Qg059890;
	Fri, 18 Jul 2025 16:44:07 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 18 Jul 2025 16:44:09 +0800 (CST)
Date: Fri, 18 Jul 2025 16:44:09 +0800 (CST)
X-Zmail-TransId: 2afc687a0959529-a9edf
X-Mailer: Zmail v1.0
Message-ID: <20250718164409239V6nK4AbfOlggzTHSQMeIT@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIDAvNF0gRG9jcy96aF9DTjogVHJhbnNsYXRlwqBmaWxlc3lzdGVtcyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56I8i7Qg059890
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 18 Jul 2025 16:44:22 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687A0966.000/4bk3Hp19lBz5B13X

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate filesystems docs to Simplified Chinese

Shao Mingyin (5):
  Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
  Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
  Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
  Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
  Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese

 .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
 .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
 .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
 .../translations/zh_CN/filesystems/index.rst  |   5 +
 .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
 .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
 6 files changed, 826 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst

-- 
2.25.1

