Return-Path: <linux-kernel+bounces-789201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3276B39231
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAB05E2A70
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2204C2494C2;
	Thu, 28 Aug 2025 03:25:55 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6413957E;
	Thu, 28 Aug 2025 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351554; cv=none; b=ehPI1mmM4yTHenDx5febjmIh2Vg01G6/U60ClsglpbrqhcjrUVeGhlCBrzAXOUBGBJCPUiAtKdZI0HzJVmbkSSt61UOOP8bvv5zUTw5x6cz9RfY0oj0RYwOvpvi56M+k5/4EBZSiCL4sxlXF/JICqEC4PJRHEnAukc1XH4UZJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351554; c=relaxed/simple;
	bh=f2i4LSHC/hUl/R34yLBjHku5U+O/hj9AzJhLe1bfchA=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=AUFcJo2oS0yrYKoOkaFgDdJrlKhuicCl1RZoYvyLHmWkFuzizLnInzkpw5EJyq0fxk8QOFkulDg9l7ArOrTLAGME0fNT+OLJtDujYn5B7dy/3GtwKESitHhHbA6+0+nKU/uCpX3DuwiCWIehi7mcvFlmlEz+DP1niS8PUcOAzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cC6HC3yHZz5PM3x;
	Thu, 28 Aug 2025 11:25:43 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 57S3PVHa066321;
	Thu, 28 Aug 2025 11:25:32 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 28 Aug 2025 11:25:33 +0800 (CST)
Date: Thu, 28 Aug 2025 11:25:33 +0800 (CST)
X-Zmail-TransId: 2af968afcc2d6fb-b8d5a
X-Mailer: Zmail v1.0
Message-ID: <202508281125331895CzD27DDDHeU_lCdVEY1F@zte.com.cn>
In-Reply-To: <20250814202950722BAA5h4UtC6XyB2C5YA2pe@zte.com.cn>
References: 20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn,20250814202950722BAA5h4UtC6XyB2C5YA2pe@zte.com.cn
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
Subject: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggMy80IHYyXSBEb2NzL3poX0NOOiBUcmFuc2xhdGUgZ2VuZXJpYy1oZGxjLnJzdCB0byBTaW1wbGlmaWVkIENoaW5lc2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57S3PVHa066321
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 28 Aug 2025 11:25:43 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AFCC37.002/4cC6HC3yHZz5PM3x

> From: Sun yuxi <sun.yuxi@zte.com.cn>
> 
> translate the "generic-hdlc.rst" into Simplified Chinese.
> 
> Update the translation through commit 16128ad8f927
> ("docs: networking: convert generic-hdlc.txt to ReST")
> 
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
> ---
>  .../zh_CN/networking/generic-hdlc.rst         | 176 ++++++++++++++++++
>  .../translations/zh_CN/networking/index.rst   |   2 +-
>  2 files changed, 177 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/networking/generic-hdlc.rst

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

