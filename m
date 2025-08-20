Return-Path: <linux-kernel+bounces-777219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C16B2D6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31BD18894F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B52D8DC2;
	Wed, 20 Aug 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pq2jeBlG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB8272E7A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679443; cv=none; b=k6H42CT/q7qQqyk48CkVAPqP0h1CyKdBpFObEt0KeB0cUpIsE+OLmj6R1p56JD9grwvtQ923N4BSngcmPz9fRXZl10QI4cEaNre4FoqjNwHRT4KpnIWHIUMldpeSJ82dDvwZYKS1H277fkCVglsNXsUz3Cs0hfiRjBipLHSY6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679443; c=relaxed/simple;
	bh=kSWBiN/GA12YV+qcjFwKA/cHTBbv2Wy0xFRnPWQK9Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8OJ0Vw6iVCdXPIkAr6gMJm9QIGk+OQa+XaVI6Ar/2e/LHIsi+JOzqdTXLWVIjuJ7X7nTVnFoChAnhIdjLFymHnCdJB3Dcc7Hg3SfEkIk6MsPze8GEyuzAAmftnFemDnfYLYmlicpuLwbIUG7OY6VnQbwXGLwuLwduFu2u/QDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pq2jeBlG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755679438;
	bh=kSWBiN/GA12YV+qcjFwKA/cHTBbv2Wy0xFRnPWQK9Ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pq2jeBlGW0CUvs+Xm9i6FNFZMCKVKAGxdCNJTRWPhjlDz2XzOAEkVYZrovKo74nQ1
	 xY3TT6SIBwsT8FhK7O0aNYjjxAPayV/shBwz+KiY2o4PvR8vjExgytjQYpGhaOHS0K
	 vHl+WJqvvdd1G6KOf2+tOBGGubh6qoNDFNAgYtxfPachR3YpFyvy+CDeqfC5hflwRJ
	 sdhW0WqHAoCAzSHEABAkuQiWqDTLSShIKnWLu+E1SRWzeS57apkZ39Tw6U1yzjPW+G
	 ZArhB/JOqskFgGBMrBjKEOgPjgR+jyVUZxs2g2UrvTM8oXYcrkArqMk9ON/GZ7ihqo
	 4Xat9acOqDz5Q==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6DCB017E0488;
	Wed, 20 Aug 2025 10:43:58 +0200 (CEST)
Date: Wed, 20 Aug 2025 10:43:53 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: always set fence errors on CS_FAULT
Message-ID: <20250820104353.5cc8035d@fedora>
In-Reply-To: <CAPaKu7TTR4prUqt=AL2Lh=od9B_RqQpH+5redvFb3FY749Ebgg@mail.gmail.com>
References: <20250618145550.1901618-1-olvaffe@gmail.com>
	<20250623083241.02127feb@fedora>
	<CAPaKu7TTR4prUqt=AL2Lh=od9B_RqQpH+5redvFb3FY749Ebgg@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 14:40:06 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Sun, Jun 22, 2025 at 11:32=E2=80=AFPM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Wed, 18 Jun 2025 07:55:49 -0700
> > Chia-I Wu <olvaffe@gmail.com> wrote:
> > =20
> > > It is unclear why fence errors were set only for CS_INHERIT_FAULT.
> > > Downstream driver also does not treat CS_INHERIT_FAULT specially.
> > > Remove the check.
> > >
> > > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/dr=
m/panthor/panthor_sched.c
> > > index a2248f692a030..1a3b1c49f7d7b 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > > @@ -1399,7 +1399,7 @@ cs_slot_process_fault_event_locked(struct panth=
or_device *ptdev,
> > >       fault =3D cs_iface->output->fault;
> > >       info =3D cs_iface->output->fault_info;
> > >
> > > -     if (queue && CS_EXCEPTION_TYPE(fault) =3D=3D DRM_PANTHOR_EXCEPT=
ION_CS_INHERIT_FAULT) {
> > > +     if (queue) {
> > >               u64 cs_extract =3D queue->iface.output->extract;
> > >               struct panthor_job *job;
> > > =20
> >
> > Now that I look at the code, I think we should record the error when
> > the ERROR_BARRIER is executed instead of flagging all in-flight jobs as
> > faulty. One option would be to re-use the profiling buffer by adding an
> > error field to panthor_job_profiling_data, but we're going to lose 4
> > bytes per slot because of the 64-bit alignment we want for timestamps,
> > so maybe just create a separate buffers with N entries of:
> >
> > struct panthor_job_status {
> >    u32 error;
> > }; =20
> The current error path uses cs_extract to mark exactly the offending
> job faulty.  Innocent in-flight jobs do not seem to be affected.

My bad, I thought the faulty CS was automatically entering the recovery
substate (fetching all instructions and ignoring RUN_xxx ones), but it
turns out CS instruction fetching is stalled until the fault is
acknowledged, so we're good.

>=20
> I looked into emitting LOAD/STORE after SYNC_ADD64 to copy the error
> to panthor_job_status.  Other than the extra instrs and storage,
> because group_sync_upd_work can be called before LOAD/STORE, it will
> need to check both panthor_job_status and panthor_syncobj_64b.  That
> will be a bit ugly as well.

Nah, I think you're right, I just had a wrong recollection of how
recovery mode works. The patch is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>


