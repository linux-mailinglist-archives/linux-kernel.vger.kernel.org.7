Return-Path: <linux-kernel+bounces-822161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05AB83307
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F8C7A4A52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89387275AF6;
	Thu, 18 Sep 2025 06:49:08 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58014286;
	Thu, 18 Sep 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178148; cv=none; b=aPdAh0xOEoMYku9VLoZdrQJIq02gVfBjThymTfOLt4f2wX4+CXs7vApIEl+qNy2fAvCgFFUd4Ld7Ykd3aLhJlMZl+rBUcovYLWGkQgyYyF/+4endXVcRS9UkjjdqWTll/jtU+Fd6+o+/cXWXYrFnUG8wSZVHSG72F7fAnsCNMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178148; c=relaxed/simple;
	bh=iN07TlijF7X0XxRjt3t1RcNAfh6X8YuurUaWn0yXl3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTcgf5G5WOO1QVi49fTMFa9WHeGAIFwm3WwAEd6n4twsh5A4hQwDcU4P4MMBGZ7gMYJQbSHiGRHl68Xv4rs/H5jcO0q5b8xzV3tLL1OSBbd8TxSfLp7n1ia/fdlAnr7eZmvAPBpgzKW5GsIMyXXl0SKn1rahgNEB8YLmzF8rAQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrACHjqYpq8tomTZ7AA--.36831S2;
	Thu, 18 Sep 2025 14:48:09 +0800 (CST)
Received: from [10.12.170.88] (unknown [10.12.170.88])
	by gateway (Coremail) with SMTP id _____wDHX1Mnq8tons6nAg--.6346S2;
	Thu, 18 Sep 2025 14:48:08 +0800 (CST)
Message-ID: <5631b0e1-03e4-43a2-9586-77bb20690520@hust.edu.cn>
Date: Thu, 18 Sep 2025 14:48:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/zh_CN: align title underline for ubifs.rst
To: shao.mingyin@zte.com.cn, alexs@kernel.org
Cc: si.yanteng@linux.dev, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn,
 yang.tao172@zte.com.cn
References: <20250918143643417OPRH_RjCXkCa3aCtQEX3Y@zte.com.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20250918143643417OPRH_RjCXkCa3aCtQEX3Y@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrACHjqYpq8tomTZ7AA--.36831S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrur4UZFW5ZF13Ary8Cr1kGrg_yoWDAFg_A3
	s7Xa1vvF4UZryIqFn5JF15Xr17AFWS9348XFsFyFykAw1UWFWDXa4DX3s5uaykZr47ury3
	Ww4kZr9YgF1aqjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcV
	Cjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0X_-JUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 9/18/25 2:36 PM, shao.mingyin@zte.com.cn wrote:
> From: shaomingyin <shao.mingyin@zte.com.cn>
>
> align title underline for ubifs.rst
>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>


Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>


> ---
>   Documentation/translations/zh_CN/filesystems/ubifs.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/filesystems/ubifs.rst b/Documentation/translations/zh_CN/filesystems/ubifs.rst
> index 16c28bfd6fc3..2491c059ec25 100644
> --- a/Documentation/translations/zh_CN/filesystems/ubifs.rst
> +++ b/Documentation/translations/zh_CN/filesystems/ubifs.rst
> @@ -17,7 +17,7 @@ UBI 文件系统
>   ============
>
>   简介
> -============
> +====
>
>   UBIFS 文件系统全称为 UBI 文件系统（UBI File System）。UBI 代表无序块镜
>   像（Unsorted Block Images）。UBIFS 是一种闪存文件系统，这意味着它专为闪


