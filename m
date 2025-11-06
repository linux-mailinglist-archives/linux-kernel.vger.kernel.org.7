Return-Path: <linux-kernel+bounces-889552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F32C3DE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8F94E8C42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7D34CFDF;
	Thu,  6 Nov 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkHxEYl8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3010343D78
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473010; cv=none; b=jK8w0Twccnvxm3CmsFifuMKqfGLGM1oZ5hmYEdrEgy1yn7wvSBOgjKKng3xtcIQ0mQ5V6WLjCeFXYfJN4eQnyrizjs9Y9j8PiH1lS2JVrG51QZBg7D1We/1kl0xjLApWDYtRsGJcNfuIJKAhKf7jD4adSQcC0VYTjAtOJJPtjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473010; c=relaxed/simple;
	bh=eh1zthv6unSjP7IlQn/g9IZOV/2gqzq5toVOXHr8gYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow+RosdHNIwGSo2mT/5KH2m3zbkjHoBnPLWylO2YPe/o89iXrCdlnBkFBuuRaKlAzrrrV7hHNnQhTXTC8f7bbk8kpZPuJMQWQUq2AufN3blCKZTvUqIBh69cAxk5ANvi7ZFnd0SMIsJQQfE6NUGJvDT5iIp+4k+hmYyG6EU+GPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkHxEYl8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso325249a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762473007; x=1763077807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwtE5bl1Bmk4nXkRg8wSfz+vYSCTX9OIyE6Hqv70rK4=;
        b=BkHxEYl80k+KdHnjto/kwwGQY4dQPcLbA47HZ/F0Ycop1MhCkqqz3H0roFjqsMr4t7
         obrfcRTcgwWzbhSuinFSL70mAo1OzLY9gD9hA3NopVXQZ4l/1X2xDaRlWC1UyXQ8HG6q
         jLwAd8qxvVGBXeR3/XyA4xKlbVQSLasqg1dYwKG5TkEE9z4Kv3PceX1JNHkYZPSPF/b5
         30GPosZI9Xivti4cX8zKtq4l+Yn7/vRKDB+As282yoTHZ1lbVA9jhkUmxjSatgnvJKLQ
         5gvCc+tpc2qZAGZ1dGKNaHb87trCQBvE3nnccysasXlMQMzQwsi82IgPHd9IVaeaeFhm
         ZVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762473007; x=1763077807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HwtE5bl1Bmk4nXkRg8wSfz+vYSCTX9OIyE6Hqv70rK4=;
        b=H41SG45G+KTEYTk0oAYr9zZkzTjKxHan6MkS843gMUB1KFtXPhx/CBs9zPdFNrm4zj
         /10ZIWpqwvRqRBroK2rPh772cb7qcniqfmNVOCvcLAR2sCJy5CrGqz3lqQB7IO2OOYTL
         nJ387FrCtcDeYi4aYcJG46NwfYG23MfPRaVHtoxTz02pxBXiR4wlDSgy2bRS0yGBIeIg
         6h/2IKK4tnFYzQaqz5Sy3zHqTvs6stp/nuJQ4pVSrq9K6SSlzWkASfXzQLXwP9VudbnF
         AdN/ZUW0xKxylQUa4dHTPybTtFC/qBh8g5dtIZty9t2edjqaHdyQBFfIAjoRxz57Olpe
         c3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX87qycI4JGFdpeaC9uDmJuZDu9K64PuF88SX4Cfv1yDeXmDsSaXYMwGOSh1a0DN5XDtPz2R4AO9QTNr/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZTI37Av9VKu9gygAr+kF0wNcX7NRj1SYf2DnL2UUBOmUXGkc
	HO6TF4DskRgBlZQQXeQc3bb8VU1dYhazVBB63fbRRQZwlmGbKP2cSOKI+jrsulFx75rc3s5h2Y6
	m7UL4nx5YGOBNbshzvURc4vxcIS65zvhEdFj9BCg=
X-Gm-Gg: ASbGnct9LMBs54Dk3NbhbtYS2ANojNvAYsVlTpp8lyPC1kP7nNdna9pCOvA43eq1sWh
	DOIuZS+QzqBYzeh2B2E/rcyiMxApmSaMNHydwgOroNT0FmfT7oWtpNhxXl7Y4tahl/0QA74n2iB
	G9HYcqEx15+fcMWWYGbLIaqzdckaxJwajZtbQBQM5J5t61vI+tvEbTlNe/9FUahqpXSZCvhg+Wo
	cuQbv9vl0W6Y6gF0EAZjQsfmnDfNGCzTDKuznavFHoXZ6T7xYlnH84Io0YAqwD0D9Me
X-Google-Smtp-Source: AGHT+IH9HqOyiD7UJnMvTInH2MmpK2CQ5kPmEOkMBi/k8MfOZTcnKKXlnRL5aSY3yGTQu9tiyes0hAnndXUSZGrFDvE=
X-Received: by 2002:a17:907:6d0b:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b72c0d02de6mr125701366b.45.1762473006957; Thu, 06 Nov 2025
 15:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1043551.1761844832@turing-police> <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police> <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
 <105884.1762399131@turing-police> <A9C2FED1-EFBF-48AD-A3C8-41DDD16F8AA1@kernel.org>
In-Reply-To: <A9C2FED1-EFBF-48AD-A3C8-41DDD16F8AA1@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Thu, 6 Nov 2025 15:49:50 -0800
X-Gm-Features: AWmQ_blrX7AQyucKNOFi707U4b2pBK67Zkgg47ONWQ-TMh6t8cCk3T6JIKN_QX0
Message-ID: <CAGG=3QUF4OZwjjMTz8jidDWNiHrOhhZhKNRwM54gz8YLHeRGBw@mail.gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, 
	Amit Dhingra <mechanicalamit@gmail.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	David Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:13=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On November 5, 2025 7:18:51 PM PST, "Valdis Kl=C4=93tnieks" <valdis.kletn=
ieks@vt.edu> wrote:
> >On Wed, 05 Nov 2025 18:34:05 -0800, Amit Dhingra said:
> >
> >> I have the same problem.
> >>  ...
> >
> >> Setting RANDSTRUCT_NONE=3Dy seems to stop the error.
> >>
> >> [1] https://lore.kernel.org/all/2025062439-tamer-diner-68e9@gregkh/
> >
> >Wow.  I wouldn't have guessed that RANDSTRUCT would be the cause...
> >However, RANDSTRUCT_NONE=3Dy does make dce_stream_encoder.c compile clea=
nly.
> >
> ><insert Twilight Zone theme music here>
> >
> >Adding Kees Cook and the linux-hardening list to the cc:, hope somebody =
has an
> >idea what's going on.
>
> I'm surprised the stable team didn't find the associated fix in your link=
ed thread. It had the right Fixes tag:
> https://lore.kernel.org/all/20250502224156.work.617-kees@kernel.org/
>
FYI, their Fixes tag points to something that doesn't exist. I found
it at SHA1 e136a4062174a9a8d1c1447ca040ea81accfa6a8 though.

> Regardless, just remove the "0" from the dce110_an_str_enc_funcs initiali=
zer; that's an older code pattern that isn't needed any more.
>
> Randstruct requires designated initializers, though I thought the macro t=
urned that on universally, so the fact that the error is only present with =
randstruct seems like a separate bug.
>
> -Kees
>
> --
> Kees Cook
>

