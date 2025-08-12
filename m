Return-Path: <linux-kernel+bounces-764004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F9B21CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CB2463BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10DF2D46B3;
	Tue, 12 Aug 2025 05:12:02 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA441A23A0;
	Tue, 12 Aug 2025 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975522; cv=none; b=EjShECxWfwJrHM6RbsQpyPdFyykhvCJVQiiWoUMn4yAJ29qrpQhiUFC5jUgxkIRMjjD/SS9LwMH92rgeDxf0WOA7EQNRfVt09pdBwM7C0MNBxwIQ8tW+nk4o0czQfWYZND/Zi8JsNPdCqOnb/2ZiDQSO05S9rwcbsMiPxRCmecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975522; c=relaxed/simple;
	bh=+e4aQ4erJHP8iI85HC9zaagNuxNBEEFdnp0sUhqAedE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKMIhMakt3T69ctSTTz0oN+mLbjVdGNJMSi4hwedkh+l7rycCGx4n1WeGDzkaDeyHVmWNl8PFStVINTru2QeOe+UaG8XND7eGzc35UQDdQ5ej9QCgXvBHMzOe65Sk0ovaCGeIRl5JU8sc1xXIPd153w71+uHs3NJ1ZNgv2/Hh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrADHSMnlzJpo7ywIAQ--.1733S2;
	Tue, 12 Aug 2025 13:11:02 +0800 (CST)
Received: from [192.168.43.195] (unknown [10.200.80.159])
	by gateway (Coremail) with SMTP id _____wCXkFPkzJpo_rrVAQ--.47500S2;
	Tue, 12 Aug 2025 13:11:01 +0800 (CST)
Message-ID: <c8a9e908-5231-4856-a722-ddc211154924@hust.edu.cn>
Date: Tue, 12 Aug 2025 13:11:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] scripts/checktransupdate.py: add support for scanning
 directory
To: Nathan Chancellor <nathan@kernel.org>,
 Haoyang LIU <tttturtleruss@gmail.com>, Yanteng Si <si.yanteng@linux.dev>,
 Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 hust-os-kernel-patches@googlegroups.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-doc@vger.kernel.org
References: <20250811170050.94997-1-tttturtleruss@gmail.com>
 <20250811212446.GA924610@ax162>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20250811212446.GA924610@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrADHSMnlzJpo7ywIAQ--.1733S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4DGFWfWFyfuw1DJF1fWFg_yoW8AF45pa
	18Kw1aka43Kr47Cwn3Kw4YyF1rAa18GFy5Grn2qwn2vFn8tr40gr4I9wn0vF4kZFWrCFW5
	XF4a9ry5KF4UZFDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQFb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jDkucUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 8/12/25 5:24 AM, 'Nathan Chancellor' via HUST OS Kernel Contribution 
wrote:
> Hi Haoyang,
>
> On Tue, Aug 12, 2025 at 01:00:50AM +0800, Haoyang LIU wrote:
>> Origin script can only accept a file as parameter, this commit enables
>> it to scan a directory.
>>
>> Usage example:
>> ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools
>>
>> Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
>> ---
>>
>> V1 -> V2: remove the fix of missing "f" in f-string and make it a new patch
>>
>>   scripts/checktransupdate.py | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
> Thanks for the update. While this seems reasonable to me from a purely
> surface level glance over the actual Python, I have added the
> Documentation folks that Dongliang added from the previous thread, who
> really own and maintain this file (the original patch is at [1]). Please
> include them in future revisions should they be necessary. It would
> probably be good for something like this to be applied?

Thanks for the suggestion. I've submitted a patch[1].

[1] 
https://lore.kernel.org/linux-doc/20250812050711.2515173-1-dzm91@hust.edu.cn/

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..b7e3a8c8832e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,6 +7302,7 @@ P:	Documentation/doc-guide/maintainer-profile.rst
>   T:	git git://git.lwn.net/linux.git docs-next
>   F:	Documentation/
>   F:	scripts/check-variable-fonts.sh
> +F:	scripts/checktransupdate.py
>   F:	scripts/documentation-file-ref-check
>   F:	scripts/get_abi.py
>   F:	scripts/kernel-doc*
>
> [1]: https://lore.kernel.org/20250811170050.94997-1-tttturtleruss@gmail.com/
>
> Cheers,
> Nathan
>


