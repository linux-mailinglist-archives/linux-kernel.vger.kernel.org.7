Return-Path: <linux-kernel+bounces-863968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5DBF99E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13D673547DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A1F1FE451;
	Wed, 22 Oct 2025 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EHecl6k1"
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46D1F181F;
	Wed, 22 Oct 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096910; cv=none; b=QUDM4XKY/sxflXQ2QL1HQdGwSoIM4EzBL8d5zi0EehO57620NJKKlJtpVIBWrpYlw+dZwABkGIvaL9GOcNIdH5yAX5DIsBQ5QjKa9Ns+hjHp4SDgMvheYxmxs0/lZVZziW42RFGYyWrJWWOav0H0FOcnahziMfOOUFS3SwTkc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096910; c=relaxed/simple;
	bh=vaoB1vhVUzy/nptxwNJGhhyV0PdrEEq0LszYhAyPYyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IVkn7c+gCHn5LhNUZedkGozZR2J0iXhfOMpQzDf98YDwXZuklwIx9pfHPBGLpNZg3NJvXm3WZpPuJqmre0d+UC+DH89xUg/olGtLxck6qElh8/yO8/eGKBh53y/EMOW7puqb8C2+6P99f18hQldF/Ust9XMzJbAqdcAxHOjqAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EHecl6k1; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IEt2zGmZj6lPzbXEb1Zf3HAtidB4DnYkLZze/rH/nlc=;
	b=EHecl6k1H8ZMxAvgF1e3uN3F3lo3vLhujVmGVHcbENeT7kf79Tv5AeWjmNmrlinBpqNfA7hYW
	N6s26ZZ6lxB/jMKn9ivWsUytuLYjxzDEaX4zmbKnyPhkB8MRCzq1WwJzegSI+fBgMZ4NSb0IKQr
	LJz7iSrzS0Ctz2Xvr/Ilhig=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4crsC7502lz1T4Fg;
	Wed, 22 Oct 2025 09:34:11 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A79818006C;
	Wed, 22 Oct 2025 09:35:05 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 09:35:05 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 09:35:04 +0800
Message-ID: <a3663aaf-14c9-4601-90e2-49650af90d7a@huawei.com>
Date: Wed, 22 Oct 2025 09:35:02 +0800
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
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <86ecqwwig3.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200011.china.huawei.com (7.202.195.155)

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

You've got that right, it seems like both the guest and the host would
need to save and restore those IMDDEF registers with the VM or task
context.The only exception would be if the registers aren't for saving
state or configuration, but instead just act as an interface to trigger
a special CPU function, such as ICC_IAR1.

BR,
Liao, Chang

> 
> You can of course do what you want in your downstream kernel or your
> own hypervisor, but I wanted to set the expectations on the upstream
> side.
> 
> 	M.
> 


