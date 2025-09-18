Return-Path: <linux-kernel+bounces-811991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB11B53150
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725701C86C80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53227269CF1;
	Thu, 11 Sep 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/lZMM0X"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE61156230
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591203; cv=none; b=WlbJnx0cxB8yswEB5b1jBGz8MdkFSdSOF8KTcLEsEh+7nAUQxySj1Q5slRL9b9A2L2MJau1uuKCe0FKeFx9/GzuDIgKNM1HOrilm/XobLcQsENeWIw7g6iT58iUUCXqKwzl44Bmi9uN1rAAHW61kHd10/haRl5APZR/KCELCyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591203; c=relaxed/simple;
	bh=2/zhgZzgaPD/mTCFbdFXCf7nnj42YtDAgI1OOmlyW9s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QjRVaS/zVi0U5r725D7QkYVoy5RrVzDm/G9NZUjK+bVR8yP9VEezN0BWwkXRDIJYQQS7Nq4bNbBGIkhnXg1xHBAU/MYJVMn1Yqt1reE1bpqQdUkDboaEI+5pSoGGSoH9jxHJ6R0YP4xuFUQYyjylTShK3wwPpWrIzeuJio6/EAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/lZMM0X; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757591197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI5As6jV6efRsnCduCOaP1Bb7ASgnjaj/hqMfvxY/84=;
	b=E/lZMM0XRRFa1H9rqqCDJs6sjDmx8blI8absB/jr1mW/ERtKK3eDJSjn9Nw4qY/zHK7Mys
	YVVS1vmHkowP93rzNkYXb5ItWe4b3qjbLYHCzqmKCb6cR0DI5/xJ57o/z8W3nY95p338rj
	8Qj+K7Sv2WDL1Dh9osCH4AFopIM4rgk=
Date: Thu, 11 Sep 2025 11:46:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <1133458227af4b9a7a0cee284502a0643f1fad3f@linux.dev>
Disposition-Notification-To: qiang.zhang@linux.dev
X-Confirm-Reading-To: qiang.zhang@linux.dev
TLS-Required: No
Subject: Re: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
To: paulmck@kernel.org
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <430d5714-4a00-4a75-b763-34918f8017c3@paulmck-laptop>
References: <20250909133928.615218-1-qiang.zhang@linux.dev>
 <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
 <20250910143620.GA561834@joelbox2>
 <e5e69dc3-ebd3-47ae-b193-bc4b2de36904@paulmck-laptop>
 <70fa9fd07e4fe2b1b498109f3450804e731fd7ce@linux.dev>
 <430d5714-4a00-4a75-b763-34918f8017c3@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Thu, Sep 11, 2025 at 12:36:45AM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> On Wed, Sep 10, 2025 at 10:36:20AM -0400, Joel Fernandes wrote:
> >=20=20
>=20>  >=20
>=20>  > [..]
> >  > > kernel/rcu/srcutiny.c | 4 +---
> >  > > 1 file changed, 1 insertion(+), 3 deletions(-)
> >  > >=20
>=20>  > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> >  > > index b52ec45698e8..b2da188133fc 100644
> >  > > --- a/kernel/rcu/srcutiny.c
> >  > > +++ b/kernel/rcu/srcutiny.c
> >  > > @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct =
srcu_struct *ssp)
> >  > > {
> >  > > unsigned long cookie;
> >  > >=20
>=20>  > > - preempt_disable(); // Needed for PREEMPT_LAZY
> >  > > + lockdep_assert_preemption_disabled();
> >  >=20
>=20>  > nit: Do we still want to keep the comment that the expectation o=
f preemption
> >  > being disabled is for the LAZY case?
> >  >=20
>=20>  Good point, and I do believe that we do. Zqiang, any reason not to
> >  add this comment back in?
> >=20=20
>=20>  in rcu-tree, this commit:
> >=20=20
>=20>  (935147775c977 "EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=3Dn k=
ernels")
> >=20=20
>=20>  make preempt disable needed for CONFIG_PREEMPT=3Dy or CONFIG_PREEM=
PT_LAZY=3Dy
> >  when the CONFIG_SMP=3Dn. do we need to replace "Needed for PREEMPT_L=
AZY"
> >  comments with "Needed for PREEMPT or PREEMPT_LAZY"?
> >=20
>=20Good point as well, thank you! And I need to decide whether I should
> send that patch upstream. Its original purpose was to test PREEMPT_LAZY=
=3Dy
> better than could be tested with PREEMPT_LAZY.
>=20
>=20Thoughts?

I will add "Needed for PREEMPT_LAZY" comments, if this commit (935147775c=
977) is
send to upstream, will update comments again in the future.

Thanks
Zqiang

>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> Thanks
> >  Zqiang
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  Thanx, Paul
> >=20=20
>=20>  >=20
>=20>  > thanks,
> >  >=20
>=20>  > - Joel
> >  >=20
>=20>  >=20
>=20>  > > cookie =3D get_state_synchronize_srcu(ssp);
> >  > > if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> >  > > - preempt_enable();
> >  > > return;
> >  > > }
> >  > > WRITE_ONCE(ssp->srcu_idx_max, cookie);
> >  > > @@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct s=
rcu_struct *ssp)
> >  > > else if (list_empty(&ssp->srcu_work.entry))
> >  > > list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> >  > > }
> >  > > - preempt_enable();
> >  > > }
> >  > >=20
>=20>  > > /*
> >  > > --=20
>=20>  > > 2.48.1
> >  > >
> >  >
> >
>

