Return-Path: <linux-kernel+bounces-776787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2BBB2D17D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48669626092
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A7239E63;
	Wed, 20 Aug 2025 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="kuIybhDG"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31F4C79
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653777; cv=none; b=r6sZKpqeGDJZS66BjL75KJpQFAttbPpRgZcGGEQRdo+A8PmIdb48dks5woHTvfPAl1e3nxfMkNmjBR3QCmmbkphl6kyJoEwCYI6HdwjDOTcPEmgobELXplOGoebDdJmVGVtYilnBwidgWli6fR9ympO7TcfAbYg9tIXR28LyiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653777; c=relaxed/simple;
	bh=MsS03uyWpiN7TIXL6CbEDyKMPqRUxyLCbAcch74Bncg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHP3qd83+CEiLKxAAX24C4+aEdlbVbgFqZpwkI0wKLV9hToMs0pbumol0GynoFY3Z1QuCFhBgRTovFaH5ZKblLdLS8g7IC5HTJ4JY0IiGLY0XV2xK7d3MvLkK6cqktqwDOT/2lJr4PlhZcvCCQ76NWDvoyZj8fus+4vI2hwSKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=kuIybhDG; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755653747;
	bh=PHH0p/H5lFqtTHzUuz0kk2sdxbWVGk0kXQ5fYSA4qcE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=kuIybhDGXdtGg4fHFmT02tn+CLGYj1HKzfKfdgXlpVRNHrkZwKyuRNDBodePn3fBl
	 00axKJDbC8212DcBaAaRnCrrwa0d8gG+p9Tn6U2svIOL6F3CIzMFE0+fJECKbclPTX
	 AD8p6CyqOuNkHUGPzWVVzumcKVXo+y/DzyTL69aw=
X-QQ-mid: esmtpsz18t1755653741t5092c507
X-QQ-Originating-IP: ipC4SzT/JkcI+Osg2Ysr385xqXVuXGF6QRu7OFb5bYI=
Received: from = ( [120.239.196.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 09:35:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10776672245163589342
EX-QQ-RecipientCnt: 15
Date: Wed, 20 Aug 2025 09:35:39 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Drew Fustini <fustini@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Darius Rad <darius@bluespec.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Florian Weimer <fweimer@redhat.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Drew Fustini <dfustini@tenstorrent.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3] riscv: Add sysctl to control discard of vstate on
 syscall entry
Message-ID: <694A9E5FCE0EEEFD+aKUmaxvbpuKN3_oz@LT-Guozexi>
References: <20250819-riscv_v_vstate_discard-v3-1-0af577dafdc2@kernel.org>
 <9D2DE979F179BFC6+aKUlbEZa2vvgmGdQ@LT-Guozexi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2DE979F179BFC6+aKUlbEZa2vvgmGdQ@LT-Guozexi>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OYjaY80FOgjaB278vw7c4rAOYa/NbFm/OVDVbMXdiM4BccJkVcPmaybb
	viL7W6yBebFAvLf4VUqrK//nexSG7jaGJ3gThiFrelsC6ROpGFrDmdCuq+0KUdtqEaMmkHJ
	1yCR/wY59J2GDiSqK9j3lHdAbuWd7A3EzLorDs6gnBySirJUcPIb97pgxfm5TYudWlydxSD
	YGlc1SV27QWtxUiEN5WR5EkA0o22SskrqzVMGrx/JurIRzdawhcDHW3QzH37qE30snzXUwd
	D+qRWFEmKu8+P3Nffq2ogx0z2hHJNXcvEsAXgx9ecmskXcZIuTG0Q7yt0SuKd2CiIqkHKWU
	E/laTMFMAQww52cRuuUAUB65kKmzRKJO4vt05q+F5wGuI5H0zZEYkpZEQaO/uNGteN7P1QQ
	qmmgiqGKFrFWug22cf1okbsQp33R2ZzBET6XJ+ax+OUnZfUAJ9eWza/r2P5tgoyezaHmRQ3
	WgIj8L0M1BId0u4Ixw3ZgkfyQCe0pux0Cp5QaBh4AeSd6WyWYyNuARcxpqRfzm/xmzltmrP
	rZ07WLHklVWJ4BG98A6F1XlThbKVjh0y5hhDCxdrzXBwIajI1zfNrq8mAeHr93qB+wk+hRX
	e1dVrQjni70EyxAEgURAF8LN6UYCP671/ZfHp+qe6y9bi4N2kZoEJ1dWCnwvl+2RpjC5kaL
	ZXfe5KxRD23lNNAwpOvEmegftLYzItlNtz3a92Ih5cliwDSyJ8y3O80lpbtGlBfG/cJ3h7S
	HiGMwrbKNGYe7MJGZ6Y6S/elyjJKWPMDBiGR1ZBvXYH98vIk1c3E2fIx2G1yw6pU+X9OFUj
	ahACeq8ExLJtNUbheIjh3gebkAk1vvEKU2abtzaTg7iN8Wb8zPYgSLFgq4ZxrPc0fHmlfix
	tkipTYXXG2j7cz/3KoMVOJeL7fOt2cEfKe57R60Yt0j7WOV2JQz0WJlxI4cahbwjRuil2PX
	g28KkqmB2HQ1TVn5/WoBk3l1P10FzxHY5N4R+aNCDf5PYwuMdkogBsxORhCb+U5590nf3PD
	M6Omd/SaJOvS9AKThaI43KCaruFrb74GScsX0TKrKVfAuVGgRWfLnKWm5QR5UlThppijw4H
	weA9nNMY1xiRgNpAJGjRgj7KK1U6ztlawgpmGnPWrwPUtWZwH69rMZ8pzFfEiHxnQ/aLVWP
	lwpc
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 09:31:24AM +0800, Troy Mitchell wrote:
> On Tue, Aug 19, 2025 at 02:40:21AM -0700, Drew Fustini wrote:
> > From: Drew Fustini <dfustini@tenstorrent.com>
> > 
> > Vector registers are always clobbered in the syscall entry path to
> > enforce the documented ABI that vector state is not preserved across
> > syscalls. However, this operation can be slow on some RISC-V cores.
> > To mitigate this performance impact, add a sysctl knob to control
> > whether vector state is discarded in the syscall entry path:
> > 
> > /proc/sys/abi/riscv_v_vstate_discard
> > 
> > Valid values are:
> > 
> > 0: Vector state is not intentionally clobbered when entering a syscall
> > 1: Vector state is always clobbered when entering a syscall
> > 
> > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> > 
> > Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
> > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > ---
> > Changes in v3:
> >  - Reword the Kconfig description to clarify that the sysctl can still
> >    be changed during runtime regardless of the initial value chosen
> >  - Improve the description of vstate clobbering and the sysctl in
> >    section 3 of vector.rst
> >  - v2: https://lore.kernel.org/linux-riscv/20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org/
> > 
> > Changes in v2:
> >  - Reword the description of the abi.riscv_v_vstate_discard sysctl to
> >    clarify that option '0' does not preserve the vector state - it just
> >    means that vector state will not always be clobbered in the syscall
> >    path.
> >  - Add clarification suggested by Palmer in v1 to the "Vector Register
> >    State Across System Calls" documentation section.
> >  - v1: https://lore.kernel.org/linux-riscv/20250719033912.1313955-1-fustini@kernel.org/
> > 
> > Test results:
> > I've tested the impact of riscv_v_vstate_discard() on the SiFive X280
> > cores [1] in the Tenstorrent Blackhole SoC [2]. The results from the
> > Blackhole P100 [3] card show that discarding the vector registers
> > increases null syscall latency by 25%.
> > 
> > The null syscall program [4] executes vsetvli and then calls getppid()
> > in a loop. The average duration of getppid() is 198 ns when registers
> > are clobbered in riscv_v_vstate_discard(). The average duration drops
> > to 149 ns when riscv_v_vstate_discard() skips clobbering the registers
> > because riscv_v_vstate_discard is set to 0.
> > 
> > $ sudo sysctl abi.riscv_v_vstate_discard=1
> > abi.riscv_v_vstate_discard = 1
> > 
> > $ ./null_syscall --vsetvli
> > vsetvli complete
> >  iterations: 1000000000
> >    duration: 198 seconds
> > avg latency: 198.73 ns
> > 
> > $ sudo sysctl abi.riscv_v_vstate_discard=0
> > abi.riscv_v_vstate_discard = 0
> > 
> > $ ./null_syscall --vsetvli
> > vsetvli complete
> >  iterations: 1000000000
> >    duration: 149 seconds
> > avg latency: 149.89 ns
> > 
> > I'm testing on the tt-blackhole-v6.16-rc1_vstate_discard [5] branch that
> > has 13 patches, including this one, on top of v6.16-rc1. Most are simple
> > yaml patches for dt bindings along with dts files and a bespoke network
> > driver. I don't think the other patches are relevant to this discussion.
> > 
> > This patch applies clean on its own mainline and riscv/for-next.
> > 
> > [1] https://www.sifive.com/cores/intelligence-x200-series
> > [2] https://tenstorrent.com/en/hardware/blackhole
> > [3] https://github.com/tenstorrent/tt-bh-linux
> > [4] https://gist.github.com/tt-fustini/ab9b217756912ce75522b3cce11d0d58
> > [5] https://github.com/tenstorrent/linux/tree/tt-blackhole-v6.16-rc1_vstate_discard
> > 
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> [...]
> 
> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 184f780c932d443d81eecac7a6fb8070ee7a5824..7a4c209ad337efd7a3995cfc7cf1700c03e55b40 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -26,6 +26,7 @@ static struct kmem_cache *riscv_v_user_cachep;
> >  static struct kmem_cache *riscv_v_kernel_cachep;
> >  #endif
> >  
> > +bool riscv_v_vstate_discard_ctl = IS_ENABLED(CONFIG_RISCV_ISA_V_VSTATE_DISCARD);
> >  unsigned long riscv_v_vsize __read_mostly;
> >  EXPORT_SYMBOL_GPL(riscv_v_vsize);
> >  
> > @@ -307,11 +308,24 @@ static const struct ctl_table riscv_v_default_vstate_table[] = {
> >  	},
> >  };
> >  
> > +static const struct ctl_table riscv_v_vstate_discard_table[] = {
> > +	{
> > +		.procname       = "riscv_v_vstate_discard",
> > +		.data           = &riscv_v_vstate_discard_ctl,
> > +		.maxlen         = sizeof(riscv_v_vstate_discard_ctl),
> > +		.mode           = 0644,
> > +		.proc_handler   = proc_dobool,
> > +	},
> > +};
> > +
> >  static int __init riscv_v_sysctl_init(void)
> >  {
> > -	if (has_vector() || has_xtheadvector())
> > +	if (has_vector() || has_xtheadvector()) {
> Is this pair of curly braces strictly necessary?
> for potential extensibility?
> 
> Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
> Best regards,
> Troy
> >  		if (!register_sysctl("abi", riscv_v_default_vstate_table))
> >  			return -EINVAL;
> > +		if (!register_sysctl("abi", riscv_v_vstate_discard_table))
> > +			return -EINVAL;
Ah, my earlier comment was based on the assumption that this was a modified line.
Since it's actually newly added, that was my mistake. :(

> > +	}
> >  	return 0;
> >  }
> >  
> > 
> > ---
> > base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> > change-id: 20250818-riscv_v_vstate_discard-e89b3181e0ac
> > 
> > Best regards,
> > -- 
> > Drew Fustini <fustini@kernel.org>
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

