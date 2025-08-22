Return-Path: <linux-kernel+bounces-781452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC6B312A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEEE620473
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777102EDD47;
	Fri, 22 Aug 2025 09:12:55 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1B4D599;
	Fri, 22 Aug 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853975; cv=none; b=p1ExVsNxppka63k7kUY/j9mjh6WZKSwVL1bdF6ftT2hqgIhzCMg3FQuPZ/TSVNQkCLS9HavZ6+q0t76SB1gEYUMpiPyMhSeu+NwMVURrN4j7qKj5aCeSmqwQ8bgIRFM1NqKyVvd1xaw5Pi0EKZ1p1pCsagFLJgQQHQbnTZOCIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853975; c=relaxed/simple;
	bh=hRidZKtD/a2L5h/chNBJ6qzkvlaUqDVag+mfp9+UPwk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=GnergSzrnA+OvQJeFQiPx9MFOihsbGhSTNbnsh4P6pdPKyLcUgxfYlTvCAWTrdff+9mCOuIG/uZcooODfCK/yxMsEt9NNCsO1d0+FYEgbkJujZI4BUu1i88FUzLYRMX/N9VvX8K30u+ebgXKW3jr5FdIIZyAFIO+LJXr5N6wZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c7ZGM2t6Dz5PM36;
	Fri, 22 Aug 2025 17:12:43 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 57M9CUbb034508;
	Fri, 22 Aug 2025 17:12:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 22 Aug 2025 17:12:32 +0800 (CST)
Date: Fri, 22 Aug 2025 17:12:32 +0800 (CST)
X-Zmail-TransId: 2afb68a83480351-c9a17
X-Mailer: Zmail v1.0
Message-ID: <20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDAvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGZpbGVzeXN0ZW1zIGRvY3MgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57M9CUbb034508
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 22 Aug 2025 17:12:43 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A8348B.000/4c7ZGM2t6Dz5PM36

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the filesystems docs into Simplified Chinese.
v2->v3
add two patches to the patch set.

Shao Mingyin (5):
Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese

Wang Longjie (2):
Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
Docs/zh_CN: Translate inotify.rst to Simplified Chinese

 .../zh_CN/filesystems/dnotify.rst             |  67 ++++
 .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
 .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
 .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
 .../translations/zh_CN/filesystems/index.rst  |  16 +
 .../zh_CN/filesystems/inotify.rst             |  81 ++++
 .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
 .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
 8 files changed, 985 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst

