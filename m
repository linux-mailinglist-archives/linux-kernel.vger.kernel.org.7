Return-Path: <linux-kernel+bounces-734654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A3B08464
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72283566ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC91F9F73;
	Thu, 17 Jul 2025 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d02XGtx0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276521576E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731703; cv=none; b=r2936zLbZgmu+GhE/1YEqpBgUmUyTP5OdQHdWisOnUlcSq8u+J+fVV3pQLy2ftxfXe9xkmjTOue3cNigsTCyvtR6LJI8wFfAt0qt+lMZCjhIZcUTKcZK3XVYRctRo/Ym68h0KZMXnSEvfA75Pdy8xF8aRH7Yzs/+lH8TC7hQ2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731703; c=relaxed/simple;
	bh=m4gQAyHYuuJrm9YUv7NlPCUouAw8kLG5UfeMrAnYE6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPkr/NpavH6qunb7t52DzpnE0xDrS/AhA9NVmgFO8jdChKQC9cIftK+YLec5Qs/NGVeO10K5Zii0qt01UvGZlHAgyg1RCKY9Lh1xUC/w8Y9vuBjtq/Df29swRNHZRUr911WA0PitysxODJIKWJcU5b6hEsqmtyfx+eCdB6ugd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d02XGtx0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752731700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kE0G9wXRbk7fNnfl6vFgdzVxCOzno+UfAnUTQ9t+cLI=;
	b=d02XGtx0H5tdFQ23iThenHE4Va6vi5gIqllKQqHXKtfxzJkxvH7NN9Mnx0I3cWpz38jB39
	AYqu28rlxQqZOErZQL3xPUj/8ANbI6ZYhMfYg00YBKDxG+/FoWpMI2EZ67suM+v4kRH5UI
	88zn3dTMQClfRdE75B57VOk0xkxVWOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-lDGJ8NGeOcSjYDF5z9MivA-1; Thu, 17 Jul 2025 01:54:58 -0400
X-MC-Unique: lDGJ8NGeOcSjYDF5z9MivA-1
X-Mimecast-MFC-AGG-ID: lDGJ8NGeOcSjYDF5z9MivA_1752731698
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45624f0be48so2414145e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752731697; x=1753336497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kE0G9wXRbk7fNnfl6vFgdzVxCOzno+UfAnUTQ9t+cLI=;
        b=peO7AvpGhEDxNcr9JSgfLQ550fBgd9PIfztbNQjUzx5OigyAuvLcPoWiHItTdRxxWe
         BJj+K+PficIwsSDbe6E2PJyy5+tavpIQSrnxyiOaztczJ142VUZK0DFdqZPyFV95ViRo
         EKvvjKk49wwAF6oFsS7HvbfMjHoad91cRFDy5bBIaLRpsRTXhXhn0wwrbFhUz2LYJQZW
         VUTgYADrGdq4+44IYknpfeBhahdLDU8ODhRupmWSnAw2hc2Wxb9PfxmAnY1f9j84CD8V
         mYtsraLmOaXKHvLpJUqJBgEPck2uhV2ASUz5HFNt4/N0erG2Ewe0tfsjg70KCEKKMZiT
         c5fA==
X-Forwarded-Encrypted: i=1; AJvYcCV4r0f5vKsu243wRyUS3tphyPP3TJXswrBRwOO5D2KHFF1IfJyE+eSp/mObuswhl1im6cCUmc9EKnWyYyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3DOriSeUZxTVtk7J/Snh7zzjamSpsV6cVnNwFbd8GI2bWJnF
	YrBJSjXXpMVjsZ61utmdsonvyS6WrB1xy6MZE3ki7XUTT0rbVNu2z1zDb6uBOoekTZF64VUuFLk
	8Bh58Itu+TejSNmHYvW7HNavDvo4G3upCjQitculYINFP6qpc2K/OllM7ngtjd+7dFw==
X-Gm-Gg: ASbGncutKKf4fUoRuRuvONkFQ9vLY8YG2JgONriZZvxJOIutL1Jp3YiHKYFppxOveNI
	k5TxU9ZxtUWRYYjFn4Rjv83ottgdrmOenLJDGLPzPzI1Hx1Aas9dXDbyHhkj3I+RkZUE0DjDdrN
	lW4vgGmrfmCX4yw21A/ZWToMrilsjVLP4IF0Xx7dzRG5SLwofIVf6hFOa6nzlIuiA4nh60LcMHA
	Q4hBJIaa9T1zYpWE8meZ1UQVAut6kS2w7twMojsLybThYdmQba0UttX6Y3Ct92LwdcugOxkirv7
	tdYgEdmKfI4U+RVc41qWpbhdrb96X36q
X-Received: by 2002:a05:600c:a306:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4562e30bb16mr31847315e9.33.1752731697638;
        Wed, 16 Jul 2025 22:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyU6o9Q3CoUlYWFKgakh+xAw1rIC3vPhNwaIEN4/uUvZfr53w1uYu1w84EorH+yJxtkxDubw==
X-Received: by 2002:a05:600c:a306:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4562e30bb16mr31847155e9.33.1752731697218;
        Wed, 16 Jul 2025 22:54:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634ec9162sm11757495e9.0.2025.07.16.22.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 22:54:56 -0700 (PDT)
Date: Thu, 17 Jul 2025 01:54:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
Message-ID: <20250717015341-mutt-send-email-mst@kernel.org>
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>

On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > > feature is designed to improve the performance of the virtio ring by
> > > optimizing descriptor processing.
> > >
> > > Benchmarks show a notable improvement. Please see patch 3 for details.
> >
> > You tagged these as net-next but just to be clear -- these don't apply
> > for us in the current form.
> >
> 
> Will rebase and send a new version.
> 
> Thanks

Indeed these look as if they are for my tree (so I put them in
linux-next, without noticing the tag).

But I also guess guest bits should be merged in the same cycle
as host bits, less confusion.

-- 
MST


