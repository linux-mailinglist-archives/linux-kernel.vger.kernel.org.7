Return-Path: <linux-kernel+bounces-749043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37380B14940
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3E54E2065
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231DF264FBB;
	Tue, 29 Jul 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQtPx7wV"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FC170A37;
	Tue, 29 Jul 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774700; cv=none; b=bpMvVY4QqadOd8HJyKfYfTfXzkZTijUL0OxNrtfEeRjp2iUBYOcMlexTh0IOPUputvAvvW/2KdmouSjMYEsNZe5HLwuol84mgKhpyuWLfPQmClVCRCNXpX3VSPEQvI1+I8sPw1MwJ+ZiDp3GuLVjZOJzB69WJM3bN+1iqazpSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774700; c=relaxed/simple;
	bh=+pdNgJ3ps086+n2qxORlxIfCR1VW9sQRrMkCjOdFchs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbIKFrAe2gwP9/nmVFy9r6v6ojpjIp4JFvaagCYGhG2y0Z0tMGlBp7zXmIgsHcib1ZH2feL6KiZaCjyNitmQpJwiJGlYqaWTNWDAdufe99vrsyz3TCWt6nDHA9ynHAtsQ5n48gOHB6+udMUBB4WmdfIy7qY0uiaVoNE3O+VFo0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQtPx7wV; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71a2d9d452eso756607b3.3;
        Tue, 29 Jul 2025 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753774696; x=1754379496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acUYVfZsBQi4TKg13g+WQRNIk159Vfwdi/eEl0lSNOI=;
        b=eQtPx7wVM8zH/yaHaTYkWkKqNu12WoMGySLsfUIeiEeeeIgVqMCjyrEi/BKW3PUHA8
         WgXMqzRF2NoBUGSB8W9mCD0zr6rq3zVVT+p0c425LnG0tJeYAt9ubNxASRT6rQqdFXqI
         bJH4zc/vp9HKvfb79Bqf9inw8UWFJ2mrk6hedFQm4Dbtp8d5wdpvfB13/jco/cmgfSci
         ZX9CLEklJw2ONsJrsHNVIunM/S0Wnl1Mryj2iESt850XlSYwlmodlsRSFfdCd6RwDHxq
         Se8sbJNGbjlnHiINW3vXLcoSUrf2HIrA6+dnhXen0tHez+GOpowgVmM8jkUa3e4zTDhr
         Qrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753774696; x=1754379496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acUYVfZsBQi4TKg13g+WQRNIk159Vfwdi/eEl0lSNOI=;
        b=cEIGq4fFTNi42n7TVCcnMp4VxkNTNiP8A1JXHoljU0PnokOr5rUCdgqpfSFbnm7XWK
         gOwGL5QI98Ws+QIIxXkKPotJK35gy9vsoBKF9NOADHP6bWCGDRIL98VmPJeGmoiqfXgT
         x8ECM9wCNg3UCz6Ku2hFgvDoa/G99alnpEcAiH5omLyuZfasg86XKgJ5+2YW8BQZOFlN
         4jq0o62+XVjyKHssFaWhf/ZpJfCKx3I+AigWAWKSEnzwTfBEgrG9SxamOwToghPIunL9
         JYIcEbPTEjRfyvjG78Qrq/PdJp9rIPR1M2M02jqgvZg7KOxaZSq4Kiw5KDe+o7KHOIQX
         hN3A==
X-Forwarded-Encrypted: i=1; AJvYcCW+zkR1456sLjbj05CGTcqKoaibWP5FcdddPEHxCFvPAOr5VAJlf+Lo6TWhQZdUkQGZtohk5UZ+KXuRcco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKcACo6QxmNbLQAtFrzf6+3MUl/A2EYNXPsTfvVE5xhY9KwLde
	bt9eX1J6WXBLjnovvq/HKpR3lPe8Bvfna9JiFGFTj7XMJoqpbqAsGt1jvn8IArt05OOqDPyjZfS
	lBcd0+LMxy6/xkwIWFE+EVt61x3+a4jo=
X-Gm-Gg: ASbGncuEbYVbMhLICi48yck6StMW3Sc7jI6w6lDpmJxUDctavWPMhCGuTf0zoBhchgC
	ylIaot60iJQPhcQm21ELDEjApB9Kk6/NF8eIh9Gr3GZRMdz6lWg/A/dhnywgyB1F3eSf7BacOoJ
	2yCgmeXkIA8SqeDdTwx9h5f1pHwY3AV3r6oub6Cv0ki/uBO+HEka2Ew77+qOxBGI+9Qtwd8isJi
	LIoiA==
X-Google-Smtp-Source: AGHT+IHNx158p5O3L8xyKfGxS3YBga//P9XngZrZyAqoB9erR4Y7MkgJWYCG2EedBNOsM+B2pnlcNDaALI/Pa4st60s=
X-Received: by 2002:a05:690c:6713:b0:71a:2961:e2ce with SMTP id
 00721157ae682-71a2961e4d7mr33604967b3.0.1753774695874; Tue, 29 Jul 2025
 00:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724074539.37650-1-miguelgarciaroman8@gmail.com> <b925480c-231b-44e5-bf1c-1f18f8abe42d@kernel.org>
In-Reply-To: <b925480c-231b-44e5-bf1c-1f18f8abe42d@kernel.org>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Tue, 29 Jul 2025 09:38:04 +0200
X-Gm-Features: Ac12FXzPovSTUnOLpcjhMNjYqHwEC9VrSdVnikkVxD8cazyoJuPibEf-UzgY-KI
Message-ID: <CABKbRoL4_rDZeTToaZn+Pug47pGB31ErvPR3C3uaspgnd=3Zww@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: surfacepro3_button: replace deprecated
 strcpy() with strscpy()
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yu.c.chen@intel.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	luzmaximilian@gmail.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

thanks for the review. You were right about sizeof(name) being the pointer =
size.
I=E2=80=99ve sent v3 bounding with MAX_ACPI_DEVICE_NAME_LEN. Compile-tested=
 only (x86_64
defconfig/allmodconfig, W=3D1); no Surface hardware. Apologies for the nois=
e.

Best regards,

El lun, 28 jul 2025 a las 7:30, Krzysztof Kozlowski
(<krzk@kernel.org>) escribi=C3=B3:
>
> On 24/07/2025 09:45, Miguel Garc=C3=ADa wrote:
> > strcpy() is deprecated for NUL-terminated strings. Replace it with
> > strscpy() to guarantee NUL-termination. 'name' is a fixed-size local
> > buffer.
> >
> > Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
> > ---
> >  drivers/platform/surface/surfacepro3_button.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/pl=
atform/surface/surfacepro3_button.c
> > index 2755601f979c..9616548283a1 100644
> > --- a/drivers/platform/surface/surfacepro3_button.c
> > +++ b/drivers/platform/surface/surfacepro3_button.c
> > @@ -211,7 +211,7 @@ static int surface_button_add(struct acpi_device *d=
evice)
> >       }
> >
> >       name =3D acpi_device_name(device);
> > -     strcpy(name, SURFACE_BUTTON_DEVICE_NAME);
> > +     strscpy(name, SURFACE_BUTTON_DEVICE_NAME, sizeof(name));
>
>
> Why are you copying four/eight characters if the string is around 16?
>
> How did you test it (and I doubt you did since you change multiple
> different files from different architectures)?
>
>
> Best regards,
> Krzysztof

