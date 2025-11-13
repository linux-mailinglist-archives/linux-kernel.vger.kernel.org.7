Return-Path: <linux-kernel+bounces-898410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 207DCC553C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B37614E13E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65C265621;
	Thu, 13 Nov 2025 01:20:52 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93A2C181;
	Thu, 13 Nov 2025 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996851; cv=none; b=kstSc7LOcahBYy8fimI5U2uWmAm2MiRxqZGivD4Ahz9ecj8IM1/oobRV41J9NL+GQGHvuuN5Lp1J/cdP9NaytEsl5U3aB3kYSVWFctXik8XFSOIcXT4ZWKNxFBBy6h8QVwGCJFQgpM/XdGy4twYeDlRWKRJ2Jx6OqDIzkjXmym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996851; c=relaxed/simple;
	bh=CfHc9g8v7cVdIiqBVRU089faCyR9C5VRO28i5AdPIl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLfmxJj7aMlVua50ORNT7k8bfgZ+RjPxMZyHC4VAKDDtAGwGLefGuUjjZpqfWBRycdYwfwmfSvd84A/Pn1gFS2JlpEpwPSKksxOeT/N30I9cpOlkVfeS3u2VeXVIgGEjiK542240c+v9vTlR/DROtgNM+QY8XUv0HPP/PUjHMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-66-6915326a5ba4
Date: Thu, 13 Nov 2025 10:20:36 +0900
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
Message-ID: <20251113012036.GA75428@system.software.com>
References: <20251002081247.51255-37-byungchul@sk.com>
 <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
 <aN62F8t493R7UmCT@tardis.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN62F8t493R7UmCT@tardis.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SV0yTYRSG/f7vX63W/FaQT4g3VaMhOCCOk2jUy+9GJRq3iTbyB6qslKE4
	wRUoQwyJSAVFNqXYBEWGRqQiI0JEBa2IAQeNiFRkFBVtpCrRuyfvec+Tc3FErC7nvEVdeLSs
	D9eGanglqxyckbfkYICnbnlnzzxIPHcKunvec/DzSpUAzS9Os9B+owxBz1gigvGJKxhs7XUY
	zLcSGMjsT2Bh4NIQD09aBxCcybfwUBXfK8BoxxsGzCl2DM9qs3l41XZBgMIXTxh402vj4GZb
	KwZnmg+0X0zlwJbeh6DckcdDhsOOYMBZhKFo7LMApdeKEVTWnUMwXOBk4fyIi4Om1PsMFI46
	MFjsDzC8TRsUILHBieFs90rIGfWH0TITv2ExNV81I1r46BNPC5K+M7TG+FqguRUx9GaJL82/
	28/QClMST69PfMC0+/ldnjZfnmBpXY5ZoK9c7zD90tfF0pTzFQztspdzgZ67lWuD5FBdrKxf
	tm6/MiTp40Mc+VZzJLm4jotHmd4GpBCJtILcSWjkp/hnqQm5mZUWksqJbtbNvLSI2GzfsAGJ
	osdkXmDaaUBKEUsWgdw2JHLuzmxpL7lYk/J7VyUBGXRUIXdJLaUj0jDy9e9gFmnJev9biiVf
	YnP1M24plnxIsUt0o0LyIx2Gfe6GpzSf3L/dxLg1ROoQSXbeU+HPnXNJfYmNTUeS8T+r8T+r
	8Z81F2ETUuvCY8O0utAVS0PiwnVHlh6ICKtAk09UdOLHnmo03L7ViiQRaWaoPmR56NScNjYq
	LsyKiIg1HqrKHZORKkgbd1TWR+zTx4TKUVbkI7IaL1WA83CQWgrWRsuHZDlS1k9NGVHhHY9C
	jpWx2Y1xyS8dGZuMQ67MktqaEwcWJBy/Y7m3eqbQcmtMjCmpBovf2Mb6j0dHUgcV/tvzneZA
	r/FZmb3ln7oeVA/0NQ7POcV26tW7GppXP1Y8nW89uY2Mrwn225F8YdrnBVtG2qw5dk3GkGl2
	xrb6zYG29VkbV+VOR80bjsnUy65ho0K0/r5YH6X9BeGhytRAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG/Z//OWfH1eC0LE9KVJOIpItGwgtZWAT+kbSgD1ZYbulBV9Nk
	S8nAsouia94wsualm5dcK8GalzAMu6ioqRU5zPBSSmbOLnNdliMnRX57eJ7n9/B+eDksz2N8
	OHXicVGbqNIoWCktjdhybv2RTUvUASPdEsjKOA0Dg+8ZmCmul0Bb31kaeu7eRjA4nYXgu7MY
	g7WnGYP5/hkKisbP0DBx6TMLvZ0TCM7drGHhcWk7A/XpQxKwvxqmwGwYw/DyQQkLb7ryJFDR
	10vB8JCVgXtdnRgcub7QU5DDgDV/FMEd2w0WCm1jCCYclRgqp6ckUH21CoGlOQPB13IHDZnf
	XAy05jyioMJuw1Az9hjDSO7k7NlPHBjODwRBqT0Q7LdNbMhaYi4zI1LR8Ykl5dm/KNJofCsh
	12qTyb1b/uRm0zhFak3ZLLnu/IDJwOsmlrRddtKkudQsIW9c7zD5MtpPE0NmLUX6x+4we5Ye
	kAbHihp1iqjduE0pjc/++BQnjShOXKhqZtJRkY8eeXICv1mYqTYht6b51YLFOUC7NcuvEazW
	n1iPOM5r1i837dMjKYf5GolQp89i3J3FfJRQ0GiYY2U8CJO2euQuyfl8JDz59uNvsEhov/J+
	bhTz/oLVNU65RzHvK1S5OLf05NcJr/TR7sYS3k94VNdK5SOZcR5snAcb/8PXEDYhL3ViSoJK
	rQnaoDsan5qoPrEh5lhCLZp9k8q03wUNyP4ytAXxHFIslBGbl1rOqFJ0qQktSOCwwktmiZy1
	ZLGq1JOi9li0Nlkj6lqQL0crvGVhkaJSzsepjotHRTFJ1P5LKc7TJx0F+xWVNdjP6jM9wnca
	WqcOyo1xJUERAQ0rdj891BUX8rBDVhjupx/0bo3qoF16Piw6bHuVR/frfdXLlasMab0LxJKD
	+3UvpiP9lqVTe7c+j7Ks7A3rqk8ZZbRXY8Y1ba4hZZPq1y7FqZBDeV/bT1uqo3aEJit3HS5x
	hq+86Oh7VqGgdfGqQH+s1an+AKTs6FwiAwAA
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 10:27:51AM -0700, Boqun Feng wrote:
> On Thu, Oct 02, 2025 at 10:06:17AM +0000, Guangbo Cui wrote:
> > > -extern void wait_for_completion(struct completion *);
> > > -extern void wait_for_completion_io(struct completion *);
> > > -extern int wait_for_completion_interruptible(struct completion *x);
> > > -extern int wait_for_completion_killable(struct completion *x);
> > > -extern int wait_for_completion_state(struct completion *x, unsigned int state);
> > > -extern unsigned long wait_for_completion_timeout(struct completion *x,
> > > +extern void __wait_for_completion(struct completion *);
> > > +extern void __wait_for_completion_io(struct completion *);
> > > +extern int __wait_for_completion_interruptible(struct completion *x);
> > > +extern int __wait_for_completion_killable(struct completion *x);
> > > +extern int __wait_for_completion_state(struct completion *x, unsigned int state);
> > > +extern unsigned long __wait_for_completion_timeout(struct completion *x,
> > >                                                unsigned long timeout);
> > > -extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> > > +extern unsigned long __wait_for_completion_io_timeout(struct completion *x,
> > >                                                 unsigned long timeout);
> > > -extern long wait_for_completion_interruptible_timeout(
> > > +extern long __wait_for_completion_interruptible_timeout(
> > >     struct completion *x, unsigned long timeout);
> > > -extern long wait_for_completion_killable_timeout(
> > > +extern long __wait_for_completion_killable_timeout(
> > >     struct completion *x, unsigned long timeout);
> > >  extern bool try_wait_for_completion(struct completion *x);
> > >  extern bool completion_done(struct completion *x);
> > > @@ -139,4 +134,79 @@ extern void complete(struct completion *);
> > >  extern void complete_on_current_cpu(struct completion *x);
> > >  extern void complete_all(struct completion *);
> > >
> > > +#define wait_for_completion(x)                                             \
> > > +({                                                                 \
> > > +   sdt_might_sleep_start_timeout(NULL, -1L);                       \
> > > +   __wait_for_completion(x);                                       \
> > > +   sdt_might_sleep_end();                                          \
> > > +})
> >
> > The DEPT patch series changed `wait_for_completion` into a macro.
> > Because bindgen cannot handle function-like macros, this caused
> > Rust build errors. Add a helper function to fix it.
> >
> > ```
> > error[E0425]: cannot find function `wait_for_completion` in crate `bindings`
> >      --> rust/kernel/sync/completion.rs:110:28
> >       |
> >   110 |         unsafe { bindings::wait_for_completion(self.as_raw()) };
> >       |                            ^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `__wait_for_completion`
> >       |
> >      ::: /root/linux/rust/bindings/bindings_generated.rs:33440:5
> >       |
> > 33440 |     pub fn __wait_for_completion(arg1: *mut completion);
> >       |     ---------------------------------------------------- similarly named function `__wait_for_completion` defined here
> >
> > error: aborting due to 1 previous error
> >
> > For more information about this error, try `rustc --explain E0425`.
> > ```
> >
> 
> I think Danilo already made it clear, please fold this the existing
> patch. Moreover, since this patchset doesn't adjust init_completion()
> from the Rust side, the result is Rust code will also use the same dept
> key for completion, which has to be fixed if dept wants to be in-tree.

Thank you for informing that.  I will take a look on it.

	Byungchul
> 
> Regards,
> Boqun
> 
> > Signed-off-by: Guangbo Cui <2407018371@qq.com>
> > ---
> >  rust/helpers/completion.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> > index b2443262a2ae..5bae5e749def 100644
> > --- a/rust/helpers/completion.c
> > +++ b/rust/helpers/completion.c
> > @@ -6,3 +6,8 @@ void rust_helper_init_completion(struct completion *x)
> >  {
> >       init_completion(x);
> >  }
> > +
> > +void rust_helper_wait_for_completion(struct completion *x)
> > +{
> > +     wait_for_completion(x);
> > +}
> > --
> > 2.43.0
> >

