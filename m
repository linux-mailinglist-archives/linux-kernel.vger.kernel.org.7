Return-Path: <linux-kernel+bounces-740441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F03B0D42B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4349189C738
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB02D3ED7;
	Tue, 22 Jul 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfby9Pdb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567D2D323D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171900; cv=none; b=fY42zs7JfzKFc95PbhkeX7wwoWxZneUv9RdJsHeDXAlpKD6nweP+76cmNrea0DYPm0cQ87V7rq10CGUcvR85RHqbe2uvAj1/xnHhh6Jr94VM8ZBehZ1/V5KrqusrE5qmLcv2COb03RZdDNU01lfAosObL1qAsNereo7HMtBtJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171900; c=relaxed/simple;
	bh=PF8Pr1kD174b7Zl7PPDZkkSbVuADD9FN3Ng9KvlN52U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ru9vAdxIVlPvw7Jni/N2nhVMEoUxhS5jpHYVyOChpHBvGbwVk2Q3QgU3X/Ak7PUsE/Fzpq5DoEDFbU19Lsl5NR57Ri9e/MJoR+OWr8sDlqWydyr8W7b1Vk2U4GLqqA+pBBKVHATKMFLi29aiSCSdg5svDBLLjYI+wGhNpRBHiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfby9Pdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BFBC4CEEB;
	Tue, 22 Jul 2025 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753171900;
	bh=PF8Pr1kD174b7Zl7PPDZkkSbVuADD9FN3Ng9KvlN52U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=kfby9PdbX8yo7/yXcHSf1UMjfcBxZ2RNmWCUSqsKMLhXX+1UeSEf5R9+NvIZYredS
	 t2yY4XJksPqGPk3z2Gqpn5YRq+q/judf7D+c+aefEYeqLi9e2Tm2GfDki6RJ2ORx6f
	 H3l41iifgiH2zwF9ggRpccXeOXKSfSR+Fjbdp89b0aGv/C40cVMh7Z89ujtoS+k0LF
	 0hN9dyHnxTYMlk/jpNIu7rv+uB40ZkaQSVQyXhKInhZiakwtGjer18LjLFTMcigxmM
	 2R3U6EZBU/6VjOdyzYnLbmlGnuV4nvZG6XVo6vATzATszZmmM8QluDATQYPDVSp4lJ
	 eIdN2zZdjdbjQ==
Message-ID: <7eb73676-7f65-4eb5-8735-559eff73e1cf@kernel.org>
Date: Tue, 22 Jul 2025 10:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irq: simplify irq_im_handle_irq()
To: Yury Norov <yury.norov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20250719211818.402115-1-yury.norov@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250719211818.402115-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 07. 25, 23:18, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> Hi Thomas,

This does not belong to a commit log ^^.

> The function calls bitmap_empty() for potentially every bit in
> work_ctx->pending, which makes a simple bitmap traverse O(N^2).
> Fix it by switching to the dedicated for_each_set_bit().

Looks good.

> While there, fix using atomic clear_bit() in a context where atomicity
> cannot be guaranteed.

What does this mean? __clear_bit() can corrupt the bitmap when there is 
an in-flight set_bit(), right?

> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>   kernel/irq/irq_sim.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index ae4c9cbd1b4b..e05904da7e3d 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -128,15 +128,13 @@ static struct irq_chip irq_sim_irqchip = {
>   static void irq_sim_handle_irq(struct irq_work *work)
>   {
>   	struct irq_sim_work_ctx *work_ctx;
> -	unsigned int offset = 0;
> +	unsigned int offset;
>   	int irqnum;
>   
>   	work_ctx = container_of(work, struct irq_sim_work_ctx, work);
>   
> -	while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
> -		offset = find_next_bit(work_ctx->pending,
> -				       work_ctx->irq_count, offset);
> -		clear_bit(offset, work_ctx->pending);
> +	for_each_set_bit(offset, work_ctx->pending, work_ctx->irq_count) {
> +		__clear_bit(offset, work_ctx->pending);
>   		irqnum = irq_find_mapping(work_ctx->domain, offset);
>   		handle_simple_irq(irq_to_desc(irqnum));
>   	}

-- 
js
suse labs


