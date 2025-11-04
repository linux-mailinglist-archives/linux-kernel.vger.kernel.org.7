Return-Path: <linux-kernel+bounces-885334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CDCC3296E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 147A44F1837
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681F33E361;
	Tue,  4 Nov 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz9AO3eT"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DE341AA0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279948; cv=none; b=tpiGSvxxpGeMM2skN8hqdDZXkJhEFjXpikpI3PDer7r5IFAQj/QMgfsoEgGvMUP1rJae1AJUg9p+ocFQBqB+c0Q18kZU8g74Xm4y2jL6xr6KG4RGgnNZT28jEK5oIuZXz2VpMW9kiEQEQ408bP0dJQvohclc8wqU6fBvkOv4tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279948; c=relaxed/simple;
	bh=zJ154gBw+0UrxGZXHQyMlHoo0g1jkFmN0Qn80qWpgNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4z2c3w+EJZDbvjfApHscZzGHdu3+TuVQ+og8eoSdg0Rm6A0WfQ5o90SGxGWzzLiLW/WR4xX7Bu3IoXIoSBbIBpihZlRKgTbj4Z/b6TXZwhEgqP2Za2aikYc4RmTdLe4DoFGv3ABms8ndZb04Tqpcl2S6seAdtYXMVvd1oz0lDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz9AO3eT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36295d53a10so50477811fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279944; x=1762884744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfboT1HRbq+3rQiXHdhZQOYYLi1wTFtTVKTz7vRyT3Q=;
        b=Gz9AO3eT24JRw8NKYW+RoJsBDBXdaEy9ebN2QXLTcelD5huQGC/WvEMOtcxAG1Ch9M
         XXoFxUEDNe58PgHYgYX4RLgDsgeYd6ACpCgSfscoszWe7FKfy+UWbjOOeoAjdpZzuIWO
         Q5GeSiQE5h+WuvUDOXCgZisPCH70nUeSXksyWr7D4wVQJ5dEJ0ZMLkzyIA682jB3RLlY
         QYtKjoZu6efFBV4XLhF8A6lQEUYcqPVbzHeN4/VTcEKZdqHjA5Pre0D8z3fmzcbx7aFB
         /9Scf7b49zXcsYBYyjZtctW+w3Rpbg7EW+v9rM67Sn7LNGgQHlWq76Ilgm9FsxiXrhlR
         bfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279944; x=1762884744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfboT1HRbq+3rQiXHdhZQOYYLi1wTFtTVKTz7vRyT3Q=;
        b=MQS+XA4DCUVlt3erf1LPxQUQskttOARzUBi+g411X5nBDHwXeGR/bsym1Mjh/99keQ
         eWGWpe5DWCoBaMufxT50NM8oaOCedPtYGfMluLbxhBE5KUZabXSCSzyW5LHnpmvvVkWN
         Si7wOqJzzpOAzwaRghm++DwNT4dVjzDeTiVUmSfq7hvT+1hopTqQMlYJr1hzXzLCQ0Tz
         UPbqOJbpmGnWTyFUN4Zv5QMgk963NFQOEcBdg6ssd2HjdLAVfD7hjgHx+K6L7/9jxj6M
         T69Z26liCSPzgi2krwon7IMe+XD1GtfSVrSNknLrWYCgF4sohb7lX9/o7+jb1bSwKpn9
         UtPg==
X-Forwarded-Encrypted: i=1; AJvYcCWSdnodxxB5R2ciWKdiqXCOxbVlgUZpCDkF6M7yTMPrPFzBFsOGJK7uFMshFhJuF736eB25Y9VKCgtal38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkj/zgMpiZzWt2dX3+roMQVi5FZW6L3MZTHhJ+WiA9g9Un0Lg
	vBiEchrEsxcMOurSScrzft2CiVfxJ3Rm7GGBzoARdJCckRIU7qVLVBqbpeC5PaDDlqHD9ns54Kj
	PiSRfe0RGhFE6Gi3t/YpVvU5to54h4dg=
X-Gm-Gg: ASbGnctNzmFtFbHULCERHcnLnGALIL92W9JGKnBQwkUS+1kP8eYsFaXl0vt4M9YN/Ap
	1eNWc9EVsgqeYG4tlYQFmttJ67zsvJS3gZmukCa1A/HoZ3nIkub+H/cpaUipMGzC1NR60G3DIiP
	pPInWlebOO4HAbOg+PEYyt1omlMStlfkyYJPBQIMETPNCvpqyByK7RqjULdDckYPSsPHDLr52SS
	I+tg0R9Dlu6ui0PS9W/H6Zyo7VWvukReW6HQQCts4CKKObeczwoyvc3EX0A
X-Google-Smtp-Source: AGHT+IGPRcVYUFkbfND1yCrXsYjPphzvBXM9kevVuqhVKPN4rVG7BAHQZtqPWdFIdx6QTyf/wx86XLa5cCF/q3DF/D4=
X-Received: by 2002:a05:651c:25da:20b0:378:e88e:70b7 with SMTP id
 38308e7fff4ca-37a513db58bmr649531fa.8.1762279943566; Tue, 04 Nov 2025
 10:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-tegra-drm-cmu-v1-1-211799755ab8@gmail.com>
 <pedxgtvzfrfzihoshhfvntin3hwwi3znleilbz4abjad74nowb@un33lgiaa26z>
 <CALHNRZ9-XrMUkQE0cwjq-HUYsy5uerhOQ9sNpirp23kKoaPuYw@mail.gmail.com> <72llskwvuwyllvz24zoex4ad6v6t5skiehmwylj7exoh7bmzjo@xq3v7vja5w62>
In-Reply-To: <72llskwvuwyllvz24zoex4ad6v6t5skiehmwylj7exoh7bmzjo@xq3v7vja5w62>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 4 Nov 2025 12:12:11 -0600
X-Gm-Features: AWmQ_bndq3GXj9nT0T7kbDH5M6YrNLEoNzE-jIY8SE3xqTqpn3-DYrXuXrQFrrc
Message-ID: <CALHNRZ_k6e9ZRmpK6Pzpet=RzUQ0fRYmfnea6U+9E2oZc8=z7w@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: Enable cmu for Tegra186 and Tegra194
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:14=E2=80=AFAM Thierry Reding <thierry.reding@gmail=
.com> wrote:
>
> On Mon, Nov 03, 2025 at 12:39:57PM -0600, Aaron Kling wrote:
> > On Mon, Nov 3, 2025 at 5:54=E2=80=AFAM Thierry Reding <thierry.reding@g=
mail.com> wrote:
> > >
> > > On Sat, Nov 01, 2025 at 06:15:17PM -0500, Aaron Kling via B4 Relay wr=
ote:
> > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > >
> > > > Without the cmu, nvdisplay will display colors that are notably dar=
ker
> > > > than intended. The vendor bootloader and the downstream display dri=
ver
> > > > enable the cmu and sets a sRGB table. Loading that table here resul=
ts in
> > > > the intended colors.
> > > >
> > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/tegra/dc.h  |  13 +++
> > > >  drivers/gpu/drm/tegra/sor.c | 206 ++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  2 files changed, 219 insertions(+)
> > >
> > > What does "darker than intended" mean? Who defines the intention? How=
 do
> > > we know what the intention is? What this patch ultimately seems to be
> > > doing is define sRGB to be the default colorspace. Is that always the
> > > right default choice? What if people want to specify a different
> > > colorspace?
> >
> > I reported this issue almost a month ago. See kernel lore [0] and
> > freedesktop issue [1]. The pictures in the latter show what nvdisplay
> > looks like right now. It's nigh unusably dark. When booted into
> > Android with a tv launcher that has a black background, as is default
> > for LineageOS, it is really hard to read anything. Is it correct as a
> > default? Well, cboot hardcodes this, so... presumably? It would be
> > more ideal to expose this and csc to userspace, but I'm not sure if
> > drm has a standardized interface for that or if tegra would have to
> > make something vendor specific. I think that would be a separate
> > change concept compared to setting this default, though.
>
> The reason I'm asking is because I don't recall ever seeing "broken"
> colors like you do. So I suspect that this may also be related to what
> display is connected, or the mode that we're setting. It could perhaps
> also be related to what infoframes we're sending and how these are
> supported/interpreted by the attached display.
>
> All of that is to say that maybe this looks broken on the particular
> setup that you have but may works fine on other setups. Changing the
> default may fix your setup and break others.

Do you have a device set up so you can check? Or does the regression
test bench have a display that can be forwarded?

My current setup is a rack of units plugged via hdmi to a kvm which is
then plugged to a pikvm. I also observed this issue before I had this
setup, plugged directly to a 1080p monitor. I have not checked
displayport. I can cycle through a couple other displays without this
patch to see if I get any other result. I am fairly certain I have
consistently seen this issue since I started trying to work with
tegra-drm on kernel 6.1 or maybe even 5.15. I've never seen it work to
allow for a bisect.

I am in contact with one other person with a tx2 devkit, who
replicated the issue when I asked. Who plans to reply to this thread
with setup info later.

Aaron

