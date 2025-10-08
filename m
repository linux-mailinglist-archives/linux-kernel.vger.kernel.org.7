Return-Path: <linux-kernel+bounces-845588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50CBC5718
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 912D534B4BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D562EC086;
	Wed,  8 Oct 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIHFaAug"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349D2EBBAC
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934237; cv=none; b=ivVtW35Gq9pzI/n6YTXcoAI9Kqm1GeeGCVqyqkwzevBfuoJ68zYjSLqEgbzv5ey1HIdyAPaXjDwt+wU4MI+Hxs80JfxWaRe6IHuWeT+w+0rwmgWNhIcGTJcacSgRw5ApePO8y3JKQ2r3/a4sDwk0KkjE4h/9izPGMhBYy9v5mhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934237; c=relaxed/simple;
	bh=Ixbte/0lL+7IX0qAw2kq3G7ZLxXlB4vVKnyEmSB6+iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp5taZV/4l78325leldjjdxgwATG6cZNn6WTwa2awAcPVqCLcMPkl4Qz69Hm+aZYFtL7gScr+daPYd9oL9KV+tplNtUfp6HQ75BdYAowrt0fJj2mva0ziyE7KMY0CI/Fmss50eJDTLBHTmDRLAZP2fvNNxlQYhwKSrDlJ5Mfs78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIHFaAug; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7a4a993dea6so2480917a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759934235; x=1760539035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6hIM6WNuFYQgzY7nobnKdF5QMgWAFdkVlhnmdbVzOs=;
        b=BIHFaAugrdsVPiofmvq95SBiCTHHf8DVEidybAst0iVcCvWdNQMY8gSLKQUfGYDe4q
         zONIQWBiU/FEaXwwJeTci8O3DoyhOS8oh3JA0Ta/8WbYh9KJcvju/AT7cpTIqm2xddGz
         DMv2SrbfoGuGOexqLaUd5lU4E7CgHTJR1xL8t3D51KNV9l/5ML7Tr1hfbxpTeYV/M18d
         EACnnASE2Zk2iA+PRUWNysi+Bbn8ftLpswPNApTHv9ygerXdwfe240vg7P7tas34Ivta
         5h86THGqJPficSgR+6r5tCF9XRdRjfLat0W2kWr6qYdMYr+0JPaH7HohdAbfULQ7eTRF
         5ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759934235; x=1760539035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6hIM6WNuFYQgzY7nobnKdF5QMgWAFdkVlhnmdbVzOs=;
        b=JbHHNDpQFZqxMHSEjPZ7pFL/vXlyuVJolJHx4QtRBIILTFQsOvnywb8jZdMErHW925
         hRVM0BRP1XzSw3fjrEMewp8DBXoAMWuEV9MRiqdRAhz5gowIHwrohklVXCureaj2Uyt1
         saAiX3fCInn1sBoGk7+toC4KK/nqLk0UECGdL+jrDTWhq5mZxcNMC9veU2U+no8Pv0xd
         PwhRLxxt0EBXbZMzwzYA4FUj3JOBMxJQDw9b6T74aZ/1QVVF2bTwTEQqo+ighRgjJkh+
         9F2GFfjHzsL/62EzcUd1wUOsMmFhJrRrUDaLNMNZ6ubn7+8fVybQnKlb4na7hBpLFUGd
         Cr6w==
X-Forwarded-Encrypted: i=1; AJvYcCUy+uKEdJxpeLED6B4tjBB2wOrlmsdtABz71VLiWes5nVvCj1HaGo4VdbNm4pTcyaqtp+U2NTMvcRGLWas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/F+qko4yGyUg9wbpEwK1G0QkcbwcsvzA+ThehkagEAzi0648
	JxpedmVCXRyqvg7F2gZPJ+f1T254JEZ/9Z2wbYE9um+JKEkwW5taQ4FVXmbasC6qSQltIWd8yEv
	K+SZA2QLlzTGBvtR4Bocy+dLNRAvIp0koXr7t/1www6si
X-Gm-Gg: ASbGnct/jzF0MF92sOC0Nhx92Llm5fk4N33V7AGkcKocZOCkTU/kWcvXfoKNLtPMKXb
	LAeTUsg9DYa4pNSHxozPvO1+jN5A9NlwbynZ9IQPw6TrMBH833hA8XGqevt2XAl+9p3kcZ3SJxK
	p/InSLvOIS0cYXMi8fcbNQWi/8Yt5FnyQpKUUQXHS2H5o4NkzvbvQNO52mOOfMf+gutzuFu7Rnv
	gOyCrjwbiWg7WOdLIP4Y0S2F4t28ug=
X-Google-Smtp-Source: AGHT+IGdolKZV+83ozvEXmRGakQKj59JusdSPV3dSs4T1W7Pq3LPZNTXJR1iBTufVtVYZ5FjloW+su0prdpDYyfenzs=
X-Received: by 2002:a05:6830:2a9e:b0:745:a21c:6a63 with SMTP id
 46e09a7af769-7c0df752611mr2003836a34.9.1759934234888; Wed, 08 Oct 2025
 07:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007145028.1845-1-briansune@gmail.com> <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
 <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk> <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
 <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk> <CAN7C2SBG2EZ4CJKR_vWKBGsKpZTF_9VJXj7ysLx38nJW3dFxeQ@mail.gmail.com>
 <f15af8e0-3bf5-4dd5-85e6-07d00f8b020c@sirena.org.uk>
In-Reply-To: <f15af8e0-3bf5-4dd5-85e6-07d00f8b020c@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 8 Oct 2025 22:37:03 +0800
X-Gm-Features: AS18NWBX0pcOTSZG_qrLJTlFAyvqTKFMyWIHAO4GASTUMYtTnA7EWQEdQts0kG0
Message-ID: <CAN7C2SATEDK4C-C7NOOvSKsQnfDBMStogkR8vFBAS+tejLbtNw@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:20=E5=AF=AB=E9=81=93=EF=BC=9A

> Many devices (including all the Wolfson ones of that era IIRC) will
> happily just ignore extra cycles on BCLK, the issue here is handling of
> a f_256fs which is a bit off what it should be for some reason.  You're
> assuming that the device is clocked at an exact and suitable multiple of
> the sample rate like it's supposed to be but in practice these devices
> work well enough for the system's purposes when the clocking is merely
> close, they tend not to be particularly fragile and users perhaps not so
> deeply concerned with audio fidelity.  Note the warning the driver will
> generate about considering using the PLL to fix up such misclocking.

If this concept holds.
Are you telling me a operatable case audio can output just quicker or
slower on such w/o issue?
Are you telling me the left/right channel bits  are able to load
correctly on fixed lrclk while bclk is overclock?
If so why this patch required from first place?
Running bclk quick and just feed in the left/right channel data on
1bit delay on both channel should works on IIS.
Just make bclk /2 or /4 from mclk always works while LRCLK just fixed
to 44.1k 48k or any audio SR?
Datasheet WM8978: Figure 38 I2 S Audio Interface (assuming n-bit word lengt=
h)

Why we got to argue this things?

What merely close is based on bclk and lrclk is correlated properly?
For example bclk is fasted then bclk/bit_size/channel_num =3D lrclk
faster then this is still holds.
Do LRCLK is fixed but BCLK is far faster still runs properly?

I think if the patch is not good enough just drop this idea.
I cannot understand what operation scope you are expecting.

Brian

