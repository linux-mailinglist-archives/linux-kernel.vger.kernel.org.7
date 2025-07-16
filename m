Return-Path: <linux-kernel+bounces-734005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB42B07BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C355F7AE209
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552372F5C37;
	Wed, 16 Jul 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjuzb/Hi"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB027510F;
	Wed, 16 Jul 2025 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686126; cv=none; b=Rnhvl40InOyOq1d24MuxLIkTzoribj7JmbCMRGuxxLoQ2OPL6pPGcAAJ9Sedn6lnAJ4wJurk6alJ+Srz5NdUF1+h/FVhsyx8mYD/ea5p/2Z6osD+XTLdVfQhQePOXcoFFk+Algcs1vucB9coag7UWpm/YngvxKSaq5Xrm/jpAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686126; c=relaxed/simple;
	bh=wDEGzHO2uTa+4A7XuSvXUU2T6+UneNTPHWos30Bm+Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kU/71ptwMLn7o2Zq9pULV6teRBhGxEEkokivRSLQMcw1qkYCpncUD52UcRJY1FOSw29HFlzf2WSlNAI+YiZKOeOT6A8oMvIDb2Y9PRdfYXZjruLwBrbNsnYWcOzBLfv15uFPPU9v7bg0gUT8Ola8IUDmjl5EjoK2I/HJB786POw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjuzb/Hi; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6159e23a6dbso10040eaf.3;
        Wed, 16 Jul 2025 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752686119; x=1753290919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDEGzHO2uTa+4A7XuSvXUU2T6+UneNTPHWos30Bm+Wg=;
        b=Bjuzb/HilF49KhbZbYB6CbwnJH8gaL2cxvj1r49AUp4CEztCIbv455IZ6YXE1WO8Pu
         KNVgbxXQ1gKTN291+Esxm6NgMpPBsZ3NWelBN1BE5kxCG0jWk+bP4o6i9RV67sxT5hv2
         lw35PXIji6bAb6eqJ1igLMaDxXdHynRTi5Hms9RnWQSxXYQkQCMHPG7CQ7W0rMSORRW7
         dNdjt57BCTQXl/KH8cV1d3tjhjcJJ+W5uDUP4Z9F4QtY25F52MjYRitITVhjSVPOOtJu
         hck9Vs7kahG+Y/MUX9iDE1rkQb2LHAJKGHSoxgqRkIKa1BpFUCKicp2D8fc7cUVBBG+h
         EesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686119; x=1753290919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDEGzHO2uTa+4A7XuSvXUU2T6+UneNTPHWos30Bm+Wg=;
        b=hn5bgK1cZvTqWSuWQ9D2Bh9afFOiaQnvKLByR9byKRsnJCeUv99bkz9fMFq6SxHD9w
         NvL2ihtgk4Gl/s2/nAaK3W8hZQbMfUbO1RtLLkHGRVCk2qui/ywsMcPtuqxyFpB9dHMi
         ITMN12H5HYHUmEXC2MIV34Y5XdyURMJlekE4GthBhDp2vdv9oRVXV41ZjxLzM29J904N
         mc+OoCTiK+fPY02BX3SY/jHdXRPfNYU73a7kpzc4I8RiJDV2PqI0yBYuuJM1oJWaSWLU
         UuUTZookUsVKXz7InxbOhwkjljuc9CwYCjrCB8Wrz58KIjxjQB8ilxaNKlbPd8Wu/+/4
         BqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWIJGU0ygyHJR5TtjoxSFWT1yRBjmCFX28UxkaupxWKupABlViFwf34EvPpQ9UTTpTNEhQuwsTzHbC@vger.kernel.org, AJvYcCVzomAbP+2E2BOv1aSPZZI7r7blD3y+J7UZYelhwEB0iZGlyQqZx98oq7EiMZgBCslOJckvyRk2Bj+zqMWj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf41h1tI5dE2P85jSX4VVHmcWvYGpkmCFPmB3+JajopmYpaLgl
	4gQI/1PqJ5+H4tCnCl68BXLpEKiXHKA1MkHsM5Cq/W9X9DWPGmbcqF6ThOYZmgKAfwJRmUZXaam
	Mz+GHbghAy2JkO9BgLE1tEMUjJmxo+JE=
X-Gm-Gg: ASbGncvcJF3VbWMVArx5v2r/P64oxfPc3pTliXv5cGxmuJDwNeW6+AkKwtzYsw/L4Zf
	30O91TfzTrrFwcdvEmF3ucsS4khXS5ASZeIUfYnwlj1fo22c3T1bWJM4blLsHo1uVXzm9eUFXP9
	m2qu+w0gkqkHFwPGZaQ+pNBOFeKonVDlKs7sOo/jpTg6IzF+uiLX1Hwkb9CDUM/6pp/Bh7Fs4Lx
	ZcGGwxb
X-Google-Smtp-Source: AGHT+IGFgEK58YLiG0kPmm1bbGImj+QtPQs5YuS58v4emZ5JMn6SYKkhdJYSdY/e5NVbE6/6pbuhfky8w9ZGB9AZe5c=
X-Received: by 2002:a05:6808:6a93:b0:40b:9948:f26c with SMTP id
 5614622812f47-41d034ee59dmr2834410b6e.12.1752686119206; Wed, 16 Jul 2025
 10:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com> <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
 <aG0i75h32dWg/L2G@gchen> <CABb+yY2BmqiQ18hU+7C234UnY8n-8PH5VEoS7nH5Xq5O1krGhQ@mail.gmail.com>
 <6b5f38f7-0557-483b-9252-cfade7a24cf5@app.fastmail.com> <CABb+yY26R_DHQUhpg-xUR_Z7EnjdR_4LPai0M-vfFTAOZy=vvQ@mail.gmail.com>
 <aHcOaas459jctIB2@gchen> <8365b672-49d4-4ed3-a3e0-53a11c20fe7c@app.fastmail.com>
In-Reply-To: <8365b672-49d4-4ed3-a3e0-53a11c20fe7c@app.fastmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 16 Jul 2025 12:15:07 -0500
X-Gm-Features: Ac12FXxFNiSlXABx3V2hOYiielrGWIT6yYg3uZuxe8SRVb--0Hrn2S4CLmdo2tU
Message-ID: <CABb+yY3KBdA0KeExfzx6otJxOiXUYQC27gaw_+s5OpQxdUmp0Q@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guomin Chen <guomin.chen@cixtech.com>, Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Peter Chen <peter.chen@cixtech.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com, 
	Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Kajetan Puchalski <kajetan.puchalski@arm.com>, Enric Balletbo <eballetb@redhat.com>, 
	Gary Yang <gary.yang@cixtech.com>, Lihua Liu <Lihua.Liu@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:20=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jul 16, 2025, at 04:28, Guomin chen wrote:
> > On Tue, Jul 15, 2025 at 05:11:01PM -0500, Jassi Brar wrote:
> >> On Mon, Jul 14, 2025 at 10:40=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:
> >> > My main worry here is that the types are all quite different: while
> >> > the doorbell and fast mailboxes are what a lot of other drivers have=
,
> >> > the FIFO mode does not seem to be a good fit for the mailbox subsyst=
em
> >> > but instead looks like a more generic firmware interface with variab=
le
> >> > length messages.
> >> >
> >> > For those, I think a higher-level driver with fixed data structures
> >> > passed through the hardware interface seems more appropriate.
> >> >
> >> Yes. But sometimes when the data structures of a protocol are not
> >> bigger than FIFO depth, the platform may choose to use the FIFO mode.
> >> I see it as platform dependent.
> >>
> >> > Are there any other mailbox drivers that just use the mailbox to
> >> > tunnel variable-length messages?
> >> >
> >> From a quick look, Armada 37xx and Hi6220 have fifo though they fill
> >> them up fully for each transfer.
> >>
> > Yes, both Armada 37xx and Hi6220 support FIFO functionality, and they
> > fill the FIFO with each transfer.
> >
> > Since the cix mailbox hardware supports messages with a maximum length
> > of 128 bytes, different clients transmit messages of varying lengths,
> > such as the cix DSP using 8 bytes, the cix sensorhub using 12 bytes, et=
c.
> >
> > Therefore, the cix mailbox driver has been modified to support variable=
-
> > length messages of up to 128 bytes. This allows for more compact and
> > flexible support of various clients.
>
> Thanks, this makes sense to me, and I have no other objections if
> this is an established way to use the subsystem. I wonder if there
> is a way to abstract it further though, since it would appear that
> the same thing should be possible on any device that has a FIFO
> to buffer more than a single fixed-length message.
>
> Jassi, are there any remaining issues on your side that need to
> be fixed before merging the initial driver? It would be nice if I
> could merge all nine patches through the soc tree for 6.17 if the
> current version, or a feature-reduced variant of the mailbox
> driver is ok.
>
I have pointed out some, and Guomin said there is a revision coming.
That should be good.

-j

