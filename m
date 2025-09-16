Return-Path: <linux-kernel+bounces-818379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18630B590EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D907A177D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8C2874F3;
	Tue, 16 Sep 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apa+aU43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51E285C9A;
	Tue, 16 Sep 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012008; cv=none; b=j5b9pXNvSxA3Eh/Q8fwcYLeltsoTyu5VSaYHfPGg+VDc7FOVJg+nGodo94JWq38qehA70E1gsQOPeYF9ucTM1i5fdE4pr3CJbUF/WomtwAtnaXwLO1Y4x4uXrCoGY6wI/HhseGZGqxsa6/QKK4UIMaklKzjuOShv9zAieeK93/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012008; c=relaxed/simple;
	bh=TkEDRubaFnasxH43gJIkhStFdKmrHOl5HziunN9y1ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu7gQP/7kfDuguEbouDUPWPkrSSB+4phQXu5vVYadYMLqD3eMVXVLOXFfTXCeK1Hqgl4Q7qPlweFYhXqgfzgt2fO1YKzsmje1AsO8Mxf+4Nli2sXn3839phRcfEl3mWIG4qUITXrwYb8b1EFc6kqzqKscMIeLQeNlH0Xjto2iG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apa+aU43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963A5C4CEEB;
	Tue, 16 Sep 2025 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758012008;
	bh=TkEDRubaFnasxH43gJIkhStFdKmrHOl5HziunN9y1ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Apa+aU43uDrCpxAMDbWtRUwpR1esMRY5nyDWOrYpuhxtBCDciLMVw9MmgPYWTn+Bu
	 RCi/5X49BFO6h8IK3cTEaaOUcd3E5pJtjW8heKzuSF8AcZ3oeZQsYNvZq0L81F0ERG
	 5LGGG5iq0YG/DGww4/Q1qf13ruQzuE21WjvQEmpz9qeKinP4RPvJuBsZ7bSQV4rvw1
	 bo9mdaUpxbH1ajyoBo8Hj3VhFBswJHZ1gF8fBUqrIM64Pq/dyP/2fesbSuz+u6TZ/B
	 eot1MtV9XVDJq4HhKnr8evrRxFQ4dJzZR5zlVv3VZr5cJFOWER995/vGzvURYovjiI
	 DEVEfrHo4VBiA==
Date: Tue, 16 Sep 2025 09:40:02 +0100
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
Message-ID: <20250916084002.GF1637058@google.com>
References: <cover.1756987761.git.zhoubinbin@loongson.cn>
 <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
 <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>

On Fri, 12 Sep 2025, Binbin Zhou wrote:

> Hi Lee:
> 
> On Thu, Sep 11, 2025 at 10:33 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > > This patchset introduces the Loongson-2K BMC.
> > >
> > > It is a PCIe device present on servers similar to the Loongson-3 CPUs.
> > > And it is a multifunctional device (MFD), such as display as a sub-function
> > > of it.
> > >
> > > For IPMI, according to the existing design, we use software simulation to
> > > implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
> >       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> > [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
> >       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3
> 
> Thanks for acknowledging my patchset.
> 
> I can't confirm why you didn't apply the IPMI patch, but this appears
> to break the patchset's integrity, potentially causing missing Kconfig
> dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).

Pretty sure this doesn't break anything.

What build errors do you see as a result?

> Additionally, as Corey previously explained[1], this patch can be
> applied through your side.
> 
> [1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/

We only apply cross-subsystem patch-sets to a single tree if there are
good reasons to do so.  In this instance, I can't see any reason why the
IPMI driver cannot go in via it's own repo.

-- 
Lee Jones [李琼斯]

