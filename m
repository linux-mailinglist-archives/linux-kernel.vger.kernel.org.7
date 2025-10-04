Return-Path: <linux-kernel+bounces-842152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E755BB9176
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4013B9BDE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 19:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F5233D9E;
	Sat,  4 Oct 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DDulwQAJ"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FE223DE5
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759607929; cv=none; b=UEpki5AlNqFRSxkmbyw5rOSVHdnMEKZV1c//aksuzGPK5ga1rbp4RPDSMfjgFWhcJUTdJXf7IVfsE4FW5v4eRpE4YhlDzvKfWoEYPp1GdWUIlgFNd5EBAazR8AbOgA57OUKMZlHwuJThnCM9T9vewMiJ4OtwI+IlU/SPhvMkN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759607929; c=relaxed/simple;
	bh=YypJ2n6ObcheY1R39FEjFgc/VMR3Ck0gVe3LYOexbGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/sxxduaJRkzjras3Lq6FTPlOH3QFQx0pFY2rCUbB2GoXmHtuY7BE2y0zLhuUXSl2FPMIT4aqt2vc9tKCR0BqC86uIy9TLs+fj4+bCaxkjNSHJ7MSQK8D3uAAER0ZCt0PYjmvXidN+xe/gdFY1gtR1/v1RvVcWtx4RElZCjQBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DDulwQAJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so4089868a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759607923; x=1760212723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkUHHW/8YstHHualb/SiYorZ1DiF4W6i84iViR0FPpY=;
        b=DDulwQAJT/4kxHMHPsS7SQqDG5dKYf/D4I6d8cJ3oefzj8PJe14kFrNvjlEnGOBcMj
         VivrHLmb9khnqo2FpDjwZs++u3VD1y8Fy7HX9K59XhqRUZVZhtqiWwUHpznipucfBIAc
         a9Kqj21Ney9QqrOSIgiXUEWnwrl54Lc9T5DZZCTDgXeXy0M+Rpwyf7gOD20o0gc7VgYu
         L5HoiGBCQQZdCflq1E7JJumeRWgu8FeuVdQJYJl9kl558TrGBLJalrUCb8YrvdiEdK3J
         2oBRJiMM0eL1DlpLLuUZhPsKaVaxbd6O+3ciI/WNP0FO0xRfGI1+p4Zv5qBWfMyomz7O
         vlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759607923; x=1760212723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkUHHW/8YstHHualb/SiYorZ1DiF4W6i84iViR0FPpY=;
        b=B5/9P33GFcMU0ozniXBH7UdgnyRQ2PFsKSver6qPyiLdb4mlFApBbatCzwhw0Qqz+Q
         hTr6xnMB0HmVXyV+MdJD4Y2bgV+Rfgiu98WnIvy7vvwVrtJSLK+7yHHzrv3oRfLVMUh6
         Pi596843CxBUwtC5Naqqd9jpKmJi4/sgQ8EmJ9hgwk/kNtdDylwZ21nW2nMNq4njKxJh
         n+wA/yBD148cOp06heubZ3I1PzvDtAgYRF/UM7pZA4OtMLKk/4/7IiwTF1n7GmIktf3Y
         FP7oNKgSajH0Ho1jplTs8x8bB5XV3h+x5KeNpcCqpx3gJnGJ0AZ3hPwwfcbM4gRVm9AG
         JknA==
X-Forwarded-Encrypted: i=1; AJvYcCWKREBd0ganTN8wqyRIXZe4hUPXe7ii0M16P8/WxmxHNM4MJeKA5riPLpEKSv0OErZcYG0a5UDOCAA9BK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3wtFIN9/jLrqB1iEXIBPsPIK0EmqsBMeYwa4Tkr41ZhuwMMv
	cxrqhjIc9DLjbVYSTzIfad7M1mleHNghuKZjlWejWOMlTx4hy+oGLyzso+DUvUuePL4s1NIOPGg
	zMrUB7L2Lm765aFIXzTzNXDz9+xbLH2M=
X-Gm-Gg: ASbGncu96CkXlLRgCzwf/ib/Y8Q0micBRvduahIedfr3RgslhljdQTX98RiWhctnMGp
	dDgHaYcvmZt1rno2kHYLr5hsLMoz8veVwaCH79ZIrV/0b/cADuon8xab9p7wCD3mHJFO+L+blQu
	XSum9xA+XfwpQHZWYrtD3YZ+qcAMtjmv8LHJqIcB1uGaFmRyB777v4Rs0+WwWJQBJQ+R0igdpra
	h/15TKyJG8OuODVHZS8JiAUi5pmmr7kmjNhRCmDPrh0uiq8E7iMiN+ecVHT/EsTqWBXcQhGV28=
X-Google-Smtp-Source: AGHT+IHIlqoFMv9csx8XRng4syXVJftJT6zd7u5YxyOumBwLOTKBWwzcxLH9Rhpq2ydFsn3WZaZHOCkzeoZW36Gl4Kk=
X-Received: by 2002:a17:902:d483:b0:264:567b:dd92 with SMTP id
 d9443c01a7336-28e9a664e7cmr89943225ad.52.1759607923096; Sat, 04 Oct 2025
 12:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927125006.824293-1-christianshewitt@gmail.com>
 <20250927125006.824293-2-christianshewitt@gmail.com> <CAFBinCDQc=2xrKbGunSKJjLhGd0bCGN+3oYd_bg0ySs+WHxZjA@mail.gmail.com>
 <6B97C24A-A1C0-46F9-BC74-3E7D2119B6D6@gmail.com>
In-Reply-To: <6B97C24A-A1C0-46F9-BC74-3E7D2119B6D6@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Oct 2025 21:58:32 +0200
X-Gm-Features: AS18NWCb80TyhWmdif5KiXRRfxefpRACPUKw21AL9syFqt4EGgXmS0JSw7hcZh4
Message-ID: <CAFBinCBrG0xZ6sWwZYtB2k_giZoOKjB_AmtbidVtyhib=UzDfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add initial device-tree for Tanix
 TX9 Pro
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 1:43=E2=80=AFAM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> > On 29 Sep 2025, at 1:12=E2=80=AFam, Martin Blumenstingl <martin.blumens=
tingl@googlemail.com> wrote:
> >
> > Hi Christian,
> >
> > thank you for the patch!
> >
> > On Sat, Sep 27, 2025 at 2:50=E2=80=AFPM Christian Hewitt
> > <christianshewitt@gmail.com> wrote:
> > [...]
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-tx9-pro.dts
> >> @@ -0,0 +1,90 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (c) 2016 Endless Computers, Inc.
> >> + * Author: Carlo Caione <carlo@endlessm.com>
> > Is Carlo really the author?
>
> He=E2=80=99s the author of the original device tree that 95%
> of the content for this one is taken from; as is the
> case for most older Amlogic hardware. The decision
> on which bits to copy and paste was all mine, but I=E2=80=99m
> not  sure that skill deserves too much credit :)
I just wasn't sure whether it was a left-over or on purpose.

> I can resend with my own name (or mine appended) if
> that would be preferred?
I'll ultimately leave it up to Neil. Maybe if he wants your name in
too, he can just append it when applying?

