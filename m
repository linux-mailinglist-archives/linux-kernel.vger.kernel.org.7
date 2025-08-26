Return-Path: <linux-kernel+bounces-786373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD6B35900
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304513B6876
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850231280C;
	Tue, 26 Aug 2025 09:33:55 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FF1F5825;
	Tue, 26 Aug 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200835; cv=none; b=mkNwyA6lWKdYAATpFetRwnZV4ulaAyyCUHJrPnpQcA/F9pULJih7KWWQrIflyyML+A/hDEicLzPhVsxwP/wsGb0msNXJxtfubQYI9voVnvokSoOJisbOAQwd3I78uEZVTD0VdGlsSDls0JZDTu2G/bttfv7c0bQu+01hojI30xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200835; c=relaxed/simple;
	bh=y8Tb2M244zZTYaYWizBJcZzccsoEzWxpfuLnGS7gZY4=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Dtk2vj07dVsc+7G8Kb1JsjYMLCv88ZfwM49eRsEaiOrb6yZK3AwsyYBfrXYDHBt8Cj+z6uNVY6EQ9/UALn2DJNNFYgu5EMviDJqAnS6X/ybJ0jWP+nRgY01D6D1oY4elB9LyaX7ixunlif1SkyMbDOBNzaf5IyI+Th1pvrnrEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cB2Xd5xFpz8Xs6y;
	Tue, 26 Aug 2025 17:33:37 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 57Q9XPaJ075252;
	Tue, 26 Aug 2025 17:33:25 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 26 Aug 2025 17:33:27 +0800 (CST)
Date: Tue, 26 Aug 2025 17:33:27 +0800 (CST)
X-Zmail-TransId: 2afa68ad7f67964-43a2f
X-Mailer: Zmail v1.0
Message-ID: <20250826173327601oSOj6wF-lo1Ne_UTeIKau@zte.com.cn>
In-Reply-To: <1be55956-a4f0-4f6f-a930-fab565dbd257@hust.edu.cn>
References: 20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn,1be55956-a4f0-4f6f-a930-fab565dbd257@hust.edu.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dzm91@hust.edu.cn>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAwLzddIERvY3MvemhfQ046IFRyYW5zbGF0ZSBmaWxlc3lzdGVtcyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57Q9XPaJ075252
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 26 Aug 2025 17:33:38 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AD7F71.002/4cB2Xd5xFpz8Xs6y

>> From: Shao Mingyin<shao.mingyin@zte.com.cn>
>>
>> translate the filesystems docs into Simplified Chinese.
>> v2->v3
>> add two patches to the patch set.
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
>
>
>$ b4 am 20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn
>Grabbing thread from 
>lore.kernel.org/all/20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn/t.mbox.gz
>Analyzing 8 messages in the thread
>Looking for additional code-review trailers on lore.kernel.org
>Checking attestation on all messages, may take a moment...
>---
>   [PATCH v3 1/7] Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
>   [PATCH v3 2/7] Docs/zh_CN: Translate ubifs-authentication.rst to 
>Simplified Chinese
>   [PATCH v3 3/7] Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
>   [PATCH v3 4/7] Docs/zh_CN: Translate gfs2-uevents.rst to Simplified 
>Chinese
>   [PATCH v3 5/7] Docs/zh_CN: Translate gfs2-glocks.rst to Simplified 
>Chinese
>   [PATCH v3 6/7] Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
>   [PATCH v3 7/7] Docs/zh_CN: Translate inotify.rst to Simplified Chinese
>---
>Total patches: 7
>---
>Cover: 
>../v3_20250822_shao_mingyin_docs_zh_cn_translate_filesystems_docs_to_simplified_chinese.cover
>  Link: 
>https://lore.kernel.org/r/20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn
>  Base: applies clean to current tree
>        git checkout -b v3_20250822_shao_mingyin_zte_com_cn HEAD
>        git am 
>../v3_20250822_shao_mingyin_docs_zh_cn_translate_filesystems_docs_to_simplified_chinese.mbx
>
>$ git checkout -b v3_20250822_shao_mingyin_zte_com_cn HEAD
>Switched to a new branch 'v3_20250822_shao_mingyin_zte_com_cn'
>
>$ git am 
>../v3_20250822_shao_mingyin_docs_zh_cn_translate_filesystems_docs_to_simplified_chinese.mbx
>Applying: Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
>Applying: Docs/zh_CN: Translate ubifs-authentication.rst to Simplified 
>Chinese
>Applying: Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
>error: corrupt patch at line 80
>Patch failed at 0003 Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
>
>Hi Mingyin,
>
>I cannot apply this patchset to the docs-next branch of lwn or alex 
>kernel tree. Please double check your patchset.
>
>Dongliang Mu
>

Hi Dongliang,

The second fragment of 'PATCH v3 3/7' had a blank line at the end,
which disappeared from the patch obtained through the 'b4' command,
causing 'git am' to detect patch damage. This blank line exists in the
source file as part of the original text in the patch fragment.

This looks like a bug in some process because the patch in the email
I sent had this blank line.

I will send v4 version to avoid this issue

=========patch fragment===========
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index 3c25b39739db..37968fb91f1a 100644
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -28,4 +28,5 @@ Linux Kernel中的文件系统
tmpfs
ubifs
ubifs-authentication
+ gfs2

--
=========patch fragment===========

Shao Mingyin
>>   .../zh_CN/filesystems/dnotify.rst             |  67 ++++
>>   .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
>>   .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
>>   .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
>>   .../translations/zh_CN/filesystems/index.rst  |  16 +
>>   .../zh_CN/filesystems/inotify.rst             |  81 ++++
>>   .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
>>   .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
>>   8 files changed, 985 insertions(+)
>>   create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
>>   create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>>   create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
>>   create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
>>   create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
>>   create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>>   create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs..rst

