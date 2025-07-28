Return-Path: <linux-kernel+bounces-747601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D87DB135CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8949C3B687F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669022156A;
	Mon, 28 Jul 2025 07:40:14 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3F2165EC;
	Mon, 28 Jul 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688414; cv=none; b=GI1eMUhrXcx1UqG7xOjwuEK5ro6rvGUX2woPkyld1PtGjfOqUSVd/srHJlW3cMBwIMzPlUoZiCc63UkCJJW2uuMHlYxn+WQJjR0JBKY24B978qt3UyCu81lM5B/6y1FmY0LcPBDow+rDJZzfTcnysWRw0PgxdGpy4108phqYnks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688414; c=relaxed/simple;
	bh=LAKNjsJYrzlFjAwmnO/emrhwwtJVO/P6Vp4XhQiV1iU=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=PLhBx0+zJyWPCxVP45dmlrRRyqifuRM59CeXcx6QYPqpEkel0Y0naagEXgJLipYIauysMS01bLvC/6QZuc8vwoW+7C8XL4P1gw9jTbU3w8XvmEkOMHkMQEb3ljvFdoMjQntXB65HRm/NNIFdb3wfkyVu8pPivyj+i6dISyI3DPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4br9P11rkBz8Xs70;
	Mon, 28 Jul 2025 15:40:05 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 56S7dqWt088856;
	Mon, 28 Jul 2025 15:39:52 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 28 Jul 2025 15:39:54 +0800 (CST)
Date: Mon, 28 Jul 2025 15:39:54 +0800 (CST)
X-Zmail-TransId: 2af96887294affffffffc29-643cd
X-Mailer: Zmail v1.0
Message-ID: <20250728153954564ePWG4rm0QdFoq2QGWUGlt@zte.com.cn>
In-Reply-To: <20250722171105251YZi7zdexFaeEVQIj2iYZq@zte.com.cn>
References: 20250722171105251YZi7zdexFaeEVQIj2iYZq@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <sun.yuxi@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?562U5aSNOiBEb2NzL3poX0NOOiBUcmFuc2xhdGUKCiBuZXR3b3JraW5nIGRvY3MgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56S7dqWt088856
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 28 Jul 2025 15:40:05 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68872955.001/4br9P11rkBz8Xs70

The content of these patches is okay, except for some formatting issues.

There are some issues as follows:
1) The subject includes some Chinese characters, need to be fixed.
2) Your email sending setting takes *Attachment*, make sure that's cleared.


Cheers,
Xu Xin

