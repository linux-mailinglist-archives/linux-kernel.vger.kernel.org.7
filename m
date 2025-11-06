Return-Path: <linux-kernel+bounces-889031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F3C3C898
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409F66206DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEA35471E;
	Thu,  6 Nov 2025 16:34:18 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E842F5492;
	Thu,  6 Nov 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446858; cv=none; b=jtyt1ae5fc5uLi6rglV86wf8fDJAx4sZ1v0efRdnXPgpqPDDpkWT+vExCoU1CP3AJuYwBRHt63UgAV37z6x+goQhKELL/FcMEhTqHyGZepa8vFE+u1rlzrwdFjwQajhrPTpxdy/61usW+fYh7goXecFssAPwaq9ffN9IKRoPhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446858; c=relaxed/simple;
	bh=viR7TUVabNHpxV1iJgXxwJvnBjkre54rmfNt5PzotQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef33snGJKihrZV3JPcIT/sI76YGPQWL5+Hrq6nEAgjEaQPQioTGk09RP23/MYtHLyvplbRdCgP2J/tlxmzr5oNRUPjG2B3peg3sA16qsJXV9VVDP4Rp7OwB8nScrcR4y1HfAVEHcXvt/qCD83R9fQr7WnOs9TU6wLBi9bHR0dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrACHusrKzQxpbmJ4BQ--.18275S2;
	Fri, 07 Nov 2025 00:33:14 +0800 (CST)
Received: from [192.168.1.7] (unknown [58.19.1.83])
	by gateway (Coremail) with SMTP id _____wD3wUnFzQxpkldhAA--.41886S2;
	Fri, 07 Nov 2025 00:33:12 +0800 (CST)
Message-ID: <7e6096ab-18bd-4438-8fbb-3f530ee9e69f@hust.edu.cn>
Date: Fri, 7 Nov 2025 00:33:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: Add kbuild timestamp Chinese translation
To: Chenguang Zhao <zhaochenguang@kylinos.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 HUST OS Kernel Contribution <hust-os-kernel-patches@googlegroups.com>
References: <20251106015148.54424-1-zhaochenguang@kylinos.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20251106015148.54424-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACHusrKzQxpbmJ4BQ--.18275S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyDKr1fZw1fWr4xZFWrZrb_yoWrJF13p3
	ZxGr17J3Z5tr1Uur1xGr1UuF1rGFn7Gw4UXw4Utw1kJr1qy3sYqr17tFyvgry7KryxXF4U
	Gr4UKF1UAFyUArUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVWxJVW8Jr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_uctUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 11/6/25 9:51 AM, Chenguang Zhao wrote:
> Sync the translation of changes in kbuild/kbuild.rst about
> KBUILD_BUILD_TIMESTAMP.
>
> Update the translation through commit 5cbfb4da7e06
> ("kbuild: doc: improve KBUILD_BUILD_TIMESTAMP documentation")

Hi, I know where the problem is.

If you want to improve or revise the kernel documentation, please 
directly submit the changes to the original English document. Our 
Chinese translation for now is just the translation of the English 
documentation.

And this commit id should be the commit of the corresponding English 
documents.

Take kbuild/kbuild.rst as an example, the latest commit of Chinese 
translation shows:

-----------------------------------------------------------------------------------------------------------

docs/zh_CN: add the translation of kbuild/kbuild.rst

Finish the translation of kbuild/kbuild.rst and move kbuild
from TODO to the main body.

Update to commit 2eb5d7f24299 ("kbuild: doc: describe the -C
option precisely for external module builds")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Link: https://lore.kernel.org/r/20241016131710.2619567-1-dzm91@hust.edu.cn

-----------------------------------------------------------------------------------------------------------

However, the commit history of English documentation goes further:

2025-01-15    kbuild: rust: add PROCMACROLDFLAGS
2024-11-28    kbuild: support building external modules in a separate 
build directory
2024-09-24    kbuild: doc: describe the -C option precisely for external 
module builds
2024-09-20    kbuild: generate offset range data for builtin modules

We need to update the new translations of doc changes in ("kbuild: rust: 
add PROCMACROLDFLAGS") and ("kbuild: support building external modules 
in a separate build directory")

>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v2:
>   - modify the commit message as suggested by Dongliang and add
>     a corresponding commit info for the English documentation.
> ---
>   Documentation/translations/zh_CN/kbuild/kbuild.rst | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/kbuild/kbuild.rst b/Documentation/translations/zh_CN/kbuild/kbuild.rst
> index e5e2aebe1ebc..ad3e84eabbbf 100644
> --- a/Documentation/translations/zh_CN/kbuild/kbuild.rst
> +++ b/Documentation/translations/zh_CN/kbuild/kbuild.rst
> @@ -290,8 +290,13 @@ IGNORE_DIRS
>   KBUILD_BUILD_TIMESTAMP
>   ----------------------
>   将该环境变量设置为日期字符串，可以覆盖在 UTS_VERSION 定义中使用的时间戳
> -（运行内核时的 uname -v）。该值必须是一个可以传递给 date -d 的字符串。默认值是
> -内核构建某个时刻的 date 命令输出。
> +（运行内核时的 uname -v）。该值必须是一个可以传递给 date -d 的字符串。例如::
> +
> +	$ KBUILD_BUILD_TIMESTAMP="Mon Oct 13 00:00:00 UTC 2025" make
> +
> +默认值是内核构建某个时刻的date命令输出。如果提供该时戳，它还用于任何initramfs
> +归档文件中的mtime字段。Initramfs mtimes是32位的，因此早于Unix纪元1970年，或
> +晚于协调世界时 (UTC)2106年2月7日6时28分15秒的日期是无效的。
>   
>   KBUILD_BUILD_USER, KBUILD_BUILD_HOST
>   ------------------------------------


