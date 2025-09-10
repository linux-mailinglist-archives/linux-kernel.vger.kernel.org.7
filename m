Return-Path: <linux-kernel+bounces-810374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC78B5196A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D316442600
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997532A3D3;
	Wed, 10 Sep 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLtvWNit"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47830F93E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514684; cv=none; b=B6iHlXy1e+A0BulbViH+HmdixO1B67+AIN2ekoHCXkgrYF/ga9i0MA7or1QFiWYZoNXqW5zPK0XANr5O7pvjF6q74gMabKEc1xIqGJw1u1Yok3kS7PoTVoAHWXO7dLcTooIOLwKBawDQmK0hxpHR8gna+X0Y+V93LVaOI7R7GVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514684; c=relaxed/simple;
	bh=S0PYbj7oVlC0tHMdjUS9fcyQ3ust6fizX8gkLiKSPKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqXhpee6Fx0jxaWfYcdS6F9pJXzp3EQRmvl5H1Xqz2RTUPP1om4HzxzRZ7JKHgcAeXXf062VOiViHHbVON6KYnwj9QrbO3YhzXM6AcOQ52lmvbiGhZstjuDtn5uf86DUGSHOSQE66R0BCwN/PH/GS/fEB7DZtVk/Ty82UnJF3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLtvWNit; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so11418a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757514681; x=1758119481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBHjh07xVgerT1Ryn1zxmezBGqdr9sptWQnsNWqHz8E=;
        b=iLtvWNitbg5dq5zTPcRVkIHdw5H2ObXf5kDRqmR2S1oO9t/MiNSVHyMFIALn/aqK0r
         mlNJnVPstp7bTS+EoLVvX/v1Encf7sQf+y9UTwg58tsHgaUsj+JchSQnDG1jW3DF5jJo
         +JtswBWmWAXsrnta22S4BTYBV1IWf3edYe7YxRsTItNSs1Kuju2fXEEy83lt8LiePbqe
         PrYZVkDjMI14pqxN3NSiixU0S5rf5/vvcUPfNIg66SeeO4kcgdGLFkI9NzQNCOJiAI4Q
         K3pug+M9vLEv12T/WfkkqRnRqnq4Njfw8IMEwVrLj160t2xiDduOr54wvCF9YQVSsan7
         rFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514681; x=1758119481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBHjh07xVgerT1Ryn1zxmezBGqdr9sptWQnsNWqHz8E=;
        b=vFXaRzG2VEIRM6eMcAo7X8cNKNJm8yx+OLD3NyovcPc/0sYQm6yh3d/Ob5xHI5mA7m
         ByPagDUEIIeV7rOvCVjJwa6buO6z8NcXcn2HJXr2JOc8xJ9fRchQflkt4KvFebvTbxjS
         6PvzcwDkAVpc8ULhOVYD0S25Z1QrFDBJsRyojemODv6iA4y5cnBcmfqnbxAwQEbugWM0
         hfa14Pzm3pJwcEEkBOA8xb6wRaGb5Bu1rKhaN/xjX5u4eqLH0NYnRqhmEUO9yVJpSILJ
         nuTdhqWrF51zDfkKIfqvGyZYO/4v9MVFb2h047P6kutj01XSZL8BcQhSxrO/CHNi5uPZ
         2IHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiCy7gDw5uaQcMRKwkFWQkI8A5MVZTHe1t3Wo0WoDgY9doQAkXdXV+s/W5Wg4HovgTWNxioP+XU032oHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyofZSa4AGkGloKMdGvVc2nMm1W1BkEg+zpMtKEuKHEWpM3tK20
	eC+3tuKs71ZTR0zo1Ot66xvz8mbM9LHfj8GR5Q1hJCGNtwd/odeuk3HUG75WLQoESNMhuoN1vXR
	S578s+RUiTwDYjWUhqnBBWmeTfj8uqpcCCqZEroVT
X-Gm-Gg: ASbGnctXLRBY4UHccYBNrZlne35lrJXc327+sOPaDO7Jj94uWEhmWiGa0VLNPKRg17K
	L5jtbSHARHse5rc2QEbQX3fxq772gqKB039CcYc/i8vRfUTcBqdF8/RpYI0eGhy6GMC81nx9wpi
	pcweATOLtypg+sc4DLY8vf+L9tn+c1+2S0NV7QAxQZ4wfqFm04srz1EbnGzZf25Vm2GHOce6PEt
	aDnOSWRYSeThqvK7+BGig3pryCyr6Bvo0VZznCdcLyxan3S0Onq
X-Google-Smtp-Source: AGHT+IGRjXQUY1hnYAWcdMxN/6KyD3xPZ0pQZ40M0o4vqF3cIQJ4GOYF46WvRJzio4N+Z7uVd9rvPLKsmTPmZkGoMyo=
X-Received: by 2002:a05:6402:2185:b0:61c:c9e3:18f9 with SMTP id
 4fb4d7f45d1cf-62d4e0f68eamr87423a12.3.1757514680889; Wed, 10 Sep 2025
 07:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910103355.629421-1-czapiga@google.com> <87frcucy3p.fsf@bootlin.com>
In-Reply-To: <87frcucy3p.fsf@bootlin.com>
From: "Jakub \"Kuba\" Czapiga" <czapiga@google.com>
Date: Wed, 10 Sep 2025 16:30:43 +0200
X-Gm-Features: AS18NWBTtKhP8XqCorujp7PIPt_ibCOebdea57KS6V9p1MfFOBrohUfAAkZewTE
Message-ID: <CABkukdpRxHFg9FbaV1GnS5UG3-ZxdxPbjKYdUpdmvOcLs5phKA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: core: Check read CR support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Adamczyk <konrada@google.com>, 
	Adeel Arshad <adeel.arshad@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miqu=C3=A8l,

On Wed, Sep 10, 2025 at 2:05=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Jakub,
>
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index ac4b960101cc..79deee3a50d3 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2608,6 +2608,10 @@ static int spi_nor_setup(struct spi_nor *nor,
> >               }
> >       }
> >
> > +     /* Some SPI controllers might not support CR read opcode. */
> > +     if (spi_nor_read_cr(nor, nor->bouncebuf) =3D=3D -EOPNOTSUPP)
>
> There is a spi_nor_spimem_check_op() helper which might be better suited
> for this purpose?

spi_nor_spimem_check_op() works only for spi-mem devices. spi_nor_read_cr()
handles both spi-mem and spi-nor controller. Using spi_nor_spimem_check_op(=
)
would require adding a variation of spi_nor_read_cr() that would use
spi_nor_spimem_check_op() for spi-mem and spi_nor_controller_ops_read_reg()
for spi-nor controller.
Another way would be to do this check only for the spi-mem as spi-nor
controllers seem to be deprecated in favour of spi-mem.

Thanks,
Jakub

