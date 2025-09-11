Return-Path: <linux-kernel+bounces-811152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29C8B52500
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD57B7B0B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E659B17B418;
	Thu, 11 Sep 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KtZM/zEM"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661D1C01
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551029; cv=none; b=JK2hjjsztTDqn1mFyel3qhnm7jLv77uipQWqGE4GRAP0qIH8ySvlvy+XkQJeGt4JuUi02BAVEHn23W6ik42xbJ7FkC8CAPwXMWgslDEeRMklJp6dMiBcPBJdQI40rKS5Swz5V1eRrx6L47KlihtNhJDnPmZInVQlaIOZhuxbV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551029; c=relaxed/simple;
	bh=bLZkKoIyuFewMnv32DJeSe9G9QkByNQccG5VgdjfiAw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bqEL6zrGA7j5r317mC8BGuE5eAMFiV1lorOVoPr8GM/GvSy73TOUuYAnGh+Gqc3WnQC1aFgdvjTCoqQcOmg+E3bbJwHmbLjgFT72+hrI/azk2FPmnwzIBNLslFwcEL1p24AFo4ma6gIXyVzYAc8c7FH1KBgJoDdBj4i294paS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KtZM/zEM; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757551011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TeBuLX2xhzl5tg3Ju2JBjH6X2bHAbxH2kyVzfYzP44=;
	b=KtZM/zEMMgPM33NzUgNkn8VGhwhxi0KC2qSm2I5SOFcatFlxWhg/JBuhD6+Zbsknh+zz48
	lJs7yCB43w87LSm+iQjONh/vMJFUOj2C7ZhPAvdySoqqu4TNPvFqUz10ULY8Tx5Qx3R2H7
	9Kv2pN5pc45c78ZyQTGKVgHy8eG3utw=
Date: Thu, 11 Sep 2025 00:36:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <70fa9fd07e4fe2b1b498109f3450804e731fd7ce@linux.dev>
Disposition-Notification-To: qiang.zhang@linux.dev
X-Confirm-Reading-To: qiang.zhang@linux.dev
TLS-Required: No
Subject: Re: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
To: paulmck@kernel.org, "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, boqun.feng@gmail.com,
 urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e5e69dc3-ebd3-47ae-b193-bc4b2de36904@paulmck-laptop>
References: <20250909133928.615218-1-qiang.zhang@linux.dev>
 <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
 <20250910143620.GA561834@joelbox2>
 <e5e69dc3-ebd3-47ae-b193-bc4b2de36904@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, Sep 10, 2025 at 10:36:20AM -0400, Joel Fernandes wrote:
>=20
>=20>=20
>=20> [..]
> >  > kernel/rcu/srcutiny.c | 4 +---
> >  > 1 file changed, 1 insertion(+), 3 deletions(-)
> >  >=20
>=20>  > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> >  > index b52ec45698e8..b2da188133fc 100644
> >  > --- a/kernel/rcu/srcutiny.c
> >  > +++ b/kernel/rcu/srcutiny.c
> >  > @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct sr=
cu_struct *ssp)
> >  > {
> >  > unsigned long cookie;
> >  >=20
>=20>  > - preempt_disable(); // Needed for PREEMPT_LAZY
> >  > + lockdep_assert_preemption_disabled();
> >=20=20
>=20>  nit: Do we still want to keep the comment that the expectation of =
preemption
> >  being disabled is for the LAZY case?
> >=20
>=20Good point, and I do believe that we do. Zqiang, any reason not to
> add this comment back in?

in rcu-tree, this commit:

(935147775c977 "EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=3Dn kernels"=
)

make preempt disable needed for CONFIG_PREEMPT=3Dy or CONFIG_PREEMPT_LAZY=
=3Dy
when the CONFIG_SMP=3Dn. do we need to replace "Needed for PREEMPT_LAZY"
comments with "Needed for PREEMPT or PREEMPT_LAZY"?

Thanks
Zqiang


>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> thanks,
> >=20=20
>=20>  - Joel
> >=20=20
>=20>=20=20
>=20>  > cookie =3D get_state_synchronize_srcu(ssp);
> >  > if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> >  > - preempt_enable();
> >  > return;
> >  > }
> >  > WRITE_ONCE(ssp->srcu_idx_max, cookie);
> >  > @@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct src=
u_struct *ssp)
> >  > else if (list_empty(&ssp->srcu_work.entry))
> >  > list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> >  > }
> >  > - preempt_enable();
> >  > }
> >  >=20
>=20>  > /*
> >  > --=20
>=20>  > 2.48.1
> >  >
> >
>

