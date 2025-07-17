Return-Path: <linux-kernel+bounces-734696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BFB084E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990F13BA950
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8963216E24;
	Thu, 17 Jul 2025 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1pPHusI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40D1A841F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733874; cv=none; b=JG1XpqY3kTZZRWthLofcnRes6d6aI2durGZy7mC56tYjmxIS0P/Z8H8+QmLg9OBqusnyyvajjzAFbMV3oYfA6raKybaHG2J3whqLPABqfIDV+FyTkYu55vvzNDWlE9sk77U9bnbhDscxguBZTsGq45y3GRBkUCjf+adtdDEsB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733874; c=relaxed/simple;
	bh=nGt6mjY502NYQJQNLQHOqJ0cX0q0+Ew5UUFrSaN7eOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIKHkAAKCULNOoyphmmMJsvwaH7NYWke1+DuFXkOebNMKr2sugVfnnSkIHblcCykihehTNfGWBcQIKPFyvPZ1Is7MciV4KR/3vwmPg975fpCawHcrs/LR46jnhUCpodP2AicZqVKdf5ArjjQSenKisEGoTN1zK5050Dx2y2Eoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1pPHusI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752733871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvK5vwyLkiwd45XXL+NYQb7X8wlfzvJMgGcpvl9Wm5M=;
	b=S1pPHusIkIPXMBHA9XGAuP/VSQsXuEfuUNLzc8uFrIOBjoC/sSBDuR/OeRe//flv2sq3yW
	YSqY+471IFOM5Tl/Dr5PCPVVuvB8BX/kkzjt9l/qrmNZp0lD+rXzmJ36aONrOXjcuJmcZ5
	6EOSliMGybOwho70twKyirwK7DZI2Bc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-EcPB-ZgVPbWByBpSbHplAg-1; Thu, 17 Jul 2025 02:31:09 -0400
X-MC-Unique: EcPB-ZgVPbWByBpSbHplAg-1
X-Mimecast-MFC-AGG-ID: EcPB-ZgVPbWByBpSbHplAg_1752733869
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so314154f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733868; x=1753338668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvK5vwyLkiwd45XXL+NYQb7X8wlfzvJMgGcpvl9Wm5M=;
        b=QMqvZRIBq1m7zAGXs72tLhZAcKWAJ7cWS8EGW798y6cq9yWLzvIB6y+BpPcCUFYmv+
         Ds4HiwQSbEpDQsSb8xI5MRu/RYB3Akp33TthTrHJ9f01D/iYzAjBcEIuFC0eASkRKiRY
         +6RRb+P/mmQq2fRo5fynGIThd68h2p20fQ/wCB6hWROZdGd1MWoMtPlxEViN7NHKnWa0
         iaXIlwlGDcJmuBR82T+0reCbzm8P5jSf4fiOlxkAtjEcqmHCH63VZXMhEqHPB9aOsr56
         OA359Aoy05OcNl1XpHrkv59L4blcSp44q8e4Z3Cr+noLqY6QBCNfxdyVKQ/Bqpsk+tpA
         ikDA==
X-Forwarded-Encrypted: i=1; AJvYcCWxAFw+p9+5ugiT0DA70/K56XkQpRTzRmWCzX7gfNssZkuBPGTERviZ7m9DZ0VYIjgoTntfYlDs0SOsUVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMMwpoGvaefRtJddrSnOL4Em1Mwgl3X8t94O1PKiuQuhHFX5j
	Gb0dxm5RB1j/d5hE8f/v3JjivmgVkG/1ovjzH6vSo7fnSpMQXlFeIzUNHSJYtZvSezMqppvlhcp
	bXBtjadzjR4w4ReYp2eklDCdDkigLN8t+2zLPjS4qTT4slgu4e0wRfgY7+QE4Yp+NlA==
X-Gm-Gg: ASbGnctcD4qDwzBE8VKBTy7LCSnnSc0V+Ft+Hb6Bl7pFPNnHRUNzOuSI+cfWapGNPtS
	QLyGUMuS+riaI03o2sinxjPQPwOGBV2YGoQmG/XmBuSEZfUekw7Ww6Y/1CeNMzdXTbbdBJhtCBU
	XyjfVwtWWEo/e69Y7u7B/3v6kJfTOZCXYVfSXaqhm91G6/FheaLgos6n2KQp2L3xP01YtX/ad9B
	koUEud4sSX2Wf0SuiwWI//++P2/D2K5Z5mYaJEnO1RV33cD+mDEixmnTIevQSVwZpycWiCcyhXW
	8ePsJ91SQkAX4Ye+b/ApXdm93GBL1Tqr
X-Received: by 2002:a05:6000:4a06:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b60dd827a9mr5402528f8f.48.1752733868510;
        Wed, 16 Jul 2025 23:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDhNrlMdoGwMnp3S2sOg05qA/z2rX+K2yXyqiJ23p15NQvqO+DN/Tziiqc7jgSgj6yaxfLA==
X-Received: by 2002:a05:6000:4a06:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b60dd827a9mr5402502f8f.48.1752733868012;
        Wed, 16 Jul 2025 23:31:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a62sm19679812f8f.40.2025.07.16.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:31:07 -0700 (PDT)
Date: Thu, 17 Jul 2025 02:31:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
Message-ID: <20250717020749-mutt-send-email-mst@kernel.org>
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>

On Thu, Jul 17, 2025 at 02:01:06PM +0800, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> > > On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > > > > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > > > > feature is designed to improve the performance of the virtio ring by
> > > > > optimizing descriptor processing.
> > > > >
> > > > > Benchmarks show a notable improvement. Please see patch 3 for details.
> > > >
> > > > You tagged these as net-next but just to be clear -- these don't apply
> > > > for us in the current form.
> > > >
> > >
> > > Will rebase and send a new version.
> > >
> > > Thanks
> >
> > Indeed these look as if they are for my tree (so I put them in
> > linux-next, without noticing the tag).
> 
> I think that's also fine.
> 
> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
> 
> (Note that the reason for the conflict is because net-next gets UDP
> GSO feature merged).

Whatever is easier really. Generally I do core vhost but if there is a
conflict we can do net-next.

> >
> > But I also guess guest bits should be merged in the same cycle
> > as host bits, less confusion.
> 
> Work for me, I will post guest bits.
> 
> Thanks
> 
> >
> > --
> > MST
> >


