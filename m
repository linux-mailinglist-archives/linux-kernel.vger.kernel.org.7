Return-Path: <linux-kernel+bounces-793141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB4EB3CF2D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925071B24E88
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9992DF3CF;
	Sat, 30 Aug 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfxPb3hF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCB2DECC5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583527; cv=none; b=jtm4Lv6QVlZsEEpgtBDGo8VAK0puf/FZwAtY259ExXnuncDvtCCOnhaFmFyeXpV1tKEHAOBKN6AvqKsc3MpYn4TLQX609ar6ZHjfaaILYbqr9plKOJ6KOs6xQdhnhe9+8Ua+ivMOmy0YBIATBCMCwFk2a28nx3Bh1kSyMjwGPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583527; c=relaxed/simple;
	bh=MlWlFHjonE2eNpDRsMMQXFp+YzaIPvcuor7vkXgWH2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChdAMU+COQtxNtmq7oPo5Bo1LdNaMdolgLehzdnfl5jZgYeaW10nLcRYqPbvcN1fX0VngfiCJUjVq9BZx7YNVdog0ql53BURhqEhxmcdh54vHAfXZD6kL6sZ83IFibax6GmAOgeTHwdE79M61p/V1sAvZ9InGhUdSQ+MzI1fzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfxPb3hF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afefc7be9d4so300998866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756583524; x=1757188324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlWlFHjonE2eNpDRsMMQXFp+YzaIPvcuor7vkXgWH2M=;
        b=NfxPb3hFhQOUYlgYuzpRvMRN/TpnzwRE67fpmLupb3+CY2+lbttKSJKEdnvu1eoVVZ
         cUUfcXPmcK60l1F+dcwNPViUaOPqX3P+mlGw+UrkRUlnBLjJcFf+ad/H/kuP5mVwrVLr
         nR5Zqf3fFcCvT5ekvhjEMs18sNczxApetsSd1Cf01duIMqC1mdE+hfj67XACWUhM1ToI
         dIFbHOdo8U7lkARgqwmFQ+w3H7WvymBusU0uML84jMsGwu3OTVELkwwJim48yYf8E4Jl
         w9FtVYSruO2GAD9zCzyuKguiVHMgKISy6fPVJaLTgt64UBUMmmTDMF0kBPdkqKpdk36V
         H2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583524; x=1757188324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlWlFHjonE2eNpDRsMMQXFp+YzaIPvcuor7vkXgWH2M=;
        b=sd/Tz5CJPNDY7YrOR9UyqAiMuDb8s7qRpinNsKIfWxt62wXpPPPkmFKyaZ5T54PAoP
         CP6qdPP8hkx96h6WJ3OOZbiIu1uOeV8b5bL2R9r6hg1Si0iCa+nD6kcRqpl8uh7sEPDP
         DoMP5VqE+SIsUYj/Sr0JRNjSEbq2GtAHvuF4/9YaPcRKz0oiJ6T0sj2Qzml8gEy+pBJq
         +3LPDYYUe89JTd4E47IRCmhn6K65pxbXtGz/ElIYL8A5y0ywcP4vLfFozaSyNV+4hW8J
         aZye2iH8wETFdJK5KR6vEsp7f2jjvavmX1Zo6mzm5uchFqhIikuHUqbLDBfYVO+VxNaV
         WsSg==
X-Forwarded-Encrypted: i=1; AJvYcCWBbp4tgCBoFHNNT3r4MwaUg4GbHlnL9jYKkw+VJN8RVDWPNx0ejdc1ATUGA6W/nGVzEbSYCfSFUzTwEGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVv5Fw5PiiilFPOm0rF5cChyD5R/H7SG9M1A7q1iziqQFFnCc3
	/x5zC0jZUWfZ6iyvPTHM/o+3QYPc1wrp/xPTpAKr5kDXaFXMSST4b7+VP5wb7s2a69c6OpTqynY
	xkwQXso9Lbg8QYMgw6vYSnNzuwCyGcws=
X-Gm-Gg: ASbGncuI5TEQshiFqZDU6KRtla/gbnLJmp7Op/y6qrHrbj8K7K8beDz+p6Td9qZ0pHi
	9ARURb3GoCVExu5CRgu2hZexGJKhNuCBWWe67UJgDLIeaQCy0OX+9/RktJB5ZEG47EHRPUerTyW
	EEmMzhJID+odvrxqn+WUP6Qwgn/n5tQz6eAIH4Y7HW1uxWS6RXFnaqcDpfmeYqiRucbAliHy8j6
	1wU/00=
X-Google-Smtp-Source: AGHT+IHhX877Si5MHtMoKjzCPWSgDLkW4Nw8V64NkARu3mF4o1P47e3J3q86OU9aj77XdDWmr0dEwLTN59b/QLi7/Gw=
X-Received: by 2002:a17:907:a45:b0:afe:e1e3:36a2 with SMTP id
 a640c23a62f3a-b01d9719062mr323503266b.31.1756583523624; Sat, 30 Aug 2025
 12:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010324.15595-1-jefflessard3@gmail.com>
 <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com>
 <67046EE4-FBE6-41FA-AB03-B0E01FA1C274@gmail.com> <CAHp75Vc3DHUJwA+S4PGfoZxGtdqVq3GTF6_BEnJFo+=sFMmfDA@mail.gmail.com>
 <587AE3BE-CD1F-4160-AA21-12B875E4EE81@gmail.com> <CAHp75VeetsQ0NgVEnhic3wdUs-w0q7nQoGX4rO3aNdq8feypRg@mail.gmail.com>
 <E12E0A91-8B9A-4326-96DD-10078BEA81F1@gmail.com>
In-Reply-To: <E12E0A91-8B9A-4326-96DD-10078BEA81F1@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 22:51:27 +0300
X-Gm-Features: Ac12FXyajH_8jg1RX4Lx6vnCVvT3y7aq_m2HQfI3YRqAHEiOMWhyol4e56lgN-Q
Message-ID: <CAHp75VcHftKVQT4_X7Fc=NERzE0=U_UPvc00=P6UnBCvY6mh0w@mail.gmail.com>
Subject: Re: [RFC PATCH] auxdisplay: line-display: support attribute
 attachment to existing device
To: =?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 7:57=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
<jefflessard3@gmail.com> wrote:
> Le 30 ao=C3=BBt 2025 12 h 18 min 27 s HAE, Andy Shevchenko <andy.shevchen=
ko@gmail.com> a =C3=A9crit :
> >On Sat, Aug 30, 2025 at 6:21=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
> ><jefflessard3@gmail.com> wrote:
> >> Le 30 ao=C3=BBt 2025 10 h 39 min 20 s HAE, Andy Shevchenko <andy.shevc=
henko@gmail.com> a =C3=A9crit :
> >> >On Sat, Aug 30, 2025 at 4:55=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
> >> ><jefflessard3@gmail.com> wrote:
> >> >> Le 30 ao=C3=BBt 2025 05 h 15 min 23 s HAE, Andy Shevchenko <andy.sh=
evchenko@gmail.com> a =C3=A9crit :
> >> >> >On Fri, Aug 29, 2025 at 4:03=E2=80=AFAM Jean-Fran=C3=A7ois Lessard
> >> >> ><jefflessard3@gmail.com> wrote:

...

> >This can be made in a series, so the order will suggest the
> >dependencies immediately.
>
> Agreed. Series would then be:
> 1. attachment list + to_linedisp()

Let's see how it will go, but I suspect that to_linedisp() still can
be separated.

> 2. attach to existing device capability
> 3. num_digits attribute + ABI docs
>
> I guess this should be an independent patch series than the tm16xx patch =
series.
> Isn't it an issue to submit code without a real user? I mean, tm16xx woul=
d be
> the first attach/detach consumer.

Make a cross-reference to each other in the respective cover letters.
(IIRC, it's possible as `git format-patch` gives a message ID, but I
might be mistaken, and in such a case just make one reference without
a URL to lore archive)

--=20
With Best Regards,
Andy Shevchenko

