Return-Path: <linux-kernel+bounces-897778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76224C53894
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F5544240
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEB3340A72;
	Wed, 12 Nov 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDmG2PYE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC+271f6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54C342CB4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966150; cv=none; b=b+Fa5c8u8Vruq+LZT2cXWwMaGL5RKGC8+ov7fJoHWa7+n9qHAwomlfqHRGKj2OWP+9+XH2Zq4PuNqJFm8AU3FPpANqtSiuJ+MW44P0+zQdqsAbDZPg8zKv09fPDB72buMhEUWT9Df4QeDHPsWJXMMcU+c9PgTMQGbSF98O3c10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966150; c=relaxed/simple;
	bh=yzJtWdMT1CSwYPtr1yZUG8pMMEoemT4XzUq0eUYhnQE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=utUSO69Pj+bo459+YXcG3LOt5mf7n2J5L6RL4vN6gPtij2tgn7dY55q6/KKWscsutfqzFQzRocvN/U/RmDpYBOvO0nsygwuExg3HcsrV6b9wRHMWeNdKYpi2JvomgEQQPExywFvNPFrJSoVK2+4awFknhFGBIxUF9063syU1BKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDmG2PYE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UC+271f6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762966147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vau743XOutCT7ZaDBV7vi7WPKrVykTyysCrhrB+GhO4=;
	b=NDmG2PYEAYZ2xZ7NA+bZvEJDjSxwW5nw8W9VJcLho9Auf0k5HQKsfdI1WV/rPIN2902X6X
	jSvKdkh5zqtWjm3ZYjYeu6DzPqQfj5kelgF1Vv75rogJlvuUmrol5iUZ7te5ncXFVVcUWw
	FXN/9ch+wjuyz3pIE1L8JGnB46v70iE=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657--LtXil2uPxq9TVi1cPBK7g-1; Wed, 12 Nov 2025 11:49:04 -0500
X-MC-Unique: -LtXil2uPxq9TVi1cPBK7g-1
X-Mimecast-MFC-AGG-ID: -LtXil2uPxq9TVi1cPBK7g_1762966143
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63f9c4e3701so1601173d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762966143; x=1763570943; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vau743XOutCT7ZaDBV7vi7WPKrVykTyysCrhrB+GhO4=;
        b=UC+271f61jpbuO7J0msGraKLdLm0AyEWsuZ9rU+cleu4UYCXIEO7QCLUXpNCkdtjFp
         bmkjiXSISWuIZ70VfsKWbuGVR/xkbdYfDnjTJUF5KS3/HYTJeyEnndgx/lm8gZ3TrQ9p
         y8u/qQifHu7SpaSUZvXUbaiz29I6Y4h3zdykmeWzsEgR2pEVitb/POSm9jQpwqPnqjjg
         fqeMdxNkgu6zdYyOA+qmhWGW3LNxLQSKTXE5mNbRlotrO5W9m6jGqTi3e+8uBnFbJ9mm
         CqcBJmz+U0DwEWWXXfNJidKDvR0aduh8ApUiqMBRuBR/sk7JHndoK8gAE8/uRNfeZRCl
         3DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966143; x=1763570943;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vau743XOutCT7ZaDBV7vi7WPKrVykTyysCrhrB+GhO4=;
        b=MMw43DpaStcBdpxpKSzZqpkbblMGu0pLzlZgKjJTI/FycvhWA4e/U6xWv8VJTQPwBX
         ALd9qG466kR1gcW6pidyVu2gjBRoYroeD2A6xBkpssHpmIyFK1/g1l9dpE+OMGZIg1yc
         SOoyR7N5kT5MLMI+3kBnFUy5hGp01VHT7HGsGZWy35hAhjl8Gt5dp1rK5MX5E27aCjM4
         AiJvg+gm6yp5hikDo2eYvECkJsifH1V4g9sgBNzU5AYB0ACxCmJsova9TwIKlSiULash
         JUamyfpUqv035HUWn0v6XrEAipHa2Bjb7Iq6w0TVk6LO/EaoNJMXFRV0hSQahpfFN628
         jhNA==
X-Forwarded-Encrypted: i=1; AJvYcCWXDugctwu1Ie83QGR93NPpV5xbLbY6JB+0cHMFuDbifRCNr/xnYXBBwY8j92N13iVuqXUDwKBln7gjADk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++fqokYDuohaGIxSIcZT9Vq3JV6avyb5ocMhl4OGghomhGVj5
	q5zasygljeAQFbviNpYSMa0B1jxXMg9IaRKB9ifUBTIOD9Q9DuxukbrkWtdUAzQNjSmufpKkLaL
	mkdy/DQ5QzPw9dxwqi2lV/0qPgncHl8XIi4tLg2Xt088CyOZ8RnU5yHXwt+OYpityDAjR5p1SVt
	WegaiZ0L+twD+5HoarEh3d1kL8LNNHeNdtxcfJry6s
X-Gm-Gg: ASbGncu+G3fI5hm8i4+irv/84tHGQ/OvM4bOtnIezl22zRsYC3xWEobYmE2tNkO0afs
	z6DP6wSZu4I1zPvw216ynUrb+4bnqqzdsHqN7Q6s/gGJN6J5JPFPnooHISiObkC6dS+zKvC9xdM
	JgR6Q0h1SknPrENm8h1oLL/C+Um10mVhRvCqSo9NmV/+bn90wZ7v0NndNziIGymFkijcx8zWvad
	lvhrK8mePhirlk5bA==
X-Received: by 2002:a05:690e:42c6:b0:63f:7da8:6b8f with SMTP id 956f58d0204a3-64101b3c87emr3056760d50.54.1762966143616;
        Wed, 12 Nov 2025 08:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmvC2Azip+GS36nKybduxfa97rWHb0V9T2GYDrBXHG+e2gKAEKaLd+WmmO83FeDXeTSFKsNYVIue/h2ojcATo=
X-Received: by 2002:a05:690e:42c6:b0:63f:7da8:6b8f with SMTP id
 956f58d0204a3-64101b3c87emr3056733d50.54.1762966143267; Wed, 12 Nov 2025
 08:49:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 08:49:01 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 08:49:01 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <855ebbf1-0b02-45b5-8fa9-b50c05793e19@collabora.com>
References: <20251110125213.12633-1-slp@redhat.com> <20251110125213.12633-2-slp@redhat.com>
 <855ebbf1-0b02-45b5-8fa9-b50c05793e19@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Nov 2025 08:49:01 -0800
X-Gm-Features: AWmQ_blkfmU4xkkhUO-M_WcjqEKuzPzp8_FWp2cGDYKHwbAkWUXG2xTRkwnWvs4
Message-ID: <CAAiTLFUbJ-YpV8+05PofXpmgOu=gNmUh9L6xgj_w80_mf7z8Tw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 11/10/25 15:52, Sergio Lopez wrote:
>> +	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_ALIGNMENT)) {
>> +		vgdev->has_blob_alignment = true;
>> +		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
>> +				blob_alignment, &blob_alignment);
>> +		vgdev->blob_alignment = blob_alignment;
>
> Shouldn't blob_alignment be max(guest_alignment, host_alignment)?

virtio_gpu_config is the minimum alignment required by the device/host.
If the guest requires a higher alignment than the device/host, I would
expect that to be found by a different mechanism, as it would happen on
gpu drivers other than virtio-gpu.

Sergio.


