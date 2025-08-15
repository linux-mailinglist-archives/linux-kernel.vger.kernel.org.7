Return-Path: <linux-kernel+bounces-770555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F005AB27C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA060434C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9402D0C71;
	Fri, 15 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CBjg82A9"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C72BE7A5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248690; cv=none; b=G0adAxlCZ4y1MwJvc/UoKEs8AJjh3ku79hgp8NqglAVkjbBm8eahRyUw8FfQ7Z1afwWpramiuL6ncNLDl6o3h5EvthePxqz5DD5XW9gbJ1v1/4u+wuTWS2NgqAbgC29VyPCBoSxaBnrNDsiXjQ6/Z8NOZgcJoS5gIp7NDMDar+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248690; c=relaxed/simple;
	bh=Bb8tycUhYpo4uki6CNUmEbUQFCP4xJE1vsWOzCLM/34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1wXVglQmCUelPEzeVMiXygiddFCi1qGMEQTjqcFyeXo6nK7BUGO/DuyOLU8ecTVEwseL50a2DPgD+2ou+sbS09kiz0NUxgklJ1mGtYRiO88k5+zJcVri9QQx1AmyQq1lEX4PnNJu4SBJCAfd3IKgj5ZeTUqCD/h9Dp/F97ntx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CBjg82A9; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755248679; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hIHiy+yF+yyWBe4KsSBHqI7dPVSsarhV91g3c9GikRA=;
	b=CBjg82A99ov6Lq0XvioQ5R5v8pwZb+gFQq1MSAj5sD2iRTz0dtHhi4/5TdH+mlY71Tt2NHWfpMJo3nfPHY1+PNPxyn/uVTtl/eF8fgCp0XNnAju/+MyLV02ggKml9+O7wHB/79TycMOBhajOTVV+Ey7ZyaFuPRiPCMg0d42QWkk=
Received: from 30.221.130.189(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wlobxuj_1755248678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 17:04:38 +0800
Message-ID: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
Date: Fri, 15 Aug 2025 17:04:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: avoid redundant memcpy and sha256() for
 dedupe
To: wangzijie <wangzijie1@honor.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bintian.wang@honor.com, feng.han@honor.com, Yifan Zhao <stopire@gmail.com>,
 Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250815084428.4157034-1-wangzijie1@honor.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250815084428.4157034-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zijie,

On 2025/8/15 16:44, wangzijie wrote:
> We have already use xxh64() for filtering first for dedupe, when we
> need to skip the same xxh64 hash, no need to do memcpy and sha256(),
> relocate the code to avoid it.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Thanks for the patch, it makes sense to me since we only keep one
record according to xxh64 (instead of sha256) for now:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Although I think multi-threaded deduplication is more useful, see:
https://github.com/erofs/erofs-utils/issues/25
but I'm not sure if you're interested in it... ;-)

Thanks,
Gao Xiang

