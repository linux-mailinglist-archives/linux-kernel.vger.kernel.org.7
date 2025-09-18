Return-Path: <linux-kernel+bounces-822338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A9B83938
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE2C7A6E49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E62F8BF7;
	Thu, 18 Sep 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch3pWP6i"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED4275AF6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184953; cv=none; b=i1qpLXxfpfNqURG7Fri7ZggR8fPXPDp5G57cESyfB+vTXlnfVsH8GjhMaVVzWVx5PZG2dSH0jdSeZQJT02xeys+DHWoVxL5RF3Gu2MBZVbdOlJ57mIgmDhuYLTwcZ7T8AIsXa4+u+jUTEV51zQPZfWyH2qRs6LURpNSxl8XRfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184953; c=relaxed/simple;
	bh=+apsQO6QEjdzapAHpxbdsNcSCb9gL0RNQ2fDJKQk9oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9RAYbdoN2pjP77hQZSuEnxJVVWHXKf0R7Dq6g40+xU7I3/44W4VHRCYeVjia89lkrBgbjZm5lra7QA3sICqwhr9+pEISs8ycx1AFili3ZIe4DHUfRivUUO2BGb2SV8XZk2QDCneFL2Zl2RVio/OaWvSwpk7WIZ9AkyuTZ72leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch3pWP6i; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e1c40ecb0so540392a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758184952; x=1758789752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgpJuE6FSpEricZhRzRNffSw0PwjJk1HPEn6KVtJT7M=;
        b=Ch3pWP6iv2HFT3p9w2dd+qVofCYfmWgR3beGFKICOr117JdMgXwQHeEkTOExTxiGj3
         bmbIjZAMh0ajITnZ8DQV4kXGgzmfOd7sqTuAh2wXtRRD79JaoU8M2bj+EgZJpwywzcUz
         B08IUCE/HLR+4U0LmF4dceSsAXHHa0anuuGQ7foufTnAb1bZ7TTL6cPbYdrkLe1UzI34
         bHpgvXWrZgDlf4D1ZkRaIHjTZHrpJo6QysO4cKi5wA0cJoiqYTBYoNBM3h0cCO0mu4wS
         yzFP12OuDzwtDVYw8xvrbuosCeTNbHpnQbrN3R2+5lFM0YddWeAakDXeIhPTrNeHqzV8
         FTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758184952; x=1758789752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgpJuE6FSpEricZhRzRNffSw0PwjJk1HPEn6KVtJT7M=;
        b=jBO8tEjW9Nni0rgS3KiB8FX620katp8H4AvlnRDo2NEI1lEgiKgqcaZP37ANohKRM9
         vTfdkX9UEclC+XpnpQeIt/0DRPBrkEtD4To9mZu5vWW37KbZcajZYhbdL5SVtBB/aIJL
         Jh3kl1ockd2h3OHZfEQOHvlKT/NBo1V1kmqFndOF0jEGAEUAeOI06k5gonkSExhYICk2
         jFGwqaR7PR5b0vSuNP2Ao7oVhfn2NiarqjwUxTFljID3FLM6DsvbOTEK9Jq8tcPv9SXB
         UJZj4Ac6L/XFHSgD/FYHGQUdPslDh1MWPQfSxgG9hAVujVz+K3LdvCh94L5wWYfxGK0Z
         OHKA==
X-Forwarded-Encrypted: i=1; AJvYcCV9xVbo0Gz90KbupL2Lb8X3qVdPLVvO/fEID2pu38e7N1H2smnB0FeMadkrRBFnLeF8pepDgT8ZaQ9itFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYImcKTO23HPSLAuvJtQUrFgoKgUlqDOpt0szIKrssnUYC5ovk
	cwqk349XSg5TjZPlYOhBlxNshGh/6ZaSIEQumWC56iC82jA8T9FrU/FK
X-Gm-Gg: ASbGncstJBKmDse35Dp+oEMZyytXdxbmIOStZE/bmTvY52q8ozUGqciUMCY9MN3sC8C
	JGOpsH+r7S1eEOoMpOxLwkAm2pGIs52+tcIebSC84t/afzQ/d6f128160jMIbx99Gh/ptgoMVlI
	cP9bcGO53UNNT62UgXKOBlIhaMzeOUAnZUNWSg71Ly9QRMrSQy0ANk9nVTj7oRSyf2RPZ0kg0BH
	/vU1ekWk5qHoOeRAH4w+FKKdjirRji2XVi/lfrioAziAsn4mTCGpT0+tX3b/dGapf2jv39z5Cle
	IFiOSlP3t+OwIiqe4pvM2Gn0ahsdgYfYVgHwW5HxYSVOu5JOQFiIvUgVhaXQS/Bzsm5SjKkItLT
	RYq9hn0myGiqTQ5uvx8kxGzDY14n+EsRqQTpINCKYIYmKdVOd648=
X-Google-Smtp-Source: AGHT+IF4rdzSBg32vZ0gOZ5A2EXINLPGUFMHUK7MiBcB7eEAbMtGfUaW+xnMSNLr9IaJ4SNTLIzT0g==
X-Received: by 2002:a17:90b:35c6:b0:32b:d8af:b636 with SMTP id 98e67ed59e1d1-32ee3f619c7mr7502380a91.19.1758184951396;
        Thu, 18 Sep 2025 01:42:31 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff229940sm1655100b3a.99.2025.09.18.01.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:42:30 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0F8AF4207D19; Thu, 18 Sep 2025 15:42:27 +0700 (WIB)
Date: Thu, 18 Sep 2025 15:42:27 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com, Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v5 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aMvF8yNJbPSqqypY@archie.me>
References: <20250918051538.3651265-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oV2pbrsk+dCJ8esC"
Content-Disposition: inline
In-Reply-To: <20250918051538.3651265-1-o.rempel@pengutronix.de>


--oV2pbrsk+dCJ8esC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 07:15:38AM +0200, Oleksij Rempel wrote:
> +* **How it works**: To inhibit incoming data, a receiving device can for=
ce a
> +    collision on the line. When the sending station detects this collisi=
on, it
> +    terminates its transmission, sends a "jam" signal, and then executes=
 the
> +    "Collision backoff and retransmission" procedure as defined in IEEE =
802.3,
> +    Section 4.2.3.2.5. This algorithm makes the sender wait for a random
> +    period before attempting to retransmit. By repeatedly forcing collis=
ions,
> +    the receiver can effectively throttle the sender's transmission rate.

Please align the bullet list text. I see hanging indent instead there in
htmldocs output.

> +* **What it is**: A standard Ethernet frame with a globally reserved
> +    destination MAC address (``01-80-C2-00-00-01``). This address is in =
a range
> +    that standard IEEE 802.1D-compliant bridges do not forward. However,=
 some
> +    unmanaged or misconfigured bridges have been reported to forward the=
se
> +    frames, which can disrupt flow control across a network.
> +
> +* **How it works**: The frame contains a MAC Control opcode for PAUSE
> +    (``0x0001``) and a ``pause_time`` value, telling the sender how long=
 to
> +    wait before sending more data frames. This time is specified in unit=
s of
> +    "pause quantum", where one quantum is the time it takes to transmit =
512 bits.
> +    For example, one pause quantum is 51.2 microseconds on a 10 Mbit/s l=
ink,
> +    and 512 nanoseconds on a 1 Gbit/s link. A ``pause_time`` of zero ind=
icates
> +    that the transmitter can resume transmission, even if a previous non=
-zero
> +    pause time has not yet elapsed.

Same here.

> +* **What it is**: PFC allows a receiver to pause traffic for one or more=
 of the
> +    8 standard priority levels without stopping traffic for other priori=
ties.
> +    This is critical in data center environments for protocols that cann=
ot
> +    tolerate packet loss due to congestion (e.g., Fibre Channel over Eth=
ernet
> +    or RoCE).
> +
> +* **How it works**: PFC uses a specific PAUSE frame format. It shares th=
e same
> +    globally reserved destination MAC address (``01-80-C2-00-00-01``) as=
 legacy
> +    PAUSE frames but uses a unique opcode (``0x0101``). The frame payload
> +    contains two key fields:
> +
> +    - **``priority_enable_vector``**: An 8-bit mask where each bit corre=
sponds to
> +      one of the 8 priorities. If a bit is set to 1, it means the pause =
time
> +      for that priority is active.
> +    - **``time_vector``**: A list of eight 2-octet fields, one for each =
priority.
> +      Each field specifies the ``pause_time`` for its corresponding prio=
rity,
> +      measured in units of ``pause_quanta`` (the time to transmit 512 bi=
ts).

Ditto.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--oV2pbrsk+dCJ8esC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMvF7gAKCRD2uYlJVVFO
o79lAQDH8IV49DcW+hwiMg+vNiZyA5vrPzmGSVHqpDc1ILyIHgD9Eh67ub4hbJGg
Spts2kxJlXc/zM5nT0aVpERot9Sgjw0=
=ajh1
-----END PGP SIGNATURE-----

--oV2pbrsk+dCJ8esC--

