Return-Path: <linux-kernel+bounces-673817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2747BACE640
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 23:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88DA174F44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5597212B28;
	Wed,  4 Jun 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aVv3UHTQ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81311EDA0B;
	Wed,  4 Jun 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073526; cv=none; b=sCGsZ9XGt1KtsPooiX/KbITkQrzKWp3SxYcY8nOJOY24B5oF6WceIgbuJ6m9G614UMpBfKKrTj/yYrXXTcWwNBzn6lFZXl43DcrlHTqa5JKRRDe8TVCayWVSolavKB4E7xmTPX/ilwdzMy/OsAOPhUm24BCRETeh58Wxt1ENT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073526; c=relaxed/simple;
	bh=76PKshXorjo4ztuoC1v8XHUaPlWxHm0iUJjzsuQeqDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBvIMR4J9cUyGKfagjg8moU9HwRJm9ZhwYpQcl9DnFgDr2GST65YtJoengwpasdYixs+Jy5jwC/6OcTjFuO4z3fVm7yd3PYyOWdEbHCkOUVcCfWkmqrCxLdAU/sDYi9ZEJXstYkcpKNUWZW9bndZqn3C2DJm9rbWtGChp9ER8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aVv3UHTQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3CE6B201FF58;
	Wed,  4 Jun 2025 14:45:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CE6B201FF58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749073524;
	bh=8ZEvYXDUXqUYL2U4yUoW9/H/AvBZH66drMq9cCnWHGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVv3UHTQKVgOQ5XsgnaygQFe03yxAZNtEsH3jGkDUPvYuK34m4Z7khFKcra3lSHee
	 XhLPJqXAbk34Fd+VuAGMjmGmH42rlQEZXAg3DL7+J7tnfZuV3zI1sYAuo2V7xnAJVa
	 1kCbZehw9I9ISiM1y4Am8D2DN/7jVGD5QHx83oCQ=
From: Roman Kisel <romank@linux.microsoft.com>
To: anirudh@anirudhrb.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com,
	sudeep.holla@arm.com,
	apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH] firmware: smccc: support both conduits for getting hyp UUID
Date: Wed,  4 Jun 2025 14:45:21 -0700
Message-ID: <20250604214522.3523-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094049.960056-1-anirudh@anirudhrb.com>
References: <20250521094049.960056-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>
> When Linux is running as the root partition under Microsoft Hypervisor
> (MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.
>
> Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
> arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
> of supporting only hvc.
>
> Boot tested on MSHV guest, MSHV root & KVM guest.
>
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/firmware/smccc/smccc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> index cd65b434dc6e..bdee057db2fd 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -72,10 +72,7 @@ bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>  	struct arm_smccc_res res = {};
>  	uuid_t uuid;
>
> -	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
> -		return false;
> -
> -	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
>  	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
>  		return false;

The patch is a strict superset of the existing functionality.
Validated on baremetal Linux and KVM, Apple M3 nested virt., various client and
server ARM64 systems running Windows ARM64 with VMs managed by Hyper-V and OpenVMM.

Looks good to me.

Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

