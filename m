Return-Path: <linux-kernel+bounces-799792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E22B43058
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6B5560A75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EFF283CA3;
	Thu,  4 Sep 2025 03:17:07 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DD139D;
	Thu,  4 Sep 2025 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955827; cv=none; b=p9Z1j0IQ2vbu2t6jPyGJr6aUck9Wep7TqY19gp89wckb4rR288HLYEKlMaQSpjUgzZMkAmGbIZNvU/lkpfNaSBkAh8oR5b0ychv05oVdcowbfqaqXUpwSREhmH0r4MnXXpJWFcv9cxT1/97ud23r40N0NRzxWxis5MB6k9OLRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955827; c=relaxed/simple;
	bh=9Eu/5+tszxbTh3ikTKGYPTx447fBssr/U5scC1x/nNE=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Lfz6o9U9m2Pf/VN6NkJvM4v+J5qI6GzMVF60uZ0/FjHsgggRod8rwasHfcshyAv/VTSxLV7mbzg6zLIpLzIwdgwsnrl88YiYQnjo5FJYo+yC5lMUcapeAH6YO7RJM/mE1HYXJe57htYzJ3GhYVf89+XdSZEYH34M/DbAKeH9+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cHPlp1Pq6z8Xs71;
	Thu, 04 Sep 2025 11:16:54 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5843FjnZ077276;
	Thu, 4 Sep 2025 11:15:45 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 4 Sep 2025 11:15:46 +0800 (CST)
Date: Thu, 4 Sep 2025 11:15:46 +0800 (CST)
X-Zmail-TransId: 2afb68b904621c5-7f083
X-Mailer: Zmail v1.0
Message-ID: <20250904111546690OmuebcWPO9GlbF9QC7wgA@zte.com.cn>
In-Reply-To: <202509021138097501cXkw4xiXiYSWRs8thevi@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn,20250902100030967nPEcUoRRSnruExakQxAIm@zte.com.cn,202509021138097501cXkw4xiXiYSWRs8thevi@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <xu.xin16@zte.com.cn>
Cc: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDEvM10gdG9vbHMvZGVsYXl0b3A6IGFkZCBtZW1vcnkgdmVyYm9zZSBtb2RlIHN1cHBvcnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5843FjnZ077276
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 04 Sep 2025 11:16:54 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B904A6.000/4cHPlp1Pq6z8Xs71

> This feature is very useful to analyze specific delay sources due to memory operations.
> 
> But these shown datas are basically average values rather than min/max, it's not enough
> 
> for debugging delay jitters. Will you add showing min/max values to delaytop in future? 

Hi Xu,
Thanks for the review and the great suggestions!
You’re right, averages alone aren’t enough for diagnosing the sources of delay jitter.
I will work on adding min/max support in the next version.


> I think if users press 'M', delaytop doesn't need to shown CPU/IRQ/IO delays, just show the detailed memory delays.

Good point. When ‘M’ is pressed, the user wants to focus on memory. Showing CPU/IRQ/IO is just noise.
I’ll change the behavior in the next version so that ‘M’ switches to a clean, memory-only view.

Best regards,
Fan Yu

