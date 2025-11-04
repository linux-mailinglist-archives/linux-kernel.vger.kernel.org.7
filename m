Return-Path: <linux-kernel+bounces-884776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AACC31180
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF5074E65BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC62ECEA8;
	Tue,  4 Nov 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LoFqQgP8"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9E2459DC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261009; cv=none; b=tiXb0+sBVT2X7897M2F5GoFyHV95M7BNPCVol0lGK22Jlp6oCWrVU/39Twy6gSh1zW1sv964Lfb4fc+EK9+TeLoZmJwPfno0MKPj0GLQhWkTHdIcqPYZyqEejKZqYuo6xAYuNX71+lOjggbuXxlQeX/Wp75IJGRYWSR9rWFur9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261009; c=relaxed/simple;
	bh=Krc8fL+9PXUv+B4dddc0dNOYXGrY0HzMDIyjLYKZKb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJkVjin/+tVcza0/qfGWSKJebyFZk2MfsuGKcFMkgKHY/SzTTXNn5YR6/B1unT5Evu6JUaUUk1MG2cveHWuPG6qgtzXJpTywTFmoXw4XOn+g7v7WGY7kRAEhYhg1hLTuc+XGq89BLngAsQ4TGqBC8VHbMWcCVzh/3X0GsjHYK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LoFqQgP8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae67fb3a-1452-43e1-a756-cad27760f36e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762261004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoFC6lCW/Rwy/xw6NdDwsgKhc64pr81mHLEG5KQUsV0=;
	b=LoFqQgP8vvMBQo91TtGz8/HXphRAh29TA5XVluB3gjxr4UcBEF0k88GQWv7ZuZibHwak1B
	i8AG+41JvlouW/ubiM3EE+vfR0jgyEduST5fuxsen8aNeFPkdrMLen9FXjqqiYvSYWELx6
	H42WMGfYHTsNbWAp72lZqSaHHNNspgs=
Date: Tue, 4 Nov 2025 20:56:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kernel/hung_task: unexport sysctl_hung_task_timeout_secs
To: Christoph Hellwig <hch@lst.de>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
References: <20251104121920.2430568-1-hch@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251104121920.2430568-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/4 20:19, Christoph Hellwig wrote:
> This was added by the bcachefs pull requests despite various
> objections, and with bcachefs removed is now unused.
> 
> This reverts commit 5c3273ec3c6af356b29ff50a654f0dc33bf25a83.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Nice cleanup! LGTM:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>   kernel/hung_task.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b2c1f14b8129..1dfb9bc1bdef 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -50,7 +50,6 @@ static unsigned long __read_mostly sysctl_hung_task_detect_count;
>    * Zero means infinite timeout - no checking done:
>    */
>   unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
> -EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
>   
>   /*
>    * Zero (default value) means use sysctl_hung_task_timeout_secs:


