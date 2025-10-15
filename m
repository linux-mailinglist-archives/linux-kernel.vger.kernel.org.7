Return-Path: <linux-kernel+bounces-854220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826EBDDD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23B419A5FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187231A55F;
	Wed, 15 Oct 2025 09:47:50 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913A2C2359
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521670; cv=none; b=tg7AAGibgp4E3C64g8kCaQbisdOIBUhqy0FR3Tgt4lKjyRAIxsw9Y1esSURXkwu8wdOis6yFGPiJBV6asB1WCTLigb3Fks6rYPtJIMhv81RFb+6hCubw1/cypI0IlYxpevldGSoy2kSQae69cF4TZce23Uv79UpBm3kXEGLZ1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521670; c=relaxed/simple;
	bh=EEluPFafr9qjOFSk1hahKMUHbpZJudJk/Ct7YIPlxy0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NMyKMv26wFR8mmJS8PEocAmcc9y+HwGE8ggD4OLWWqEEYxctrsk4813C37lTS/PgQ/b1OLJS82mOQ5AlAn1dn0pY1TQE9NF34fq5tg4TeZ+9vNiBtLcAiiw5LZJLZZ3xJNVp8VJ1G/hpQSSiq+PiG1rROlqfPSNkSBsSUbyUQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxxtC+be9okWAWAA--.47214S3;
	Wed, 15 Oct 2025 17:47:42 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+S6be9olnjlAA--.49274S3;
	Wed, 15 Oct 2025 17:47:39 +0800 (CST)
Subject: Re: [PATCH v1] objtool: Fix typo "teh" to "the"
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
References: <20251015090106.4037-1-yangtiezhu@loongson.cn>
 <20251015091758.GA3419281@noisy.programming.kicks-ass.net>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d489fffe-d201-6213-a59f-2e217c5ab880@loongson.cn>
Date: Wed, 15 Oct 2025 17:47:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251015091758.GA3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+S6be9olnjlAA--.49274S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25Ef
	UUUUU

On 2025/10/15 下午5:17, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 05:01:06PM +0800, Tiezhu Yang wrote:
>> Obviously, it should be "the end" rather than "teh end".
> 
> Was not in fact type but interweb slang:
> 
>    https://www.urbandictionary.com/define.php?term=teh

I can not open the above link, I read the info from
https://www.definitions.net/definition/TEH

What should to do in the next step?

(1) Do nothing, just keep it as is.
(2) Change it to "the", but adjust the patch subject and
commit message.

Thanks,
Tiezhu


