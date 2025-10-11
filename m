Return-Path: <linux-kernel+bounces-849073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD25EBCF25D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187DF19A00E7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DAD2367CF;
	Sat, 11 Oct 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GH8FXvrP"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC253595B
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171938; cv=none; b=kezVtDzPb01O8v3hTisxr95Aqd59cxT2hg0Cp0HKv993Kyo7wgVqE//PCduembEzANC6U67/dGQPOcKB9GTGZF3PLmHbFQdpBjtT9i2iUYl9ysTPIZHpqxykNXmSNSkcfCtuQtKR0Pvf4oPX4+zsE0rWLHcSmlrCJo1DsYAHrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171938; c=relaxed/simple;
	bh=Xd8rdUfoPMg6QaScAWlW2FrpZAahiivHRi2Hl750VIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puwwke0Qq9HebyRiANKWty9PLgASrIXJBW642IAbuA3Y7E+/H+JthT/4pFI+M3V4IaKAx7e1YXP0H989aEkKuMxfgGepj4nBn9wycxGmzp/7a9Vg4lFgI7esjpwI13X9lo1CcaR3XIsaHZTcLeQESjz+X8G/yHEeZz1fG0wOAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GH8FXvrP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1AE7020EF2;
	Sat, 11 Oct 2025 10:38:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KfWdQL3U1iZv; Sat, 11 Oct 2025 10:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760171915; bh=Xd8rdUfoPMg6QaScAWlW2FrpZAahiivHRi2Hl750VIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GH8FXvrPy+0BGJjsWRtz+eW5+JgBvE1LO0VkIVxwueYQOj1iT3bX5umkqIWiHMNhg
	 8ae4UZyh81KcaBb88gWGYK3RjrHLmDiohtVEcKnxGV8Xq4QZJRhtPO+PqyiMVsfUsX
	 L1DtIgHC1WNjP54ZCzjFQqGrtD4Bf2KgT3cspnnQzH9p22uZOt+pYSXqAPwxqUFBmX
	 dkPcQIeWe9RgX6z362LS97wRKEKIYblSNjcqsMLKziaYokV7AgWuCZZzIG2MBhASPK
	 81YX1QdfbhxjzQ3azxu8+h6ptnJyRU4MgVyeSQL9AAf8XREHmpKF0sLzNI2Ktiw/Tu
	 kwwWecrBEhb2Q==
Date: Sat, 11 Oct 2025 08:38:22 +0000
From: Yao Zi <ziyao@disroot.org>
To: Paul Walmsley <pjw@kernel.org>, torvalds@linux-foundation.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
Message-ID: <aOoXYHaFe-R7ZySY@pie>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>

Hi Paul, Palmer,

On Mon, Sep 29, 2025 at 02:00:17AM -0600, Paul Walmsley wrote:
> Linus,
> 
> The following changes since commit a03ee11b8f850bd008226c6d392da24163dfb56e:
> 
>   riscv: Fix sparse warning about different address spaces (2025-09-05 15:33:52 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-mw1
> 
> for you to fetch changes up to 0b0ca959d20689fece038954bbf1d7b14c0b11c3:
> 
>   riscv: errata: Fix the PAUSE Opcode for MIPS P8700 (2025-09-19 10:33:56 -0600)

...

> Guo Ren (Alibaba DAMO Academy) (1):
>       riscv: Move vendor errata definitions to new header

As already noted by Han Gao[1], it seems the second patch of series
"riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup"[2] is included in the
pull request for 6.17-rc1, but not this one for 6.18-rc1. Is this
expected?

Best regards,
Yao Zi

[1]: https://lore.kernel.org/all/CAAT7Ki9_Vm0+v9RHpa2w-Bg3agJy2Tp4d6+tcPJ=M7XX3GV-7Q@mail.gmail.com/
[2]: https://lore.kernel.org/all/20250713155321.2064856-1-guoren@kernel.org/

