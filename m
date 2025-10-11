Return-Path: <linux-kernel+bounces-849259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA62BCFAE1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16F1402A41
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2CD283C9F;
	Sat, 11 Oct 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkeP6di5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5E27D784;
	Sat, 11 Oct 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207749; cv=none; b=UzZNxnd5a0QrjCM6w7ckk82fLEJerjqUa9NW0r833kDO8Zo0QYqtxr22l0EJT8jnrKwDUGk1URW4Jp9YWy1ON/BlYugfqYsnR5eKiwbOsfpwVXaxJlN5aVIIFMdv11j1Qbo31gd0Zw03cBHH9+yvhkSlYtCNPgggZ8/WMTfJoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207749; c=relaxed/simple;
	bh=JeuSNzjb79cav9xRsG19ffG5ht+YAnWGI0rfqrrmt6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp6fEsrg5UQPqXNVbqQtlMeFecQNP9omMgg+Hy4w4nmb93e41cSBV1Q7PUqVM72+H49ZasjpB89DkiArbMfHqVhbh1L9/ydgZQRctdd/9W3cmrat7sWNcb+f5ZMfXG35c4p5/kcBd4Z0+PyUonCeU87C8YlHq4uaGlMGofkyyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkeP6di5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2710C4CEF4;
	Sat, 11 Oct 2025 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760207749;
	bh=JeuSNzjb79cav9xRsG19ffG5ht+YAnWGI0rfqrrmt6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkeP6di5m0EgJnl2GOAGJ5PUXel0ftXpzo47oa7h0EvDeMh9jw7oyZMPFAjin3TYz
	 qWsvH1GcS4RmDiKvBwU8vwce608CNe/q+9v1NoTqiPk7VhAitsfRX9SXuqH8DEdZxd
	 iPRdimfzkusnwIDOvr8oc1Q7aLgx/jbZ/oEUXRAaL38tI6rVKQMuBqAF/KI0RHw/wA
	 TuTZ9TofIjxUHltuAn2YdLSSP9CNhYXDIr82hec85R4rEfW/GYNxacpCGUctemaFfo
	 13y14rfKeOagDpBT1nrfGj4JQ5U/GHpR7YUX3p5rrxVh7xhkLZs58BXrrOwPwa9q8S
	 TnT2rzPjlzt4A==
Date: Sat, 11 Oct 2025 11:35:46 -0700
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid
 ext
Message-ID: <aOqjggmTr4ioHwB/@x1>
References: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
 <20251007-ssqosid-v4-3-e8b57e59d812@kernel.org>
 <DDDL94HT7HYF.3VU2WQYU4WZY5@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDDL94HT7HYF.3VU2WQYU4WZY5@ventanamicro.com>

On Thu, Oct 09, 2025 at 08:47:27AM +0200, Radim Krčmář wrote:
> 2025-10-07T23:21:12-07:00, Drew Fustini <fustini@kernel.org>:
> > diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> > +static inline void __switch_to_srmcfg(struct task_struct *next)
> > +{
> > +	u32 *cpu_srmcfg_ptr = this_cpu_ptr(&cpu_srmcfg);
> > +	u32 thread_srmcfg;
> > +
> > +	thread_srmcfg = READ_ONCE(next->thread.srmcfg);
> > +
> > +	if (thread_srmcfg != *cpu_srmcfg_ptr) {
> 
> Wouldn't prev->thread.srmcfg have the value of CSR_SRMCFG when executing
> switch_to?

Thanks for reviewing. Yes, you are right that prev->thread.srmcfg should
have same value as CSR_SRMCFG. Are you suggesting that the cpu_srmcfg is
not necessary as prev->thread.srmcfg should have same value?

Drew

