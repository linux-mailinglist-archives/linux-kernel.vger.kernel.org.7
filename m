Return-Path: <linux-kernel+bounces-747391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0DB13341
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F6918966DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E161FFC6D;
	Mon, 28 Jul 2025 02:56:39 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA872D052;
	Mon, 28 Jul 2025 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671398; cv=none; b=JZsHYn9Rzja2FEbm//IBAEsY11W5ZHZ9T/KiXPjOilWj04n84qJSu8a+9NaMK3cZEiJkWRDJBf4YNLB2iM7wJuoa80FpJEqXcQdW/Dfw1T9rm3+OvEzQbVfwtFh0OsL3JFHv2l0AxVCg0+PZD0eUE9RLh6cdKc7ykJ9MIoBsE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671398; c=relaxed/simple;
	bh=HgJB8izPuVhSegElgab0W3wZMm4A3SjvxjQMZ6vn/XU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=C5uUuT4wVDv9MjFSjvosgkg5GZ5EIv55wiN8PwMH7lVZoTggf3hoTRiVlhgXNP45ne6qOxJfC903y5MzmOsjNX7Qbt84YFSt4PgcO2JC+00Xj+Ab9hOAuO6oikzV2s5kq3tFO8H58Qk06Ih+eC970KhRTdWNeTBM8TWr3ix3Mpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4br35j5PP9z6FyBx;
	Mon, 28 Jul 2025 10:56:25 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 56S2uAVU080671;
	Mon, 28 Jul 2025 10:56:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 28 Jul 2025 10:56:11 +0800 (CST)
Date: Mon, 28 Jul 2025 10:56:11 +0800 (CST)
X-Zmail-TransId: 2afb6886e6cb3a8-c0ced
X-Mailer: Zmail v1.0
Message-ID: <20250728105611902ENzYOxJcTdsXoAd-8dSZi@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNV3CoMKgRG9jcy96aF9DTjogVHJhbnNsYXRlIHViaWZzLnJzdCB0byBTaW1wbGlmaWVkIENoaW5lc2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56S2uAVU080671
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 28 Jul 2025 10:56:25 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6886E6D9.000/4br35j5PP9z6FyBx

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the "ubifs.rst" into Simplified Chinese.
v1->v2
send patches of one patchset in the same thread.

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

