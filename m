Return-Path: <linux-kernel+bounces-818543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE705B59319
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25437A9699
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1812F83B0;
	Tue, 16 Sep 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzuD4Nu/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAF281356;
	Tue, 16 Sep 2025 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017684; cv=none; b=aWAsOYKlRgEaNtI93L7XOp7JDrSXgto/vDY4NO/3l2iXbjD+1Aplqe+bKc8HGCvhiTW939qKj0txMLmDXl3bZ6dOmM88w5oU/uDQYXJ8sG+8jiy1ehvCk2D2u24oIZJX8D7egPZFPt/n0FdHjDuEPJa+kU+ArillC7LkekZTFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017684; c=relaxed/simple;
	bh=arzOWVmuLmMGxUl6lo77+C7iboIEFTgklaWej9NK1PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqZc5Lt6V8Z5LKIhN7Sl/2q0t8VvfeI5cIoO4t+PBo2NkpE7X2atO5fjkG2YxDVhzVWLp/227xTI6LMQdxFsLMRdvoELVjCapqLTEjvTIrewiYtLbqTbPW7JfephJMlpAix4xCMhka0UZ0fg3rAYOJfxuacqnACgqss1O72OXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzuD4Nu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7362DC4CEEB;
	Tue, 16 Sep 2025 10:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758017683;
	bh=arzOWVmuLmMGxUl6lo77+C7iboIEFTgklaWej9NK1PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzuD4Nu/adR5HeASBSkVzFa/K441a5afdSrjOjgbhIjYbJpTxBjoSnLF+kG7QRtKy
	 pQd1pHGsz51bPLanIzzeH1btbEhCi/bbhs/4wyN3te+bLjKdYZKbKLBr+bhxzC6xKp
	 O5E0MIT8Q3gMrDAgZyKzEvy8L7gQJKxpZ0VeBVr+t07gS6/0f6dakTJUS+WehO7T30
	 mgNDfWP5MsA8cRHx1GBmVMm+NTx4G83vGR/rQBk+xS619dC4VRCP0AFkj8yOXSMER+
	 guDUXfTuFNwrQZnQljVyZLyyAJ1+UyurnQMiWW+FRQW9KGIAZi2bLr4Zo3/0TsSWXO
	 vwTvrVgmop+1A==
Date: Tue, 16 Sep 2025 11:14:38 +0100
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
Message-ID: <20250916101438.GA3585920@google.com>
References: <cover.1756987761.git.zhoubinbin@loongson.cn>
 <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
 <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>
 <20250916084002.GF1637058@google.com>
 <CAMpQs4+J2zYgZaGYBSaf4UwzKZY-qMoD1oe2vmgJQXAfghqu=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4+J2zYgZaGYBSaf4UwzKZY-qMoD1oe2vmgJQXAfghqu=w@mail.gmail.com>

On Tue, 16 Sep 2025, Binbin Zhou wrote:

> Hi Lee:
> 
> Thanks for your reply.
> 
> On Tue, Sep 16, 2025 at 4:40 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Fri, 12 Sep 2025, Binbin Zhou wrote:
> >
> > > Hi Lee:
> > >
> > > On Thu, Sep 11, 2025 at 10:33 PM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > > > > This patchset introduces the Loongson-2K BMC.
> > > > >
> > > > > It is a PCIe device present on servers similar to the Loongson-3 CPUs.
> > > > > And it is a multifunctional device (MFD), such as display as a sub-function
> > > > > of it.
> > > > >
> > > > > For IPMI, according to the existing design, we use software simulation to
> > > > > implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.
> > > > >
> > > > > [...]
> > > >
> > > > Applied, thanks!
> > > >
> > > > [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
> > > >       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> > > > [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
> > > >       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3
> > >
> > > Thanks for acknowledging my patchset.
> > >
> > > I can't confirm why you didn't apply the IPMI patch, but this appears
> > > to break the patchset's integrity, potentially causing missing Kconfig
> > > dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).
> >
> > Pretty sure this doesn't break anything.
> >
> > What build errors do you see as a result?
> >
> > > Additionally, as Corey previously explained[1], this patch can be
> > > applied through your side.
> > >
> > > [1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/
> >
> > We only apply cross-subsystem patch-sets to a single tree if there are
> > good reasons to do so.  In this instance, I can't see any reason why the
> > IPMI driver cannot go in via it's own repo.
> 
> However, there still seems to be a text dependency issue. The IPMI
> patch modifies the MAINTAINERS, which depends on the first patch.
> If the entire series of patches cannot be merged together, does this
> mean the IPMI patch can only be merged after the MFD patch has been
> merged into the mainline?

No, not at all.  So long as all patches come together during the
merge-window, there is no issue.

-- 
Lee Jones [李琼斯]

