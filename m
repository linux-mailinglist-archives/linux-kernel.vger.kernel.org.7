Return-Path: <linux-kernel+bounces-887908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA6C39588
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4A93B56A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6102DCC1F;
	Thu,  6 Nov 2025 07:10:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A32DC771
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413021; cv=none; b=ZfTqkrPUcNpDlWXHlcmu47Q8r3XFgLD4h0uyJZhhcJvCoKx+oancSaJK6vp+SOhwGflprEZZj9TT+cTCf/QprO7w7IOmaJTUI+QXRQLyWbqnCe1X5DN9uPazY+CD770UBkzcuDpb0mHOYJKpj9Uaut1Z0MQZTUS4v0xNFnmkZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413021; c=relaxed/simple;
	bh=VJRNZcA3kTanfiZF8OZOxH78vaFDupiQD/NwZKA+vQU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rkgLIWl57JGn3EreEow30QJNvUN1SRTPeEYe3OFEjM3JECn5h5hcNi7EVDO/5xMNukXB8nQXYUFLduRhECusXxNCEMIJ+puoqupLBPg9ZgNE8CXUFxD1APfLUFJ12hef6ugAY6ww283zabNjtoWwCVUCtH9oo9VTTRHyr4zbNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dxb_DVSQxpEZkfAA--.3933S3;
	Thu, 06 Nov 2025 15:10:13 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxpeTRSQxp8V0pAQ--.58117S3;
	Thu, 06 Nov 2025 15:10:12 +0800 (CST)
Subject: Re: [PATCH] Loongarch:Make pte/pmd_modify can set _PAGE_MODIFIED
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 kernel@xen0n.name, akpm@linux-foundation.org, willy@infradead.org,
 david@redhat.com, linmag7@gmail.com, thuth@redhat.com, apopple@nvidia.com
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Liupu Wang <wangliupu@loongson.cn>
References: <20251104073006.1764241-1-zhangtianyang@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <48f8f2d8-e6e0-ec2a-7323-11551c66dac2@loongson.cn>
Date: Thu, 6 Nov 2025 15:07:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251104073006.1764241-1-zhangtianyang@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpeTRSQxp8V0pAQ--.58117S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw4DGr1rXry3GFy7Xw43urX_yoW5Jw43pF
	Z7CF9Yva1rKF1IvayfJanxXFy5AwsrGas7JwnrK3WkG34qq3yjgr4xK3y5Ar1rJaykZw18
	Zw40gws8WF47twbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=



On 2025/11/4 下午3:30, Tianyang Zhang wrote:
> In the current pte_modify operation, _PAGE_DIRTY might be cleared. Since
> the hardware-page-walk does not have a predefined _PAGE_MODIFIED flag,
> this could lead to loss of valid data in certain scenarios.
> 
> The new modification involves checking whether the original PTE has the
> _PAGE_DIRTY flag. If it exists, the _PAGE_MODIFIED bit is set, ensuring
> that the pte_dirty interface can return accurate information.
> 
> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>   arch/loongarch/include/asm/pgtable.h | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index bd128696e96d..106abfa5183b 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -424,8 +424,13 @@ static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
>   
>   static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>   {
> -	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
> -		     (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
> +	unsigned long val = (pte_val(pte) & _PAGE_CHG_MASK) |
> +		     (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
> +
> +	if (pte_val(pte) & _PAGE_DIRTY)
> +		val |= _PAGE_MODIFIED;
Since ptep_get_and_clear() is not atomic operation on LoongArch like 
other architectures, considering this scenery with HW PTW enabled:
     CPU 0:                         CPU1
                              old_pte = ptep_modify_prot_start(); 

                                   old_pte = ptep_get(ptep);

     write(buf);
*HW will set _PAGE_DIRTY bit*
                                   pte_clear(mm, address, ptep);
^^^^^^^^^^ For CPU1, bit _PAGE_DIRTY is no set in old_pte, _PAGE_DIRTY 
will be lost also. ^^^^^^^^^^^
                              pte = pte_modify(old_pte,)
                              ptep_modify_prot_commit(.., pte)

Regards
Bibo Mao
> +
> +	return __pte(val);
>   }
>   
>   extern void __update_tlb(struct vm_area_struct *vma,
> @@ -547,9 +552,13 @@ static inline struct page *pmd_page(pmd_t pmd)
>   
>   static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>   {
> -	pmd_val(pmd) = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
> +	unsigned long val = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
>   				(pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
> -	return pmd;
> +
> +	if (pmd_val(pmd) & _PAGE_DIRTY)
> +		val |= _PAGE_MODIFIED;
> +
> +	return __pmd(val);
>   }
>   
>   static inline pmd_t pmd_mkinvalid(pmd_t pmd)
> 


