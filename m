Return-Path: <linux-kernel+bounces-845577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E8BC56AE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B17E3A81B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D8F29BDB9;
	Wed,  8 Oct 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaGDGj46"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC11C54A9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933110; cv=none; b=GDDko/xPrf/KqWSpGMW3zrpLPL8SH9ZJxpB+tBZjBGckBWu+3fvNPpSIZ2XNec8eKotzT1jopeGi8eKoAME5Isn5j3pbWkJCw1ANGX775cW1TBKNXhaSMc0cfjIqDQAX39FKqi3Bx6nYbc3cpNCzO+6FqQuBW2aaLShedYR78Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933110; c=relaxed/simple;
	bh=02xoZOIaqCUk6gy50ED6DchHmI0JFVyHynhA2+ahuyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFefBtoyqnJzCMKpk7j7K+9JMtFbnTPTPb8SxCwfbqe8QMeCFVZ0GhpxxQCB5ibD614ea4jyK3/zh6lFUFRYOvYidls8k4PHyH5RgMTJEg/b+6SOn/0zzyphkTDDg6FXaMDmMtzRkQlz4LlA5Skqw3pGVUpV5OKHoU7SaMyQATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaGDGj46; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce534a91so2538778fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759933108; x=1760537908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02xoZOIaqCUk6gy50ED6DchHmI0JFVyHynhA2+ahuyk=;
        b=IaGDGj46XIEWM6dLd2386Af36ZegkUCptIovx8XvpZKTl+wVuoyOBQarAhFN1G+BgG
         DJ8tC6ckKAikqfIPHPej61PN9Ivr/3SeYnoAUVNz+oSTmHy/9SabA3rEnKbo29O7Wr//
         7SAfsAPF0rEEdKmRf79xEIM7Kfj/BxvAJ6zn5rBd5vNVdMhcCV+SIuGSPkN6CDaoAqea
         325UYRVXgFkOC3zN81ATwfO+SiFziKqJunpcqvnCqK/5HFKX9DfE/0LMv7IsCULDI1vB
         OHs5MrCqnO4WWti5qToq/Zr4hgCsQmfqh9gyxXmrdBDwhPoZUCCKi/BYpoUNYJq5afuI
         GyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759933108; x=1760537908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02xoZOIaqCUk6gy50ED6DchHmI0JFVyHynhA2+ahuyk=;
        b=TlCYDCN6aK5+WrVIEPVxNOe0GoKwUhfbDAfPtTIQWmo0CEv1aJwoyTDvNg6GyoNSS6
         HBbc9CdfjdZfdwSs2mFuLxyY7m6fmVKuS9TVJ9exkNm3423+RUqT8LIAod6wAAB832sl
         PxADqRb0BVf3nd9tY8tmg6KJlYaoTiVXnwOIi2RFJaRQr8RPnMxmcl+3ixlj1GXyUxQZ
         t0snxuKfD675rZhnPzu/WO1NYmv2cegRUZt4Ulq20d1XVr/Cx3zMBdBEF8ywVYnlFQnl
         VGupyG36hU5+OGAGeD6v6aJ3zRce9aRVSgQ0V6tNerTWEIMsjXD6jpA3vuokcQ1GHUqA
         3HRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzmz1BSoOhfo5h8CaEWm8UusfWaDrdW5naJb0rK/oJfdkgC6DaNQv8Mj9Jx/F+fHT3aGFgnfcwTY40MKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjmYPpV1/3swHoM//ChZ1KwwNwuziktny8hftmf9EUQ6gO0QP
	TLeOIUaRT68EvbpeN5yUn3GR6Mh3QnqyySuww0SAwEZal8UbAkI2Y6QslOUmpPg51tDJF0elat/
	igJ67Yz/8Y/7b5UYgko4ZKPDUa43aMwA=
X-Gm-Gg: ASbGnctNtpj/KJQBJ9xuDUxT6ZGGm3VmU3wx1B7/O4luFy0AfoqlZGjoDwakCYPInka
	rEP/mgeS27/7DH071X6gxT8KqGFBxGDAaD9PWJuadAU357pjAw/0NCpS4vpj3kqi+1k4v6GyGMC
	4q6zsviOvCi4U9e0z/tQx6sPhVfNVq27aB4QMCJLQtdwNLjsI2t5UmKXjSIAKzvZd7NSBSmX9K3
	Kq/jHaxDPgKP2k5wdIU50WTpI8gt87Zkb1Yn4ek2g==
X-Google-Smtp-Source: AGHT+IFNFjVUAWMHKgGHXBLdjL+z9UZVnH3ivOrRi96WUbNTNIl/wqUCLJ3Eqxp4UI6lqYQhsmLvNTpljrWMA40Zw6Q=
X-Received: by 2002:a05:6871:451a:b0:315:8b80:aa4a with SMTP id
 586e51a60fabf-3c0fa86713fmr1692388fac.48.1759933107602; Wed, 08 Oct 2025
 07:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007145028.1845-1-briansune@gmail.com> <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
 <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk> <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
 <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk>
In-Reply-To: <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 8 Oct 2025 22:18:15 +0800
X-Gm-Features: AS18NWBAo1priwf20NfbC-WLbiCJ7RPYiCQuSQkiocxt57LiFHPz_plFqnbPsSw
Message-ID: <CAN7C2SAHy=9S3_DWCEijr09KSc4s516XAcfVbwMhNoFr_PYYrA@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:40=E5=AF=AB=E9=81=93=EF=BC=9A

> This is not OK, BCLK is 99 which is less than 100 so there are not
> enough BCLK cycles to clock the samples.

What you are questioning won't even fits under normal operation scope
of this codec IC.
This is simply arguing and I really hate these type of conversions.
This is a patch for specific codec IC architecture.
Such automated bclk seeker just runs on expected operatable scope of this c=
odec.
And such patch is to fix missing proper bclk register load from first place=
.
If there are cases that is this codec is allow but could generate
wrong result on this patch.
Willing to update this patch and learn from my errors.

Any one could do what you are expecting and could runs on this codec.
Happy to learn as much as I can.

Brian

