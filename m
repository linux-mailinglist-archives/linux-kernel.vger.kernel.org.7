Return-Path: <linux-kernel+bounces-851885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8DBD7876
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC43F3BE742
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955330DD06;
	Tue, 14 Oct 2025 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcJtUZCz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B830BBB2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422093; cv=none; b=ObLx1FLkSdXsK9nw+gFgo9LjBobxnR6uCeO74/ltV5snjl7nC9YEqGHEQ68y9n4CR+Ll9ncut2EDhLfQUnktsNYrdzbWLReH5HB7MGfTLbY88m2h0O2xOrdznMIa8SxN591PefaLHWfmeF2Zrbzk9xow2goM3kebzJUDMGj/5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422093; c=relaxed/simple;
	bh=lof0YmaEG+LixcrlFfIQ7Ogl4ET9WZzFbwtodBp/9N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs7g1EoMGu4A7Dcvxczs3mZm66gTBaa88aLxTfSWSvr9MrZcdmQQRlOrw3qJjSJypXs1iIEuvw9D9Xk2Wv7p8lidt/jRNaJNkh09zoyNvdfD1y14aBCmVFQqroZk5HCP92z6/nR+qdIOwNEOLXYZnDqzI5YA0DQ823mwkl7FpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcJtUZCz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4f323cf89bso867489366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760422089; x=1761026889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lof0YmaEG+LixcrlFfIQ7Ogl4ET9WZzFbwtodBp/9N0=;
        b=CcJtUZCzLKwef2qI/CAlnpT8LJuw+YBJESBvjS8IJHRmV1xox3O/l7nZz1ruPh9kx/
         dM15/ZMjyqyrAccFGAdWXGLdmJvTne6V7EZJAB1diKNklyN7ZtCHB1UDZk+pBUeAYKmQ
         YzGxl5yT7qPWV6g/C63rOC00e+4HvfnOzsqfR3eBr/H6SkLsygvjNnVkDGGlPa8VNPRO
         /5jfmiFYcagW0Dxtm/0aA7hPhif9s5XDQGc9YOfWHZRrWNxH5LKVKVPoSAGa2zWLkLpb
         cVGaSKOg3Qp5F7VGXPvZdjAGzhulpdX9+NkOgQJKls3QhKWcc16Fj2K5vtQzuEmc1sGJ
         lnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760422089; x=1761026889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lof0YmaEG+LixcrlFfIQ7Ogl4ET9WZzFbwtodBp/9N0=;
        b=relGlHN8P2iDGLo2rHhTLDD2RcJ+heg0LiHQj7mfts/sravIIyF/RmyRaZXUJNXQxq
         KSxzBww6oeCW25Df9Xy3svSgkvL9M6XrPzZoA62ALLRIaXhnwSo4nCijIJJLYyV1owAt
         +tSFhSBDLqvRpTVijW8ROwcD80avQB8cgz/gUbiCW7eDPLfYx77UrKCWIXt1mHLJNssp
         p2DYjLMQ6/dl43VOkjIqvLmEYkDZYSG3ClALQlXAPWLIV+Ln5vquKds+Mas6bIeOi3rD
         uhQEk110vobj4EsUzix6hjv8hJ9AZObT3+eEANVL+wXW5aQLVylybqhbWxCdByySSZSz
         kwTg==
X-Forwarded-Encrypted: i=1; AJvYcCV3k3HChyIuKR9sJoFJqEoE/sClx+qWvJ+R+z2wh990wRHJNO7UCcbkrpvKIgjhncUanLo8NwYP80CabRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/OUoJ7thxtWzZud8mvFdlMnSXjVPb+pB+ApAz8ILEq1m7iYu
	KX6weLVcMGJbyERJzX7vJYr5O9zAnBBrdiSkwMsi2WiObuFB+YWQTYlZqzxWuHTGbG3EWMy0CLF
	sEFlHQJBjR39b4n8UvtTQdIs9toCDbQtsWjdwEd4=
X-Gm-Gg: ASbGncv3AfiYV2DRz5S+dY1YIn6hCE/B6Zl6JofiFSfGHTDaprABT2dVcyUbxmC+80/
	ucbqdV4kHkDNg9PZ8c2Ihymm3r0wF/mKMYiWRny4qeHid79wD2JY1AIP+hkAO1sXzVaJCtICi9o
	ECTwIZWvLfFf2F9F2FuQoCehHGyyKhnc9kWGNFHjoXkiPOLpGmEYZ50IKpRhfDWdscLupasBqSA
	F/1K6yA8+hkmfXv6V24TLkHcPqic79E+a+z+EGli8D1yx6hflaa0GNuT7Tacg==
X-Google-Smtp-Source: AGHT+IGgdgiIGSvQYNIALqQ9pUoUutRB3h3EQJkldTUgUBPgd6YP8ch3nDyhEbNc4+8Rle8rXUNdTCWvtn+Bk1FuOVQ=
X-Received: by 2002:a17:907:d86:b0:b3f:d9e9:baab with SMTP id
 a640c23a62f3a-b50aa8a9056mr2856602866b.27.1760422088618; Mon, 13 Oct 2025
 23:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028141955.639633-1-arnd@kernel.org> <Zx-ndBo7wpYSHWPK@casper.infradead.org>
 <ef98d985-6153-416d-9d5e-9a8a8595461a@app.fastmail.com> <20241029043328.GB3213@mit.edu>
In-Reply-To: <20241029043328.GB3213@mit.edu>
From: John Stultz <jstultz@google.com>
Date: Mon, 13 Oct 2025 23:07:56 -0700
X-Gm-Features: AS18NWBRClzXhRlv_9uytilT7uxCBXfaLucmkCNNwGt2ZbA0vKObHGKWy_fvfp0
Message-ID: <CANDhNCpsoPcotnrjH6y0yEBf43652DRasSsEnAyEbrKN=tjEfQ@mail.gmail.com>
Subject: Re: ecryptfs is unmaintained and untested
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@kernel.org>, 
	Tyler Hicks <code@tyhicks.com>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:33=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
> On Mon, Oct 28, 2024 at 09:50:37PM +0000, Arnd Bergmann wrote:
> > On Mon, Oct 28, 2024, at 15:02, Matthew Wilcox wrote:
> > >
> > > This comment has been there since June 2021, so I think we can just
> > > delete ecryptfs now?
> >
> > I have no opinion on removing ecryptfs, but I don't how possibly
> > removing it is related to the patch I sent, as far as I can tell
> > it just means it relies on both CONFIG_BLOCK and CONFIG_BUFFER_HEAD
> > then.
> >
> > Is there any indication that the last users that had files on
> > ecryptfs are unable to update their kernels?
>
> Debian is still shipping ecryptfs-utils and is building and including
> the ecryptfs kernel module in their distro kernel.`
>
> So it seems likely that there are probably a non-zero (although
> probably relatively small) number of ecryptfs users out there.

Yeah. Sadly I'm one, as I needed something to migrate off of when
encfs was deprecated.

Is there another soon-to-be-deprecated filesystem to encrypt
directories I should move to? :)

I definitely think we need some loud warnings and Tylers' suggestion
for a read-only grace period would be helpful.

thanks
-john

