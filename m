Return-Path: <linux-kernel+bounces-758844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92360B1D484
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1213B2D69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C0247291;
	Thu,  7 Aug 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RiyMlFnP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juKWrbgY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EA21ABB0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557244; cv=none; b=mwIPjQhTt25uNTnPmxya+KPE6pjhZpTcl+nHnCb/uiXwerT6ftdF2v4iWYMpuNYyF5fvV3a0mKTXrQ2nVA1dnla1a+YzFlJQKZ/RVCzS+gRGArrZ4UGMhUQu9jkuZEKApGDZwPud2+LtiMa7GpQCmQAHstNsYSrDzFE+VOOOmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557244; c=relaxed/simple;
	bh=SPoxEyD+6myc7RBU2PJYrgKIQCRRb3fizhKLMNesbaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3GAJiT2goolCD95Sae8yiCIjusKF3MWWCHfv0TbBTVC+wzxVe+M4LqKBpHDNt7TUxAOTfxDnziyjhNy81neSaBMN7b0/tnKjL2/XwimhYgE3ywTYZRjHbLwOv/5GKtk0HNlTyY2fqDwZ7ubSM8RCAs8OriQP8rBCihNQ7aKHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RiyMlFnP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juKWrbgY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754557239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGH2JlI9GUgPTp37nJfUpjH4xNokVpg8I/NQB5i9CII=;
	b=RiyMlFnPsFVsfFfA1eKzqWYLJdNr6cPH7PG5SNXUTszb/9OD34U9Q78pKDYBjTLGM1zUM+
	IfTd2lXYlDNi4xafOd9E/S1EnbbaaefDpl2P18C/JtrcOQngp2fObL+LAlsFce0RsQduV9
	zeueDV4RGpoP/MzxALULeIh4XTROpY+MFNKk0JhIUbVb8gv+R0QPjrsIli5EmrjJkC+djH
	Qy2kuV90CncwQeohaJj1PFercUpWw4A/2MQeyy6rlE62ZICwq4wTf/BJY5bcO0AP72/fh7
	3X7zCGOYChwvBiiIX0Ca0tITfwMXC2A5nC5mxui50kycGPukxnT9iEr4ZFRn5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754557239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGH2JlI9GUgPTp37nJfUpjH4xNokVpg8I/NQB5i9CII=;
	b=juKWrbgYIADz6QF0yqfi5JwtYjQPcAIg/fwsZeHkU/c5pPp3NGSjUb8fu82yE7wmBdSxs1
	MOBBpDjqtfVEwmAA==
To: kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [tip:irq/urgent] BUILD REGRESSION
 9f7488f24c7571d349d938061e0ede7a39b65d6b
In-Reply-To: <202508071514.CFNi6mo5-lkp@intel.com>
References: <202508071514.CFNi6mo5-lkp@intel.com>
Date: Thu, 07 Aug 2025 11:00:38 +0200
Message-ID: <87h5yjcxqh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 15:10, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
> branch HEAD: 9f7488f24c7571d349d938061e0ede7a39b65d6b  irqchip/mvebu-gicp: Use resource_size() for ioremap()
>
> Error/Warning (recently discovered and may have been fixed):
>
>     https://lore.kernel.org/oe-kbuild-all/202508070607.QKVa8DiU-lkp@intel.com
>
>     ERROR: modpost: __ex_table+0x1584 references non-executable section '.rodata.__func__.103779'
>
> Error/Warning ids grouped by kconfigs:
>
> recent_errors
> `-- riscv-randconfig-002-20250807
>     `-- ERROR:__ex_table-references-non-executable-section-.rodata.__func__.

This has nothing to do with the above commit. That's just a new one
of the same type as the ones which existed before:

WARNING: modpost: vmlinux: section mismatch in reference: xp_fill_cb+0x46 (section: .text.xp_fill_cb) -> .L62 (section: .init.text)
...
WARNING: modpost: vmlinux: section mismatch in reference: 0x19e4 (section: __ex_table) -> .LASF400 (section: .debug_str)

There are gazillions of them and that's a purely riscv specific related
problem.

Thanks,

        tglx

