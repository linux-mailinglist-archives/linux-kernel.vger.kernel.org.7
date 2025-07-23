Return-Path: <linux-kernel+bounces-742979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14F3B0F901
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1264C585D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82F20E717;
	Wed, 23 Jul 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npMUJDyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63701E5B63;
	Wed, 23 Jul 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291670; cv=none; b=UCoZJLIfOdjXKaYxTo4TmFwdW2H3quyt5MMZDzBkJxhMntuS7bKpGMpO6Jrqc/m5h7KO6mds77vNk4YydyaoTF7IR6J4EHIXAkutLuoAABbpOQCTAlYid/S60dgVF1BGLaMCcrvReFPbbMCuvOgAEjaomm6qGSl6qweSXEvT+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291670; c=relaxed/simple;
	bh=qx3flbpVTB16XarLcPllBskgnmI/m+3CCQd9sozjRog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi6Up8ApLSeEB2wOsSeSTb/Qin3UlONz7mkPD5k8SoOTBsKPvn2b7YuJfM5PyQakHdGLnPFiXlcuu2Owu8KrSmjxcgZz26SCg/8Kz3TLuKG/esIcQDMmDSWAaSx1jtCrr//yy0UJabS6itmSbXVZBAZWzBkiYdnYldQAr7mQGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npMUJDyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D31BC4CEE7;
	Wed, 23 Jul 2025 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753291670;
	bh=qx3flbpVTB16XarLcPllBskgnmI/m+3CCQd9sozjRog=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=npMUJDyHQ8L49bPjLwhal3lEZRpRRzDpbcu0oxa/KNlIA8QZpwMGYpPj+xFCdxa5d
	 rFl/FNd+Bz63JeSsdpaVybpLDcbwthtTonFkH3S1tBtV2clrn3P0vsHuUUsEDUzo8L
	 Sy+7SUm6rLW3rIsajLeTXAnqdihWqFnqm4Cqjz3mpN45vwf8+ssi02XEKyMm48Z6VK
	 TjUbxUypfn/eSv1uuQALd/W/inWc/MkfE9LhiHA7jCv8bBngj01PHlDcm0lfDdBfxt
	 suAhNTbBAIeJw/a4S/pOrjjjBo5B4ZmEqO5Yk2Y3fUNfaTQ9o30LpMB9/cKFEA6bDg
	 IdGVGdY+dVarA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5409CE0AD1; Wed, 23 Jul 2025 10:27:49 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:27:49 -0700
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
Message-ID: <5470d186-7c75-4ead-81de-71f9d6b4c58f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
 <abafbf9b-d13d-4389-82fe-501810388a10@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abafbf9b-d13d-4389-82fe-501810388a10@rowland.harvard.edu>

On Wed, Jul 23, 2025 at 01:13:35PM -0400, Alan Stern wrote:
> On Tue, Jul 22, 2025 at 05:43:16PM -0700, Paul E. McKenney wrote:
> > On Mon, Jan 06, 2025 at 10:40:03PM +0100, Jonas Oberhauser wrote:
> > > The current LKMM allows out-of-thin-air (OOTA), as evidenced in the following
> > > example shared on this list a few years ago:
> > 
> > Apologies for being slow, but I have finally added the litmus tests in
> > this email thread to the https://github.com/paulmckrcu/litmus repo.
> > 
> > It is quite likely that I have incorrectly intuited the missing portions
> > of the litmus tests, especially the two called out in the commit log
> > below.  If you have time, please do double-check.
> 
> I didn't look very closely when this first came out...
> 
> > --- /dev/null
> > +++ b/manual/oota/C-AS-OOTA-2.litmus
> > @@ -0,0 +1,33 @@
> > +C C-AS-OOTA-2
> > +
> > +(*
> > + * Result: Always
> > + *
> > + * If we were using C-language relaxed atomics instead of volatiles,
> > + * the compiler *could* eliminate the first WRITE_ONCE() in each process,
> > + * then also each process's local variable, thus having an undefined value
> > + * for each of those local variables.  But this cannot happen given that
> > + * we are using Linux-kernel _ONCE() primitives.
> > + *
> > + * https://lore.kernel.org/all/c2ae9bca-8526-425e-b9b5-135004ad59ad@rowland.harvard.edu/
> > + *)
> > +
> > +{}
> > +
> > +P0(int *a, int *b)
> > +{
> > +	int r0 = READ_ONCE(*a);
> > +
> > +	WRITE_ONCE(*b, r0);
> > +	WRITE_ONCE(*b, 2);
> > +}
> > +
> > +P1(int *a, int *b)
> > +{
> > +	int r1 = READ_ONCE(*b);
> > +
> > +	WRITE_ONCE(*a, r0);
> 
> This should be r1 instead of r0.

Ah, good eyes, thank you!

With that change, I still get "Always" as shown below.  Which I believe
makes sense, given that LKMM deals with volatile atomics in contrast to
the C++ relaxed atomics that you were discussing in the email.

Please let me know if I am still missing something.

> > +	WRITE_ONCE(*a, 2);
> > +}
> > +
> > +exists ((0:r0=0 \/ 0:r0=2) /\ (1:r1=0 \/ 1:r1=2))
> 
> Alan

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/oota/C-AS-OOTA-2.litmus
Test C-AS-OOTA-2 Allowed
States 3
0:r0=0; 1:r1=0;
0:r0=0; 1:r1=2;
0:r0=2; 1:r1=0;
Ok
Witnesses
Positive: 5 Negative: 0
Condition exists ((0:r0=0 \/ 0:r0=2) /\ (1:r1=0 \/ 1:r1=2))
Observation C-AS-OOTA-2 Always 5 0
Time C-AS-OOTA-2 0.01
Hash=7b4c046bc861c102997a87e32907fa80

