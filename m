Return-Path: <linux-kernel+bounces-835916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C116BA856E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E125189B36B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05537264623;
	Mon, 29 Sep 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqGJ0Cz5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC29260588
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132534; cv=none; b=brpyY53/mBKZFRLPwDcjqMO1Zj66xHFqEFTXsQNWMH1e47CXQZWbz42PJpWAuX01cbBBNfBsxuckbqS8sbfI19gjL9AgVXC/y40TzFRPv8nIVqS+KJ4q0QH2Ikg4kdS8NGwrdO3HSsbRQwFEeVFBK4aNCCUks8jbxkTrsCogCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132534; c=relaxed/simple;
	bh=lqTu2Wn6YlBhGAcSVpHOpoNC68jYPa6E4hsETWv4xyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyehN5sMSvZu98iBrbrsbOrTSCgPgfECKoIQ1zvCNBgjNqkMqlSAQfgb7yLIkB41wzt9KjankD3kANFcQKYwiNn3bcPlqOFuyKGOUe/T/Z7TtOnH1huwlWt/YHhXDvAQQALsdzS8T698OWhrWgOOWGyi5vTfdoeSVclHSwzeNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqGJ0Cz5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759132531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Omunrqw51MkpkcIN+kqJsam42py8x8dM1K62pxn/zA=;
	b=FqGJ0Cz59v8ouEkRiqzINgGccTiTGbN5Rfrkt5tHZJ8+62NIv/fmYro6eTnP9K1hwoQTH7
	8nMqML3F1CN9zoxt6BEkNlGPOMo5S9IArrG92oG7bjMYC2iBcZ68r+2ccmFrR9MYU9Hhpu
	ryoTGGy/UNP6uLniYEShAzS4olfHTG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-6agfWiQdPuCbdmSsFFosiA-1; Mon, 29 Sep 2025 03:55:29 -0400
X-MC-Unique: 6agfWiQdPuCbdmSsFFosiA-1
X-Mimecast-MFC-AGG-ID: 6agfWiQdPuCbdmSsFFosiA_1759132528
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so2564861f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132528; x=1759737328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Omunrqw51MkpkcIN+kqJsam42py8x8dM1K62pxn/zA=;
        b=YTxaCCYRYZDbKu+vLKlJ6lqb8Sg0nEbNx5Z1gtwZyWFG/DBg1001C/CY8/LjmYke6a
         apR1IO6xmGkyMyV/srb07aFPGKfZcrcfqIIL1p6sxt6J65pQZ0ImQ36rdr/GY9VREzY1
         BxKDh8ovhISOcFzFaHWNaNG/ySGmwxtCo5w0i4b8fbitgSqCS1MegH0wphYcH82XHlSY
         N4RErE0o8RecyLTlINook26zjAIxH4AVA9YZJrmupH/ueQLMYCnt8kgifs9PL1OrsFZO
         /Y7t0Hoio/NNMqjRi5NGaU4WbU9jtM9nFr5TkeBsGSOItGx8zRmeM17vZIwMRXvs4Ea1
         3NMw==
X-Forwarded-Encrypted: i=1; AJvYcCVEwieSdtkKjSnJ56uXZZNvb9+TBt+pkO1yN0huY3UY4KCSSk6oBS+Fq71eF6Sqi+kRsNa7+TBkCDWleCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykc1WomxLYtXI1jb5RAKVQRjFwT/suqTIEgszibTlZIuodNTxe
	j8G+42TbVZ697ScZqgiRbpeHgkZuTNXi8IK6wfj/dBZV+EJNU3rk/jKjZsGOaLisMmAEPivl/V4
	t24MBT/STqrdXgAQLllU5hIBlssvKzkYTMQmtOtzK+TzRCeCUc+bTyX6SHkiB0SS1YA==
X-Gm-Gg: ASbGncuy5i4UwFUZPpDy2joJlhAslpLbpIIpSm99RRKfBgMjqaS+FXElIGnP91aFxpE
	vD1Z+rQCb7vQQShdgrc2unm9dMh+OQBws/UijE3IVEPedozfCSUdvZLrIIM7v0JRXuvZNrws7BO
	0oo1JWGMTVuwYHSP8Qu7Z+tHPrJ+kmNk1UPtMO8Nnd+goTEWVp6v1LDXw7ML0ul/RPTcj+whJEW
	09Ox2pu/lnQomc4gJ+vxSP4PoZMdmhHyEwsVZTFs/Tr/sSC1vtyUC0adAWr8FS7PmBr0GJM5QSu
	GsTgvKRjW9kgyoD7Sh2XpC3Gy2vj1Xcf4Q==
X-Received: by 2002:a05:6000:310e:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4180686140emr6760221f8f.21.1759132528481;
        Mon, 29 Sep 2025 00:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZHcNFzklivkL5bSzSWgmb6E+omLFHKnQN2HGuL3HJ7RyfD1N604PNWqxQXEmEA9uXKAeybw==
X-Received: by 2002:a05:6000:310e:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4180686140emr6760185f8f.21.1759132527990;
        Mon, 29 Sep 2025 00:55:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2ff6sm17002153f8f.56.2025.09.29.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:55:27 -0700 (PDT)
Date: Mon, 29 Sep 2025 03:55:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250929035510-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org>
 <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>

On Mon, Sep 29, 2025 at 07:55:59AM +0200, Eugenio Perez Martin wrote:
> On Fri, Sep 26, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > >       dev->device_features = config->features;
> > >       dev->device_id = config->device_id;
> > >       dev->vendor_id = config->vendor_id;
> > > +     dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
> >
> > Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
> >
> 
> The macro for v0 is called VDUSE_API_VERSION, so I think it is less
> intuitive to put:
> dev->api_version == VDUSE_API_VERSION
> 
> But I'm ok with the change if you want.

Confused. You mean "more intuitive"?


