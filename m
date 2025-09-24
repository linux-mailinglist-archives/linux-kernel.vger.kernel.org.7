Return-Path: <linux-kernel+bounces-830505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64561B99DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8A170D79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1AD2FE04E;
	Wed, 24 Sep 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKFN8r8p"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C332E54CC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717275; cv=none; b=hnoH7Ws4kx4LDVYloPfOtS1iNBiVkH0KVYR/3Al9ByF6AX9Lt0E1D9Hb8pGAwxk3S+I1Y2TtCD0X1fDio0iQv/xkyo2vVRcK2P2WlsUeWU6WAKKPrVnVzA4IBJ2jzF9jTQBb7xEKvnidCTl8zut+TDWEnMTbZfpAh27mSYOc10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717275; c=relaxed/simple;
	bh=w/Y7hFj+095plLmyj6F//RB0JJaVllnXem2h/GAL5DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fT31hWZqgmi+mw0XTyHpAImdPqTSAZebYLnCYAl35eQCyKmxUjVlKOLpKtZPcdQu3m2nT+bcXBOLGQ91wJQS4sb2YVrlroM3e12IWdoInn/VViK8n6evlrDrh9Z5eKOwM1A0bQAP45kK7VRBEn6GDkOsvav/nj7bSptHHbqEmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKFN8r8p; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77e6495c999so5307303b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758717273; x=1759322073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTDFZgAdQghFMqYnaQQne0DSQg8eYDQbEUoZypuZEl0=;
        b=nKFN8r8px+pzegy2l8GzbujA3yONawgNDtwnTyjN3MVG+becplTcAFlrefsHstjep3
         Uub109iAJRU1KOEBZRFhm0MlO5B/XDZ5204pKV5O1S25FAmW1hjAuKLsZY5D9yBOgue1
         wzQzZpyoAs3gMYfKOBD0twEMueSvXUHwcdvVcfy/Venut+jIUoEBvOw0k88ejbw3FyaL
         OXjj5SaAg5Axb1gReX4SUBHgktHAlvjF6sQQatvc5qdtB7sraWLw5SR+ezqLf+E6B1oy
         GPhrXvwiHxtcwplCpwNX4Nupiar2cWlj1pbTEcCXNi6Pe4jSUNFvZfNpRgbj680D9TDu
         /CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717273; x=1759322073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTDFZgAdQghFMqYnaQQne0DSQg8eYDQbEUoZypuZEl0=;
        b=p236wkX8I8f1b2MIHkUXZ9FI7PG2Nie2CoKRKbAcVVKzuArP4gi8guYPq4G3EIW5Dl
         /L8slUcazVw11E/RJboSdcuVppdq88lMUEpbKMlXL9F3vBXolbeNMQHIQwgCn41v3PDF
         21yL9v//JXsR7p3u6Xen+5T4cDbKIqf+0Yt/lF1DhpJVpts4auypNrCXwJ+36pPL1oQQ
         8PvMJknoIWhVU3MkxK5OUGj7Qmj3XU+s95K3HZq+TniPNyA3IzuS+bE86ff6N+AnwwjN
         bB4RQNZtWD65TTRa6NdySdegiX9s7nDIj+tf6Jpa6qggnzKm1qzUf9UUjdSD4lL/e85s
         QpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+1+wFkbKcS9JCGPkmWfue79nXJOis06jQQJuX2zp5Ce/ddEX4R39M3PS7k4r3DH0qLlOgzQEQwJLDvKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTuRZAiA/y+edcIJFRRpykz5TRfSwD7t+p7hmDSnHCjMINzQI
	jlY+KanLWv+nemEx7K/gXxmROJ+vdHs71NdRK3Eh8rPo8xAa7VZnhj5v3iW2GsoRsrGpAj8yY+t
	Ypb74RHZ3EuqXXGP6wjKO0Hn+BAsHp4A=
X-Gm-Gg: ASbGncve5oliQCHRBhIeOltTg3o2ZzLxvsbVDYlG4j3yZ7Pe1lWBTIRzNpC2Y5fUNoY
	lDx2cnzVRyLzMME2DS+I2cAkMjEjPMmbdbtjjDteMHUyjePy5Oh0hGco89BTPw0GjZXpsbWkS4l
	P04LDx7cyskkmxRsVnpb8IjUhaXwjtOyWnLRYIQv/td3oa69AMiNXV4CdP3uw5CM/Xs2cfFvY7K
	UUCfh6Id1gC24iqFegv9kjUZJMR7ZE/p+gO6X4a
X-Google-Smtp-Source: AGHT+IHdx5C/tIG+bo3u5C0cXUba70Ijx6a94OsvdZgP19XusiUpG+AOBXv8usuNF4dJmHieFVzFc321rHyvoQrN75Y=
X-Received: by 2002:a17:90b:58c5:b0:32b:dfdb:b276 with SMTP id
 98e67ed59e1d1-332a98fc381mr6768390a91.34.1758717273147; Wed, 24 Sep 2025
 05:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922131148.1917856-1-mmyangfl@gmail.com> <20250922131148.1917856-6-mmyangfl@gmail.com>
 <20250923174737.4759aaf4@kernel.org>
In-Reply-To: <20250923174737.4759aaf4@kernel.org>
From: Yangfl <mmyangfl@gmail.com>
Date: Wed, 24 Sep 2025 20:33:57 +0800
X-Gm-Features: AS18NWBjGVWilxW3m5lF33pWes0iHg7AU_L8xzuQ8IGPKI3mtuMEre2fBRoTZXw
Message-ID: <CAAXyoMNBHgG-DFv16ua-T__iBXg=chFQ6TNoXdZvk4VP2aYESA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 5/5] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
...
>
> > +static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> > +{
>
> > +             cancel_delayed_work_sync(&pp->mib_read);
> > +     }
> > +
> > +     dsa_unregister_switch(&priv->ds);
>
> The work canceling looks racy, the port can come up in between
> cancel_work and dsa_unregister ? disable_delayed_work.. will likely
> do the job.

Are you sure about this? There are many others who use
cancel_delayed_work_sync in their teardown methods (for example
ar9331_sw_remove). If that is true, they should be fixed too.

