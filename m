Return-Path: <linux-kernel+bounces-740396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E672B0D3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F8161D61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECFA1534EC;
	Tue, 22 Jul 2025 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNe1h8Q8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8F2D29C7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169876; cv=none; b=jZ5kWMPHxRblr/5EXbsTp9ycByQ92ZyrVjJMgG+SVUkV4VaUR7Xei0Pa6Ns9HNZdaE/IGloi3B2vPtnYjGHyDu671AYuouKnEGlDVwQV2jIsdEe988uuoh/Ajmh7RyRQvIgcXB/ujdLwri6nb07XfB3wuNLUA1Fyj+8IP2UZons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169876; c=relaxed/simple;
	bh=KEQ+1POGwaZLlQgPaSk5QV7eY0bwG1NFxzwzgBt6IOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhV3KqYtq6oqtVtSMhDMh9ClBtLmVDs0s3ytjSPBB6E4axUH+raYx2H3TaEp/XFswXvvZiw+lU+gZwtgtM2gOyOUjR6AhpTFLRkdoGnWQ/xO76ZBlnKtHzL0IMLIlLmKqADWZo8/jSsL3OS9OgXprEjoiUg3tw4YZAPBfxr0GnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNe1h8Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87DC4CEEB;
	Tue, 22 Jul 2025 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753169876;
	bh=KEQ+1POGwaZLlQgPaSk5QV7eY0bwG1NFxzwzgBt6IOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JNe1h8Q8yecuwmh3vm/HYNH/I/9bA9rU2cr1dJikFEVczhC6GfSvpzJlQe+ekCNdv
	 oSu8zS2k+UThTq2OSG8fbCr7uz3sV2OxFYbX0iLkEzmRx3mltfY0gThzk37Yx9UCsa
	 KnSB1rUacxc4Sl9r6dSKmzr91FuStL7qBhx+vwBLYa6AwXgJXY/8+DgotXc46R0B3L
	 tJ2BP8hKCBebR1h8VtU1PdIKnWu/BXhJYr9M4cscchvMzKDILsRQ8kUuaPuEzKXTp/
	 7s+5sn2d5zF1OfkLGOZgtYdvUPNEY8+GOUw53yX5vcW8FQNZ9ydrx5M3pTNqCBC83l
	 kUowG0DmFMq6w==
Message-ID: <7d18317b-5a3a-435e-8620-6f978dc84e8f@kernel.org>
Date: Tue, 22 Jul 2025 09:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 4/4] genirq: Prevent migration live lock in
 handle_edge_irq()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>
References: <20250718184935.232983339@linutronix.de>
 <20250718185312.076515034@linutronix.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250718185312.076515034@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 07. 25, 20:54, Thomas Gleixner wrote:
> Yicon reported and Liangyan debugged a live lock in handle_edge_irq()
> related to interrupt migration.
> 
> If the interrupt affinity is moved to a new target CPU and the interrupt is
> currently handled on the previous target CPU for edge type interrupts the
> handler might get stuck on the previous target:
> 
> CPU 0 (previous target)		CPU 1 (new target)
> 
>    handle_edge_irq()
>     repeat:
> 	handle_event()		handle_edge_irq()
> 			        if (INPROGESS) {
> 				  set(PENDING);
> 				  mask();
> 				  return;
> 				}
> 	if (PENDING) {
> 	  clear(PENDING);
> 	  unmask();
> 	  goto repeat;
> 	}
> 
> The migration in software never completes and CPU0 continues to handle the
> pending events forever. This happens when the device raises interrupts with
> a high rate and always before handle_event() completes and before the CPU0
> handler can clear INPROGRESS so that CPU1 sets the PENDING flag over and
> over. This has been observed in virtual machines.
> 
> Prevent this by checking whether the CPU which observes the INPROGRESS flag
> is the new affinity target. If that's the case, do not set the PENDING flag
> and wait for the INPROGRESS flag to be cleared instead, so that the new
> interrupt is handled on the new target CPU and the previous CPU is released
> from the action.
> 
> This is restricted to the edge type handler and only utilized on systems,
> which use single CPU targets for interrupt affinity.

LGTM

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> Reported-by: Yicong Shen <shenyicong.1023@bytedance.com>
> Reported-by: Liangyan <liangyan.peng@bytedance.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20250701163558.2588435-1-liangyan.peng@bytedance.com

thanks,
-- 
js
suse labs

