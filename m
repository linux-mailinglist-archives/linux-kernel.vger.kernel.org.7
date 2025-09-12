Return-Path: <linux-kernel+bounces-813331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F18ADB543A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A247A6104
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F92BEFFD;
	Fri, 12 Sep 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GXD9bTOT"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55E215198
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661529; cv=none; b=hWimrhKJIl9fIFlvK+laQDipfFV/rmXVhsauxiBlMjRG7qLX5213oCGyio8vp2BNwb0ZnnYAaxvHoMlkcEPoXULAAwQgOHfrXdoCYDherYNKK0jVP27BacnNy99A4hsCkhGfkrbNHJ/zf//qHbtIOBylBMeL7aUM75SwIFQHrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661529; c=relaxed/simple;
	bh=peTxhAGR3daZzAvmzW9ww+hbnMcaEKjQQIT5Cf0Fs4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3iIQ2w+T0KkT+xBjb8/zIkv/vpqaR2we9jZKeygPI9SzXweZZvb82F6HseB7v0P7CHQMzwyGt1Gcx2FND57VRr6834nuRNyxTSoCf5lCMwXZmQGjrI2gOymzkcMGbRxUM7ixKPZb4T+EpCSL4MUaDRL43e1bvgDZBlGWlb+VXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GXD9bTOT; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0233785-b3da-4bd5-a37f-cf4704c49744@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757661524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iXw6E6rNRdpErP2hR22iowIPCSBgYh4iueuVgcUD50=;
	b=GXD9bTOTXs/tqINexb/e7Ts6tlvZPk9wT8DJZndnWkzFXfbeLocLwBcr5d+VMxQx5cuipl
	xHpx2ILkAReuDKrj1PddLk1qOqkSFfQ1I0mHlyaoBzSIAygDNBTZjmO1ngOIeqbCLxG0JV
	AWFLK4jt2arOa8uFiM694mNfV3qbxRM=
Date: Fri, 12 Sep 2025 15:18:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/7] Docs/zh_CN: Translate ubifs.rst to Simplified
 Chinese
To: shao.mingyin@zte.com.cn
Cc: alexs@kernel.org, dzm91@hust.edu.cn, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, yang.tao172@zte.com.cn,
 wang.longjie1@zte.com.cn
References: <20250826190102126qyDear85W7BATchttuUUL@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250826190102126qyDear85W7BATchttuUUL@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 8/26/25 7:01 PM, shao.mingyin@zte.com.cn 写道:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> translate the "ubifs.rst" into Simplified Chinese.
>
> Update to commit 5f5cae9b0e81("Documentation: ubifs: Fix
> compression idiom")
>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> Signed-off-by: yang tao <yang.tao172@zte.com.cn>
> ---
> v3->v4
> resolve patch damage issues.
>   .../translations/zh_CN/filesystems/index.rst  |   2 +-
>   .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++++++++++++++
>   2 files changed, 115 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst
>
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
> index 9f2a8b003778..6049b599dec8 100644
> --- a/Documentation/translations/zh_CN/filesystems/index.rst
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -26,4 +26,4 @@ Linux Kernel中的文件系统
>      virtiofs
>      debugfs
>      tmpfs
> -
> +   ubifs
> diff --git a/Documentation/translations/zh_CN/filesystems/ubifs.rst b/Documentation/translations/zh_CN/filesystems/ubifs.rst
> new file mode 100644
> index 000000000000..16c28bfd6fc3
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/ubifs.rst
> @@ -0,0 +1,114 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/filesystems/ubifs.rst
> +
> +:翻译:
> +
> +   邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
> +
> +:校译:
> +
> +   - 杨涛 yang tao <yang.tao172@zte.com.cn>
> +
> +============
> +UBI 文件系统
> +============
> +
> +简介
> +============

Alignment required here.


It is noticed that ZTE Email has been translating kernel

documents for a long time, which is highly admirable.

Against this background, I believe most of you are

familiar with translation standards and capable of

reviewing Chinese translations. I hope you can review

each other's work, especially when new members join

in—help them and assist them in getting familiar with

the entire process.


Thanks,

Yanteng


