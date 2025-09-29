Return-Path: <linux-kernel+bounces-836519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4424BA9EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2C2176B08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774230C0E9;
	Mon, 29 Sep 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfN+ag3p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C092FF645
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161662; cv=none; b=Zk97HfMyJlQ9Y8V8oXiuiq7vn4e5h14LcOWL2llU90ZWlaQxXv1tpSoVKZmJtJiUG4coH2XfM/Rb8wX6wZ5ZpWEzt/mD8Bge7ozbZHgOheUNq8F2Xxs0og+W+jnTVlyoL9oDNFrXxeWXkTRSZdBTophu+U6ZznGcFtcwMVfpXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161662; c=relaxed/simple;
	bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOqIj8QzqGXiktiWLiPKAfDrN4RtkQuaxnfzi9r84Z5cw5NG7KLgKs2/HufFkZrcKCAo/44A1dtbnq5HJ2u4yTILzHqCx14sNW7PlO6zeQaGP6873omb6co7oxvR/aDViK4U9FqqWoaGGtgG2KGvZxNzTCV01jTrDqTBJyrfREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfN+ag3p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759161659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
	b=JfN+ag3pNuXQwhIKsJ2eOHLF1Qtb5wwK6bFHSSwv1V+2Y5NTbhSaEniITycAuopVKeEYzT
	frLrEZ4WpgAanJxm/l20pvhLJ9bHJjQG9x50RdTqZRryK6KoIv3n9Kyiq0Lj2qoHaTTk6w
	aFAb5z55wWnzWY5az4ECLhrHaWgxnuY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-OUAO07qVOqKwzbbmDasxTg-1; Mon, 29 Sep 2025 12:00:57 -0400
X-MC-Unique: OUAO07qVOqKwzbbmDasxTg-1
X-Mimecast-MFC-AGG-ID: OUAO07qVOqKwzbbmDasxTg_1759161656
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b07d13a7752so566174266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161656; x=1759766456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
        b=rNi3RakvCoZ+QzgTa+NN+B0m6OyPhbkWi4yoOVJRTxJ43vaHYwnommjd1vEu6k5Hfr
         XZT92FQ3yfhb5LCEqOqsl3kEJbhraffhsOCVqESFl+U1vDr68fwf+bgf1EjLX64dCVy5
         dbufVFL8m0he3Ko7A59ZEN2R45i88pwyzVsumdWtKGYKGuTGkqrJbsairyQyK9PMPhTz
         fN3/Vm9HrWnBsVCr2yp1cJzOFylvk5BIn6HsZFmb/zvzagK5aMq0DA0z+PJ4d3MULi1K
         I8+UjFnu6IFLbaZ/cpYr7KO6cJNTNrzt/ZgkXuBPNPGZrrNF2yujq0AJVFqI5La7557t
         HoBA==
X-Forwarded-Encrypted: i=1; AJvYcCVEwOfaOC7mZuucwi9v2oW6Etgh7XbQmfD9h/f2W5keYYiYhqbGm1nOVVag5EJQ5NpZr2Zo7tu6fZH18N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+81hM37Gq05DItkP2cvUZ7F9O+kFFY6md+Ghml2wLsSxglKB
	lAb6Ri+3uEwTI6zTljuYvEd0FRMQE/GdjH4VovUNSoWHoCY8lsnqy3vHa+3FLAPrG20m8//TnVN
	8UvsbDzctfCwJugtWCcetbJN+QXYPQWiEr0G9yvNq0D4uwyvhrKUxLAQZsZVDM8gqR8y/4zGYFD
	e089Id+4sDaGWPAXiwVBsGztMr75y5Xh7OVS8B1r6n
X-Gm-Gg: ASbGnctU7EFQk2DYZCntf91L0Hbem5I0yZ8x89kmb5xUrfUDwIrGMruWsOwlZGGPMzp
	BIo/xNI0uj69X7tHrFEkIklTT1jDmTnqDLm+5DJAcXA/iiTloZUuRkYPaWi2YhMD0dYQub8mCQS
	iqtPZIniwPBZ+vEeaM+MyyeA==
X-Received: by 2002:a17:907:3e9f:b0:b3b:d772:719b with SMTP id a640c23a62f3a-b3bd781ba71mr843425366b.41.1759161655724;
        Mon, 29 Sep 2025 09:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6hzu6lwEjjnhGnHFD8M9ofM8ojrlvCKKGBmnqXaS/KCPAQ0khSQKd+hnPIMyAHKH3zg+/WlTMjm+XtQu+5y0=
X-Received: by 2002:a17:907:3e9f:b0:b3b:d772:719b with SMTP id
 a640c23a62f3a-b3bd781ba71mr843420566b.41.1759161655326; Mon, 29 Sep 2025
 09:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
 <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
In-Reply-To: <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 30 Sep 2025 00:00:18 +0800
X-Gm-Features: AS18NWC2orrPAiafpnWLj0PiUo6H6ktFe9pH1En2rWhE1VkgRlQKrFKPhSd3Jgc
Message-ID: <CAPpAL=z9GZKTDETJVEpq1aop8q1Rgn7VaXbV_S4_y-nsVfzpxQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Fix copy_to_iter return value check
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	zhang jiao <zhangjiao2@cmss.chinamobile.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 24, 2025 at 8:54=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Sep 24, 2025 at 5:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > The return value of copy_to_iter can't be negative, check whether the
> > copied length is equal to the requested length instead of checking for
> > negative values.
> >
> > Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss=
.chinamobile.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> >
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>


