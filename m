Return-Path: <linux-kernel+bounces-824489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582BB895EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0321916F4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E2230DEBE;
	Fri, 19 Sep 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JY36eORK"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070042FABFF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283899; cv=none; b=LOTw1Lp6QVA0JGF/yViUG50CNYkHpXFII4EiIIs8IyHiIK8QqRY737QsMXX1wQXSFDjRpXE1m3x06WlrRkyTzj+sHsrv/Mb6z3KF5t0PKp8MQ/aLZkbzKJgi/sRL484O+dpH527Ld0ooX3UBayWP/8nQlTeljUE9i0iW+2xhOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283899; c=relaxed/simple;
	bh=chN6SoEPOGU+6awekNgiy+q38h9K3ieuwFiG+7vBG1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdhC8H0GkefIhbWyY0649ylyj0NjRf8qF9Fhahsc/BiVbMM6hulsIuqah9h9mF7t1HUToQ9uqH2LZW6hndLJA7BWCckoe2Raf4AXMeMKMdvPwO8hjeMjFFkiqKUEMy9tYN5RwG2KWkQGYmhUCZj+YS5kTcv1Ho48rcpfy3LT09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JY36eORK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cSrvn1m29z9tqX;
	Fri, 19 Sep 2025 14:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758283893; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJK735vegIkWG7nNh4y99VskygLNEoaW8Uhdx54BEJs=;
	b=JY36eORK5cUOQdLbJZWlcJ3GuBdV37+oKbxdYfYPij3uFB7wpk/5Ewq/THP86j+PP3ZDH3
	9IFfvliFbIs9ZoeSkm0rrQvC8E1NSbeqb/MLyva8csFs5FkNwGKSipdqBqOnfaS9F8ijeT
	bPjybw1Hq3f0coD+e42eId7JAlb6A2ujNXGijBTDqpOGi2PKy/CpIm+qPXYxG68wY5MK7k
	y79yH9v0bs2nAAIG5OZOeShzXi4EWqFdSNKxPtVGgSrRs3kms65lINqA1DA8cEZ/IvCT7o
	yX1LRpTSyNrapO5qAiCRMPRHy/PVLO7miYgAxAYxL+aXjzQpEs2DC6gpPaszBw==
Message-ID: <421f5c8946671872a2f7c35c15f3def5bdc053d5.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched/tests: Remove relict of done_list
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Philipp Stanner
 <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 14:11:27 +0200
In-Reply-To: <ad1359c3-86ae-4ed1-ac60-902daa2331a7@igalia.com>
References: <20250919064450.147176-2-phasta@kernel.org>
	 <ad1359c3-86ae-4ed1-ac60-902daa2331a7@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 4abchh9ij7rdgjz97ny44odjxy17aqpb
X-MBO-RS-ID: 52f79e0cb21bf2566bb

On Fri, 2025-09-19 at 08:33 +0100, Tvrtko Ursulin wrote:
>=20
> On 19/09/2025 07:44, Philipp Stanner wrote:
> > A rework of the scheduler unit tests removed the done_list. That list i=
s
> > still mentioned in the mock test header.
> >=20
> > Remove that relict.
> >=20
> > Fixes: 4576de9b7977 ("drm/sched/tests: Implement cancel_job() callback"=
)
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/tests/sched_tests.h | 3 +--
> > =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gp=
u/drm/scheduler/tests/sched_tests.h
> > index 7f31d35780cc..553d45abd057 100644
> > --- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
> > +++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
> > @@ -31,9 +31,8 @@
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * @base: DRM scheduler base class
> > =C2=A0=C2=A0 * @test: Backpointer to owning the kunit test case
> > - * @lock: Lock to protect the simulated @hw_timeline, @job_list and @d=
one_list
> > + * @lock: Lock to protect the simulated @hw_timeline and @job_list
> > =C2=A0=C2=A0 * @job_list: List of jobs submitted to the mock GPU
> > - * @done_list: List of jobs completed by the mock GPU
> > =C2=A0=C2=A0 * @hw_timeline: Simulated hardware timeline has a @context=
, @next_seqno and
> > =C2=A0=C2=A0 *		 @cur_seqno for implementing a struct dma_fence signali=
ng the
> > =C2=A0=C2=A0 *		 simulated job completion.
>=20
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied to drm-misc-next

Thx
P.

>=20
> Regards,
>=20
> Tvrtko
>=20


