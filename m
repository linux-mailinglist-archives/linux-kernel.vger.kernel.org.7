Return-Path: <linux-kernel+bounces-864022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F40BF9BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CA142186B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48922259F;
	Wed, 22 Oct 2025 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hX8VbUsh"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4A17BB35;
	Wed, 22 Oct 2025 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100633; cv=none; b=rTLEY8Y0c1YcX0zYUfkrVpsmXQ1VYg9bwBZsMD0Ttb4ztwChy62NeVklPVpCHxSjjHdKWVupdGFpt5d5g99uCtszea0MOhIiPUG8s9DbwzvI0iSopsvv2WwwpUOtUhLv9mHisstTaeUS6bpJgDbb9cYhtNLGa7GLkUj5qlMatIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100633; c=relaxed/simple;
	bh=s/j/zE/pGha7NcQLwNECP/pulc7Xztwb0zhdqlSqzh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nHV+s4Jt38m23cYQyQ1FJw6MTKryKZN/lnCSoAowHNxO8wGS1PvNKLyeHBpLPkVPzIegTWRXX4uwAC3IX9pjW9JlSj8O7ncH85lYeNuB9a8o2/0bMU1FZo929UKOJ1wdEE3nHpzGezfpo/6dW8o4wgOgzfP5Ocup6vBgGm9xsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hX8VbUsh; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5n0B2RsLs10RONEsKYshZ66umgt/mNFNyqb6vFixnsU=;
	b=hX8VbUshRg3DZ4q6x48tQ5ypzt33D2WMIsQ9qspL35DA53e8cSL7FPGXJ8pOVfzLcCgT9NQTY
	frbZQ9kfFEwih4GxbQWeeDveRhi2X90Cuof9ySUAdIvK3hrBYHVvFdmxXRoSMD4i4/dIdfWrcwp
	N6Z9W8p2Eu6RCQmdtxSSTd4=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4crtZN5bBFzcb1W;
	Wed, 22 Oct 2025 10:35:56 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 618C3140292;
	Wed, 22 Oct 2025 10:37:07 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 10:37:07 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 10:37:06 +0800
Message-ID: <0e885995-c85e-4f0f-b0e6-edac9928d854@huawei.com>
Date: Wed, 22 Oct 2025 10:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Add kernel parameter to disable trap EL0 accesses
 to IMPDEF regs
To: Marc Zyngier <maz@kernel.org>
CC: <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <mingo@kernel.org>, <bp@alien8.de>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <broonie@kernel.org>,
	<oliver.upton@linux.dev>, <yeoreum.yun@arm.com>, <yangyicong@hisilicon.com>,
	<james.morse@arm.com>, <ardb@kernel.org>,
	<hardevsinh.palaniya@siliconsignals.io>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20251021115428.557084-1-liaochang1@huawei.com>
 <86ecqwwig3.wl-maz@kernel.org>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <86ecqwwig3.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200011.china.huawei.com (7.202.195.155)

Hi Marc,

在 2025/10/21 20:25, Marc Zyngier 写道:
> On Tue, 21 Oct 2025 12:54:28 +0100,
> Liao Chang <liaochang1@huawei.com> wrote:
>>
>> Add kernel parameter to allow system-wide EL0 access to IMPDEF system
>> regregisters and instructions without trapping to EL1/EL2. Since trap
>> overhead will compromises benefits, and it's even worse in
>> virtualization on CPU where certain IMPDEF registers and instructions
>> are designed for EL0 performance use.
> 
> Since you mention virtualisation, I want to be clear: there is no way
> I will consider anything like this for KVM. KVM will always trap and
> UNDEF such register accesses, no matter where they come from (EL0 or
> EL1).
> 
> Allowing such registers to be accessed from within a guest would make
> it impossible to context-switch or save/restore the guest correctly.
> 
> You can of course do what you want in your downstream kernel or your
> own hypervisor, but I wanted to set the expectations on the upstream
> side.

Does it make sense to allow EL0 access IMPDEF without trapping for some
special vendor CPUID, instead of forbidding it as the default setting on
the upstream code?

BR
Liao, Chang

> 
> 	M.
> 


