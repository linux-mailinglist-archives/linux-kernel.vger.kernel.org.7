Return-Path: <linux-kernel+bounces-736564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C787EB09E96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B541317369E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6C2957C6;
	Fri, 18 Jul 2025 09:03:07 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447CD29552B;
	Fri, 18 Jul 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829387; cv=none; b=LOV4vG748jEz3f54zFD774EDh0nVAw3ROL0x4ZB7azM9xypft+0ZDmLNJ70rKq+RwdlRZfrMUnZnWHrAYHS2TpTYQr7sTTbYmffvbmHM8+WdrUSyeDfomxo74zhYzVU4uikr8ZpidE2f3eyc8u5TmGqdHWC9NB4jDPKoMG1hxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829387; c=relaxed/simple;
	bh=fkFTFGJf8jIkEGGq7S1TnG5/NxabZMAmvVfJR0zbBxE=;
	h=Date:Message-ID:References:Mime-Version:From:To:Cc:Subject:
	 Content-Type; b=aLijSAv/9P3ADOVN/JkBqevz/tSunw2YymS0slvI22CtzSAlKwJNUmxnalF4sFmx/ozEJXYNh/eyCflxAE12OTsa2GZN7KQf5w7uTn4cu3AN+22mdr21PXqTOnIghOvzcaOFd7eyS3xPiGAHj220CbQpC6g7U9ZoYBJxiGhCxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bk3jH3Gm1z8Xs72;
	Fri, 18 Jul 2025 17:02:59 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 56I92ojh088959;
	Fri, 18 Jul 2025 17:02:50 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 18 Jul 2025 17:02:52 +0800 (CST)
Date: Fri, 18 Jul 2025 17:02:52 +0800 (CST)
X-Zmail-TransId: 2afb687a0dbcffffffff8b3-cf244
X-Mailer: Zmail v1.0
Message-ID: <20250718170252644KCodnbedh8sY1HAK2znBA@zte.com.cn>
References: 20250718164409239V6nK4AbfOlggzTHSQMeIT@zte.com.cn
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
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwLzRdIERvY3MvemhfQ046IFRyYW5zbGF0ZcKgZmlsZXN5c3RlbXMgZG9jcyB0byBTaW1wbGlmaWVkIENoaW5lc2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56I92ojh088959
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 18 Jul 2025 17:02:59 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687A0DC3.001/4bk3jH3Gm1z8Xs72

>From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
In the title of this patch, I mistakenly wrote "0/4" instead of "0/5".
I have resent the correct patch.
>translate filesystems docs to Simplified Chinese
>
>Shao Mingyin (5):
>Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
>Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
>Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
>Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
>Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese
>
>.../zh_CN/filesystems/gfs2-glocks.rst | 199 ++++++++++
>.../zh_CN/filesystems/gfs2-uevents.rst | 97 +++++
>.../translations/zh_CN/filesystems/gfs2.rst | 57 +++
>.../translations/zh_CN/filesystems/index.rst | 5 +
>.../filesystems/ubifs-authentication.rst | 354 ++++++++++++++++++
>.../translations/zh_CN/filesystems/ubifs.rst | 114 ++++++
>6 files changed, 826 insertions(+)
>create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
>create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
>create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst
>
>--
>2.25.1

