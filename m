Return-Path: <linux-kernel+bounces-888143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5897C39F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92F4550035B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760530DEC1;
	Thu,  6 Nov 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsKaoMtO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229A2DF145
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422605; cv=none; b=CpWZynB7T71nE8Ok6tkqYNMhaBcnVaAczqctynHamqBvxLQqq+LIJgpPT7SbpwCDFD7lUXVimk7Jmij9rT12XhSfb429lSO0jhPFQvdoJEyxDkNW7eKYGaHyVpoYyy0nS0AS4uaLejVLDuq1oaCygk5cClPBaAQUKK8dNmIS3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422605; c=relaxed/simple;
	bh=IRcPar28/4D04E4r0bzkVCy8UYUvk2JvQczEvypeUz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZIBVw2LoKdWcFdjvUrKJK6/eHyYuQYas9VSq4w1xy3kbDaI490C4zTXPijx9oCFyi71aSkd37PrKm42JiAx35wVNteslt+rrsMQ46R2SUQkmmSWxudfpTt44WgbNaaBl715byzyL74431JR8MQjqdhVuFUWt7YCR7fJlLa6dEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsKaoMtO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33be037cf73so905285a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422603; x=1763027403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuITS4kBtdrE0xOY6fuM1GNDJI0Hyov1YNBt8plbc9A=;
        b=TsKaoMtOg0Y/2ugepLzaICi1jqLe2Z+dfzFs8mxnAIQygkPv/PmPeLNoQbqFKm2AMd
         pnUc+zBHnNouz40ehoXORH1pTxTbKXvRSxcrjC93X96E3TqtswlcVfSeBjdDkriREi+H
         g5Rd/eoZ9XA4M9joSj2Mfh0/2mmOOsHZwbKYBrFvUATx1eUkXp/A4L/hA5erD/BwktNr
         M80dBqVG6INw2u/Q6oGs8KekxCPMNXQQbsOt33XOxbW6AvWZk9qyjAtOZQfnREvzAvtL
         N49t11xweXxPWojSILWKBpW7h0TdpM4FpqjXNmxuDok+sdw71uIfEZ75XldXDaVQkrM/
         ORZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422603; x=1763027403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuITS4kBtdrE0xOY6fuM1GNDJI0Hyov1YNBt8plbc9A=;
        b=IsiUjsyoYQC7mQ4VAjy1VK+rfXa+46Di8UOHXM5HSssu9xLYenvMqNucaphNwbyPyf
         ES9jiWQ6lKUmiLcvOf3UJuh7u4hl3MD5LzrdIaIXfAGmBvpv0SgYuuoXUUiqmgIyFkBU
         aNwb61ec1abt8i31vBUlPUm3IVCXe5LoqsxUCRp7Uw8ozR40UvoSWEDsWYfL4418UVMv
         Zl02wtSQqGe6ZGRbjErrIFQ723bOo4Bv5tW+Z0tnk/dpU387slpgZzneayownaQDBclB
         lKjilCsjT5X2rnqZrwWoAIWNKW35YcYA97xS72KeABwZujZRJoCscJ9ZzzUoKP/TgCu+
         9oUg==
X-Forwarded-Encrypted: i=1; AJvYcCXkTPtaNvCrOGKsyyA+fMveivpRUqxcX5kPY6zH8UcCHwUxKSfcfShbvz4Nd8W4VE4JFgHC8B+pmr7c7Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuH8OYEqEIY0+TclqpvfDeuI2WpT61m1gEcckaLIKpzJO1dgim
	Oy6n9VluT+KxhY+ZfiAXtbxAmwhcHG2f51cmIrxA6Po2R0/JZ+7bF8G2PO+8dGtHXugbide/dHz
	khgFcm+SRnviW1ceAt0FaCsFkMt1uCWc=
X-Gm-Gg: ASbGncvnNAlGxRYvj591xhGgz4DwguSWLooBsk5BwKEjp4CmXM/U58AFYdujRI1WMz3
	+i1+XIfSq3OvD9Z64VinRYbh/DQHh8LeBp0KbLLODfBjQTL8Db8U2FcmZNlKeOMeVHJ6AEvIwh0
	CfoRFhp13WAarR7SQ5H516IVVEuBwxwf/aSvxImbLeO5NnSquAWojmINEQfuemMClzkpO7ntwT1
	G9fQFwX9N9z76l2Vmb52O6/aQBiJPLEPom9XpshdsnkW+GqVrb/COb+/GoI
X-Google-Smtp-Source: AGHT+IHtTu0aItN7oCpYlQZATPWzMYAFpRwqJjPF19uAoe9o1LjA9xlu2YB532D+sdeX4rZwu4Y297vlJzwmbTz5sNU=
X-Received: by 2002:a17:90b:584d:b0:341:315:f50d with SMTP id
 98e67ed59e1d1-341a6bfb59bmr7314378a91.8.1762422603266; Thu, 06 Nov 2025
 01:50:03 -0800 (PST)
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
Date: Thu, 6 Nov 2025 17:45:27 +0800
X-Gm-Features: AWmQ_blxzccAHkkFrG_7m68qvbkNEe1KQA8jfJHjAGe25H_MIaeW4TBvjXhKUes
Message-ID: <CAAyq3Sa=7d6We2xz6bEb_x_zBv+fJwEZuSsfti+S46t3JVo7sw@mail.gmail.com>
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
>
> Here is an excerpt of the main comment at the top of the io.c file:
>
>     * As it was noted above, the VID header may start at a non-aligned
>     * offset. For example, in case of a 2KiB page NAND flash with a 512
>     * bytes sub-page, the VID header may reside at offset 1984 which is
>     * the last 64 bytes of the * last sub-page (EC header is always at
>     * offset zero).
>

Here I was considering the comment in io.c, and also the definitions in
ubi.h, which say:

 * @vid_hdr_offset: starting offset of the volume identifier header (might
 *                  be unaligned)
 * @vid_hdr_aloffset: starting offset of the VID header aligned to
 *                    @hdrs_min_io_size
 * @vid_hdr_shift: contains @vid_hdr_offset - @vid_hdr_aloffset

So, if ubi->vid_hdr_shift is non-zero, then the VID header is not located
at the beginning of the subpage. In this case, we fill 0xFF from the start
of the buffer until the actual vid_hdr_start.

If ubi->vid_hdr_shift is zero, then the VID header is already placed at
the beginning of the subpage. Then we fill 0xFF only after the header
region in the buffer.

> I am not sure this is super common today though.
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

