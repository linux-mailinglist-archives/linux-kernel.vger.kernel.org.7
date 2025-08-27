Return-Path: <linux-kernel+bounces-788572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D437B38696
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B8E16488A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72572797B8;
	Wed, 27 Aug 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFijeEQ6"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A9277803
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308402; cv=none; b=X1hVG3IeWfRy2HmDu1JhiGjW5/UyX7nv7FBckFPdtPIa6Eyn0wUte242buJ0qhmhQl928Mg1jr3Qy8R6XIQAfpmGrPzXQuV7Y/d08O3SG6TX3JVYhAHFAkXZMhCTa/PexD3/pAuSw0nZxc0z0qzjigKkZU1tGoZVS9HLQUkatsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308402; c=relaxed/simple;
	bh=VKuuQQCW9goFCxDxyheaqk7T10+zbATvmX6hEvwyK0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnJ9uZ/QgvbaW1pFKhS1mIfTXO38mMi0gpL3Q3NDXPa+i5DAwfGBOtjJKUBP+QBVebIpz9lULz7oBeaNrafWVfU+C6wAIktGUV7yxxJJi/vdJpJBSEH5jRb3YKqXs+848MZy6MiJEAay0yVebTL7hz5UnE72Yo8CtkS0dUBXZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TFijeEQ6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7720c9e2900so9304b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756308397; x=1756913197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLrh1j2iqdsWB2lnt1a0koxPADVPet1wRoykvV46kQs=;
        b=TFijeEQ6D81atglXdWXJLn+u039VUAm2sNZ/WisrNInknqFBPtwMtEYq+V0q5KAbNT
         2QcKK6GV8hR6L72e30p0EzW0HwQ5JShzDQYKHXsw+Q2lh4qDJg251oNAAdmp98+V9pS2
         LvX3wMj/Ub8fs1b8c25kiuKCbvQ4DYJHEx3l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308397; x=1756913197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLrh1j2iqdsWB2lnt1a0koxPADVPet1wRoykvV46kQs=;
        b=EamJ0g3AMa2ZG5Gpk43fxyZGhQfEsDvh60wHAPB54ANdRaFBIVM6Ce8ANa1ozt5XYG
         BuqdTuFC07UToBo4qqyvFrRl2DI9Z1MJiZijRqviiaa27eM6dPrbhMvMncTcLBWhFCAB
         Jji5m+KGLupJjcndgbaOCkQ6AbTOBMNW/BDgDN5AkEsqRRn0H+T3i/OajGulcj/Yk8TT
         +HiEuYZC9WauIaS0r74M5yxyUQxKbHcbLUUwVajDKajtY1uhX/Nn6cj8vKWVTL+bMjk3
         9qIlk0ZwxD/4FJ/w44O5g+pfErrE5DXX+lTyhPi/IAd9Pp4v3XPIDId/i4sgmYiJkg+W
         1g0w==
X-Forwarded-Encrypted: i=1; AJvYcCWyW2yfHX02lzV2gWxKnyrx1/+qrJhMr3ldi+XUUjxVuHmp5BvGYu8veiM8zOt5u78GX+nl1aaF7iO84Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxKjGpXWG/kStPJKhvkyDesVJabO1Hj2sllR8iyXJIsg7TiS2
	k8K4JAAw2DajoXtTBkyI6Yn1Ma9d98xqGotxrp59pEAKqupfykdBfVzLiaFgAVPvxGrkUywZyTw
	d/vQ=
X-Gm-Gg: ASbGnctXyo56UPD7UKhvjAZKnoiawsbKIQxX1D49FXmcax588DcqayhBFnvr/T2gfWj
	CrUjjMkR1LqflHHk40N/E36iBHDHH/7x1UJmTBN3Icln3esyRUvkbIDSlZzQe/zs/3/rTw4Gtp9
	YIWIk3LaIBFVRDD8QTfztcVFK+chHPtJrH0Jvgqm7vtYjHz64EGWRX/agqsnZxVdn1guAv+bCFp
	MMRbaDWaW9++PxjqTSMNcWav7cfulfH0AKfQJl21Ws8I7eQ2RWGHghIFghVZVXQ+ut8pJYP621g
	J/bNLwzcEiPakDr6Ty/5z1v79VUBLqCq7i6VO3y0utoOFzcbdXzpWLnzmDw9e7CE9IGvqBrRdrp
	B9nyJVRcOFAr7hFZVEFIZWwpwH62BSvGIhhXUswSLunQlg6ZT/7N+vChzlo/QbPA1xQ==
X-Google-Smtp-Source: AGHT+IFl/GhG3DlbIAuC55AnYTRo1CuAgr4lN+no+VFXkAsxGy4zbb+fhdXpDD8h+rFA4/jLvo6QKg==
X-Received: by 2002:a05:6a00:1746:b0:772:101f:5e46 with SMTP id d2e1a72fcca58-772101f7245mr1501964b3a.12.1756308396657;
        Wed, 27 Aug 2025 08:26:36 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e912e40csm7814342b3a.44.2025.08.27.08.26.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 08:26:34 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24646202152so55225935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:26:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+IjyUgL6dOw7FV51rucYsIsVhDvJi4ggDiQeETJOXNZGlw7EhlJRlfIwriVh9asrqEHWVAWaOcY3jOkI=@vger.kernel.org
X-Received: by 2002:a17:903:22c3:b0:246:61c:a67b with SMTP id
 d9443c01a7336-2462efc84a4mr257613985ad.58.1756308393826; Wed, 27 Aug 2025
 08:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aK8Au3CgZSTvfEJ6@stanley.mountain>
In-Reply-To: <aK8Au3CgZSTvfEJ6@stanley.mountain>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 27 Aug 2025 08:26:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEQf=PX52Uv_bjzhnUipKwcNY+BBTOfDHucv=EkBTzgg@mail.gmail.com>
X-Gm-Features: Ac12FXyOqAsTB-Ef0CSpdX5fkDPZp5ZPV2zuiCMnpU52NE9UK-HvdLXDXVbdv14
Message-ID: <CAD=FV=WEQf=PX52Uv_bjzhnUipKwcNY+BBTOfDHucv=EkBTzgg@mail.gmail.com>
Subject: Re: [PATCH next] HID: i2c-hid: Fix test in i2c_hid_core_register_panel_follower()
To: Dan Carpenter <dan.carpenter@linaro.org>, Jiri Kosina <jikos@kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, Wentao Guan <guanwentao@uniontech.com>, 
	=?UTF-8?Q?Bart=C5=82omiej_Mary=C5=84czak?= <marynczakbartlomiej@gmail.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kenny Levinsen <kl@kl.wtf>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 27, 2025 at 5:57=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Bitwise AND was intended instead of OR.  With the current code the
> condition is always true.
>
> Fixes: cbdd16b818ee ("HID: i2c-hid: Make elan touch controllers power on =
after panel is enabled")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org

Jiri / Benjamin: if one of you can give this a quick Ack then I'll
throw it into drm-misc-next with the patch it's fixing.

-Doug

