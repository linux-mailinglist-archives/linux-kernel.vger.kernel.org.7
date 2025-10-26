Return-Path: <linux-kernel+bounces-870325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44175C0A772
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB9E3AF209
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668A62DA746;
	Sun, 26 Oct 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha8fWpw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC81D5CFE
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482432; cv=none; b=DsbWXqbo7YA+GyS/XD6nnhP54kSJAJW3GRH4NTL7ap2lbWdhu9Hi/QlXfBrbfxKJdjAs7C8n1cm2mrxpRtJDChY88OZbVLI7h5W8s7m9PkY7MFnh+sSRzjGGZJ2Kw6fnwL917xgNZHcDAAqdeA1YyfQ1DzAUNab0fW+h8S52T3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482432; c=relaxed/simple;
	bh=4DSoS12TDpnm2vk2b5aorRyKVAcL3faWMo3FnWnt1uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKiHNTDeyPI/nEW3il4YnKPbosBcu5RWgB+qazpsiggmwCu1+r90BzkEl3a3st8sa8tMgUicaaEmo/Z2H/mM2+K/u/JRB6wGaNQuu2JLDBoN8pXY4iQs3gGHgs/DR8zYOkJxkuuWSjd6IhVwBsaSz0b4JCOoZzfM5SjK6TiJ7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha8fWpw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCFCC4CEF1
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761482431;
	bh=4DSoS12TDpnm2vk2b5aorRyKVAcL3faWMo3FnWnt1uE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ha8fWpw3OY7p4sOnwwqhQGflPqZyWIALvaXdYIQjGXXEwRvK1qPsMnUntPe8vfnFJ
	 9/mQnGAWuBd4kqf0531sJaQwCUvHIMnkvEPHz+d4bizqRkGFReFgCGME7oxXvHb8aO
	 H6F2bjtcrhYq85qg6MlGqwPJ3tTBMwfnlM5duUKpp1PoEfjtdiQqeYLvgJ3LZsByCK
	 dqL7Y1Ve5GdRykMFmpph4aV9CCRbu2OCJyqpjQ68oaVRM3EPiobsO/MGOo6RjeIpk7
	 +gebzX6olqNm5ZO17UemJ5l7+vQZp6wu0miU7TcAEmsYtC0ckcVppJd6EnIkeb77d9
	 4W8VUKVp72E2g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-654ee101473so330347eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:40:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSorITBawqS1a3oMKU64lKBc2cOnIp908aCUm6zha0f/cjUvPRjpoRRauymAEidRQYEiieZNp1dlDrFLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W5U/j+jO75/S1IhdTjcvlEW1UFzfVbCR0qricLSlBk1l+Gd3
	pQmt6eT0p6K6N/AJ6jd4e471oAwNKz9lURSDzWY19uA9lIX4A9i4IAjnh5o6Itce4/AVDX4H2Ay
	pIxrVPlCY3yMisVP3ewJb6DbPV1G37pI=
X-Google-Smtp-Source: AGHT+IHVugOpFjVvQGNX+BIYlnbRGXKr6MVsGBBLxMo+9bFHr+iMePmjK5dgvb44iUb+eD5Q3ikwYQyLrnsM30KMuuQ=
X-Received: by 2002:a05:6808:a552:10b0:44d:afca:523d with SMTP id
 5614622812f47-44dafca5a3bmr713263b6e.32.1761482430567; Sun, 26 Oct 2025
 05:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-6-lihuisong@huawei.com> <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
 <92b1b431-9855-43fb-8bb3-801649064438@huawei.com> <CAJZ5v0g0PgicTEAb3gAeF2D3ZqONNt+6odt2SfGE7XtY3zoPyg@mail.gmail.com>
 <ab814879-37d6-49dc-8a38-6b94cabf9327@huawei.com>
In-Reply-To: <ab814879-37d6-49dc-8a38-6b94cabf9327@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 26 Oct 2025 13:40:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hHO_vuQ71sQ2=vmjEMNr3jYh6Wx_nk55gQVdGgWFDHKQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmAx-N8R1augtcP0FsCKemJJz3DVOQkqe5szVIq3dv99YYk9uxXzBeSZis
Message-ID: <CAJZ5v0hHO_vuQ71sQ2=vmjEMNr3jYh6Wx_nk55gQVdGgWFDHKQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of
 processor FFH LPI state
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:40=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2025/10/23 18:35, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Thu, Oct 23, 2025 at 12:17=E2=80=AFPM lihuisong (C) <lihuisong@huawe=
i.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/22 3:42, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei=
.com> wrote:
> >>>> Both ARM64 and RISCV architecture would validate Entry Method of LPI
> >>>> state and SBI HSM or PSCI cpu suspend. Driver should return failure
> >>>> if FFH of LPI state are not ok.
> >>> First of all, I cannot parse this changelog, so I don't know the
> >>> motivation for the change.
> >> Sorry for your confusion.
> >>> Second, if _LPI is ever used on x86, the
> >>> acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info() wil=
l
> >>> get in the way.
> >> AFAICS, it's also ok if X86 platform use LPI.
> > No, because it returns an error by default as it stands today.
> >
> >>> Why does the evaluation in acpi_processor_setup_cpuidle_dev() not wor=
k?
> >> The acpi_processor_ffh_lpi_probe does verify the validity of LPI for A=
RM
> >> and RISCV.
> >> But the caller of the acpi_processor_setup_cpuidle_dev()don't verify t=
he
> >> return value.
> >> In addition, from the name of acpi_processor_setup_cpuidle_dev(), its
> >> main purpose is to setup cpudile device rather than to verify LPI.
> > That's fair enough.
> >
> > Also, the list of idle states belongs to the cpuidle driver, not to a
> > cpuidle device.
> >
> >> So I move it to a more prominent position and redefine the
> >> acpi_processor_setup_cpuidle_dev to void in patch 9/9.
> >>>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Pow=
er Idle(LPI) states")
> >>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >>>> ---
> >>>>    drivers/acpi/processor_idle.c | 10 ++++++++--
> >>>>    1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
> >>>> index 5684925338b3..b0d6b51ee363 100644
> >>>> --- a/drivers/acpi/processor_idle.c
> >>>> +++ b/drivers/acpi/processor_idle.c
> >>>> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(st=
ruct acpi_processor *pr,
> >>>>
> >>>>           dev->cpu =3D pr->id;
> >>>>           if (pr->flags.has_lpi)
> >>>> -               return acpi_processor_ffh_lpi_probe(pr->id);
> >>>> +               return 0;
> >>>>
> >>>>           return acpi_processor_setup_cpuidle_cx(pr, dev);
> >>>>    }
> >>>> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(stru=
ct acpi_processor *pr)
> >>>>
> >>>>           ret =3D acpi_processor_get_lpi_info(pr);
> >>>>           if (ret)
> > So I think it would be better to check it here, that is
> >
> > if (!ret) {
> >         ret =3D acpi_processor_ffh_lpi_probe(pr->id));
> >         if (!ret)
> >                 return 0;
> >
> >         pr_info("CPU%d: FFH LPI state is invalid\n", pr->id);
> >         pr->flags.has_lpi =3D 0;
> > }
> >
> > return acpi_processor_get_cstate_info(pr);
> >
> > And the default acpi_processor_ffh_lpi_probe() needs to be changed to r=
eturn 0.
> Sorry, I don't understand why pr->flags.has_lpi is true if
> acpi_processor_ffh_lpi_probe() return failure.

It is set by acpi_processor_get_lpi_info() on success and
acpi_processor_ffh_lpi_probe() does not update it.

> In addition, X86 platform doesn't define acpi_processor_ffh_lpi_probe().
> this function will return EOPNOTSUPP.

Which is exactly why it is a problem.  x86 has no reason to implement
it because FFH always works there.

> >
> >>>> -               ret =3D acpi_processor_get_cstate_info(pr);
> >>>> +               return acpi_processor_get_cstate_info(pr);
> >>>> +
> >>>> +       if (pr->flags.has_lpi) {
> >>>> +               ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> >>>> +               if (ret)
> >>>> +                       pr_err("Processor FFH LPI state is invalid.\=
n");
> >>>> +       }
> >>>>
> >>>>           return ret;
> >>>>    }
> >>>> --

