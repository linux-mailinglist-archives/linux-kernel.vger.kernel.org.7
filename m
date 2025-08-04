Return-Path: <linux-kernel+bounces-754947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586CDB19EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D553BD3F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EE223FC54;
	Mon,  4 Aug 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VsJ79zNE"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449321146C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300954; cv=none; b=j+zWs/o3EbyBf4zSITKjj1ZhJO+7XkUsetDvXZmNUjaZFmZMIkjpMmBUKT7RR1d4z19HWex0tF8nhzSEkqNj1eNil790l/stEsRYYT8Zj2Uw0FOJ4h8BiywiWZWeuI6b9J3L50GRfKCtpLg9oo61q0FIMmDB36QbQDEwcpQsCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300954; c=relaxed/simple;
	bh=Fi+eEDHHOpDk+QbauBT7a4yWQHmz5NCmSmsw/z//73g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+H3+7qaLrwH2tpAH/j7AFU3A3mQL5tC+CnMhl/cTD21Fx+U1fP+xffB3e8TCgvAneIg7xYWOVM6+8iEwHiyLaGirkq6CmGwmOdsecej3koqUukD09NtvQTbh0QxmyDTIuEpCm7uoKh4aDYJFA5tq60l81yFY3v7g99s6nyiq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VsJ79zNE; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754300949; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tOi3xkOlfqtkI4ihbv9ehKJO2uOAALksoSwZIOWMYcA=;
	b=VsJ79zNEKnZgsU5QIA++PJYvPHPrFdJc25q2JmeqyqOy/DsuJBiLR8YssWe5yrDEx/8W9imUZFfZRwmj0PuvbMD29CsqZWwTUaIiTbwHp8LQieEclDHHGL2H2NqhBa9ZO0O4o3cpH1aix/uR+qlHQnTiaoVuuMQRypLTieigl3c=
Received: from 30.221.131.110(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkyYPsm_1754300947 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Aug 2025 17:49:08 +0800
Message-ID: <960a1491-47bc-464b-a955-37d62470c0ef@linux.alibaba.com>
Date: Mon, 4 Aug 2025 17:49:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix atomic context detection when
 !CONFIG_DEBUG_LOCK_ALLOC
To: Junli Liu <liujunli@lixiang.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: xiang@kernel.org, chao@kernel.org, yangsonghua@lixiang.com
References: <20250804093811.295563-1-liujunli@lixiang.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250804093811.295563-1-liujunli@lixiang.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



... the patch format is still broken, is your mail server
or your mail client broken?

On 2025/8/4 17:38, Junli Liu wrote:
> Since EROFS handles decompression in non-atomic contexts due to
> uncontrollable decompression latencies and vmap() usage, it tries
> to detect atomic contexts and only kicks off a kworker on demand
> in order to reduce unnecessary scheduling overhead.
> 
> However, the current approach is insufficient and can lead to
> sleeping function calls in invalid contexts, causing kernel
> warnings and potential system instability. See the stacktrace [1]


... and previous discussion [2].


> 
> The current implementation only checks rcu_read_lock_any_held(),
> which behaves inconsistently across different kernel configurations:
> 
> - When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects RCU
> critical sections by checking rcu_lock_map
> - When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to
> "!preemptible()", which only checks preempt_count and misses
> RCU critical sections
> 
> This patch introduces z_erofs_in_atomic() to provide comprehensive
> atomic context detection:
> 
> 1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled,
> as RCU critical sections may not affect preempt_count but still
> require atomic handling
> 
> 2. Always use async processing when CONFIG_PREEMPT_COUNT is disabled,
> as preemption state cannot be reliably determined
> 
> 3. Fall back to standard preemptible() check for remaining cases
> 
> The function replaces the previous complex condition check and ensures
> that z_erofs always uses (kthread_)work in atomic contexts to minimize
> scheduling overhead and prevent sleeping in invalid contexts.
> 
> ==============================================
> [1] Problem stacktrace
> BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex_api.c:510
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107,
> name: irq/54-ufshcd
> preempt_count: 0, expected: 0
> RCU nest depth: 2, expected: 0
> 
> Link: https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop

I prefer to replace the "Link:" to
[2] https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop

Since "Link:" tag mainly refers to the your current patch
in the lore...

Thanks,
Gao Xiang

> Signed-off-by: Junli Liu
> ---
> fs/erofs/zdata.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 792f20888..2d7329700 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1432,6 +1432,16 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
> }
> #endif
> 
> +/* Use (kthread_)work in atomic contexts to minimize scheduling overhead */
> +static inline bool z_erofs_in_atomic(void)
> +{
> + if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
> + return true;
> + if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> + return true;
> + return !preemptible();
> +}
> +
> static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> int bios)
> {
> @@ -1446,8 +1456,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> 
> if (atomic_add_return(bios, &io->pending_bios))
> return;
> - /* Use (kthread_)work and sync decompression for atomic contexts only */
> - if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
> + if (z_erofs_in_atomic()) {
> #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
> struct kthread_worker *worker;
> 
> -- 
> 2.25.1
> 
> 
> 声明：这封邮件只允许文件接收者阅读，有很高的机密性要求。禁止其他人使用、打开、复制或转发里面的任何内容。如果本邮件错误地发给了你，请联系邮件发出者并删除这个文件。机密及法律的特权并不因为误发邮件而放弃或丧失。任何提出的观点或意见只属于作者的个人见解，并不一定代表本公司。
> Disclaimer: This email is intended to be read only by the designated recipient of the document and has high confidentiality requirements. Anyone else is prohibited from using, opening, copying or forwarding any of the contents inside. If this email was sent to you by mistake, please contact the sender of the email and delete this file immediately. Confidentiality and legal privileges are not waived or lost by misdirected emails. Any views or opinions expressed in the email are those of the author and do not necessarily represent those of the Company.
> 


