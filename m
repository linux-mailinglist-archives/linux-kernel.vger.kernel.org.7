Return-Path: <linux-kernel+bounces-889831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23518C3EA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5FF94E6EF7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86B2D4B68;
	Fri,  7 Nov 2025 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdQfgmqC"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808326FA6E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497351; cv=none; b=LMf/ylKkxrJsDSmCgvGFcka7zmGbYILjLgEE0us35rRgTDO8L6hYOd94hZcrUm7MJQ0Uc2vMhrJErUaQXir94ivIpl1XX08FKbXEwZfoPeFq+xmS5PXX+w2Mr0krIqh6w89PLD2odGiRtbsZqpBF9inwIsaMihK3LAM0+ehMcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497351; c=relaxed/simple;
	bh=ezkWKDEnzaSPdwISfdaaU281kYN3oUxiNHfWEJGMZKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVkaVhMpaTN51SpYm2R9mic/lVuO1cOqwbsqJxGYBi8k0v3o43wZ95UyR6qilD996Py7wBpP+Cze/OVOYminVq6pLeyonU9kBIGSGPC910Dqob7oBhyg5/gTTvpkJ/QT2wtj4eE7b24JonSN+jZZ/OsgeS6od9QE0y/5dsOzWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdQfgmqC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b556284db11so350927a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 22:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762497349; x=1763102149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUsFzqUXQZz1n2RuQCKkvAwHBLrARb82AaIwq1mZYBk=;
        b=OdQfgmqCmCmD2x69/2hMwXdX3JXgvsbADfmroJeuWgSc5YMoCBroV6Nql/7plpTZl1
         /qgS0FlOiLoePbDEcWFPNFlFM1FiCYNf+DL1oJ8DLRR0FDmhz9KC2JFxpWqwgVcPw4bS
         YbuWUt/jdn0p2IEjOYJxmWnOhyIz/Fb4/nM40OmYQi2BhdmHqg8ZLladGEqu1Iu0HVf4
         Q3Cr1mZUR4/AenrYpyuW0Cj7znAC4m+zLG/OINgFCiTbwdfg5Dbmc6TG7OoEhAgDnZ3d
         tgD5JKcnembrbUYckW1grYjp34YjhGFbtNKlndRF9b0qxJVktnF15omI5qVJlsOiCo0P
         rGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762497349; x=1763102149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUsFzqUXQZz1n2RuQCKkvAwHBLrARb82AaIwq1mZYBk=;
        b=ZAccEimCazhT2YDL+LzE4nnos5RZ3MvaMdvQ/P8K58BWziZ6fLDPOp6ALZr2dfXUKv
         zPL11XJj9ZPyAtNjdPZ8GJOffLAQhabZtQQSrxfowqad5pALU8ikMpWSDkIwGoEi1QYN
         FKR0HaND9TNAHDZjYFnZkHMLWQU6RtE52M2KeJSiW+8KaengzLI26SSQMI9mkj9ZrzyR
         qwXsqkxcUla+8IwTAfO4M34YPp4Zh0Y7MQ5V2MgxT+U5cZiLSx0aCyIMZ/UBRE97EyqW
         OPmKnOwVlcr0AsYVHb11pbL/zIiDZgO/rru2rwtOul7yJh7UhoapdeVOlIE6hzaSSTNi
         xIPw==
X-Forwarded-Encrypted: i=1; AJvYcCWP/dAfUCO+pQ4sRZoars2NTM0kfkjkq7XWW8B+oSYwogts55CGcP1KkT+61yXgI2MyEjSqHXTcZxE1YYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPb7RcenO4NqNET9pobjQD0Z5IOSz9QRmFVNmbcsAlUSq1LV+
	llC9n2R8tD3uS6OlVLMhtLeo9njyok2JQnhkUhro17YNb1QZ/7KiwP21KYk9h0t13dq+LFhZ7KD
	UTibUPfHsUYOnfBlijvWK8DahiS6ziw8=
X-Gm-Gg: ASbGncuM7Oj/PxpTKwAAonbtHfwFJSCpIHTfoYE2E6LoAm7b2zTjS3Jn8RhCw2zdIVq
	w2CsqzwvxTCke2FbE/CvbL2VGjrYTOLkljWoFWt2wrrCJPrzE0OiHPVYhzb573fWJr4wktIjNh6
	Q1kPxmXhlxBRXnGLDZ+ie2uPqwHy79fwUzVD6qC0Z7WXzKVKmSxNM0TJz5ftj9cqwhapVICC6Fz
	0mgHiHpVXESJQeTfi9Ik8Hve7oEdhmq5TCqDXapFlNEmckK8h+pRGtd9GH+emqqcoieRgI=
X-Google-Smtp-Source: AGHT+IHD2sHQ2JhFDIByYNzUhLLxTgE7g7W06cDQM3CbAV75SFpIeVUjbC/8/8que3hL5Hq3pg8yZ5zHUKC4nw41vng=
X-Received: by 2002:a17:903:3888:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-297c046688fmr31835145ad.45.1762497349496; Thu, 06 Nov 2025
 22:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106054940.2728641-1-linchengming884@gmail.com>
 <20251106054940.2728641-2-linchengming884@gmail.com> <87o6pf8r24.fsf@bootlin.com>
In-Reply-To: <87o6pf8r24.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 7 Nov 2025 14:31:12 +0800
X-Gm-Features: AWmQ_bnGg-3AHA9qjsaSFvGn8ogxToPDDBGmH9VNNkzQziibC95PuHQBA82OM_4
Message-ID: <CAAyq3Sb8-FRC+bZt_bEvOdBNVSN4xa5F_TpBbKF__HzhVPEpTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mtd: ubi: skip programming unused bits in ubi headers
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, chengzhihao1@huawei.com, vigneshr@ti.com, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=
=886=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:10=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hello,
>
> On 06/11/2025 at 13:49:40 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > This patch prevents unnecessary programming of bits in ec_hdr and
> > vid_hdr that are not used or read during normal UBI operation. These
> > unused bits are typcially already set to 1 in erased flash and do not
> > need to be explicitly programmed to 0 if they are not used.
> >
> > Programming such unused areas offers no functional benefit and may
> > result in unnecessary flash wear, reducing the overall lifetime of the
> > device. By skipping these writes, we preserve the flash state as much a=
s
> > possible and minimize wear caused by redundant operations.
> >
> > This change ensures that only necessary fields are written when prepari=
ng
> > UBI headers, improving flash efficiency without affecting functionality=
.
> >
> > Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
> > that continuous program/erase cycling with a high percentage of '0' bit=
s
> > in the data pattern can accelerate block endurance degradation.
> > This further supports avoiding large 0x00 patterns.
> >
> > Link: https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/d=
atasheet/201910/DST_TC58NVG1S3HTA00-TDE_EN_31442.pdf
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> Thanks for this very clear and detailed commit log, as well as for the
> well written cover letter. I am personally fine with the overall idea of
> clearing these unused bits to 1. Yet, I have one concern regarding the
> implementation, please see below.
>
> > ---
> >  drivers/mtd/ubi/io.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> > index a4999bce4..c21242a14 100644
> > --- a/drivers/mtd/ubi/io.c
> > +++ b/drivers/mtd/ubi/io.c
> > @@ -868,6 +868,8 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int=
 pnum,
> >               return -EROFS;
> >       }
> >
> > +     memset((char *)ec_hdr + UBI_EC_HDR_SIZE, 0xFF, ubi->ec_hdr_alsize=
 - UBI_EC_HDR_SIZE);
> > +
> >       err =3D ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
> >       return err;
> >  }
> > @@ -1150,6 +1152,11 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi,=
 int pnum,
> >               return -EROFS;
> >       }
> >
> > +     if (ubi->vid_hdr_shift)
> > +             memset((char *)p, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HDR=
_SIZE);
> > +     else
> > +             memset((char *)p + UBI_VID_HDR_SIZE, 0xFF, ubi->vid_hdr_a=
lsize - UBI_VID_HDR_SIZE);
>
> Here I am reaching the limits of my UBI knowledge, so I would prefer
> Richard to (in)validate what I am saying, but AFAIU, the VID header can
> be literally anywhere in the page, not just at the start or end of a
> subpage, so in the vid_hdr_shift I would expect some extra maths to
> happen, no?

I understand your point now. If the VID header is not guaranteed to be
at the start or end of a subpage, then yes, my current logic needs to be
reworked to cover that case.

>
> Here is an excerpt of the main comment at the top of the io.c file:
>
>     * As it was noted above, the VID header may start at a non-aligned
>     * offset. For example, in case of a 2KiB page NAND flash with a 512
>     * bytes sub-page, the VID header may reside at offset 1984 which is
>     * the last 64 bytes of the * last sub-page (EC header is always at
>     * offset zero).
>
> I am not sure this is super common today though.
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

