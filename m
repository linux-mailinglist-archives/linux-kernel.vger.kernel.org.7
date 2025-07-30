Return-Path: <linux-kernel+bounces-751078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60637B1650A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8839B177E09
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E62DCF74;
	Wed, 30 Jul 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TPpEQoRc"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE51C7013
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894223; cv=none; b=CjFkAQXYqItuU6VQTBPBSY8XDtGIabgKDlid4l2p16C2Zv8rXG5Fmx5PL/qZKS+v+gM71H6O+w/N2Dxu4FRW0VrgnVgvXNg+ZS6E81A3DNm6qKt/d/EoF+6EMSjvtbYrZOZFmoreqERBgD3VdrF17kV7mRtHgShCYoUW+n9oymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894223; c=relaxed/simple;
	bh=9dWTRXZaJPCq1JtfMK5xMNGaI4kHGmvqX/UGrLCtlVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyRFMOdMT6PzzmQlaNRkA90tg8Ax3b9gHyPjf5T+o7azTqsyZsl1m0hnXpDlYKIeKF6WZubMBwB3CpXsITJWFWts/8sOJzc8sXWBJKRJWmWtsMT8m2gJncJFm+0m1j/3D2xtkJq8MPXXJuNgIiDe3l2ylzyXVSpWu5Heehkbu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TPpEQoRc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae360b6249fso1284223366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753894219; x=1754499019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hhW6h1/+S/ULBh1mEzTRJl6Vdbe8H6LqlY995wIIFZ0=;
        b=TPpEQoRchnkA8O/f8oQaVK/Sj2uMlYf+dWUkIEg+LnKSIrMFf58TrCNKUSDQrDFezl
         cW6bsVvBPRH+Slo7xWZ3+CHK1XBy3EyHqmAdUjysmM9p1BfKh4Lq2tVim83PTp1mrr5i
         8j2gwXCP+XkQvpYTE6pnmSHGcYE5UsntZgDys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894219; x=1754499019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhW6h1/+S/ULBh1mEzTRJl6Vdbe8H6LqlY995wIIFZ0=;
        b=jCY0vUw/QRzqjrk6CmQD+tI1kz4oxu2x9M0XSTymnSpCRnve7+8TXM+6ygIvfxtgJh
         6jyCV4lzo6kd7KnfjNyOCInyHrYiM77/yu2+XdZ+KbN6Nhb2SxRGdyXznZHmnodnddAG
         eonibAkfjsqFkwWHZJmbm9SWxgJbRk7qF18cRKWSeWnvZdFP4a0y359wes3TdFhoH0eG
         SmN9vZmIeJypcEhxwVHzHUR8IzLLcbz21IcYAEeUEX4V6QhvnNzocxM6qDSi5Z6IOtzo
         Y9wvO7O4w8fc1Zfb/nNwCl64qP0fTQevbBLIFQM5XhOg4N69I/aNPtJPzzgv4ZGOTyTO
         LgGw==
X-Forwarded-Encrypted: i=1; AJvYcCV7lZ7jlWfCic2Gr+L1EaeeFBfUW1MXehA60njJFuMEpBpeX+jJMDLrj1QQ/gk4gxi9fXQfLsZhtNpHZ3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhhU3BaIztra1wgoWEHM7KKp5KkjDtdFDfL+KDBx0FxuBnuR3
	comAd4DK+uWwFs+nnIVvDNbSAlJW7Y4okLa57lStv23AWPlkFDHKk2QfOp64/x3iLpcH9RPywih
	f5Y5YmRs=
X-Gm-Gg: ASbGncs5P+AJ4W19p4vIlHwgiTdAILcFb7u/FlsWWHgliOVFLHhd2W/G9xfJiFtABLH
	l2FgSB2LIiS51wC7JGCwjj3Zpm9y7CVJfcSFmLB5eqiUM+fyQUVGBJu+LdDHx9bIpiePc/qAl+x
	n92fj6HhG8x/ahToEQsJA/QW3Ldawo6Ltx44Mgk7F0KccDiQENJANGPwicQDEAqA8XHlo9WGE6E
	A4kKRJgWHPByqlbveo45SaVUorjyyTdjAT5GBRA6jjLMg7p09j4I/HC97AQqaeo3Vw9bfoaX2eW
	g47CoYFYXB4NOw/NifTtU1WVZnEQMrB1M9brfoWmQrpD4bwCPS8A1a02PltcPLzaUy8eYORYYx9
	RT+L5FtfBiN19hib8V3PQMTqi1pOpLuObu7J97KQW/v5jeGVE73JSRp71RInrM7bCgKdmA5y8Ky
	L3TeVSOJE=
X-Google-Smtp-Source: AGHT+IHvfDTGwvnIUiiSMQdLl5ZB1lOLDBug8wLVH+lkwWVc6vrfh3zDzawHJbRcWrc7n+8El4arPg==
X-Received: by 2002:a17:907:971e:b0:ae0:16c5:d429 with SMTP id a640c23a62f3a-af8fda934a3mr492442966b.58.1753894219248;
        Wed, 30 Jul 2025 09:50:19 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af8f77c4f9asm192421466b.58.2025.07.30.09.50.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:50:18 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso1576191a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:50:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJnoGLDKAia+tZbHig43SBeZvWWgbOkBtUbpi5ifoRrhcA5NBoc2/UIln9bGk/I34MOv9kRxwcXv8FaJw=@vger.kernel.org
X-Received: by 2002:a05:6402:1d4e:b0:615:a3f9:7be2 with SMTP id
 4fb4d7f45d1cf-615a3f996c5mr655231a12.19.1753894218008; Wed, 30 Jul 2025
 09:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ecu4idvc.wl-tiwai@suse.de> <CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
 <CAHk-=whvoZuw-Cv2Bx2ip8Kq4j9jw0meLBg0xz8GbxzFmQK7QA@mail.gmail.com> <8734aeteef.wl-tiwai@suse.de>
In-Reply-To: <8734aeteef.wl-tiwai@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 09:50:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO0Rx2LcYT4f75Xs46orbJ4JxO2jbAFQnVKDYAjV5HeQ@mail.gmail.com>
X-Gm-Features: Ac12FXwEVff61vrMyjTIvAD0SR_lkrr7F6Z_dxguNlvXb6tej_Sauo_3j4s3E48
Message-ID: <CAHk-=wgO0Rx2LcYT4f75Xs46orbJ4JxO2jbAFQnVKDYAjV5HeQ@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 6.17-rc1
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linux Sound Mailing List <linux-sound@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 22:51, Takashi Iwai <tiwai@suse.de> wrote:
>
> It's a dilemma of the default kconfig enablement.  In general we want
> to keep the default disabled for leaf drivers.

You misunderstand.

The problem is that you threw away all the old config data in the name
of "reorganizing".

And no, the answer is *not* "make everything enabled by default".  If
somebody has a working configuration for their setup, new subdrivers
shouldn't be enabled by "make oldconfig", because clearly those new
drivers aren't relevant.

So no - not "default y".

If you change the names of config variables or re-organize things some
other way - you need to accept the old configuration name as the
default.

And even then it's an absolute *nightmare* for any bisection, because
losing configuration ends up being very easy when going back and forth
if the person testing doesn't realize.

And yes, dealing with this makes name changes and Kconfig
reorganization more complex. And if that makes people go "that's too
complicated", then DON'T DO IT THEN.

Breaking peoples existing setup is bad. This is not quite a
regression, but it's a huge inconvenience.

My laptop is back to working - it turns out I only needed the addition
of SND_HDA_CODEC_HDMI_INTEL in addition to figuring out which realtek
codec got lost in this shuffle.

And *that* case should have been handled by making the newly split up
HDMI config variables be "default y". Because my *old* setup worked
because I had SND_HDA_CODEC_HDMI enabled, and that enabled everything.

The new setup didn't work, because I still had SND_HDA_CODEC_HDMI
enabled, but the newly introduced sub-config variables weren't enabled
by "make oldconfig".

So that

  config SND_HDA_CODEC_HDMI_INTEL
         tristate "Intel HDMI/DisplayPort HD-audio codec support"
         select SND_HDA_CODEC_HDMI

is wrong, because it *should* have been done something like

        depends on SND_HDA_CODEC_HDMI
        default y
        select SND_HDA_CODEC_HDMI_COMMON

so that *if* people have SND_HDA_CODEC_HDMI from their old config, the
new "oh, that old name used to select everything, so now we obviously
need to make it 'default y' in the new world order".

And the "select SND_HDA_CODEC_HDMI" doesn't work in that setup, so
what you need to have is a different name for the "I want to select
the common support that the intel HDMI code needs".

End result: don't re-organize Kconfig stuff unless you are willing to
deal with this kind of detail. Because as it was done, it was BADLY
done.

               Linus

