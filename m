Return-Path: <linux-kernel+bounces-801886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01856B44B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FD05858AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800C11B5EC8;
	Fri,  5 Sep 2025 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZWznRLG"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA1175BF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035055; cv=none; b=l0PVeolDnORqXY8YSqitNa7RMYK7PWNor8+petpont3m6Uu/m/jFfUaHzn9wpYSHExVyZQ7OMeGKTi1h1ymtIFf0gKRG0rAcCl5nYvyyXIpTOjtpogLjbijrZG5nLT01w8FMCd2gLj1UNPzymMzlpb0aYX/+s/q7BDgZ+94zsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035055; c=relaxed/simple;
	bh=2LiDsVuR+C2Za9gXSgwj/IVmzfiMxWkRqAi4hjBzaZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyWKfKO38/bXyhXuUWqClSTejnq6GsJyGSZaz4n1Wa4HR1yalOBjN+kRaqHGY/y9qR5XYJhVUE+JtvpBoFZT7MuiXnYTXfnCpW+cr5gBrUE96hd5wEc7GVi8hSqmLqzeEcauSf2xolSj9mfDO2rnNkZldMqGHpBi/yUawE0cjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZWznRLG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so1374558a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 18:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757035053; x=1757639853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7Pf4+kubMT40gLaV6AmzrZ3LLU0nezZUg5BZHTuQLI=;
        b=EZWznRLGpqsRMcy59dMh+ylVWr1MyM7C99AUlULYICxaECAyYkynVlJiXOVeFuf9TW
         P7Wwbe4pEbX0BPP90GYBbi93hUDjw3t+QEYxlilQP25jbwAZekwYSUrgbZ7vUfQ8ZYAI
         imxS7jDN6cvaVQMHTkr7RqB5F1rr2CVTyQU41tvvvmyTdAn7Ebf5M0PpwrVrNFxHfk1Y
         KycDcKbN7XlNj2RzaM8W7VKrRro3giDTMURSSjr0xRNlBsRe8O5ccxMsuZwW9QLUDkqa
         HSZLJZzBF3dErMk+9/B08gDYzrNq2zr620z9CxC16nTR2c4xWiEH3goMfy6rGtoFxEk3
         36NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757035053; x=1757639853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7Pf4+kubMT40gLaV6AmzrZ3LLU0nezZUg5BZHTuQLI=;
        b=Ja8wBy+SYruyXKSIteCzgiQyHd/QdhWzGNnsc0FKDd9X6Ch0wq54llMwRnnVQGDhlj
         e7AqahS6i/I1K6+98XGYzuijQ+X3fxZSOOgKbwV78QWrEnhm+eEBu7nEnrbEZKUnqSvf
         YELiOwyDVBv7c6qfnYsfiOoUH1JOm0JJ8YMFI0ecqL+nI6QM/5L+F/GFBNNizF3ZhagJ
         jdyyVxjd6SYuQO7v6JnfhLYckSwT4UHoQdrBraQ0OENsVDEshOrXKLnOfJb3R8lzXR6D
         XBZyRFvw4UcjCxBTS7Cknia+uv0pLfJueYSMS+XFR1FCHgqhGekDzPR00PfiO9uLvvbj
         c32Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy40egKIwKFRUJ6tlUlEKjUHR2SnwBvfyaeGVL4y3TJooSzFdVeSGwFQb7+DOfaCfB8fa29Qmjfo+gg9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMF6+//rRkXI6sQLomB9fIq8cHwzXo1Lj4r2r2Y6plHlX9DgW
	GjTaioAcGA7f+vKG4geQBdQlxAYpt8leV/T3PkN64JWoLHcziNi/ST4DM4QvYed4BtfnqPfhkYw
	78LlKbhDdMZAnzIlOe7Xl93H5dZb4v8E=
X-Gm-Gg: ASbGnctTOR5cx6qPx5eDUrRMM3Oer+6jHWqwtROPcjAFSGO2dUAizbRlNXTWn4xhOSb
	DHN8PO011fJgRa/k8ZVdSVm/3H0XzgwytfZ/LiszRf6yPvjGjKjGcOI/SjxhQwIMAtECXf5/bGG
	ytCy4L20RP0+yM/kPOyaakEF5RIpINcS4fuaWDpI4rrXbCq6rGhciz74OFOEbP/Kz0/zub16I6l
	MlIO6FOrbWS+XcmyygpovTVSQaRS15Ao1ebrbO1cXgCUpXfccPHjBgKrq/xx5rvt2C/wvecQQZX
	vRQx6A==
X-Google-Smtp-Source: AGHT+IF2qns+wQRFsCXVs6volfobRwQAPreJKcfau6BotrpqzEVF+JmtSuYlKk4wlAMa21p+q4/IITX6/mm6oZrsBdc=
X-Received: by 2002:a17:90b:53cc:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-328156f991bmr27587872a91.37.1757035053238; Thu, 04 Sep 2025
 18:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808095503.906244-1-linchengming884@gmail.com>
 <20250808095503.906244-3-linchengming884@gmail.com> <87zfca9kur.fsf@bootlin.com>
 <CAAyq3SZbPpVX_LyoYaHYhA3ZNeb0NYWQ4KC6-+uubB1GGCqZag@mail.gmail.com> <87y0rhyq12.fsf@bootlin.com>
In-Reply-To: <87y0rhyq12.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 5 Sep 2025 09:14:40 +0800
X-Gm-Features: Ac12FXx4byBzWH6j48oQZOe7xQFIRkBRcfZZ7-RMjyA1Z6cccgN6oI9mOsKBS90
Message-ID: <CAAyq3Saj5cmHAb3NPd=ZzJEvYD873s2CFKOyoxMrKk6Tj6yakg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: spi-nand: macronix: Add randomizer support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=9C=88=
18=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Chang Ming,
>
> On 11/08/2025 at 11:01:25 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > Hi Miquel,
> >
> > Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=
=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:19=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >> On 08/08/2025 at 17:55:03 +08, Cheng Ming Lin <linchengming884@gmail.c=
om> wrote:
> >>
> >> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >> >
> >> > Enable randomizer function by specific flowchart to set the default =
value
> >> > of RANDEN to 1.
> >> >
> >> > Randomizer introduces two new DT properties for child nodes to confi=
gure
> >> > the randomizer functionality and coverage options.
> >> >  - mxic,enable-randomizer-otp: Specify whether to activate the rando=
mizer
> >> >                                feature.
> >> >  - mxic,randopt: Define the randomizer area per page.
> >>
> >> Can we create a global NAND DT property for that? Enabling a randomize=
r
> >> is quite a generic step.
> >>
> >> > The penalty of randomizer are subpage accesses prohibited and more t=
ime
> >> > period is needed in program operation and entering deep power-down m=
ode.
> >> > i.e., tPROG 320us to 360us (randomizer enabled).
> >>
> >> Do you want to share what is the added value in terms of lifetime to
> >> enable the randomizer, given the drawbacks which are significant?
> >
> > The randomizer mainly targets extremely unbalanced data patterns,
> > which might potentially lead to data errors.
> >
> > Please refer to the attached document:
> > https://www.mxic.com.tw/Lists/ApplicationNote/Attachments/2151/AN1051V1=
-The%20Introduction%20of%20Randomizer%20Feature%20on%20MX30xFxG28AD_MX35xFx=
G24AD.pdf
>
> Thanks for the link, it may be pointed with a "Link:" tag in your commit
> to further justify this addition. However it is sparse on details. I
> would be interested by more details, such as "how many 0s? how many
> bitflips? how often/likely?"

Thank you for your feedback. Unfortunately we do not have numerical
data such as exact numbers of '0's, bitflip rates, or occurrence
probabilities to share. Instead, I would like to refer to the JEDEC
JESD22-A117E qualification standard, which provides guidance on
retention and endurance testing.

According to this document, there is no single data pattern that
represents a universal worst-case across all failure mechanisms.
Different mechanisms may stress programmed cells, erased cells, or
cells influenced by adjacent states, and thus specific patterns such
as fully programmed, checkerboard, or mostly erased are each only
worst-case for certain designs or processes.

Given that no fixed pattern can cover all cases, the use of a
randomized data pattern is considered a practical mitigation
strategy. A randomizer distributes stress more evenly across the
device by scrambling incoming data before storage and restoring it
on read. This helps reduce pattern-dependent degradation and can
therefore improve long-term flash reliability.

>
> > Figure 1 shows that continuously programming too
> > many 0s can result in data errors.
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng-Ming Lin

