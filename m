Return-Path: <linux-kernel+bounces-822211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA954B834CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CB53B479A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE142E974E;
	Thu, 18 Sep 2025 07:21:59 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C1C2D9EDD;
	Thu, 18 Sep 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180119; cv=none; b=j2vx9XolF7qv4Bgj4Zl4t3s+XxUNRxk1bxYd1d5ftNhzbuurDMI2rAtXLQze2dZbT1TUyXmvSJ2pEhuPTwDgNogfGdAPj0gOZOIN1YcYOWFZQ2cAvX39PxTWR6nXLBHBCtKPDI32VDU2NEQOC5VeE7RB4oYxUhJpTbSVirZA8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180119; c=relaxed/simple;
	bh=MH24jopaLTynYFV4jBncSoge4J5PU9ToQ4hV8M70tOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5dX67GnNwPcOtC3V9zuXm5dSVPq8zYAQKSl3feVpedQYvVtua67ujPa1Oua6q82+MhDmoTjSRznejKLm8165I8z3ivDthXMmOd+WoBCt5tPQRPVHcarSp+IKLLnQqgBokZGwwdsPT3mhJ1nl1vEuuDNIfHZPZOCTMhD6MN1LC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAXgGfwsstoxEh7AA--.10965S2;
	Thu, 18 Sep 2025 15:21:20 +0800 (CST)
Received: from [10.12.170.88] (unknown [10.12.170.88])
	by gateway (Coremail) with SMTP id _____wD38RHusstorX2OAA--.23859S2;
	Thu, 18 Sep 2025 15:21:19 +0800 (CST)
Message-ID: <68f89d58-ebc5-429a-a4f4-707a361450f4@hust.edu.cn>
Date: Thu, 18 Sep 2025 15:21:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Docs/zh_CN: add fixed format for the header of
 gfs2-glocks.rst
To: shao.mingyin@zte.com.cn, alexs@kernel.org
Cc: si.yanteng@linux.dev, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn,
 yang.tao172@zte.com.cn
References: <20250918151349743KS4zJHQOoG-yPHSeAY3dv@zte.com.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20250918151349743KS4zJHQOoG-yPHSeAY3dv@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAXgGfwsstoxEh7AA--.10965S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrKr43GF1kWFWkAryUAw45trb_yoWktFg_A3
	yfXFWUAws0qF1IqFy8CFnYvr97ArW3Kr18XFsYyFyDA3WDKaykJFykXw18ZFyrGFWavr9x
	Ca95uryrXa47WjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxYjsxI4VW7JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
	WUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x
	8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7xRR6pB7UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 9/18/25 3:13 PM, shao.mingyin@zte.com.cn wrote:
> From: shaomingyin <shao.mingyin@zte.com.cn>
>
> add fixed format for the header of gfs2-glocks.rst
>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2:
> remove the "-" for only one proofreader
>   .../translations/zh_CN/filesystems/gfs2-glocks.rst   | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
> index 7f094c5781ad..abfd2f2f94e9 100644
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
> + 杨涛 yang tao <yang.tao172@zte.com.cn>
> +
>   ==================
>   Glock 内部加锁规则
>   ==================


