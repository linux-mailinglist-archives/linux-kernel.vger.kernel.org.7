Return-Path: <linux-kernel+bounces-854201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A1BDDCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEDE3BAC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A14031A81D;
	Wed, 15 Oct 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWinAf7p"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A299307AC8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521083; cv=none; b=guj8TU1Uc6yO3+Ou9yJj5yBm13xhEUqAkIaIfTHCi9pD9fB0NTWwBIq52kq2fTLqBJC/p2xCy4l4V04wa7xZjqyUmv/NBPCaps2QyAwOlCmOxgLuoTmxizSzOzEaO6ZITUVDv29sRHSAOMhL4oJugDMuEXFXP8WN9Ug3THH+isc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521083; c=relaxed/simple;
	bh=v7thoVpEHD/7/YoB/5RU23qHpgvRPS/Ny73RcOcGpLY=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=djYHTLXXD4UZrzvrR0Sq4+C1rfRT24gS0sLYCtWQC2ofG9jD9d4dgz1F9j3Qpr1pMfEe1fQIyJVVx2ifAw9rFkiyI0NmGIEXXWpKF/K+ocre3lhBrBTJI0UUPvm8A9ZNswQ2pPxWZZcd9b3x2l2mZKemrIRFBQbaZyPo7fjW5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWinAf7p; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso4685582f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760521080; x=1761125880; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JvzsfQTSDtQaC7t5oa6u6D3sSXuBAsirytWy/69/Cyg=;
        b=OWinAf7pSngzluRUD/Og2TO6yux8FeQzIx09i8xSF5eWf7610Ms8qrV7crlPWwM6PL
         75R5PyDddZbdJLnMEHSD1++H3Is81zzFBsQMvaIDfMQiUxSumJrbRqODBgchXREIUlHI
         /zv9Jc72+1KGWKZlhLWS8PwNP9LV6nGX5baSzyLWLtnhn3OAyqiXd+7ppacueEzD8PUV
         8fhxuFsRUejFd5wvG7EOqR457PzVBwjKaNp952LrvwTJTMVzYfN7j6psuRPCkOhmiY5f
         xYXeD6EpuutU1sxylMP2wZYdnHBkZ8ondRHKJadgUWAUKY9LPNYUk4eO9sg5p6B6AB9o
         beqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521080; x=1761125880;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvzsfQTSDtQaC7t5oa6u6D3sSXuBAsirytWy/69/Cyg=;
        b=XJgvlxU7teDNO87fc474RJwONiermbZ8r14NR7rYgZi3od8/wQClbqAIRPVvpERlWD
         9GO0Y5oiH1HINBG+mYdM6udHc9prVA77hapoKoCE3nX8u6Y00oLFU6h8kdj5GEKccq1P
         v1SSud4ToZrhXMoY3drS4VHYq3bVZMUMY46BEUNBab6HTvymqvrEVkcjt37z1bruGv42
         qfImSCaI3KYqhYWoo3C1Ek+u2MhONvmjwwkAI6rj0D2ChPpXY93CrnUAJfmFxeXPWQH+
         2KgbwuSqrduytE9temVkbxsI3L69m3PAcwFQghcxJrRegAMT8IkODJO3hjrW3qs9LCP7
         KPTw==
X-Gm-Message-State: AOJu0Yyr4VWYP3X1+By9NCSYLhwe7mrNd7X5MJEcnxUitxDjTX8rlPhr
	8INkhsSsr479eIwAf3o02NmoxuLCGODPGY0mbGs3UFmVnKTTim6egZAVP74PWkEhZxs=
X-Gm-Gg: ASbGncug+BE20VH5mgmUwPKEmFsG/cfSBEkBlB0LkJkz0PiRSjZmJivDPwdBE1CIWf+
	vkt/kf0FWv22RuqUEZN+pLnKRqC80FZ+e11pUbeibZKwzNzjIaYd3xiuyEyCMcds5870aZ/zeS7
	oTRBNCUFbYqZQZorbiVwrYnDBCVqxbkDD5CBWETvligqqF8KMdcijbYG6a4wc+FPVksSOTAAh4n
	bKxIniepd+86jrmBebW/VmeqIsney0H85adJV7Qe2UdJUJh5DEXGdybiiPuxIxYDhuCZdjVbx+7
	fknoYxixlA8rXD5ngUsoAA82Ik1jM9lU+YMSrXKnWL9/nEc5r8sBca3PjzB/m1mDBmLvExqCHDN
	M1DQpR6rtAd05s4EDPsAKAH3xAS6PEZqMbdlcKBZxEXCYgXDNqHKjF3ODCOlJGTaqSCO/KlIOsk
	Lu9g==
X-Google-Smtp-Source: AGHT+IFDiJRvObvolQL86xK8Ky80uc00BGpXp/bh1HjV2QFKrNTGVpwo2+WV6HccWddpKwYdOdepNQ==
X-Received: by 2002:a05:6000:461b:b0:426:f40a:7179 with SMTP id ffacd0b85a97d-426f40a729dmr3260449f8f.26.1760521080060;
        Wed, 15 Oct 2025 02:38:00 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426dac8691fsm19569623f8f.50.2025.10.15.02.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:37:58 -0700 (PDT)
Message-ID: <68ef6b76.5d0a0220.39b228.4064@mx.google.com>
X-Google-Original-Message-ID: <87347kcxou.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,  maddy@linux.ibm.com,  mpe@ellerman.id.au,
  npiggin@gmail.com,  christophe.leroy@csgroup.eu
Subject: Re: [PATCH] powerpc: kgdb: Remove OUTBUFMAX constant
In-Reply-To: <68da3e7e.050a0220.8efdc.f1ab@mx.google.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Mon, 29 Sep 2025
 10:08:29 +0200")
References: <20250915141808.146695-1-mikisabate@gmail.com>
	<68da3e7e.050a0220.8efdc.f1ab@mx.google.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Wed, 15 Oct 2025 11:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Miquel Sabat=C3=A9 Sol=C3=A0 @ 2025-09-29 10:08 +02:

> Miquel Sabat=C3=A9 Sol=C3=A0 @ 2025-09-15 16:18 +02:
>
>> This constant was introduced in commit 17ce452f7ea3 ("kgdb, powerpc:
>> arch specific powerpc kgdb support"), but it is no longer used anywhere
>> in the source tree.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> ---
>>  arch/powerpc/include/asm/kgdb.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/kgdb.h b/arch/powerpc/include/asm/=
kgdb.h
>> index 715c18b75334..4c0afde87e97 100644
>> --- a/arch/powerpc/include/asm/kgdb.h
>> +++ b/arch/powerpc/include/asm/kgdb.h
>> @@ -25,7 +25,6 @@
>>
>>  #define BREAK_INSTR_SIZE	4
>>  #define BUFMAX			((NUMREGBYTES * 2) + 512)
>> -#define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
>>
>>  #define BREAK_INSTR		0x7d821008	/* twge r2, r2 */
>
> Gently ping :)

Ping again :)

Does anyone have some time to review this patch?

Thanks!
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJlBAEBCgBPFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjva3EbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyFRxtaWtpc2FiYXRlQGdtYWlsLmNvbQAKCRCWvoxv
2J1lZRmOD/4jxbp88nyoKaaxZMI6jdfSN11ofX87AZ1bdwZE6H8xOvz9bSRo+qAn
p50yfjHziWTH+YvrOpLASuhBrsFL0xUPU5ehBiau7tacspdE3q77sp3MjnYVpzNT
nHdg7L6vmxByORA+t6UzDAu8pC0ssfwhTCw7O4Hnu+oLGzEr3n3oRWzgYoJSquOQ
c7DvR78hNvqrH5dViaImr4/tsX3tP8PKQx1y67e2uxhPGZWi0hz465AgYpLHrLyb
lYy1WAZP8FD8tSgz19DXfnQjZDeXy0737PFNaEOocPtLdKuOmvYOAgEFBwKCeGNx
1bYwwOjqcpW+EjgzV9Hho7kIj9S9Tg8IJJB85WUENsOcoB09CpXWotUE1VoSL9gX
2RLR59z3dwha5hAEKn4f8ZEmv6vDqZJzwj7WQYKz/YjhVeviNwNAd34sYpKfs3n2
EIp5BsVjo3K58zQu2Il8EF/5Swb7HyBAPu+kZlFHINIhaKkVIlFba8WVZXkhR71V
/BmOstaniK09rulEOUSUPqzB2oi5gXDaQm0F/D1M9gVAX0J9/QkM0kGyBFi0gDD3
Yp18dXsPmRrUoIDGGyoBZKcdY0cSVLyqnBCWdZCNPj7qwE8Th7hYkVVR2WSAEYli
cNsn/5OLRubHJVTNLo9VCEUhzYJBeDPRlIYrJvi1Lhg+i4onWWQQgg==
=XSBL
-----END PGP SIGNATURE-----
--=-=-=--

