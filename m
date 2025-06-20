Return-Path: <linux-kernel+bounces-694790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47255AE10C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 03:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7043BDE61
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452AB41C69;
	Fri, 20 Jun 2025 01:33:35 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF013FEE;
	Fri, 20 Jun 2025 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750383214; cv=none; b=URA+IsVObDIhkcQKs9RtwSJNs3PKLa/C7dO3opG/1Y6OFnXDGnIOr5FRoo3Cfm1E2/HD3qb5xg2v5qzvtc4Vn/GhOrT5uw2EUqxTkeXcw76U84mPvTbiqYp5/q2ZHPYV6/IcMei/w6N9bufi40ngSWzw/qq0kvhH41a+qJCKKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750383214; c=relaxed/simple;
	bh=f2aJvLBqSNA3k3NdOoHSKSNBtduxwGhS9Io4QCDYekc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=oABuVFP44duIo30Yb+hHWjduplVuPlwlAr5gqH+0ITFcQHxTTlVNKWR6gwevl/X20TqcKAMNU9q6gleFPuXqjFrhh1lY2qLCGK+/LSmSW6QF43fVBJxJNnaMy+8OgS9Gb/sQGB2RQhHPNio6resAXPzr6MsPNHK5fVRF7Szfvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bNg3Y43JFz5DBq1;
	Fri, 20 Jun 2025 09:33:29 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 55K1XEoQ029149;
	Fri, 20 Jun 2025 09:33:14 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 20 Jun 2025 09:33:15 +0800 (CST)
Date: Fri, 20 Jun 2025 09:33:15 +0800 (CST)
X-Zmail-TransId: 2afa6854ba5b1d4-1bc18
X-Mailer: Zmail v1.0
Message-ID: <202506200933159890YBbryukmf_-JVQoEtvF8@zte.com.cn>
In-Reply-To: <20250619123523.GK1699@horms.kernel.org>
References: 20250619144934348-KObAuS33g0yI9ulIjMjE@zte.com.cn,20250619123523.GK1699@horms.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <horms@kernel.org>
Cc: <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <jiri@resnulli.us>, <linux@treblig.org>,
        <oscmaes92@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXRdIG5ldDogdmxhbjogZml4IGZvcm1hdC10cnVuY2F0aW9uIHdhcm5pbmdzIGluPyByZWdpc3Rlcl92bGFuX2RldmljZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 55K1XEoQ029149
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6854BA69.002/4bNg3Y43JFz5DBq1

> name is passed to alloc_netdev(). Which is a wrapper around alloc_netdev_mqs()
> which includes the following check:
>
>     BUG_ON(strlen(name) >= sizeof(dev->name));
>
> And the size of dev->name is IFNAMSIZ.
>
> So while I am very pleased to see efforts to address format-truncation
> warning - indeed I have made efforts elsewhere to this end myself - I don't
> think we can solve this problem the way you propose.

Thanks for pointing this out! After checking the code again, you're absolutely right - my proposed change could actually cause issues with alloc_netdev_mqs() since the BUG_ON check explicitly enforces the IFNAMSIZ limit.

It's unfortunate that we can't solve the warning this way, but I really appreciate you taking the time to explain the situation clearly. Your patience and attention to detail here are super helpful!

> Also, I suspect any work in this area will not be a bug fix, and
> thus more appropriate to target at net-next rather than net.
>
>     Subject; [PATCH net-next]
>
> And please make sure patches for net or next-next apply against
> their target tree: this patch applies to cleanly to neither.
>
> For more information on process for networking patches please see
> https://docs.kernel.org/process/maintainer-netdev.html

Got it! Thanks again for your guidance on this - I really appreciate you taking the time to explain both the technical details and the proper submission process.

Best regards
Peng

