Return-Path: <linux-kernel+bounces-817214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3F7B57F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A967B7A9D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0391F4C8B;
	Mon, 15 Sep 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD8OjTFk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254E4D599
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947577; cv=none; b=EnZ+VRPIAZChQyOOFMSP89bei2QJQyM2WucQqBpW3X46GU6HAMSyIv/Glw9ASNjIWMUbCmfGCpcRyCtLXoRNq+q3z6CSJmxe3iIoa1Y1PaI15eEl/LGISLfRyzZrGPM2F5qtC+udYLNvv2MF9/7eI3owE9CYZawydZVbS1p/V7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947577; c=relaxed/simple;
	bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJf9gVBI6nEn07LmgGskZkiz5P3+LpsOmShf7jPdsnHFA8UTTKyM1EpG7VAtEA5S4zrZks2vDGd8UKrhuPqhJ4UwOJ6kVldYvSco9VDvvTuAK78T8q172PV0fVfamDM3L4i2O+rlm2OA5eMsTWWn05KovHe72P5vwvULjgrfVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TD8OjTFk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757947575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
	b=TD8OjTFkKo8rkRW2NHfbrHVN9EJOfiwcICs4SCaZqNgOJVLN9Oz9TqycvJlHnFbG5DuNwd
	v4N+PVuRjmVNhJOMQVrIJnsc+kZwCJzsvFB/44XxwsTPHRhv1VmKz3REP7QxRJxiIazZJR
	y2meAnjis4KM8+r5Hrqcv9A86T4dW2g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-1yc0yqVXPk-xiRIz_3dcHg-1; Mon, 15 Sep 2025 10:46:13 -0400
X-MC-Unique: 1yc0yqVXPk-xiRIz_3dcHg-1
X-Mimecast-MFC-AGG-ID: 1yc0yqVXPk-xiRIz_3dcHg_1757947572
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b04145e8615so296416966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947572; x=1758552372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
        b=vNxmdXXxaVycdQhQ6VOKTBxR11LAqjEMRhvM+utW+tbTudVqimHjtv8SRX6oUyTWxR
         BiAHTlx3PlAmX5kKEX5GOrYyCUDfioXaqZaWe9NPqyCwK4QXmZ7KQUx5SEoVVG2oLLLp
         hUC8Z49ky8/AnMqRt0NAP214kkiX2kSPJykjEtv2MM6dPr+1OV5kHTkJ1ajd79izbkWy
         T7JSbb6153CLSfBKJqOz4wiICi4s98t0YdOQQ/PUFPd4pVKCAFfyv6N8hYQBpdPZ+ky8
         SnbSASKvdacVncCP060GYxyMHMRSqh1CckeIt0C/JzlAHaM35Fysw134lzV0OYD+9gQw
         iV6g==
X-Forwarded-Encrypted: i=1; AJvYcCUkHR8AIEzaNYmH4Dv2uDqfK7Xo9JSnoRZ6R04g2Z+fyTJSvYsTcTcGhMwqEK6nO0m29J527hHO26x4fA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wA8K5UHGaiK6dk+E8B0smckCW+QJm/ym1aE/psYCEyoN9+Z9
	08zEPnW5mx6HaBsyWjV8MO0khAWGziPLZR1C7lfgmAKnyCMG0R1LfxVZ8wX2o+gpT7sS4X/UK+E
	B5G1Qg57OeYkEfMTxkvcnJAvE0iA0GRtAZWm8hK+sJgD+FbWR7CoHUklDFse9iU5tDrxBva8XSL
	FXY9A5sKGCfcvrtIoYipTlmV9O+VrHlSMTs0uGsCd+
X-Gm-Gg: ASbGncvaOx838fO9UWmd8+gdXEs3cnRnv/E2w9h3QHv8xLKsdA4AM2ZhmV1dgCX0lmr
	UlkzLDRFs8+VO7tkWnT2rK3ENYaUa5NItw2UwG15y84d3x6fCV8hK5HmEj0RTHdcCXUU5XXdHtK
	amts5VGTvLUTvpj38TX2QIdw==
X-Received: by 2002:a17:907:3e03:b0:b10:ecc6:5da3 with SMTP id a640c23a62f3a-b10ecc6640dmr347176566b.63.1757947571748;
        Mon, 15 Sep 2025 07:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERqnM4TDFaglXTZ1TiljWgRnJ/XQu6e2iToInrsLSac1TYz5imtwKAo2yzppRLZeL61hsUVinU28MLjkJY0qE=
X-Received: by 2002:a17:907:3e03:b0:b10:ecc6:5da3 with SMTP id
 a640c23a62f3a-b10ecc6640dmr347172866b.63.1757947571319; Mon, 15 Sep 2025
 07:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
 <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q> <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
In-Reply-To: <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 22:45:34 +0800
X-Gm-Features: AS18NWCPqkI_mOz0DI25Cy8SLU0CdLKom07g_re2BVpx_B9ko5kxeK11-LxKKX4
Message-ID: <CAPpAL=z2YXWDV7HVeSzZbTAUNrb1h4R3s1kmWSyjXp_r7iar8g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:58=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, Sep 15, 2025 at 03:55:53AM -0700, Breno Leitao wrote:
> > On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> > > This series of patches introduced a kernel panic bug. The tests are
> > > based on the linux-next commit [1]. I tried it a few times and found
> > > that if I didn't apply the current patch, the issue wouldn't be
> > > triggered. After applying the current patch, the probability of
> > > triggering the issue was 3/3.
> > >
> > > Reproduced steps:
> > > 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/lin=
ux-next.git
> > > 2. applied this series of patches
> > > 3. compile and install
> > > 4. reboot server(A kernel panic occurs at this step)
> >
> > Thanks for the report. Let me try to reproduce it on my side.

Hi Breno
> >
> > Is this a physical machine, or, are you using a VM with the virtio chan=
ge?

Yes, I test it with a physical machine. I didn't used VM=EF=BC=8C just inst=
all
rpm which compiled based on this series patches, then hit kernel pahic
at server rebooting.
>
> Also, I've just sent v3 earlier today, let me know if you have chance to
> test it as well, given it fixes the issue raised by Jakub in [1]
>
> Link: https://lore.kernel.org/all/20250914125949.17ea0ade@kernel.org/ [1]

I already submitted a job to test v3, the test will be completed
tomorrow and I will update the results promptly.

Best Regards
Lei
>


