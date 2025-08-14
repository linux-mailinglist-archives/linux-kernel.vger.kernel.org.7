Return-Path: <linux-kernel+bounces-768756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4AB26517
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951DD7BCBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC772FCC16;
	Thu, 14 Aug 2025 12:11:49 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46428504B;
	Thu, 14 Aug 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173509; cv=none; b=TsIivcikQHnqMRbFoi7pILxV2qrOIZH3zZfWAhcXBSJu+CluMzeMwQ0qMOKmHTuUMJFjJtshs1+9KYeW5buA3jEoEBxUWMcp75D0Jarb6KKUsqgYIQhYAnCG10CoHLFSsh+tJxqDz8mdx1QxhlJjNzJQ21RYG6wwbzWg2sY4Dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173509; c=relaxed/simple;
	bh=8u9RP2xh/1X5QpQ/eJnsBhp/8hmSeMReZKli+xcbNVY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=RKM6j+IV3IFTDinjWHMtthikifmLd9wDUltcGPKphj2e6zjK34Wovk8eUiPi1PjukMG5Ox7kE8aYy/jdUaFy9fZ9SkvjSUJaJEfM7eFvEODBcTwnttPFgGoivq2IEPlBYR+30aFHgM+nqPg8+Y+QC1e+NdUcSaauYsz3Nzgd1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c2kcY3dDjz5H1s9;
	Thu, 14 Aug 2025 20:11:41 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 57ECBQvP076334;
	Thu, 14 Aug 2025 20:11:26 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 14 Aug 2025 20:11:29 +0800 (CST)
Date: Thu, 14 Aug 2025 20:11:29 +0800 (CST)
X-Zmail-TransId: 2afb689dd271ffffffffc4a-3b075
X-Mailer: Zmail v1.0
Message-ID: <20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIDAvNCBsaW51eCBuZXh0IHYyXSBEb2NzL3poX0NOOiBUcmFuc2xhdGUgbmV0d29ya2luZyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57ECBQvP076334
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 14 Aug 2025 20:11:41 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 689DD27D.000/4c2kcY3dDjz5H1s9

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate networking docs to Simplified Chinese

v1->v2:
https://lore.kernel.org/all/20250728153954564ePWG4rm0QdFoq2QGWUGlt@zte.com.cn/
https://lore.kernel.org/all/CAD-N9QW7=frNYSJDhaUiggSF9p_v33R8BQ0t8vypWUCXO+pyZQ@mail.gmail.com/
1. resend by plain text.
2. remove unneccessary empty line in subject.

Sun yuxi (2):
  Docs/zh_CN: Translate mptcp-sysctl.rst to Simplified Chinese
  Docs/zh_CN: Translate generic-hdlc.rst to Simplified Chinese

Wang Yaxin (2):
  Docs/zh_CN: Translate skbuff.rst to Simplified Chinese
  Docs/zh_CN: Translate timestamping.rst to Simplified Chinese

 .../zh_CN/networking/generic-hdlc.rst         | 176 +++++
 .../translations/zh_CN/networking/index.rst   |   8 +-
 .../zh_CN/networking/mptcp-sysctl.rst         | 139 ++++
 .../translations/zh_CN/networking/skbuff.rst  |  44 ++
 .../zh_CN/networking/timestamping.rst         | 674 ++++++++++++++++++
 5 files changed, 1037 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/networking/generic-hdlc.rst
 create mode 100644 Documentation/translations/zh_CN/networking/mptcp-sysctl.rst
 create mode 100644 Documentation/translations/zh_CN/networking/skbuff.rst
 create mode 100644 Documentation/translations/zh_CN/networking/timestamping.rst

-- 
2.25.1

