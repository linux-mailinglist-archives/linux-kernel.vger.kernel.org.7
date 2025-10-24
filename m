Return-Path: <linux-kernel+bounces-868771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1374C06145
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75499504477
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C322C15A9;
	Fri, 24 Oct 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUZpa/ro"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDB2BE644
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306339; cv=none; b=s4Gda/hGIiqe/I0GRK9aRT+cdD6EE83hheLd2qTB6rotD765Hi51N+hFoXD7bx0gr6v8atPtaWh62THn+mH7jCAVF8vboUwfwFxbrfov3rJ5wMLgY/Glv0af4AaXh3AVvE39yIJyoZZ9ZU8zeehsADFRXvWaKFOdibEOQ+lmm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306339; c=relaxed/simple;
	bh=luQ7I+dQpgs4csu6w7EuEEhvuol5CB8yAgkxGJFsrrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0mHJsGNmutf0ZyzbGJtVDzLJBVcKf7nRh45VxXG8N3fHakIwmJfUudYfT6WN7effZsnnDbE8CUApkF2hkfDQ0ejPZF3kQ2j0BGiU3utHzxzqWkX9qLBlnJTLSW8rWwP0rpDuis3dmGc5xIBYS3bpyLE/ULGeGj2QqnJiQ24MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUZpa/ro; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso64291066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761306336; x=1761911136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R28RbX6yacDRN8EZS9Zv9Q6wLPVR7alXUhujea6//I=;
        b=XUZpa/ro71LflahKLks/t2Ipvkk26qb+krJodvno19QNsdPRQXj75a9MQc0+vsqLNV
         ADRpKrGlw5kFilCkKNG3X0nEnXJGIHfbQN9BX1OOrbmouJvvwZ34d/8GNLrDlgtEOyuC
         mcfn1wnsQ5Dvt+4LYmnFK066p5R0e+wKXO3j/1optJKXmgI9j78ETbzXPGBQPvxGRZX7
         Obs6ESXcYoveZbOTSx1DbcazR28GJai1Yz2+q0LECFEDOdo6iM6+zbAN2cdk/KSQ2G/m
         rvh4yVf3SEh8rSiBbumIWHVUXHoqvLYBN27Rroe10UPL/KYl1RyFrQ+ZgXoxb1RN341N
         KQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306336; x=1761911136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/R28RbX6yacDRN8EZS9Zv9Q6wLPVR7alXUhujea6//I=;
        b=kkXOfq8Xw2x1DTMTK8eOzfw9+NRDcoLXDmCx7IQCjTEwj6Lb9N4Sw+4mJp6S7Qddrk
         1OinZxX+tnTUpnA2XWExJwzrk++jwA9F2at/LD2oAWaKrhKK74Q+nMcur4VMg/yGbRzx
         fbclsbyYatiz6vh05PvE3maMNkiUYNaabs2FZvpVfdfbNlnuypTr2El8gGus0e++CXOw
         sMChvxywSxXl7lgCtvyO0VREGvBbZof0AzNSIIixysN5rPvvwFwbC50dAQe348fUT4N5
         lYBYs2wdMLFIhuJA5xfaXSlRHbyYa6OkM0ow4XxHXNuQWMBSqqH2axTwKh0aMsUa5tOn
         bt9w==
X-Forwarded-Encrypted: i=1; AJvYcCXhJS1sMBHoELZ2WdHkRECb+pO6OiNwNvYA9aVx9m0Zs3YpkKgxQtpOTzQCfTtwczZ+x8peHgG76hkdBwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtHOdMCPMZC5XmRWZASLRRsapPT4k+pZmvRxDt0Sdjq0CwLPc
	5+kppZflU4Rhb3xDmsanDJmEvSef39ZrT3SyZMazUTV9eTQh1CayVG0LjCDWGVeQM71mOyFqsqd
	6nuZQmceexsYzWY1nH6eO20lsyc/aeD0=
X-Gm-Gg: ASbGncvJMF34UkBQbRcLMfrUS7jw7jebIIuMsr8GZFEHa/OhlRDFPU7OLzgaW3lI4jc
	VOdWXDLDpfbQcdYTpwkkvN4jUCIP8IqK95fecMlt2gjExS2lX2MNzZJucLpca/7TL8fSj2hL4cd
	x9o9jpAEmEKM6q0r7BzdUy16GrwO5ch0UgULdrxfggae+dl6RNtq6D2R1Arj+tb3ZUxqTiAoheD
	aldHwIC5mGsE3H+QJHUPvhjyFM8BoxyaJz+0prTQvExfwyWTKcVA3yX3uxm4A==
X-Google-Smtp-Source: AGHT+IHgefdKWBp4DSP0OZeTnT1lsDnS/0NfPSuvV89rxgZtDvuvJFpp1w6Eu2z/MODOJmERGtCFa0kYRNc4jhuZ5l4=
X-Received: by 2002:a17:907:2d9e:b0:b6d:4f1d:8c9b with SMTP id
 a640c23a62f3a-b6d4f1d9e1amr718193466b.28.1761306335909; Fri, 24 Oct 2025
 04:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923175927.4380-1-raskar.shree97@gmail.com> <958a157f-e01d-499c-9f3e-d19e33b1de74@kernel.org>
In-Reply-To: <958a157f-e01d-499c-9f3e-d19e33b1de74@kernel.org>
From: Shrikant <raskar.shree97@gmail.com>
Date: Fri, 24 Oct 2025 17:15:24 +0530
X-Gm-Features: AS18NWDn1I4rwo93D59ybEO92j04rZTcEYiBcCfdMNzbbHmY8edIh09vy7uLs24
Message-ID: <CAHc1_P5+xz5JK=dHQGBOt_kfCyeAm6mcX2zbjgE0WtR5mnDqdg@mail.gmail.com>
Subject: Re: [PATCH] media: saa6588: Fix unsafe debug printk macro
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:05=E2=80=AFPM Hans Verkuil <hverkuil+cisco@kernel=
.org> wrote:
>
> On 23/09/2025 19:59, Shrikant Raskar wrote:
> > The existing dprintk macro used an unwrapped `if` statement, which can =
lead
> > to logic errors when used in if/else constructs. This patch wraps the m=
acro
> > in a do { } while (0) block to ensure safe usage.
> >
> > This change resolves the following checkpatch error:
> > ERROR: Macros starting with if should be enclosed by a do - while loop =
to
> > avoid possible if/else logic defects
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> > ---
> >  drivers/media/i2c/saa6588.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/saa6588.c b/drivers/media/i2c/saa6588.c
> > index fb09e4560d8a..71d34d229564 100644
> > --- a/drivers/media/i2c/saa6588.c
> > +++ b/drivers/media/i2c/saa6588.c
> > @@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
> >
> >  #define UNSET       (-1U)
> >  #define PREFIX      "saa6588: "
> > -#define dprintk     if (debug) printk
> > +#define dprintk(fmt, args...)  do { if (debug) printk(fmt, ##args); } =
while (0)
> >
> >  struct saa6588 {
> >       struct v4l2_subdev sd;
>
> I think we can do better than this.
>
> Looking at how dprintk is used in this driver, I see that in almost all c=
ases
> it is preceded by a 'if (debug > X)' condition. Except for one occurrence=
 in
> saa6588_configure().
>
> So I would propose to just drop dprintk, and instead change dprintk to
> pr_info and pr_cont. And add a 'if (debug)' in saa6588_configure().
>
> Actually, v4l2_info(&s->sd, ...) would be even better, then the PREFIX ca=
n
> be dropped as well.
Thank you so much for reviewing my patch and sharing your feedback.
I will drop the dprintk macro and will use the v4l2_info() helper as
you suggested. I will share the v2 patch shortly.

Regards,
Shrikant

