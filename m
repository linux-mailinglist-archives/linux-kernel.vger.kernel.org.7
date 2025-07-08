Return-Path: <linux-kernel+bounces-720982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C105BAFC2EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E21BC009E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E352253EE;
	Tue,  8 Jul 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ABImBFNW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAE223DF5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956869; cv=none; b=P4otNUpvCom/GtwUoCZoXvsqj3VhCUUefrUqpZBdIqndf2AlfvXVhxE120vsy+4u2zwfW3gh3LEqwsincABvrh90jVX8wTssTG28mPVpwQZ7YPIujmgl1tkR049FDEiK5oL6svd0NDpo2K7IwPQwHHHPvbEnvIMs5cfh6Gsr16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956869; c=relaxed/simple;
	bh=mn3PjSRF5aAURidYrwQ4vjrt55R7G/gDBmdhvDiU7Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R50UzFp890PgHHWflmf5/Mb2pTyfDTZH89/RKz0+pmmjLypAh+mFxWbyt5ZF38pGI05zkH+Z+3YRDbgWD5e2cyr6cgdQfh1RVdvgzKRpD2ysPRjQ/O7FSZw8VdTHBgJp4HTjdBW/lbpYlg9iNU9lMp834EOT30l2F53SdNEQJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ABImBFNW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adfb562266cso629820766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751956866; x=1752561666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TZMEfz5WIJRj2nZJ2aYAIWpyLrUKEdr0s0Vm/UGWig=;
        b=ABImBFNWm8NRWv8vdBXp5pza3w85HtMyDV5UXU1KwpnehvHiHsgns0Sh+Fqv5Tq4ou
         iSolx+Esn5eN+0hL7zHeAeYM5Vy0ad1VKIAvRUw5ldSFbs4bl5g+OL4Pzcsj77ZlYaGf
         Q1FZQc2iFH0aWMgg9dwQqAPst9aC2IyA/rBfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956866; x=1752561666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TZMEfz5WIJRj2nZJ2aYAIWpyLrUKEdr0s0Vm/UGWig=;
        b=qK2AQmnhOF95eBHd2L0xnesqCWQQ8llpxZSN7psDV7VLw1R3zva8DM4FU7M3w01b9F
         u9/ShJbDIZvILK8h2Lz6R9G1No5II1BpKiL2RUpyrL5l+LC1YWav3aCl9Ga+qzgSitAb
         smaFrcdhrfgqu3KYgiBF1fG0V/k+SJ0exduqve0CVqnZtsfe0AXE8DKcyQ+KdeseuzjY
         sq5VafU0q5qbECk62GDajjv+/RHiKWM1M57yNZCqeVP7TTWhYZOL2BhPvC8fiI2rfiZn
         N0nru4mAx5xXAcqO0KHEneI1u/zuT30W8ImyzGyiiWr0s9mOLRiyStzkgf77RNVMWfWP
         BNAw==
X-Forwarded-Encrypted: i=1; AJvYcCWN3LduR/wDZWtRIepnpH2JYsd2It+UUw/bPr0PYwzRQJEpnio8OI7gRll05wLypP5kPvwEQEvTbENDVVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYN7tYGvu+F3OgvTgrEMOR9fQizAmPwD4+feq3BWQuX695kHWi
	3yck3yEXaZeE8kkScCBdR0aoZ/3jDChxFIxGlJF1PvmsFoiVD1ARmXjrXcbVC0PgvzGIb9jWQMB
	v5hFwJA==
X-Gm-Gg: ASbGncvAD8bf4MXUeBiAF3BWqRjN2GQTxItEH0KkjiE3JnK70c9Pq+opPPEOREtytfT
	MUWeap44xn+4Xb6DfALJibXNkXYYDPEd+3Lfji7aCL/1vkJlfE0Sz3A7HU5HnS5rxztt0uy/LFp
	74ftvEAuLG3+WLF+WeiyEWfjlcFBsdkUjHyRUgh8DP8V3Rq7fAWQHdLj7CzEy3/Kl6/GYSmgyeB
	LoFJY67grCeNfpthCQQ554DYhF07F/SqIxtYRkZFw2tpw4R3QAwdGp+1tfXItYP60xd3/gsRI5F
	mbqp1sPHlGgKJ4kcn4ekxe6qHdiPS4uYt4dAYCDzJzEpBpjHqaLyTi2h13rZF3ZyEYB8IcfWUQJ
	Z25grZaEHmwMj61hPWlF7OklZ55UeTKN9ZbDXpBA=
X-Google-Smtp-Source: AGHT+IFtzC5UWytzDL2VWYGkzLzIfVuM+/mw8f6StEIjt36Nsl7xNBVAPIO+eGBbEhw8XvTkgi7beA==
X-Received: by 2002:a17:907:961a:b0:ae3:f174:4484 with SMTP id a640c23a62f3a-ae6b06da709mr192812466b.46.1751956865345;
        Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5571sm841037566b.90.2025.07.07.23.41.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso7905a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtIl+URps9py1qjJ6clDpJfNhZqv+ku0fefj1QXOpef0/Om1JmUYS+AyIL0Aok+gsSAC3kqMFsgwka+JE=@vger.kernel.org
X-Received: by 2002:a05:6402:10c8:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-61051ba0baemr14560a12.0.1751956864575; Mon, 07 Jul 2025
 23:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org> <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 8 Jul 2025 14:40:28 +0800
X-Gmail-Original-Message-ID: <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
X-Gm-Features: Ac12FXzqSDrdQQK4kqjkvNzFjIs4Y1onDjlv36xI3xbZkB0uRyjH6h5P9pzUugQ
Message-ID: <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:57=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jul 7, 2025 at 12:27=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium=
.org> wrote:
> >
> > After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> > subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> > ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> > w/o trips subnode still fail to register since `mask` argument is not
> > set correctly. When number of trips subnode is 0, `mask` must be 0 to
> > pass the check in `thermal_zone_device_register_with_trips()`.
> >
> > Set `mask` to 0 when there's no trips subnode.
> >
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> >  drivers/thermal/thermal_of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd=
744725121ec7fd0d9 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_=
register(struct device_node *
> >         of_ops->bind =3D thermal_of_bind;
> >         of_ops->unbind =3D thermal_of_unbind;
> >
> > -       mask =3D GENMASK_ULL((ntrips) - 1, 0);
> > +       mask =3D ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
> >
> >         tz =3D thermal_zone_device_register_with_trips(np->name, trips,=
 ntrips,
> >                                                      mask, data, of_ops=
, &tzp,
> >
> > ---
>
> If this issue is present in the mainline, it is not necessary to
> mention "stable" in the changelog.
>
> Just post a patch against the mainline with an appropriate Fixes: tag.
>
> Thanks!
`mask` has been removed from the mainline, so this patch is only
applicable on old branches.

