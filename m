Return-Path: <linux-kernel+bounces-838026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64421BAE41C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C763A19273D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D94E263C9E;
	Tue, 30 Sep 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hkWwgsEb"
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4F1E868
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255132; cv=none; b=SA6SkfLpMHWUCpia9yow2jqeDdiOgYJem7Liy8EJgqbUdbJIgIoDF4j+euCg9JAwniCfNLz07vpi5mV6HrmNApF/p7ZTNnfpYg7HKeDfn9zVsPKWQvoF/B0P200JkIOTw0vktekH80YUYItuIERkfRMN9nfg2xdNZtsg/8oqLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255132; c=relaxed/simple;
	bh=ADwZswRbbWhsUCbTkCZdA4DKpC45e3S8HDF0kMLhXfE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gTCl46CxKK+bqxsHu2mly7o9VLr1qR0Uq4xxcV/P1WEqNKG5leI4SZLnEJqQWWSrlmknR/ogi8WVEWrjDLV5hysXbFRpCt+nYK/RZrX4eyDvKDX0BAGphsRLZBWWDxfwC370JfJLikNSdLBEgZ2Hi/3D+z2N3fmGPXBpWQvUww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hkWwgsEb; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Abuvdp6dvcP4pY2sYCbxIW6RxmXHacrG5s1S0+d8Jjs=;
	b=hkWwgsEbgCcQFMRP9aZB8XnU+yzXypXbwAPTH2NCWuuksjHy2aP/gVbgLF8/VxbH54g1zm4Da
	KwoV3C5mC2moRqmwVfIEYz8049YoF4KG451Lf42a1DaAxYcAeqwb/ajF89naiQl+11M3S4QYrFD
	LWMzFhkY8b0bWeKRYTPMUe8=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cbm4j4m5xz1T4Fp;
	Wed,  1 Oct 2025 01:58:13 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id E27131800B1;
	Wed,  1 Oct 2025 01:58:37 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 1 Oct 2025 01:58:36 +0800
Subject: Re: [PATCH] KVM: arm64: Remove unreachable break after return
To: Osama Abdelkader <osama.abdelkader@gmail.com>
CC: <maz@kernel.org>, <oliver.upton@linux.dev>, <joey.gouly@arm.com>,
	<suzuki.poulose@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250930135621.162050-1-osama.abdelkader@gmail.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8e289e80-60ca-977f-97a2-cbe1146baaf7@huawei.com>
Date: Wed, 1 Oct 2025 01:58:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250930135621.162050-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/9/30 21:56, Osama Abdelkader wrote:
> Remove an unnecessary 'break' statement that follows a 'return'
> in arch/arm64/kvm/at.c. The break is unreachable.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  arch/arm64/kvm/at.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
> index d71ca4ddc9d1..b04c00f95944 100644
> --- a/arch/arm64/kvm/at.c
> +++ b/arch/arm64/kvm/at.c
> @@ -43,7 +43,6 @@ static enum trans_regime compute_translation_regime(struct kvm_vcpu *vcpu, u32 o
>  	case OP_AT_S1E2W:
>  	case OP_AT_S1E2A:
>  		return vcpu_el2_e2h_is_set(vcpu) ? TR_EL20 : TR_EL2;
> -		break;
>  	default:
>  		return (vcpu_el2_e2h_is_set(vcpu) &&
>  			vcpu_el2_tge_is_set(vcpu)) ? TR_EL20 : TR_EL10;

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks,
Zenghui

