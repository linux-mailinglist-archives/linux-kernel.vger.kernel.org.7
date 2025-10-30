Return-Path: <linux-kernel+bounces-877535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D7C1E600
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1788D188D502
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A030CDA2;
	Thu, 30 Oct 2025 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2IiS5gf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045622A4F8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799381; cv=none; b=arqg/Ezub+aSBjpiLY/MSdKrUgW0am6m/SdastSueGm5joB+bFPle8Ippbu0tDp5CjCdN0K/13U0f853rSmgVRLN0pXbhVG0/bGVC1EYSzk3gvBIDRwFOOABpfJnt8Xc3qIDJIVxGgjtGhzNvqlF1Y5sgnsT/tR2qhqGDhSa8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799381; c=relaxed/simple;
	bh=MM/27vDFOENHfbbDXz2+qgipNjDt7Jas94SoYZixPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEpWPwl/mT+LI4GK4UTAdNweJLa6SlQrO1Z4RfsupJwebrH1V96c/KErhHXKzovql0WwJqihEIbH7/PwdIHxJzDnwsqFWGxJJhMxc22DJfs0mMCf6N09NMuwiUNVd56CtQ8IiwWt6LxLiR5mZCvWi6p/xKlLWOs9SXvVLSB95mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2IiS5gf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761799377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/YCYJ0gKE2kVZG+zLywOGB+upmVtVXPpgC1uB4xQIk=;
	b=R2IiS5gf3jk+4t9FVaatRPOH7QmgzUyksdQDg1mRcwOVunyN6R50bkHgohR1T/31G9Fc59
	47WoZiWkuPPZFLm2f7pGloLUqD7V0GE+K7CNPx6cIGJhDoSKLozga/AAV4stmXBH4xX7lb
	KDVukE2MWljTRCKCCoOsZwcebTCdSO4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-MSWXv0kYNgWQMBI5VVaVzA-1; Thu, 30 Oct 2025 00:42:55 -0400
X-MC-Unique: MSWXv0kYNgWQMBI5VVaVzA-1
X-Mimecast-MFC-AGG-ID: MSWXv0kYNgWQMBI5VVaVzA_1761799375
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430e67e2427so8446465ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761799374; x=1762404174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/YCYJ0gKE2kVZG+zLywOGB+upmVtVXPpgC1uB4xQIk=;
        b=PBoKhtCk+QxUmzzoilN5RF/elvn4AY3yLI1qwsjiAatD+8i4FP56F2AKMoYWZCXXUg
         bIQqyO9TG5np0ID3kxJV3rlkaaD65KMrBTtx9lSz8YlBtgYaIp/kFDV9qgERQ0XJcHkr
         ZwVRs0AFoi+mSg7JmcFxY7b7wFdf7qPK3siWm0QOqjtECEPlg8BguUVkYGENpGFms1JV
         n/f4iDhxDo6LigPE7R8VGHxvrhvx8jt36x5q+6G9iXYGi/Hbyw7gJBhTJ7F0RJniJGb3
         9I6n4fEFpNiATbqwHET83fHLruh75I/HPYrsc/pPaTfwqd982xXkyvtleJNBxzMOFXtQ
         pgoA==
X-Gm-Message-State: AOJu0YwCEz6CRownMxhijpWUzy+ffO8KPNubfYCZLUmyAF+vvH31O50L
	4u/SnJVE6RL/5Gg2Bbm6LtnvvslgEni1TnMs3JuE8qJKUuqoAlYXo1fUH/0LeUl7DKBK8+6oXKV
	56vcGVuRf0hxur/yzOp1QZqW9wj8vJ5W2D5quYtfx+Twn+1O9KN9a/8kS5Uwe8xvknqX1nATB+I
	ohRTgJCT4Ywz/9YIp6mJqxj7I1q2G/iwctIISI0K+T
X-Gm-Gg: ASbGnctYsPDlIoHRIm6DhzzdLY8ox8eVanawyo14Q5jqq3q8AoemldLSUGdtPKxWtvA
	DjtS1923C2oNWB2qWBiRjyj+J6IqjNHpfHZBaKPi+e+G4kCKua0e2ykG8oI+nQUctSEwwLM6AVO
	zdH6bF8UXfLZQb7WsamQHEqNrf5jtLP+WKQCH5ntMbvZ1DYr5OcydWeRZoX2LoULzMTgEBRdX0w
	z10qnYOMuu9dTXq
X-Received: by 2002:a05:6e02:4702:b0:433:517:12d1 with SMTP id e9e14a558f8ab-4330517154bmr5696735ab.20.1761799374510;
        Wed, 29 Oct 2025 21:42:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt9jvD8/UAD4YNIQ8lvjCok/GXMTyKA3mEFewCXTrRjEo+XhUWMv41Yv0j4yl3O+ilY/8iIHy4AfBtMKIYF60=
X-Received: by 2002:a05:6e02:4702:b0:433:517:12d1 with SMTP id
 e9e14a558f8ab-4330517154bmr5696645ab.20.1761799374152; Wed, 29 Oct 2025
 21:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029191414.410442-1-desnesn@redhat.com> <20251029191414.410442-2-desnesn@redhat.com>
 <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu> <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
In-Reply-To: <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Thu, 30 Oct 2025 01:42:43 -0300
X-Gm-Features: AWmQ_bkkDA92_gNFS16WGMU6T-0gOF17VIutMjEeo_EgJSLjGrzLyts6m5W-l-0
Message-ID: <CACaw+exbuvEom3i_KHqhgEwvoMoDarKKR8eqG1GH=_TGkxNpGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Wed, Oct 29, 2025 at 9:36=E2=80=AFPM Desnes Nunes <desnesn@redhat.com> w=
rote:
>
> Hello Alan,
>
> On Wed, Oct 29, 2025 at 6:49=E2=80=AFPM Alan Stern <stern@rowland.harvard=
.edu> wrote:
> >
> > On Wed, Oct 29, 2025 at 04:14:13PM -0300, Desnes Nunes wrote:
> > > A kernel memory leak was identified by the 'ioctl_sg01' test from Lin=
ux
> > > Test Project (LTP). The following bytes were maily observed: 0x534253=
55.
> > >
> > > When USB storage devices incorrectly skip the data phase with status =
data,
> > > the code extracts/validates the CSW from the sg buffer, but fails to =
clear
> > > it afterwards. This leaves status protocol data in srb's transfer buf=
fer,
> > > such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, thi=
s
> > > leads to USB protocols leaks to user space through SCSI generic (/dev=
/sg*)
> > > interfaces, such as the one seen here when the LTP test requested 512=
 KiB.
> > >
> > > Fix the leak by zeroing the CSW data in srb's transfer buffer immedia=
tely
> > > after the validation of devices that skip data phase.
> > >
> > > Note: Differently from CVE-2018-1000204, which fixed a big leak by ze=
ro-
> > > ing pages at allocation time, this leak occurs after allocation, when=
 USB
> > > protocol data is written to already-allocated sg pages.
> > >
> > > Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_=
indirect()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > > ---
> > >  drivers/usb/storage/transport.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/tr=
ansport.c
> > > index 1aa1bd26c81f..8e9f6459e197 100644
> > > --- a/drivers/usb/storage/transport.c
> > > +++ b/drivers/usb/storage/transport.c
> > > @@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *=
srb, struct us_data *us)
> > >                                               US_BULK_CS_WRAP_LEN &&
> > >                                       bcs->Signature =3D=3D
> > >                                               cpu_to_le32(US_BULK_CS_=
SIGN)) {
> > > +                             unsigned char buf[US_BULK_CS_WRAP_LEN];
> >
> > You don't have to define another buffer here.  bcs is still available
> > and it is exactly the right size.
> >
> > Alan Stern
>
> Sure - will send a v2 using bcs instead of the new buffer.

Actually, my original strategy to avoid the leak was copying a new
zeroed buf over srb's transfer_buffer, as soon as the skipped data
phase was identified.

It is true that the cs wrapper is the right size, but bcs at this
point contains validated CSW data, which is needed later in the code
when handling the skipped_data_phase of the device.

I think zeroing 13 bytes of bcs at this point, instead of creating a
new buffer, would delete USB protocol information that is necessary
later in usb_stor_Bulk_transport().

Can you please elaborate on how I can zero srb's transfer buffer using
bcs, but without zeroing bcs?
I may be missing something.

Thanks & Regards,

--=20
Desnes Nunes


