Return-Path: <linux-kernel+bounces-877360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE77C1DED1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B0D24E40A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D81EE7C6;
	Thu, 30 Oct 2025 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoJR5X5m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682E1EC018
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784621; cv=none; b=cvXo88qdNMRY33axjc1AGZKucz3R64BoXc+kIbyBtgoQt4rlQ8UeuI/LnpZGwpzVuThkPN4Gugy/01zclzLMEB5l7bwgDtgx2jHU8HOlDB88YNg2BfXgw9llPVcqSelQQHL8CQ1jF895hsZX5FquUWzY55evTFlhv1BGeVjf4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784621; c=relaxed/simple;
	bh=vc+Z4vwJmfybJI6vUwSlj+i4Y37gu+pDm/b5oN1SdWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBCp80iCtI+LdN3zjAPtTZP1Sluqo5X5k7zDxtFZYjSSpwjTRSqe343F0AT7eGDq0YTpCoE+uI6iKAfZAqObxKal1la6o6EPQCZ893Vf23EBQeucIKzxsK0EwUwmO53rFUYSMVcBkFZAZKaUDrU9toAdL0lHg/oXTW8+vwCqKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoJR5X5m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761784619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpdMkLEBxAzGgTMAiZJaINSdgkvujrmbEy562gQUFuo=;
	b=HoJR5X5mrJxPh9yCxSrpfT5MLOXHoJq0CZtiTTslOVj8Eap3upmQb8yARzRIIjl+z2dRi6
	ti3tlLLohv+InFexAe9qcRBl77KjSwzWniUIuAl+2Gxxl4IwLb158eo8OU3kcIn51xrI0A
	gx2YOTYwLYhtSHxH1/kiTzFS7xa6V5w=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-QBrygQeGNXWNo0hwKI_6wA-1; Wed, 29 Oct 2025 20:36:57 -0400
X-MC-Unique: QBrygQeGNXWNo0hwKI_6wA-1
X-Mimecast-MFC-AGG-ID: QBrygQeGNXWNo0hwKI_6wA_1761784617
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430ca53080bso5839025ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784616; x=1762389416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpdMkLEBxAzGgTMAiZJaINSdgkvujrmbEy562gQUFuo=;
        b=B+LZK8nvx3/a9R+NcUvDJWLXBpRufUx04Z9iE0g8C6JCPHXG50lcfsNK1I4rvJ/Sdb
         uh/Egm5LSkMxAOPQdZL5ZLI17JOrQo0TP7GPBLfz1XlJNS2R4idZlGkqGGayhJH2N9rI
         sOYh8jMNmPdTmxuuY3IugeWcGK0vafF+CzWg7dzbeWRKfxMwONdCHwLAu/vVV1yOg40A
         PPHLKNadqopX+mXY6QPrxAdRgOBKDbEYvY3dexz6+jhNJioiASL+mJQHJZ9YOKxLQBw3
         Mi4Rg5NZ0n0rV5qcjI+hEPlBTpvF2PdSOY1LlnJ0Yqo++lpv4vWQNTMatgcLS3s93VzT
         gH4A==
X-Gm-Message-State: AOJu0YyQF+WD7dCI4P+inmQCEhkc0D/R3bM/xlRsy+G0Nyn8mReC7NmJ
	2VySdu2jM4NNhvmTkJZJ85e9/Nmog9hJFz+FnZ3ssyj1AuM2eCKzIpTVQcBhhyGxWKQmhjWJ70X
	7JiMcP46vAlZs/+dxZMeyMqTgzSy1bfuVAupKLYpKf9VODaPcm4zt8dKpRT6Jp8875L3EX3YUIS
	br7LryZHtmeKX4NiJm5onZ0Y6xKnoEpYu/lpwWkBz7
X-Gm-Gg: ASbGncto5hxyGrwk3ijV8qE+GN0eM7aKso7tvLPin3a6QcnGPrRhY5xmuA59uwiG89Z
	Bs8KAFVTdZauSJSIUVkFRpIKmj6CBkFp45vbpDwXx/oRpsIS9vu3OdVqXt/XQUXX69FvoHZR59w
	Vf/poY8uroWvnS7FL5s+sK8Bw5za9EoZl23MiarZhgWHai+xEuFa6lVf1epafBXf0hTgjZDWBYa
	0ym09jl9D6ozLbr
X-Received: by 2002:a92:cdab:0:b0:42f:9eb7:759b with SMTP id e9e14a558f8ab-432f9044dffmr57158565ab.28.1761784616638;
        Wed, 29 Oct 2025 17:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZuijjJOo7FLk3K/tPaprJFeBWImzkLs7KAevx4fRe2hGV4YYIEo0lHTFjE0zedcBVsWSD7uSDSINEiDu/904=
X-Received: by 2002:a92:cdab:0:b0:42f:9eb7:759b with SMTP id
 e9e14a558f8ab-432f9044dffmr57158385ab.28.1761784616273; Wed, 29 Oct 2025
 17:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029191414.410442-1-desnesn@redhat.com> <20251029191414.410442-2-desnesn@redhat.com>
 <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu>
In-Reply-To: <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 29 Oct 2025 21:36:45 -0300
X-Gm-Features: AWmQ_bkf3Zl0zsrq7ig32Ls3dqm_dQGASmfXfNZq2huLPMng2uafO8z-59mTHrg
Message-ID: <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Wed, Oct 29, 2025 at 6:49=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Oct 29, 2025 at 04:14:13PM -0300, Desnes Nunes wrote:
> > A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
> > Test Project (LTP). The following bytes were maily observed: 0x53425355=
.
> >
> > When USB storage devices incorrectly skip the data phase with status da=
ta,
> > the code extracts/validates the CSW from the sg buffer, but fails to cl=
ear
> > it afterwards. This leaves status protocol data in srb's transfer buffe=
r,
> > such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this
> > leads to USB protocols leaks to user space through SCSI generic (/dev/s=
g*)
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
> > Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_in=
direct()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > ---
> >  drivers/usb/storage/transport.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/tran=
sport.c
> > index 1aa1bd26c81f..8e9f6459e197 100644
> > --- a/drivers/usb/storage/transport.c
> > +++ b/drivers/usb/storage/transport.c
> > @@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *sr=
b, struct us_data *us)
> >                                               US_BULK_CS_WRAP_LEN &&
> >                                       bcs->Signature =3D=3D
> >                                               cpu_to_le32(US_BULK_CS_SI=
GN)) {
> > +                             unsigned char buf[US_BULK_CS_WRAP_LEN];
>
> You don't have to define another buffer here.  bcs is still available
> and it is exactly the right size.
>
> Alan Stern

Sure - will send a v2 using bcs instead of the new buffer.

Thanks for the review.

--=20
Desnes Nunes


