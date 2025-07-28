Return-Path: <linux-kernel+bounces-747930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3ABB13A61
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725C51656C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA53264625;
	Mon, 28 Jul 2025 12:20:24 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38D33E7;
	Mon, 28 Jul 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705224; cv=none; b=aTm0n/2duq5B3GVbVY8stwkp2JsAAk6h3bKqWUS2AVqZNOixKjdVx9338p5fcR1EuTphdWGvINF/tpzH97vd4AacIKZ9H/v2VD82oe0RW9MttH+fCCfv8mRE8tIC8VEcpCZr9iLnWRt2E/HovorVxTRfk01odX6N1dcQu1EBPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705224; c=relaxed/simple;
	bh=49AIUiPRQLgQDz1bat70GoFzqIYDMTIQwOfb+M8u3bA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=QKoGQD3O5lwh1j7+t3UgeCUouyYq30E9gaF0o6WoCDp0Ya5c0cmNWN125vKT5xibiJ9m/YaxAk26AmSFthFw4lUsUqpS9JFz/B3dAtZWUxdIblWazEphycs68g814xpxjYOVfxsiswKhhBPTDXHg1he4mfAFZkhVhpuQTC5CewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4brHcF2KKfz4x6CZ;
	Mon, 28 Jul 2025 20:20:13 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 56SCK8cQ007887;
	Mon, 28 Jul 2025 20:20:08 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 28 Jul 2025 20:20:11 +0800 (CST)
Date: Mon, 28 Jul 2025 20:20:11 +0800 (CST)
X-Zmail-TransId: 2af968876afbffffffff90c-fff15
X-Mailer: Zmail v1.0
Message-ID: <20250728202011488UJjveTBjJXYNXh48cBuXs@zte.com.cn>
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
        <zhang.yunkai@zte.com.cn>, <sun.yuxi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDAvNCBsaW51eCBuZXh0IFJFU0VORF0gRG9jcy96aF9DTjogVHJhbnNsYXRlCgogbmV0d29ya2luZyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56SCK8cQ007887
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 28 Jul 2025 20:20:13 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68876AFD.001/4brHcF2KKfz4x6CZ

From: Wang Yaxin <wang.yaxin@zte.com.cn>

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

