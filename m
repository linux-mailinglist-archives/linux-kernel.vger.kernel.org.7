Return-Path: <linux-kernel+bounces-852075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39524BD81C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FD664EB9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166D530F555;
	Tue, 14 Oct 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bL+9QbFB"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FF1A9FB3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429480; cv=none; b=B4ckczW64hWEDmmRY28qJKuiqIOMMs6JOmDru4xwk9Hq5Mo4hs2G80Y4CNx5pv69wiFXUZbJMdFC+AfZCltpGDZzsVSJv0J1TdRrxv2ZCLBkBr+YTftcZ4W9e7EweceuopQDs7HbtaTi6U+2QQIX57l7J6oquQqubrDI6p7g+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429480; c=relaxed/simple;
	bh=5Dm0ATb1dpCKkWGi2z9sqddFhoiE0Y1gELlytzHuHb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qk/Mrew76RVvPvHjo2pV22CP5jKjMGCptVCRs25f0LlLVNSNtacDeC1FPsbMVZ8evXNbfkJuANFgLPMsjwgr3PfVS8TJ+A275qpc5h16nNZTB32etaqqHpudLe9EpAk2Y1bJqOpJyZN4xefY+VNyxU2rLmS+PlED7tUlRIlQeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bL+9QbFB; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-859b2ec0556so725844285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760429478; x=1761034278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMGJPaAzV1kru6wKkSy6MVvIko6e1M+iRPzYq9fV7VU=;
        b=bL+9QbFBm+/U7D/rPAOjhjbOLvOVBE4e3cgoxBScdo/xA/jz6UTljatze3psv/OyRE
         84NVaH/8GwGJgyLHgiNGxGzQxUlqpHRb7NME8ZIaTdE8aPSGXDU1o+3qV6dUeoQfDt9G
         jAmcj0bK/ZezEbYK1VWd3iejiQkIMyCH8zfPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429478; x=1761034278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMGJPaAzV1kru6wKkSy6MVvIko6e1M+iRPzYq9fV7VU=;
        b=TdRFDQqgfjz9ZdHBJwPn5IObPbiK7EfFo7YIaw49q0UuqTTV66Ws0StVt1ayuhW5KL
         Dp4HPkcAAaLYF0MeSw9V5iuPpD57lSnkhYvqV8FExy7xmWZWFnBnbOWH4Id0W3Umsn66
         y/TOvRX1Hrn9QAaw1DE38267mkeDI0BOTJmflkFb90MiBRfp4EzPmksQc8/71uFzXd6F
         O6X5iXjhQNdkR02VJ6sqZxPEPOOrjlHgkXwdAhikoz5qO0GBdTI74gFPVJQk3rIRF/fM
         lAhzR3WN1tcp/SDO0FILM38yiBw15Qn0++4drXZdSkkg+6ecscNSXwEa/MhHcR/oNfnv
         YHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX46KKO49sad6GGIBOjaaTbKuLizEAdQXkdgVozvtfgb8fT6RY8VGi98HPg3ywv4qfz8c4fIHWtPfqkJ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVuMK77GD6xM4Ybj1YrvcVl1i7FmrwbuLFkVZ84gB63RKL2Gl
	Vn1r9TYNf9t9UyzYCA5UnO+0VbpmtywsQYUMZjsi33LD051+16TJP/NwbnhISKJyPbNZb+voQ4Y
	pu1t8GGa/8gLDrWiBgWjOs4Ll6/dmo64Q2OEvsldiKg==
X-Gm-Gg: ASbGnctQSh0uvjpa0xAfPQAoX74z2N6TUZEVEHBQaNq/+tsCPOd7Ewi47pX2JxXQWV0
	iMKL1gxgOduYH3V5mNX00u0toHAZ+e0IwSGbQBMFzESQdCOgZnm4gtNNYHZXR1OHDlMSrFQLLSR
	4Mj/Nndhr1XXwcMKO+n1QKbUBMJx9wKvg8fVLi15oyvxwyrx13PobwsOuleHkck+vLW4rOr4y9p
	HEbcy97vNeMU+wI12a0TOM3KkwUwXOGHNJ0xBGnlut3zyVs9Yw0kto1n8MYAATrzsbDCw==
X-Google-Smtp-Source: AGHT+IEe58Iab2hR+xoB1mSPnSaPs35dSPKEd8XuvJsaUY54Ngzy2aU0wZaHOb7oRhbv7gRDzjv3kBVeuCAwgqnL/gc=
X-Received: by 2002:a05:622a:54c:b0:4db:7bc2:93a with SMTP id
 d75a77b69052e-4e6ead513f0mr326143401cf.51.1760429477785; Tue, 14 Oct 2025
 01:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com> <CAJnrk1YRNw5M2f1Nxt619SG+wUkF+y2JrMZZCyLqWVd59+-gjA@mail.gmail.com>
In-Reply-To: <CAJnrk1YRNw5M2f1Nxt619SG+wUkF+y2JrMZZCyLqWVd59+-gjA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 10:11:06 +0200
X-Gm-Features: AS18NWBcWGZkbj8Hpx9Tbn8t3-4yZDs4Zr9hvCDpwsLr7w1WwSOX2qBWki0bKgA
Message-ID: <CAJfpegvt8Z4ftmQ37ptD8gQu4CHCUB1smxxTgngNpRaDm5=1dA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Joanne Koong <joannelkoong@gmail.com>
Cc: lu gu <giveme.gulu@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 at 01:44, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 6:40=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > > My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
> > > similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verif=
y
> > > that it hasn't been invalidated.  If old_mtime is invalid or if
> > > FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
> > > cache is not invalidated.
> >
> > [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
> > Link to complete thread:
> > https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.=
com/#r]
> >
> > In summary: auto_inval_data invalidates data cache even if the
> > modification was done in a cache consistent manner (i.e. write
> > through). This is not generally a consistency problem, because the
> > backing file and the cache should be in sync.  The exception is when
> > the writeback to the backing file hasn't yet finished and a getattr()
> > call triggers invalidation (mtime change could be from a previous
> > write), and the not yet written data is invalidated and replaced with
> > stale data.
> >
> > The proposed fix was to exclude concurrent reads and writes to the same=
 region.
> >
> > But the real issue here is that mtime changes triggered by this client
> > should not cause data to be invalidated.  It's not only racy, but it's
> > fundamentally wrong.  Unfortunately this is hard to do this correctly.
> > Best I can come up with is that any request that expects mtime to be
> > modified returns the mtime after the request has completed.
> >
> > This would be much easier to implement in the fuse server: perform the
> > "file changed remotely" check when serving a FUSE_GETATTR request and
> > return a flag indicating whether the data needs to be invalidated or
> > not.
>
> Doesn't this still lead to a problem if the data does need to be
> invalidated? If the data changed remotely, then afaict the page cache
> would have the new updated data but the newest write data would still
> be missing in the page cache.

Right, this would need to be done in combination with read/write exclusion.

Thanks,
Miklos

