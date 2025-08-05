Return-Path: <linux-kernel+bounces-755826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8AFB1AC3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7ED17FD16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD7191F9C;
	Tue,  5 Aug 2025 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UC1F1rOe"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFD23AD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358523; cv=none; b=WaodEK0mx3NtD5yKPTM8Ya6cbAF9X2IITy3SMsCMJHj8iGKW1b30dfRpMmgZadiUBdHsd2AfGNfM6wldbkKBQyJzLlccC3M8OfWtOXCqY8jsHT29mpKaOMfu0dSoGR6BSY1d7XNVKtpbEQbFzL+yezbsco2w0TaOjUeM+4lb8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358523; c=relaxed/simple;
	bh=QX1CTmpupHM2mqJUvFjMJFls36Qgn2qwqTNCZK46cJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nfqx0xRPo/hxWM9OmF3UHn236DX+EYtOjHLA+rdIgelKiTQyHjeQ8yAAiAO+ssBY0FWwBjRiMIH8pIq3M28jgJhGrFaobK+P3S3g6KF50arl1S4E2a+A323wKYGazm+VTcm1YFkRftIgnswiFZIJO22xSa/W4cjPs9iwJ35zVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UC1F1rOe; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754358513; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9dYADWpTuv14vdNRl1oOPRCvz8e/tdcXRS2nxaslzHg=;
	b=UC1F1rOeeXECsUl1gdzUDP7AmOzhbLQ44eApan4aw/FulJ9Jr185dUDjX2RNK4ZS+h2ci2JmMIqOVvgFxPRBEUJ0r+fx484prrXdGSKme5i+m2Wjwxd4zsHU509JbDKqpcut/77DG/69ba6kgV3dqs3cXVl7J1suReMs/PdGlc8=
Received: from 30.221.131.119(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wl33RFZ_1754358196 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 09:43:17 +0800
Message-ID: <0c1b7ff7-b053-4868-a550-e2044aba300f@linux.alibaba.com>
Date: Tue, 5 Aug 2025 09:43:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix atomic context detection when
 !CONFIG_DEBUG_LOCK_ALLOC
To: Junli Liu <liujunli@lixiang.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: xiang@kernel.org, chao@kernel.org, yangsonghua@lixiang.com
References: <20250805011957.911186-1-liujunli@lixiang.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250805011957.911186-1-liujunli@lixiang.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/5 09:19, Junli Liu wrote:
> Since EROFS handles decompression in non-atomic contexts due to
> uncontrollable decompression latencies and vmap() usage, it tries
> to detect atomic contexts and only kicks off a kworker on demand
> in order to reduce unnecessary scheduling overhead.
> 
> However, the current approach is insufficient and can lead to
> sleeping function calls in invalid contexts, causing kernel
> warnings and potential system instability. See the stacktrace [1]
> and previous discussion [2].
> 
> The current implementation only checks rcu_read_lock_any_held(),
> which behaves inconsistently across different kernel configurations:
> 
> - When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects
>    RCU critical sections by checking rcu_lock_map
> - When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to
>    "!preemptible()", which only checks preempt_count and misses
>    RCU critical sections
> 
> This patch introduces z_erofs_in_atomic() to provide comprehensive
> atomic context detection:
> 
> 1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled,
>     as RCU critical sections may not affect preempt_count but still
>     require atomic handling
> 
> 2. Always use async processing when CONFIG_PREEMPT_COUNT is disabled,
>     as preemption state cannot be reliably determined
> 
> 3. Fall back to standard preemptible() check for remaining cases
> 
> The function replaces the previous complex condition check and ensures
> that z_erofs always uses (kthread_)work in atomic contexts to minimize
> scheduling overhead and prevent sleeping in invalid contexts.
> 
> [1] Problem stacktrace
> BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex_api.c:510
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107,
> name: irq/54-ufshcd
> preempt_count: 0, expected: 0
> RCU nest depth: 2, expected: 0
> 
> [2] https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop
> 
> Signed-off-by: Junli Liu <liujunli@lixiang.com>

This version seems applicable to me:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

