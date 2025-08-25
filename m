Return-Path: <linux-kernel+bounces-785360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718EB34991
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB51B23F20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C397A3090D0;
	Mon, 25 Aug 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVEnpOAB"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F7305E00
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144888; cv=none; b=pvyIG8fKNdV7QdklXyvL3MpdCMZO1jTO4aEcm6P/U9UGj5gJtGl6sMAgIdrRQr6LEIdhplJxFR31rAL2AxvqKqvQVPE60ACaK5jmJwBiJoQ4qFY4VtARm0LjPhUfwItWRe6jhru9e7ImJpaVXyV+BN+7RSzVnpye0ysigXBkoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144888; c=relaxed/simple;
	bh=aYM216hUj9Za9m/PURK4MtZ3hB1Ba50Rccy2v9X72n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gChmF+A5HJcgsyFGNV4iYCKMLflhDDVa39Y2Fapfkk0R+keGPsGisb0hVY5jeo1YJTiKJ6azap+UQIor7ysw1NblC6KagHyGHyOxdYn0m7/4wRDFln7XC4m2EveZCTnOLvsbJRzSFRCJKXM48R7id/Nzvcu3UMufzutcI5UXyzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVEnpOAB; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89246ccded7so1381758241.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756144885; x=1756749685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9JEgY7dRXCprre7D1t++kZh8E0Oja2bjhdoASUmixII=;
        b=TVEnpOABRyLEF8apMVbSm1gnQOMCRcU0ZqSW3am8iu0HvgwA/eTXQfDaBegNcJlu20
         eYoC0ZMh5BGLQn7Wq7U7ap7aPuSPCOfNbfSPqhqh4ZNa0Vvi5Hfs6VsZ1Svc8RLUFZmj
         xtQqdIWquW7Doa4ENhM2wSgr0//9SZinbbtjKTTHm6BxKrTfGu5kn/DdlzuHFMrNKn2h
         I7d18DWTV6FDG8ZzBLjDy1SEZSW3gSUT61ERIxGDcnuSu26bMHiBsCgy04hDqJEA0lbx
         gilWRKLQPrSxBYZ0rTjdTNxtGsWB7Nd0sfrDjsct1Ebow/6xJmXB0w3m6JUgCKRW5hiz
         dfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144885; x=1756749685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JEgY7dRXCprre7D1t++kZh8E0Oja2bjhdoASUmixII=;
        b=q6vMBXJOomrgnicsEtmrVT9gIjHHrql3WAVhayOB0dGkGz1tbLJJNp9Mh8lQfV3ut+
         6dBkTxF0JzZyME1PK8V3rn9Ejsz/OyYyawQduuG9wrb6ceZBI+0tZoachEBUomm6MGc2
         ZE+jgRoZP6YwFgtUKyA2MS2rETm39IbncHNiu8bQQriLpECugkiK6cIKp7Q0kbiHG/1b
         nFdatYAhexF3UkBrvkkLAAJI1QfBM20IcxRdgXdG0hfgQm/Ehbg1GR2CPTcA5IrYQinC
         5GrJsdqm0rgMngQePcjsFydA7Fq8WCFPz+Fgfx21qxT1tBTQ3bTGuO4bthOz6/wOEBv0
         eDAg==
X-Forwarded-Encrypted: i=1; AJvYcCV564wlXeofOX4L7avClffF1b2jIktY4zz/jxeiWqgX4W2fZnpdw43fJOkHGM/vi1kkaVWi3OOvGMl0qhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+vQyEXT9U5wYr0lB6xD5/GSlPgNzyNzlWTAFrCj8GsKp0k1H
	XlVcZgruL+IK0dsEYMhzMFgBngptMbVOKCj0VGK3qTNtnn0Uqw849rFEq1xvks1uUb5egGy5K3J
	ihphbSuWz7qPvCep+kKuZK5DFGgaOJpY=
X-Gm-Gg: ASbGnctu3LIPx4GgbAgJsdJK5zumpM7Lnh5OCRx605rkmdoSgpe9UzeRJ7mXzCteCj1
	59NffslGNyLcEZT/ChM9rt4K4ctb7v78ugundcNWdT1gc48Csh3qLppT2Bt60GcCmexvNF5DhOG
	XxpLzfxq3C2golp5m7fcQoiZPaFWyY9YzUR9oKSisL4jjTvF2ttXJ2OdYGZEh+ryPGzUGHMu9KB
	ELRm1I=
X-Google-Smtp-Source: AGHT+IEC33cQX3w4hqQ05JpwXSzo+DF9J6YqwU6e3jbvhn8xMt6PPLpI5WLLZwD+06SsM5WvDSWeKawFI5hyV3oKGUE=
X-Received: by 2002:a05:6102:3e19:b0:4fa:e005:cb20 with SMTP id
 ada2fe7eead31-51d0c8d7a21mr4380911137.3.1756144885138; Mon, 25 Aug 2025
 11:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823075139.34797-1-rampxxxx@gmail.com> <20250823075139.34797-2-rampxxxx@gmail.com>
 <704edc3cae07cf09f27ff476ff11ca5dd2779520@intel.com>
In-Reply-To: <704edc3cae07cf09f27ff476ff11ca5dd2779520@intel.com>
From: Giant Sand Fans <rampxxxx@gmail.com>
Date: Mon, 25 Aug 2025 20:01:14 +0200
X-Gm-Features: Ac12FXzSA7Kvn7HfMDWBLxmy3lBmT0sJaw4T_DFukIorI-nLs-5vgbIAFKff2XE
Message-ID: <CABPJ0vh0VTdY4Mcso4m3224NZX01riSEBQng_=mvEZYgjgpBrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: fix kernel-doc struct tag for `drm_modeset_lock`.
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 10:00, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Sat, 23 Aug 2025, Javier Garcia <rampxxxx@gmail.com> wrote:
> > - Add needed "@" to avoid warn messages about duplicated symbols
> > as there is function and struct with the same name.
> > - The fixed warning is:
> >
> >       ./Documentation/gpu/drm-kms:476: ./drivers/gpu/drm/drm_modeset_lock.c:377: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:48.
> >       Declaration is '.. c:function:: int drm_modeset_lock (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'. [duplicate_declaration.c]
>
> Please look into why adding @ here appear to fix the issue.
>
> The problem is deeper than what this patch makes it seem, and this
> papers over the issue in a way that sets the wrong example for the
> future.

Thank you for the comment, I'll look deeper into this.

>
>
> BR,
> Jani.
>
> >
> > Fixes: f3a808817fdb ("drm: fix drm_modeset_lock.h kernel-doc notation")
> > Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> > ---
> >  include/drm/drm_modeset_lock.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/drm/drm_modeset_lock.h b/include/drm/drm_modeset_lock.h
> > index ec4f543c3d95..0de7046dc653 100644
> > --- a/include/drm/drm_modeset_lock.h
> > +++ b/include/drm/drm_modeset_lock.h
> > @@ -75,7 +75,7 @@ struct drm_modeset_acquire_ctx {
> >  };
> >
> >  /**
> > - * struct drm_modeset_lock - used for locking modeset resources.
> > + * @struct drm_modeset_lock - used for locking modeset resources.
> >   * @mutex: resource locking
> >   * @head: used to hold its place on &drm_atomi_state.locked list when
> >   *    part of an atomic update
>
> --
> Jani Nikula, Intel

