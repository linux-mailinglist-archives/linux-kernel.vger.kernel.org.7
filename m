Return-Path: <linux-kernel+bounces-827450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3F4B91CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A172A2AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FA2820A3;
	Mon, 22 Sep 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlCvPhXM"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6261E5724
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552618; cv=none; b=qq7NmnSCKh7XMJeMPTwPWJemRSKXuI/PYVd6K02jBcMPBOychT7R+6ilnZI60/B8Vt9toCUU7w1JEWwJQLBwUMAF6wTOrduqyCwoIpX16W20/bPqDIhBRJc/UCYDgZSSfrhUt5NGCfQa0c1zB9LV00EfaCEq2VoVxz29YHTQPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552618; c=relaxed/simple;
	bh=PJkfGbWQ8DKwLCLdQal42ea+EEF76F0Bpw81JJEN1eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE5tmnffReRVdtNrCTIOQQYwk0pnyynd4E5x/e+ZcvBLnrhhxAFQtHvhDc8NPu5m8A2lNjtVB5+5CUKlxS5VcUjWvZ/jLYpiHTDzvDY//+wHM+GSe8DZltA8bRHK41kxBo+jHv9ICbs9Vi9lqALBbQcihZSw6Ziwp9/vgqNAH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlCvPhXM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-579c95a2be2so4444351e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552615; x=1759157415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJkfGbWQ8DKwLCLdQal42ea+EEF76F0Bpw81JJEN1eM=;
        b=OlCvPhXMQrTHiVgolN4LwWr/VoY+H8xnlLyJr8IU5NvofmTriNS5gfKn53y4aHWORH
         P0T3PxAKsYHYbIRO/tvCP1bV7dP3+M6gOobowGt1HzNLw8OLBKHX1rG5IihLCyJRkfgY
         1W3yWW7d8m/Gx3hMOsffmaugfPvUrMu9N6vrK/T3KtZAjgaQhdu3IGt1uxvEaIMpkiIf
         TzwjzFbbj0pInEv6aZyI2eCh4qmQcJz7SETbqBjGfXrKYCBgB5aQtEeg+31TayC+2GLC
         NWQCk1kTI07GkHxkxyG8iWVluQX+Yk8owOo30UwR+SxhnDio6ohd+CoOrb0XoX8vFkGL
         fmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552615; x=1759157415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJkfGbWQ8DKwLCLdQal42ea+EEF76F0Bpw81JJEN1eM=;
        b=vonZwAxPteSh2B+sC8XeAgs1t0S4a99dmCWIpeBddf3COL6FDUxYTvWzbmqICfuxzI
         4lrPVaUlf4Jz2fgiIpGF8W7LrpFuXZcOjizdUS07QmepRTNt2kgPj8b67Q4w3W6iC5GJ
         SUryEN7wCsWVFwUWLkrRGnPeBLk5bbxchEv8kc9qmoupsRASNmkkhczq4TEg04n+PHW/
         NmFbZ1BtdZ2Ue+EwS9BECVaYoXF7jLqWAFRXCCSkzpu8o42WUSnJoHlZXCBugUUt9DS3
         PY2+/1MX/QJQf8gJ455+RBbV/3vYb/6KWnnjAb4Qu8BDsrKGx0NDZuLr4H9PKv3lkeu1
         uiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXGK+gBfbWY5ARxK+MZnw6nyACRLHAGJL9b37qTJfYfqkYlwX4e76h7fHhmGjyYgwYBUG7pSyHjG49OH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/0c++OojQbpfXuleOPXjN/hnaMuyqQ9MLw3+fBHuIyo7iudq
	bqBe9rHIfuS1tC6CJS2vTF9GMMwRh7OzyDROESSA5/1aabYCK2J27wXy0ZrIxA==
X-Gm-Gg: ASbGncs0qBZY3lqzv0chjmIexezOaxBw0Mc1Z+sj78Ep+MDMJVj+2jJznt/5x9BFS4R
	Q0cfOdFGEWv8smiHOERvYgoQ6+c5KejRspKGvj5vKkSWtcjbi9mELilK7jmBsunza933sj4SJ14
	m/fJSC/0kKcOT46WYBxrC41ojLJjt35GiSzakpQZNr5R6YvJg29qop80Mbtpm2r8BnYEEfDRGaF
	53exJ7+hSfbvP1rJKACYEnwwfA2MiloKRT/fZcOGGJOq6mZ5nl+0zFlflGIsUH+tAOkxl+b6cJ5
	5KG+e7X1XXyTVz9h5a0FN221wkqoE6+mDnAIugOxXiTPdcFmMoFiDR6LJhovUV12zeVIpkMJ708
	UOTBUrA7pVu4bmccUmz/0M+ca6Z5eBtzp90xljMNMkulRUB4Dj1Yrez2zEak=
X-Google-Smtp-Source: AGHT+IFcvDKfo6/rF+Nh3kI8hFqr1RyQcXaBGgCXhniYJNNce82tXdBX88O2hhL6GYKhS7xRDvOPEQ==
X-Received: by 2002:a05:6512:2344:b0:57e:216b:7605 with SMTP id 2adb3069b0e04-57e216b7873mr1995745e87.49.1758552614400;
        Mon, 22 Sep 2025 07:50:14 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57ea29ee5ddsm890447e87.19.2025.09.22.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:50:13 -0700 (PDT)
Date: Mon, 22 Sep 2025 16:50:11 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 5/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <aNFiI_4HAP5sBSTP@gmail.com>
References: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
 <20250922-i2c-mux-v1-5-28c94a610930@gmail.com>
 <CAMRc=MdMMQxFfkMPHaUg9nMWuW9F1p+PT2i-ggcU5SSFKOVGKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kLmsbuz1Pkyj0gi4"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdMMQxFfkMPHaUg9nMWuW9F1p+PT2i-ggcU5SSFKOVGKQ@mail.gmail.com>


--kLmsbuz1Pkyj0gi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Bartosz,

On Mon, Sep 22, 2025 at 07:42:43AM -0700, Bartosz Golaszewski wrote:
> On Mon, 22 Sep 2025 08:21:00 +0200, Marcus Folkesson
> <marcus.folkesson@gmail.com> said:
> > The bus frequency is unnecessarily converted between Hz and kHz in
> > several places.
> > This is probably an old legacy from the old times (pre-devicetrees)
> > when the davinci_i2c_platform_data took the bus_freq in kHz.
> >
> > Stick to Hz.
> >
>=20
> This looks good but would you mind also changing the name of the field to
> bus_freq_hz in order to leave zero change of misinterpreting it in the fu=
ture?

Thanks for your review!
Sounds fair, I will change the name to bus_freq_hz in v2.

>=20
> Bartosz

Best regards,
Marcus Folkesson

--kLmsbuz1Pkyj0gi4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmjRYh4ACgkQiIBOb1ld
UjIFaQ/+LAQ/eyJkvpFrJeZXJSpKHC7TjT/6INLurYa43ACv+OmVxYjnHFi6gpWi
biuX98wrOiTY967DDBgQnlCAl72iirRfxCkImgv0HPg7MfeLiXarhLWwJzYbzp/2
h/3v2LB3wOJGw+OnWkiDCVXgpT5ti1ME/5S2cx1DAK1RrgCWJhPRzEF6mWWrXEvX
hnrqSnf6OWFGN7SW2yegp0R5beRjKvZeI9Cg+A1x496RfRQKgEffQ6VxB50Y5iSx
4odYxRmVIEz9FSnWEhULeB77mgWT2F4vo0KokWd47MBznwwYDcIxtXnZMyW1Kqgb
0bPDZFqGnIvSQtgOo2tTiL7pAMvxncaWkvFMRmNFX+T+e8SjK0XyP+G0/IDETqoa
T2k4HPloV4P0a5szKoIzvjaS+SlvMN5F+26XW9k/V9lP7GL+tOFFhy21CJArjU2L
lRQ8SQLEIKu4JLs6RoVyOYiG+eFuwaaFTrzfBR1gULhMDrzBbT0k2nDrMjvWfGqI
wsMHXrGqb6eWNq/Vx0sWV5BNLFl5vL38a9bXL0Gv6Lpmc2p7I9SSYcTe9eNR7nVK
g2S8L/ivdCgXP/n9j1hmQrfACVKQec/DjxT9/HyXVwThXVUXso98DRdNOhZJyg5x
letC7sGiSN1Pr+P2PAhHYYS33zg2kXad7jm0sHRM8zh89RCJsBg=
=vtDu
-----END PGP SIGNATURE-----

--kLmsbuz1Pkyj0gi4--

