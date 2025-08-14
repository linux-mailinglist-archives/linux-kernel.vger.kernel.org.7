Return-Path: <linux-kernel+bounces-767899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F6EB25A38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C373B59C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1519B5A7;
	Thu, 14 Aug 2025 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjvMK2ka"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66028481DD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144096; cv=none; b=US4ti1331ehkUrFTdnbYvdD4p+0DZWREQkA20Uyop73asPqDZTua21dCbpa1P1geAGYd2haSGOlKxTo/K1Dp76/lD6y9K0E9DHvCdCTWUqjRIVUUOC3P5Iu+SnIc+84n31Yjp5Y9Uv2yedtBfG/m5MoQOK7S++mQUXrwhjYgazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144096; c=relaxed/simple;
	bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE0veUVKaoOqJplJSf1RrfFp+9vj8TL68KzH61G/bF4z18u3k5yJ0nB1YgAcG5v6T0+1VULGsT4VyWITGGgwxQV1fnQRTlGpwHhXmAOuTxXRLK/MNAaGmwyBICG0TIkoDLXjOtovkXdZZTgy4mE4b8n0gM1dxdmoRD/SbMiC5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjvMK2ka; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755144094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
	b=OjvMK2kaonxSFFYrse+dxlGz3xem3KALGJKQIAdWGtRWQmQ9S7yODl2GJvet4Zrq9W4+HL
	edJYxEbgMnoxAINzogG1iXtSNX5sKblKJvzu3B0egQi7QyxQPBZbEy81o/ZYshKpVgJU17
	JUC6uIbheeYlltkwKtZ4tVf1w3nJb5k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-t4j7XK60N-uE4H7FcPQJBA-1; Thu, 14 Aug 2025 00:01:32 -0400
X-MC-Unique: t4j7XK60N-uE4H7FcPQJBA-1
X-Mimecast-MFC-AGG-ID: t4j7XK60N-uE4H7FcPQJBA_1755144091
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32326e09c5fso520406a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144091; x=1755748891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
        b=V8d8RreT7e+yu7oVQmnWMhKKS3vIQDwI/N3qp0aN3lHVB9yO9m5T20h8rCJa/C+v5h
         UHQm6KQ8nvb/rqYyWslGDBAMxypJ/VnDl/MOpCUOnyFC4aYrNVn1vTs2caKLiDQoQDJY
         7L2Fa/mfz490SrZnv56hW/PCGWIxdAPWwEz2NMJWfWMMUHC0V9xWvBllUihlRDmdBOkr
         E4Lcb34HK1YoCWlzbALyw9dvrh3sGrB/bCnXRgRBIt6KI2SOErkBnGAsoNfWweSvnRM1
         qzOa7mrRLnppzZi5WdBk/kmklRdbKwMumTjC0Fm4zONFGxMVpMeiHJWmktbJpO3OoXq5
         rsfw==
X-Forwarded-Encrypted: i=1; AJvYcCWmGGTS9Jj98e32oKb2ittoDE4UwRhJ3R7nbm3W8MtDPeRrBg1XTZkZCfQViQt/GuVLzP/4Ve1ZyPiL4c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3N1X8oZ4bDpTSlQk45Whry6KzEDq6c2wgjBkyDbRGGj6PEhVr
	zI8RPnjiOdHdWwINXGYH9gaY+8cbsCVtbvSYWvcTcYncHP74iTZXIjneZTPvp711MkSGd0lOB3C
	JV3dSbXpR8yN+53vN/WC/vAEBTOgxv4+6wCmN+T9PrphEs77Oztu2oWQUcWzB6PdhUvGvC/10Wm
	LUrimvTD6WAX5Su/qe6gxhrUu6ezDxFqEziSSRaROf
X-Gm-Gg: ASbGnctAzHxxmE2L2NCFMPoXu6n8xyyyWInMedeFGur3Hh6hjQEXkEXdqGqeGXf8EzC
	kgys4+UK1c9qRv4NvDAyUrqlyo7y3kBSXhloE8hJcqCEjbeCD1b/WtqxZMyLlkwuXijlK2wUhVi
	YeF3vlYc9ol4inWqXr+dl/tg==
X-Received: by 2002:a17:90a:e7ce:b0:321:9536:4b69 with SMTP id 98e67ed59e1d1-32327b590d4mr2435285a91.27.1755144091261;
        Wed, 13 Aug 2025 21:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlgZcQQu+mkUi1deC7sDjvQ9QuH1SATW4bpi1PSZYoAkkkYuzX31t0W1PcNStDaF/dAIVS1DhTpkg+BudaI2w=
X-Received: by 2002:a17:90a:e7ce:b0:321:9536:4b69 with SMTP id
 98e67ed59e1d1-32327b590d4mr2435217a91.27.1755144090770; Wed, 13 Aug 2025
 21:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250814023554epcas5p4b3dcab50835e2da4749be1be135def20@epcas5p4.samsung.com>
 <20250813172307.7d5603e0@kernel.org> <20250814023607.3888932-1-junnan01.wu@samsung.com>
In-Reply-To: <20250814023607.3888932-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 12:01:18 +0800
X-Gm-Features: Ac12FXxgn-t3KycHNHz_KyALlzCrfoNrRoAOOEeUSfgRjxzlZkWqFGNrg_7ImpI
Message-ID: <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:36=E2=80=AFAM Junnan Wu <junnan01.wu@samsung.com=
> wrote:
>
> On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > Sounds like a fix people may want to backport. Could you repost with
> > an appropriate Fixes tag added, pointing to the earliest commit where
> > the problem can be observed?
>
> This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414633"
> After this patch, during `virtnet_poll`, function `virtnet_poll_cleantx`
> will be invoked, which will wakeup tx queue and clear queue state.
> If you agree with it, I will repost with this Fixes tag later.
>
> Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")

Could you please explain why it is specific to RX NAPI but not TX?

Thanks


