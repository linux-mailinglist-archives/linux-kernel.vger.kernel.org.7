Return-Path: <linux-kernel+bounces-789200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A29FB3922C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5596861C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4B248896;
	Thu, 28 Aug 2025 03:24:20 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49321CC47;
	Thu, 28 Aug 2025 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351460; cv=none; b=Zz3NchdkC0Y5Su/N6gUWSqkQFtZ+e3iW5IhIKkEcy4XDB7rzDLzh7cbN567Ueh5wHNXoEwcHRIq37pqGFdS7kFem6I3mXp5/7pwsdUObtBFvJ5EFqpjTboj3Tu8k+Ig3D1u+1EVH/OG8UGBUJMNXwnSQGg4rGFJ96O4o2Wozx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351460; c=relaxed/simple;
	bh=4RcqQLHswlTWOEIsnEQYJrVLEdZT+mCVdT3PsDpvn5E=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=sn01POw2K1rv+Ail9syTs5bOb83Vy7A1WBef0hXQqTJpTJQWdaJ0hdr60x4RKuWByCtDYNty/eQ0P8W75r/oTCWfUUstmhnoiuypHZdIyU0rk8n2Km2rgK7OxuUyfUBPfufyN9lvTHpHpgb9FRP7FysqpBYH6JjRFS6tJfxRLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cC6FT2DG9z4xPSW;
	Thu, 28 Aug 2025 11:24:13 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 57S3Nt3U067115;
	Thu, 28 Aug 2025 11:23:55 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 28 Aug 2025 11:23:56 +0800 (CST)
Date: Thu, 28 Aug 2025 11:23:56 +0800 (CST)
X-Zmail-TransId: 2af968afcbccd32-b6394
X-Mailer: Zmail v1.0
Message-ID: <20250828112356651HroBTX3mMeZ-LvKlHIbCJ@zte.com.cn>
In-Reply-To: <202508142028407445nvZxgf2l-bOvTMm2v-zs@zte.com.cn>
References: 20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn,202508142028407445nvZxgf2l-bOvTMm2v-zs@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <wang.yaxin@zte.com.cn>, <alexs@kernel.org>, <si.yanteng@linux.dev>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzQgdjJdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBza2J1ZmYucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57S3Nt3U067115
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 28 Aug 2025 11:24:13 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AFCBDD.000/4cC6FT2DG9z4xPSW

> From: Wang Yaxin <wang.yaxin@zte.com.cn>
> 
> translate the "skbuff.rst" into Simplified Chinese.
> 
> Update the translation through commit 9facd94114b5
> ("skbuff: render the checksum comment to documentation")
> 
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
> ---
>  .../translations/zh_CN/networking/index.rst   |  2 +-
>  .../translations/zh_CN/networking/skbuff.rst  | 44 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/networking/skbuff.rst

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

