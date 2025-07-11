Return-Path: <linux-kernel+bounces-727124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162BB01554
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DFA5A1D28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF3C1FAC54;
	Fri, 11 Jul 2025 08:02:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719271F63CD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220962; cv=none; b=qEu7kMgUi1Xgl4nt09K6oSOu4VrIwk0bMAgsMpe260WP7C1kLcesTOIGBsVDzCV6fJo9z8hN9ogXz7ud3PlZ0+4ma/vwkUSJwfEd+UaZ8vtf94915FLx7+X1Z6nnjDVQP2VR1y/A/GFyXFbFXKRcuEsfBGeOskg8NdMgdYvWxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220962; c=relaxed/simple;
	bh=4GfM1GlzhKpqAq6O9YYpgkq3ZIOfijGF3h8PYS/sE3Y=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JKD+sDhqGXveQjowJVz52QoaU9267HS6v0Y5alEAVriHf0FU/BYuSfc8VNkS4v8SXHWhKOUNtU4oD1TU4cpHO1isvFUFc+oEtJmRzDyj+N/duwxuQzUUPoOKWotXVjc9Vgw652NVxL2oAIjxN2pyFQGucvSnA/YYbEeROemLMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bdkbk4QFCzXfBn;
	Fri, 11 Jul 2025 15:58:10 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 423211402CC;
	Fri, 11 Jul 2025 16:02:37 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 16:02:36 +0800
Subject: Re: [PATCH] KVM: arm64: fix u64_replace_bits() usage
To: Arnd Bergmann <arnd@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Joey Gouly <joey.gouly@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Mark Brown <broonie@kernel.org>, James
 Morse <james.morse@arm.com>, Sebastian Ott <sebott@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250711072752.2781647-1-arnd@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <60a9ec28-cf1a-a504-25f6-523471732f38@huawei.com>
Date: Fri, 11 Jul 2025 16:02:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250711072752.2781647-1-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/7/11 15:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> u64_replace_bits() returns a modified word but does not actually modify
> its argument, as pointed out by this new warning:
> 
> arch/arm64/kvm/sys_regs.c: In function 'access_mdcr':
> arch/arm64/kvm/sys_regs.c:2654:17: error: ignoring return value of 'u64_replace_bits' declared with attribute 'warn_unused_result' [-Werror=unused-result]
>  2654 |                 u64_replace_bits(val, hpmn, MDCR_EL2_HPMN);
> 
> The intention here must have been to update 'val', so do that instead.
> 
> Fixes: efff9dd2fee7 ("KVM: arm64: Handle out-of-bound write to MDCR_EL2.HPMN")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 33aa4f5071b8..793fb19bebd6 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2651,7 +2651,7 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
>  	 */
>  	if (hpmn > vcpu->kvm->arch.nr_pmu_counters) {
>  		hpmn = vcpu->kvm->arch.nr_pmu_counters;
> -		u64_replace_bits(val, hpmn, MDCR_EL2_HPMN);
> +		val = u64_replace_bits(val, hpmn, MDCR_EL2_HPMN);
>  	}
>  
>  	__vcpu_assign_sys_reg(vcpu, MDCR_EL2, val);

Already fixed by Ben's patch [*], thanks!

[*]
https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?h=fixes&id=2265c08ec393ef1f5ef5019add0ab1e3a7ee0b79

Zenghui

