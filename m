Return-Path: <linux-kernel+bounces-819058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D8B59AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAAA3AC92A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D87341ABA;
	Tue, 16 Sep 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="aSOAEb5G"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44732ED3C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034046; cv=none; b=fdZEZ3yZBADOVVZlzARtxLtS5iZsNH6FgERr+MLyUrWyNSDiKflz23C6ErYKkIQjC1xm4Qj4eQu8YjmiKJZznV1T9zUzYOdJdHM8aJIY9E+gucWxJKF3/Pfvg5iEDVVkIDsiQeefGJX2+chzJhkZVgo3bzkIQbyRw0dKwVxHIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034046; c=relaxed/simple;
	bh=iNdPy1RoJEZ6L4XEIMicV8SguEdC/4lMJe75Iqpc6C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6/rmwyxgtpvI6c6FCAAvMIcZVwzhmRuypfLyS/F88nbXkYCermv5Izbem7XMTI9fB+AFXY0teI7q6YqPblsxw+dkTBWMdfgaCmQw6QMu5uKsb/CMsObuIJkRVmVVczEicwTwDhIf7RlhrJUu6fgUpDJOTh6o19n0kuV2xqxLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li; spf=pass smtp.mailfrom=cock.li; dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b=aSOAEb5G; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.li
From: kemal <kmal@cock.li>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
	t=1758034031; bh=iNdPy1RoJEZ6L4XEIMicV8SguEdC/4lMJe75Iqpc6C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSOAEb5GMAH6RIXoRVRiUdKOKG/BUzf11lz2JzIkXW71YsF1HCSWVGR120mFnk3Rd
	 ZlZljh+td160I9cCT2ndocBGItVbxUnxftpno060IKMuWVfj0iFagh96Cn0vXINVIg
	 QOe9FSwDSfXhBbw3q2xf5SgxBYeepU2Uj5D8zkH6CuahQ290aPyMKgc0ik3ZnhO3vl
	 /lj6AlsX5ikkVDRxCfBXVK5cddRk3juNFAIwmjPDl44nFkt+6Bqruzwd2TdrejYuwa
	 9tVtEweu2nQbmOdJMa7jXBFramG61pHdvmlEEIKl1/yTUdJG0S0sR6wJRBZ8e7Dg+J
	 BLDPDo9aQXFxQ==
To: ruanjinjie@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v6 10/10] arm64: entry: Convert to generic entry
Date: Tue, 16 Sep 2025 17:46:21 +0300
Message-ID: <20250916144621.5606-1-kmal@cock.li>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916082611.2972008-11-ruanjinjie@huawei.com>
References: <20250916082611.2972008-11-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, can you make it so that this patch series support Syscall User
Dispatch? There needs to be 2 changes:

1 - Implementing arch_syscall_is_vdso_sigreturn
Here is my implementation for it:
(I checked for syscallno unlike x86, which checks if the IP exactly
matches with the VDSO sigreturn symbol. This solution seems better to me)

bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
{
	unsigned long addr, pc;

	pc = regs->pc - 4;
#ifdef CONFIG_COMPAT
	if (is_compat_task()) {
		addr = (unsigned long)current->mm->context.sigpage;
		if (pc >= addr && pc < addr + PAGE_SIZE)
			return true;
		return false;
	}
#endif
	if (regs->syscallno != __NR_rt_sigreturn)
		return false;
	addr = (unsigned long)current->mm->context.vdso;
	if (pc < addr || pc >= addr + vdso_info[VDSO_ABI_AA64].vdso_pages * PAGE_SIZE)
		return false;
	return true;
}

2 - This trick shouldn't be done if the syscall will be catched by SUD:
if (scno == NO_SYSCALL)
	syscall_set_return_value(current, regs, -ENOSYS, 0);
As the ABI could be anything.

Thanks,
-kemal

