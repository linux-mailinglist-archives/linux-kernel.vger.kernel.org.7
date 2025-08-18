Return-Path: <linux-kernel+bounces-773742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951EB2A893
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAA21BA4ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD932C235C;
	Mon, 18 Aug 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b="l1AlTTjl"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F81E8836
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525369; cv=none; b=aaiWfBc4w4/OZQETAR5Ov7tg/0rP76wic9W0vlXFAGF5j8VYi1c6514U9pRm0BnBQAjc/guipmpz/siVYLLztffJyBC5WEPI1Sks7CI7h+jGvF/Az96ynKXSkcRFrJCidNaeVTkShbCQWeoB61a8LimY+jOhYshBdBKXILteiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525369; c=relaxed/simple;
	bh=kxwdAUu2zY5vhHf9mFzq/NhkfF2YCg3YlMNOdGVC6Xg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hsOyDJSwOywCl39SYytoUOTaUA+yDlUsSfEZpgcwW8TC3qagVpVmx0Ut9o8flZ+TE918rHpER+m7b2pFsY+WFtXf8Eiq7FGyA+nQQO/5RLAFPbywcvwYuI0Leg9LmBPkqvAH/tIsUrRJS8fp7UOYRr3iacwoY22TVuIyHPro3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io; spf=none smtp.mailfrom=coresemi.io; dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b=l1AlTTjl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=coresemi.io
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so4321984b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coresemi-io.20230601.gappssmtp.com; s=20230601; t=1755525367; x=1756130167; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knjo7tVoICwQ1/dX/7NdQHS5Cp98cmu3MQrZQIGu3Nc=;
        b=l1AlTTjlqjFymN0PDycAszkcc0QS4J1aBsOUaG60SC21jvgJzmky0Vd67+5uNJqV37
         LnJ4+bUy7Nau76BhigafRp3bTEAdRz5pe6wPduKWHvgCSM5FVc3VRUxZOpy8Eo7ho5Pg
         OXOuXTYyqm3nmq0aU14F9qYLvrbBsqUmiCK754CseUPsi+oAL8V+VnR2AvCrpwdWAz/0
         9jmhRitH3W95+Td4sQUnP4Ie4xjv0yyzWk20IbFIb00kuYiH5GRiVd2bzd1Cu/Cs5yTg
         oxKQd6nqu7wVOUrurKrtaZ4d9ah9apDdrwpYeY6B94Br5kaNFa3L2e2rPCFF8GBpv9FU
         Nv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525367; x=1756130167;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knjo7tVoICwQ1/dX/7NdQHS5Cp98cmu3MQrZQIGu3Nc=;
        b=jo5jSP+f1rmDrCgHu9JO71iU2NjZbLf7lVQXPRGalMp1sQK3HndouPAqAzmrY32p2H
         TIr/Kq4g7z0hhf/6DrdkjW9XZ3HKL/4br4aHE3ZjkhnZObj6SojJDbLSrqrgI0AYLNaB
         dGdhaUlHwe9UVSp90xUnPBf5MgzT6VXcgkZeK2oLFppGL7P1vAKcpW4SfYAH5zkr7Cgo
         YZ/q3Cwc+d7yITK5Ju/Pfr9eLUSIc3oaY1cNCyB67QskeU96ssaloyMun+HohtWPAARq
         t9uEYV+RzCIQ0kg2imgqSv68DSx8acTxcvjCRYRV5Hvo5nhBkDTbxs2k7VI99VvyqB2M
         4KjA==
X-Forwarded-Encrypted: i=1; AJvYcCXKnSvGJ0IlVY5Le0o1bLDk8zV8UOCmKDQ6JGv+7eHWHGqeCxqiKEqIGun88zJpAgTQqhWY7hfkAFwKcYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwsneGgYjUumvBLZNndnG11IcLW4t3ZDgDl9+AMR2Smf7WaB+
	H64lxmJQQoeIU/iW1qsDaI7lZnqUKovphEDyqJ71wlrabXV2r6rc9gb6b7h1GnfT6no=
X-Gm-Gg: ASbGncsBOqt+NyNFoaLg0Fv4MuHdPUli0R+Nk/lykgp4NyU8PQ2fTOgyxOe19Totk7H
	upL2CxhDA6UhSaMHmcX5RAhOqEpNfB4esetCKsvT+PYuMYyCXZxdywNVz44vEJK7cGYw55Y4PU5
	dZtsfYC+VYMaJQhwxkcIWAwdtMpJh5Q1ljYTTjdtQ5UI1UtAtNVwBJvYVSnK8x4WWRQ4FsefBD5
	MoIGexQl5zpg+TlD9bCYoKe68Lzlwc8IfpM1OuRGUPX+tMev1qejnuEazU3cSuLedQI8jVWEICM
	Ja/ea2pZIGD50Bsrun9R80/qksl2GlV+II1+09WqvY/s+X4gMCjnPFKseHyZBrMVWgAGC3dCMMm
	ATSTpLG8scOIVlO5bgtfNXTYmqmgvsRDY8m7AUux+ddiNQGgGKSpXrUK5TAnKADIqyQ==
X-Google-Smtp-Source: AGHT+IEnSXb0vt8RQwBHMpljKGdgSRTOrqgUIcFjVsEjlh2qZKWBpjKH+4rX8SY3Lmj+EtSaZgz7UQ==
X-Received: by 2002:a05:6a20:748d:b0:220:4750:1fb1 with SMTP id adf61e73a8af0-240d2de6aa1mr19430165637.4.1755525367168;
        Mon, 18 Aug 2025 06:56:07 -0700 (PDT)
Received: from smtpclient.apple (p121132.f.east.v6connect.net. [221.113.121.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b475095ef3bsm555683a12.46.2025.08.18.06.56.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:56:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
From: "D. Jeff Dionne" <jeff@coresemi.io>
In-Reply-To: <0784109c-bb3e-4c4e-a516-d9e11685f9fb@kernel.org>
Date: Mon, 18 Aug 2025 22:55:51 +0900
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Artur Rojek <contact@artur-rojek.eu>,
 Rob Landley <rob@landley.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB2BF943-8629-4D01-8E52-EEC578A371B5@coresemi.io>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-3-contact@artur-rojek.eu>
 <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
 <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
 <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
 <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org>
 <295AB115-C189-430E-B361-4A892D7528C9@coresemi.io>
 <bc96aab8-fbb4-4869-a40a-d655e01bb5c7@kernel.org>
 <CAMuHMdW0NZHCX1V01N4oay-yKuOf+RR5YV3kjNFiM6X6aVAvdw@mail.gmail.com>
 <0784109c-bb3e-4c4e-a516-d9e11685f9fb@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)

Something like:

J-Core SoCs are assembled with an SoC generator tool from standard =
components.  An SoC has a ROM from soc_gen with a Device Tree binary =
included.  Therefore, J-Core SoC devices are designed to =E2=80=98just =
work=E2=80=99 with linux, but this means the DT entires are generic, =
slightly different than standard device tree practice.

J

> On Aug 18, 2025, at 22:41, Krzysztof Kozlowski <krzk@kernel.org> =
wrote:
>=20
> On 18/08/2025 12:57, Geert Uytterhoeven wrote:
>>>>=20
>>>> No.  It=E2=80=99s a generic IP core for multiple SoCs, which do =
have names.
>>>=20
>>> Then you need other SoCs compatibles, because we do not allow =
generic
>>> items. See writing bindings.
>>>=20
>>>> This is the correct naming scheme.  All compatible devices and SoCs =
match properly.
>>>=20
>>> No, it is not a correct naming scheme. Please read writing bindings.
>>=20
>> Can we please relax this for this specific compatible value?
>=20
> We can...
>=20
>> All other devices in this specific hardware implementation were
>> accepted without SoC-specific compatible values ca. 9 years ago. =
AFAIK
>> the Ethernet MAC was the sole missing piece, because its Linux driver
>> was never attempted to be upstreamed before.
>=20
> ...just provide some context and rationale in the commit msg.
>=20
> Some (different) people pick up some irrelevant commits and use them =
as
> argument in different discussions in style: it was allowed there, so I
> can do the same.
>=20
> Best regards,
> Krzysztof


