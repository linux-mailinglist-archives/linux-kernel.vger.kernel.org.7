Return-Path: <linux-kernel+bounces-722415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF6AFDA10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E63A4E69D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88D1246326;
	Tue,  8 Jul 2025 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHXgvOKR"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16324500A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010820; cv=none; b=CAjZTg5sTuykYloxc8tcf3U7ghg7guUEJhAbQZQBKoyv+vtO9XfYw+IOSoV/hhCpX+zwaXef1X/orGyyOvCxzOZhPPYPyO9/RL9lYfu2wO6QbSoJv/XfoO2YDN9VOPK1PIh2gr9XLPzQASDPC9Yc2CePGb7E502HhP9NbAZOhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010820; c=relaxed/simple;
	bh=T4ldD8/1bBUs6avXoUWO3U6vM3vI/rtHEadEoBUr4do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxQWMRL+s0ejWA18O14u9zbc/IG/wDQHAU0m/qMF+5aScCoBGKbhHPbz21poBt6iyL2wHZ9pcndXcebtA5EaNptavvS1V0xMb8IAsXHz0ygHlsCGHUBGdvAnzEw5tqm4lY4WPHr9xD6PFp4CDfSQ+JA7466PnFiSZarsHON+9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHXgvOKR; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e5d953c0bso53209887b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010817; x=1752615617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaAH589LZlMraY4A9Bpzm4rHlPQ4aZ5HSThFI0Eph4U=;
        b=dHXgvOKRhPEAadnB4kI7hLrk3IEZq8zBv4/Gc6CvI5KbVO/NNOILLvStbzIyqHi85P
         LPp5bl1dNHR5YUaRe62nbjdzYx2XAIud4Gw8g94TQq6hxgJBwFSJQx/IrW4vqcMcqugw
         +ASj3jl40sKosNNzhcWuxCNYaKWdOCPf05WjfK3nIW1XQJoZfMLVyQI5esW4ABmp9a77
         4/yiKIQRnL4PvdEMLZCW5GrU1q3toHgpAA2fHXqczfs6M9gMqhVC9k4xZh67sJSkcHi7
         w1xdOVk7VQkhbgvav9TZ22RjRzE5laDJd7M+7eipPIzCW/Bzwe/WZs+CxHQ3VDLDxcyN
         6TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010817; x=1752615617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaAH589LZlMraY4A9Bpzm4rHlPQ4aZ5HSThFI0Eph4U=;
        b=f30Jy0bUFWPb51WSIqbDeSMzuwq/u3YR+fiGuq0nKt5vnEfzsD9GFLnzj7a298wpzS
         06AZKt+Wv3sf3p47GASSoV9ioGoyle29WtDupAMskA9BoJYZes8uuZl2kUuJhmIRXwQ4
         yS+J1tX+kPOUK+Svgjk3KyUlffGvSy67JPv6be2DlaRMMqCkuQLhmagQ/Pd3RmK9JVra
         N6rvB+A9OJRY5Q2XqDwvaWCfNjP8V4j6FKAwOv/i4LVEu5T7z1bgdVpk1UaPmRhNZfRm
         /Y6FpAYHTInoIiG2n4BgL68fug29UtrRmPiGgWBVUiu3gtQ1ADFDMRrhuHxoI1tIXCFE
         9Uog==
X-Forwarded-Encrypted: i=1; AJvYcCVylbg6B/YTjooMNCUNXv5P+bBiIp5yz3dFNmd+CPqaTVpuCq/zyWE725sCm/mHHnYviBxfbv33tY71wbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhwIIS+gako7xwxUJNNOYMqA/6lm2GzNpadZn0S1OJTwjIpO5
	ZIyHp61EioQRMFTVTDd9Z8JpFGiHUyem/sOjK+wI8W61zLvGryvPHCX5me4xgHI2SNewPNf7MNM
	Uggk/wfNCrlSbC1Yu94iY4lkSCkRamzY=
X-Gm-Gg: ASbGncsJrLH1D5FUa/96+OAFu6f9HvzixCU0D1/jNRiCCE6am8aGLJprHhukp1Rbo+G
	XHesyb5ozi+a0FaSOJq9ad6FW9FSoCrkrHM+5wl3YzIhn5vvDu7ydPVBNTLDQXUqCaeZ/Rp0/3C
	CvT4cI7sTB9IP6AglHk8zfbEOcl80C++GRtRVL4aAIRKvsUzj+tPF6wE5JUqv0N3Ztwps6lVAtL
	94=
X-Google-Smtp-Source: AGHT+IEZyewEjFiJ13mMUMT2SWnwYaChgZGIEiM8RaBPQnvGx962PDUYUOvqRPNL/uLL7zq31VHakjyVm1m7zHbDitw=
X-Received: by 2002:a05:690c:660a:b0:711:9770:161f with SMTP id
 00721157ae682-717b1b589eemr4928217b3.2.1752010816854; Tue, 08 Jul 2025
 14:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618145550.1901618-1-olvaffe@gmail.com> <20250623083241.02127feb@fedora>
In-Reply-To: <20250623083241.02127feb@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 8 Jul 2025 14:40:06 -0700
X-Gm-Features: Ac12FXzNJw14_2WStep6IjZp_-TrHnrbk-yIF8wqDQTY4HkXSi3wfVh2bACab1k
Message-ID: <CAPaKu7TTR4prUqt=AL2Lh=od9B_RqQpH+5redvFb3FY749Ebgg@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: always set fence errors on CS_FAULT
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 11:32=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed, 18 Jun 2025 07:55:49 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > It is unclear why fence errors were set only for CS_INHERIT_FAULT.
> > Downstream driver also does not treat CS_INHERIT_FAULT specially.
> > Remove the check.
> >
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/=
panthor/panthor_sched.c
> > index a2248f692a030..1a3b1c49f7d7b 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -1399,7 +1399,7 @@ cs_slot_process_fault_event_locked(struct panthor=
_device *ptdev,
> >       fault =3D cs_iface->output->fault;
> >       info =3D cs_iface->output->fault_info;
> >
> > -     if (queue && CS_EXCEPTION_TYPE(fault) =3D=3D DRM_PANTHOR_EXCEPTIO=
N_CS_INHERIT_FAULT) {
> > +     if (queue) {
> >               u64 cs_extract =3D queue->iface.output->extract;
> >               struct panthor_job *job;
> >
>
> Now that I look at the code, I think we should record the error when
> the ERROR_BARRIER is executed instead of flagging all in-flight jobs as
> faulty. One option would be to re-use the profiling buffer by adding an
> error field to panthor_job_profiling_data, but we're going to lose 4
> bytes per slot because of the 64-bit alignment we want for timestamps,
> so maybe just create a separate buffers with N entries of:
>
> struct panthor_job_status {
>    u32 error;
> };
The current error path uses cs_extract to mark exactly the offending
job faulty.  Innocent in-flight jobs do not seem to be affected.

I looked into emitting LOAD/STORE after SYNC_ADD64 to copy the error
to panthor_job_status.  Other than the extra instrs and storage,
because group_sync_upd_work can be called before LOAD/STORE, it will
need to check both panthor_job_status and panthor_syncobj_64b.  That
will be a bit ugly as well.

