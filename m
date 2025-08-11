Return-Path: <linux-kernel+bounces-761750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B238BB1FE07
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD16C173B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBAB14A60F;
	Mon, 11 Aug 2025 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKNz9RDU"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24FAD23
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754881417; cv=none; b=fseVgdTWCA0ieDNXtcvdAIaM8gpnq/x9w6eacUZySskZp5uJX7Sa8RFwrB2F4TbF0cld0s+tjf5wiVVwlX/3oKfwUf/B4mR+XVxLwbsdSDWWPJd+0kCFd0MjaeuRUpjK89B6LuIAvOkcIU1HyH5EHIzhOQXWNIUqpQWR4+hFfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754881417; c=relaxed/simple;
	bh=Di6qxHkj9oUSWbXSvYNx8nAEowNeYCQwHqU7gBDpEoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irFyfLujo44esIENIUn7Vk389p7ZIQohLjXzMqIfOygxCqeDpDw+4gkHlFMSwM3Xec2ukGR647/R/+n55MoBA2zmhGzvYeFOAvsEr1DzUxWhY0Y623kS0JtFtrnKz2Zamv5s326r+eHv7JMwfWNB5hgwfUIoWeF1HctOZcxjVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKNz9RDU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31ed9a17f1fso3087570a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754881415; x=1755486215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsATNO7vxMuxyYylZDIuowEvn5aJ6XccLf59i9aEyTY=;
        b=VKNz9RDUji0Ehu6h/+Cdp9Dtofy3DwKVqbQwzO+c/ugFdHqjwKuUV4QTHT8FPlnk/Q
         W8l9ngCYPSOHMRxUQGn0t1uJBZc6GqtcFUh5e8+cR/WdbNYZ2Oiv9ZxEXq9YuTRnuN7J
         XEybvzhzZNcxZRuLcSBBzws88ITCZCDRi6ZSUmZiEpkBq9Ss329U/+Rn6Tge9M0WUcW8
         LcLoneWFOxctX+XmLEMej8tKLbNgFuVvSzfdmJXkMM1MvVJTrQRU6vnE2aj3W1tIngGi
         5wnLfalyAXaR9LOBTT5NhKF1NBhsK2oto+E080BwBOuRiSyhgVtusF6EKJpQwSGdC43Z
         1mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754881415; x=1755486215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsATNO7vxMuxyYylZDIuowEvn5aJ6XccLf59i9aEyTY=;
        b=nj6Y4bGtAmIR3EQ1LdelB0LYdT+UoeyPP0NKH+QboPg7FS9Yq+Iti7w7KIOdSsITr8
         paZZJuvvqIm7zpDeBTvuhNajKUq78GSkmMxdblgJ/MrKSM9eJapz2FzPJta3g/yq7oLv
         AYLdGAb+NhhUpqm3ruqqTL2zfL+RJmtg5TnCptPp/4+tttUkAkpS9Yp6eVscd0bqYQaU
         IAUgxAdarQuE6+8M//ZjPucBMZ0zDiUcHyrniOH4aLguJkOR6tRCies0PZ75mQqn5O9x
         cKdTGSGypTCcet8Im4jQ+KoVK5rx3f9VnrHjxZkjVFj4ii9YatxFqzIwLvZQU76WR3nK
         tXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuatNUcMG6levMHWdej8+9vXS3cZkp4AHXsJ4HTVZvJNxs0+t1eaHkr+XbNgc48BePQPYidhlIOSQ8GBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzPy65tp7EhIWRRvMp83lNskIxkEjg+mCmHNUP7+d1/O2EP/ra
	HmRjFt5Ex23uNzRoHxXgycCbKqhEXqDgRp5r2R1AMd4xfXAW8T6zCOF1RNbcVM+HlaNZMdavOUD
	+xq7iN9l8638V7LQQGLHU4cgmZ9Dv4Zw=
X-Gm-Gg: ASbGncvAasZjJ/7sAtbORHNq3E8H8W2S5bA94g9Ob9TTQ8N8JND6CxYUyx9G0URWchA
	WEeTKA6maWL43NAvuzupk/fcDD3oIJ2SJ2/kGWXKfP3f+xLR05csvFLcybcv4FMDf+F3hUK5H29
	AVUN9IVGn75xyfv3p+aI0zgAt988bGMOEk9oPZ+IigGnhyddAyOFGVFIe52539F6LFMZ7trDhSC
	9Ko1eE=
X-Google-Smtp-Source: AGHT+IHYv4HPwLaWAoIc23z+VO1nf1+EcK+dCdc0O8MvKoLhP9opU9gnjKgA4klmEdxO3ouanYg29RJ4Y0QMjiqbdEU=
X-Received: by 2002:a17:90b:5786:b0:315:9cae:bd8 with SMTP id
 98e67ed59e1d1-32183b4d95fmr13760150a91.23.1754881415361; Sun, 10 Aug 2025
 20:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808095503.906244-1-linchengming884@gmail.com>
 <20250808095503.906244-3-linchengming884@gmail.com> <87zfca9kur.fsf@bootlin.com>
In-Reply-To: <87zfca9kur.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 11 Aug 2025 11:01:25 +0800
X-Gm-Features: Ac12FXztBa2kKDLSenS5JsM2SIpn-RB4gfFpR_F9raTQNRdao7XKxJAG8-pMJdA
Message-ID: <CAAyq3SZbPpVX_LyoYaHYhA3ZNeb0NYWQ4KC6-+uubB1GGCqZag@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: spi-nand: macronix: Add randomizer support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=9C=88=
8=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:19=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 08/08/2025 at 17:55:03 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Enable randomizer function by specific flowchart to set the default val=
ue
> > of RANDEN to 1.
> >
> > Randomizer introduces two new DT properties for child nodes to configur=
e
> > the randomizer functionality and coverage options.
> >  - mxic,enable-randomizer-otp: Specify whether to activate the randomiz=
er
> >                                feature.
> >  - mxic,randopt: Define the randomizer area per page.
>
> Can we create a global NAND DT property for that? Enabling a randomizer
> is quite a generic step.
>
> > The penalty of randomizer are subpage accesses prohibited and more time
> > period is needed in program operation and entering deep power-down mode=
.
> > i.e., tPROG 320us to 360us (randomizer enabled).
>
> Do you want to share what is the added value in terms of lifetime to
> enable the randomizer, given the drawbacks which are significant?

The randomizer mainly targets extremely unbalanced data patterns,
which might potentially lead to data errors.

Please refer to the attached document:
https://www.mxic.com.tw/Lists/ApplicationNote/Attachments/2151/AN1051V1-The=
%20Introduction%20of%20Randomizer%20Feature%20on%20MX30xFxG28AD_MX35xFxG24A=
D.pdf

Figure 1 shows that continuously programming too
many 0s can result in data errors.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

