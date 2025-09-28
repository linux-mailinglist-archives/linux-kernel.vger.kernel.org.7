Return-Path: <linux-kernel+bounces-835402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65013BA6FE4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B50189B244
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8095E2DAFA9;
	Sun, 28 Sep 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MFweJCNk"
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5A2D5C9E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058858; cv=none; b=qa/c5RGqEw/wugi44dWGQqGwROvPUdUuOTEnOIJPNEBaqRrRxs0NyMFBjRFk5XUsKIs/1WF49ctumCwfR/Jw6RazIVlrEo2RNXYwNIHEVUIm2G8VvzkBPXRctHyXtAb4keKj1t8CZj+YeqkxArolQ/gnVTY25xGD1YU0UtwhHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058858; c=relaxed/simple;
	bh=NA70EMhWVGY0vu0NypQnKfysp037PAxoMAR2ZsoPqvg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jtFkTRbz3dGwzzhHWZePPVNJU0rf/bciPr7WkYP4hWT54NlPcW3QKZojMLqcUam/IERTGjZLgx56B4Ksm+S0KDVwjn2Zc15H1SqpReyS1uDsfMxx27DQX9/K6S1G6Zajdy2NL0A+u/cchiXFbCTgdaThBdnama543vzppIfxesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MFweJCNk; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cZMVR2pwxzvX9R
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:27:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kNC29xo2Oju4FNTLwauE84cDif4ZKmEqMXzXqRGThAY=;
	b=MFweJCNkJkCRBZNcz+nfn33DwMc2XANO/SdftOX3ToXpjpKSkajogomX1g3tVbBFfspi4YbbW
	sb0l2yxtrGDqLme8n7yTVrSVZKdGDN6CHSjQeN4ULEmDoN8GGiTgkKs+Shi55BAKNjHOTTwj8bG
	+gg3s0DO3qheXJvP0BiL+QM=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cZMVV11WGz1prKR;
	Sun, 28 Sep 2025 19:27:14 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D62A140155;
	Sun, 28 Sep 2025 19:27:24 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 28 Sep 2025 19:27:23 +0800
Subject: Re: [GIT PULL] arm64 updates for 6.18
To: Will Deacon <will@kernel.org>
CC: <torvalds@linux-foundation.org>, <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@android.com>, <brauner@kernel.org>
References: <aNbJ0YiL7Us_eicz@willie-the-truck>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4016897f-42a5-bb18-4ebb-80de97f99a60@huawei.com>
Date: Sun, 28 Sep 2025 19:27:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aNbJ0YiL7Us_eicz@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/9/27 1:13, Will Deacon wrote:
> ACPI, EFI and PSCI:
>  - Decouple Arm's "Software Delegated Exception Interface" (SDEI)
>    support from the ACPI GHES code so that it can be used by platforms
>    booted with device-tree.
> 
>  - Remove unnecessary per-CPU tracking of the FPSIMD state across EFI
>    runtime calls.
> 
>  - Fix a node refcount imbalance in the PSCI device-tree code.
> 
> CPU Features:
>  - Ensure register sanitisation is applied to fields in ID_AA64MMFR4.
> 
>  - Expose AIDR_EL1 to userspace via sysfs, primarily so that KVM guests
>    can reliably query the underlying CPU types from the VMM.
> 
>  - Re-enabling of SME support (CONFIG_ARM64_SME) as a result of fixes
>    to our context-switching, signal handling and ptrace code.

IIRC they're 6.16 stuff [*].

[*] https://lore.kernel.org/all/20250528114103.GA27965@willie-the-truck

Thanks,
Zenghui

