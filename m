Return-Path: <linux-kernel+bounces-819951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59871B7CDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92075327CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A527A456;
	Wed, 17 Sep 2025 03:54:36 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746126159E;
	Wed, 17 Sep 2025 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081275; cv=none; b=iO4H7qqdT6Q4CXQnViiWCbfCA5Ru6kKImF8N+Vo0hHtabxIYU0fizYirWk2bjnWc5IpCuPSm5jB6qlY+lK5CRWHwrUOWiwbYwclhQNjlAYFXtvmW2oQL9HYP+95/3r38fmF8x+RoQStzueW36XurtvDBh2HZAJeCdjRLhQ8N0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081275; c=relaxed/simple;
	bh=VrY1UoPIDLzL4/7sTCNvCpXw6Lzm0dHvd+Ryq1BOhsQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=LWuO1ldSdGvZkn0rqSAsfD7hm0bf0bsKRVyJGKu3VI9bi4H1ClCtlH5xReW7ebFcwspYjhAprgS/ivjqDgxzF67xF+cm70FVcQGs8fRbK9aEjLS/JLbCnzDLICNldfdwtKsbyPCpt8437ZRRQJ45smWVKld9igrc+8NR8uy0Cqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cRPz11Kfcz5B13f;
	Wed, 17 Sep 2025 11:54:21 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 58H3oubU002266;
	Wed, 17 Sep 2025 11:50:56 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 17 Sep 2025 11:50:57 +0800 (CST)
Date: Wed, 17 Sep 2025 11:50:57 +0800 (CST)
X-Zmail-TransId: 2afc68ca3021687-dcb2d
X-Mailer: Zmail v1.0
Message-ID: <20250917115057635tlnrFBfUcn1C1pBCZ02gN@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHY1IDAvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGZpbGVzeXN0ZW1zIGRvY3MgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58H3oubU002266
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 17 Sep 2025 11:54:21 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CA30ED.000/4cRPz11Kfcz5B13f

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the filesystems docs into Simplified Chinese.
v4->v5
fix some format issues.

Shao Mingyin (5):
Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese

Wang Longjie (2):
Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
Docs/zh_CN: Translate inotify.rst to Simplified Chinese

 .../zh_CN/filesystems/dnotify.rst             |  69 ++++
 .../zh_CN/filesystems/gfs2-glocks.rst         | 211 +++++++++++
 .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
 .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
 .../translations/zh_CN/filesystems/index.rst  |  17 +-
 .../zh_CN/filesystems/inotify.rst             |  80 ++++
 .../filesystems/ubifs-authentication.rst      | 356 ++++++++++++++++++
 .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
 8 files changed, 1000 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst

