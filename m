Return-Path: <linux-kernel+bounces-792832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A5B3C98C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1213B0E00
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717F24E4C4;
	Sat, 30 Aug 2025 08:57:24 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC853363;
	Sat, 30 Aug 2025 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756544244; cv=none; b=uw0knDRJ2qDFsCZYF6hp//lrGC1aw3YXN74DN8gDnjsUXbSTd0OR/NIchGuKPtodr8x3ZWsuKHIIri5TVNYnClCRasrU1lnXcuDJh7I9Ypmpoc7GoAND8q2Gg2m1flodRgAORsqvUXRIWyiqyuM5LVP93NZqkW0HTmIDj2nDDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756544244; c=relaxed/simple;
	bh=+PJ718pZkHecDJD/niuj71raER0oNdGPCe4aU8cOYt8=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=HzQ4CA+lmHJI6nJ5rNznu9UmUrjYfhRZDZzevg0hfDa/P6vMeREB+ootrH3VyRn5fJhZgX2x2oeeihCig4l+3XLhTKMKWVJQaZVO7Vov+An/PpluN2KgaP1/umPjLC2mBkdB7FqtTkhy7JEmHFq3QLkEZ7a/ZmRw7nYLYwOd5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cDTXq10XKz8Xs72;
	Sat, 30 Aug 2025 16:57:15 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 57U8v9SS059986;
	Sat, 30 Aug 2025 16:57:09 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 30 Aug 2025 16:57:11 +0800 (CST)
Date: Sat, 30 Aug 2025 16:57:11 +0800 (CST)
X-Zmail-TransId: 2afc68b2bce7b0a-fb433
X-Mailer: Zmail v1.0
Message-ID: <2025083016571123360dlV3pxVqfCY35MOQnma@zte.com.cn>
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
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0ggMC80IGxpbnV4IG5leHQgdjNdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBuZXR3b3JraW5nIGRvY3MgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57U8v9SS059986
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sat, 30 Aug 2025 16:57:15 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B2BCEB.000/4cDTXq10XKz8Xs72

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate networking docs to Simplified Chinese

v1->v2:
https://lore.kernel.org/all/20250728153954564ePWG4rm0QdFoq2QGWUGlt@zte.com.cn/
https://lore.kernel.org/all/CAD-N9QW7=frNYSJDhaUiggSF9p_v33R8BQ0t8vypWUCXO+pyZQ@mail.gmail.com/
1. resend by plain text.
2. remove unneccessary empty line in subject.

v2->v3:
1. add reviewer tag

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

