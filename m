Return-Path: <linux-kernel+bounces-850623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0119BD352A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A953C40A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207E233D85;
	Mon, 13 Oct 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJFtRhjt"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7922A4D5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364196; cv=none; b=L2KxC/X2+I656FOyyCdsnU3YAQIMbKln9rUEG5hYE0MGmFl1ZpxXkP6SNg58EaMDQ42oX15XJC0TqmKiecMz8fcYVxCC41FJO4q5gNk2UrMbjiTzQ7JKxbw7xjZBCNm4OZTU/aDuGAnZldYZVwRqCuGltz/ugh2UllNpZfI629Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364196; c=relaxed/simple;
	bh=0pa4lQo6WdcD3iZoUXfVz3eROSCmrkBGjXHPB2KVS+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raWDyeGzIAhh3w/8YswisITFv1ELBLABJqp+YfA5DkYAWOo2uCgDg0txNXoUPT/p4klP62Ept5X8itU/7/uh3j0c56+y13Hp98yFIqedFACdNH0lhitbXqQY05GP/2OcAxs9xKpoKHtjV98+kymfS2zc8lOX2NvdHSKQidLL7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJFtRhjt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87a092251eeso67508596d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760364194; x=1760968994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsvwD+Fi4syTXky3R6aiFFqllKikijYJhVHTrHzkF44=;
        b=eJFtRhjt3Zu3BT7C7gTzBbfuwYP4T3t12VTDyTENXFsbjBUzQRN02xvsZezeG6cGIm
         ry/e1bPXyoDK3XeRjqKPchiL52018EvQKKfBzuYmE5ZujY0dV0oxxl/iuXHDwPjD0s8I
         SxqmTws10Xa64PcqVAIRA+e72Zr7QDGiDN6biP59eYn3tYuTRLsdMqH94KBn6cPvmukg
         bL9qr1DXzWF5fHDXyUm+GgLoipLyKYZ+A5lAckwftMWbwwvW3AUjIhaeZi9MiCl1ZL6P
         7gH5tXWzJQC3OUXwjoKXejXeom+ZgMTNTusogEAVpyEoucnaYNAoqeHmlBj8ygCnoJHr
         8OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364194; x=1760968994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsvwD+Fi4syTXky3R6aiFFqllKikijYJhVHTrHzkF44=;
        b=PWx+3ZfRDf8Coif/2i904d5HECalmn1+95h7XmZWcOnGW1+JQKdR7B7r+CO+JlztA/
         WNmpj8GOXMaCsLCz9F8m6oqWZOAooevi2OFVfMrKbjsEADaS2RbG0ebyh7YKiiN16Nuc
         8fSzHzMMoQWHsNNAXT0cSCGQhaH6va47i0cBOSgcRU7GZZZotV7q6HtUu0j8ciK/K4VR
         se91gix2ROZrOB6xakq7EGPpPOZhkc74JC3iqAmhWAcM5OrQGojdnQylb8d2/PWf9Cbj
         PiQD7LJW6fCREfuJgvLhN/sLt9IWUwkpUFjcbB56BhKauZRM9iEVHhC1KIlj9PDDYbb2
         IgTg==
X-Forwarded-Encrypted: i=1; AJvYcCX1fppm/JB9nDSsnXpoWRzNiQPJ6VhZOqar/ql2cRKdRgJhw0V/pvdxvzAu4N7l5xsYLNXn4BhYBhH/OzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54h4smlsqWtuvJuj36aqGr9LkM3uM1ww0rRj/D3mKXGxBIQcf
	BPXsdXUwrmcZp1A5KKmFjs2bRf3v9dBDeLSSuAHX+NIlWgwjMlZ4TkJpC6NAeRKYz/gRkJN4avk
	hCgUEeVJV0HA64pVjmsnaEUgdhuMDH64=
X-Gm-Gg: ASbGncuFyLhdr+yOiFl6rgwREcPkWxkcg2obpX9kjbbbR5tof8OtRXbzKLbXToLRR3j
	QC2cPUtIYnIXu9qZ0J09+cnIHqkG+C1MhNliwDRypZMlBZJ9b3tKASmBRitbU9vqBHknl3e2K0a
	Q1SK1K3CZeRvDxyggqb0odmYmkNQKNlmEF15oBMCaAH0+hwNyGFGpujSEPs9MhKL8RKRiFHvE6D
	brIyGdm1K1PaGGnjdMrqoBy0V4GUpFYALpCPg==
X-Google-Smtp-Source: AGHT+IFvq5k1EuebtHjH8NtC18O9Z9IQYxbVQCJ9hJgUzNYb51sqTyvtRgLwUZEROHyWBv2AmHidhVXrKQI11wj9UYk=
X-Received: by 2002:a05:6214:5018:b0:7e6:7392:f7df with SMTP id
 6a1803df08f44-87b3a784170mr279102566d6.6.1760364194107; Mon, 13 Oct 2025
 07:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP_9mL5=GmtJF3nSbfX6gRzPc=fAMrTOfMuOLyWFwq5D4OYUFw@mail.gmail.com>
 <20251013130010.143271-1-amadeus@jmu.edu.cn>
In-Reply-To: <20251013130010.143271-1-amadeus@jmu.edu.cn>
From: Liangbin Lian <jjm2473@gmail.com>
Date: Mon, 13 Oct 2025 22:03:01 +0800
X-Gm-Features: AS18NWAoIMYqp_P27rsiPm63GVautCNYpIalpnf8xGliTTm_E7ySNqCl1fUxC1Y
Message-ID: <CAP_9mL7eaDBtVE-VUEMojG9wz34Cfa+N4Ekorj165M=_4zpPbQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de, 
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chukun Pan <amadeus@jmu.edu.cn> =E4=BA=8E2025=E5=B9=B410=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 21:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> > +&pinctrl {
> > +     gmac0 {
> > +             eth_phy0_reset_pin: eth-phy0-reset-pin {
> > +                     rockchip,pins =3D <2 RK_PD3 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> > +             };
> > +     };
>
> Leave a blank line.
>
> > +     gmac1 {
> > +             eth_phy1_reset_pin: eth-phy1-reset-pin {
> > +                     rockchip,pins =3D <2 RK_PD1 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> > +             };
> > +     };
>
> > +     gpio-leds {
> > +             status_led_pin: status-led-pin {
> > +                     rockchip,pins =3D
>
> No line break required here.
>
> > +                             <2 RK_PD7 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +     };
>
> > VBUS on usb2phy0_otg is floating, this USB port only works on
> > device (peripheral) mode.
> > phy-supply is optional, so this should be fine, right?
>
> Yes, if there is no log like this:
> supply phy not found, using dummy regulator
...

> > VBUS on usb2phy0_otg is floating, this USB port only works on
> > device (peripheral) mode.
> > phy-supply is optional, so this should be fine, right?
>
> Yes, if there is no log like this:
> supply phy not found, using dummy regulator

I have checked the log, 'supply phy not found, using dummy regulator'
not present on usb, but present on gmac.

