Return-Path: <linux-kernel+bounces-751760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B1B16D18
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A291AA74C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E5215F72;
	Thu, 31 Jul 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoPL2DeG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265718C933
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948971; cv=none; b=jee+HCucL/llcrPoZy2scMVL+MbyHK1Da+aIknd1zx3IRb+VdeKvk3exbLQz/atJAKtKuJuN9TN6teQIZ0wvhFhB76hFXhtmviNMVf3NJgqO0DtIQeo6J2Z0FoAXz0ZcJA2J6EG1bfJuXvXmIuMaOmF5oeadbNmUMATzt8yStdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948971; c=relaxed/simple;
	bh=9Z5DzLNxeW75H0JmSCyuAbv60UL/uTn/jONG/a++W1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJn0rFoffo6y6OoxIFpMUT7VaLNM6y9XYsQJfIu8Ddk6zxuJ3Pt4SWadbueIYq5kFMVz5BcsYLcwW9N2cdhU9GAA8TdiJjJ0CtXrRSJNTf0VOEY6Z/8383hjJHgc8zsVq7XUeI5quRLob9VWsLKUr9JEWnCkqb4zgDPDQ+Tk4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoPL2DeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF6C4CEF5;
	Thu, 31 Jul 2025 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948971;
	bh=9Z5DzLNxeW75H0JmSCyuAbv60UL/uTn/jONG/a++W1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hoPL2DeGjvXB+Ut7mDHzNstCWe0F+g81eEx5aA+V59cEG9LHB1hOzkHNabJXujUfR
	 XIgupSB2GYxqTcGSNqpIs/n2sg5hZVyL6x1pl3U24jti22CEaBXaGqBldxLh2ft+7G
	 tfV+3Be2nOIYSptD0ytXi//OKj2Nfbkqm2hClWL9MvYSBbAFuZQkU8o3g0DlZ3IUOK
	 uFJa6I8Al29+7Eq9M1GvpGW/TgOWl4tVcvxiWwvA5iBHi6ThQjMKGAC/wiiQCCZ4RK
	 19spkVW9sU51X4gYVxFCnyBj9p43d0k1kEBnGoideJGC0kSyLHtBq0VbP6scoGGl9N
	 Xz4JMTQKL+0/w==
Message-ID: <38a023cd-4e67-418f-bc27-e272c5484671@kernel.org>
Date: Thu, 31 Jul 2025 10:02:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irq: simplify irq_im_handle_irq()
To: Thomas Gleixner <tglx@linutronix.de>, Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250719211818.402115-1-yury.norov@gmail.com>
 <87zfcxtz6t.ffs@tglx> <aH5OUChoFx55WnVG@yury> <87o6tdtupb.ffs@tglx>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <87o6tdtupb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 21. 07. 25, 17:44, Thomas Gleixner wrote:
> On Mon, Jul 21 2025 at 10:27, Yury Norov wrote:
>> On Mon, Jul 21, 2025 at 04:07:22PM +0200, Thomas Gleixner wrote:
>> find_next_bit() and for_each_bit() cannot be used in concurrent
>> environment, and having atomic clear_bit() is meaningless here.
>> Two concurrent processes, if running in parallel, may pick the
>> same offset, ending up executing the handle_simple_irq() twice.
> 
> The irq work cannot be run in parallel on multiple CPUs. It's guaranteed
> that only one irq work handler runs at a time. So irq_sim_handle_irq()
> is fully serialized by the irq work magic.
> 
> But the bitmap can be modified concurrently, which is not a problem.

Actually, it is (IMO):

         while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
                 offset = find_next_bit(work_ctx->pending,
                                        work_ctx->irq_count, offset);
                 clear_bit(offset, work_ctx->pending);
                 irqnum = irq_find_mapping(work_ctx->domain, offset);
                 handle_simple_irq(irq_to_desc(irqnum));
         }


If another CPU sets a bit X in the beginning of the work_ctx->pending 
bitmap while this is running for some time already (that means offset is 
already greater that that X), bitmap_empty() will be always true and 
this spins forever (or crashes). It is because find_next_bit() will 
never return that bit X -- so clear_bit() will never happen on that.

What is worse, find_next_bit() will return work_ctx->irq_count and both 
clear_bit() and irq_find_mapping() will touch an OOB memory.

Or what am I missing?

find_next_bit_wrap() would cure that.

thanks,
-- 
js
suse labs


