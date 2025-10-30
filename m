Return-Path: <linux-kernel+bounces-877423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26FC1E143
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6055940530D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EFD2E7BB2;
	Thu, 30 Oct 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="K1r43AMb"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6C2E4274
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789601; cv=none; b=bke1ipnRTBeFhACJxit6iARX5OO1imeaYJh8KG86irGLvxj2RP9U0hd0gcKJH/NDvlW+FF4LsnHTn0mI08NVWTAYS5crWAZhzNY4Y2ELATLadtqnHgJPHI8ecd6UeRyx5IFaevLoqQAQAaeP0m0QDoODJRhA6ShAR58HXgYPnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789601; c=relaxed/simple;
	bh=WCn19iM1Z0MfIjW+rItRIGL8bdfe6BgzVs9U3AbCLZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4XRSGMKw1H88HLmQRrJcJoyP2atc3hDP7CdI7LxKyVlPDf3g+OkPuZd74bwXOkKgT99RTN3auzYpEwiKtScTED2i4I0Fs9yAfykZZynrIhFo5Jp8TlZSyqKNZopwyFTul6VvMSQwugTTtl7A4RFj6dBuKoJIzw4+H7vKF4bggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=K1r43AMb; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ecf30c734eso4417881cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761789598; x=1762394398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z2NHI+JKle61/F1K6gTmohpSB527P/h9U8G3EyLfGXc=;
        b=K1r43AMby/1As3GK2ps2Xm/J69G2GdXWhudnC9HEO4vbDDsuChofFnnnK42Iw8TfoQ
         cYdxHf986wyLX5UuPB5u9Zo2THUkoWbNF2F3LX6Xy9zu4L6Rx888L8h5SKRSPwXMWGtQ
         LNa7t3BVMWCQSydPGsTaQ8kL2ryXyWuBMlHkbWgVKoPawY6D/Rb7F8qfCdVpEurKxM9N
         hm7ODu8erjm1ePtiH6zDPfQAgkrUxfMpZ/+6UySX6/jJZ+zZUjMfxB2gDfNiDbKnaUH3
         aVwryOnUnhI8krFad+XBiubyFA+9DgPEb7wDNJ1gUmRBtRR5IdHoE2RkusrwiW7PjKBa
         fnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761789598; x=1762394398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2NHI+JKle61/F1K6gTmohpSB527P/h9U8G3EyLfGXc=;
        b=C8EsYQd9kYaZZI6MlpgbUfsk66k0bllCmgs9HRgW476agP7hmD4R1Ffm1CGE1djS0F
         vBEoKftVV1lYoU2YQt8pI57R8qwZ0y92GupDlfxpdS5U0dQ2kcgiQz9VZY7HB5WCK++D
         BeJDcnuA9e4r2B3oRQxb9kL3Kgh9vyclKbgIIc/cuxk2+r9B0+OCbSTlfSY5UJ/yr0dg
         v7Jx2GrZHUCnEDkdxkBnggumfjDz/v0cZzq3gTaPWaxEhYMtXuJZbhN4UTzZpmiqIfzO
         OAcvzVKDEeSZ56pDy6bOSSiEjtaX7fRP388YbtGLZ7yTCM7n16Rl5xnA4vVkZTZioh6H
         n3JA==
X-Gm-Message-State: AOJu0YxBeEndjAbL831d8UAizstpRNLadMlItve7MvVYJT+mdNrd+dIR
	4W0VzhXwffPuja1AKpWxExnPA+Ige+PBLviLQluO4Pbxy9YB270x90bnUJiDnJ83Po1TxFqVnII
	NdfY=
X-Gm-Gg: ASbGncsFrdqJ+CRpad40sOdI9VVetF6klXwz8Q1hf1svFJAr4BnnR4bXaVFJ1uuDpNK
	ra4gestCE+WiiMH2rkNRhA5WDsYtR+FgA4q7IAlTv8O3wKT/by5QTeD2Lya0Nn73/iZ2yHDr1D9
	UWreClyOciLs93AN2as+EJrw6+sYG5AwEKV+N5xMz5qaMJmqmKdDmIp/jddQfCEYd11ktOcMYG8
	Ch322gGu7iNSlpcI2MYvdPFl8rZq6VaVpg4a8P0oVsOx9/O/xgsDTmJKTiDqouW5GV4wRfosPsL
	KZc5855nPu20rYkf1xKim3bjsiffEqRI+Z/ZqDtjFVhS0WM+T+7S/nMQYkOTLObI10Nrb9W6dEX
	H04zFGAe95PpNJ5QpT1MhH8G+d/9/gl2aMx6McCvS/ztyf0wTOkl4cklTzMNiLwqsoJtiYCz7BZ
	9oIw==
X-Google-Smtp-Source: AGHT+IH+TV6RMeAIWWxN5dWDK8nDnwa8KRVgo55fY3RxQYJF0+8j4+ggyy4srfUSmRt7u00GArjcJg==
X-Received: by 2002:a05:622a:22aa:b0:4ec:fafd:7605 with SMTP id d75a77b69052e-4ed2236368amr17970891cf.60.1761789598508;
        Wed, 29 Oct 2025 18:59:58 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::db9a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3858f1esm105935391cf.29.2025.10.29.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 18:59:57 -0700 (PDT)
Date: Wed, 29 Oct 2025 21:59:55 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] usb: storage: rearrange triple nested CSW data phase
 check
Message-ID: <a8f5302d-ed93-4b2f-a706-e7e2646986a3@rowland.harvard.edu>
References: <20251029191414.410442-1-desnesn@redhat.com>
 <20251029191414.410442-3-desnesn@redhat.com>
 <27c07b90-f4ef-462b-8b6d-46afd4301912@rowland.harvard.edu>
 <CACaw+eyo4Yc0=Ak=RWsozDVMzGHaZhW6SBHJUWFqRb6gPzWS8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACaw+eyo4Yc0=Ak=RWsozDVMzGHaZhW6SBHJUWFqRb6gPzWS8Q@mail.gmail.com>

On Wed, Oct 29, 2025 at 09:39:36PM -0300, Desnes Nunes wrote:
> Hello Alan,
> 
> On Wed, Oct 29, 2025 at 6:54 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Oct 29, 2025 at 04:14:14PM -0300, Desnes Nunes wrote:
> > > This rearranges the triple nested CSW data phase if clause, in order to
> > > make usb_stor_Bulk_transport() code more readlable. No functional change.
> > >
> > > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > > ---
> > >  drivers/usb/storage/transport.c | 21 ++++++++++-----------
> > >  1 file changed, 10 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> > > index 96b81cf6adc7..3f2e1df5ad1e 100644
> > > --- a/drivers/usb/storage/transport.c
> > > +++ b/drivers/usb/storage/transport.c
> > > @@ -1188,18 +1188,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
> > >                * check whether it really is a CSW.
> > >                */
> > >               if (result == USB_STOR_XFER_SHORT &&
> > > -                             srb->sc_data_direction == DMA_FROM_DEVICE &&
> > > -                             transfer_length - scsi_get_resid(srb) ==
> > > -                                     US_BULK_CS_WRAP_LEN) {
> > > +                 srb->sc_data_direction == DMA_FROM_DEVICE &&
> > > +                 transfer_length - scsi_get_resid(srb) == US_BULK_CS_WRAP_LEN) {
> >
> > This change has nothing to do with the subject of the patch.  Please
> > leave the code the way it was.
> >
> > >                       struct scatterlist *sg = NULL;
> > > -                     unsigned int offset = 0;
> > > -
> > > -                     if (usb_stor_access_xfer_buf((unsigned char *) bcs,
> > > -                                     US_BULK_CS_WRAP_LEN, srb, &sg,
> > > -                                     &offset, FROM_XFER_BUF) ==
> > > -                                             US_BULK_CS_WRAP_LEN &&
> > > -                                     bcs->Signature ==
> > > -                                             cpu_to_le32(US_BULK_CS_SIGN)) {
> > > +                     unsigned int offset = 0, buflen = 0;
> >
> > It seems silly to initialize buflen to 0 when the very next statement is
> > going to overwrite that value.
> >
> > Also, "buflen" is not a good name for this variable, because the
> > variable does not contain the length of a buffer.  Rather, it will
> > contain the amount of data that got transferred by the
> > usb_stor_access_xfer_buf() routine.  The following "if" statement then
> > tests whether that amount is equal to the buffer length.
> >
> > Alan Stern
> 
> I tried to borrow some code from usb storage protocol, but after these
> observations I do agree it is not a good name here.
> Nonetheless, I will drop this patch from v2 as requested.

I didn't mean that the entire patch should be dropped, just the changes 
to the indentation of the first few lines.

As for the variable name, num_written or something like that would be 
preferable to buflen.  You can make up something better, or you can drop 
the entire patch -- your choice.

Alan Stern

