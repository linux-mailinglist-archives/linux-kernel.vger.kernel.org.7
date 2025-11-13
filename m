Return-Path: <linux-kernel+bounces-898485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE3EC555FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 039D04E1080
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC162BDC17;
	Thu, 13 Nov 2025 02:02:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952512248AF;
	Thu, 13 Nov 2025 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999372; cv=none; b=vGF7XRrQTxLBiPlEh3JNiC0jiR3cpqpmH+QzxF7vW2ldkPXg26ONsjA3tVchfMyHX4i19awCdecpEgLZ1w34jERYBzDS2GvuRRa4YPcods7IeN45fQ7b/yW6/dnfWeCXgROrP7Q9L9gUTfjKLmkQqCuhQcuWLkLpy9yj7wWcklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999372; c=relaxed/simple;
	bh=wrwfEm1eJN5ZFOVUUEYyAYWIhV0+rrQk0L93dYDf9xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwwSmBhX3p27C9FeQIBI8Q7ciiMITx7XK95fOnqRyx5mQ7Vv01eCkVoDOS1ivnkva8qx1wqSmj9akK2sS0h3uD+TynrwPbmnfWCmoteFPztIvlLMghr53QXXze3RSCYwpMi+CilPnzexQjVRSm7oDD9WQuVKNIzCjBMDwgdUPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-df-69153c41d44c
Date: Thu, 13 Nov 2025 11:02:36 +0900
From: Byungchul Park <byungchul@sk.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Guangbo Cui <2407018371@qq.com>, Liam.Howlett@oracle.com,
	amir73il@gmail.com, andi.shyti@kernel.org, andrii@kernel.org,
	bsegall@google.com, gregkh@linuxfoundation.org,
	linaro-mm-sig@lists.linaro.org, link@vivo.com,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	masahiroy@kernel.org, mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com, max.byungchul.park@gmail.com,
	mcgrof@kernel.org, melissa.srw@gmail.com, mgorman@suse.de,
	mhocko@kernel.org, minchan@kernel.org, oleg@redhat.com,
	paulmck@kernel.org, penberg@kernel.org, peterz@infradead.org,
	petr.pavlu@suse.com, torvalds@linux-foundation.org,
	vincent.guittot@linaro.org, will@kernel.org, yeoreum.yun@arm.com,
	ysk@kzalloc.com, rust-for-linux@vger.kernel.org, ojeda@kernel.org,
	gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, dakr@kernel.org, alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com, kernel_team@skhynix.com
Subject: Re: [PATCH] rust: bindings: add `rust_helper_wait_for_completion`
 helper function
Message-ID: <20251113020236.GA36724@system.software.com>
References: <20251002081247.51255-37-byungchul@sk.com>
 <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
 <aN62F8t493R7UmCT@tardis.local>
 <20251113012036.GA75428@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113012036.GA75428@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX/f31O3bvt1ar6Kf85zm/IQ+9hixvBlNjZrDKObfnPHdeWu
	ojCl4kqhtZEiPUvORTmVxVEmj9v1MN3Is46WQnKt4qZjxn+vvT/vvT6fPz4iVlm5QFFniJON
	Bo1ezStYRZ9vyexl4QG6OXfdDJjTD0HXq/cc/CyoE+B+52EWHNZLCF59NyMYGi3A4HTYMViu
	pTBwuieFhd5TX3hofdyLILW0moe65NcCDHa8YcCS5cLQfuMsD8+fnBCgvLOVgTevnRzUPnmM
	wX08CBw52Rw4T3YjuNxfwkNuvwtBr7sCQ8X3zwJcPH8Bgc2ejmCgzM3CkW8eDlqybzNQPtiP
	odrVjOHt8T4BzHfdGNK6FsC5wbkweKmKXzqTWgotiJY/+sTTsowRhjbkvxBoUU08ra0MpqWN
	PQytqcrgafHoR0y7njby9H7eKEvt5ywCfe55h+nX7mcszTpSw9Bnrsvc+oDNivAoWa9LkI2h
	SyIV2ptDQ1ysffq+Yx+a+WTknJSJfEQihZGH7xrRX/5UPcB6mZWmEde9ZsbLvDSDOJ3DOBOJ
	ov9YXla1KRMpRCxVC+R6ppnzdsZLW0lOQ9Zvj1ICUtR9i/eWVJIdkWNZHfjPwI88OPP+9wIs
	BROnp4fxSrEURC54RG/sIy0idemdgpcDpCnk9vUWxushkkMktjQP++fQieROpZM9iaT8/7T5
	/2nz/2mLEK5CKp0hIVqj04eFaBMNun0hO2Kia9DYF1Uc/LGlHg04NjQhSURqX+XHM/46FadJ
	MCVGNyEiYrW/0rZxLFJGaRKTZGPMdmO8XjY1oSCRVU9QznPvjVJJOzVx8m5ZjpWNf6eM6BOY
	jE5En/4mXFt5aGR4zYpthWJOTlvuou2h9avmvzTcu/qhLD41Iqy7TWUzR061Lh7tc/itXr15
	V4DUkjIrY2H79Eptboyv1nTFz3p2JCS1dDitYX+x/uidtbby7PVRL4bW5uWNW1cXFxbebF63
	dXmaz568vvlJ9EtPScSBppiCyY9WtFqfqlmTVjM3GBtNml/B1euAQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH932+z69ujkeiZ/LXGdJCTc0HzdDMNxszs7EYHT1zt+q0u7Qy
	piSSkxrz4xLRdeW6unapZLh0iYj1a3qQCXW0lF9XjWg6Zvz32vvH5/PPm8e+ucxMXqtLkvQ6
	dbyKVdCKDcszFqyKmK4NKa0MhKzMQ9D9qpeBn/m1HDzoOkxDa0UZglfDWQhGx/IxyK1ODLbr
	6RSc60+nYeDsJxbaWgYQZBTZWXAVNDNQm9bDgafzNQU2oxtDx82LLLx4fIqD4q42Cl73yAxU
	PW7BMJITAK15JxmQc/sQlA9dZeH0kBvBwIgFg2X4IwfXLpcgqHZmIvhiHqHh6NdxBu6frKeg
	2DOEwe52YXiTM8hBVuMIhiPd4VDgCQVPmZVdOZ/YLtkQKX70gSXm498pUmd6yZFCxz5SVRpE
	im71U8RhPc6SK2PvMel+eoslD86P0cRZYOPIi/G3mHzue04T41EHRZ67y5mNM6IVEbFSvDZZ
	0i9aEaPQ3B4dZRKdc1NOvHOxaUielY18eFEIEz/Yv9BepoU5orvJRXmZFeaJsvwNZyOe95vQ
	zdat2UjBY8HOiTXZWYw3M03YLubVGZGXlQKIhX13WG/IV3Ai8YSxE/8xporNF3p/P8BCkCiP
	91Peo1gIEEvGea/sIywVazO7OC9PF2aL9TX3qVykNP3XNv3XNv1rFyJsRX5aXXKCWhsfvtAQ
	p0nVaVMW7t6b4EATO7Ec/JF3A3k61jYggUeqSUoy5Kf1ZdTJhtSEBiTyWOWnrN4yISlj1an7
	Jf3enfp98ZKhAQXwtMpfuW6LFOMr7FEnSXGSlCjp/7oU7zMzDQVD08OHl9p72lDDodLIlO6i
	HXXUmuqUe1FRG69pLIH2xU9uGP03D95lVjvbt5ljijP0UTlV6/zzl1Tusqx3RU+W0+OWaEqC
	5oT0zo20yoPPdKbA2IiOZV3Rb3/0HSsLO5i8aUrFmUaX+XzNqfay2cOK/Y5numb90sjgA+ub
	Lhfc+aSiDRp1aBDWG9S/ADBeOIojAwAA
X-CFilter-Loop: Reflected

On Thu, Nov 13, 2025 at 10:20:36AM +0900, Byungchul Park wrote:
> On Thu, Oct 02, 2025 at 10:27:51AM -0700, Boqun Feng wrote:
> > On Thu, Oct 02, 2025 at 10:06:17AM +0000, Guangbo Cui wrote:
> > > > -extern void wait_for_completion(struct completion *);
> > > > -extern void wait_for_completion_io(struct completion *);
> > > > -extern int wait_for_completion_interruptible(struct completion *x);
> > > > -extern int wait_for_completion_killable(struct completion *x);
> > > > -extern int wait_for_completion_state(struct completion *x, unsigned int state);
> > > > -extern unsigned long wait_for_completion_timeout(struct completion *x,
> > > > +extern void __wait_for_completion(struct completion *);
> > > > +extern void __wait_for_completion_io(struct completion *);
> > > > +extern int __wait_for_completion_interruptible(struct completion *x);
> > > > +extern int __wait_for_completion_killable(struct completion *x);
> > > > +extern int __wait_for_completion_state(struct completion *x, unsigned int state);
> > > > +extern unsigned long __wait_for_completion_timeout(struct completion *x,
> > > >                                                unsigned long timeout);
> > > > -extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> > > > +extern unsigned long __wait_for_completion_io_timeout(struct completion *x,
> > > >                                                 unsigned long timeout);
> > > > -extern long wait_for_completion_interruptible_timeout(
> > > > +extern long __wait_for_completion_interruptible_timeout(
> > > >     struct completion *x, unsigned long timeout);
> > > > -extern long wait_for_completion_killable_timeout(
> > > > +extern long __wait_for_completion_killable_timeout(
> > > >     struct completion *x, unsigned long timeout);
> > > >  extern bool try_wait_for_completion(struct completion *x);
> > > >  extern bool completion_done(struct completion *x);
> > > > @@ -139,4 +134,79 @@ extern void complete(struct completion *);
> > > >  extern void complete_on_current_cpu(struct completion *x);
> > > >  extern void complete_all(struct completion *);
> > > >
> > > > +#define wait_for_completion(x)                                             \
> > > > +({                                                                 \
> > > > +   sdt_might_sleep_start_timeout(NULL, -1L);                       \
> > > > +   __wait_for_completion(x);                                       \
> > > > +   sdt_might_sleep_end();                                          \
> > > > +})
> > >
> > > The DEPT patch series changed `wait_for_completion` into a macro.
> > > Because bindgen cannot handle function-like macros, this caused
> > > Rust build errors. Add a helper function to fix it.
> > >
> > > ```
> > > error[E0425]: cannot find function `wait_for_completion` in crate `bindings`
> > >      --> rust/kernel/sync/completion.rs:110:28
> > >       |
> > >   110 |         unsafe { bindings::wait_for_completion(self.as_raw()) };
> > >       |                            ^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `__wait_for_completion`
> > >       |
> > >      ::: /root/linux/rust/bindings/bindings_generated.rs:33440:5
> > >       |
> > > 33440 |     pub fn __wait_for_completion(arg1: *mut completion);
> > >       |     ---------------------------------------------------- similarly named function `__wait_for_completion` defined here
> > >
> > > error: aborting due to 1 previous error
> > >
> > > For more information about this error, try `rustc --explain E0425`.
> > > ```
> > >
> > 
> > I think Danilo already made it clear, please fold this the existing
> > patch. Moreover, since this patchset doesn't adjust init_completion()
> > from the Rust side, the result is Rust code will also use the same dept
> > key for completion, which has to be fixed if dept wants to be in-tree.
> 
> Thank you for informing that.  I will take a look on it.

It looks not easy unless Rust side uses explicit maps for that purpose.
I think there are the same issues in 'lockdep + typical lock' too.  How
does lockdep deal with the issue?  Use explicit keys for that?

	Byungchul

> 
> 	Byungchul
> > 
> > Regards,
> > Boqun
> > 
> > > Signed-off-by: Guangbo Cui <2407018371@qq.com>
> > > ---
> > >  rust/helpers/completion.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> > > index b2443262a2ae..5bae5e749def 100644
> > > --- a/rust/helpers/completion.c
> > > +++ b/rust/helpers/completion.c
> > > @@ -6,3 +6,8 @@ void rust_helper_init_completion(struct completion *x)
> > >  {
> > >       init_completion(x);
> > >  }
> > > +
> > > +void rust_helper_wait_for_completion(struct completion *x)
> > > +{
> > > +     wait_for_completion(x);
> > > +}
> > > --
> > > 2.43.0
> > >

