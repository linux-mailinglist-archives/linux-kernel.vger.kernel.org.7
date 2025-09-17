Return-Path: <linux-kernel+bounces-819914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2279FB7E0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F993BC061
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554B2F28FB;
	Wed, 17 Sep 2025 03:10:19 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC419C55E;
	Wed, 17 Sep 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758078619; cv=none; b=krHFVbwRhuwVwkhKr8BUuZjUaZSElq/mM6BEot7OsknRfI8RcRlymyR0YKK3nbemx1LlLnzkY/8/h+BU7mAiXm7lAhfhAsFJ4DvrKTPxrAxq4XhUCzbfCUm3kFNBorskw5dizIael3+4QBbSIz5ZE38zNCdxCGQo+AsCSvttXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758078619; c=relaxed/simple;
	bh=HZxuZloRpt5PCb/LxazzOHEuUfWFGj9cJBYKrMaRhXs=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=NF0DW/qXF5VzsDq8k1GYhIXg8Knoq+kyqsozWrnTTIov6+3C1uRLavST9x9Jwv5dHgGauQEcHoCtWNsivSUThucWltAbuBIsASxjQhj5jVcfrTbNAMYK99KpZm7ddBzlMCe0Za8Ev2wscELqKBolnhwhSd06CPJtPIZJyl7JEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cRNzy6pnkz5PM3F;
	Wed, 17 Sep 2025 11:10:06 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 58H39tBh034526;
	Wed, 17 Sep 2025 11:09:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 17 Sep 2025 11:09:56 +0800 (CST)
Date: Wed, 17 Sep 2025 11:09:56 +0800 (CST)
X-Zmail-TransId: 2af968ca268496e-c2e2e
X-Mailer: Zmail v1.0
Message-ID: <20250917110956338Wld0_KzYq21PXolbufuNn@zte.com.cn>
In-Reply-To: <CAJy-Amk5UTE2HN_Pcd5kbvCsa247CZ9sSMNX==itXeJkWuj-NQ@mail.gmail.com>
References: 20250826185643235jApHbqi4zaPaZWVy6_Pot@zte.com.cn,CAJy-Amk5UTE2HN_Pcd5kbvCsa247CZ9sSMNX==itXeJkWuj-NQ@mail.gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <seakeel@gmail.com>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <dzm91@hust.edu.cn>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <wang.longjie1@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAwLzddIERvY3MvemhfQ046IFRyYW5zbGF0ZSBmaWxlc3lzdGVtcyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58H39tBh034526
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 17 Sep 2025 11:10:06 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CA268E.001/4cRNzy6pnkz5PM3F

>Applied! Thanks!
>Alex
>
Hi Alex

Thank you for your review!

Previously, Yanteng gave a review suggestion.

https://lore.kernel.org/all/e0233785-b3da-4bd5-a37f-cf4704c49744@linux.dev/

Additionally, I also noticed that the header of this
patch lacks a fixed format.

https://lore.kernel.org/all/20250826190719682yrVrd5e1DHRXx0-XjI19Y@zte.com.cn/

I am preparing to send a new version to fix the above issue.

Thanks,

Mingyin
><shao.mingyin@zte.com.cn> 于2025年8月26日周二 19:12写道：
>>
>> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>>
>> translate the filesystems docs into Simplified Chinese.
>> v3->v4
>> resolve patch damage issues.
>>
>> Shao Mingyin (5):
>> Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
>> Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
>> Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
>> Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
>> Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese
>>
>> Wang Longjie (2):
>> Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
>> Docs/zh_CN: Translate inotify.rst to Simplified Chinese
>>
>>  .../zh_CN/filesystems/dnotify.rst             |  67 ++++
>>  .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
>>  .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
>>  .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
>>  .../translations/zh_CN/filesystems/index.rst  |  17 +-
>>  .../zh_CN/filesystems/inotify.rst             |  80 ++++
>>  .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
>>  .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
>>  8 files changed, 984 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
>>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
>>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
>>  create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
>>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst

