Return-Path: <linux-kernel+bounces-789203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C50B39234
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBBD1C23A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6076C2494C2;
	Thu, 28 Aug 2025 03:28:15 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2521171D;
	Thu, 28 Aug 2025 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351695; cv=none; b=ndEUUSTvvHOaEWWvvvcIbgKJaiZOYF4XTDDDq0+CoeDrxw4VAep3twlT84ueBfqFupmjBu+rgt97A32o4av4HLPBUgs6z7wj+tqYuTLNvK31YqGIImOuYfndJXAEqH1PBicUnWEQPkUjl4MGz7JXN2X7UPm1NFcgR781CujbTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351695; c=relaxed/simple;
	bh=vWT0vrcOJ51bj0i0t0ohp1YwUgvZjAG2sI8ZvQQnGRg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=sMf66lyytW3UX/V2odU0QrN6VPoJ3NsMbPq3U7jHxauqi2/utQUn/CPw7LFKiXRUOKVyzH+8t2wk/sfJ0VHa46zZJPYTpBGZvkMIr62t2uGLwXq45oI82sBOzT9ofF2nNFe7FAogrfxyv7qiPSHBbZHgJfODgSxmyW0Vqp2bvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cC6L23C0fz5PM37;
	Thu, 28 Aug 2025 11:28:10 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 57S3RovQ072338;
	Thu, 28 Aug 2025 11:27:50 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 28 Aug 2025 11:27:51 +0800 (CST)
Date: Thu, 28 Aug 2025 11:27:51 +0800 (CST)
X-Zmail-TransId: 2afa68afccb7355-bd9af
X-Mailer: Zmail v1.0
Message-ID: <20250828112751947nPp0i9WwI02rU1BNa3FTt@zte.com.cn>
In-Reply-To: <20250814203052841vWATRXU4pnku526u5TwPn@zte.com.cn>
References: 20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn,20250814203052841vWATRXU4pnku526u5TwPn@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <wang.yaxin@zte.com.cn>, <alexs@kernel.org>
Cc: <wang.yaxin@zte.com.cn>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzQgdjJdIERvY3MvemhfQ046IFRyYW5zbGF0ZSB0aW1lc3RhbXBpbmcucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57S3RovQ072338
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 28 Aug 2025 11:28:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AFCCCA.000/4cC6L23C0fz5PM37

> From: Wang Yaxin <wang.yaxin@zte.com.cn>
> 
> translate the "timestamping.rst" into Simplified Chinese.
> 
> Update the translation through commit d5c17e36549c
> ("docs: networking: timestamping: improve stacked PHC sentence")
> 
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
> ---
>  .../translations/zh_CN/networking/index.rst   |   2 +-
>  .../zh_CN/networking/timestamping.rst         | 674 ++++++++++++++++++
>  2 files changed, 675 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/networking/timestamping.rst

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

