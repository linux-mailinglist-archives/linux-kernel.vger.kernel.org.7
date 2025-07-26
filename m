Return-Path: <linux-kernel+bounces-746840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD80B12BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3DD177675
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799CA288C9C;
	Sat, 26 Jul 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0gnxEDj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEA1B4248
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555023; cv=none; b=iAaDMVN8A2Zzwts3SWJJsZSGjjUc3xBtNmOChM9uf5DPxQZdWmr1CAk0UQqmRpSAwk1E5zkziTldqsRmKYTJnvk6Jzv15r5MNYQrX1ymFfQ/qtXShsmpUdonSG/aBlbywddMVM6GrrQ+InC4JmVSA3MIKTq2KulcoJAqa+4CVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555023; c=relaxed/simple;
	bh=wJaOsXIJfuq0ic1DGjE1tBK2mIUUuFDFBblMg6pSJPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0FAN3Sisjgyn0gpzXf1xalNqUX+rMDMkJmDNernkqo/V9s+lTbv6/lKS3yyt1nhnsi++W/H8Jfdc2pzFo2x9maNeB+tMJbTVpFGLtwuBQmtTXPLIutG/uIEOhq5GOvIklx2C4f8viVOua+wrbcCsxCUiI8jlMq+qRGP4mU+RBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0gnxEDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9FAC4CEED;
	Sat, 26 Jul 2025 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555023;
	bh=wJaOsXIJfuq0ic1DGjE1tBK2mIUUuFDFBblMg6pSJPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0gnxEDjlA/8MHvDPk4VLhu2+Ol9SzXH/UxlomcH7yoN9bI0tna6Wm9JxSwiwiDF8
	 Ssi19+Z+ANff19qOwCrrY+Zv/aiuI1kLASexs+XI3mjFBVPvmXYpDz0ZKtp2qfTD/5
	 4YSYIQujXv3aJvISuKe8LxNR+TF1JUMxqNRjy/nXlbhropw188cFGEjpn/vHx92NSQ
	 Is0WMdsWMF9hwmsH2BjA78MDj6ri60En9eywgjZaKohuzXuLhEyYQ4tbK6QZL+mUur
	 z0CEBgPf7zjlWtmQl86EvSSsopRu63VjpI/hHuXeTjni22P45/8vl0jJZffLkKP4n0
	 +Em7ZhTs4SrFw==
Date: Sat, 26 Jul 2025 11:37:01 -0700
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aIUgTTOcuNAJqZvg@x1>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <cc82c938-def3-4df6-9fc9-fc321af7d54a@iscas.ac.cn>
 <DBL2588APTCA.2XUKQCJ0DW89C@ventanamicro.com>
 <feb3549f-da91-4eaa-a624-b9f35db6ba3c@iscas.ac.cn>
 <DBLCYPBLQBSQ.170ND7Z93GPK4@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBLCYPBLQBSQ.170ND7Z93GPK4@ventanamicro.com>

On Fri, Jul 25, 2025 at 08:47:04PM +0200, Radim Krčmář wrote:
> 2025-07-25T23:01:03+08:00, Vivian Wang <wangruikang@iscas.ac.cn>:
> > On 7/25/25 18:18, Radim Krčmář wrote:
> >> 2025-07-24T05:55:54+08:00, Vivian Wang <wangruikang@iscas.ac.cn>:
> >>> On 7/19/25 11:39, Drew Fustini wrote:
> >>>> From: Drew Fustini <dfustini@tenstorrent.com>
> >>>> Clobbering the vector registers can significantly increase system call
> >>>> latency for some implementations. To mitigate this performance impact, a
> >>>> policy mechanism is provided to administrators, distro maintainers, and
> >>>> developers to control vector state discard in the form of a sysctl knob:
> >>> So I had an idea: Is it possible to avoid repeatedly discarding the
> >>> state on every syscall by setting VS to Initial after discarding, and
> >>> avoiding discarding when VS is Initial? So:
> >>>
> >>> if (VS == Clean || VS == Dirty) {
> >>>     clobber;
> >>>     VS = Initial;
> >>> }
> >>>
> >>> This would avoid this problem with syscall-heavy user programs while
> >>> adding minimum overhead for everything else.
> >> I think your proposal improves the existing code, but if a userspace is
> >> using vectors, it's likely also restoring them after a syscall, so the
> >> state would immediately get dirty, and the next syscall would again
> >> needlessly clobber vector registers.
> >
> > Without any data to back it up, I would say that my understanding is
> > that this should be a rare case, only happening if e.g. someone is
> > adding printf debugging to their vector code. Otherwise, vector loops
> > should not have syscalls in them.
> >
> > A more reasonable worry would be programs using RVV everywhere in all
> > sorts of common operations. In that case, alternating syscalls and
> > vectors would make the discarding wasteful.
> 
> Good point.  Yeah, auto-vectorization might be hindered.

Yes, I think that userspace vector usage will become more common over
time even for "ordinary" programs as compilers and libraries improve.
For example, it may be the case that the majority of userspace binaries
will use vector once the ifunc memcpy patches go in.

> In the worst case, users could just notice that it's slowing programs
> down, and disable it without looking for the cause.

I think that a default policy of not clobbering in syscalls would be the
best trade off. I gave CONFIG_RISCV_ISA_V_VSTATE_DISCARD a default of n
in this patch, and I imagined that people like Palmer, who wanted it for
test suites, could change the default or use the sysctl.

> 
> >> Preserving the vector state still seems better for userspaces that use
> >> both vectors and syscalls.
> >
> > If we can expect e.g. userspace programs to primarily repeatedly use RVV
> > with no syscalls between loops, *or* primarily repeatedly use syscalls
> > with rare occurrences of RVV between syscalls. This way, the primarily
> > syscall programs can benefit from slightly switching, since there's no
> > need to save and restore state for those most of the time. In effect,
> > syscalls serves as a hint that RVV is over.
> 
> This would need deeper analysis, and we will probably never be correct
> with a system-wide policy regardless -- a room for prctl?
> 
> I think there might be a lot of programs that have a repeating pattern
> of compute -> syscall (e.g. to write results), and clobbering is losing
> performance if a program does more than a single loop per switch.

It's interesting that you mention prctl as it does seem like that could
play a role here. If people think that one syscall clobbering behavior
for the whole system is too limited, then maybe prctl could be a better
solution. I believe it should default to not clobbering. It could be
enabled for test suites in CI that want the strict clobbering, or for
programs that are known to work better with clobbering enabled.

Thanks,
Drew

