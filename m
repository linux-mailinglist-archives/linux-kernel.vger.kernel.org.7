Return-Path: <linux-kernel+bounces-848830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A56BCEA72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B77754FE719
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F255305046;
	Fri, 10 Oct 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjIavNT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754CB304BDD;
	Fri, 10 Oct 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133363; cv=none; b=D/ZUyqtw89w7sl7r1VApMMus1qCrlfKKOAGN3tLxvbs0Ikjq4UWWrHmSJJ55GCWautETk0Ket+fMJ4up4jShA/LBlxcLgitU/T++X+A20gxuz/kLyHCEO72iMMPgpYAQVC+e+myCGgiCF2UK0tkVwppS/HsN+VNazl/g1531GNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133363; c=relaxed/simple;
	bh=t46kjDiMah/zekXRjDSdXOUOoGpyx+/Cr/l+MUXLY2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+kME6KmdZCpbMGba0rHfWSJeiEbbnyMZylXDFyhqUpHS1lAq6b3pWDy+aQpKOyjKNFsQwZ7sDQG13FcCDdT8FXQZW7OE0arfo4O+sQPmCevJt0fQ1+RfH5IhosaN3uTC87rBGrvJKAhc74zmzF+5nf9JB+HblC/Fy42pMoqOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjIavNT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BB6C116B1;
	Fri, 10 Oct 2025 21:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760133362;
	bh=t46kjDiMah/zekXRjDSdXOUOoGpyx+/Cr/l+MUXLY2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjIavNT6UwXft3fPGYaDZegvMKYz7k1JTExmOJxuY2GHFkxK3+P1IF43CEAgpsW8r
	 B9vhEvi8TGbAcG2tlmWcIvRf0JDg5Da9goDcUmaqveQx1c8JPyqYojIXAHjpIRdKUR
	 nsKDBzD/vYVXCxfJ1nin7+bADQwh1MO8lWoSqp6SVgbNhdDtMrZuIAT6wC0czf9rP1
	 LJazopt5R6e0qzH9j1ETdj1Db2ig1vzyozO7zToh3qL2QUDQf52M13GMRfLqcZvkZA
	 fGcsyhxLrid9YbehH7WfhnQOQb9udnaBlMsQf6BkC2ShRCY9S9dGNqX8+NB0SriV+O
	 W2FnDW5kd7cGQ==
Date: Fri, 10 Oct 2025 14:56:00 -0700
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [External] [PATCH v4 0/3] RISC-V: Detect Ssqosid extension and
 handle srmcfg CSR
Message-ID: <aOmA8DNt/y+WxT97@x1>
References: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
 <CAEEQ3w=3pte5=CR9-R3rmCGFZ9ErJ9YcWS9i=JwPUb1Ty3ipwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEQ3w=3pte5=CR9-R3rmCGFZ9ErJ9YcWS9i=JwPUb1Ty3ipwQ@mail.gmail.com>

On Fri, Oct 10, 2025 at 08:23:50PM +0800, yunhui cui wrote:
> Hi Drew,
[snip]
> > I think it makes sense to first focus on the detection of Ssqosid and
> > handling of srmcfg when switching tasks. It has been tested against a
> > QEMU branch that implements Ssqosid and CBQRI [6]. A test driver [7]
> > was used to set srmcfg for the current process. This allows switch_to
> > to be tested without resctrl.
> 
> Could we consider submitting the entire QoS functionality as a single
> integrated patchset (indicating the upstream branch that the patchset
> is based on)? This should include the content from
> https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylibre.com/

Thanks for the feedback. I had thought that submitting Ssqosid
separately would streamline the review of the parts that most affects
existing arch/riscv code (like switch_to.h) before adding code for CBQRI
and resctrl integration.

But I have gotten similar feedback from another person too. I can post a
complete series that adds Ssqosid and CBQRI support including the
resctrl interface. I have a cbqri branch [1] on top of riscv/for-next.
I need to clean up some of the code, and then I can send a series with
ssqosid+cbqri.

That cbqri branch just has device tree support in order to demonstrate
the resctrl functionality. However, I did also work on support for the
ACPI RQSC table earlier this year for a proof of concept [2]. I have
been thinking that I will hold back the ACPI support until after Ssqosid
and CBQRI support is reviewed. It also depends on some improvements
regarding the ACPI PPTT table that James Morse is currently working on for
ARM MPAM support [3].

Thanks,
Drew

[1] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/cbqri
[2] https://lf-rise.atlassian.net/wiki/spaces/HOME/pages/433291272/ACPI+RQSC+Proof+of+Concept
[3] https://lore.kernel.org/all/20250910204309.20751-1-james.morse@arm.com/

