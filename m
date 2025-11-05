Return-Path: <linux-kernel+bounces-885763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E0C33D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59F984F00F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6126CE3A;
	Wed,  5 Nov 2025 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDwDWj0r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYcBt32u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05B24469E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313768; cv=none; b=mCxD5Wv5Vgsr4bGtfLxcdIF1VgJlSRRd5TwOMH3Tlz8qdqAbMOB15YMp2rYPk9e6Y+ybEzuUxY/J1GAKHm0MFQkCB3hN8CtTAX56Yjpoi2bQzRcmbaGr2SpRVSMzkvoL3jFpo8vIU13emHGF0JULV1I2xdDJGK3cbZi06ApmkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313768; c=relaxed/simple;
	bh=3PeYTbupN2VISfwGjv65aYeNXt+0FlfHZjEj53N7LO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BA1KY0XIw3Y0Iue3KyYBV4V+RDnME1EML/UWq5sniBes/bxt8y08BEoL6F5CvOckz2A9PTIliQBJSUk1SDKsY51IqubsqGBElDCJ3WI2uWJXYEyvv1K8UL0+3Po7JKYGmU9ytV0C8xwVIjEE4uZjT59CYy3rL51WqAqIj990DqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDwDWj0r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYcBt32u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762313764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocA7y4ZtA8+hHznDELnZyszTc84eNA3IP7qXnz+EX+g=;
	b=JDwDWj0rkeAHQibYLnipo/Bf5fBk8zE5ivEyr4FRgCKg5nILjhUsIfke2wJ2k707p/nyh2
	q4+tnYgB8ZnrXi6HWNpoMSENmtfbeSJsxpS6ltYcZ/v3jKk5Cb3sSZ/ciLaw2T5ifyMaRP
	LjXhiQyaYE2Cq5+jSV7K1gFf4BIYE+o=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-CannA03ENLqaT5Ts9xnblw-1; Tue, 04 Nov 2025 22:36:03 -0500
X-MC-Unique: CannA03ENLqaT5Ts9xnblw-1
X-Mimecast-MFC-AGG-ID: CannA03ENLqaT5Ts9xnblw_1762313763
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9351a957f18so8277520241.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 19:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762313763; x=1762918563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocA7y4ZtA8+hHznDELnZyszTc84eNA3IP7qXnz+EX+g=;
        b=bYcBt32uppfMkLsTXVUsQ4gr4/pDuP604CPu3zmbSKpT3H3dMBJdnyK+TV2Z6PYbYV
         SLTNNhMmf+wPPKhcHX9UGllKbX2ylcbwE2k/tpDkP3m3mj29QgC4Pa8KcfdvMwx4h/Lv
         Qq4N3RGpFRoku/HnZqTF4jhtpweULu/PruP5Kg+GYj8+i1cbzAJ4rW0pw1UF7TfLGqqb
         2z+Rqd9qWxK5njdwJ1rkmZ9VX19hPyMEAhz9Zh/zLI1blPVnHduh/w7PE0SUvvIuncPI
         N834l6LNH0+CIqFfN+a2hPzb8sIe6HI0ENwfhfMKjeGNfpVSgD3O2WIKnbBOjjYiW0Qb
         N0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762313763; x=1762918563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocA7y4ZtA8+hHznDELnZyszTc84eNA3IP7qXnz+EX+g=;
        b=WpXSk3bM7HHKfajxt5uV0YOAJztbENVmqfZbweVe7cxRQdkNqNcPykbU0beXH5tqt0
         h2zbYUMV08+p2GMPynkt9ACcVJdujQBFha0cC3EqQ9iv4b/xn32JW/4MRr+jW41T5PcC
         gUlHMSPBr6uwt8GAJ4iLNUJFD2EJfK+Kic2jUmaU2p50IULbmA/B6lEpvhJViG0wNAzG
         0ynGL0f6oG9C+WYu07Xu+f7KkP+q5CYd6UZuDC1agIzgf4mOeYfKD3oSLeDlC/LPW6Dm
         aDRJXvlSaR2mvZPk8zwm9MkngxBdlUugTShKkiNfywKrwJ28AkqKTr82JcI2UJbLow/L
         Bzbw==
X-Gm-Message-State: AOJu0Yy03gaJuhzlKUIq5XqiunaD45bBgfMKLC9rklRBkd3q9Gx3ajJ5
	FWvpe5QZxXr0re4knuTEAwWgbKHi/7TiWmQwud2E/gWhj/5xHqv9iTQh9eIFg0HuQ/lUPiDCNVN
	6d5ok5QsRCpPDSNMikMu0s58qsVLYn2WPsUKU9uBeQkuQJHQzr6J7NHG/qXOKT4I7FSMux1xPgX
	9XJxvm9o5Kto1duRZYnr1gtqeIxzsnxGCXorr6N7av
X-Gm-Gg: ASbGncvffxK7FFjQu1MrlfY2t65o3aIATsEwI7CZOqH5T2rR+t76iBCF53954KySgDP
	MT36uKc/COul1ynoEeVrFS99FklOxJf5l38iNlPfv/1GubJBldTDQAmEc81xSCdRRCTwVrS0g00
	pC69HHAOIX1sojFt4/pyv4f1qKpZNJeumbL/7IzKWkLg2gUxRPFK8WlTyB
X-Received: by 2002:a05:6102:38d1:b0:5db:e851:9395 with SMTP id ada2fe7eead31-5dd88efa220mr663814137.7.1762313762742;
        Tue, 04 Nov 2025 19:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaN6WXTFcpJPXSpiq1R+9dMIxdHLXt3eZaNMcu3Hc7Beh8Ua+C3n9+i2Mi1JWYK95JERw528TlcqBhjjCvoWg=
X-Received: by 2002:a05:6102:38d1:b0:5db:e851:9395 with SMTP id
 ada2fe7eead31-5dd88efa220mr663810137.7.1762313762420; Tue, 04 Nov 2025
 19:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020124646.2050459-1-ming.lei@redhat.com> <aP7Ft5Y0WEMGv7jX@fedora>
In-Reply-To: <aP7Ft5Y0WEMGv7jX@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 5 Nov 2025 11:35:51 +0800
X-Gm-Features: AWmQ_bnYsih5sanVVZF1jCKeXrZy7KJdv6xiOdNtzFhYRjOJHZha19sYkxxbnpc
Message-ID: <CAFj5m9JY4TSY1dYE0qBVGsRcEOmyNuA4utf+G2=SBU2n5Ks==w@mail.gmail.com>
Subject: Re: [PATCH] lib/group_cpus: fix cross-NUMA CPU assignment in group_cpus_evenly
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:07=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Oct 20, 2025 at 08:46:46PM +0800, Ming Lei wrote:
> > When numgrps > nodes, group_cpus_evenly() can incorrectly assign CPUs
> > from different NUMA nodes to the same group due to the wrapping logic.
> > Then poor block IO performance is caused because of remote IO completio=
n.
> > And it can be avoided completely in case of `numgrps > nodes` because
> > each numa node may includes more CPUs than group's.
> >
> > The issue occurs when curgrp reaches last_grp and wraps to 0. This caus=
es
> > CPUs from later-processed nodes to be added to groups that already cont=
ain
> > CPUs from earlier-processed nodes, violating NUMA locality.
> >
> > Example with 8 NUMA nodes, 16 groups:
> > - Each node gets 2 groups allocated
> > - After processing nodes, curgrp reaches 16
> > - Wrapping to 0 causes CPUs from node N to be added to group 0 which
> >   already has CPUs from node 0
> >
> > Fix this by adding find_next_node_group() helper that searches for the
> > next group (starting from 0) that already contains CPUs from the same
> > NUMA node. When wrapping is needed, use this helper instead of blindly
> > wrapping to 0, ensuring CPUs are only added to groups within the same
> > NUMA node.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>
> Hello,
>
> ping...

Hello,

Ping...

Thanks,
Ming


