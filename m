Return-Path: <linux-kernel+bounces-795494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326FB3F2D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17A64852EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDF26560A;
	Tue,  2 Sep 2025 03:44:18 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFE78F2B;
	Tue,  2 Sep 2025 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784658; cv=none; b=BcCSWHQXR6ywlHaun6OZLQgKT/gOqN/yXD0WYBxPtpIQWTU+1G1O9vLqZ7XT3RjouXCZrlvPU4djSe7Z3Ms34dwZWmvs03tvj+NwFb9XwItrAEgvyUrK+GV44rTlG8J7JFqoZ31nHa3y3iE74rRtjJO53/kpyjZuHf4P4u23bIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784658; c=relaxed/simple;
	bh=7Td2js/qRxOL7z74nUyRRzk8v7klHz83qLHqOA+5Dzg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=P31++pNtBrbPQ6XGUFvZ2RS/9lcdGxXFANQDgQjTQAX61v8pUuFkxgX9jWOpktI2yBN7/y2e9F4013rGBVA63pGkIAMn8EyhuXO+G7LsbU3eZ5z6isD0ExWq2PRVZfNKXsXWTImNu1yDwEsC66rPWBInZkv/jdSTxC+5leP4/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cGBSF0FDtz5BNRd;
	Tue, 02 Sep 2025 11:44:13 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5823hv31092249;
	Tue, 2 Sep 2025 11:43:57 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Sep 2025 11:43:58 +0800 (CST)
Date: Tue, 2 Sep 2025 11:43:58 +0800 (CST)
X-Zmail-TransId: 2af968b667fed26-1e83a
X-Mailer: Zmail v1.0
Message-ID: <20250902114358733xEww2rETcJI37Bc-CrWmL@zte.com.cn>
In-Reply-To: <20250902100353835xyAecL45pVFk1sbaC16f4@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn,20250902100353835xyAecL45pVFk1sbaC16f4@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <wang.yaxin@zte.com.cn>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDIvM10gdG9vbHMvZGVsYXl0b3A6IGFkZCBmbGV4aWJsZSBzb3J0aW5nIGJ5IGRlbGF5IGZpZWxk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5823hv31092249
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 02 Sep 2025 11:44:13 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B6680D.000/4cGBSF0FDtz5BNRd

> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> The original delaytop only supported static output with limited
> interaction. Users had to restart the tool with different command-line
> options to change sorting or display modes, which disrupted continuous
> monitoring and reduced productivity during performance investigations.
> 
> Adds real-time interactive controls through keyboard input:
> 1) Add interactive menu system with visual prompts
> 2) Support dynamic sorting changes without restarting
> 3) Enable toggle of memory verbose mode with 'M' key
> 
> The interactive mode transforms delaytop from a static monitoring tool
> into a dynamic investigation platform, allowing users to adapt the
> view in real-time based on observed performance patterns.
> 
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---
>  tools/accounting/delaytop.c | 112 ++++++++++++++++++++++++++----------
>  1 file changed, 82 insertions(+), 30 deletions(-)

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

