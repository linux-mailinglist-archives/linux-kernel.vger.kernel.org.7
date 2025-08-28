Return-Path: <linux-kernel+bounces-789198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF7B39229
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3957A460E55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75900248861;
	Thu, 28 Aug 2025 03:22:07 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486B21CC47;
	Thu, 28 Aug 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351327; cv=none; b=sbT1x7KK/ptv6nOQK+eC4esOq68AbXA/D/jrFmOJ8ByB3hNrhM0sSbEzTcpQ2eDkcwGV5GH1Cv/tFwavqVYFcAege2HR5NxCUVNUs8Joz7SrXF3iIOEZJ+iyocvlS9xuYfZnH8TWRxskU/6INH6/ZqTqeM+NPOBdtxnhOaNvzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351327; c=relaxed/simple;
	bh=5VauDm+N+ltpAVqtN3fDkqdIGV7IcHd6P/bB2XRkcMk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=mjWoEiEJbWCe2g6aAAEpBDzIvcne9sGw7FyTM48MUnHc6K4Wth7i9PK2A2tyee3G4kA7NKUrbn1wMxzDF5h53r7Z1cxsVIDNBOM4uATLwrfE2Dwes2wwGb2TXnWy2OY5nskelxDMEiYRDtvshXxlDmYwveehLptCdBjwz8i304U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cC6Bn0HWxz8Xs7F;
	Thu, 28 Aug 2025 11:21:53 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 57S3Leew064219;
	Thu, 28 Aug 2025 11:21:40 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 28 Aug 2025 11:21:41 +0800 (CST)
Date: Thu, 28 Aug 2025 11:21:41 +0800 (CST)
X-Zmail-TransId: 2af968afcb4547c-b2ae1
X-Mailer: Zmail v1.0
Message-ID: <202508281121417419PzF2xb3v1UVXLG05_pdp@zte.com.cn>
In-Reply-To: <20250814201312381TGvjbLkruWW4KHzCZuHCV@zte.com.cn>
References: 20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn,20250814201312381TGvjbLkruWW4KHzCZuHCV@zte.com.cn
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
Subject: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggMS80IHYyXSBEb2NzL3poX0NOOiBUcmFuc2xhdGUgbXB0Y3Atc3lzY3RsLnJzdCB0byBTaW1wbGlmaWVkIENoaW5lc2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57S3Leew064219
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 28 Aug 2025 11:21:53 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AFCB51.000/4cC6Bn0HWxz8Xs7F

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
> 

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

