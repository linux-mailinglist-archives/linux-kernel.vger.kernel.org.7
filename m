Return-Path: <linux-kernel+bounces-745984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC852B12145
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341C87B9FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C42EE98D;
	Fri, 25 Jul 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+gsQ7ei"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384C24418D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458470; cv=none; b=bAcDPKTtXpPccGWCJT+Y1mgGFVNuoEHpZBWXBJ2pWNDT6ol2ZRxXwWpAaOt3e3EcHgSHWG3yDgvpCeHp6CaCJicBKVXCWmZOdiwBc3+2iMtnp8Y/VXOSfGaibSr6WtngvFQ2Au+0HKg9m4mz3Jsf7GocWoUucSNbfvoyEp0Em6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458470; c=relaxed/simple;
	bh=t0RQZYqOnC8qwtn6qPNBO3T1TznaSsM5oAbGsa8BZIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZvuaICr1+Pj/q9SA9cP9bDEbhZA/SK1Ae002Mzb8XcpobICssq+m6fxJvD6zQ4FJzI+votkuHLEg/X3EEtXrr7jRSwhn3ZHuZ6AZ0g3T1N5r2ot6eJ38XPhre8xRxObrxmJV+Bzc5rH7Z6WAbOtxXZ4yCFD8dCRj1pxm1XDr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+gsQ7ei; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab53fce526so29730611cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753458468; x=1754063268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+Gxk8kDLeWhUfZa20iC5ukdIQPazYFON7keNdL4TSs=;
        b=F+gsQ7eitsoBzB8dI4StcNsOhbf87xfVdFF+7Kn/6SPBQCf+/lwRv0bdm80g3ifDYw
         yI2Ibhv/rQ+/MQ2ltivclkz8+fi+zi5vv9Onf/zwnXkkwPVuCMnz+CbB/wMF4+1c609f
         jZnJaTzHFsgrTJGmRBd02KnsvL3ygT+1pW/eN6ZPJ+hN36lQHhRe1tP08duJ97JoaeWs
         4UeI38G2wkxNxHmueYW0iUVgytsg5/gMpyHxyL4OZxX9VLCpejjCf1kngiBf2E28f03f
         d6tOkq5iWSSDie/XtYb+SZrEDTrbji9iKqrqECT4XB8+D18oKojghBKldgk9U/cY8S/+
         YgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458468; x=1754063268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+Gxk8kDLeWhUfZa20iC5ukdIQPazYFON7keNdL4TSs=;
        b=IGDmE5Lbcw4w9/hUGIabDX+ZoRiIFTnlnoWE1Ru8XI4hn/P3dG7mgcXh1FpkS3V2yU
         RzGQYFlBHaK1u5B3yEzzpHwsZF6I7xCBO7NC46C2/LqcvXBM14y1cKMKEmyTOSEBvdi3
         SVxc0qf4+bx8490DdIkV9dZJ/+snGSAsmnw3lRyha24aNkp2XmHXXLUZpIkEOI4V8Vld
         Hvq211jTu8uuePWEGQwX28RujVKaaLGf0gPAeBR3s1CKtLjz8TNw0wJa9J73L9GKQTzj
         HB9rdPOUudm+cXo4fA1WOmYFXxfnK+rNKnPs7j4HaUcNrzy22QM8Wi3SNiH/k/vtcutI
         sHAg==
X-Forwarded-Encrypted: i=1; AJvYcCXEqWROnUP58NNLLjkQ8NGz1xqMu0ZKWejNRrSmd7oXiuUBr2UgZls1ZQThuNstSqI9dt4TjejwlgEELM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHRfi63biOE+6FJv50OH21CJ5WmDUdt36bBi898L53b9xMwMF
	lmKX0Vftq0LdMtqJD9Vrz7u6YTfGdhLekLDyEhuxW8PY/Yz89POIqQhrWC2gaNeEbZ2MoKzJFqV
	O0NK9UazKg7zpGcrA+Ig7CBCGgrQqONRBRao7meOV
X-Gm-Gg: ASbGnct4/0jJ+Thjvy3XWCi3Y6VmayZE2BA+6Qgdv2TmeI36xusI7qK7NuAu752YXnG
	tAMZbqpCYS3X/0mG+S2dr6lIvFwOtTV4GCiMu81k4x6ysRiusdDeGZ5yy/V+VnaLhLyL6pVi9ih
	rnSSG4hTo46zBdhHwaIp7P1LbqsAHiEGBvBe4TxCYeeFIeqAZlPloPrwP5d3kx7MkIDPLY8F4M5
	CDPFCA=
X-Google-Smtp-Source: AGHT+IEzZaHMReJ5XNFbGAgHeYF3Xnnap7wt6MhmmuxMPMOXDXp7wr/rsmslpn79gUJF3ssMvXLdqQrveoBAxpR2CLs=
X-Received: by 2002:a05:622a:146:b0:4ab:ac54:e3eb with SMTP id
 d75a77b69052e-4ae8f1c9a85mr24811891cf.54.1753458467542; Fri, 25 Jul 2025
 08:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725133311.143814-2-fourier.thomas@gmail.com>
 <CANn89iJW+4xLsTGU6LU4Y=amciL5Kni=wS1uTKy-wC8pCwNDGQ@mail.gmail.com> <20250725081045.34ac4130@kernel.org>
In-Reply-To: <20250725081045.34ac4130@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Jul 2025 08:47:34 -0700
X-Gm-Features: Ac12FXynX-SjHxFw157YJI9K51vdJtrSbnIWsfJzDnXOtRCfRbQ7IxrMqCpAIvo
Message-ID: <CANn89iKhVL0uQz9eTi6y3iDtQqRvCVt8T7MndxfMGKf7sPLvhw@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: nixge: Add missing check after DMA map
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Moritz Fischer <mdf@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 8:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 25 Jul 2025 06:53:16 -0700 Eric Dumazet wrote:
> > Not sure if this driver is actively used...
>
> Like most of the drivers that are missing dma_mappnig_error() :(

Well, a failure in __netdev_alloc_skb_ip_align() is more probable.

Maybe the following would help (and fix
ndev->stats.rx_packets/ndev->stats.rx_bytes) as well.

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixg=
e.c
index 230d5ff99dd7e1e9fabe21a6617d72d663cc1a7c..835463c301e11dca9f824137e75=
dd0eacf130419
100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -606,9 +606,6 @@ static int nixge_recv(struct net_device *ndev, int budg=
et)

        while ((cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK &&
                budget > packets)) {
-               tail_p =3D priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
-                        priv->rx_bd_ci;
-
                skb =3D (struct sk_buff *)(uintptr_t)
                        nixge_hw_dma_bd_get_addr(cur_p, sw_id_offset);

@@ -639,7 +636,7 @@ static int nixge_recv(struct net_device *ndev, int budg=
et)
                new_skb =3D netdev_alloc_skb_ip_align(ndev,
                                                    NIXGE_MAX_JUMBO_FRAME_S=
IZE);
                if (!new_skb)
-                       return packets;
+                       goto end;

                cur_phys =3D dma_map_single(ndev->dev.parent, new_skb->data=
,
                                          NIXGE_MAX_JUMBO_FRAME_SIZE,
@@ -653,11 +650,15 @@ static int nixge_recv(struct net_device *ndev, int bu=
dget)
                cur_p->status =3D 0;
                nixge_hw_dma_bd_set_offset(cur_p, (uintptr_t)new_skb);

+               tail_p =3D priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
+                        priv->rx_bd_ci;
+
                ++priv->rx_bd_ci;
                priv->rx_bd_ci %=3D RX_BD_NUM;
                cur_p =3D &priv->rx_bd_v[priv->rx_bd_ci];
        }

+end:
        ndev->stats.rx_packets +=3D packets;
        ndev->stats.rx_bytes +=3D size;

