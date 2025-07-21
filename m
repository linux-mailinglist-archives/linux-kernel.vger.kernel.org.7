Return-Path: <linux-kernel+bounces-739879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8143B0CC97
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8711723C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE923F413;
	Mon, 21 Jul 2025 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVOh4WwK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD123ABAB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133308; cv=none; b=tEjAyBRxLqGe/MjXlWXv1eEqf6fehlM5bL3iBKWRuTRCWR4Nnk/SVJIgpmkjCMZ1uzkgcmBhYarHAhMvCzvi1F5vNWZNzva7Jm88103BqUIYmi3z81fhQBPNnPYusdCuL4uyKSpuUSkf9i4uaWqN7gC4nsjgFxGtimNbkP7X1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133308; c=relaxed/simple;
	bh=Z8+145n3stoZJ1eS9MsnjPvQqiSlyo+W5TQZfHtKrUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH4AhoTmpB7gxD6nuw1GF7PRLvHUY1FAc4ttP0zPAmlL+wwGdECcDSilLeNrSJlZdG8S0tX2/qe639x+8s8FfqIy+BlcxOmZY2HExfGaLDJG6G5XwUiUFD/XbxMT/c1HJ4th4LEPruDYnMWia0nF96QkTSed7Ntlr3XyA+FlwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVOh4WwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F59C4CEED;
	Mon, 21 Jul 2025 21:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753133308;
	bh=Z8+145n3stoZJ1eS9MsnjPvQqiSlyo+W5TQZfHtKrUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVOh4WwKApPd6X2J5mzxgp8A1Vofa6hw9Z+zz43nWSfXDOjtqhv/CZSMWwa/ZCdle
	 8uHhIs130sO+bjzMOJzk54DYQObGa2jnuuAZebCAEXhInWZS9nhqT/0AwZmoGiN8c2
	 oUt81RyYmIm731on+mES3ZJtZImksoqz2S0GLfs0iJ9xBrg5nYXFGdw2wtZ3Z930Gg
	 hPMOdR+xIB1vlCRlRGwAqoVD2C1Qn1oTtbNdx/4rCeeE0jJLP8hbY6L7OyquJ5EPS7
	 14lz93ETEKwT08+0zVp/ENFWEKNknwbPtVdp2k1+2vLZXFNkiR189jjKc6EXgQaMAL
	 CimI5viN6pofQ==
Date: Mon, 21 Jul 2025 14:28:26 -0700
From: Drew Fustini <fustini@kernel.org>
To: Darius Rad <darius@bluespec.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aH6w+in5tCe42Kvc@x1>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <aH4u_OHqZHZtXjn3@localhost.localdomain>
 <aH6qO3c39gmybwEc@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH6qO3c39gmybwEc@x1>

On Mon, Jul 21, 2025 at 01:59:39PM -0700, Drew Fustini wrote:
> On Mon, Jul 21, 2025 at 08:13:48AM -0400, Darius Rad wrote:
> > On Fri, Jul 18, 2025 at 08:39:13PM -0700, Drew Fustini wrote:
> > > From: Drew Fustini <dfustini@tenstorrent.com>
> > > 
> > > Clobbering the vector registers can significantly increase system call
> > > latency for some implementations. To mitigate this performance impact, a
> > > policy mechanism is provided to administrators, distro maintainers, and
> > > developers to control vector state discard in the form of a sysctl knob:
> > > 
> > > /proc/sys/abi/riscv_v_vstate_discard
> > > 
> > > Valid values are:
> > > 
> > > 0: Do not discard vector state during syscall
> > > 1: Discard vector state during syscall
> > > 
> > 
> > Is the intention for this this mean "don't guarantee vector state is
> > clobbered" or "preserve vector state"?  I suspect it is the former, but the
> > wording seems unclear.  Additionally, if that's indeed the case, maybe the
> > documentation should more clearly articulate the tradeoff (performance vs.
> > security/robustness).
> 
> Thanks for your comment. I agree it could be worded better and the trade
> off should be explained. I believe the motivation behind clobbering in
> all syscalls was to make sure that userspace does not rely on the vector
> being preserved through a syscall. The goal of this strictness was to
> catch any programs that were misbehaving.
> 
> Thus, it might be better if I described it as:
> 
> 0: Vector state is not strictly clobbered in all syscalls
> 1: Mandatory clobbering of vector state in all syscalls

Darius - sorry, I seem to have failed to put you in the To: field of my
reply.

Thanks,
Drew

