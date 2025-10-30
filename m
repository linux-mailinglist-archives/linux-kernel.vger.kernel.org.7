Return-Path: <linux-kernel+bounces-878360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B267C2063B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 519704ED477
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E722E3F0;
	Thu, 30 Oct 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="brtcNT/N"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B71E868
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832367; cv=none; b=UgAffl0Gfrl1hYqze0jfDsqMkSOVY1B7g44xxwqmMZC/cShBTChmqYmjZLYN0FCmuRvXvUx9siZ66euHY4O625kGE5s7kEpu+de+B5Z79ywEzTRCcvnTxv7652LJdX8+KHLhjFP0vjf5ULncfZBz6NdSYtCucUH3Uobj1eo0orE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832367; c=relaxed/simple;
	bh=E0QzcfXWoHUOsdT7rTZMfrR6XAKnU1jfAvZvjyvtedM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np0eJEmLM2ol+PT5+il4PzNlzydGlKVAXClv1g5fs6BsR0Bjr9MqWYwCGQkjmeEdwtip7SQLI+SLlX7PZzoM27hPqQayOGpRqWaFK4tvLRj+NYgD4bCa4OzFRISlXvZjMWG5ERCCQyQdremLusnirCXWa9/euvuLrfbogymhtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=brtcNT/N; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8a074e50b41so135710385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761832364; x=1762437164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wZtXAAGFprMo/ZTBKrYhrAoxG1/dNAQ0A/mVgWIzjac=;
        b=brtcNT/NxXYdiSEB1Wn7wSJNpyipf5djLcgZBSai7tO5JhZyia+IOpHDIw+7N3MsmY
         L7vdh8rVYQ1IL1tCAgCUUwv9Y2auDEOIblynJh/miJqqMZtr0Wj7ZUaOFXBALdL7QqdB
         554WBqnBnuypDKYW45KvQWt9Q4V/bbmesIkHQkc68kSYNas+VEO3FBVLjTL3EOTKLex9
         eTLraYYcjuUNhFqG3oIipJgISFLitV3LjamJSKyHDS+HKHR/4Dpq64jsvNJ9VHcuR+99
         +Kdvt5ObEYoJXciQZUy3FYB+k7+UHs+FLXOtZmWFSVv39jx3zu+QO7Wo2eh4VC5l9zSf
         nOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832364; x=1762437164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZtXAAGFprMo/ZTBKrYhrAoxG1/dNAQ0A/mVgWIzjac=;
        b=sgaQ/qjJJ1rhReef84rugK4c+2G5bEBIZjpgaDvU3fIOmQR2RotyK8XxV9O9qbYnoL
         +h0z6ERRAIuiQZV45maCgy70yUqjBuGBI3r+5UU0SNES6reT6s8XAzPivP8O+M88iews
         +KP+eZ47wmGyi6xr789zOhgC23B1m8cEvDwKPp7Vx84nTLZTa6tPbOpelPjkp1haqxr6
         6/NuiIdjc6OMgx2ViaCWpXm5HQwDctd5eYgCOj9D3kKykprVDo7bMEzfyD/eV+//F/BI
         Eon09revsR1QdECU1Cj9pLCdouesxqBg2wnWUaEDFdc5KsZfqJqPVCpvfRzx2JbWNJ6r
         lSiA==
X-Gm-Message-State: AOJu0Yw4287tdlFGe+P5BITBNBT7DlQSJNIdXTSrAaMg3EuAATN2NO5z
	LnRgsJ+6LkIs5Z8hbm7RKprOBPccloK8kLIZKW3jzjaEjbqJg4D3YnfZU0SF9LbYZA==
X-Gm-Gg: ASbGnctt8Vi7lGmAnb8pjV/8NyEyqulkBJcqGKKL7pMaxCKKxWt4o17/1Bf1i4arF1Y
	OIjvPYfxEfaglfY6OrAyVQs7Fj9RkcW7CHPiKwy7U8FoAKg/0dFGJ8vF0fZO+CD35c2uyPH7xXR
	nYahtAlzWpQjFersNzaVpDBH1GP2/wgcOkCNTKana5cbBHe3c4qMsJPgAws4aQ7TsHNlvQNsmwR
	5YHLCdiwDGAxhthJkbw0WmkrygRWA60QJgj1BnyQUxP+aG8oGAQTZhyWi8H2K8pKNHn1SUMAYEf
	vnkqB0mLViyxckjUPRlRAB+kUEiRmE8vcRKDreEAFPMzM56bJOn3BMrRKhRtZiDIgd8hcvEE5JG
	WV9fJERpXhafCTgy+Saz7aXG39ewUUtQMsiKNP6CEajWAWjB44fnXV8dKyPJLfOoZJAkkjUiiE9
	Mj/HGYFsIRDJkSCANTIc8=
X-Google-Smtp-Source: AGHT+IHvPD1HDWobEO9/K7p303S8d75PBvpopWWJuuTKLjyjKjmBOYPS+Bb+U4mCULT1RA5s84pgjg==
X-Received: by 2002:a05:620a:7001:b0:8a6:9a1a:922b with SMTP id af79cd13be357-8a8e4ff0aafmr902035485a.42.1761832364045;
        Thu, 30 Oct 2025 06:52:44 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f252b1a66sm1249016485a.26.2025.10.30.06.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:52:42 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:52:41 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
Message-ID: <808ef203-528f-480b-8049-8e3ca4687867@rowland.harvard.edu>
References: <20251029191414.410442-1-desnesn@redhat.com>
 <20251029191414.410442-2-desnesn@redhat.com>
 <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu>
 <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
 <CACaw+exbuvEom3i_KHqhgEwvoMoDarKKR8eqG1GH=_TGkxNpGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACaw+exbuvEom3i_KHqhgEwvoMoDarKKR8eqG1GH=_TGkxNpGA@mail.gmail.com>

On Thu, Oct 30, 2025 at 01:42:43AM -0300, Desnes Nunes wrote:
> Hello Alan,
> 
> On Wed, Oct 29, 2025 at 9:36 PM Desnes Nunes <desnesn@redhat.com> wrote:
> >
> > Hello Alan,
> >
> > On Wed, Oct 29, 2025 at 6:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Wed, Oct 29, 2025 at 04:14:13PM -0300, Desnes Nunes wrote:
> > > > A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
> > > > Test Project (LTP). The following bytes were maily observed: 0x53425355.
> > > >
> > > > When USB storage devices incorrectly skip the data phase with status data,
> > > > the code extracts/validates the CSW from the sg buffer, but fails to clear
> > > > it afterwards. This leaves status protocol data in srb's transfer buffer,
> > > > such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this
> > > > leads to USB protocols leaks to user space through SCSI generic (/dev/sg*)
> > > > interfaces, such as the one seen here when the LTP test requested 512 KiB.
> > > >
> > > > Fix the leak by zeroing the CSW data in srb's transfer buffer immediately
> > > > after the validation of devices that skip data phase.
> > > >
> > > > Note: Differently from CVE-2018-1000204, which fixed a big leak by zero-
> > > > ing pages at allocation time, this leak occurs after allocation, when USB
> > > > protocol data is written to already-allocated sg pages.
> > > >
> > > > Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > > > ---
> > > >  drivers/usb/storage/transport.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> > > > index 1aa1bd26c81f..8e9f6459e197 100644
> > > > --- a/drivers/usb/storage/transport.c
> > > > +++ b/drivers/usb/storage/transport.c
> > > > @@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
> > > >                                               US_BULK_CS_WRAP_LEN &&
> > > >                                       bcs->Signature ==
> > > >                                               cpu_to_le32(US_BULK_CS_SIGN)) {
> > > > +                             unsigned char buf[US_BULK_CS_WRAP_LEN];
> > >
> > > You don't have to define another buffer here.  bcs is still available
> > > and it is exactly the right size.
> > >
> > > Alan Stern
> >
> > Sure - will send a v2 using bcs instead of the new buffer.
> 
> Actually, my original strategy to avoid the leak was copying a new
> zeroed buf over srb's transfer_buffer, as soon as the skipped data
> phase was identified.
> 
> It is true that the cs wrapper is the right size, but bcs at this
> point contains validated CSW data, which is needed later in the code
> when handling the skipped_data_phase of the device.
> 
> I think zeroing 13 bytes of bcs at this point, instead of creating a
> new buffer, would delete USB protocol information that is necessary
> later in usb_stor_Bulk_transport().
> 
> Can you please elaborate on how I can zero srb's transfer buffer using
> bcs, but without zeroing bcs?
> I may be missing something.

You're right -- I completely missed the fact that bcs gets used later.  
All right, ignore that criticism; the patch is fine.

Alan Stern

