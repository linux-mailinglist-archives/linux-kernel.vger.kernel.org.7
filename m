Return-Path: <linux-kernel+bounces-736185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DBBB099CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98F27A1762
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF91A23A5;
	Fri, 18 Jul 2025 02:32:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFA192598
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805928; cv=none; b=YswUK6EwjKEt0h4MvLqusc2r+UDNrtf203VKaX8BZ7nJ+43PV8ggWp7mkoJgsVYATs3yKMeadXyY/wQrsBCPABASMtl4rMOk2lpLys9TZ8p5XaFrjeNT8nzfworcDzyZHkkoXZv+5FeD0G8GcrsPUWInehpb3D4GOYrYMMBgmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805928; c=relaxed/simple;
	bh=R9OH3vIsRbQ2qkCL2Wec5pMYKZZY7OAwuWLWAc7X/1U=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=u+49e6cFRpOf97f7ql3IdfB5pGuTZmBoMCUmwpiOWw0UxxowhSAZ80Pu9OWA4ijSB/A3rElY9pQ2lU2xNJ+vvfdkbcvxBAgqmsHmCl4DAIrq94gEQO1Oe651yoGIBEt4QwO8rl33z1pph/HJcFwzmr3lIjGHfbhbZi8bU/YQ/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bjtyv2YnFzvPtk;
	Fri, 18 Jul 2025 10:29:11 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 78150140279;
	Fri, 18 Jul 2025 10:32:01 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 10:32:01 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 10:32:00 +0800
Message-ID: <24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com>
Date: Fri, 18 Jul 2025 10:32:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <kristina.martsenko@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mark.rutland@arm.com>, <sashal@kernel.org>,
	<yangjiangshui@h-partners.com>, <zouyipeng@huawei.com>, <justin.he@arm.com>,
	<zengheng4@huawei.com>, <yangyicong@hisilicon.com>, ruanjinjie
	<ruanjinjie@huawei.com>
CC: <inux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Liao, Chang" <liaochang1@huawei.com>
Subject: [RFC] SCTLR_EL1.TIDCP toggling for performance
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200011.china.huawei.com (7.202.195.155)

Hi, Kristina

I've reviewed your patch [1] for FEAT_TIDCP1 support, which by default traps EL0
accesses to implementation-defined system registers and instructions at EL1/EL2.

Do you have any plans to add support for toggling the SCTLR_EL1.TIDCP1 bit? I'm
encountering performance degradation on CPU where certain implementation-defined
registers and instructions are designed for EL0 performance use. The trapping
overhead is substantial enough to compromise any benefits, and it's even worse
in virtualization. Therefore, I'm hoping there's a way to clear the SCTLR_EL1.TIDCP1
bit on such platforms, perhaps via a kernel config option or command-line parameter.
Alternatively, do you have a better solution for gracefully toggling this bit on
and off?

Thanks

[1] https://lore.kernel.org/linux-arm-kernel/Yrw3NWkH6D0CgRsF@sirena.org.uk/T/#m5cfdb27b48d9d7e30db73e991fc6c232ba8a7349

-- 
BR
Liao, Chang


