Return-Path: <linux-kernel+bounces-879480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D196C23368
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A963ABF94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5292857F0;
	Fri, 31 Oct 2025 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwTB+qTV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6528466D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882738; cv=none; b=PMRt3H4PJp2ZY9ObK8q642PZa/T/t/X/3NWbZuJB9HeiE9JfO63qiyfBvmlOsMADUwBhcHeD6P6ZUSaHDzaahTr+JqfqKhTd6VqyJksOS/9NZ51GiQHxXBfSOnpT+J0fZ7pv0eCPGtMqNPQcmNn8VupIF3O4BOFtsYBJCou/ngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882738; c=relaxed/simple;
	bh=tpBH4WqLZ/UhvLppO8BpS9NvMHSs57XS4kkO0So3Joc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVrVO1Q47RqBNyyed2YmwSXjqzlopiFI1fg69E2vGnNBrwQ+7Jr8huAYEoy8kF67u7uar6S+mACLe++QvUB4d8chXmKl50KAPX6boYsR5IWMdF6Fxxe20S2WN9TbRcSiQ1skggVwWB77cR6CFG7JR74kS76hyE0Ofg1wROl8Jck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwTB+qTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761882734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T33GakBQ5UDJA1Jm0FIA4c9NYfmlY9OCvzmbavseX0g=;
	b=MwTB+qTVyT/uFE9S9aALqemBD6yJEW/JPFKlWtZvLGdF0IUMA2xoWMJMgkBZJpYzn4Zrge
	5nxXsZnp7exlJi2SwcEZJsQqe1Rfd9UDTtroho8CahAt42CulLBdkmLIbp+IwJ4Sw+Ng7U
	XYwC5c18mnvWr3t26Azy/5UKpXEAFaA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-UAe_Q7qGOHqwFIiJ1rJ60A-1; Thu, 30 Oct 2025 23:52:13 -0400
X-MC-Unique: UAe_Q7qGOHqwFIiJ1rJ60A-1
X-Mimecast-MFC-AGG-ID: UAe_Q7qGOHqwFIiJ1rJ60A_1761882733
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94109728fadso221359239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761882732; x=1762487532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T33GakBQ5UDJA1Jm0FIA4c9NYfmlY9OCvzmbavseX0g=;
        b=Uwd4o6JBfOI5Q9bZCtjcc/gCPYpJ8HljBFP+0V9NFJilsjM5Pe71vm9KA5sAAAOXGM
         QKDfI4jYeWqYxNf5swQ0O/aHsAycfzbZcTLcYoaZ28csd8PGzjDFNxCJM27nWFoNuMLn
         MIqYxURRuxED/a4qCQslEy6Lrpc8JStvjOxMXuSc1ZMqHSNIufHKTibcjC80HASsZ/Lq
         /c59CAPD2UVZo2q0i+MJuDxWSHjUg16JaTaY9Rks2Tb2Bj5+QcNr69hSMc2nayYOf3IG
         0x2wLe42Ely8UCnDYE2Prko74lgi8kFB6bgP+cWWHg51xhmnO35zvI2yVbG+4p2HBUPC
         2fdg==
X-Gm-Message-State: AOJu0YwXf52xwX+LtukKwx1TvhsJOOdWgrAzcqSQD3f7iZAsabBvoEgJ
	cAgNP60aaTRWyi7ti7BJ/vYmLoc3R8OV8GglhnAjcr+5up9jiNIJYUGCJRPss4jNWU47uGWvkw+
	oeyRhxSlCs/cz9Yp+rPcJeJclSKhbwI9JC3PPLWKMxCsiIUWKYh72b5Fc8tctQk3gpiicY8oNN6
	tOvciBozNf5NRai6ISjOZasgrk3rDGknTenuZTbeWu16ZdcXZ3l6c=
X-Gm-Gg: ASbGncv0LmWGhAV4B00hPNeBy1kt1D7xuZnqBIJ5yY27vXZC48bpvVkzLTHQiwcuBoi
	l6SF+dEFFYdOghXvsTIVM2TMp2zyZ2bNKsdPCuZA38C9VVop1jrgfDNz6sT4ezuNf42qy5+wp0V
	uVzy5pESfW94U6V8D4VKs5oap4olly/W8Q/qPT9P3TmgG5Yv+KmlYnyJ51T88+m3BzY4mftiOLu
	A33vdo3EgrRbUbE
X-Received: by 2002:a05:6e02:168d:b0:430:a38c:b767 with SMTP id e9e14a558f8ab-4330d2074e9mr39276775ab.18.1761882732341;
        Thu, 30 Oct 2025 20:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM0mguF4E4vj4qqamw49fFeKIMF7ghlly4N+TPPxD9oj784mjEzmTSyeiNt+w4nDbflu/q+bm0ewx97PFavBU=
X-Received: by 2002:a05:6e02:168d:b0:430:a38c:b767 with SMTP id
 e9e14a558f8ab-4330d2074e9mr39276565ab.18.1761882731977; Thu, 30 Oct 2025
 20:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030214833.44904-1-desnesn@redhat.com> <b2ec533d-9f87-4d65-a20f-99488ffe56e9@rowland.harvard.edu>
In-Reply-To: <b2ec533d-9f87-4d65-a20f-99488ffe56e9@rowland.harvard.edu>
From: Desnes Nunes <desnesn@redhat.com>
Date: Fri, 31 Oct 2025 00:52:00 -0300
X-Gm-Features: AWmQ_bl1Y_eJoHIkPYXYYbP9d2aBucY5Y0A17DvuLdmMVlIYjUWj86ahJqMQHyU
Message-ID: <CACaw+ex5xpE8H6GMTc6gSQZ2iASkkw1CAe1ATOx9BCzenP39fg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: storage: Fix memory leak in USB bulk transport
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Thu, Oct 30, 2025 at 10:48=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Thu, Oct 30, 2025 at 06:48:33PM -0300, Desnes Nunes wrote:
> > A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
> > Test Project (LTP). The following bytes were mainly observed: 0x5342535=
5.
> >
> > When USB storage devices incorrectly skip the data phase with status da=
ta,
> > the code extracts/validates the CSW from the sg buffer, but fails to cl=
ear
> > it afterwards. This leaves status protocol data in srb's transfer buffe=
r,
> > such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this =
can
> > lead to USB protocols leaks to user space through SCSI generic (/dev/sg=
*)
> > interfaces, such as the one seen here when the LTP test requested 512 K=
iB.
> >
> > Fix the leak by zeroing the CSW data in srb's transfer buffer immediate=
ly
> > after the validation of devices that skip data phase.
> >
> > Note: Differently from CVE-2018-1000204, which fixed a big leak by zero=
-
> > ing pages at allocation time, this leak occurs after allocation, when U=
SB
> > protocol data is written to already-allocated sg pages.
> >
> > v2: Use the same code style found on usb_stor_Bulk_transport()
>
> Minor nit: The version information is supposed to go below the "---"
> line.  It's not really part of the patch; when people in the future see
> this patch in the git history, they won't care how many previous
> versions it went through or what the changes were.

Noted and thanks for letting me know!

> > Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_in=
direct()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > ---
> >  drivers/usb/storage/transport.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/tran=
sport.c
> > index 1aa1bd26c81f..ee6b89f7f9ac 100644
> > --- a/drivers/usb/storage/transport.c
> > +++ b/drivers/usb/storage/transport.c
> > @@ -1200,7 +1200,19 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *sr=
b, struct us_data *us)
> >                                               US_BULK_CS_WRAP_LEN &&
> >                                       bcs->Signature =3D=3D
> >                                               cpu_to_le32(US_BULK_CS_SI=
GN)) {
> > +                             unsigned char buf[US_BULK_CS_WRAP_LEN];
> > +
> > +                             sg =3D NULL;
> > +                             offset =3D 0;
> > +                             memset(buf, 0, US_BULK_CS_WRAP_LEN);
> >                               usb_stor_dbg(us, "Device skipped data pha=
se\n");
>
> Another nit: Logically the comment belongs before the three new lines,
> because it notes that there was a problem whereas the new lines are part
> of the scheme to then mitigate the problem.  It might also be worthwhile
> to add a comment explaining the reason for overwriting the CSW data,
> namely, to avoid leaking protocol information to userspace.  This point
> is not immediately obvious.

Agree that it makes more sense to move the dbg comment before the declarati=
ons.
Also concur that a comment about the fix of this leak is good to have
in the code.

> > +
> > +                             if (usb_stor_access_xfer_buf(buf,
> > +                                             US_BULK_CS_WRAP_LEN, srb,=
 &sg,
> > +                                             &offset, TO_XFER_BUF) !=
=3D
> > +                                                     US_BULK_CS_WRAP_L=
EN)
>
> Yet another nit: Don't people recommend using sizeof(buf) instead of
> US_BULK_CS_WRAP_LEN in places like these?  Particularly in memset()?

I wanted to make clear the size I was zeroing it, but it is literally
a few lines above. Will change it to sizeof(buf).

>
> > +                                     usb_stor_dbg(us, "Failed to clear=
 CSW data\n");
> > +
> >                               scsi_set_resid(srb, transfer_length);
> >                               goto skipped_data_phase;
> >                       }
>
> Regardless of the nits:
>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
>
> Alan Stern

v3 under the '---' is a charm!

Thanks for the review Alan.

Desnes Nunes


