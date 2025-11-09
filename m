Return-Path: <linux-kernel+bounces-891979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F1C43FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849AC3ADBFC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA252F7ADF;
	Sun,  9 Nov 2025 14:10:32 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC32F6909
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697432; cv=none; b=AKZ38KLaKETz30JcC5Nwz9g5UnkWHRJ/F9YbHfy2oYkWzUiFsOziYpaRRmCBWc6suYP2Fv84ukB1nitW7spP2Y4+J/dgwBHx9BDHBsyhA1NeiWbGMuh6Z2txJ4Cf4g1BZQr4n8Oj6GIQ5ptDxTMqOJ3EDvANv3QXkp066qK3ENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697432; c=relaxed/simple;
	bh=z3hFpIt0+B+x+Wgd1ap2OLKHSF4ldMpme4pWkGiEHao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/A6HhR9a9I7CqDAP0aOQkePnYNkCD5Sx6wOcvqPgR5sAbYyqZZmzyYX83odXSDKfvXOIbJSuQQf36PoN+2fxoC9eEkdgpxLS2gQrPzpZlIldg0OrxOm6dHnC5bICdyDOGIlpPp3X7kTUgXulUi2sRUclimXRy1SwJQKevL+sIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.122.212])
	by gateway (Coremail) with SMTP id _____8DxLvDQoBBpG_cgAA--.6063S3;
	Sun, 09 Nov 2025 22:10:24 +0800 (CST)
Received: from [192.168.0.111] (unknown [36.44.122.212])
	by front1 (Coremail) with SMTP id qMiowJBxTMHMoBBp7LosAQ--.9208S3;
	Sun, 09 Nov 2025 22:10:22 +0800 (CST)
Message-ID: <a983c2b9-e18e-9e28-d827-77df96ad8904@loongson.cn>
Date: Sun, 9 Nov 2025 22:10:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1] LoongArch: Refine init_hw_perf_events()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251014070227.22396-1-yangtiezhu@loongson.cn>
 <CAAhV-H6uRnP6MD7aV0fC-uL+rihuSDw=Opmx=0keQ9gFp9ERhw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <CAAhV-H6uRnP6MD7aV0fC-uL+rihuSDw=Opmx=0keQ9gFp9ERhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxTMHMoBBp7LosAQ--.9208S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF13ur4kCr4xGFWrCFW7GFX_yoW8GF1xpr
	4IkanIgFs8KFy8AFs7G3y5Wry2yFZ5GFyIvrn3Zr1UCFWDZ3sYqrnrXa1fuFykAryrC3WI
	qFn2gwn7Wa9rJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
	UUUU=

On 11/3/25 17:09, Huacai Chen wrote:
> Applied without rename loongson to loongson64, because loongson32 and
> loongson64 have different event numbers, they need to be
> distinguished.
> 
> Huacai
> 
> On Tue, Oct 14, 2025 at 3:02 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> (1) Use the existing CPUCFG6_PMNUM_SHIFT macro definition instead of
>> the magic value 4 to get the PMU number.
>>
>> (2) Detect the value of PMU bits via CPUCFG instruction according to
>> the ISA manual instead of hard-coded as 64, because the value may be
>> different for various microarchitectures.
>>
>> (3) Rename the PMU name without the postfix 64 due to it is redundant
>> and may be inaccurate.
>>
>> Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_cpucfg
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

I just saw the following reply about the patch title "Refine":

"I'm not really sure what "Refine ... about HIGHMEM" is supposed
to mean. Might it be clearer to title this something like "Remove
necessary highmem in ..."?"

https://lore.kernel.org/linux-mm/aQ4lU02gPNCO9eXB@fedora/

This patch title is not clear too, should it split into two patches?
The patch title can be:

(1) LoongArch: Use CPUCFG6_PMNUM_SHIFT to get PMU number
(2) LoongArch: Detect PMU bits via CPUCFG instruction

Thanks,
Tiezhu


