Return-Path: <linux-kernel+bounces-879395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF37C2304D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77DB44EF0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB2B28DB49;
	Fri, 31 Oct 2025 02:31:49 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96582E0919
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877905; cv=none; b=TqZZMTIjqzoK4vUwQR6jCzs//OrFT5dWY/ioixM9KVQFV/p5EJHwHS5u9hS66bEeH9Sp/wUcshuKBUJeWbObAmkMvwYHA7dZevxlA0yi6Y+FBhav0QjiAy2L01cDd5dLQeIv//ts1MoMJ217UDj7+A+fh5ZoXzADWL6oK7AvrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877905; c=relaxed/simple;
	bh=cBPLmMSUf3VmT9Jo5qFm1HihQMvwixdUd3WUDspDwL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzf/A5ePfn4gjZhpq3FS1cOz/4WNq735Bf/JCAxhusOcGchHg/G68YVCOqlWZPakFEML6Syo3FixueRIQeILFKKRjmLtYWUq5TsEOh0U6c9UMZ1uTnnJPIcSWcf1D3VP6KiTByyVgohLY/p/cwXpjgxro13SQk2G3+mqvvM2qZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8CxbNKEHwRpKeocAA--.63271S3;
	Fri, 31 Oct 2025 10:31:33 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJBx38ODHwRpG8AeAQ--.1864S2;
	Fri, 31 Oct 2025 10:31:32 +0800 (CST)
Message-ID: <cfdb97e1-fa89-4660-8d00-160ceb127b85@loongson.cn>
Date: Fri, 31 Oct 2025 10:31:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mfd: ls2kbmc: A fix and a refactoring
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: Chong Qiao <qiaochong@loongson.cn>, Lee Jones <lee@kernel.org>,
 zhoubb.aaron@gmail.com
References: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBx38ODHwRpG8AeAQ--.1864S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEMCGkC-i0XogAAsJ
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
	xGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UNvtZUUUUU=

Hi Andy:

Thanks for your patches.

On 2025/10/30 19:36, Andy Shevchenko wrote:
> Just an ad-hoc fix and refactoring as I have noticed the problematic fix.
>
> Andy Shevchenko (2):
>    mfd: ls2kbmc: Fully convert to use managed resources
>    mfd: ls2kbmc: Use PCI API instead of direct accesses
>
>   drivers/mfd/ls2k-bmc-core.c | 38 ++++++++++---------------------------
>   1 file changed, 10 insertions(+), 28 deletions(-)
>
> 	

For the whole series:

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>


Thanks.
Binbin


