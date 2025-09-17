Return-Path: <linux-kernel+bounces-821011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B7B800D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F755189890F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769CF2EF675;
	Wed, 17 Sep 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHQdZlm6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DD2EDD41
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119507; cv=none; b=lxY2GvxycoGN5XCKXotB39TzgKCxuLYXj5gy8LsGqiIPOMBBYlDCFUKWA5dnEolkFPK5UsdiKjVbkweVDwmZViMX68nVaGmEmwil85OrZgkE0SwWk+30K8XfxCk2/2yuZVs7ZPB03wSnZ5nImlPDQmn/6NLrwknmiKo9aNaup7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119507; c=relaxed/simple;
	bh=pmZTa+8cnY7Efr6/mRZy0dWltDPz1nlF8NdW0P91Y9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AFOyeFc9MNDmtUC9cd2eqIBoKVdM2ZKU2y8geRDeaPXqVI5uqxYzQ+BTtARkDpHQewNqJErHnpXTGfHzx7abueuPjuw/4dmC4NSKXKWuW8Q7GW83sLnBRb8wz+aGI53M62QZ8cx468w1crkkS8Y5uOaNoraT77YWJNgJ9yGm9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHQdZlm6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f28b8e12cso7269057a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758119504; x=1758724304; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyY1RV/auovX2uJdCFMa3w6J8/ewCXkxPUNzbeKoZdo=;
        b=UHQdZlm6FfREwgu05wpI5BdkNT31V5dJKYkcA1EaCthiu75PTdoseiV+lM6YMpWRLh
         Z1vNYbS7Wo9ojMxun7qhGvFmX038VqYjBQBrkXoWwRdnw6N449GpQJm8mk0dsRWX9gkl
         czHnw2NKvUfN71vkjglJyuvjUuRs07zCypvFHaz8BR6vVUXNBJf/+i1iOZJPsD7xYfTE
         YbR5A2GZSs8uLoMbxS9ZRtZ3K+C1qIL/BztW/QtQZho73omSFrHWyEaovwmeN7Xo3vBW
         42naUpdLwlkaw7OulfcHc3F7ZoR+yFb8FFYXf+izAiQbV11B/upY3WWuXgxMDhM09vX/
         QGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119504; x=1758724304;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IyY1RV/auovX2uJdCFMa3w6J8/ewCXkxPUNzbeKoZdo=;
        b=PjTJlj+ZusKKuf3w1ogHltPB7S8lh07f9aHjbRdHBqLj8zy2V3I4iaiuQBoxdn2zr/
         hr0V3XPKSs3ObFfDeK7aL3fyRphq3PLZ185jxcSmrnv2u21U167nmRjYsoDQBeMXghu7
         6cLzTFyffrKBEKwcR3TqDtF9vF39y432t740c7KCCf58EBLugkCa9njN6SZ5bAfTGbTs
         xf0CrmK27ZdyUy3U1vcNGNvqRJF0v9cdaJ+HPg/32FECEIEzpwrIYthpAxII85oEdBPm
         6QyfLAlbUUzgEAHbnkyeh8XGmenarqz0Ipx1mkcOvMzki1SHwwXD6LUD6ktpRFKTrDyo
         hu6w==
X-Forwarded-Encrypted: i=1; AJvYcCWGpoCDbpFKBwe2E8/viA2fgh2tNmoYfI9bglZjR6EQc1PFI5pLZIS1FuhzgG0YJZV26pCwWMU1no8gCto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmydogm9Asf/rOnpJqkLd/CcRTBpPDcTLaKSsCy/w9wuZmde+
	jdWKvj9wK6ix+m/eTmMJW8rh9ZOMqTKwnwJHzK60nnEFc9CGTnWSptB4
X-Gm-Gg: ASbGncu0p9UJAu86vIIIQ4EeA40h9Uuk/kPAHG/MNNnf5v2SWijVet5qRuO3OfZGgmn
	aMpPfjcx6MoSfQuXTWzinZNcEiJvptaBAtyMLbX6MvKEW6o6L79ftZ8lUWeOm5SKdjNj5R1fMuf
	MJfUU8Q1sEhpLoyw3qEz56zRaTalRHUedbAfkCkwILlSRBS6I9idlP62sYceEmVhaDbQ58B1pIX
	nJrbRwBPosTZZ6Iww+HIDEGfaUrjLS5oaNIfRnlFSErbDleJnWZcVsaBjLVKa9UjmezaTYMhkMR
	VowniD5wyc39CaPhCyPEjMJCDEEVVWUEaBH8Xy4dOfvLZMttq1hHLakkuleiHfijjSfnCAgVEwD
	1OP6oaySfffz4ohaYXhDmWr4idT0oVZZqATHJ3I6m6e7Tj5A3dTIGHzKvUBHxGGNXu7k=
X-Google-Smtp-Source: AGHT+IGSu0kLCnKgEdILIwXArUGLgXbeJB2AOyLfpHxUrOACUzPlxCRqec4ro27CMYP0cvBESnTAKA==
X-Received: by 2002:a05:6402:3252:b0:615:6a10:f048 with SMTP id 4fb4d7f45d1cf-62f8443a507mr2008537a12.33.1758119504155;
        Wed, 17 Sep 2025 07:31:44 -0700 (PDT)
Received: from localhost (public-gprs292944.centertel.pl. [31.62.31.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f70984065sm2433229a12.33.2025.09.17.07.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 16:31:40 +0200
Message-Id: <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, <stable@vger.kernel.org>,
 <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Russell King"
 <linux@armlinux.org.uk>, "Xu Yang" <xu.yang_2@nxp.com>,
 <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
From: =?utf-8?q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: "Alan Stern" <stern@rowland.harvard.edu>, "Oleksij Rempel"
 <o.rempel@pengutronix.de>
X-Mailer: aerc 0.20.0
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
In-Reply-To: <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>

On Wed Sep 17, 2025 at 3:54 PM CEST, Alan Stern wrote:
> On Wed, Sep 17, 2025 at 11:54:57AM +0200, Oleksij Rempel wrote:
>> Forbid USB runtime PM (autosuspend) for AX88772* in bind.
>>=20
>> usbnet enables runtime PM by default in probe, so disabling it via the
>> usb_driver flag is ineffective. For AX88772B, autosuspend shows no
>> measurable power saving in my tests (no link partner, admin up/down).
>> The ~0.453 W -> ~0.248 W reduction on 6.1 comes from phylib powering
>> the PHY off on admin-down, not from USB autosuspend.
>>=20
>> With autosuspend active, resume paths may require calling phylink/phylib
>> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
>> resume can deadlock (RTNL may already be held), and MDIO can attempt a
>> runtime-wake while the USB PM lock is held. Given the lack of benefit
>> and poor test coverage (autosuspend is usually disabled by default in
>> distros), forbid runtime PM here to avoid these hazards.
>>=20
>> This affects only AX88772* devices (per-interface in bind). System
>> sleep/resume is unchanged.
>
>> @@ -919,6 +935,16 @@ static int ax88772_bind(struct usbnet *dev, struct =
usb_interface *intf)
>>  	if (ret)
>>  		goto initphy_err;
>> =20
>> +	/* Disable USB runtime PM (autosuspend) for this interface.
>> +	 * Rationale:
>> +	 * - No measurable power saving from autosuspend for this device.
>> +	 * - phylink/phylib calls require caller-held RTNL and do MDIO I/O,
>> +	 *   which is unsafe from USB PM resume paths (possible RTNL already
>> +	 *   held, USB PM lock held).
>> +	 * System suspend/resume is unaffected.
>> +	 */
>> +	pm_runtime_forbid(&intf->dev);
>
> Are you aware that the action of pm_runtime_forbid() can be reversed by=
=20
> the user (by writing "auto" to the .../power/control sysfs file)?

I have tested this. With this patch, it seems that writing "auto" to
power/control has no effect -- power/runtime_status remains "active" and
the device does not get suspended. But maybe there is a way to force the
suspension anyway?

> To prevent the user from re-enabling runtime PM, you should call=20
> pm_runtime_get_noresume() (and then of course pm_runtime_put() or=20
> equivalent while unbinding).
>
> Alan Stern


