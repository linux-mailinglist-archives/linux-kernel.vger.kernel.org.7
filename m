Return-Path: <linux-kernel+bounces-817873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A6B587E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FC620659B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6C2D47F5;
	Mon, 15 Sep 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJCOenAA"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5C2B2D7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976727; cv=none; b=NiOMWFbbgPi7ue7vXJZoci/TWlRp81DzOwQbwk0LfgoiMP/41rJZt/XjGXTuMfRnjl+Pg1oZkcZ2KrMQLdZCntQHYWmpAiVqGA/6zooBaeoFJI6YG9sB9KXHm6tjmxzYq6ZPIzEwOPfhqcNLGcC0h8kSNaDT9x74d0SdSybRKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976727; c=relaxed/simple;
	bh=gqy51CGjZs7L4fhYV0nNCQsfL5rlx8dGes18KMtP2G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay+1yDfwOvCtPHOnFVCjcp+Cm9YYw2bH3ZVkj6lYsr3vjSXl8B7RNSBF+sUDjo/6EO/hu+0RXAr/jALSysW2AJESAstG4a/8MFcRjrzQ6nuK+0kA8P98387B21AXZxjkpgoZ1Yj9BKPYceg7UNASf+MweLQ4jZ3eeWOUwVWVE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJCOenAA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-355739c7fc8so15134531fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976724; x=1758581524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm0/mnzPsesUmIeJ98TzZwQ2Akz/kNDhyhWBAXtAXDw=;
        b=DJCOenAAlKon1CFk67aW8RCatnhrU1/WKDGbuT9KlO6LNdIZtsPvwWT7cRSKbxpxDu
         IBj5n9WX0+qMpcV45DhaCIaq5UkZ72rj3XyCVfNMyGpnp95MTOkCvnA4SY5Ptw+YuBSl
         ayjqcnBJ0PlvNgHiZObULJHR2gZ2Ksoz6z8GjmJqNH1ROU3eEAKLcMvmJ7dtKNKC5VFM
         o6EFTxx7H267NdqmJ9p+B5VhRGkZMikH39c6sCzvV7qms38zlQCEBRaYXob1109+hOyP
         /JllWCjefhMdi/bFzhDnU4fckETV3E8pQcSKhtr7TYEcHZU4VfFy8HExL6wxpzaUdYBA
         XsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976724; x=1758581524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm0/mnzPsesUmIeJ98TzZwQ2Akz/kNDhyhWBAXtAXDw=;
        b=AUa218BBYIEwnbHgqAEU86GicdAFYD6EFs4TzANYbE5qrfTgfG7iSElU3HC4ir3c2g
         0YglXzPdpsU3yHDZNSWd+4JzB+p7GUiVu36E8QU2Qd3aZaA0xpW6/RJG81RrlcIOZR5Q
         V+uI8KzLbfoFlSy/2NHXhIRicdD0Hw/9E3xd9zTs1etW9BZsiar1KH3egSFsawSQNlZt
         mJQZABgEFH2L1ShF/3O7FuJww/JkSkv0A8HssfBX0hkWtkDCTXYoBScNlXQunyJwWeGf
         LTDVt2Pl4s2goGO3BcSf99Qn16rEIb0A2xV5Q/m1mrLqnmkipBrnY/InvNAQv3tlFWWJ
         lJ0g==
X-Forwarded-Encrypted: i=1; AJvYcCU7h8sSNNUBbCDH9AEqHCJKZgOdxoM2NG7FJjb18glvTMXhBTIKtZGti/Yx12vJZlbt+qXKMo01FJ8wW7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJFD/AujfiQKC4L7DspMwduIsDpJE9MAr2F05dqKD/sds+jlv
	wsFtGYNTGlrqOIJoZsH5RQ4Ot+bPSLVvxyiOzmzYPNlUMG05GlA12QF2CSWAeOgfMmH2Er6wy0B
	5GtLFf+B3j7RLprUirIxR342OEUbYPRU=
X-Gm-Gg: ASbGncsKgVrXEvPACFPVmswjztREkLPMu4TtROVGHplw22/Vz5Mb9AjkTVmgOLCDyLc
	8pQlNAkBNPbjCax4UF1Z0Ywfh5DOLapLly6xtiPdYaf4fqqlxXIkcasnLGvZQTNyrSZ/fBY+cq1
	fLp6wb18ZEJLKYocDvJHbM1/ONW5Bmwqn5F/DnII3XFaXYhAjBM/6YuoZaNAcrviRY34NLMfBAe
	URFvA0=
X-Google-Smtp-Source: AGHT+IHDRvcV0dV9VDhAcAMEZ21dqvL1noGOj01MZ+sfLv+YYHw5oyhSI+Q1GgqRspon0xC83RYI98h95ffW6T3retY=
X-Received: by 2002:a2e:a016:0:20b0:336:7e31:6708 with SMTP id
 38308e7fff4ca-351403eccb1mr33364351fa.37.1757976723624; Mon, 15 Sep 2025
 15:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912134406.221443-1-onion0709@gmail.com> <62842992a3f18ca7c11e4887d3eced69644793ae.camel@mailbox.org>
In-Reply-To: <62842992a3f18ca7c11e4887d3eced69644793ae.camel@mailbox.org>
From: Luc Ma <onion0709@gmail.com>
Date: Tue, 16 Sep 2025 06:52:19 +0800
X-Gm-Features: AS18NWBzVkhxcm04lwXZqplHOT5g0VGEYgD3MlvxyGFbkTaem_RX_Qsv2EDXZCg
Message-ID: <CAB3Z9RJPdCu50esK2mg9NkVihuWmZn7hpDdxeMEN1FBNpFtBrg@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: struct member doc fix
To: phasta@kernel.org
Cc: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 15 Sept 2025 at 20:12, Philipp Stanner <phasta@mailbox.org> wrote:
>
> On Fri, 2025-09-12 at 21:44 +0800, Luc Ma wrote:
> > The mentioned function has been renamed since commit 180fc134d712
> > ("drm/scheduler: Rename cleanup functions v2."), so let it refer to
> > the current one.
> >
> > Signed-off-by: Luc Ma <onion0709@gmail.com>
>
> Thx for the patch.
>
> > ---
> >  include/drm/gpu_scheduler.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index 323a505e6e6a..6c4d0563e3d7 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -546,7 +546,7 @@ struct drm_sched_backend_ops {
> >   * @num_rqs: Number of run-queues. This is at most DRM_SCHED_PRIORITY_=
COUNT,
> >   *           as there's usually one run-queue per priority, but could =
be less.
> >   * @sched_rq: An allocated array of run-queues of size @num_rqs;
> > - * @job_scheduled: once @drm_sched_entity_do_release is called the sch=
eduler
> > + * @job_scheduled: once @drm_sched_entity_flush is called the schedule=
r
>
> The change itself looks correct to me; however, a function must be
> cross-referenced with parenthesis: "once drm_sched_entity_flush() =E2=80=
=A6"
>
> '@' is used for function parameters.
>
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#highligh=
ts-and-cross-references
>
> Please provide that change in a v2.
Thank you for pointing out that, I'll send v2.

>
> Thank you,
> P.
>
>
> >   *                 waits on this wait queue until all the scheduled jo=
bs are
> >   *                 finished.
> >   * @job_id_count: used to assign unique id to the each job.
>


--=20
Luc

