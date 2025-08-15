Return-Path: <linux-kernel+bounces-770663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162ECB27D96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC497684758
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F62FC872;
	Fri, 15 Aug 2025 09:54:55 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F62D63FF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251695; cv=none; b=EekMxOjhQkTjx1+exMoYpWgCmo7Dn/rus0gC9/hZ+hXGFLUrbVceUAX4xPahbKPt+9YZUsjcdFXSdbXGBd1Aw2q5LwwjHIuNMHY8MlN8dIoSDqlHrBzJVRyQmhUUydquFYY7T96zXa4whI7MK7H668EcDQ0dh8ovmi8hJD/KGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251695; c=relaxed/simple;
	bh=0LqySbXLtpTSbRvcDtyVojBGitShmGy/OP3vs8XlUMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8gz9r9u7+Qydf15aQIMSrb+t1sGa8b3aZmUzMgZAa8XQ2LUgx7mN8vUGpo4Z6pUDBF0+FYcGPvzrrPkLzsujw4r3hPJEuze3E9prOy5agsEqgvF18PmR009WdDU1xwJASCLgkkk49i0p8KLlWbjPMI6wTsUzcRhGQretwkrets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c3HX165c6zYmKJ9;
	Fri, 15 Aug 2025 17:54:41 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 17:54:50 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 17:54:49 +0800
From: wangzijie <wangzijie1@honor.com>
To: <hsiangkao@linux.alibaba.com>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<stopire@gmail.com>, <wangzijie1@honor.com>, <xiang@kernel.org>,
	<zhaoyifan28@huawei.com>
Subject: Re: [PATCH] erofs-utils: avoid redundant memcpy and sha256() for dedupe
Date: Fri, 15 Aug 2025 17:54:49 +0800
Message-ID: <20250815095449.4163442-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
References: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)


> Hi Zijie,
> 
> On 2025/8/15 16:44, wangzijie wrote:
> > We have already use xxh64() for filtering first for dedupe, when we
> > need to skip the same xxh64 hash, no need to do memcpy and sha256(),
> > relocate the code to avoid it.
> > 
> > Signed-off-by: wangzijie <wangzijie1@honor.com>
> 
> Thanks for the patch, it makes sense to me since we only keep one
> record according to xxh64 (instead of sha256) for now:
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Although I think multi-threaded deduplication is more useful, see:
> https://github.com/erofs/erofs-utils/issues/25
> but I'm not sure if you're interested in it... ;-)

Hi Xiang,
Thank you for providing this information, I want to optimize mkfs time with
dedupe option and send this patch. I will find time to research Yifan's demo
of multi-threaded deduplication and try to provide some help.

> Thanks,
> Gao Xiang



