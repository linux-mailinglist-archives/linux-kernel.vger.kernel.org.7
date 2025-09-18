Return-Path: <linux-kernel+bounces-822172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090E9B83364
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEF12A16CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37BA2D73A7;
	Thu, 18 Sep 2025 06:50:27 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88622D9EF4;
	Thu, 18 Sep 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178227; cv=none; b=t9wMmHriLPGV+3AroQKj2HOixp8GWQg/QeNm51tmqUU1zpjueNpuRplZsagL/70QlD+33p3ICUyBcllVcZmq8IaBIkO1M0T+5y8OgAP+olYcMp3/kYQBtFvZkYxURgd29+LyEBbJJiWE/CT1MIudnm4MQPfgyeaebLRoIMWepDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178227; c=relaxed/simple;
	bh=XGFNmWXa3iRFt3Y7pKiXMH0F9ZY7JOdzVdZUiB29I5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+5tPmdPTrWPS/4T+ZM0PFo9FBI6pOUZz3IJmaH1ofgMYON2GkffOWzraSDOLVwOPOJNf4nHUbYAhegSw9GfCjwDqgxVMgiLvYAb1uRyp2xh5aZ7+J9jXz4UgbxRM02YgIDwxvuI6EG/xccsnUEgjSh6pW0XKtqt/imzxUTz5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAAnqMh5q8torsreAg--.13038S2;
	Thu, 18 Sep 2025 14:49:29 +0800 (CST)
Received: from [10.12.170.88] (unknown [10.12.170.88])
	by gateway (Coremail) with SMTP id _____wDXZJh4q8tojNGnAg--.28600S2;
	Thu, 18 Sep 2025 14:49:28 +0800 (CST)
Message-ID: <a6e58245-15cb-42f6-852c-c9db4d43ed66@hust.edu.cn>
Date: Thu, 18 Sep 2025 14:49:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/zh_CN: add fixed format for the header of
 gfs2-glocks.rst
To: shao.mingyin@zte.com.cn, alexs@kernel.org
Cc: si.yanteng@linux.dev, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn,
 yang.tao172@zte.com.cn
References: <20250918144305326x9mQuLPvqgyLm4WTJvZ9I@zte.com.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20250918144305326x9mQuLPvqgyLm4WTJvZ9I@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAAnqMh5q8torsreAg--.13038S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4xKw1fuFyxKFyxCF4fuFg_yoWkCrb_A3
	97Xay8Awn0qF1IqFykCF1Fvr92yrW3Kr18XFsYyryUA3WDK397JFykXw18ZFyrJr4a9r9x
	Ga95uFyFva42gjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkkYjsxI4VW7JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcV
	Cjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0zRuMKAUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 9/18/25 2:43 PM, shao.mingyin@zte.com.cn wrote:
> From: shaomingyin <shao.mingyin@zte.com.cn>
>
> add fixed format for the header of gfs2-glocks.rst
>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
>   .../translations/zh_CN/filesystems/gfs2-glocks.rst   | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
> index 7f094c5781ad..a9c5f8810d20 100644
> --- a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
> +++ b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
> @@ -1,5 +1,17 @@
>   .. SPDX-License-Identifier: GPL-2.0
>
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/filesystems/gfs2-glocks.rst
> +
> +:翻译:
> +
> + 邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
> +
> +:校译:
> +
> + - 杨涛 yang tao <yang.tao172@zte.com.cn>


Only one proofreader, remove the "-"?

Dongliang Mu


> +
>   ==================
>   Glock 内部加锁规则
>   ==================


