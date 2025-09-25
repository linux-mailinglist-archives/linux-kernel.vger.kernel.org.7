Return-Path: <linux-kernel+bounces-831866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FDB9DBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1554F3A5A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD282E8B8F;
	Thu, 25 Sep 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iifk7Ceb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D33C01
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783315; cv=none; b=bYmQnyrN3FTGMue1ST/EblSFLGehtwKbD3b3cN9J14NxyYlcL6iduXAJ6NQVV31eGhyDvVbm0nP8NGIn4uArLvfDBMW616GdGTwSZHI7YMU10ZnAq+pR3iZafoZhtwa9kNNXQB2z/jp8GGdac/CT5tZu2RqoWyTyoDLCm5/GVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783315; c=relaxed/simple;
	bh=r2JUlSD7rhwj15a/cE+EKqtmJLQxqexQyH6N87v6L0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY3mvbmCzBNn/MXKnUfBgejrw7k5IC4lYDhHEPIATZsYD4MYIXVFsy9wTAPAskws5aNH7vOdgBZKBOWReNAS2why4jv7GgOHxS+twAH0c7R3spaiQi7jEp70gr6YsTrzpfncXczb9k3VrRrxbn52J1hypgCY1V2WcvWXvwsuusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iifk7Ceb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758783311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1afco+OLcbUkuderEKCSHGmDr+kLzLlD2qRO3PXw0Hg=;
	b=Iifk7Ceb5cVaOIOFyljhUiSu9vwWGJ4N+aYkea/maDxKKqIcLy2Tr0vzITRV9CC9UGi7In
	ReMAlpzPFznpgZJAZTlc8BwIEICe6uLstd5F/JDOW7Bmb+qkrW9nESesAk1Z5vZ1qSiQx+
	l0NEO8daNsgKpEHp/5DFLTN5i0Bmols=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-J4PdrplJOwK1ZuRWx7yJiA-1; Thu, 25 Sep 2025 02:55:10 -0400
X-MC-Unique: J4PdrplJOwK1ZuRWx7yJiA-1
X-Mimecast-MFC-AGG-ID: J4PdrplJOwK1ZuRWx7yJiA_1758783310
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-ea5bd03c88eso650303276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783309; x=1759388109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1afco+OLcbUkuderEKCSHGmDr+kLzLlD2qRO3PXw0Hg=;
        b=MzSUR/HyTdtbFQIb9jbuHzaS8N96qWQXsnxGqkJbMyM3jxUugyDU00xjiMnztR7ceo
         kuy+hW07mGBahzMmZXvTFQ/2qMit0s7d/kPTWLfX6B7ArgxDTOduq4zDjKRHxHr7LEDA
         arnEhMDHGTdwOgeoRUi5scLuebwaxx0Ma3w/2PeEA2I4cp3tKn4EqAbjsClDTTvd39J3
         BZF11HUJaj/vfY0PTboEGgscVjKZ2TPOWFln1EStHZw0Hz0ApC7h/09MHHgRbXcXPFMQ
         xOFb37QI4BqiCZaJ1eIgvCnUQ3qUEMXXjFpWwLcPK//lHTEoGgwNrreZ1Gpd49CLHaOm
         Gn4g==
X-Forwarded-Encrypted: i=1; AJvYcCWkF8h225wpymNhiug4NOl2ezC5bCRUUZQO9HziXMNGITRy7FSfhw5f/WSCB3P5R9/ZxWT0a/V6zXOcFWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/NNKOsYYu1Cr7ivyZcRnWNMxGUhetcVAma+/eDGqLcAdtndW
	ATbmvbd0pfbroKHAjVT/rGCSKCv22m8ypTfEA1eXXasaJGlnqrt8T7lqHfYU14R0PTEt9a0zTgr
	cUJwqhr0+9pN5sqzTIQK9LwtAFc7RG4SQdAazva3QlgcCXm7o7VohftvMkQFherx429Hc8ns94r
	wCF3aMSIOuIeSa/HpQECGSwfaysXbggazJgVjtMbRp
X-Gm-Gg: ASbGncsntIrqUPdI5/m9b8cQFj+X1xUkE2p9nQVC5B9NlMsDP9bnp1Tar0clTIj5NBp
	ph1T70rH0iE4HE04X+eeXCF1xZq+ndu/ponNsn4+PMb1zU7HWOImPTvUkq7/+p7WJ5RRl8r8dei
	LRZqRfui6bFLpPMLOj4FB3bspTqxRyw+5J1qsuEWtZNGMtAHZGuaJ/6D/d/M5z4mTFLVY8vEqIH
	IrvQvDY
X-Received: by 2002:a05:6902:f87:b0:ead:eaa:52c1 with SMTP id 3f1490d57ef6-eb37fcae0f8mr2372342276.37.1758783309742;
        Wed, 24 Sep 2025 23:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9NYmeNltTeYeivvoYJcWlBhCn4pWsqGDG8RQXH5hutKO64/reoO9IYAJVGBXg9Ri3EtS5/Y2BLzKbK6bc5pY=
X-Received: by 2002:a05:6902:f87:b0:ead:eaa:52c1 with SMTP id
 3f1490d57ef6-eb37fcae0f8mr2372335276.37.1758783309434; Wed, 24 Sep 2025
 23:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924070045.10361-1-jasowang@redhat.com>
In-Reply-To: <20250924070045.10361-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Sep 2025 08:54:32 +0200
X-Gm-Features: AS18NWDcmdLS-q3ZMtWMmmlfI8XF52ncqudb7kTpWmxj8SH51wcxc4jnfKIa7nY
Message-ID: <CAJaqyWdAP=G=3yqs6CCQJOX6zue6RVieGGTLHt2cQrnxhL1AhA@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] Use virtio map API for VDUSE
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 9:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hi all:
>
> With the introduction of the virtio map API, there's no need for VDUSE
> to be hacked with DMA API to work. So this series switches to use
> virtio map API for VDUSE so VDUSE can get rid of the DMA API
> completely.
>
> Please review.
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>


Thanks!

> Thanks
>
> Changes since V6:
>
> - Typo fixes
>
> Jason Wang (2):
>   vdpa: introduce map ops
>   vduse: switch to use virtio map API instead of DMA API
>
>  drivers/vdpa/Kconfig                     |  8 +--
>  drivers/vdpa/alibaba/eni_vdpa.c          |  3 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |  3 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 +-
>  drivers/vdpa/pds/vdpa_dev.c              |  3 +-
>  drivers/vdpa/solidrun/snet_main.c        |  4 +-
>  drivers/vdpa/vdpa.c                      |  3 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.c     |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h     |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       | 79 ++++++++++++------------
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 +-
>  drivers/virtio/virtio_vdpa.c             |  4 +-
>  include/linux/vdpa.h                     | 10 ++-
>  include/linux/virtio.h                   |  4 ++
>  16 files changed, 74 insertions(+), 62 deletions(-)
>
> --
> 2.31.1
>


