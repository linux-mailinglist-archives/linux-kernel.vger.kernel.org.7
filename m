Return-Path: <linux-kernel+bounces-840056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C70BB36EC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D879C165E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88523002DC;
	Thu,  2 Oct 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RGEzM7sy"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586D2DAFAE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396804; cv=none; b=jKSZ54Y+9ScIGxi0dKZe9521/GlASn53KJWX7o5VtzBHrVXz2/g6oKRikDaInm2cZ/cwFQTN3kWdUwy5wQecDG6NLAos0/PdT7ZitEUg6o6mWTr3/Q+FSV+X1wxeoOzOBgJ/cjzgF4ZsV002uf/Fw2ALOVe5TznoUAm0ZHsWqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396804; c=relaxed/simple;
	bh=gKG3RZCMM0/9td5XhwRRVDuctRczr0EQX9XI+rQNrpw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rR8kg33CzNJOQlqasDdXeYfyd+afuZFfWeMqz6hCHZc6IdtoRXZiRFM/t5aUDADFIdnt3HwhbZfU0SNvNwpBIERSZ3I+xTW/x8GVx53ajMdIIwxYIox8ytWZju+W8aAUfHo+aZdBSBFH03DR0VwqHO1v22J7Ht3Hq2HdvIL6dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RGEzM7sy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so7731505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759396800; x=1760001600; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s2BhPJFUA5rMfvZ1uL3WhmuxW8QfF3Kklsw/mp/nZyk=;
        b=RGEzM7syri9lkpHb4rl5HskJax0bAj8nFPAYH+LAoMVXCDnB5pqpMSD8mM1vYZtKwi
         9eQDL7mrP7zBC3L2QoN7AX2UqCuPfhp3kHMmMpFL64R+9dmc3eHQfm6p3LrXTgJ8INzv
         0yQytrmzb1uNCSaRVWvrqGlaL7kzwLI48mzU+mkYZrZ48J5hKGvzd/dISgo8OfwHyf9K
         eadQGMWV2KIltk0aN4dXTK+XqShCcY69PbLF8MJO9JmFnDztvdI1brF9VjjMRvp2JYva
         o/3EJdmNgPYJU4LSLXn6F5kFP1pyK6yO4lvDvwnVE328TbxPWcYkvMDOyd4OutAkzXZp
         SaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396800; x=1760001600;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2BhPJFUA5rMfvZ1uL3WhmuxW8QfF3Kklsw/mp/nZyk=;
        b=vkg4U0lP2GJyklb1D2h05O9qp/EOXyqQ0VmlztH0/Ngl9xbgo+ytndbvfxHL65tOUh
         Sn5UunCz+IuwBag3Lc37/z2+O51jKS3TdCj6H65EW+PDDECVyQiRXGNy1RBZXnQ2qMJ6
         GcnmN4GvYq33HODxpJnHpGjRqF4rweshh3+uphLZC0mg65I9sdD2sn159QOhibwYKOja
         2cY5wrRQehOk+7dbjWvHttWcgCIK7FXyb6Ovqu/0SwmbMGKmqiHd8mcq4j5bYulAUMTe
         0YkJo6Q5jJPedOowExZXdjK4glFeacEb0l8ond6e+Yz3DPJb9aXRlUxyZWe2qWVcHMEO
         N31Q==
X-Forwarded-Encrypted: i=1; AJvYcCV221N9VS5vlZ0meu1u/BcmXQrw1oF11wm6vDFiHLlnLXYts7KrLIvlw6TvX0pludelnLyQnRR/1vAgVv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sxwAHxb0+huRre71XDKa0+SY4iQov2k6zPMtEtlfc33MdPZ5
	QsbOJlr2gD+dPY2mJprFkyxlN2lVmtsSuhLJ5N43ZTHMNE48BLc+JG34A0rmW+qwh4E=
X-Gm-Gg: ASbGncuHACXdTG/Wp1+44os93jk+7Kwb7G4BHGs/YfUbTjAiPKYQG9HD7/6yJDrd4qV
	TWMwPtCWbJI/LuAqBKjdgqbVJm4BN662nVKEoglD1LdzTMqrbeIK95rreBSD7204s+W73d+/Iwg
	fE6Z5HTzxbcJ1XWaqcNG1RMaNs5+b8MxUfisEJmlLZcNCgXNSWzC3YDcrM70zHI0lwTn+s+dIak
	hGFCWka+Do0499yFJIZQ6n0RJWyV8aHEPBYoLl66dVIIpVcRVcgoxFAac4K7INa+NpEyMEyPKrY
	uQ85p4+6jCi5W4WAe8bfDv3p3dAbXCZXFVBaIoUtZetO+NnKJgRemB6RyX+/0rdNREgpNstpL6f
	sH+wihKE73echigDkldbx4bi0E0piYTK14F5ZnBJKTf5ujOeamSeyCNH3uosTFVIhSFiVSQ==
X-Google-Smtp-Source: AGHT+IHIFpkDmi1VU2+9VZXNZGV+SNIcJwRSxeDcMpiAWAFfIEuaOQqtErYVn3aR0Xr7bMMB0aIPHQ==
X-Received: by 2002:a05:600c:1382:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-46e6863e130mr20968605e9.7.1759396800370;
        Thu, 02 Oct 2025 02:20:00 -0700 (PDT)
Received: from localhost (88-127-129-70.subs.proxad.net. [88.127.129.70])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e61a029a0sm72705605e9.13.2025.10.02.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=55e5f674b6f0c4498d17272902032cc52f7b00d4661fa093516501d66420;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 02 Oct 2025 11:19:38 +0200
Message-Id: <DD7Q3TRDJQMG.3OXQED3HRBIL8@baylibre.com>
Cc: "Tero Kristo" <kristo@kernel.org>, "Santosh Shilimkar"
 <ssantosh@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3] firmware: ti_sci: Partial-IO support
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Nishanth Menon" <nm@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com> <20251001170036.favd5zaieknywcch@amendable>
In-Reply-To: <20251001170036.favd5zaieknywcch@amendable>

--55e5f674b6f0c4498d17272902032cc52f7b00d4661fa093516501d66420
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Nishanth,

On Wed Oct 1, 2025 at 7:00 PM CEST, Nishanth Menon wrote:
> On 16:37-20251001, Markus Schneider-Pargmann (TI.com) wrote:
>> Hi,
>>=20
>> This series adds support for Partial-IO to the ti-sci driver,
>> implementing the firmware interface necessary to enter this low power
>> state. It processes the wakeup-source properties from the devicetree and
>> communicates with the system firmware to enter Partial-IO mode when
>> appropriate wakeup sources are enabled.
>>=20
>> Partial-IO Overview
>> ------------------
>> Partial-IO is a low power system state in which nearly everything is
>> turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1,
>> wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the
>> system on pin activity. Note that this does not resume the system as the
>> DDR is off as well. So this state can be considered a power-off state
>> with wakeup capabilities.
>>=20
>> A documentation can also be found in section 6.2.4 in the TRM:
>>   https://www.ti.com/lit/pdf/spruiv7
>>=20
>> Implementation Details
>> ----------------------
>> The complete Partial-IO feature requires three coordinated series, each
>> handling a different aspect of the implementation:
>>=20
>> 1. m_can driver series: Implements device-specific wakeup functionality
>>    for m_can devices, allowing them to be set as wakeup sources.
>>    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-wakeup-sourc=
e/v6.17?ref_type=3Dheads
>>    https://lore.kernel.org/r/20250812-topic-mcan-wakeup-source-v6-12-v8-=
0-6972a810d63b@baylibre.com
>>=20
>> 2. Devicetree series: Defines system states and wakeup sources in the
>>    devicetree for am62, am62a and am62p.
>>    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio=
/v6.17?ref_type=3Dheads
>>    https://lore.kernel.org/r/20250812-topic-am62-dt-partialio-v6-15-v2-0=
-25352364a0ac@baylibre.com
>>=20
>> 3. This series (TI-SCI firmware): Implements the firmware interface to
>>    enter Partial-IO mode when appropriate wakeup sources are enabled.
>
> If this is the order of dependencies, I guess the series has to wait
> till CAN driver changes are merged? did I get that right?

Yes, the series has to wait for the m_can series as it containts the
dt-binding required for this series to work.

>
> Also surprised that the DT series is second in the dependency.. usually
> dts changes occur the last. but anyways..

Yes, true, they could be switched as well. The driver changes of course
won't work as long as the DT series is not merged, but they could be
merged in parallel as well. Neither the DT series nor this series modify
any bindings. Only the mcan series does.

Best
Markus

--55e5f674b6f0c4498d17272902032cc52f7b00d4661fa093516501d66420
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaN5DqhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPM
7AD9FZ7TKtdj9gutIa9BZ1ZQBz0wJHycBDoOSqrFQAbQ8UwA/RMHayb7a4PbZ8iy
j6khLzQ18Wvas902AD5rQ9z70soC
=sMun
-----END PGP SIGNATURE-----

--55e5f674b6f0c4498d17272902032cc52f7b00d4661fa093516501d66420--

