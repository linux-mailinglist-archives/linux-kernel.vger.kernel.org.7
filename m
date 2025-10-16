Return-Path: <linux-kernel+bounces-856881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7338BE5524
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4732B189B39A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D481CEAD6;
	Thu, 16 Oct 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ7Jt8PR"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0261B0437
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645310; cv=none; b=bkQWfV7/1vLYZA8Y45obxXe2qzaDeb6r6agXZY4wH3U4yZSrSFLvUqEr+nIXp8eVU+GtgCf0j3fBrVxftkB3pE0Qit9PjE5OHJS4kFK+vDXIijkvQBAYRVHxe5eqxkqXnq/PKJuZOv7Zlx9npBZctkDAAOjbwnZUGm/nkpvDzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645310; c=relaxed/simple;
	bh=5LV1LhbZXSqdN8/Ic6BuDFnwHiv8u0GIP1b8uHhLq8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVMJnOUuJpKhhUYN23kQiE9EsgDmQam0XyxIMFVfOAjTylV7hUlA9yckswPQubu0qwYjA23MVfExHJdNJKcuI2/NklvGwx9Vk9VAilDPZpOEpm+tUuQVoVHB7/MjvFrbgzIofQvUlUQrM/mbJst/i6dNwaG/wMjw3ImQo6vA58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ7Jt8PR; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e14c509d6so656655d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760645308; x=1761250108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwSJQlIKUBZxKguIzgka47vhsGWXbpweHW396bjpenE=;
        b=cQ7Jt8PRLP2bdHUqwCjJx2w5q1Bf+uBKQ6jGV7vfm+JVSzm0Og7LGFvKTfl5A7AqY3
         jcbaB9wc+kUJhEfh+5d5JnzJNth0AUTvc3zZmuyTlr0Y9nLmWjKVw6JLr6d6PVLcvy2q
         cWv4HHCSLSW38gyuOn56+Z3Mf3qEm+K79Pp9ZTXJzN8+LUfHrKM4WfhTYICW4+rM6605
         +3IKFyENvSOOv2Cci8o6Nbc1Hn7NRy8bOGkmOI2g84uiW6CVTQhYwLkoRZFyw4iASCGl
         FbYRrJw+YkBPRrl7IcLhbG9obSGor+lD6rChfSX2j89b3IXXSE0sba4o5y4vXrRDGFLz
         8RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645308; x=1761250108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwSJQlIKUBZxKguIzgka47vhsGWXbpweHW396bjpenE=;
        b=tRGPw/vI0hgZbi8j82PLT5bau//7wkVHfJUSVhn546AlW6pMKPG6rKJzdM9Cx7egbq
         QVbta0gY/t+9Y2I4JD3lp6h9GMOLUHMvrKvSHhnF8Sm/2x/aiPKDzd6m0NUTQjcGm06q
         TY3vQ3py8rsm1POs5p41hAb4y0X03Lw7sekahk2yOuLUl11aCblEHsY0YPrTUv5p6AuR
         wQJ1uh1Fx99TyJvbU4VreYtzNIxhIQOTSVYUu++ipJDZ2uDi+MA2Ht7mjonhRz/7nlf0
         XSRm4MqzxhkmtaYNXcbhA1lu9o3bSIpqH0T18ZGjMHpRCTmDgid4JmH8/EFY6aKQX8R8
         jgSg==
X-Forwarded-Encrypted: i=1; AJvYcCW06BlMprq4ul/CzxuXuEv/K7ny/Tj8KCrU4JNoHK/qunBn06Gey5lbP9vgLH5ksT0rXfWRlV0XfbWQoHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRpKD3mOLoc0E4L8TH1ZUihdXfUSmb1qkYrJw+elft32DJJKt
	dzdMH72t8wFC78VukxKq7HqH+b33IjLHSnXOSs5Dn0FI5aUrw3WYVzL0OaarVbETu+r0/fJit9l
	AZiqgHpvdlJG5RkqXoYffzmnLp7ducDw=
X-Gm-Gg: ASbGncuHBbTzdvPRjGRDG3Cc1HW/p28aBX9yB59yCEv8KWqYMY/pWICCt6od7VyHvGG
	AVcXRF8bNj73xFclFyl+CVHHwMXvKuiU6B4DQo9UiW0ms7GeEiA/Yho1vEyXDO/+GSwr7GhrSV1
	6/Kud70tsoawXfP1NGZtCZKZ50USv+RurV194bOvwxJRM/9tuR2xCis2juWmp0tgrcKXRs2F3Ms
	XbgeAMeKKO0KYPgLMBLhP/zSrpEajiWSOss0Rguc9Al25GsEYaY2MErUFA=
X-Google-Smtp-Source: AGHT+IHvMgZk6If8o2qH54dkg2cytF3aHS8b+WyjiGydzi+xYAEbco+6c2Bb5pN+U9QhO3xEPUlTr6z3Csxk3GbljFI=
X-Received: by 2002:a05:690e:11cb:b0:63e:c66:42c2 with SMTP id
 956f58d0204a3-63e160d895emr1244040d50.4.1760645307556; Thu, 16 Oct 2025
 13:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014044135.177210-1-ghatto404@gmail.com> <20251014044135.177210-4-ghatto404@gmail.com>
 <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com> <CAMQHOhfjsi1L+3j3TrcjEjPp3xkn94KOdsrVZvJCyUDFBBSeqg@mail.gmail.com>
 <d06a254f-bf54-4bdf-bd09-3ee5e5b31bad@oss.qualcomm.com> <CAMQHOhe=WYhtsjHMcRnJOi8UhnNNBfveTWRGSZ_bg24gFysAEw@mail.gmail.com>
 <8bd5486f-38a9-4104-8d09-234f642b45fe@oss.qualcomm.com>
In-Reply-To: <8bd5486f-38a9-4104-8d09-234f642b45fe@oss.qualcomm.com>
From: Ghatto <ghatto404@gmail.com>
Date: Thu, 16 Oct 2025 16:08:15 -0400
X-Gm-Features: AS18NWCRa6pRdMMpu0X_9Af5lgC9aF7fE9-UeKFo7BJK8yxGs2I6QnALReJ2QHs
Message-ID: <CAMQHOheTkKC8NcRrPxKZdB_h0SJGNJVMd4NUD7TE4becPouWyQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:06=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
>
>
> On 10/14/25 9:04 PM, Ghatto wrote:
> > On Tue, Oct 14, 2025 at 11:18=E2=80=AFAM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> >>
> >> On 10/14/25 5:10 PM, Ghatto wrote:
> >>> On Tue, Oct 14, 2025 at 7:01=E2=80=AFAM Konrad Dybcio
> >>> <konrad.dybcio@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/14/25 6:41 AM, Eric Gon=C3=A7alves wrote:
> >>>>> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
> >>>>> depends on "Input: add support for the STM FTS2BA61Y touchscreen".
> >>>>
> >>>> The second sentence doesn't really make sense to be included in
> >>>> the git log
> >>> I'll keep it to the cover letter then
> >>>>
> >>>>> The device has an issue where SPI 8 (the bus which the touchscreen =
is
> >>>>> connected to) is not working properly right now, so
> >>>>> spi-gpio is used instead.
> >>>>
> >>>> Some Samsung devices used to use spi/i2c-gpio intentionally, also
> >>>> on downstream. I'm assuming this isn't the case for r0q.
> >>> It isn't, the device uses fts2ba61y on the spi8 bus - I hosted the
> >>> DT at https://github.com/ghatt-o/ss_experiments/blob/main/r0q.dts if =
you
> >>> want to take a look.
> >>>>
> >>>> Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
> >>> The driver probes, but it fails to recognize the touchscreen device
> >>
> >> Could you post a complete dmesg and the precise DT diff you used?
> > https://pastebin.com/QkYa8nMp (android dmesg) mainline dmesg doesn't ha=
ve
>
> The link has expired =F0=9F=99=81
https://pastebin.com/s4abJS9M shouldn't expire now!
>
> > any relevant information other than spi/i2c probing, however, I've noti=
ced
> > both on deviceinfohw.ru and the dmesg that for some reason the touchscr=
een
> > is on spi0.0 (even though DT says 8) and I'm not sure if that means it'=
s on SPI
> > but on a bugged out bus or if it's really just spi on bus 0
>
> It means that it's on the SPI bus that probed first (index 0)
>
> [...]
>
> > +&spi8 {
> > +       spi-max-frequency =3D <5000000>;
> > +
> > +       touchscreen@0 {
> > +               compatible =3D "st,fts2ba61y";
> > +               reg =3D <0>;
> > +
> > +               vdd-supply =3D <&vreg_l8c_1p8>;
> > +               avdd-supply =3D <&vreg_l11c_3p0>;
> > +
> > +               interrupt-parent =3D <&tlmm>;
> > +               interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +               pinctrl-names =3D "default", "sleep";
> > +               pinctrl-0 =3D <&tsp_int_active>;
> > +               pinctrl-1 =3D <&tsp_int_sleep>;
> > +
> > +               status =3D "okay";
> > +       };
> > +
> > +
> > +       status =3D "okay";
> > +};
>
> this won't compile ^
>
> Konrad
>

