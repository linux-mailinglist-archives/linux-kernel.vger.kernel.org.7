Return-Path: <linux-kernel+bounces-866301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3517BBFF6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0651898BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7456128CF4A;
	Thu, 23 Oct 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M+iefYmI"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF072BEC34
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202516; cv=none; b=hLgKxrPLfF+bctdg8EsBLK+2u2lmk+7j461n4W4VbBz1p/ejYRWM0r+eZuQxrVIpHo0TGfjx6ZwvVUgz26sygVvqJcdTdQl+U1qslsWDtuDcBY1hrKnhTUVm2/ovJDEfaXzGRgGCqqi1Jjjh1A8kd+JJFoEJwnboD4Be0c8c8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202516; c=relaxed/simple;
	bh=P7cmVKMa19PXBwMszLnkcUvMTM39+KT1KleRqDn9CZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmKL0l+kRz/xBMaXQdyv9AMYhLuzStrnTx90bLsKcyqST9wgiOFifQwIw1ztJU3fCLeNK8aSKATpNVA6MUPBgsUHA41wgP52HH10ogXaF4eSpzvDcQ7A65o0QJ0Jjajzif5Y7ZL4EZ1TEagyLTUgoRolyNFi7n469Sf6/xVeu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M+iefYmI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47117f92e32so3450585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761202512; x=1761807312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7cmVKMa19PXBwMszLnkcUvMTM39+KT1KleRqDn9CZ8=;
        b=M+iefYmI7fTqOEnh2F0whlBl2Fme+S8oBo6SpjkMAYCjj03bL/crGt4JslFzXUdV2N
         xKbpZEHwZfea4zS9r/4o9Z8UVR1I+ZmacC/LvFpWfKzE6s5jXSidxAuJOLnbJdT2gjhk
         GEc98oTumMfZqWtOupcXI1nB4NPNyO4lk3MM/vYDwLhW9cWQ/wAw6SVwuYMORm6KyGNs
         w90xQGeHgQTCLrafSXNvNhjt+KqUj0DIw1zcyWHVQzZmufVAN/WlDYQHGNCMOM6BfOHC
         H+FiP6NmpCadHiHtAVfiZnLrFQNtzQhGqZ0W63xNTjWnuiW8t46D5iPF7eKuLcIEward
         0/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761202512; x=1761807312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7cmVKMa19PXBwMszLnkcUvMTM39+KT1KleRqDn9CZ8=;
        b=wlVMR/oBD6wonBH+zvN8xne7WhQcKyQzAuCrwrN2+QzCn5QkqqXa9ej15JoE+2wtDV
         rgYkZDCnA1+0Vt+UngVMf1VvsfMKPhq9aCRHvxedbzc5RISvHXVpyairiNyEe1DVZD73
         szw2+qI9KFuLjKKg3exsYEEMlB7mK/lbGo4suAmFLAfm+cwzJqk0ACr87XhfqUVZFBUr
         +Ncpwikr3cNSu1CpMo8i48BviTk3f3eTw2xQ1+9iuDuQyeEUnmjhaONd9jqEj1qzq9o9
         nZ3TkwLRYquSoWZ1gpCGNJg2VqlTWypBg0AdBPHxjHnzakXfg91OqUQdGBBV49t3Ghgg
         SW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1x6rr8N0nmh5zR6aBijVdtX2t5w617f8x51cSyv4V4ZvTeZzloCfooo+CRi/5iQ9go3iEbULRKWk1Qkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDVeU6L43dpdpqLhuF4sbCKieRRugKl5dhE19WyE71FqgvCC7
	PH4RLQpi80LwP2YVWGzgdvZbftx+8dE4IbwFzB9k3SIN/k9MMnYtdWfRqslbZckMZjpMVNgsMW2
	NC6Hw
X-Gm-Gg: ASbGnctI74/kfNksKjCmxnWGiBv4xs3y2wceGZIUrBwvwirvc9Z937C2ZpKu1KBy91f
	ewtYI0F+q1NWzZgB2MbExjzxIAOlQWjKgg15APrBU8wonvPLkvCRJDbe94/M7r2aGz2hYKXJ0cR
	ByGwRTc+7ed2KFqhopYsMu7XLgobf7D8b1paMmTQAON1k7pZ/c7T/O2VJ7RWR9j60PrInjdvOx9
	fYsRomMNuU1gpAgiKqb/Yf84oJF3OzMJLZWtRNiR9e7sCOdDfIrMxsiARGY+BrIrooWbeSpUPzR
	tQHjP5IMbVz7GlN3d6Lg4FbKIWSWcX8nXTNQPGN3mrdyVul2g+m5LyLTs6MDSOu9zk0VRM4QQrC
	HZ1+VqBxmvaTegInxyk9SYgoNcA4ThFrWtrXGbByUT4DmRQADZVQV8/+KdbH+nfB3zXfnC1zAyM
	icbMiWNSHGZ1iQ0v/nha+2zECDFZFB9gOeFctMN0DP3Ay7TPnGgHhn
X-Google-Smtp-Source: AGHT+IGKHAzueYEARosceZQSUNRMYONnIXPxr3aLgyLwcX+P5PWjg4x97vF6SnwM4KLaRqLIaysbSQ==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4711791cadfmr201702685e9.32.1761202512182;
        Wed, 22 Oct 2025 23:55:12 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c4342373sm93215405e9.12.2025.10.22.23.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 23:55:11 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:55:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
Message-ID: <enih2kbbrs3ngzciceekrks6gwclanmfxtzvrfg4fmeihnej5v@boap3ccfuy6o>
References: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
 <cdkpp74ra2ltr7h46psutkwnzyvl4iegcicnhqqj7svm5trltm@w2egfj5nryjm>
 <7d3df04c482e71760ccc941469c99412b608c92b.camel@ew.tq-group.com>
 <lgse44as4k6fpzarztfnfl7wbxq2bfg5k7m7l6xlsyx23pmem4@khal3tytgwjn>
 <1963351b2e50c537418293e6ab9293576a239c98.camel@ew.tq-group.com>
 <d46d07858a3b5cc9134e17509617901e2215122f.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rlgfuerx234j7yce"
Content-Disposition: inline
In-Reply-To: <d46d07858a3b5cc9134e17509617901e2215122f.camel@ew.tq-group.com>


--rlgfuerx234j7yce
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
MIME-Version: 1.0

Hello Matthias,

On Wed, Oct 22, 2025 at 03:36:51PM +0200, Matthias Schiffer wrote:
> As it seems preferable not to introduce the wrong code in the first place, I
> would propose to change the order of patches: The first one would update the
> handling of CTSC and IRTS with CRTSCTS in the absence of have_rtscts (without
> functional change, as CRTSCTS can't be set without have_rtscts), with the final
> patch of the series allowing CRTSCTS with just have_rtsgpio.

Sounds good.

Best regards
Uwe

--rlgfuerx234j7yce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj50UsACgkQj4D7WH0S
/k7wtAf/XcUFLM+wtZWzXix6dvhz+7BSQxsfdu/Y4GbDepTozo3tR+L4K4aSn4bZ
3ugNccUP7WI420z0hKS+Hfn10yomj9Ews/SGPoyysgqms0X3gU003eEbsfHAEjIW
4WdAbjFC2UVa2K5C/4TtvTEt7PKXuJDjjN7OKUX8LAS2fyBJnG1Us40nZaDGu5Fs
PuFGIzamgj0MQCFgtroBTuXmVolkOLuRXwHc7ul9EVN6nY0ki+OVIy0ZDZ580fSr
sNGh9lLSragixhuHHgzETqam2QphEW/Qqs/m4fONp0cZluZPcpc3+AtB0lObkIKw
eg7CnOkbCWjVIJXEJOVk57CbH8shCA==
=Nxbu
-----END PGP SIGNATURE-----

--rlgfuerx234j7yce--

