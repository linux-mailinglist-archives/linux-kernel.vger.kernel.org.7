Return-Path: <linux-kernel+bounces-689829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC20ADC6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A397A65AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0D2C159F;
	Tue, 17 Jun 2025 09:49:23 +0000 (UTC)
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.31.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409728FFFB;
	Tue, 17 Jun 2025 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153763; cv=none; b=nI0mH8KZcNxCXsk0wriMQlW6k13VyJqfWDlBpWalsbRJf90pWhI/VhpF5M+TmAR0cKKRpoHhE2xVhiRzSwFyXpneX36Pr27xClFkExpO/kAe3xh4SFnkrRwJBh8K20bfjs9kXbR1YmZR1wZaiXFEaxZ63dm4wJVdzVuxL2Fx8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153763; c=relaxed/simple;
	bh=W4UtMRd5rBL/duja0gW0w0noVF3iPoJHGYI1sXUHOJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smzAwnyWzEqC0dIyhMv9ZGSI5RFxYmzl8UPU8lWM+7OAJk85qmv9xV7jXvmbT0bWQHSFIxy+HsmRqJmo7XpsGN53rzm9ttf6exltzTt4aXAcKztUBMwH5VYSAIAaEnfUVXEwMb/DU06KeoUNBGXFIatO9tlx7f1gZlnKdVvu2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=80.67.31.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1uRSsG-000000001o9-3PFb;
	Tue, 17 Jun 2025 11:45:00 +0200
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id DE44FFFC71;
	Tue, 17 Jun 2025 11:45:52 +0200 (CEST)
Message-ID: <bb74b5b6-bc23-4aa4-83df-449dc7c9006b@eltropuls.de>
Date: Tue, 17 Jun 2025 11:45:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
 <20250617092814.vqKdu23w@linutronix.de>
Content-Language: de-DE, en-US
From: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>
In-Reply-To: <20250617092814.vqKdu23w@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Hi Sebastian,

On 17.06.25 11:28, Sebastian Andrzej Siewior wrote:
> Between those two functions you have 800us delay. Interrupts are not
> disabled so the CPU stalls. As explained earlier, I expect the read on
> the bus flushes the writes causing the spike.
>
So the delay you think is really the hardware(CPU) being stalled on the 
bus for so long? Or do you mean that this is the reason for the long 
runtime of the IGB function only?

Shouldn't the other core (it is 2 core machine) still be able to handle 
the timer interrupt then? (I did some testing with isolating IP on one 
core and cyclictest on the other, I am not sure if I moved the timer IRQ 
to the second core)

My mistake was to search for where the Interrupt was being disabled in 
Kernelspace (I did not think that the hardware could introduce and IRQ 
delay for 800us..)



Marc






