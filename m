Return-Path: <linux-kernel+bounces-581418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55155A75F16
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA62167B03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6EA19CCFA;
	Mon, 31 Mar 2025 06:54:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1587192D96
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404075; cv=none; b=PrfR+fGGLElbo8vy5oOff2UL6W3HbTUTggAJLFYw3uJX/md8nuN+Z+EXslXWgQQ1TE5As3JWdLVT2FHMgTkV5mS6gXSN6xYZ5tNljOIMr/3pE2Y9rX1wgf7xA9HELPAEn4B6LJvMC/ggnIr7DUWQM0/JAcHa4ABx5Xb07h/+VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404075; c=relaxed/simple;
	bh=YVZprOIJjhTejkn+2yrh+GejzKo3uE8v8jqzT2YetXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERW+Dw3JSclsdoQZILlrI7GU8rDh1GoSCo5DFQrqYdreEpjayxOcT1iS+LRhd8gVVn98TnKL0CxdDJI9ahnJPCRwwWvE94Vh6czGmi6Oz4eyF4faxtmg+NTii18Em5mrx3UQLeApoA2gCa+fUHvHC57HxXQMJWVwE5kUXNfpLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZR1x40ZN5z6M4hZ;
	Mon, 31 Mar 2025 14:50:48 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FD01140257;
	Mon, 31 Mar 2025 14:54:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 08:54:23 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 31 Mar 2025 08:54:23 +0200
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Oliver Upton <oliver.upton@linux.dev>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] smccc: kvm_guest: Align with DISCOVER_IMPL_CPUS ABI
Thread-Topic: [PATCH] smccc: kvm_guest: Align with DISCOVER_IMPL_CPUS ABI
Thread-Index: AQHbnzaiWLoM4Pr1N0ylxjrv88F9hLOM1NNw
Date: Mon, 31 Mar 2025 06:54:23 +0000
Message-ID: <e670c3778d794d82878d0b4cdd3d11d5@huawei.com>
References: <20250327163613.2516073-1-oliver.upton@linux.dev>
In-Reply-To: <20250327163613.2516073-1-oliver.upton@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Oliver Upton <oliver.upton@linux.dev>
> Sent: Thursday, March 27, 2025 4:36 PM
> To: kvmarm@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Mark Rutland <mark.rutland@arm.com>; Lorenzo Pieralisi
> <lpieralisi@kernel.org>; Sudeep Holla <sudeep.holla@arm.com>; Catalin
> Marinas <catalin.marinas@arm.com>; Marc Zyngier <maz@kernel.org>;
> Oliver Upton <oliver.upton@linux.dev>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Subject: [PATCH] smccc: kvm_guest: Align with DISCOVER_IMPL_CPUS ABI
>=20
> The ABI of the hypercall requires that R2 and R3 are 0. Explicitly pass
> 0 for these parameters.
>=20
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Fixes: 86edf6bdcf05 ("smccc/kvm_guest: Enable errata based on
> implementation CPUs")
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Thanks,
Shameer

> ---
>  drivers/firmware/smccc/kvm_guest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/smccc/kvm_guest.c
> b/drivers/firmware/smccc/kvm_guest.c
> index 5767aed25cdc..ac2d3cf8a776 100644
> --- a/drivers/firmware/smccc/kvm_guest.c
> +++ b/drivers/firmware/smccc/kvm_guest.c
> @@ -95,7 +95,7 @@ void  __init kvm_arm_target_impl_cpu_init(void)
>=20
>  	for (i =3D 0; i < max_cpus; i++) {
>=20
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_DISCOVE
> R_IMPL_CPUS_FUNC_ID,
> -				     i, &res);
> +				     i, 0, 0, &res);
>  		if (res.a0 !=3D SMCCC_RET_SUCCESS) {
>  			pr_warn("Discovering target implementation CPUs
> failed\n");
>  			goto mem_free;
>=20
> base-commit: 369c0122682c4468a69f2454614eded71c5348f3
> --
> 2.39.5


