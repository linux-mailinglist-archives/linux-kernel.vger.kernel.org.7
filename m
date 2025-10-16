Return-Path: <linux-kernel+bounces-855579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08BBE1B05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B9CB4EB75A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC82D3A7B;
	Thu, 16 Oct 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl2Kr56D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7B2D2491
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595732; cv=none; b=BQjjls/kMYLsfuLgEQ/lnkMYM1erFbDz/cl/9crMPBYlvRMcPNfwyF9YBSX2X8upsPEbIpxNMH6/fZac4dViMTOB7bSilxxWo/y8g5Vm0y/+IZOX07xDfbbtoF86L2Aw5wDc4BmzyRshZ3KJNOeehqkAl0xuN5FlI37lrbbgJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595732; c=relaxed/simple;
	bh=uTF7g4P4MDcqLlbbpaoY1ppAUV6kqErenYf6eY1HF/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCDQlyCH1RMFtj2QjrYh3r+eAx5GXn1iE2VuxyR8r9TjRXiv+X0tIohiCrHUJL2Ag8RlOHSbOUidn3d7cjf8SNq3BviwOVp9hB+9JgjfdZriYuJam5WyVzCYbLpyAA3Q4Ea6ESbI3lZjh5bWBW0wgpq1hqT4/wQghA6VvzvofSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl2Kr56D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760595729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inFv4pKsvQ1IVMUNO3/+DKKfq2HKDKi/cjwCFHrQEC4=;
	b=hl2Kr56DIYauXkEFJgfXgktm9BHyF+AKOG7b9LeaWSUX+sQB0I+Z6FSFNwh8LGfFfZyYiD
	dbYQVlJvHQhAbA982GZfe/zzKyzTZUMSVgKSf/EkBI5jJuLZ7d93MNqSDPPH3tG42Ipx4A
	783MkIttppChy8QxdZQr5CjbM1GGF7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-E4WUn8DCN0SlPDTL-XjZew-1; Thu, 16 Oct 2025 02:22:08 -0400
X-MC-Unique: E4WUn8DCN0SlPDTL-XjZew-1
X-Mimecast-MFC-AGG-ID: E4WUn8DCN0SlPDTL-XjZew_1760595727
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso4882905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595727; x=1761200527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inFv4pKsvQ1IVMUNO3/+DKKfq2HKDKi/cjwCFHrQEC4=;
        b=iDvOoiQmuWXod+q/6eD3982NbhX95EAgEp1txAnsElyzrNAJsgT2CPiDxrjUnK/I79
         E6SCgCHvbqP4LFp+sdraikIK8Xk1Cxfm8yBMqVugeStH+GjOjFcBdQTYajHPyw03YH8F
         wGyOOXf4gcqNdbGgds9XH6Aqd/L2cTO7JD04iwcik+lzyL04/ZmA7JTtUeXxeGEEXj3+
         PBh40gk05LSoHlf3svzBBcHc6PUupbXMkN+GbsMt5vSTvfuccjf3LuLl4odPN2qYdZOl
         xp5nf50ohZiHqjkNVe9ZOeJr6t29qV5105sfhYguOO5ykZeCD9XKa4hUf6UPNXCH5YBE
         IFfw==
X-Forwarded-Encrypted: i=1; AJvYcCUO/8QSdUKL1+rWKAaSWQhbdCKxPhqfCGNixVTVm4CVhFdfSsJGj/60Ofk6I91Z5qEDqh8Sj54gyKQz7cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHbBLl4/3nPYjwDQlbknHmbVbA/iup3Wt9f4uT4rzYzvzw7KA
	0liOVldZx9w4Qj7OEnfFHb0nQ8EiBlvI6KTGDpYm/+PYuuH8j1BDfICE6JZXtaM5Vn/9Xivat5q
	64tZbySbzPC4VGCplMbAh5433DUpg7/MdN7yygxBKp4Buph+MRPVHIK51eMOr1Jpxgw==
X-Gm-Gg: ASbGnctC4+yGzpac91yE6+oroIaYx+OLyCLfdMDkUrEkAJbuJatOZr7q/v9nw43tS5S
	/+8TsneexP91TTiOMGxJPx6iUQgw1AruU3dd6vBwwIViAdEtqDY+HC2m1c5m+yAg8tFC0bPf2Sg
	+GUdVHMvKUfh7Wn6AkQme1s/NCQpMb01Rc4PVZeWXPAJp2I72mWzdv8lqmQm2qv9Yq9gZgNN9IN
	oJkobwMgQtZAJ9X3SVyInzebTH+eOqeoTYoSWKJFyNVWcVewtofFJPeo/oU7yGCd4d3uQHYI/FZ
	roMmf8P9RgiMzX5Q6vrDutltxb5ms7eUsx7Sc2RrfTjj+G68kxlQ1O7z2jpDg1m3EGSg
X-Received: by 2002:a05:6000:2601:b0:425:8334:9a9d with SMTP id ffacd0b85a97d-426fb6a1f41mr1604069f8f.1.1760595727442;
        Wed, 15 Oct 2025 23:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSDVD4VRRNvVpaIAkB8ninQwYqvJlQlrSELMHHp5BQcgOvDl48VbYVxjOOEbXoKTiADW5LyA==
X-Received: by 2002:a05:6000:2601:b0:425:8334:9a9d with SMTP id ffacd0b85a97d-426fb6a1f41mr1604053f8f.1.1760595726908;
        Wed, 15 Oct 2025 23:22:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114461debsm6689605e9.18.2025.10.15.23.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 23:22:06 -0700 (PDT)
Date: Thu, 16 Oct 2025 02:22:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251016022131-mutt-send-email-mst@kernel.org>
References: <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org>
 <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>

On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> On Thu, Oct 16, 2025 at 1:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > >
> > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > 100 messages to enable/disable promisc mode - together they
> > > > > have no effect.
> > >
> > > Note that there's a case that multiple commands need to be sent, e.g
> > > set rx mode. And assuming not all the commands are the best effort,
> > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > while.
> >
> > Not wait, record. Generate 1st command, after userspace consumed it -
> > generate and send second command and so on.
> 
> Right, that's what I asked in another thread, we still need a timeout
> here.

we do not need a timeout.

> Then I think it would not be too much difference whether it is
> VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> can only advertise NEEDS_RESET since it's a device implementation.
> VDUSE can not simply break the device as it requires synchronization
> which is not easy.
> 
> > But for each bit of data, at most one command has to be sent,
> > we do not care if guest tweaked rx mode 3 times, we only care about
> > the latest state.
> 
> Yes, but I want to know what's best when VDUSE meets userspace timeout.
> 
> Thanks


userspace should manage its own timeouts.

> >
> > --
> > MST
> >


