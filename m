Return-Path: <linux-kernel+bounces-745852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DEB11F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE1BAE0E80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DE1B6CE9;
	Fri, 25 Jul 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/6pi6zo"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7114EC46
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451610; cv=none; b=XFSFsiEoPPd6vBqZpnP8ISIYiqzeFirS6wrNKdyvOUwizyC8kTxAFRGHCTYJNIbVZ/H7F3UVFLTf3icCwmVuNi4bcnHS6x/jN0PKeoXmrDymEDIxenEqyMro1uTMz3Z4rhQrBXiSZUUYhwyOvQ5slfMB0mFjzRDPp21scW2OC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451610; c=relaxed/simple;
	bh=mSDg1GQamFsjMossvkdrmxraz/XzbhlY0Z87GkuJcGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr4rizM4djPXuMw7vU2DXOjU2FchR0pY5XQckiimIpnmCFX/c4PFJSnA0KSAdDFA7jeboqRObBeg2Zs/p+r5lM+DKSXyJm5qptxth0oXSI0Z59XDedOOJi5pYbDpE2uogIGlJbO/wxkWYJXM4B19cxhuuUY7H3FV1DFWrXhxxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/6pi6zo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab9ba884c6so27965601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753451608; x=1754056408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1hAqeYCy6aPtsdaD+a95FJh5xJrvRSfxYY035KZ700=;
        b=t/6pi6zoCsS8h5gpWMkrh+4YjYMsmFXKuyVUf1ekJ5wuV45hwhvcBs075vXjWoF1MA
         mseRhluBGxaCardzo4XhLcSytjwqzC4ZIL1LIMcg+/2biIHBqC08U5yCWzG634DA7ygL
         WybuPAY5/8DorpgnpObC0FZCJA2A0dJXtRs5m/kcIrtjMKlm/2UTO0k0aBrpuqldO5DO
         0U+0nKyn1yVEWOJt/Z1ifDXq9JMjRMzsqYFgkUVkIAhB0SnOXZxUADF5HPlz8Bd0OCc4
         kZf91b5cs/DGxuXGRHVEB/SPC32yOjoZ2waX8/j4XaA68sM1jUh1ZXPwmc5KoyUSGnnb
         hN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753451608; x=1754056408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1hAqeYCy6aPtsdaD+a95FJh5xJrvRSfxYY035KZ700=;
        b=blerw/bjT1GvMb1U0CrOXQIC+HIlLShgkMS3TvlResgP6C7HfZ1VLiPEhwYNA7I/40
         trHRE9cM4sZ40/RbRCjXtk0kO42vpN/3P5p3A7GAb3Y+E0hA7aSzHCEXFp7079DAbuRE
         T9o1xdDLAxF4D5tRwq63Xrq5pHLM5efs4PGX83c9vD0sKUYbSUK/uK7A5czFWBKsR/Su
         7ZP1+YcaMX3WGmoOsXNoCh/o8sT7BPYvI7Ay7Th2ji9xJoWlK2Vm2owJ2kYaawwpg7BU
         O2JVF7sEFZRZXKNY7irjDvlbbOJQ48FW3e4cQDD2cmUskAhvVaW2xy6/amgjjia5truY
         KFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwv2522O0KSczKYFGaQ6jOVJ8aXYJS+8XQOh09BGTTnI/yhwZxUZ1k4yf9oF+37XLmCFAatbXB++Xb7ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0y7ruPATGcIwN//khSsMh07p/BtC5ffWUu5/TsIK8qEdEqwm
	nTckfQtHO+sGRDIKMw9mPw8RGIyXJV5p3A72DpDLkdHgxw7u0oCg+Q32Sr8XJ0oVE7N5cFkiv20
	ilCVPBrbn4Uh2X1CZuQyzXr8OykViPl+vZJnJ+Kj8
X-Gm-Gg: ASbGncsKlnrDyG7KkLltFuwD6hf7m+C0YHejsHvwns8K3kFvX/fBJFdqUpKZCZBJ2+T
	1YKNWLIwxN0gCtDyc7+2cwc0bMROSEbJk6v+iXi7ziikbf853F5kNdJdmV7qGAGgd9di6QVj3rk
	BN/59IYpRkvLKsJsY8F1ePgHLkCUoHHRrk+lLHmie4sbKu5Tz3UQr6a7Gq/qA1YIo8XuJzT3B9m
	jnf1Ja8cERcekJ3Ng==
X-Google-Smtp-Source: AGHT+IHOtPZYCcL27DWaCXqhxuZHZ+IobaaCtR9TWuGSz7vT8EhbM2oy7hS2Ze67n30F2CECD1rIf8wpevlL6Pbpo9o=
X-Received: by 2002:ac8:5804:0:b0:4ab:5d26:db8a with SMTP id
 d75a77b69052e-4ae8e878ec5mr23365041cf.18.1753451607204; Fri, 25 Jul 2025
 06:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725133311.143814-2-fourier.thomas@gmail.com>
In-Reply-To: <20250725133311.143814-2-fourier.thomas@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Jul 2025 06:53:16 -0700
X-Gm-Features: Ac12FXz9f_T46FZr6oWHnYPdE1FCnEu_6iCpQgTJrXvhchKkQWpnlpbZ97hSA3c
Message-ID: <CANn89iJW+4xLsTGU6LU4Y=amciL5Kni=wS1uTKy-wC8pCwNDGQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: nixge: Add missing check after DMA map
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Moritz Fischer <mdf@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 6:34=E2=80=AFAM Thomas Fourier <fourier.thomas@gmai=
l.com> wrote:
>
> The DMA map functions can fail and should be tested for errors.
>
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Inst=
ruments XGE netdev")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/ni/nixge.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/ni=
xge.c
> index 230d5ff99dd7..027e53023007 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -334,6 +334,10 @@ static int nixge_hw_dma_bd_init(struct net_device *n=
dev)
>                 phys =3D dma_map_single(ndev->dev.parent, skb->data,
>                                       NIXGE_MAX_JUMBO_FRAME_SIZE,
>                                       DMA_FROM_DEVICE);
> +               if (dma_mapping_error(ndev->dev.parent, phys)) {
> +                       dev_kfree_skb_any(skb);
> +                       goto out;
> +               }
>
>                 nixge_hw_dma_bd_set_phys(&priv->rx_bd_v[i], phys);
>
> @@ -645,8 +649,8 @@ static int nixge_recv(struct net_device *ndev, int bu=
dget)
>                                           NIXGE_MAX_JUMBO_FRAME_SIZE,
>                                           DMA_FROM_DEVICE);
>                 if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
> -                       /* FIXME: bail out and clean up */
> -                       netdev_err(ndev, "Failed to map ...\n");
> +                       dev_kfree_skb_any(new_skb);
> +                       return packets;

Note that this error (and the possible failed
netdev_alloc_skb_ip_align() at line 641) can leave the queue in a
frozen state,
because of a missing

nixge_dma_write_desc_reg(priv, XAXIDMA_RX_TDESC_OFFSET, tail_p);

Not sure if this driver is actively used...

