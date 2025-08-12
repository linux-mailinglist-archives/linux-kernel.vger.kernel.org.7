Return-Path: <linux-kernel+bounces-763813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8FBB21A97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8B81889CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B022D97A3;
	Tue, 12 Aug 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DoHPqktM"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB3A95C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964413; cv=none; b=nR6v1blDxp3uuvi29MdJ/LKVxDBjK8dA/lS+wCcitAjRmYn1SMH3x2yASU0KatTY0dHmPY2G969jkZyQZZszBOxDwu+DEeT4gVtPfaSRU+rn2a2sOCUHTNJzJ5PAj3Rakco4LOYE2X1FNijIeybkqit1i4eqWc8cYT87Sb7E3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964413; c=relaxed/simple;
	bh=Q4Z3qXVn3J42JB4Mt5A9yNqNBJp506Y4Xw/nPFcjBzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkX/Fbf5AIBXKeQQfTLnlYGMHA5S0En+Jb4OLbD7ub8En76rFaOGMUasbQW74soaA1rH3csBcYEKLSLV2vcALTA3+2fIEFs8UppBS/gVd5f2i/rt86w7OWNxt3DIPG9OZJbSvvse6uAW31Ce0u9JyKwKsa0YXkHHlMaNiJx6+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DoHPqktM; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed67c8bd-9e79-47c7-9186-910b530a191c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754964408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb/42nEJ2muvgQ6lHP6YmjzEIJNGbje0iFA6wKFEZGI=;
	b=DoHPqktM0aPB4n3AoOiG1up3ZkRzWty4W+nNKrOxLXLVrlZGsjqBjruYe121OlVLz//lUU
	RBCayvb/D6083F02bS2koJX41z6kK3V0hHh5aB3ksOLkB+oUrVitNdJd+We9JjbNBShijh
	EjPLHv/xotIxI7NLXz1GtVU5I3nRMRw=
Date: Tue, 12 Aug 2025 10:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of
 kvm_get_vcpu()
To: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn,
 zhaotianrui@loongson.cn, chenhuacai@kernel.org, lixianglai@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250811025544.458422-1-gaosong@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250811025544.458422-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 8/11/25 10:55 AM, Song Gao 写道:
> Use kvm_get_vcpu() may can't get vcpu context, use kvm_get_vcpu_by_id()
> instead of kvm_get_vcpu().
Since using kvm_get_vcpu() may fail to retrieve the vcpu context,
kvm_get_vcpu_by_id() should be used instead.

Under this premise, and under the premise of making revisions
in accordance with Bibo's and Huacai's suggestions，pick up my tag in v2.

Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cm>

Additionally, do we need a fixes tag?

Thanks,
Yanteng
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   arch/loongarch/kvm/intc/eiointc.c | 5 ++++-
>   arch/loongarch/kvm/intc/ipi.c     | 2 +-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
> index a3a12af9ecbf..5180da91d2e6 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -45,7 +45,10 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
>   	}
>   
>   	cpu = s->sw_coremap[irq];
> -	vcpu = kvm_get_vcpu(s->kvm, cpu);
> +	vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
> +	if (unlikely(vcpu == NULL)) {
> +		return;
> +	}
>   	if (level) {
>   		/* if not enable return false */
>   		if (!test_bit(irq, (unsigned long *)s->enable.reg_u32))
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index e658d5b37c04..0348a83a7ed7 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -298,7 +298,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev,
>   	cpu = (attr->attr >> 16) & 0x3ff;
>   	addr = attr->attr & 0xff;
>   
> -	vcpu = kvm_get_vcpu(dev->kvm, cpu);
> +	vcpu = kvm_get_vcpu_by_id(dev->kvm, cpu);
>   	if (unlikely(vcpu == NULL)) {
>   		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
>   		return -EINVAL;


