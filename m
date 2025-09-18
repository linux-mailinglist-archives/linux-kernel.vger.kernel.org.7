Return-Path: <linux-kernel+bounces-822295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79249B8378D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596107B8B98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF92F362C;
	Thu, 18 Sep 2025 08:07:32 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376692F361F;
	Thu, 18 Sep 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182852; cv=none; b=m6jZnZCg88CjR4tJRhE7YmJEGKizC8o2gxroyNfkOakc7wWd+bsEoMQw9SmCNmOmKNSGt1FunyuBNzQF663peIN/fIw0svHPr0kK2npKNQbtMF3/w5XWWBZP1veshVCHZWpqRvSeVSf1D/1VvundzqxiTqjIoKxcb/X4HhCXU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182852; c=relaxed/simple;
	bh=5C/zUI2mvijNoFYMZi0qP58OmtRj986jYrloLiokaF8=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=JRsk8ctjpwc9t4AQuTbd+tgAYIzCApcbC1/NwXculRpffdkPn0cRKFx1ZpnASEz8/qk9w20YYzH7wO/gcrPbkvbsEM9LBy+ZbZymzRF1hp3E7rEk8jG+VlaRgn4WPTx2SuIF5MNgjxSjxDav8WpJaCVuk45Nb2duydzA4ExQksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cS7Xb45HWz5BNRd;
	Thu, 18 Sep 2025 16:07:27 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 58I86xx7044585;
	Thu, 18 Sep 2025 16:06:59 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 18 Sep 2025 16:07:01 +0800 (CST)
Date: Thu, 18 Sep 2025 16:07:01 +0800 (CST)
X-Zmail-TransId: 2afc68cbbda5867-c352e
X-Mailer: Zmail v1.0
Message-ID: <20250918160701503LAL5d3yUvPccri9n1foeC@zte.com.cn>
In-Reply-To: <CAJy-AmnK2fFJeoRzUXp7tME6HVYeGJreuXLSecnQLAr=SNzE5w@mail.gmail.com>
References: CAJy-Amk5UTE2HN_Pcd5kbvCsa247CZ9sSMNX==itXeJkWuj-NQ@mail.gmail.com,20250917110956338Wld0_KzYq21PXolbufuNn@zte.com.cn,CAJy-AmnK2fFJeoRzUXp7tME6HVYeGJreuXLSecnQLAr=SNzE5w@mail.gmail.com
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
X-MAIL:mse-fl2.zte.com.cn 58I86xx7044585
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 18 Sep 2025 16:07:27 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CBBDBF.000/4cS7Xb45HWz5BNRd

>> >Applied! Thanks!
>> >Alex
>> >
>> Hi Alex
>>
>> Thank you for your review!
>>
>> Previously, Yanteng gave a review suggestion.
>>
>> https://lore.kernel.org/all/e0233785-b3da-4bd5-a37f-cf4704c49744@linux.dev/
>>
>> Additionally, I also noticed that the header of this
>> patch lacks a fixed format.
>>
>> https://lore.kernel.org/all/20250826190719682yrVrd5e1DHRXx0-XjI19Y@zte.com.cn/
>>
>> I am preparing to send a new version to fix the above issue.
>
>Good. I have picked v4 on
>https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git/log/?h=docs-next,
>could you do me a favor to send a fix base the branch?
>
>Thanks
I have sent 3 fix patch.

1.
https://lore.kernel.org/all/20250918151349743KS4zJHQOoG-yPHSeAY3dv@zte.com.cn/
2.
https://lore.kernel.org/all/20250918143643417OPRH_RjCXkCa3aCtQEX3Y@zte.com.cn/
3.
https://lore.kernel.org/all/202509181556503857h2V0skOmjONfEzUrZ-ok@zte.com.cn/

Thanks.

Mingyin
>
>>
>> Thanks,
>>
>> Mingyin
>> ><shao.mingyin@zte.com.cn> 于2025年8月26日周二 19:12写道：
>> >>
>> >> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>> >>
>> >> translate the filesystems docs into Simplified Chinese.
>> >> v3->v4
>> >> resolve patch damage issues.
>> >>
>> >> Shao Mingyin (5):
>> >> Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
>> >> Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
>> >> Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
>> >> Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
>> >> Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese
>> >>
>> >> Wang Longjie (2):
>> >> Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
>> >> Docs/zh_CN: Translate inotify.rst to Simplified Chinese
>> >>
>> >>  .../zh_CN/filesystems/dnotify.rst             |  67 ++++
>> >>  .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
>> >>  .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
>> >>  .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
>> >>  .../translations/zh_CN/filesystems/index.rst  |  17 +-
>> >>  .../zh_CN/filesystems/inotify.rst             |  80 ++++
>> >>  .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
>> >>  .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
>> >>  8 files changed, 984 insertions(+), 1 deletion(-)
>> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
>> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
>> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
>> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
>> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs..rst

