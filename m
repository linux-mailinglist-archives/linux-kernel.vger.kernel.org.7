Return-Path: <linux-kernel+bounces-836057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C0BA89F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C61895887
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA62C2361;
	Mon, 29 Sep 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tfe+TxqE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3852C1780
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138152; cv=none; b=MiML27oUm9FNVjJcm7q2fT+GmGqfn61tTs5cSAW6//HMsQmrdquJfhlNPgF9S46UVPf2klIws0Amvrlj2/MOUBu4tAyKwn+9VcNmCvk1uMNZs/oN0FV+vYDruC4GqXTeTTJ62NXPL8KHl8TP9vhUySZFVnUgsf1Xuf124DazY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138152; c=relaxed/simple;
	bh=IqqohkwK/wDAZXsbcwVBOyqyCpj2UXCieQ+qc0MMaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLlDd4XtL7q0xfHK84oze6nnc1N8l0LallmEggPknzu03uvEBpm/PW6Oo1FnGdr9pJZ2SrOfPjqXaeOXTYDgp0C60dwWPHSkm55LKoz786GmrLAYYBHfjDLGB2CZMqfJukQOwH8NWF+mFeMkEgElRAT9M1OVwoyQ6idcZdl0FUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tfe+TxqE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759138149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fWDea0/6VzbimOx+St7tLaVKMNcgYjUWpmfVi5MNpI=;
	b=Tfe+TxqEA+pYU4YwhVphmljXs8+n20i37+Ov90LY50Jrg6G7sunm1XluTSPBOx/JimI9v7
	XpwZqB8H0PHz/07lgFxpdYK/0URAei1U86EoT0wYJz8a1CM8BBrFyOXbpHW1Aygm6XeA5w
	qLKc5dM3ydQaXnSl51zUWFbqrKjKJ5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-WgGNCFL_Ov2VCYOtdcp0Rw-1; Mon, 29 Sep 2025 05:29:07 -0400
X-MC-Unique: WgGNCFL_Ov2VCYOtdcp0Rw-1
X-Mimecast-MFC-AGG-ID: WgGNCFL_Ov2VCYOtdcp0Rw_1759138146
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so2132808f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138146; x=1759742946;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fWDea0/6VzbimOx+St7tLaVKMNcgYjUWpmfVi5MNpI=;
        b=dC0Ukbx8GAAMPX1X5lhRT+NA8S7X1CIQglJgPqCP75I7ji4zL3b2qGUXhpLfRzmnDP
         ZXDy0kNWBo+oFiHqdPihHtQEFEv/hGAFD3TizaUwxaDs1IlhdW+YR5VSyjgBVRIHnMh+
         n0O82m3G1dGack7kUonP2kt+3dvxlISV7Bh2cnNwjze1lbWZnQeUz/haBvuNfG4zrOBr
         fgmNCLEhlyJ7d4zXQsFW9THBuD+wL/Kh+2PjE2K4yf+cKKcl70/BqOB19RY02FoC58JI
         fJ7Xh/unu1qHiyd3PBR/rG6LZ7i5RI9BnuwtTyuixOq9v8RH2n470Tgsns/IBHtOMXGa
         18mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO/CnmXhFqU8cFnFrdM2gzl1B0GRA4+oQnJGBsGv5ip+JpohQ9C+f0qnoWFtnQmCOag4FL2+DeWW0v4o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvE5CPAmYwFuCu/GVaU13+Le8qc+CNGz4+ry/LDNXG+rnniZAf
	JNcwCwR3Xwj1qwDUvwHZFMxjpJVsuZ3nu51/I57thhTPHG7qvdivtTwPBOt7GL+/zRH983XM9Fb
	a1k1LJze9OqGn2BM1HYAAS8nZSHwxPEjzuRLI4jMcx9RUNCU6TaqWR0E2BXiYGLtQwg==
X-Gm-Gg: ASbGnctGUWI7pfPap6Ux+QT5VSyI5bH2xYZrp/eRAqtN1uU3cTnAwtxJDga4CscO/ag
	Pt0UexoGK7BY5sNnxfcz8cKJpTdrYh5BJk1GGDK2kRrr+pkN7pgdvKkaax0Xcpf6AINQZlKjDIw
	/88uBPjLGmF4/YmDazzH/gvO1fnUYjj4bWayvZ4GB2Lye7naQpckj1s2IscutesEyHwrZkryvoF
	9nEY6z2DGMVc+HIGdVH9G62MSghOCkQG5vSTVz5YaV8KR9cHkoYFCp20HIZ2o1aShe6dBFsFCuy
	wC6NW8a4f7Byk/mbQflZN2eHhpXVgHHSPA==
X-Received: by 2002:a5d:530f:0:b0:407:4928:ac93 with SMTP id ffacd0b85a97d-413591d79bamr7817175f8f.42.1759138146139;
        Mon, 29 Sep 2025 02:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYA0WmzP6WoEMlbJwT4yGMKxIBdSduVZ9RrZfxmTRyvknf7O/p1G5x1BNEYVHkuc7D1lGyMg==
X-Received: by 2002:a5d:530f:0:b0:407:4928:ac93 with SMTP id ffacd0b85a97d-413591d79bamr7817161f8f.42.1759138145763;
        Mon, 29 Sep 2025 02:29:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5707c1e7sm5111115e9.21.2025.09.29.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:29:05 -0700 (PDT)
Date: Mon, 29 Sep 2025 05:29:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250929052852-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org>
 <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
 <20250929035510-mutt-send-email-mst@kernel.org>
 <CAJaqyWdQkJgUKqne0_ivLTpQ3rD9tfzcEZL26o5ZdcQsjrJL_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdQkJgUKqne0_ivLTpQ3rD9tfzcEZL26o5ZdcQsjrJL_g@mail.gmail.com>

On Mon, Sep 29, 2025 at 10:52:45AM +0200, Eugenio Perez Martin wrote:
> On Mon, Sep 29, 2025 at 9:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 29, 2025 at 07:55:59AM +0200, Eugenio Perez Martin wrote:
> > > On Fri, Sep 26, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> > > > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > > > >       dev->device_features = config->features;
> > > > >       dev->device_id = config->device_id;
> > > > >       dev->vendor_id = config->vendor_id;
> > > > > +     dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
> > > >
> > > > Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
> > > >
> > >
> > > The macro for v0 is called VDUSE_API_VERSION, so I think it is less
> > > intuitive to put:
> > > dev->api_version == VDUSE_API_VERSION
> > >
> > > But I'm ok with the change if you want.
> >
> > Confused. You mean "more intuitive"?
> >
> 
> Ok think I misread your comment,
> 
> I find
> 
> (dev->api_version < 1) ? ...
> 
> more intuitive than
> 
> (dev->api_version == VDUSE_API_VERSION) ? ...
> 
> But now I think you meant
> 
> (dev->api_version < VDUSE_API_VERSION_1) ? ...
> 
> Is that right?

That's right.


