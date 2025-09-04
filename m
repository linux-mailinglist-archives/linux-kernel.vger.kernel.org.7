Return-Path: <linux-kernel+bounces-799737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3FB42F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4F87A1D43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBC1FBC8E;
	Thu,  4 Sep 2025 02:15:47 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E3129E6E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952146; cv=none; b=W+5xZy3BtCrrw2O8bPjsCvmwH5bPwSOL+XiDzGCHQ5j+381VNuxl5Gi3PDtHCfNNw5uh6XXaqWQaWg1O6WIHtNb/T+ItplQqQGGjBxz8ovobRogGzdbxap+gDl/NaPxlm6AxdnbxoXXwWJ9CMPzlwuJ3xMQm5924s9YObGqoWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952146; c=relaxed/simple;
	bh=cFFORYB7W9kJ/fMRCxTcDJgh1ntBg6Yn+F8k58EQXVY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C1iGjPkOEsxC1YmfepFjU0dUp2Av0PY317hxjxvojYo8Gau3WBVu76y1o+VsyJ5Y50o6uHE7jhiw1+u0+tsQIupBY8+bSkEkOMlWgGxA8XurMvDK/dencxeqrfpG+EooeCnQs1wnTrw0PTQNBU/jPW0rRbt6/tJnpsZo1SA9UE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxP9NH9rhoznoGAA--.13305S3;
	Thu, 04 Sep 2025 10:15:35 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxQ+RD9rhofdZ8AA--.1935S3;
	Thu, 04 Sep 2025 10:15:32 +0800 (CST)
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Huacai Chen
 <chenhuacai@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn>
 <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
 <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn>
 <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <40e60857-8e02-cf5e-7804-453b406b0b8b@loongson.cn>
Date: Thu, 4 Sep 2025 10:15:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+RD9rhofdZ8AA--.1935S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZrWUury7GF13ZF15trWfCrX_yoWfWrc_ur
	n29wn7C3s8ta1qvan8Kr4YqFZ5Za4UWrW8J3yDXw48Z345Ja90kFyfJFyfWas8KFsxZasr
	GF4UXas5WryI9osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
	xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU
	=

On 2025/9/4 上午3:17, Josh Poimboeuf wrote:
> On Mon, Sep 01, 2025 at 04:31:36PM +0800, Tiezhu Yang wrote:
>> On 2025/9/1 下午4:16, Peter Zijlstra wrote:
>>> On Mon, Sep 01, 2025 at 03:21:54PM +0800, Tiezhu Yang wrote:
>>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
>>>> the following objtool warning:

...

>> Josh suggested to do something so that the EFI stub code isn't linked into
>> vmlinux.o [2], it needs to modify the link process and seems too
>> complicated and expensive for this warning to some extent.
>>
>> So I did this change for objtool.
> 
> I don't like adding these workarounds to objtool.  Is it really that
> complicated to link efistub separately?  That seems like the proper
> design.  vmlinux.o should only have real kernel code.

OK, I see. If this is the only proper direction, I will do it
in the next version.

Thanks,
Tiezhu


