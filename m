Return-Path: <linux-kernel+bounces-819860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEAAB7DBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8F6323A05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740572F39B5;
	Wed, 17 Sep 2025 01:55:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0921255E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758074144; cv=none; b=oEeI3CD9Y/itQw1NlD+jkGDt3DURsPbyk7YPGnLJI/TcUHvLdqydrFC2xhjzBiwV0fb2L4frRgCjWr7Yfs6pIZ71ifU6tx6ekpQXho41oCW1J5W0d09Q1iVNBaopNZp1hUvp7CHyv6kV8juv2mOCoUv501WuumtH2yzNS3ICfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758074144; c=relaxed/simple;
	bh=pSiwS+fvWAkXRKSkV6pu1Bbkql+YetxKgndWwlX4Gsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wk0pvsA5jO8oIiBNyJw2gCkthKYPQxL4/WGXMN7w19virTckxK22tRYodw7Qiu5G248lOiSo8wGVbRNrrE2wu/4bkrfrWnutHsO5aM3XFblvLdrMLUM7FvC6S7riW6t+v7nFKjQ0Mnvv6LZbmmSew6NtQJZ6gn0kyFIcNPcz0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cRMDh1ScZzRkGD;
	Wed, 17 Sep 2025 09:51:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id BCFE91402C1;
	Wed, 17 Sep 2025 09:55:37 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 09:55:37 +0800
Message-ID: <886f1357-8d14-bb63-bf46-837bb6922ebd@huawei.com>
Date: Wed, 17 Sep 2025 09:55:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v6 10/10] arm64: entry: Convert to generic entry
Content-Language: en-US
To: kemal <kmal@cock.li>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250916082611.2972008-11-ruanjinjie@huawei.com>
 <20250916144621.5606-1-kmal@cock.li>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250916144621.5606-1-kmal@cock.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/9/16 22:46, kemal wrote:
> Hi, can you make it so that this patch series support Syscall User
> Dispatch? There needs to be 2 changes:
> 
> 1 - Implementing arch_syscall_is_vdso_sigreturn
> Here is my implementation for it:
> (I checked for syscallno unlike x86, which checks if the IP exactly
> matches with the VDSO sigreturn symbol. This solution seems better to me)
> 
> bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> {
> 	unsigned long addr, pc;
> 
> 	pc = regs->pc - 4;
> #ifdef CONFIG_COMPAT
> 	if (is_compat_task()) {
> 		addr = (unsigned long)current->mm->context.sigpage;
> 		if (pc >= addr && pc < addr + PAGE_SIZE)
> 			return true;
> 		return false;
> 	}
> #endif
> 	if (regs->syscallno != __NR_rt_sigreturn)
> 		return false;
> 	addr = (unsigned long)current->mm->context.vdso;
> 	if (pc < addr || pc >= addr + vdso_info[VDSO_ABI_AA64].vdso_pages * PAGE_SIZE)
> 		return false;
> 	return true;
> }

Thank you! I will try to implement arch_syscall_is_vdso_sigreturn() as
this and test it. By the way, is this for supporting arm64 in wine?

> 
> 2 - This trick shouldn't be done if the syscall will be catched by SUD:
> if (scno == NO_SYSCALL)
> 	syscall_set_return_value(current, regs, -ENOSYS, 0);
> As the ABI could be anything.

This requires discussion with Catalin and Will, which may alter the
original intent.

> 
> Thanks,
> -kemal

