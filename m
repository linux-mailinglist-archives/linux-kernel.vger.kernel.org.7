Return-Path: <linux-kernel+bounces-817586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3DB58425
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F220B2A1EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D02DEA6D;
	Mon, 15 Sep 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aRf31/9J"
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677552BEFE8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958983; cv=none; b=n5/eSDt6OgM6bD3e4NnDdgoEGerB8CHa7Z1+n4eO33YL27CvEmcznzfRUljbNVUfn7nvexJAjkVeJWNkogEvc15qCH+DYGsHYX3sSq4RkMa6FRlhtY417LWP0yTTmMF1ymMeEiQAcdnUFtCcu8OVI2FgLWj7Eu1lY+5Wol2rSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958983; c=relaxed/simple;
	bh=pyln1+t7r3NReffU+GcqGlg7dQEAIsHl0+sNo5XvP3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEGIqNOfRK6D2QBTI9/M4SWJIy8C65AAD43YoGf14Ze8BgqLEgj1FJO2e4TwDJ1sTMCY+kYx4xqEwXG3ASKIknW0eK4CIvPsOmo2JsUeCBBMIBa2TD/M/2CNEDzGzRobd/kD5BAAN0tptstzPGKkHz5mbP0+Uj1U1P+8Nua0Wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aRf31/9J; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-73400edf776so11621397b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958981; x=1758563781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJbRTFvItIOxNjF8btTHP0zPk7LDQHPgGj0UqdfwXlI=;
        b=V7zdKYeolZ58AoWO/lDSBanIv3KaMSFU+ZtyPJSvegs1vHJMggHT4kRL2mSEKc52xw
         oT0yzIdQ6B1PG9s1iPqFTeIJCqQzvHSpcsfKf64FoQQAiVHmx6hqoiSz8ibAvprdfctv
         /Oh1H0AlmKauM7LC8ee4M23cWSTb2uSEQb9VgEOLYbbFjUc6so5yuUy5opBEe5VuDrlG
         LsR+1UWUazJItgVO595afOAzxwA35IkiwKpleWD9RDTQJxkmvc6y57ekADt4wksiaIbW
         RGzySskOCjunlXvhJjhSAnfwIe3WKnwGcJyCSqHmib4L/Wh02ydGoxcNNOwz1OzQbJaR
         EJqA==
X-Forwarded-Encrypted: i=1; AJvYcCUnEthN7tIkySdeofQYYVQ+P3FxsREGQ3Ig+UpYCQukPPkCFhmxxFu8YI6YUNu7UNNE1UPDPxE/qjfPITc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7oE6kcloyUdm83i+2Bc+lnMPOrTBYoemwkFA9XasoAOIaqXi
	2+dCm+wZnIncD0+MnUmK8SsejwpKGE9T+FWkik5DO9qpWDI7IecgHD5LQTxkxkx5c+xMLWPd3uf
	89e0MesK72dZeuShtyEgms2k4/LGnkVkdgjXXUQOKmyALgtw/7X6/dhFCyAER/+WkQjGDqgGj+d
	PpAafT8VMnQTSpAEojO5K+9oeGV0fqBWtWSTZ6R//XpWyhYxg//ovPEKFkocaoHQpRYFrbnf5B7
	bTQpFQiW9QNawoSN7rRQ4L5CBjP
X-Gm-Gg: ASbGnctN+ikSTpKPZA+ES+BGFDZgM4na8no+Br8lwNot5w5DjZvnMJVz1oLJXeyg6E1
	F2E6XTjHINSF+A982XS5SyRFIaJilXvMqSw1tl5qPMS+zDaNpQHXMYzi5ZFIs1PxFR0ddNM76Wh
	H5JB1pacWR8kpI+4TTyW4Gb6vNxzfvREAVb/erhtQmmUMczyXH+8lro+bkmg9Uug+hQLJ+KPkeD
	qrIVPntyrYVqU+lbyVPRhVIyDkpvfEMiVO+Z5RHVDS32MR9G+TbP03A0BYauA2WyLIbtlBQ6QeG
	A8as2D6cvhiJ2YJtGzXAHWiBIohqIJP+/0UCKhL6QJFiiA5ge1n1gYixFQf2QlCFz1LGABcHzwH
	ulF7heMohv+ZFo9T9cSo+FekeR9CuGM0gg+pye1CtTDI+ny5bhJKysCzAGCb9pgQ0leZ1KtwCSL
	D1jC4qkQ==
X-Google-Smtp-Source: AGHT+IGaAJsnAX2F62V8OJXYsbDSNHexaOxHnjVPBQtILS6Swh9siZfuT6PWcCieJMDHJ/svLbSRAbkSdLfM
X-Received: by 2002:a05:690c:9c01:b0:724:c3fb:181d with SMTP id 00721157ae682-730652d448cmr119881577b3.44.1757958981166;
        Mon, 15 Sep 2025 10:56:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-736e339cd64sm23577b3.2.2025.09.15.10.56.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 10:56:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f86568434so3349001a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757958980; x=1758563780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJbRTFvItIOxNjF8btTHP0zPk7LDQHPgGj0UqdfwXlI=;
        b=aRf31/9JQbh8ec3DAbRVvMVqKx3GfFBU6DwSZHcWhEJWYKXzQaWzLq6yELYPy5pFZO
         I0HQQdAnJ0Zv4vGhA21arm2KGdJevP0CeHbmY338/AjetaZ/vrmpM/9NimfXGGNbIwFN
         3jU6M4LZ1Sdq4A/By36m4TJ1esIm8LK0fNeYQ=
X-Forwarded-Encrypted: i=1; AJvYcCWOmHgYS98eA9zQI66/RnoUTXXMyklpgvyX+MRZedFXwueWPrOWKt+NV5s65TKAP5V4PTqHvMj9tkt/RxM=@vger.kernel.org
X-Received: by 2002:a17:902:dacd:b0:25d:8043:781d with SMTP id d9443c01a7336-25d804381bcmr158134815ad.21.1757958979789;
        Mon, 15 Sep 2025 10:56:19 -0700 (PDT)
X-Received: by 2002:a17:902:dacd:b0:25d:8043:781d with SMTP id
 d9443c01a7336-25d804381bcmr158134515ad.21.1757958979436; Mon, 15 Sep 2025
 10:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-7-bhargava.marreddy@broadcom.com> <20250914133150.429b5f70@kernel.org>
In-Reply-To: <20250914133150.429b5f70@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Mon, 15 Sep 2025 23:26:07 +0530
X-Gm-Features: AS18NWAdwcC_lAEZq2uYBCaX6F8v5R_jkiei_yxqCSuPoChdSZfVNZ-cFOt-fRU
Message-ID: <CANXQDtaB7HcSujG1R9i90YUB6PdOin4=CsKzGvNX6tGMw8n+mw@mail.gmail.com>
Subject: Re: [v7, net-next 06/10] bng_en: Allocate packet buffers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 15, 2025 at 2:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 12 Sep 2025 01:05:01 +0530 Bhargava Marreddy wrote:
> > +static void bnge_alloc_one_rx_pkt_mem(struct bnge_net *bn,
> > +                                   struct bnge_rx_ring_info *rxr,
> > +                                   int ring_nr)
> > +{
> > +     u32 prod;
> > +     int i;
> > +
> > +     prod =3D rxr->rx_prod;
> > +     for (i =3D 0; i < bn->rx_ring_size; i++) {
> > +             if (bnge_alloc_rx_data(bn, rxr, prod, GFP_KERNEL)) {
> > +                     netdev_warn(bn->netdev, "init'ed rx ring %d with =
%d/%d skbs only\n",
> > +                                 ring_nr, i, bn->rx_ring_size);
> > +                     break;
> > +             }
> > +             prod =3D NEXT_RX(prod);
> > +     }
> > +     rxr->rx_prod =3D prod;
>
> You should have some sort of minimal fill level of the Rx rings.
> Right now ndo_open will succeed even when Rx rings are completely empty.
> Looks like you made even more functions void since v6, this is going in
I changed those functions to void only because in this patchset they can=E2=
=80=99t fail.
> the wrong direction. Most drivers actually expect the entire ring to be
> filled. You can have a partial fill, but knowing bnxt I'm worried the
> driver will actually never try to fill the rings back up.
I believe the driver should return an error if any buffer allocation
fails and handle the unwinding accordingly.
What do you think?

Thanks,
Bhargava Marreddy
> --
> pw-bot: cr

