Return-Path: <linux-kernel+bounces-877362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB745C1DEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2BE3BDDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA011F2382;
	Thu, 30 Oct 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oehb50WV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DB17C77
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784792; cv=none; b=gxRUI8YFONf5GEURBn6PnCd0zbCz2xRPxQG/kYFmnZ7O/tuut21d/VJ3lz63z+q8fqpXLO9QaNLZP/SE1vDpAsFuY8VHGao0AxDa/AhX4tTx1V1A5GquwbjgU7jfq3B2NVs0BpTX7deK3NoObyew69zZleRjeKD/A+g5XoYF8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784792; c=relaxed/simple;
	bh=6dvBL4ln37XXNOifIg0lpLo3XkJnoDlD+jAwRbpHOuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPYGkJwUVU9XBC1lRnYj6tCbH46eDJ81tkjIsXIkuNwosy7HN8qMDWtwiLwHLOxYp7Fnmvq7p/uxcFG3pfpSonWNCT72tXIldoTMTZ2mpfC2eaEhBNO4rPPimgDVF1WiY8dNoBt5Rjw3bIe7w0BnKJpDgAeBCzNMuRssFoWZwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oehb50WV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761784789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nX0BIiaQfSTcEd1h6gY2WbycIasz+1vd3uK7BbssLMw=;
	b=Oehb50WV8kVnDc1772o4n0rDdOAbnFGpHmqmTAT4sY6D2vaydeoOScFXfZVnwImBfQu+38
	+or9yHPrqRTmRrPbzX+meWn3r+WU/GMXNKVwn+s/IHAinev6dhj7COXBhYoajIJUyoHok0
	7EmAM8UFKA+IbLh83pRUeG2fqIn4jMI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-SifCjRtdMv-G2V9TBBGA6g-1; Wed, 29 Oct 2025 20:39:48 -0400
X-MC-Unique: SifCjRtdMv-G2V9TBBGA6g-1
X-Mimecast-MFC-AGG-ID: SifCjRtdMv-G2V9TBBGA6g_1761784787
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940d395fd10so156495439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784787; x=1762389587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX0BIiaQfSTcEd1h6gY2WbycIasz+1vd3uK7BbssLMw=;
        b=UPMDmteSFESB6MyMOnb9AQ6HFgAUB+HOF5EMboGj+DO59aCNlYE0Qg1aALVtuD/2w7
         R8lYp+Eqb0lpNekr1IETt5P1HdvJj4R9W3iN5R341Vp1T4USTORTDIF5i6gGa8/Xbiq7
         Ozuj1236mf9nJMrrfhFUa8ojSEIyMgfMrGb2nw/NUVQRbZO/ueFuwEBj4/rZn5dPzBYx
         uYO2z/l+i732rcuKL6zZD+VU6IrX+e7C402f7Qd6S33MnXqCUsN0mYMLVODUJ3MpFCCL
         w4NLnrf4jodOqvlDy4dqvmlaeBdDySvX4FrQxKi+A/+jlPstut5wkvStW6kJXlupxKkB
         QFDA==
X-Gm-Message-State: AOJu0Yw2iX/1uDdqzkrQuKCBLVGhzAmiI3S2agjuQ4vquUuZ4Uxq3Nx6
	FHpuzXgQdNvkLgHtg94yQu7/dN6YaU5GtTFJsPbf5tKYmoBa923HUYSEcvWpno7uCGx9Swfgy4m
	Mj50F9TPEH+pbrVjbCPWUQtY0inox/rXa/I8WDAFGbti/Mo5YsrPlMAXxWp05yxQtI5DpsViTgZ
	lSWzleLGfeFKAZQSyRdM/C06YCod2FSEu67xqZ0sbFD05TEv2DcRY=
X-Gm-Gg: ASbGncsasSD44ZLkGAf79v6T6t4E2kZuUfSCqc3/i3arZSiIQze9qxMGFiFpXxig3sU
	10Hn5F7pcq8kuaG5urxJky8OQyrczfM7Qart89Gx5QYlKyP/C1xn2UQwAqm0YBrOIZtUicmDd9z
	4bH9MH2ZXgu4OvvxUKQchI32Ryz30E0gkiA0AgzTf21b9ETvT+Ru2Cx9PtEZ6ShyZa5v+6mj0Pn
	pX3+4sE6tB+LR78
X-Received: by 2002:a05:6e02:4515:10b0:433:150:bacf with SMTP id e9e14a558f8ab-4330150bc48mr16922375ab.26.1761784787331;
        Wed, 29 Oct 2025 17:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFVYtfA6rArdi0mk/au8/WKEwpErH+iNUEWNUx5lwFVDKqMdB5YztsG1w+Y87+3R/Rdk8LfiwjOFLXZS1Hhkg=
X-Received: by 2002:a05:6e02:4515:10b0:433:150:bacf with SMTP id
 e9e14a558f8ab-4330150bc48mr16922265ab.26.1761784787015; Wed, 29 Oct 2025
 17:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029191414.410442-1-desnesn@redhat.com> <20251029191414.410442-3-desnesn@redhat.com>
 <27c07b90-f4ef-462b-8b6d-46afd4301912@rowland.harvard.edu>
In-Reply-To: <27c07b90-f4ef-462b-8b6d-46afd4301912@rowland.harvard.edu>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 29 Oct 2025 21:39:36 -0300
X-Gm-Features: AWmQ_bneuKle0qhVC6CYfVLEB9C24iVzLhzJSEQLZKHyQlyete2C7DWKg33dZuw
Message-ID: <CACaw+eyo4Yc0=Ak=RWsozDVMzGHaZhW6SBHJUWFqRb6gPzWS8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: storage: rearrange triple nested CSW data phase check
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Wed, Oct 29, 2025 at 6:54=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Oct 29, 2025 at 04:14:14PM -0300, Desnes Nunes wrote:
> > This rearranges the triple nested CSW data phase if clause, in order to
> > make usb_stor_Bulk_transport() code more readlable. No functional chang=
e.
> >
> > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > ---
> >  drivers/usb/storage/transport.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/tran=
sport.c
> > index 96b81cf6adc7..3f2e1df5ad1e 100644
> > --- a/drivers/usb/storage/transport.c
> > +++ b/drivers/usb/storage/transport.c
> > @@ -1188,18 +1188,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *s=
rb, struct us_data *us)
> >                * check whether it really is a CSW.
> >                */
> >               if (result =3D=3D USB_STOR_XFER_SHORT &&
> > -                             srb->sc_data_direction =3D=3D DMA_FROM_DE=
VICE &&
> > -                             transfer_length - scsi_get_resid(srb) =3D=
=3D
> > -                                     US_BULK_CS_WRAP_LEN) {
> > +                 srb->sc_data_direction =3D=3D DMA_FROM_DEVICE &&
> > +                 transfer_length - scsi_get_resid(srb) =3D=3D US_BULK_=
CS_WRAP_LEN) {
>
> This change has nothing to do with the subject of the patch.  Please
> leave the code the way it was.
>
> >                       struct scatterlist *sg =3D NULL;
> > -                     unsigned int offset =3D 0;
> > -
> > -                     if (usb_stor_access_xfer_buf((unsigned char *) bc=
s,
> > -                                     US_BULK_CS_WRAP_LEN, srb, &sg,
> > -                                     &offset, FROM_XFER_BUF) =3D=3D
> > -                                             US_BULK_CS_WRAP_LEN &&
> > -                                     bcs->Signature =3D=3D
> > -                                             cpu_to_le32(US_BULK_CS_SI=
GN)) {
> > +                     unsigned int offset =3D 0, buflen =3D 0;
>
> It seems silly to initialize buflen to 0 when the very next statement is
> going to overwrite that value.
>
> Also, "buflen" is not a good name for this variable, because the
> variable does not contain the length of a buffer.  Rather, it will
> contain the amount of data that got transferred by the
> usb_stor_access_xfer_buf() routine.  The following "if" statement then
> tests whether that amount is equal to the buffer length.
>
> Alan Stern

I tried to borrow some code from usb storage protocol, but after these
observations I do agree it is not a good name here.
Nonetheless, I will drop this patch from v2 as requested.

Thanks for the review,

--=20
Desnes Nunes


