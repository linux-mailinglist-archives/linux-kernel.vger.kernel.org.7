Return-Path: <linux-kernel+bounces-635139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DCAAB9DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A845172D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9D22D4FD;
	Tue,  6 May 2025 04:09:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42F307204
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746502464; cv=none; b=mfDAvxlTk18tCPdU9mKySRuxGrPJ5+O0fP61ZZ+BOCk+jYBjqnexeAys1aNXiT1Y0RPuySB9ulaz5E2ic9omYINcF/T2zLKRTn59QuMdlI1jbcUyeX3q/tdbbjDrWDgyNI0L51HW7FoEeeeLQ6BTf8INcnzS9e9MNNVqaXVtU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746502464; c=relaxed/simple;
	bh=YXxzwzUfShMmUTLeJNa4UxyS7JtYbIjaxIMf/MdcsGo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jcqy52sWQlmYes4jF2FqOAcOpFTt0wgs8dGx+1kl+cieGP/gU9vBTZoXjxUjupljKeZvIMxPrUvEHRzi7+ZzYAMz5VNDubm8BCphRCtHmLfhICD6gpmlVCa/mIV5tJWbVhiwf+KLuxSIE3pGnhTYbok+AVA6Wqlb8YitR2lsNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zs3mq2C3BzyVKC;
	Tue,  6 May 2025 11:30:03 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 2974A180B5F;
	Tue,  6 May 2025 11:34:18 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 11:34:16 +0800
Subject: Re: [PATCH] arm64: kvm: Replace ternary flags with str_on_off()
 helper
To: Seongsu Park <sgsu.park@samsung.com>
CC: <will@kernel.org>, <catalin.marinas@arm.com>, <suzuki.poulose@arm.com>,
	<joey.gouly@arm.com>, <oliver.upton@linux.dev>, <maz@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <cpgs@samsung.com>
References: <CGME20250415012410epcas1p42b48977934c21b5db0b19f4185f7a63c@epcas1p4.samsung.com>
 <1891546521.01744691102904.JavaMail.epsvc@epcpadp1new>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <112b336f-40ee-113b-2b10-4ba2f19573de@huawei.com>
Date: Tue, 6 May 2025 11:34:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1891546521.01744691102904.JavaMail.epsvc@epcpadp1new>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk200017.china.huawei.com (7.202.194.83)

It'd better to write the subject as "KVM: arm64: Replace ..."

On 2025/4/15 9:24, Seongsu Park wrote:
> Replace repetitive ternary expressions with the str_on_off() helper
> function. This change improves code readability and ensures consistency
> in tracepoint string formatting
> 
> Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
> ---
>  arch/arm64/kvm/trace_arm.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks,
Zenghui

