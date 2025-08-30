Return-Path: <linux-kernel+bounces-792753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D1B3C889
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0AD5E5F11
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB620485B;
	Sat, 30 Aug 2025 06:30:02 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CC22F764;
	Sat, 30 Aug 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756535402; cv=none; b=RQp9c2mVD/abpG5HE1IJQtBNwaCat5qxu3qI+9EwYQH4024kUelfpDiVbRo2W03dwFs6v/Fz0ABMehXVSxRmLjN8cq5bTVrA2/2hrzPqXNqnaLptV/ZUP06zmDQLXWqPaGFh7Y4T17uHg7fBprTGnOBJThNJml071GUWp8oVy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756535402; c=relaxed/simple;
	bh=YZNhfwZ/t2MyKL3D0dFAq2T1Wp3ECR7VYFeNoeR4fCI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=fkW7UBlPr53GYi1ye8RiyU4rha8lz7yRb/ecF+O3FZfhA9J7jChZrLsh3OXV1NXGgn8e9s0Ttqd/6uXC2V4g0ZByEWAJUgBBc8Pr5qrZxYk5rEdGKatzdciEH7d3Ib5VoVVJNxECz0UOXVZAAm9UK781nhHTQ2I2DPrn/QdHRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cDQGh3z6nz8Xs6w;
	Sat, 30 Aug 2025 14:29:48 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 57U6Th5Y086473;
	Sat, 30 Aug 2025 14:29:43 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 30 Aug 2025 14:29:44 +0800 (CST)
Date: Sat, 30 Aug 2025 14:29:44 +0800 (CST)
X-Zmail-TransId: 2afa68b29a5841a-66dd7
X-Mailer: Zmail v1.0
Message-ID: <20250830142944929e1M6lffs_PwvPfl7J-R1g@zte.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 57U6Th5Y086473
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sat, 30 Aug 2025 14:29:48 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B29A5C.000/4cDQGh3z6nz8Xs6w

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

Reviewed-by: Wang Yaxin <wang.yaxin@zte.com.cn>

Thanks
Yaxin

