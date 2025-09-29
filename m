Return-Path: <linux-kernel+bounces-835765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC4BA8017
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885B6189A840
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68229BDA5;
	Mon, 29 Sep 2025 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyNsbwHT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06934BA53
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124516; cv=none; b=HuIoiHc/29fHCd1BKvR3sbVbhePvnrA7mGUcAq4NhjXA0RoMGRzeFUZBkdLSGEcaZrt5zPitaHk/mcBsC3dk+MEDpTdboCbX0RaspHbxGKjzfffbw76BzYAuQgm9SNLSAVOOZ0xEZJeYEpHBJ4v3o5RPAufrbYOgmEyl42vVh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124516; c=relaxed/simple;
	bh=fk4qbcimRIVrb/YTG3/0Q28P2xDHbRO2d0TV3Hpr9nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2sqWkgOj3xnFkEQuRmS0O1iha9l4IHneoKYV/lkS5JTY0gR4wFcIo7NRvuiKcInwz0+ExrJWnlRgItgN2QtPkP+r16CrwLLf29NacJxS2hb23Rh6D8dxXDFz6PrqTIhvLpL6UWI51QKlbpSJE+FLOnXrSX3QGYgOqNx8Q0V93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyNsbwHT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759124513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kslRQf6+HX/+lCOPEQ+nRCdpHTGfTTmG8vjQfJ7ses=;
	b=CyNsbwHTUkzBF7SQuhFXANcfPr6dxvuX2h5nfw45041urvzJxw69+u11cbgo8NJ+qvVXmk
	rfruVNBfPrIyHntJNqqofPe/SEPnZ2N9Qhf7Oee//OhBtlDymdVbGgQOyd3AV715HKBE83
	f5XX4hlkP9Z2EN99QSta5qExk4Fu5kY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-I4EuMX0HOWWYhVW3pkg8zw-1; Mon, 29 Sep 2025 01:41:51 -0400
X-MC-Unique: I4EuMX0HOWWYhVW3pkg8zw-1
X-Mimecast-MFC-AGG-ID: I4EuMX0HOWWYhVW3pkg8zw_1759124511
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71e7181cddeso55755797b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124511; x=1759729311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kslRQf6+HX/+lCOPEQ+nRCdpHTGfTTmG8vjQfJ7ses=;
        b=cEG1fkx+EZmdCgP8CpsA6JoBGErSiD8WoCraupL+vZLmSpsrUW0KhCxz1qo0fPPfLH
         IVZzUzRVDeOPY4x92VpuFqIOa1yLC+LBMj//ZSH8fALLg82wW0VDCPiGiszHwZIk21lC
         GGMhesrEakSlXZY5SmHGErDFSvytlxUJrG6nVgrarDrMvHLMjW8Po07tP/9DMlCrzty8
         2VRoGpZe7J8QNGVay+L1qqAYLTNW86kFw9JE1xNbjvtTi1BqhFXseIpY31I0b6OtQUK/
         Dds5P89Hj2mBZhv0poenyWePegPEZ6r6Yq7LqdAWy5yDDVqb2Pen3e3XBy0yZHt7VRpp
         80qg==
X-Forwarded-Encrypted: i=1; AJvYcCUo0giCMqAVuQgrVlaZKKB1cl6AvM9lrtYf9V6iZM8u2YbbCKVvimH406Bfq8biYPpMwcvugYHOdA44KvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49EAg4xtts0EXEBHv8d1TsnFAJ97wfemD4BMjzVjPNejhaLHz
	shWV1VcW8Tbt8zhPnrR2shxUM3q9i54ccV7SpxB7Hasq1zxX4bbWicB3c+WCWRK6Wa49dOb7d2V
	RS1DeFdQgMB++Ug7yyZJ15FZFwchU8xrxA/drZ7/nhTVExHZfz27sivCYq5xEqg/ESP7EmeHv0K
	NWtV4JnkcrugS9aF1CoID/EvN4o63t/rcNVSu16Irx
X-Gm-Gg: ASbGncu0lOYgDIe/Qqz+Q5SY3A71h4RWvbM5RxLXwKtlbj4tTBchBUtqkIQViTujyFY
	VgdvgL+p6WLVRvovlMEp0G4P7/0qHsa6vlc9ijjigGH8rEf0ifzpJemOapE+8kHWh2JUY4JNeaQ
	inZG8gCDpiQvcsFpO+0gUCAoqK6nUpY1nCh1luuA3H/wXHRBYZ8p2bsPjsul9sBrvAGFh/XpWE3
	2aN3lvm
X-Received: by 2002:a53:de4f:0:b0:635:4ece:20a2 with SMTP id 956f58d0204a3-6361a84f588mr14971431d50.39.1759124511264;
        Sun, 28 Sep 2025 22:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN/KuwMGiaQ4Y71OKlWvzfV2Hk0k9ZHHw2NbLQ62CQzUn41nWnAvu5q3iEOvsbLHhIP2zwhwc4xZ3MQ8EELmQ=
X-Received: by 2002:a53:de4f:0:b0:635:4ece:20a2 with SMTP id
 956f58d0204a3-6361a84f588mr14971424d50.39.1759124510955; Sun, 28 Sep 2025
 22:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926103421-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926103421-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:41:13 +0200
X-Gm-Features: AS18NWCfZLmE4sIylnvDwOwGoN7qyazMg0qrjMKhNVJd3otrQDdqka3G_TAQqNQ
Message-ID: <CAJaqyWfeiAiNOBtGoEYK7PLncXLMO+wZ=Gse+=X0FO65qQO4LQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add multiple address spaces support to VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 12:14:26PM +0200, Eugenio P=C3=A9rez wrote:
> > PATCH v5:
> > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_F=
D
> >   ioctl (Jason).
>
> ???
>
> I think copy_to_user returns an unsigned value: the number of bytes copie=
d.
>
>
> static __always_inline unsigned long __must_check
> copy_from_user(void *to, const void __user *from, unsigned long n)
> {
>         if (!check_copy_size(to, n, false))
>                 return n;
> #ifdef INLINE_COPY_FROM_USER
>         return _inline_copy_from_user(to, from, n);
> #else
>         return _copy_from_user(to, from, n);
> #endif
> }
>
>
> so, how does the patch work then?
>

copy_from_user returns the number of bytes that could not be copied.
For example when the object size in the kernel is less than n bytes
long, check_copy_size returns false and copy_from_user returns n, the
amount of size requested to copy.


