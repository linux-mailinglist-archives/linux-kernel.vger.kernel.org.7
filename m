Return-Path: <linux-kernel+bounces-792750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82927B3C87D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D441C24E16
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC40238C29;
	Sat, 30 Aug 2025 06:25:40 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D92869E;
	Sat, 30 Aug 2025 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756535139; cv=none; b=lCRSKi+Dnut2EdgNDjs/XimCbnmTXl0BcCIM0N5sjlvBHZG3tlxcltQoWrDBkfEEwAiilTPCtTHJGzmcqzu6ZQ2FuhDkhXDpttYZb5rRS5vIlae+MPhDizgSpI/bTdaGKyclvR6Nbmtej0PzxPbOKHz1VoZcRjo4GNGI0Pxwe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756535139; c=relaxed/simple;
	bh=0QzAJ7CbvMlIPWm24wLuXvgMoA0rDopHRYVH3zy9GKI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=T7BzNtaSbZxIJjoRDKpQwxihW9bRmJukRXLOyLmJExBilcc/oTJxch4DbFiUF9yOOyukwHlBBoI5Fa3VWwGmp8eDpV2c2+d4kpWbvHs0APt+8adZQvzXXCbV2EFa9kxnl1XZZuoziiBqMWbMpzH/WuGOYWb+8pXin6s8DqCuqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cDQ9V5hx3z5B13X;
	Sat, 30 Aug 2025 14:25:18 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 57U6PHPJ084792;
	Sat, 30 Aug 2025 14:25:17 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 30 Aug 2025 14:25:19 +0800 (CST)
Date: Sat, 30 Aug 2025 14:25:19 +0800 (CST)
X-Zmail-TransId: 2af968b2994fde7-637a8
X-Mailer: Zmail v1.0
Message-ID: <20250830142519085d4aXePTT_pSZ3UTxxNC8X@zte.com.cn>
In-Reply-To: <20250828092655.GA30360@didi-ThinkCentre-M930t-N000>
References: 20250828092655.GA30360@didi-ThinkCentre-M930t-N000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <tiozhang@didiglobal.com>
Cc: <akpm@linux-foundation.org>, <fan.yu9@zte.com.cn>, <corbet@lwn.net>,
        <bsingharora@gmail.com>, <yang.yang29@zte.com.cn>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <tiozhang@didiglobal.com>, <zyhtheonly@gmail.com>,
        <zyhtheonly@yeah.net>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10gZGVsYXlhY2N5L3NjaGVkOiBhZGQgU09GVElSUSBkZWxheQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57U6PHPJ084792
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sat, 30 Aug 2025 14:25:18 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B2994E.000/4cDQ9V5hx3z5B13X

>Intro SOFTIRQ delay, so we can separate softirq as SOFTIRQ delay
>and hardirq as {IRQ - SOFTIRQ} delay.
>
>A typical scenario is when tasks delayed by network,
>if they delayed by rx net packets, i.e, net_rx_action(),
>SOFTIRQ delay is almost same as IRQ delay;
>if they delayed by, e.g, bad driver or broken hardware,
>SOFTIRQ delay is almost 0 while IRQ delay remains big.
>
>Examples tool usage could be found in
>Documentation/accounting/delay-accounting.rst
>
>Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
>---

a small suggestion: it would be clearer if you could include a changelog
when sending a new version of the patch next time. For example:
https://lore.kernel.org/all/20250828171242.59810-1-sj@kernel.org/

Thanks
Yaxin

