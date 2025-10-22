Return-Path: <linux-kernel+bounces-864505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56ABFAED1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3BF46614E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E230AAC7;
	Wed, 22 Oct 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="glKVQn8w"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27143231836;
	Wed, 22 Oct 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122136; cv=none; b=sAc6d2sa09ljrcqiuYNYjDn79vr45qSpR8GPB+XSLuf6gM+BL0fgTqQs0JryXLLC9P8PHPxcW0c2s2w44Flw+0bumfNW4I+cTWWkHIb+Y6aTxEvDvau1u1qKqrF1TAsJgnfXFX1xEuLbrdEtD4g2/ygrV2U1cbhNp/kdybKZd1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122136; c=relaxed/simple;
	bh=L/vGTy9B1KwtO2hrIjD8ekgxf2pecL2RU1QcrP/nFZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V+27LAHX7hxN2fXt9IBE5/MZZuJZ95/T6HIc/HkhL64VG7MBrJGPC8uVq+j3IGaiieGoyVPjDTf/Wwk9+pTNY34gDkd38p01ntlQUeQ8xzeqCD309gr3UqpDfX+LaZtrox8awa+BlNOcv3/AivNvm9w4GXglawx/xzrIBgK7e7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=glKVQn8w; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qo1GdKEn3CCuaK6Y8fWzfgLn1TKUz0pavTTMmOLW4qw=;
	b=glKVQn8wj18tptFHj8m6X5rYciJNYiahJQxQ+3zbj7Q4ExWpMvMroXlg3ZvPQXw6dxR/zXFFl
	rRaPRt4O6Syb5VhyQSxmipNs6sZdz3hAeQgjoQ020iNkQ0m8bubRYe0CrapIFzfH/gbZ3cIKjGl
	T97n9lWyswlVmYs5kri1Crs=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cs2XT3rwTz12LKG;
	Wed, 22 Oct 2025 16:34:49 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BA489180495;
	Wed, 22 Oct 2025 16:35:30 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 16:35:30 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 16:35:29 +0800
Message-ID: <904828da-402f-499d-8904-250e78feafcf@huawei.com>
Date: Wed, 22 Oct 2025 16:35:27 +0800
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
	<oliver.upton@linux.dev>, <yeoreum.yun@arm.com>, <james.morse@arm.com>,
	<ardb@kernel.org>, <hardevsinh.palaniya@siliconsignals.io>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20251021115428.557084-1-liaochang1@huawei.com>
 <86ecqwwig3.wl-maz@kernel.org>
 <a3663aaf-14c9-4601-90e2-49650af90d7a@huawei.com>
 <867bwnwec8.wl-maz@kernel.org>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <867bwnwec8.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200011.china.huawei.com (7.202.195.155)

在 2025/10/22 16:05, Marc Zyngier 写道:
> On Wed, 22 Oct 2025 02:35:02 +0100,
> "Liao, Chang" <liaochang1@huawei.com> wrote:
>>
>> 在 2025/10/21 20:25, Marc Zyngier 写道:
>>> On Tue, 21 Oct 2025 12:54:28 +0100,
>>> Liao Chang <liaochang1@huawei.com> wrote:
>>>>
>>>> Add kernel parameter to allow system-wide EL0 access to IMPDEF system
>>>> regregisters and instructions without trapping to EL1/EL2. Since trap
>>>> overhead will compromises benefits, and it's even worse in
>>>> virtualization on CPU where certain IMPDEF registers and instructions
>>>> are designed for EL0 performance use.
>>>
>>> Since you mention virtualisation, I want to be clear: there is no way
>>> I will consider anything like this for KVM. KVM will always trap and
>>> UNDEF such register accesses, no matter where they come from (EL0 or
>>> EL1).
>>>
>>> Allowing such registers to be accessed from within a guest would make
>>> it impossible to context-switch or save/restore the guest correctly.
>>
>> You've got that right, it seems like both the guest and the host would
>> need to save and restore those IMDDEF registers with the VM or task
>> context.The only exception would be if the registers aren't for saving
>> state or configuration, but instead just act as an interface to trigger
>> a special CPU function, such as ICC_IAR1.
> 
> Funny that you mention the IAR register. Because contrary to what you
> seem to indicate, IAR does impact state outside of simply acknowledging
> an interrupt. What do you think happens to PMR, APRs, and so on?

Understood, acknowledging an interrupt will modify the active priority in
APR and current running priority in RPR.

BR
Liao, Chang

> 
> 	M.
> 


