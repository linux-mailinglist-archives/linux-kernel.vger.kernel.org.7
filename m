Return-Path: <linux-kernel+bounces-822593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C76B8438C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06511188764D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6D2FFF89;
	Thu, 18 Sep 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bTecXaQ4"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597A2F546C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192571; cv=none; b=R7gdl3FCJzOApNCO0jtjVkjhe2vpepgOOvQ50OcRYZeqf5E+CIlaRJkDGHRRRIMDGsG/k0JkcA5XzZceumuFdrb1JcLyc6bGJSC2tWOePsXhkF18J3Id3xgKUsQ+M9zXTHb6taZ8TEfEp+gA+NMI1XwaqaTrCuJM6xlrKA//E90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192571; c=relaxed/simple;
	bh=ZUBtVHvkTAY4+B4crK786K2DWksiRXcDIQfYXHLK7oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+R/qnZmaPqGuwz6mApCsQ4JpdD1ZoDCfvLpRzAvB5eNR93rWAHXSsgMXxQ+fW2sAZw9X6JLfeC6Cpdxw+e1Od6NjoPThnkU8QRVXF6h/GTm1/UlikHink60SxnOg59+o8OHZiDEIRZa/NzKUoA4HTiCjor7EXmBLfQ/6Zu4Y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bTecXaQ4; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-88c3944558bso17186839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192569; x=1758797369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tKzXKJ86WWAjRz6O6r+1bHqtyZjWimokstHRSdS6Mg=;
        b=NhO5aBIYl+fcLwcFG+bS53EVgpZdFDzh+NMaCqEdCiRkhIQB9Q/X4gbwO57bKDZ0dF
         8iRDA/Jnu3hKOYwqO5sUYR2Q0coJzVkgY3BYdnqi2QPDx32Q2w7Gk+GJXFQQGu/h7jWV
         8fWmG05F3SsCSqsjPUE4O67pJbD4WnvsSUE0GJbuv2Fg3lDNo3GEi5RVvd2XraplEuW1
         0Ff/Jj8hfRLFvK9KYiQq8RoAb9hYehbFNiOR6IFv2F4KCCxjwbxmUXn3Zu6wF6K78qz5
         rlu7A6mIM2HAjTM3QnxvtsKDeojvAgv3NLEOTFKggtp8BbHVZ62I6AuWWcLi9Bn7QpnO
         yRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyE40RC5iLFzcs1UZlUyfJIUe+HTQfI9eUGpJsf8TUJGC350fHRkprA+Em3lD4GitVTQ/PIgW9Jlcs4V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KOTzT8gYCNy1xVyvC16lEknZf8PEDMdysx+2zY3bYuHXDlZe
	GHjF9b4wf+QF2iE6cGV3wfQgMUyudsdtXIsTqVOR5RVwZ1PVhy7GOJN0e254KdPvhBiuwacnqxb
	EGZA1xnZ2BwWRQSn7dTZFTQ7tqWe9hKJWW6OjyFFbnQg1GV0eJ4owGAfR77r3AGxiGbVc5MWQi2
	UicyB8cExxyPHnr/M/1g9TmoBgRFQxFxQ/WB/qeCm7N2iyVEJQEwZ5pbJ/03FILKZbf4OgJgS8S
	eiPPFAzWqui1BsOZvba0GuKrQ==
X-Gm-Gg: ASbGnctz0kWoeSflkuLfLka1C0qTWS/PXGNHQn3iXBlQZtjt4KDslOocKlBUH9FIlF6
	ClH6GUR7YJGfJgzU9+hmS25Juc29rIp5IOv7g1YHApgB6jJJ8WDMzckcMbNoLTe64wD9mgcMuhB
	/6n/IHIr/FLfLqi+xZ49B6znSuYqG+gpbCJOFQHwWfQGH61KGcIyweUKQBYRGJYc57uYmpRKWjQ
	0m9eeB+4KeyTKgafhJMu98RxWowtOZGDPfQ79MhnTN0V7jXIOlm0wRg7tbxMPxkYvOJxIaes87g
	DcSxFCzoC3zEr9kbqoTZHuZ+pV7kRci06j+8EneDJrNeEVuC6QfiYat+/fZ+IkHx9ObyveUd+Bn
	KShGobS1TkieJk+AFwIfokaDc5/Tm0hAAion46CWjdicohRSrflSnztkjMElx2nh4U6EnfKovMA
	G5C5Q1ETCT
X-Google-Smtp-Source: AGHT+IH7ImIOWpjn4GUyMSAU4Gs7G7KsdXIwtLvyuDLy9N7UngLpTgV/c+/ueB1GfyJGpH+LHHXOIYNalOeo
X-Received: by 2002:a05:6e02:1847:b0:412:c994:db15 with SMTP id e9e14a558f8ab-4241a4b908cmr89348715ab.14.1758192566678;
        Thu, 18 Sep 2025 03:49:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-53d3cb1a22dsm140042173.14.2025.09.18.03.49.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:49:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26983c4d708so7839685ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758192565; x=1758797365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tKzXKJ86WWAjRz6O6r+1bHqtyZjWimokstHRSdS6Mg=;
        b=bTecXaQ4p6DMIlbjqQfhKH3UGDFLfdw+H8C29OdvMBJubc365E+2zEpjZQj66gtRmh
         iCweaicd6S1MW1wuu6+mlRFWPYyqvRdS+leOPgAEv7n2x8sG1T8T6ozHv9js9Yw2GYl3
         xMU+/ABgCILkrj6SUfNmA6WPORHS/pc3AhrQc=
X-Forwarded-Encrypted: i=1; AJvYcCVS7II3kHv2KIGAQalimifBJH0bpdDasivjhAyc5m0faYnilDEimyR1BEKzmj+oxlsYp8WAEb8kt1HnEhI=@vger.kernel.org
X-Received: by 2002:a17:902:e54a:b0:269:6e73:b90a with SMTP id d9443c01a7336-2696e82fe56mr46280525ad.15.1758192565258;
        Thu, 18 Sep 2025 03:49:25 -0700 (PDT)
X-Received: by 2002:a17:902:e54a:b0:269:6e73:b90a with SMTP id
 d9443c01a7336-2696e82fe56mr46280315ad.15.1758192564881; Thu, 18 Sep 2025
 03:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-6-bhargava.marreddy@broadcom.com> <20250916154501.GJ224143@horms.kernel.org>
In-Reply-To: <20250916154501.GJ224143@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 18 Sep 2025 16:19:13 +0530
X-Gm-Features: AS18NWCa_g0UmRvKmRME9ja7yGUskmCB6KsNTvDnDhoSWvGcPCrazrGLA1CN6r8
Message-ID: <CANXQDtanjs=VEMP8Mq+Bq5D_vT=zH3xbo2kc-EBaNkuWJ8T-8A@mail.gmail.com>
Subject: Re: [v7, net-next 05/10] bng_en: Initialise core resources
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 9:15=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 01:05:00AM +0530, Bhargava Marreddy wrote:
> > Add initial settings to all core resources, such as
> > the RX, AGG, TX, CQ, and NQ rings, as well as the VNIC.
> > This will help enable these resources in future patches.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> > ---
> >  .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 213 ++++++++++++++++++
> >  .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  50 ++++
> >  .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
> >  3 files changed, 264 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers=
/net/ethernet/broadcom/bnge/bnge_netdev.c
>
> ...
>
> > +static int bnge_init_tx_rings(struct bnge_net *bn)
> > +{
> > +     int i;
> > +
> > +     bn->tx_wake_thresh =3D max_t(int, bn->tx_ring_size / 2,
> > +                                BNGE_MIN_TX_DESC_CNT);
>
> The use of max_t caught my eye.
>
> And I'm curious to know why tx_wake_thresh is signed.
> I don't see it used in this patchset other than
> being set on the line above.
>
> In any case, I expect that max() can be used instead of max_t() here.

Thanks, I'll address this in the next patch.

>
> > +
> > +     for (i =3D 0; i < bn->bd->tx_nr_rings; i++) {
> > +             struct bnge_tx_ring_info *txr =3D &bn->tx_ring[i];
> > +             struct bnge_ring_struct *ring =3D &txr->tx_ring_struct;
> > +
> > +             ring->fw_ring_id =3D INVALID_HW_RING_ID;
> > +
> > +             netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX,
> > +                                  &txr->bnapi->napi);
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers=
/net/ethernet/broadcom/bnge/bnge_netdev.h
>
> ...
>
> > @@ -176,9 +212,19 @@ struct bnge_net {
> >       u16                             *tx_ring_map;
> >       enum dma_data_direction         rx_dir;
> >
> > +     /* grp_info indexed by napi/nq index */
> > +     struct bnge_ring_grp_info       *grp_info;
> >       struct bnge_vnic_info           *vnic_info;
> >       int                             nr_vnics;
> >       int                             total_irqs;
> > +
> > +     int                     tx_wake_thresh;
> > +     u16                     rx_offset;
> > +     u16                     rx_dma_offset;
> > +
> > +     u8                      rss_hash_key[HW_HASH_KEY_SIZE];
> > +     u8                      rss_hash_key_valid:1;
> > +     u8                      rss_hash_key_updated:1;
> >  };
>
> ...

