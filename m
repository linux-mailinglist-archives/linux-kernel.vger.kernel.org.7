Return-Path: <linux-kernel+bounces-786515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1CB35ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18237BAD70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49A2BDC00;
	Tue, 26 Aug 2025 11:12:12 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2FE26CE0A;
	Tue, 26 Aug 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206731; cv=none; b=A810bU1sN8iO24vPmMb55dSGzzlWSBhu/eF2oy833yEMpt3NAL/U98sseB+4ZsnBb1OtIdWidfpRVNYUl3pRgvOOstIYpaRpTQWDUWF6dR3wfqcQN9Kt+p6GcBc/J02EP1QfVp21ggtFKybWbUFW6WflvlM6wK6SmuvoNXtbSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206731; c=relaxed/simple;
	bh=F1J8hpFjz9Pm4Hjusb9kBW2sK0yefCcNw80dDnjfr+s=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=lYUQHtgX4wFPCHM9yhr1Lx8nXj857rW0uSr2N6agmPFPfeMW+dqjaVRlTjdoBWxshsdRRXLRc2m5tt3qAQiqc0G2hSIVDe604nH3GLb6KrOO9pqkDWIjjHSs6fZrjw/EiHqyQ357rn5T1LMoKDb4jVhb0pYOf+gqJ+ivecuREZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cB4kD4jj6z8Xs7s;
	Tue, 26 Aug 2025 19:12:04 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 57QAueKE005303;
	Tue, 26 Aug 2025 18:56:40 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 26 Aug 2025 18:56:43 +0800 (CST)
Date: Tue, 26 Aug 2025 18:56:43 +0800 (CST)
X-Zmail-TransId: 2afa68ad92eb4c1-ab524
X-Mailer: Zmail v1.0
Message-ID: <20250826185643235jApHbqi4zaPaZWVy6_Pot@zte.com.cn>
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
        <yang.tao172@zte.com.cn>, <shao.mingyin@zte.com.cn>,
        <wang.longjie1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IDAvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGZpbGVzeXN0ZW1zIGRvY3MgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57QAueKE005303
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 26 Aug 2025 19:12:04 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AD9684.001/4cB4kD4jj6z8Xs7s

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the filesystems docs into Simplified Chinese.
v3->v4
resolve patch damage issues.

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
 .../translations/zh_CN/filesystems/index.rst  |  17 +-
 .../zh_CN/filesystems/inotify.rst             |  80 ++++
 .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
 .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
 8 files changed, 984 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst

