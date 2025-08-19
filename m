Return-Path: <linux-kernel+bounces-775546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F300B2C07D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8623B14BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA932A3F2;
	Tue, 19 Aug 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="fYiRGH72"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE8326D72
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602926; cv=none; b=TbQwZ8CmBoD6S/ma6V+FhhTirmeQbJ83TYSd+N9qTVi7lfvaYMsyFZyknIZ0z1aooOZtSx2a2M/Ki9NJXNx5RS7NP7zyrgFX6i/RtdmdNdGjIVJ0JLpnQB8GVHLF/r+ALO/0hVjpuW3lfjHr35OxRpkCNG9GsoyM15zcpbpgHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602926; c=relaxed/simple;
	bh=myKsvwNH99TlxBSb2QIjtLkyW9gCml4h7oenqAl9bog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7CRuWjNQAGznVz1ADEVQP0xDR05rqRmv/KwlBtLnTvlZmzoqhzJYMxblYVqhSJY49r6Ap8grR+NloeRizBjNfL0kCKwYLNM8NA23hmkpQrVcOWNm35SgMsBQOZiltoqkp4sjpx6tWZ1O5No46eqGtUDjGqZEiyYr6wrOqJRRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=fYiRGH72; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71e6eb6494eso29903417b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1755602923; x=1756207723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIpLciw+1XEu/4gPMiZnJGMUt60j6UkGL0YXIEPs+TY=;
        b=fYiRGH72f8ldwa23NFwTyc3y1EQB4oSbIpSiVEgUJ3H9Yj6pzHf1io1P1TFpS868oK
         +sXVQ5xf85vMqn7GQa0+IzlAJ2NRhuKwN72SiYBdCjauYpymsAXSl4qmc3N0hiVwHRzT
         T2ZKGCzesDklTrwpVQKY0/2slfLWBpDmOaVHF+GshBPfBDuGOMuWiNNGp+QGoxI4gGdR
         5htvvVQvkCmrsBXnu+GbEfZb1VOo/+HS4N4ijacIZuk1q4pp4JGskj7OFp93yElXcYox
         gC0U6Hl4jHdmEOUR5v/3+NdBlTt3vqWqOI+K1R5SwfQezj7KrxMl0bNA80FpyjQCQYv5
         EW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602923; x=1756207723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIpLciw+1XEu/4gPMiZnJGMUt60j6UkGL0YXIEPs+TY=;
        b=tXgx7vOGdjNzZm+PUiDnb1gfiukcBmiqw5tSAXgTOcp+8FEmrEs3kLujRZxDbAwlMQ
         Z0sw1GET4+bUQu+MJeme20EXDFiI/TH0DhuSgetZEfEkGa1Wc/6yJrWRwl4JjIYK1x3h
         akF1adRlWMApzjikiFzH6rA+Tv1KF/z/sQSDm5JfGAuQRaaPFc7YkNcknggWFYK/zXN1
         CVvg7Yy545G9qU3lCTvmRrmhEk3w27kGXAQ4H0v7AVcm4gm7DYSjML2Ti1duO4ILWJXa
         6Q8WKjxr8wah7Aef1bwRfG+0+WhoWqmpNMrNFdx2WdDc2z6tOtwvxB599X4PN3I9K/XR
         AzLg==
X-Forwarded-Encrypted: i=1; AJvYcCX1NCI3bjC883mFQ54iz0PyI7QiWqQl1NlriAvlmEPjlTF5cozwFUq9jckTHd0CV64iSGzp92RTzhyjIkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Ks0zvZsovQdQuT83EUsuQ6McstWjYPWpFSX/xSCgya8dhvV3
	+fh0RTOHZKa8FsA0MG8JZmJu9gCymWBpBBF/TRbWeYB5bq7Jvm8QRRQCxHfmw4x+V4VCApCMGfk
	tmN7RkOOvOZa///6Tp8qpLMkR9fxYHWrRNbUDoig1eA==
X-Gm-Gg: ASbGnctaSYCv+Xsyx69CHQuqNjomuYH6ON8zQizHAJC+xXUgLwUdzsgv7DUr6TizFrj
	upoC9uVPIQaggN099RuKJVTi86AMTKIn1VEH2vjYY6+a1kin8GsXPVjexxvzUn85FFX5oNSCLbj
	33AAdzXkpvZQXI+CIiUFJrKrR3bLPOvxzuWX6q5dytuXe5ivPKrPhSgbIBZvHh3+9N+TDt4ypXs
	XtEdD+cP/nNQOIDBMfI+lLAoBQxNuVDT3EnEKJH28FV2i9NhQ==
X-Google-Smtp-Source: AGHT+IG/wHjJd0uy/3FLG7fBMCiAI52cyNR0ZLVdEi2rD6nkFaQbn6okYNWT8up2/jc1S+MzYBUHsR02oAJoY8whuEI=
X-Received: by 2002:a05:690c:7209:b0:714:268:a9f8 with SMTP id
 00721157ae682-71f9d61d74cmr22846967b3.27.1755602922860; Tue, 19 Aug 2025
 04:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com> <26f31ab8-1b9f-466e-aa9e-2b76bec7a364@collabora.com>
In-Reply-To: <26f31ab8-1b9f-466e-aa9e-2b76bec7a364@collabora.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 19 Aug 2025 12:28:24 +0100
X-Gm-Features: Ac12FXx3lj2u6gCEsaioe_ILwD0hCHIhxZB4MQMwCNCYBCspDHiMigskd6GA-ew
Message-ID: <CAPY8ntDJEyexsrQAWmzaunECxnT3F0zDzVhwe5gHmA_zAnW_8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm: vc4: Add support for additional 10/12/16bit
 YUV plane formats
To: Robert Mader <robert.mader@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robert

On Mon, 18 Aug 2025 at 11:46, Robert Mader <robert.mader@collabora.com> wro=
te:
>
> On 07.08.25 15:28, Dave Stevenson wrote:
> > We'd been asked if the S01x YUV formats could be supported on Pi5 as so=
me
> > software codecs produce them.
> > The answer was yes, so this patch adds them and the P01x formats.
>
> I tested this with the Gstreamer MR from 1 and can confirm that the
> formats P010, P012, P016, S010 and S012 work as expected.
>
> Unfortunately S016 is not supported by Gstreamer yet - however chances
> seem high that it works as well.
>
> Thus the series is:
>
> Tested-by: Robert Mader <robert.mader@collabora.com>

Thanks for testing.

In combination with my MR to libdrm/modetest to support these
formats[1], I'm happy that S016 works.
Your testing through Gstreamer gives me confidence that I haven't
messed up both my kernel patch and modetest setup in the same way :-)

Thanks again
  Dave

[1] https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/425

> 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/85=
40
>
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> > Changes in v2:
> > - Swapped from adding an extra bool hvs6_only to having a min_gen for
> >    each format (suggested by Ma=C3=ADra)
> > - Link to v1: https://lore.kernel.org/r/20250724-drm-vc4-extra-formats-=
v1-1-67fa80597fad@raspberrypi.com
> >
> > ---
> > Dave Stevenson (2):
> >        drm/vc4: plane: Flag formats as having a minimum generation
> >        drm/vc4: plane: Add support for P01[026] and S01[026] formats
> >
> >   drivers/gpu/drm/vc4/vc4_plane.c | 56 ++++++++++++++++++++++++++++++++=
+++------
> >   drivers/gpu/drm/vc4/vc4_regs.h  |  9 +++++++
> >   2 files changed, 58 insertions(+), 7 deletions(-)
> > ---
> > base-commit: d2b48f2b30f25997a1ae1ad0cefac68c25f8c330
> > change-id: 20250724-drm-vc4-extra-formats-1f53e6491cc1
> >
> > Best regards,
>
> --
> Robert Mader
> Consultant Software Developer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
>

