Return-Path: <linux-kernel+bounces-820008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8639B7F09F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B301B27B73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED3269D18;
	Wed, 17 Sep 2025 05:54:33 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB261C5F23;
	Wed, 17 Sep 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088473; cv=none; b=Vo9C7lB478ATlYV8trptZAXaMkN0SAXWCXm2i57DwoFpLRFLELsKKiMsvZR21HrJn7aFjJd68/2Hjs2FiHkUrOIydaQ/yK99ERq0wxSJBgW1K5mmT7Rz9VHzM4qLiq7Fi35j1tyUvBUW9ntYw52y/fz+BQmwwRXOGfB2lZDs2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088473; c=relaxed/simple;
	bh=TwCv6bzdZDLeUZWiv23q5m5XfYyJqs8o+xLOs7zk1qA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=uG5TYsEUUW/E56zgQBgixcS3lbGf+iT8I5OTJzQSCKVg3Zw7Oo0no1PuSzEhrFNy22yA+DkjefzaEq8jMjgKIw+2UXFGTDGXtDXgOHWynQyHE5Ei8A8ZPONKcwW8oozK/M3il5V7k67ZtJqGSgbhOHmSjU8ULoreMjItzyIOJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cRSdb179xz5PM35;
	Wed, 17 Sep 2025 13:54:27 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 58H5s45v037168;
	Wed, 17 Sep 2025 13:54:04 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 17 Sep 2025 13:54:06 +0800 (CST)
Date: Wed, 17 Sep 2025 13:54:06 +0800 (CST)
X-Zmail-TransId: 2afc68ca4cfe3be-6a7d7
X-Mailer: Zmail v1.0
Message-ID: <20250917135406432vKZ2pELx-bRkvOdfP10Zb@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IGxpbnV4IG5leHQgMC80XSBEb2NzL3poX0NOOiBUcmFuc2xhdGUgbmV0d29ya2luZyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58H5s45v037168
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 17 Sep 2025 13:54:27 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CA4D13.000/4cRSdb179xz5PM35

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate networking docs to Simplified Chinese

v1->v2:
https://lore.kernel.org/all/20250728153954564ePWG4rm0QdFoq2QGWUGlt@zte.com.cn/
https://lore.kernel.org/all/CAD-N9QW7=frNYSJDhaUiggSF9p_v33R8BQ0t8vypWUCXO+pyZQ@mail.gmail.com/
1. resend by plain text.
2. remove unneccessary empty line in subject.

v2->v3:
1. add reviewer tag

v3->v4:
1.fix misalignment problem in title

Sun yuxi (2):
  Docs/zh_CN: Translate mptcp-sysctl.rst to Simplified Chinese
  Docs/zh_CN: Translate generic-hdlc.rst to Simplified Chinese

Wang Yaxin (2):
  Docs/zh_CN: Translate skbuff.rst to Simplified Chinese
  Docs/zh_CN: Translate timestamping.rst to Simplified Chinese

 .../zh_CN/networking/generic-hdlc.rst         | 172 +++++
 .../translations/zh_CN/networking/index.rst   |   8 +-
 .../zh_CN/networking/mptcp-sysctl.rst         | 139 ++++
 .../translations/zh_CN/networking/skbuff.rst  |  44 ++
 .../zh_CN/networking/timestamping.rst         | 674 ++++++++++++++++++
 5 files changed, 1033 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/networking/generic-hdlc.rst
 create mode 100644 Documentation/translations/zh_CN/networking/mptcp-sysctl.rst
 create mode 100644 Documentation/translations/zh_CN/networking/skbuff.rst
 create mode 100644 Documentation/translations/zh_CN/networking/timestamping.rst

-- 
2.25.1

