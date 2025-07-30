Return-Path: <linux-kernel+bounces-751112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D7B1655F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1661AA39ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA62E03FA;
	Wed, 30 Jul 2025 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RxXA2Ocl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76412DFA26
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896110; cv=none; b=lj2V5SCGDU5BaetEHIzyhTn2pTHSYc0fSRFIl+05q2rxth5ROlTEbcz8U2KoX2LTIrAZxaHagRnMvpaTdDqDCr9S4Su7FPc2H75CVxHP3gY08SVA4CsGRr+ZgXhJE48iseNB1i7wNfyT4T8zynj787dDaFOF/xJLI6gjsSDfXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896110; c=relaxed/simple;
	bh=uZTWbNp5UQgpwMG41jKfjHK5L2cgnLut8dHcJchNR8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1OSUL3dzDLE+CoAItfyMkZU8XRTE1gSHslIPtmNcmru+ofS1KsJT+2jf0EReZkH/HPddL553pmksZwM7osGexYFy14qUHIqltbINkUAE3lUj4tcSgJwN/4nswS7TttpM9O5v6G+OWdBeG3dPcNt7UrjwVx3r46eEG8hRr128us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RxXA2Ocl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so3849683a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753896104; x=1754500904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XviGxGGSj+ExW/gtBrrBLfUa0g6+/sZ66LLFHVBs7nU=;
        b=RxXA2OcltaA6jYeXM+4ngfaY2QTS9dp8zNyACAzBu1wmzVjMR3Umeh85vOAtfhECpf
         6rr4R00Rul2IvHh7v5QTFOhQYydEjgYLn0Bx5BmB4c8jSZzWg1zIY4hLyxLY6u0/L3hP
         C/SRkFYlTW1FYmCX7kynEQieIfVPmkWNdq2eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896104; x=1754500904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XviGxGGSj+ExW/gtBrrBLfUa0g6+/sZ66LLFHVBs7nU=;
        b=Uki53AKuT6TqDTtIxdGNxYBjd000/KqKzu/I9Gqb83s4IlukJC51mHjMORFltqJw6t
         Yyy7dZ4sE/8rKBRO5bdzCRELB1/shIJI3IJvj0Srv/Wlw7cMlUmTrJUDb92S+dEZu8O6
         +bqaVMymoITOPRqK/CKGVbaJbbedZXosykKhCbtEo0DiTs7MlqZB1nPOvy7kBhha3/Hh
         ahYTBpx0WDZxgO7/YE5PsSuhTIfgSVipgQaF8SQjzzcbS9Vq/A2dMiCgaBcn2rBsRzIb
         X7r60k1lyIEBiq1V0APIjPcuZiAaWIHc2mMN8L3Z0bQuYfyKhP6OSaAACSj9nwTpjpSh
         VGhg==
X-Forwarded-Encrypted: i=1; AJvYcCVqVy970GNutxk/fUQrOGQbF6SFV9AnPKHF8MNi9rctyWASSwL6QgvEUl89PN4N0MEYkyHxIrixUaWutzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypn1ploWvFDNLnjKLZJsuLaI5/ZlDdnkhT/o7cgfbFBYthWdei
	nz7oUY8cRIAplPHQWxIKIeUqgE5OtsC81UrfzV7gmKXy+R46QJgLBmKCH41rR6EikOQ8f292oZQ
	lOMWAyZo=
X-Gm-Gg: ASbGncvrdBF6YHVA3r4xgzS+YcUWCiSQOKSznF+Asob0LxR0exB3B6rjwRnwehRbs2g
	DaXmwq9DJ2LTGQLI/GCUBF5/rwUfz/JODlIePBJ++eoGrzoZ9uHGrD5zmwtKxUfX5W2ysEtpwp1
	5AAY5SJLkJqMPePCt55RwSCfjyASE8pqPVeYw6vjpcuX+7v1TVqjU53CxEhv/4C5/3EN74SJuAi
	hfO22YyY0Z7fwLwgovLNYJJ3VGLKdT+W8/DTjfla5TUB/QSJajxGy/sHFJ49ug9/86DWrNUw+xM
	Zuk+FTTMUDgS32lApeRiwjA9+O5ysxq1IWi6w3gpNd8yrIwYzf74gdv6fRSti42CcgummD2+o7f
	W+puNar2ckpJHSxtHxfW+hFpe0pB42cxTucx9y11jwA47REuNmakalT/foxY/9rBmNdzHOoUw
X-Google-Smtp-Source: AGHT+IGliqCbMCLfsLOLnYRiTVuYpCV3X1XI8vuwmSncPu55rirONVSGYxX/L+qWZPwpX3EtNc2ACQ==
X-Received: by 2002:aa7:d5d5:0:b0:615:481c:7e03 with SMTP id 4fb4d7f45d1cf-615871e685cmr3647181a12.21.1753896104019;
        Wed, 30 Jul 2025 10:21:44 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6156925daf2sm2547191a12.35.2025.07.30.10.21.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 10:21:42 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso8824a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:21:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFdFfGZGjzlso6VXXa34ap5OkjdTUp6sFkDQSsvEpVN8ch1qSCkG2Go5+JIvGZh2VLq9T6t8flZbNvX0I=@vger.kernel.org
X-Received: by 2002:a05:6402:3546:b0:615:4b3:a62c with SMTP id
 4fb4d7f45d1cf-61586f2a6e9mr4722955a12.10.1753896101790; Wed, 30 Jul 2025
 10:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ecu4idvc.wl-tiwai@suse.de> <CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
 <CAHk-=whvoZuw-Cv2Bx2ip8Kq4j9jw0meLBg0xz8GbxzFmQK7QA@mail.gmail.com>
 <8734aeteef.wl-tiwai@suse.de> <CAHk-=wgO0Rx2LcYT4f75Xs46orbJ4JxO2jbAFQnVKDYAjV5HeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgO0Rx2LcYT4f75Xs46orbJ4JxO2jbAFQnVKDYAjV5HeQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 10:21:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwR=hNLA7SzdnM5BvaBAwm2cVeZRR7uEo+3625SaiOjg@mail.gmail.com>
X-Gm-Features: Ac12FXw8U-wQfGTvfoAcOoJvQvmgALq7PY--9KMDtp2xEI7r3qeUomSmM2CLTcQ
Message-ID: <CAHk-=wjwR=hNLA7SzdnM5BvaBAwm2cVeZRR7uEo+3625SaiOjg@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 6.17-rc1
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linux Sound Mailing List <linux-sound@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 09:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, the answer is *not* "make everything enabled by default".  If
> somebody has a working configuration for their setup, new subdrivers
> shouldn't be enabled by "make oldconfig", because clearly those new
> drivers aren't relevant.
>
> So no - not "default y".

Ahh. I looked closed - I should have done that earlier. It looks like
this was just a split, not a rename like I thought earlier.

But a plain 'default y' is still the wrong thing to do because you do
*not* want to enable this if people didn't have CODEC_HDMI enabled
originally. So it would have to be a

        depends on SND_HDA_CODEC_HDMI
        default y

But then you couldn't disable the generic code.

What *might* work is having both

        default SND_HDA_CODEC_HDMI
        select SND_HDA_CODEC_HDMI

which looks confusing, but should mean that if SND_HDA_CODEC_HDMI was
selected, the sub-option is on by default

It looks pretty iffy, honestly, but I _think_ i tworks.

I do think that the right model is to keep the old name for the old
functionality, and have a structure something like

  config SND_HDA_CODEC_HDMI
        tristate "Enable all HD-audio HDMI drivers"
        select SND_HDA_CODEC_HDMI_INTEL
        select SND_HDA_CODEC_HDMI_...

And then the new common hdmi code should have a mew and *different*
Kconfig option name that the sub-drivers select (so
"SND_HDA_CODEC_HDMI_COMMON" or whatever).

on't re-use an old name for some new fucntionality, unless you've
waited at least a full release or two for peoples kernel configs to
have been refreshed to the new setup.

With *that* kind of structure, you get

 - people who didn't use to have this enabled still don't have it
enabled by default, so "make oldconfig" does the right thing

 - people who did have  SND_HDA_CODEC_HDMI enabled see no difference:
they still get all versions

 - you can now decide to disable SND_HDA_CODEC_HDMI, and then enable
the sub-drivers individually

so that would seem to have full functionality, and avoids the
confusion of having the that combination of "select" and "default".

            Linus

