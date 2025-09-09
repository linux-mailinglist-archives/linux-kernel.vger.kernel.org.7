Return-Path: <linux-kernel+bounces-807029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F3B49F19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA387AC6AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E59E2441B8;
	Tue,  9 Sep 2025 02:20:38 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBB235057;
	Tue,  9 Sep 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384437; cv=none; b=o1aqeB/ssZiqqLRElfeHYhclJCwlLr4PAlXeVCIqP1scKWC2gK1wXVG1On+8rWjzVf11l1weCtgWfUnPGPsSv1LPlqH+yOcvYwZOPgiTT7c09BHkT/kI5ZHqH6qGhUSJDtEjyX17vh5f08+EnYVW9rgDkSzXfW00J1rFE+zpU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384437; c=relaxed/simple;
	bh=K3qINbirh6FDIbTYUhLVpKdmK8G3sNMs6+rri6XXFTk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=D93IFzZKtlM8pE664RT5iSxqF+6+rtmDiB08BwKwn8UuCNUb2WcX83C8wt2kfZaALsr+i44qOxeBMqdqOigBsLLT2CHGUReafstEmRjusYKln+zfG3RPlgX001HxY54xJ00qyfVMkWnUZQag17yI4DHaT8sM9PAzl/HshdBcwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cLSGR6Js3z8Xs6w;
	Tue, 09 Sep 2025 10:20:31 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5892KBMP039301;
	Tue, 9 Sep 2025 10:20:11 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 9 Sep 2025 10:20:12 +0800 (CST)
Date: Tue, 9 Sep 2025 10:20:12 +0800 (CST)
X-Zmail-TransId: 2afc68bf8edc5ff-979be
X-Mailer: Zmail v1.0
Message-ID: <20250909102012483SxyAVZnrCtXCkrr-tphl9@zte.com.cn>
In-Reply-To: <20250907001338580EURha20BxWFmBSrUpS8D1@zte.com.cn>
References: 20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn,20250907001338580EURha20BxWFmBSrUpS8D1@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <wang.yaxin@zte.com.cn>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYyIGxpbnV4LW5leHQgMy81XSB0b29scy9kZWxheXRvcDogYWRkIGludGVyYWN0aXZlIG1vZGUgd2l0aCBrZXlib2FyZCBjb250cm9scw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5892KBMP039301
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 09 Sep 2025 10:20:31 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BF8EEF.001/4cLSGR6Js3z8Xs6w

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
>  tools/accounting/delaytop.c | 166 ++++++++++++++++++++++++++----------
>  1 file changed, 121 insertions(+), 45 deletions(-)

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

