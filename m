Return-Path: <linux-kernel+bounces-880336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A7C25811
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9571897C51
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E42586C9;
	Fri, 31 Oct 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXIrCE/2"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5A2253B0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920121; cv=none; b=VpvI1lykGOtMeC5ETWHnpUaWyHIaZFByqNczBVS0FuyMHyQxqlPeFExmO2JLQCeljxne3hmvh5vYvvrEz5VjZ7hl+s8rthSveCs/SxatxPIdqN1oOvswVbS+4/V2951ZxovawywJZLBz3DvqSyWsGxBQVjxZd7NFOqfBzcuNFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920121; c=relaxed/simple;
	bh=RfbSfjINgNk+KIwhm8ycWoAdKTiJ0fFRB2w72BkSG9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Comdk9+pbl9ZDfoxLlUHBqumINwZ0kr1Rx5QIqZg6lTKD5wUw6bqINSIPfs1pWhrloqM7tbomDIBhMKSUso291uIASY1sdEkxta2XO0mKGrMD/OzwzKdCUfI5tEZEvx8AdXKIH1xOiQD658vvLZHLNgvGwQo+JaoAo5D0k7bqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXIrCE/2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so1191795a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920117; x=1762524917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYsX3dXvtTLPwG3M/sH5RR0fEhEx/a2A0niUgfDtB7c=;
        b=aXIrCE/2jm8S4JGyTj245k+VqvoKp7lF4GCKd/oX85kgPoFb3Ku/LcARWm5vo/iLp+
         mZxv6n7K+k0/rDNyND+nD3+QmLh9hAgfL38TTedz1ddtdew2JToO134yVShlKCZk6sLB
         SZjrTaE9gOA3ZW7LVzHKJMm0H5GHNXnkadwaZ3Bi2js3THwrMwvJ6dDz/UquXCSehYCs
         0I4sjSzsf6a4Nh09SwMkw42g1TZF/Y5e18NkgHAlwPPz67J+/KpqnZqI+zYrFL6Ks0f2
         ETkkzrJe+hvAHgksSFGd//NEgsdUR6PPHfcNkZOBX6D40sU4Qf0H0oIlh+ynrDmA1mXu
         A6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920117; x=1762524917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYsX3dXvtTLPwG3M/sH5RR0fEhEx/a2A0niUgfDtB7c=;
        b=ICUypZpwDEhtCM9GextMDOSivxx2KU562mHXb+q11asFesqjMEyORWgjbEr3N9LWJ5
         fZJddEioB89ODBcnEUaFJPQVAaINy7JtXArCeuuDYkHO4JVzlprVwlqMZU4sodgtfyMh
         xeeINYKbZdBeJOV7gLW9fKf7YtajMhYg51AXtJMfGZzjoJnFVFbAcxYqcztULQJ6gBe9
         jv5PwsCihiLVIKkVUsMiDRumPZHa59V6vhHACq02D7/ICNuvaTQMRJb7TY6IWoEvKCB7
         uA1ou0qF3agmQPWT7NCBQgYCeG3hEwlT/931ExSXbs6EGkzjMf5/WP7UcPItFWtJo8Q6
         T8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV1kPDnmB2cN6K/GnoKItuPIMzf6iCO3QxFkTVlVLj4TkHxf1zwxJP9K+P98omobckFZhL/zmbXapBSQQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2AeZuu7Nc1uj/juvqb3CoXmguDzwLZBDXAMozzQmLZGD2LG2q
	Peza3fRjwbd2eCC9Kr6/+IV0RIK0tbnpFXwWd25OMFZAnH1SFml3wKriVd81Ptp6s1seoYyLUHR
	eegH8HGM8CuMuZvt9+P/vib2OZUd5N1E=
X-Gm-Gg: ASbGncuXcOtESgIUIlJojWz8RQEXPwjPqOleA3GZGiGnoXt5ZWmUOCUSmVcspdvAPQ6
	QMqYgX9JEgVOgpx7Ob9ouJA4sBNKpuBtNfykyJKSfvQON9E0YRqn3Oz+WJui0X2fX1rea2Yf4IN
	+QQ5hUBU/Zv4+nmwYz1wIssDLPdWWRrl9Uzj9V/TCWi/zcxJbWiLp36HJeBZn8UTASxO0xnvIjD
	oKeBZZ63g050im6N19ocP9drLFLV5WZMsZ1MbMX2ke2cuX7/fh71SJz0z1n
X-Google-Smtp-Source: AGHT+IHCoMYa3G6T0j0Lwg3aXNYQKN1oVik+PtSFNAWANM/X1vB53TmrMd1fdfWNGyBVzHkp5GN4Wj+zYmrBBjKjOxY=
X-Received: by 2002:a05:6402:4314:b0:63b:dc7d:7308 with SMTP id
 4fb4d7f45d1cf-64076f66b7emr3214619a12.5.1761920116612; Fri, 31 Oct 2025
 07:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2daa603f-13fe-c803-17fc-4fdd8e5723ba@gmail.com> <87ldkr36cv.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ldkr36cv.wl-kuninori.morimoto.gx@renesas.com>
From: harikrishna <hariconscious@gmail.com>
Date: Fri, 31 Oct 2025 19:45:04 +0530
X-Gm-Features: AWmQ_bnT3bfpqUrnEdxX-SgDqm70z_JJkkRze91XfXQ4PqGozK-YlIywu8eTu9I
Message-ID: <CABBwEEh7gjMPi8dybAcd_4rTT0ZJU=zi99ahSgdzCAjMtL6zdg@mail.gmail.com>
Subject: Re: [RFC] ASoC: soc-core: proposal to remove num_auto_selectable_formats
 from snd_soc_dai_ops
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	shuah@kernel.org, david.hunter.linux@gmail.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:28=E2=80=AFPM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi HariKrishna
>
> Thank you for suggestion
>
> > I=CA=BCd like to propose a small cleanup and simplification in the
> > snd_soc_dai_ops structure by removing the
> > "num_auto_selectable_formats" parameter.
>
> Do you mean like this ?
>
>         struct snd_soc_dai_ops {
>                 ...
>                 const u64 *auto_selectable_formats;
>         -       int num_auto_selectable_formats;
>                 ...
>         };
>
> > Currently,snd_soc_dai_ops includes the "num_auto_selectable_formats"
> > field to indicate the number of entries in the "auto_selectable_formats=
"
> > array.However, this count can be derived programmatically using the
> > ARRAY_SIZE() macro wherever needed.
>
> If my understanding was correct, unfortunately we can't do it.
>
> We can use ARRAY_SIZE() in each driver, because we can access to raw arra=
y.
> But can't use it on ASoC framework, becase auto_selectable_formats is jus=
t
> a pointer. see how ARRAY_SIZE() is defined.
>
>         --- driver ---
>         my_formats[] =3D {
>                 [0] =3D SND_SOC_POSSIBLE_DAIFMT_xxx | SND_SOC_POSSIBLE_DA=
IFMT_xxx ...,
>                 [1] =3D SND_SOC_POSSIBLE_DAIFMT_xxx | SND_SOC_POSSIBLE_DA=
IFMT_xxx ...,
>         };
>
>         // We can use ARRAY_SIZE() in driver, because we know raw array.
>         my_dai_ops =3D {
>                 ...
>                 .auto_selectable_formats        =3D my_formats,
> =3D>              .num_auto_selectable_formats    =3D ARRAY_SIZE(my_forma=
ts),
>         };
>
>         --- soc-xxx.c ---
>         // it will be error, because we don't know its size
> =3D>      int num =3D ARRAY_SIZE(ops->auto_selectable_formats);
>
> Or do you mean create new macro, like this ?
>
>         #define ASOC_SELECT_FORMATS(array)\
>                 .auto_selectable_formats        =3D array,
>                 .num_auto_selectable_formats    =3D ARRAY_SIZE(array)
>
>         my_ops =3D {
>                 ...
>         -       .auto_selectable_formats        =3D my_formats,
>         -       .num_auto_selectable_formats    =3D ARRAY_SIZE(my_formats=
),
>         +       ASOC_SELECT_FORMATS(my_formats),
>         };
>
> Or am I misunderstanding your suggestion ?
>
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

Hi Kuninori Morimoto,

Yes, you are right.
I have got it now.
We can use it in codec driver not in framework.
Thought of changing the type of "U64 *auto_selectable_formats" to
"U64 (*auto_selectable_formats)[]" and removing the
"num_auto_selectable_formats".
But cannot be used to get count. Apologies for this.

Thanks for the guidance.

Regards,
HariKrishna.

