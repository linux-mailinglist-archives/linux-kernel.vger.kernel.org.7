Return-Path: <linux-kernel+bounces-743149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930BBB0FB34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900104E0BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8CA214A94;
	Wed, 23 Jul 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F948PVFB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BE7F9;
	Wed, 23 Jul 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300634; cv=none; b=mmVs/CFIj0dYwzy9N8aR2XWvUNR+gsYZ2VdwOY6m89mmEt8SjuqOD1JnXs7BQhABKplx8ls8pSnAYDuh4w1mNb0UsqcRLxLaEWlGhlJW/r1nFVR4AVn+SyIOFsCNViLCZNSkm9Zu84Yg2JraCBCi/Qz1yYRSmm0rpionAXSlS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300634; c=relaxed/simple;
	bh=KO1DPBhAby687F5YozzqhxpfEKDn5Y3mLGJdWS2v+ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExxY+qV1jenUrCRc5TECHS71WGpXom8b3oZC+21S+vNBHiMVYUi0/tWWYKb8Y04BKyy4sX0UTBaPVMkrRlC9hwVcqVbJ2EILVdSQ3XX6Wt+l/vGmMi8nsOq+f7CjzfjI/6CQUnYz8jtDqFM5Ddd90paAx/cQ6sbUNVstQ/c/T7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F948PVFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B52FC4CEE7;
	Wed, 23 Jul 2025 19:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753300634;
	bh=KO1DPBhAby687F5YozzqhxpfEKDn5Y3mLGJdWS2v+ts=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F948PVFBhg0oY672LQKnhc0GQ5Te+g71ZnShvK2l00GsuKJWDStASevDn7v7i0uI/
	 FWNW5v7RtzYxPS4gDzKvNh7cASK8p2B0dXLLBsWuL9qWAF0VYvL4M4pQabNQkjx5YR
	 ITwZg0ZiC1alcrBcg7Oaa/rtSopSv9C+Al97zSR6VdS8GdtuWr7DdxeOs8ipoGnStF
	 awEz68gi/fzMZmW8t3mERMYk8eO0WtPRkMZQyyo2QKuGyHKo1uqRSlcKJEaJUqj26F
	 u1kzcLV7fK7zBjMTErkwAwIYhB3UuR5apTkUk4di8pFJNr2GQBzyJJ5jdQIF5uZYZn
	 87WdsNN7bKqWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E32FECE08DF; Wed, 23 Jul 2025 12:57:13 -0700 (PDT)
Date: Wed, 23 Jul 2025 12:57:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
	quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [RFC] tools/memory-model: Rule out OOTA
Message-ID: <9963f6a6-9da9-4120-b1fe-e4a1df9edda1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
 <b9c250b2-e4c0-4e8f-b37c-b51d93b980f0@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c250b2-e4c0-4e8f-b37c-b51d93b980f0@rowland.harvard.edu>

On Wed, Jul 23, 2025 at 03:25:13PM -0400, Alan Stern wrote:
> On Tue, Jul 22, 2025 at 05:43:16PM -0700, Paul E. McKenney wrote:
> >     Also, C-JO-OOTA-7.litmus includes a "*r2 = a" statement that makes herd7
> >     very unhappy.  On the other hand, initializing registers to the address
> >     of a variable is straight forward, as shown in the resulting litmus test.
> 
> ...
> 
> > diff --git a/manual/oota/C-JO-OOTA-7.litmus b/manual/oota/C-JO-OOTA-7.litmus
> > new file mode 100644
> > index 00000000..31c0b8ae
> > --- /dev/null
> > +++ b/manual/oota/C-JO-OOTA-7.litmus
> > @@ -0,0 +1,47 @@
> > +C C-JO-OOTA-7
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * But LKMM finds the all-ones result, due to OOTA on r2.
> > + *
> > + * https://lore.kernel.org/all/1147ad3e-e3ad-4fa1-9a63-772ba136ea9a@huaweicloud.com/
> > + *)
> > +
> > +{
> > +	0:r2=a;
> > +	1:r2=b;
> > +}
> 
> In this litmus test a and b are never assigned any values, so they
> always contain 0.
> 
> > +
> > +P0(int *a, int *b, int *x, int *y)
> > +{
> > +	int r1;
> > +	int r2;
> > +
> > +	r1 = READ_ONCE(*x);
> > +	smp_rmb();
> > +	if (r1 == 1) {
> > +		r2 = READ_ONCE(*a);
> 
> If this executes then r2 now contains 0.
> 
> > +	}
> > +	*r2 = a;
> 
> And so what is supposed to happen here?  No wonder herd7 is unhappy!

Nothing good, I will admit!  Good eyes, and thank you!

> > +	smp_wmb();
> > +	WRITE_ONCE(*y, 1);
> > +}
> > +
> > +P1(int *a, int *b, int *x, int *y)
> > +{
> > +	int r1;
> > +	int r2;
> > +
> > +	r1 = READ_ONCE(*y);
> > +	smp_rmb();
> > +	if (r1 == 1) {
> > +		r2 = READ_ONCE(*b);
> > +	}
> > +	*r2 = b;
> 
> Same here.
> 
> > +	smp_wmb();
> > +	WRITE_ONCE(*x, 1);
> > +}
> > +
> > +locations [0:r2;1:r2]
> > +exists (0:r1=1 /\ 1:r1=1)

Yes, I did misinterpret Jonas's initialization advice, which reads
as follows:  "unless you know how to initialize *a and *b to valid
addresses, you may need to add something like `if (r2 == 0) r2 = a`
to run this in herd7".

Given that there are two instances of r2, there are a number of
possible combinations of initialization.  I picked the one shown
in the patch below, and got this:

$ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/oota/C-JO-OOTA-7.litmus
Test C-JO-OOTA-7 Allowed
States 3
0:r1=0; 0:r2=a; 1:r1=0; 1:r2=b;
0:r1=0; 0:r2=a; 1:r1=1; 1:r2=b;
0:r1=1; 0:r2=a; 1:r1=0; 1:r2=b;
No
Witnesses
Positive: 0 Negative: 3
Flag mixed-accesses
Condition exists (0:r1=1 /\ 1:r1=1)
Observation C-JO-OOTA-7 Never 0 3
Time C-JO-OOTA-7 0.01
Hash=d9bb35335e45b31b1a39bab88eca837c

I get something very similar if I cross-initialize them, that is
a=b;b=a.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/manual/oota/C-JO-OOTA-7.litmus b/manual/oota/C-JO-OOTA-7.litmus
index 31c0b8ae..d7fe0f94 100644
--- a/manual/oota/C-JO-OOTA-7.litmus
+++ b/manual/oota/C-JO-OOTA-7.litmus
@@ -11,6 +11,8 @@ C C-JO-OOTA-7
 {
 	0:r2=a;
 	1:r2=b;
+	a=a;
+	b=b;
 }
 
 P0(int *a, int *b, int *x, int *y)

