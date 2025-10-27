Return-Path: <linux-kernel+bounces-871218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A490EC0CA80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB433BBD01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BA26FA50;
	Mon, 27 Oct 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvifwJYk"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7F2E6CC6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557129; cv=none; b=oGYjIkVspbqrC1COvi2zY0cQUy26ZaAICdW887tW8BiIWfQU0NLHU/DYrXVOI3qSGj1BVIJ61nkAQYQFdIxUyJVw6k1Q1/b3qqOyZgFvG4ijPZHAwda/00d76KcVEzUR7V2PjILzNQHkveonhsrjf9c8O7Ti1prWzqx8DXk9ecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557129; c=relaxed/simple;
	bh=YJ3Na5nmh5DDcjGriWUnHW8mLHF0cCL13X2wMKwKkZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku/1piCiXI73x5M/QsnF4nJ67ebnLeJx7WKUPVg2u+r3czHSlWgerPI0ag7daZgYPBVF8Rne4FXjgxdf6DIXANCp3MmRvZVMqG2KkbD6tGheACcXm1J/ltQ8IToWsBYFqgTFJo16fA80iz66d+snYJlQFQebetHN2boMb+llZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvifwJYk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7930132f59aso5780121b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557127; x=1762161927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ3Na5nmh5DDcjGriWUnHW8mLHF0cCL13X2wMKwKkZs=;
        b=QvifwJYkJnnKP+TjMgC30TrsGQM675Pv5fHKYcevIQ7AbDKujy1eWdWf6RhhlrmkPQ
         vgWA5EEZ4oQ3Y9xH3KH8bLGgjYMBHWrv4i+FaDchgiDoFBsOo2hRnLn10NecAPqUTfNR
         gfcuVKSOe8lbS3V2CSTeo/lgs8b0zvqJlIGC8+XUR0pWFk/s95lPsATouQbmurxLioZk
         tWGYVtTzLeE+bHZ6XIt4jI4nZfDaql3HxSPY9V3DUoYHI6+BAWzn6K5DQB/vP9533Ooq
         q1U2VIsgy1rPR8BFuStatnPsWnM/oypjsjgtnAGZ0a5W1jkt8v9pjH+VisGv9Smrqc4G
         5Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557127; x=1762161927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ3Na5nmh5DDcjGriWUnHW8mLHF0cCL13X2wMKwKkZs=;
        b=mEKJpHA66tunoUROokgyRektXQsebUkmZ8o2uldCn7JRI4et2vDaux68rRmF4N7u5f
         LaW+UL1Hq0iTpKoLv1u9rm7iUtpd3Twt++QupV8ruT6PkCJMhTrFWvVds/dLKTACGjc6
         +utM77BTypoAleNeMQHysBQLfE1SSBwoP6+EXa9sTCnozy0O1n7Z8jbD3YSaIYXx7XXY
         tfbSOjjeVwIVxEDCWuca1Pn50YjEBgQd1TIvr0IozP16vKV4Cb4tA3BlFp0IvcXRTbgE
         ZQ/Hb26fli4NnHXOcpym37rFzKtuwllP6eX/KD3qpabL0Yy/mfa0rq0nFwENaj7L9Uxq
         GRig==
X-Forwarded-Encrypted: i=1; AJvYcCUvGyqTxixEDnY+5p0zbWY7h8GWlDCOjbxvtQJDNghH5bHNnANIJ36cUb5edwXty7OTCoc927yPdNpqyIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsjq3dEGSfBTb8EbQ5ukC2Uau53KRpiAoWdBiLp44Mg49lBa0A
	dWc3ddGRiNh5UPuLrZqyBaij0cSHfNlN7ZDnuMkQZS7OfzVQ7l5b+CYjF0WSkCQ53JQ/dQwdxAo
	MOmjZYhxTSr4HPznq81RyNX8a+fxp1FA=
X-Gm-Gg: ASbGncvEIV4UPLwW2FIjPyTFGY1bEUgzYhQRdPEG/h5J55R2WtrHaqOE/LAME4+dRai
	efjnrrlQZhSmczT/jarZL5jBVmKFNfOjGYf1J8fyosDIwUKxKKyRZEV22T199siszagC/vaU/Ry
	Af3I9/lgAfJSp689vqhbDFLGcG7rYt1x8DTG2hdX419FYYmPgkzWma6qX43HQS1yyAe6WZtJ2UQ
	SlDUw58HKakHAdD+7l/G3UxH7dd6ZmmXqjNQ3dtFxAtyixUk03BZ2NwQcWY
X-Google-Smtp-Source: AGHT+IEiG1Heztw+sAzc6C9orRdKxxd8nUg5Hwrgtqpqrdenw2oiLdlGPf8acbWrVKMFxCxLmp8gxM8EFG6JHJGyBFc=
X-Received: by 2002:a17:903:1ab0:b0:290:c0b1:edb8 with SMTP id
 d9443c01a7336-2948ba56285mr114949085ad.40.1761557127361; Mon, 27 Oct 2025
 02:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
 <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
 <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com> <CAHp75VcB9yLZq31zHa8wuE2DtxJ0j5hoco3q=F4WG8yDuTrtkg@mail.gmail.com>
In-Reply-To: <CAHp75VcB9yLZq31zHa8wuE2DtxJ0j5hoco3q=F4WG8yDuTrtkg@mail.gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Mon, 27 Oct 2025 14:55:15 +0530
X-Gm-Features: AWmQ_bnQqMCu_7fuK1sZJyFkgn5UMbNBZRiMmlLawMoRHvGlI9KxSUmDU_eS-jM
Message-ID: <CAL4kbRNi+B1Fm9fnEvmLS_n1SWQnb+BC=xht4=qJOrnEUqqGhA@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Andy
I've sent a v2 that combines both kernel-doc fixes into a single patch.

https://lore.kernel.org/all/20251027092159.918445-1-kriish.sharma2006@gmail=
.com/



On Mon, Oct 27, 2025 at 2:24=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Oct 25, 2025 at 5:12=E2=80=AFPM Kriish Sharma
> <kriish.sharma2006@gmail.com> wrote:
> > On Sat, Oct 25, 2025 at 7:05=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > Is this the only issue with the kernel-doc? Can you run manually
> > > scripts/kernel-doc against this file (with -Wall) and check, please?
> > > The change itself is okay, FWIW,
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >
> > Thanks for the review!
> > Looks like I missed another warning in the latest linux-next:
> > Warning: drivers/iio/industrialio-backend.c:1069 No description found
> > for return value of 'iio_backend_get_priv'
> > I can send another patch to address this if you=E2=80=99d like.
>
> You can combine in one patch, there are no strict objections for
> fixing all (small) kernel-doc issues in one file at once.
>
> --
> With Best Regards,
> Andy Shevchenko

