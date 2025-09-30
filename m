Return-Path: <linux-kernel+bounces-837369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF32FBAC27D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9C2171E44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD822836C;
	Tue, 30 Sep 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nHp3Iqcn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bSO6IffR"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48807E0E4;
	Tue, 30 Sep 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222847; cv=none; b=nrsLc5nxLt1VlQOMlwhJPAa2Q+gDI6w+KpB0+p+rqxc+4gniFCTl60UzzDj035e41vuHDk22Y7U/l90WZNTf8T5LIZvJsAb4P0n8pLPZuFbPpb082MOLFihpwBI8oadNn1O8mHF2CfWctAE7i7G0UTuSWMOfnIQSVAC6ggFeVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222847; c=relaxed/simple;
	bh=U892Esd5mTj/d5tmho52j6cdCEfSjQZJiBCIwYm4Eqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQd/2+WdmUzRb5Fxg/JlaEAnu4C89ZaYloYKCtdsJ1ytLKm/uX1WVqqA0XlnMy/TVqJmocR6/cbeweAeWeGftYE10mtS0OEEwBuRipk3xsfHJ04zkmraqPKgcga/wufQEdr0G4dh+THMUq5wY+U7kVrDk8EQebesDMfGMZFBMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nHp3Iqcn; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bSO6IffR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cbX8P6LPCz9ttD;
	Tue, 30 Sep 2025 11:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1759222837; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U892Esd5mTj/d5tmho52j6cdCEfSjQZJiBCIwYm4Eqo=;
	b=nHp3IqcnvbreOZc3OzulvC0i3d3NSiJcd0pCNkdKLzgChgANiDCaIFIHrrSraFbz88obvY
	vWUbERulvbsWPTd6n6DMWPyclCe4TxnC7uMh6WVyVuxjEORtXY5UOM8g53jWBwgMsWOu7V
	g1dkh6m2vjxHSNGwrSVHfGZNahe37BLJoP82ol8dm4Guj9FjSi9FsfyV6jauE8VfXhpXcN
	i+ZQUZuBhdAdfB7ids8lhfHg8lcVa8p/LHu9u0TTm4dKGMQWeryKXHObLXOl5tbUY3+c+A
	m5LAILorzuL3c6qjQ9/ckXcQrY2RuIG/zgZJcDRODFGOBhO+0KuG1EOhxuLhHA==
Message-ID: <4453e5989b38e99588efd53af674b69016b2c420.camel@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1759222835; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U892Esd5mTj/d5tmho52j6cdCEfSjQZJiBCIwYm4Eqo=;
	b=bSO6IffRMsKMfrWE4WksV2egg/AdsOdKcTyElsfS4oISvSwRGOOW93aUMveSOG0rjkRBKZ
	8PPEowKvBC4mDwsXsIDBH/+4hRb9ZTPgIOff66KQra6p2+PtECJs03s2SngMG5vaGtmePA
	lznDHFbnBdjhqFie87d43A9cq7Vrc/ai6cHDTSsv+Ej4ObjfEupmywM6vJDuyY6XG0qfp1
	/Fci7+7JEhC/WXMfFYc7s39KRPheF9umg+XA4lqRCj2pyIgiYQbLWU9bn4WDzB41NInUiY
	0j4VK3p4zunEX1jXUTc1gklny9621t6Nh4Xz8ZY895Tkx4vsbd4lqiHH8NEQLA==
Subject: Re: [RFC v8 00/21] DRM scheduling cgroup controller
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Tvrtko Ursulin
	 <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 cgroups@vger.kernel.org,  linux-kernel@vger.kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Leo Liu
 <Leo.Liu@amd.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Michel =?ISO-8859-1?Q?D=E4nzer?=
 <michel.daenzer@mailbox.org>, Philipp Stanner <phasta@kernel.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Rob Clark
 <robdclark@gmail.com>, Tejun Heo <tj@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Alistair Popple <apopple@nvidia.com>, John Hubbard
 <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi
 <ttabi@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring
 <robh@kernel.org>, Steven Price <steven.price@arm.com>,  Liviu Dudau
 <liviu.dudau@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>, Alice
 Ryhl <aliceryhl@google.com>, Boqun Feng <boqunf@netflix.com>, 
 =?ISO-8859-1?Q?Gr=E9goire_P=E9an?= <gpean@netflix.com>, Simona Vetter
 <simona@ffwll.ch>, airlied@gmail.com
Date: Tue, 30 Sep 2025 11:00:00 +0200
In-Reply-To: <DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
	 <DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: zm9rtuzamubk7iurtkm9beynczfjwck6
X-MBO-RS-ID: adb1f3886a0592d9927

+Cc Sima, Dave

On Mon, 2025-09-29 at 16:07 +0200, Danilo Krummrich wrote:
> On Wed Sep 3, 2025 at 5:23 PM CEST, Tvrtko Ursulin wrote:
> > This is another respin of this old work^1 which since v7 is a total rew=
rite and
> > completely changes how the control is done.
>=20
> I only got some of the patches of the series, can you please send all of =
them
> for subsequent submissions? You may also want to consider resending if yo=
u're
> not getting a lot of feedback due to that. :)
>=20
> > On the userspace interface side of things it is the same as before. We =
have
> > drm.weight as an interface, taking integers from 1 to 10000, the same a=
s CPU and
> > IO cgroup controllers.
>=20
> In general, I think it would be good to get GPU vendors to speak up to wh=
at kind
> of interfaces they're heading to with firmware schedulers and potential f=
irmware
> APIs to control scheduling; especially given that this will be a uAPI.
>=20
> (Adding a couple of folks to Cc.)
>=20
> Having that said, I think the basic drm.weight interface is fine and shou=
ld work
> in any case; i.e. with the existing DRM GPU scheduler in both modes, the
> upcoming DRM Jobqueue efforts and should be generic enough to work with
> potential firmware interfaces we may see in the future.
>=20
> Philipp should be talking about the DRM Jobqueue component at XDC (probab=
ly just
> in this moment).
>=20
> --
>=20
> Some more thoughts on the DRM Jobqueue and scheduling:
>=20
> The idea behind the DRM Jobqueue is to be, as the name suggests, a compon=
ent
> that receives jobs from userspace, handles the dependencies (i.e. dma fen=
ces),
> and executes the job, e.g. by writing to a firmware managed software ring=
.
>=20
> It basically does what the GPU scheduler does in 1:1 entity-scheduler mod=
e,
> just without all the additional complexity of moving job ownership from o=
ne
> component to another (i.e. from entity to scheduler, etc.).
>=20
> With just that, there is no scheduling outside the GPU's firmware schedul=
er of
> course. However, additional scheduler capabilities, e.g. to support hardw=
are
> rings, or manage firmware schedulers that only support a limited number o=
f
> software rings (like some Mali GPUs), can be layered on top of that:
>=20
> In contrast to the existing GPU scheduler, the idea would be to keep lett=
ing the
> DRM Jobqueue handle jobs submitted by userspace from end to end (i.e. let=
 the
> push to the hardware (or software) ring buffer), but have an additional
> component, whose only purpose is to orchestrate the DRM Jobqueues, by man=
aging
> when they are allowed to push to a ring and which ring they should push t=
o.
>=20
> This way we get rid of one of the issue that the existing GPU scheduler m=
oves
> job ownership between components of different lifetimes (entity and sched=
uler),
> which is one of the fundamental hassles to deal with.


So just a few minutes ago I had a long chat with Sima.

Sima (and I, too, I think) thinks that the very few GPUs that have a
reasonably low limit of firmware rings should just resource-limit
userspace users once the limit of firmware rings is reached.

Basically like with VRAM.

Apparently Sima had suggested that to Panthor in the past? But Panthor
still seems to have implemented yet another scheduler mechanism on top
of the 1:1 entity-scheduler drm_sched setup?

@Boris: Why was that done?

So far I tend to prefer Sima's proposal because I'm currently very
unsure how we could deal with shared firmware rings =E2=80=93 because then =
we'd
need to resubmit jobs, and the currently intended Rust ownership model
would then be at danger, because the Jobqueue would need a:
pending_list.

So we'd be running danger of redesigning drm_sched, whereas with Sima's
idea there'd never be a scheduler anywhere anymore anyways.


P.


