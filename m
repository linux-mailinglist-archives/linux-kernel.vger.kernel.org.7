Return-Path: <linux-kernel+bounces-783973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B51B334DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A29117374E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9823BCED;
	Mon, 25 Aug 2025 03:57:10 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95839225401;
	Mon, 25 Aug 2025 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094230; cv=none; b=Te7Zgyv2eNfyykwLxYvg1sAXBX1Hx7TQ2RjpqIK5PGoZGoUrZfAyF7rEPxLwzOi5h2Msb+GzptRa4c3uS2qpmMruYqcOXOHdFWY+484EDBo/cxq7RMlcRMIy6z7L/ix5mQy3E9cFlr6XodFKNyCL+g1b643sVp0JAro7Eo0dIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094230; c=relaxed/simple;
	bh=zzQP0uV9yVfafKNcbFiHnkSWYZMyU1d1/7l69CIjAG8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Filz56DxrO6Na2g3LJMSIb9V0g9jFjQmAnMArHhYSru0cX5cIflEYRe/PzfKp8UhV3E/Pf5/Oefj+T1Y0fmyWCEgHHXKla7l3MFAF+lrh73oyKphttREY6dg+84OldOK9NagTZNe/eD2r5RmXRQoyF02hMI0w9SzDCvTa+YvQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAA3uMjV3qtoUma5AQ--.23865S2;
	Mon, 25 Aug 2025 11:56:05 +0800 (CST)
Received: from [10.12.168.139] (unknown [10.12.168.139])
	by gateway (Coremail) with SMTP id _____wA3MGvQ3qtoDWoKAA--.6070S2;
	Mon, 25 Aug 2025 11:56:02 +0800 (CST)
Message-ID: <1be55956-a4f0-4f6f-a930-fab565dbd257@hust.edu.cn>
Date: Mon, 25 Aug 2025 11:56:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH v3 0/7] Docs/zh_CN: Translate filesystems docs to
 Simplified Chinese
To: shao.mingyin@zte.com.cn, alexs@kernel.org
Cc: si.yanteng@linux.dev, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn,
 yang.tao172@zte.com.cn
References: <20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn>
In-Reply-To: <20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAA3uMjV3qtoUma5AQ--.23865S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxGr17tFyDJFWDArWfXF4UCFg_yoWrXw1xpa
	yYqr93WF1jy3WfGwnakrW2q34UC3WrK3s8Cryxtwn8Gr4qvF4rKry7tryqgrZ8tF45u3Wa
	qrWfKryku34UArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm0b7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07jfpndUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 8/22/25 5:12 PM, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin<shao.mingyin@zte.com.cn>
>
> translate the filesystems docs into Simplified Chinese.
> v2->v3
> add two patches to the patch set.
>
> Shao Mingyin (5):
> Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
> Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
> Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
> Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
> Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese
>
> Wang Longjie (2):
> Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
> Docs/zh_CN: Translate inotify.rst to Simplified Chinese


$ b4 am 20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn
Grabbing thread from 
lore.kernel.org/all/20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn/t.mbox.gz
Analyzing 8 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
   [PATCH v3 1/7] Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
   [PATCH v3 2/7] Docs/zh_CN: Translate ubifs-authentication.rst to 
Simplified Chinese
   [PATCH v3 3/7] Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
   [PATCH v3 4/7] Docs/zh_CN: Translate gfs2-uevents.rst to Simplified 
Chinese
   [PATCH v3 5/7] Docs/zh_CN: Translate gfs2-glocks.rst to Simplified 
Chinese
   [PATCH v3 6/7] Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
   [PATCH v3 7/7] Docs/zh_CN: Translate inotify.rst to Simplified Chinese
---
Total patches: 7
---
Cover: 
./v3_20250822_shao_mingyin_docs_zh_cn_translate_filesystems_docs_to_simplified_chinese.cover
  Link: 
https://lore.kernel.org/r/20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn
  Base: applies clean to current tree
        git checkout -b v3_20250822_shao_mingyin_zte_com_cn HEAD
        git am 
./v3_20250822_shao_mingyin_docs_zh_cn_translate_filesystems_docs_to_simplified_chinese.mbx

$ git checkout -b v3_20250822_shao_mingyin_zte_com_cn HEAD
Switched to a new branch 'v3_20250822_shao_mingyin_zte_com_cn'

$ git am 
./v3_20250822_shao_mingyin_docs_zh_cn_translate_filesystems_docs_to_simplified_chinese.mbx
Applying: Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
Applying: Docs/zh_CN: Translate ubifs-authentication.rst to Simplified 
Chinese
Applying: Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
error: corrupt patch at line 80
Patch failed at 0003 Docs/zh_CN: Translate gfs2.rst to Simplified Chinese

Hi Mingyin,

I cannot apply this patchset to the docs-next branch of lwn or alex 
kernel tree. Please double check your patchset.

Dongliang Mu

>   .../zh_CN/filesystems/dnotify.rst             |  67 ++++
>   .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
>   .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
>   .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
>   .../translations/zh_CN/filesystems/index.rst  |  16 +
>   .../zh_CN/filesystems/inotify.rst             |  81 ++++
>   .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
>   .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
>   8 files changed, 985 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
>   create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>   create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
>   create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
>   create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
>   create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>   create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst


