Return-Path: <linux-kernel+bounces-756426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD2B1B3D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B9E188FF07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03302701D6;
	Tue,  5 Aug 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRU/vd5N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F8212B1E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398339; cv=none; b=EFT83hn2DkRhQ4TTW6mKl62tScOwSPE5FN1HWSBdaQopZ5VmufznRhtVsizeLqJ4p28YZk+vuT9Fayg+Nhn4OeRkFPZMdiilnqLhDr+6jSnkcqL0IRdUukotcWtiaXgGx8AJ9CmsM9NtzJ/DswtnWIRgO4MWGBE8fX3vya4BL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398339; c=relaxed/simple;
	bh=Ogfilpy1+Aw2fyYDbAnv8ueBhzY263nV1cV6pqFK6YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFFC+/TfKAwRugHuv1aPIpjcsDyvQOtKKfD2uX+9uY94Lc1YmVhr3Ic31aoR6idAPtFyoSpZBBnDXjptCEM29qXW18pOpsvujwPTVrxHiha4rWsvawjfDCLD1KrKYm3a5WWjWg3wR4L4FFNFAR5XPKESf6wK1Vs5KutObuMipJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRU/vd5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754398336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgB0AQxdVl7C2PQ18hWglhquCvWS8wfXLwal+sVZVI4=;
	b=BRU/vd5NApolZ688atsYj4lk4o8RY3ZUyjRslTOIRcr5MXk7MUJahX9tIpQ4D5IpIOv/80
	+rGZOO4oPiun70jvHZlmmzbfCqTmMxL1JlvuAFwOoaZpMv3++spu27l5Emd+Qpik+ek/IB
	4QQCT8Nxcjbc7DqtfvNyYewUVl/orAI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-cGAGU-k8Pc-GboFU0V56kg-1; Tue, 05 Aug 2025 08:52:15 -0400
X-MC-Unique: cGAGU-k8Pc-GboFU0V56kg-1
X-Mimecast-MFC-AGG-ID: cGAGU-k8Pc-GboFU0V56kg_1754398334
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-30bc3ba1b79so358484fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398334; x=1755003134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgB0AQxdVl7C2PQ18hWglhquCvWS8wfXLwal+sVZVI4=;
        b=pC2Y9i1c/lQtDS5rsEu9AuOVP8FeVIGB1CQBvvgxT+kG0PWFfZJ8Lhkv9N6cdV5BRx
         0VSneh8rlgLT9TT67mROnx4CuTk9MSKOm6aK54i//fKPrSGJ9d2dr8r6jHF1puiRHLBA
         AyslzApFLqXOeIQ+i35mhcj0S5Yc01zH7Z1Si9jEiBu5Y5eQbipp+Na9VyQ67lvt/NMh
         7zqieShWmNqjnqqvN3twrHuTyW3mSyuJxh3wWF/Pk3g7Dz7SWv0snsPyFb17HQ75FeHy
         8y+WLlUQqGYaEEABKFTg1Wrm7so3ZhhNKfioB1LI+uEOVREac8VvPdwFqDWuSYkpELbq
         6wZw==
X-Forwarded-Encrypted: i=1; AJvYcCXDUMkMsazqJyx+9eE/pu0o70Ut+OPvz3mWmkfMgDIW/C92FmLKb2zi/+plMdS5VtPUN6kBuLq+9H8Gyj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcjrKc+Nhm4CLaCugRFWQTjIA0tvGhRqv0mReirg9AvAdootD
	yMTVgmBWcjgiOblFMwe3XaHIKgDZO4v34Hy0kEUambwL2C+Dqo5rzfna+Qtft1PTP96Ugdhr1f2
	WFlj3bl7nijyCB2W4P3iQjUgJ/drEVobZ/04gvrhxP3f6vzKQrGmDIQf4T9s+JdjbtAD+GbV8SK
	hlUiL2A8u20xNAORnE4NGMK15BiNPdWw3mUl/2J5QZ
X-Gm-Gg: ASbGnct8088Z3jMl/nc8lJQVi1kLhlvzATKWTtrG3JHAH9yFEdGPgYuXadRnIl4txmU
	7S/LJeMJ78NLRdzy4fub6yrIpaYIZFnP2OXfk+CuxG8HMnrCMYUp0J0qYtoZSLXetFRJOsbYQGj
	PP7bVFiBiStxsrry1zz6+w
X-Received: by 2002:a05:6871:9c20:b0:2ea:9827:84a8 with SMTP id 586e51a60fabf-30b67946621mr3175549fac.7.1754398334473;
        Tue, 05 Aug 2025 05:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHinHajgoHUmWGj94cAaH6a+7G7OE4HbqLOK7S+uUkO6MBS9l7AWmZGl1jdJNZFDhjpN4LGqm+iBpUkdsLIkyk=
X-Received: by 2002:a05:6871:9c20:b0:2ea:9827:84a8 with SMTP id
 586e51a60fabf-30b67946621mr3175542fac.7.1754398334152; Tue, 05 Aug 2025
 05:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801101338.72502-1-mschmidt@redhat.com> <20250804172055.0b865696@kernel.org>
In-Reply-To: <20250804172055.0b865696@kernel.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 5 Aug 2025 14:52:02 +0200
X-Gm-Features: Ac12FXzEAuZrErgHW_y4fs26VWeae3kHl9WKIW6RmRdQXXMRv1Ftpe_4M2qDXtQ
Message-ID: <CADEbmW0yx1_JL1mExOp0Kwdy7sUDQdG3CU_bHON1nJ-ikQur5w@mail.gmail.com>
Subject: Re: [PATCH net] benet: fix BUG when creating VFs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
> On Fri,  1 Aug 2025 12:13:37 +0200 Michal Schmidt wrote:
> > benet crashes as soon as SRIOV VFs are created:
>
> >  err:
> > -     dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma)=
;
> >       spin_unlock_bh(&adapter->mcc_lock);
> > +     dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma)=
;
> >       return status;
> >  }
> >
>
> Quick grep reveals an identical problem in be_cmd_get_phy_info() ?
> Or is this bug size-sensitive ? I don't see the vunmap call..

The call chain to the vunmap is:
dma_free_coherent -> dma_free_attrs -> iommu_dma_free ->
__iommu_dma_free -> dma_common_free_remap -> vunmap

I think the reason be_cmd_get_phy_info() does not cause a problem is
it uses dma_alloc_coherent(..., GFP_ATOMIC).
Then iommu_dma_alloc() does not go into the iommu_dma_alloc_remap() path.
The corresponding dma_free_coherent() then does not go into the
is_vmalloc_addr() branch in __iommu_dma_free().

Michal


