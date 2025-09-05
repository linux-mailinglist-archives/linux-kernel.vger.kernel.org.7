Return-Path: <linux-kernel+bounces-802560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB49B453CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F427B820D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0A296BB7;
	Fri,  5 Sep 2025 09:53:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7E28D8D0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066006; cv=none; b=OFt+WRazrvdKtn9jEJHTEJa3jVmtmpTwmYWCpvvEjLnKWcEJlR7chg8NjjRmG8xMG8VsIV+1lReo4afbG1Ob0PapmMHyH83AgNbUEjwtohDic1vC8AZVpO3eJ4pW3dwI33oaHd9pctVNIxlIH5BjwCVezusMxUxzOYvLKedbwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066006; c=relaxed/simple;
	bh=TA/IRpMoFzaGCaODu0EFqNFBZRbPPnCaAi9dH1MgABc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Wdyu9XeWu9G2OqYf35GWQnzsIfQCXM4H+wGmqzMw/ynCkvy4hchrpRpUvx0lq1BH4UgeDsy9XxPXRG3yg10JrEI25AD3GaTjv9ImLEW0NwVl0gmSfGUyrDHRZVMtWK4Cyxooxs7b6AdBuzUICyvWc3HfmNtedxcN6/eEfA4+/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxHvALs7poYwgHAA--.14971S3;
	Fri, 05 Sep 2025 17:53:15 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxzsEJs7poud1_AA--.49582S3;
	Fri, 05 Sep 2025 17:53:14 +0800 (CST)
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
To: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn>
 <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
 <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn>
 <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
 <CAAhV-H5u4xHcuLhyPe+a_YqPoCX2uVoqcW94i=HvU1NooL_efg@mail.gmail.com>
 <mqyjt5cabahlvezowt6plurkyrrbputvg776rhgaxhpwsqnuq3@onr5svx5heuf>
 <CAAhV-H6Cntwxo2XcPtB+zH0VE5J3N=Wb2Ad8RZ6DjwopGsXALw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <75cae289-8717-85e7-1d86-a2736010d99c@loongson.cn>
Date: Fri, 5 Sep 2025 17:53:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6Cntwxo2XcPtB+zH0VE5J3N=Wb2Ad8RZ6DjwopGsXALw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxzsEJs7poud1_AA--.49582S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF15AF15ur4xZF1kuF13KFX_yoW8JFW7pF
	W0qrWxKF4kJF4xArn7X3y09Fy3W3s7t3s0kwn8Wry5Aa4DJr1Svr12gr15uFZ8Xr4xta12
	vr1Yq342kayDGrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U

Hi Josh,

On 2025/9/5 下午12:33, Huacai Chen wrote:
> Hi, Josh,
> 
> On Fri, Sep 5, 2025 at 1:26 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>
>> On Thu, Sep 04, 2025 at 10:17:11AM +0800, Huacai Chen wrote:

...

>> Is there some technical reason why vmlinux.o needs efistub linked in?
> I think so. For example, EFISTUB prefer to directly use screen_info
> that defined in vmlinux, see the comments in
> drivers/firmware/efi/libstub/screen_info.c:
> 
> /*
>   * There are two ways of populating the core kernel's struct
> screen_info via the stub:
>   * - using a configuration table, like below, which relies on the EFI init code
>   *   to locate the table and copy the contents;
>   * - by linking directly to the core kernel's copy of the global symbol.
>   *
>   * The latter is preferred because it makes the EFIFB earlycon available very
>   * early, but it only works if the EFI stub is part of the core kernel image
>   * itself. The zboot decompressor can only use the configuration table
>   * approach.
>   */

I wonder what is the final conclusion.

(1) For patch #1 and #2, keep the code as is and just update
the commit message.

(2) For patch #3, replace UNWIND_HINT_UNDEFINED with
UNWIND_HINT_END_OF_STACK and remove is_entry_func().

If there are any more comments, please let me know.

Thanks,
Tiezhu


