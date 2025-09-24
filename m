Return-Path: <linux-kernel+bounces-830848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC5B9AB34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FF684E25E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A23230FF36;
	Wed, 24 Sep 2025 15:36:02 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6E27456;
	Wed, 24 Sep 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728162; cv=none; b=JJ/ZIlOu3+ncykKetfTmk9lADUn0OzsXBJ2lWO43O/zSefmsJUAowugfNJKLgz9YRT6kSYhKTeDcItx9KS5ieExr5kHl6L8pvL5hjz2yOJ7F5SgXv30aHYudODFnULiowW4E0KRDGked4yOIZQz0v9eqj8ngLY862cBjFVCb/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728162; c=relaxed/simple;
	bh=XnCafYimc1fKKbIvAwPuz4XSnz+AJ3b/OkFAhVB1Nyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB/rgjuOyfhPPW02XVOAbPcpbVBRdjQJtyDzerjdC5tG6EC+AIaY0u7UliKjx5v5xgvZVKuVsNMenIE89Kazc6rpSQqjX2mVe9z++BOdfL0OrC+vtRSqLo1zZ05vlXo7XfPsYewog4c54Tyk7FtfGElZoJjKqUheVST87f00Rhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowADH24XDD9RoAzdBBQ--.31926S2;
	Wed, 24 Sep 2025 23:35:31 +0800 (CST)
Message-ID: <27092a3a-cf9d-4481-99b3-4cc64a544b4f@iscas.ac.cn>
Date: Wed, 24 Sep 2025 23:35:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 2/2] riscv: Allow for riscv-clock to pick up
 mmio address.
To: aleksa.paunovic@htecgroup.com, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>
References: <20250924-riscv-time-mmio-v6-0-9c6158a14b37@htecgroup.com>
 <20250924-riscv-time-mmio-v6-2-9c6158a14b37@htecgroup.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250924-riscv-time-mmio-v6-2-9c6158a14b37@htecgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowADH24XDD9RoAzdBBQ--.31926S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3ZF4kWw4xJr4UAFWDJwb_yoW8XryDpF
	s3Cr13Ar15Xr4agwsIyF1DuryFqw4xGa43Kry2yw1Ivr45AFy8Kr4kt34vqFyDXF97Ar12
	qF1Skr4Y9r1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j8KsUUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Aleksa,

On 9/24/25 19:10, Aleksa Paunovic via B4 Relay wrote:

> From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
>
> Allow faster rdtime access via GCR.U mtime shadow register on RISC-V
> devices. This feature can be enabled by setting GCRU_TIME_MMIO
> during configuration.
> Reformat the clint timer to use the same mechanism if RISCV_M_MODE is set.
>
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
>  arch/riscv/include/asm/clint.h    | 26 ----------------
>  arch/riscv/include/asm/timex.h    | 63 ++++++++++++++++++++++-----------------
>  drivers/clocksource/Kconfig       | 12 ++++++++
>  drivers/clocksource/timer-clint.c | 20 ++++++-------
>  drivers/clocksource/timer-riscv.c | 34 +++++++++++++++++++++
>  5 files changed, 90 insertions(+), 65 deletions(-)

I have a question about the design of this patch. Do we *really* have to
combine the GCR.U timer driver into the existing riscv,timer driver?

It seems at least to me that all we really need is a *new* clocksource
driver with a higher "rating" than riscv_clocksource and
clint_clocksource, and the kernel will prefer it anyway.

In your patch, you're effectively making timer-riscv a driver for both
riscv,timer and mips,p8700-gcru, while including a whole bunch of
indirections and renamings. I think the structure of this patch would be
much simpler if it was just adding a new clocksource driver.

Please consider.

Thanks,
Vivian "dramforever" Wang


