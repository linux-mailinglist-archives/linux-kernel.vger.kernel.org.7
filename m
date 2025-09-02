Return-Path: <linux-kernel+bounces-797241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA4B40DDF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1347178E67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92F3350823;
	Tue,  2 Sep 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRzBx2Av"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F22E54B0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841388; cv=none; b=i9RIR3rF5Qr2QtEntNNYAsJCLPNtjwRY/yEYlr2nhif2n7QSwYiHjHKTTxCMDUyP7uridw7X05jwj83QNgeXpOWqPDsEzJm+pbrxuuZDV48Eg8LC5VKkxpy8H0Eg5hn7sbR2Ceui5Cyod24agCaWI2d9VDGR6kXEH22JaAAgc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841388; c=relaxed/simple;
	bh=EDPYZ7AeuetLSueyUUgIpG1TuGC9xDiYOStlafV5IN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sir7xcIjfJyQyEtqPiIp4UBDli6CefE1n9fgs+oH3EH4DHIz4stwLp9NfqgOqdSS/P5DRJQ19f/XuY3Pkqu/RlFkLwe21empdIo2ENbTO5HZR7LqhU4O/HV1BgL88V0Zjl0uaV74rOm/glQHuzZyBqSd4OPYGOWyKhxJeiiYuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRzBx2Av; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d6014810fso46391487b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756841386; x=1757446186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCDtmJ9MnRRD8pZdomc+bD7vyzpQ5/EL7gaHH0a7i9k=;
        b=TRzBx2AvO0g9Ov4GVcpokDzZvtlJtXD1+LPXWOoI5p4y2ChYUiq0ugkJxha/1vcRxg
         j9F+RKzVQ2eSRSPfKF7ncmn/kmayXj1eNKMdZsHUktTJdHVtWxIDh02PdP3zOyDaY5xM
         mInZyZnt1qzZHplqvRDnXACN4Jhz2i06EgHTfh31jOlj6ufDBHHe2m09EnllFobuE3lX
         4leKuBDP6U286ipoqJN5ZqarNmIfFDdtsfusKEd7amS77LM3uI9TLXm2/KUuooveJ4WC
         j/zid0yB6LCZByHbPzKDjvE+8ubKiEMWb9259OLHAJRdPDBaNUl/XR/DX082aglde5+Z
         GFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756841386; x=1757446186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCDtmJ9MnRRD8pZdomc+bD7vyzpQ5/EL7gaHH0a7i9k=;
        b=sjO71dlUAsm9hpg2oc4pwZdaFFR6zhkIG6C3ytOd5m6vaO/Nw5BGCV05WyGrF5m4ie
         8iA5B5URFEtZ3R0RkRjXRT47uY2blD3z0B7JWKg8QMgHn2HvELOVW8OyTQPIZRMx9YzS
         NVfYlOngt2M9d28jCYYfz0MH3mJHzeDmwcEzZOOd2yBH7+2c5MbCV3N2nj3A1gHw46Ru
         e3sJ8U43zK3PLrbBYYlRe4Xo0A/tGkpM2I2SrEG8mlnrIFfP1g6SH7OqWcWr5eOPke51
         eSgQ3kN6yVupZdGC9nA8sm5G+uDpkUSSdNHdtuHrtLTZAukbTpIh/7W/ulg2W2q1Wkxn
         ZrCg==
X-Forwarded-Encrypted: i=1; AJvYcCVgM2AenoE5c4Bfm9C7cOGH+1jWT+AmHuYmh8f82HKYXTF9P+pwEiFEeWAlVijiu+4wk9i5UGsf11j5i3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgSWrCiu0pcIXkWp3VxxYfUBBU9W8eiR6q7Qh+MHu+3koc9Xmr
	9V8CwXxCVKb+07OOmG6VTuW0E2d95FGiGE1Y+pnfDtAXtDmS2udnUIgSxedwcJKSmiNbqP/QlBk
	FUN+XS8foXCWmoNUijSmrokRBiH85uyE=
X-Gm-Gg: ASbGnctTwYbq8Z34ZbGVgspeec/hYctnXkdVqF2YtiKZEFFzO4fkHvvCq4V863zkL3F
	+OWKbvmAjRX0wIpeBMVP4qblaHgn0IyjXztGr5JBs+nXZdqDkcApQ6GLxFsRuu4Gwr/rf0kmxl/
	Xop4/hZQ2s95God8QNHOLYvz28++sZ5Q68rO8gKYL9TnyaFNpqsUztqKw7Po9wsl2F5yH8T6j2A
	nmHUkBa8UBIFwHewcEwRqKTh8CeHNTnh6tTCAiYXpDirdJGN4E0XPKiNHcV2TetXvZjitcn
X-Google-Smtp-Source: AGHT+IGTLvT2TgzPf6r2XqdEnizQavc2n6Hz47RT3wEvJ7iVTXIBCwd89zfqpXV936H4mpV9p0egjFgHh9H+RUCPcwQ=
X-Received: by 2002:a05:690c:3809:b0:721:64ec:bc65 with SMTP id
 00721157ae682-72276537066mr135149447b3.44.1756841385677; Tue, 02 Sep 2025
 12:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829230251.3095911-1-olvaffe@gmail.com> <20250901092711.15832cfe@fedora>
In-Reply-To: <20250901092711.15832cfe@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 2 Sep 2025 12:29:34 -0700
X-Gm-Features: Ac12FXw1HjxcTsR5YSE7EFPgr2NIGInvguTOoGuC8pCUs2YgJlMpIsI50AoKFsA
Message-ID: <CAPaKu7QMy6c2zELBUXAUqL_NqYyC7v-xP0_dkxUhOnO86nUCwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panthor: assign unique names to queues
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:27=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
<snipped>
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/=
panthor/panthor_sched.c
> > index ba5dc3e443d9c..62f17476e5852 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -360,6 +360,9 @@ struct panthor_queue {
> >       /** @entity: DRM scheduling entity used for this queue. */
> >       struct drm_sched_entity entity;
> >
> > +     /** @name: DRM scheduler name for this queue. */
> > +     char name[32];
>
> The base string ("panthor-queue---") is already 16 characters. You then
> have a group ID that's below 128 IIRC, and a queue ID that's no more
> than 15, so that's 5 more chars. This leaves you 10 chars for the
> client ID (theoretically a 64-bit integer). I know the logic is sane
> because you truncate the string, but I'm wondering if we shouldn't make
> this string bigger to cover the theoretical max client_id, or simply
> dynamically allocate it (kasprintf()), so we don't have to think about
> it if we end up adding more stuff to the string.
It seems we don't validate queue count.  Sending
https://lore.kernel.org/lkml/20250902192001.409738-1-olvaffe@gmail.com/
for that.

On a user device that opens the render node once per second, 10 chars
are good for 317 years.  It lasts significantly shorter on a test
device, but the uptime is also significantly shorter on such a device
(hopefully).

But kasprintf should be harmless here.  I can certainly switch to it.

