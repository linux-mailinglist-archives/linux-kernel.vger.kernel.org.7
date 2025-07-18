Return-Path: <linux-kernel+bounces-736545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3BB09E54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A6D16CB01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA42293B7E;
	Fri, 18 Jul 2025 08:49:55 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BD1FECB0;
	Fri, 18 Jul 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828595; cv=none; b=klUeK5DL/rdSwzLh7Y3A306pej9mGegbTILFRVGmwcp1Qlnge7t40Q5XUZ8zM91ekSZ0MtH1cbXUFgQCgKpmIkTVWtHjucPWeJM35BcWcDHC1GYWF19uvgmU8vcQjkmsawr966AutboINM13WQh//cIhT18+xp89DL/5Dk24nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828595; c=relaxed/simple;
	bh=dQUKLmv0b8SNRCE+D8tBV2Y0hFzTOan73ishk3fAWjU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=YhTh/Myf1LvLkdOYAcXQw29dYoM5X8pEFmRVuJrAECc+kfjh7vwGT5Z5nIm3PYm081l7Xiv2iwrSe9JyjCscFFyvIsl6WkkJumc6vu03KmCG64b3lSWLTvvm5aEynt5nRVuQuHW6jVAxgjD3XnZTkGQf5t+TE2ss9yfBLivlCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bk3Pz4Gbtz6G42S;
	Fri, 18 Jul 2025 16:49:43 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 56I8nWgT068184;
	Fri, 18 Jul 2025 16:49:32 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 18 Jul 2025 16:49:34 +0800 (CST)
Date: Fri, 18 Jul 2025 16:49:34 +0800 (CST)
X-Zmail-TransId: 2afb687a0a9e097-b7a3f
X-Mailer: Zmail v1.0
Message-ID: <202507181649341810Ko3RM5-OgAx9p_La6NlZ@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gRG9jcy96aF9DTjogVHJhbnNsYXRlIGZpbGVzeXN0ZW1zIGRvY3MgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56I8nWgT068184
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 18 Jul 2025 16:49:43 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687A0AA7.001/4bk3Pz4Gbtz6G42S

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

