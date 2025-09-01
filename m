Return-Path: <linux-kernel+bounces-794601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32914B3E3C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7E948024D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4F031DDA9;
	Mon,  1 Sep 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/gO95zb"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5324DCF9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731360; cv=none; b=pGKQIX1qRZ1mYev00uVrsZllrU4YjElIhqF/TExHOIORFNpeE0Wg3GhP5WlVd+L7hHaSA09rAv1gG8MeF/4UCbLg4wtSBwSGG8tk4HRpLZeGzVGtKKY7nhF/buTn0qqEgyJtyVTDMu5/SxV2wqMmmul2BNs0IzFTIxQa0Vr00So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731360; c=relaxed/simple;
	bh=pHzvO7FnuG3Y8cfVPYEujz8Pd5Zq+LpomOEmuXlPsmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWsibbiXYF4mtbuJPXGiOqtvtuzSE8LeQSrHZUYGnQqiiFMEsMSFFnlDt+H7TOS3RTbvCV8R5sxVeUq/ctcALjbmLwmkmqxKzO66nSZ8asB1IL1UYxxVSQNkIYpZNZ63lqrzXedqnwVST/fbvFbq+fm+WAQnfbT7lliR6HKhOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N/gO95zb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f716e25d9so1827906e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756731357; x=1757336157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHzvO7FnuG3Y8cfVPYEujz8Pd5Zq+LpomOEmuXlPsmw=;
        b=N/gO95zbSPubz8+fzkr6d8SHjON0h46SBRktPorCqmn6D+B82hgZTNEFmMIrupTg7R
         zYuz1kGzhik1SEt9feAOvaWAXpXgiefY3MFfD2BaCPBi53k0cOcbRagmFsqnlVUyk6tR
         eZYJI0SZfFdsYy+rdXQmOxj4VU6vhVyGvoyqT1K8H/1nNTs5jLSGr1UKEeInicwgDZEv
         C1Pp22q6QByns6Lbc0MUOvKDRxV623kJr8bbYlcRqUtYHiHX4LwzlB0gLO25abdxq+Ai
         IVXh14nTxPWDT4FxghiQTce7Jmi1kVm1ujQCljSHUP+Gf2M4pI05A+8ZBZkArkgeKrxj
         ZeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731357; x=1757336157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHzvO7FnuG3Y8cfVPYEujz8Pd5Zq+LpomOEmuXlPsmw=;
        b=Kc51xl/At5rO5qoe5EtMo+CFetzxLpy6VU4J8RqaVA9oyEDXKt8QSC7dbtAmlPVSuH
         AYa6alznIu8P320cHl5K+rm7CD+sNsTKSnvaYJOWNwkvJOzudu3f3WrjSukgiWuFEwgf
         M7QSEB5Wkx8IJfklxhxkeyde4KMbkHGwWnPwr0rcvmJcA8K9nB7F9JW0fiwoeog6X0zV
         bGBrsfcZtHbQey232FmtKdgntPxVMspN1/ArX1EU4SgnhBsMHYnhR2pr8ycnxLcEgF/M
         miTJRKilsx7oQcBLyxF+E8QokKo5r7/2AkxPkKsJp3ZXmjZQX/Cf/hwDVIstR+8GpA6Y
         xYdg==
X-Forwarded-Encrypted: i=1; AJvYcCWqVe5FndKuKylCRX4XdY3C+GmCToqnkrPePQ1mdNdI5uUXpq6nl9EGVCLI8JU628heLwS6bxN1KIAgr48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Xym3RVilO90RWIvRyvzJomdTMnfBy6xF2GN1BKydR2S1Zh8h
	XW2rmezX/r2s3cLTy3SHg612uNO9qVKKn1muBkUmrKVjqcsORD9hpJED4wvYrPy/qqkkZibx3/p
	V2HwC/OXSsn/50hldmhAVFw2/Psy5Ts2O9cxTWZaFow==
X-Gm-Gg: ASbGncs6voqVu456psURDcsbnHxQBUEkiJsLvcHDydnBB9jsV6NPNflc7wsbBMhHJvG
	jHYsS54QVT1Jtr4ut5BRrQ32a0RCx+WXgugrxenpqViinCYdER4JQICtc9ddEN57UmI2uQ+xAWY
	iCLpuS2SGOiqQegcoQKe1R60sxJnMIuvNIjvbE8bBwBhL6v91TocQInPgjLP29YpQ9npgOaojS/
	jB1FeA=
X-Google-Smtp-Source: AGHT+IHDj8cz7cQZ3X0v3+zhy0ZHW1Bc0Ee2H0FX5pElqXb7vIdjHb7N5zlkeIrybjYoRm4vWr0BKtNdjorjqsqto2I=
X-Received: by 2002:a05:6512:4608:b0:55f:48ab:a2c2 with SMTP id
 2adb3069b0e04-55f70995397mr1725798e87.35.1756731357115; Mon, 01 Sep 2025
 05:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827024222.588082-1-gary.yang@cixtech.com>
 <20250827024222.588082-3-gary.yang@cixtech.com> <0fa7e2cb-fa0b-4f9e-84d6-a4b2b3d8a4cf@kernel.org>
 <PUZPR06MB5887D9A879D16DC6A8C8ED58EF3BA@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <25283b66-4cbb-4db9-9b1e-7a4e6e3db2a1@kernel.org> <PUZPR06MB5887887C93BFF42BC8417D96EF3BA@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <CACRpkdYC-3qybKW7VH5MVfBc3oqSrOa2RTt1Q=p=HHsi5drGOQ@mail.gmail.com> <PUZPR06MB58871C2E108BF1AC057EF461EF05A@PUZPR06MB5887.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB58871C2E108BF1AC057EF461EF05A@PUZPR06MB5887.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Sep 2025 14:55:45 +0200
X-Gm-Features: Ac12FXzfjnaic5AU3gd0OQUgGODH28pTgWB36lmJD5eBDGGK5IJq6vSA5jGXlos
Message-ID: <CACRpkdYRTKHy0ace2o3NAeuSR3oai9fZMPrN6qQr3Lyqif4OSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: Add cix,sky1-pinctrl
To: Gary Yang <gary.yang@cixtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:20=E2=80=AFPM Gary Yang <gary.yang@cixtech.com> w=
rote:

> I understand your thinking and try to support the standard referred to ab=
ove.
>
> I only need to spend some time to research this scheme and debug it on Ra=
dax O6 board.

Thanks Gary, I have this board too so I hope to be able to test it
directly.

I haven't figured out how to boot it using device tree, everything
I have going is using ACPI right now, but once I know how to
boot it with device tree, I will be happy to test!

Yours,
Linus Walleij

