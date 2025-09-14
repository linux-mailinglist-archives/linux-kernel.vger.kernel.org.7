Return-Path: <linux-kernel+bounces-815734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9931EB56A75
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570F13B7753
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21AF2DC355;
	Sun, 14 Sep 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnfRgQvG"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A691F462D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757866625; cv=none; b=hGeLGYjNi71Z9vIAKtdco10bKJyuh5eWbvI0DjWXNDXsaYCQFe8JLPZHTtk6VKixFoNrnHtmLFKkzxE3xXpV5Zn020KyEWerg9h1wupZIgTvuVlmZOhhOjIk/FGHg4PsuvuwKK1tKM9576t4uCI8xi02QhdnzpUAee/ss2SXtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757866625; c=relaxed/simple;
	bh=jWbdC2pvgh9ssiqZWTBrNl6uNVTE68yxw5S35v3pW8Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oX0q2k1Tl+eMgMBeijLNSOv1trjVeCgB7l+O0FrsjrlX5M8mpxwAOEJ2iI+JFimuwGIjJXqb5AUKOXTDmOiQNOZnPuKRYanzXn3H7hyXVmaAAILrxeTY2r6wWUGrzcKjJxMg2swFDHQNMhRuEqjmi20xG9Gv7H/gCh98JMbOq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnfRgQvG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77251d7cca6so3206545b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757866623; x=1758471423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHfQfaNhE376CkNmiYZYTQUu0TvMLQbCRNkJjZT7v68=;
        b=OnfRgQvG8sxsY/NS5VsLqjSXJrNDneKrv6LaKt8qqJweaBbHbkicSxg0Kfhxou+Opk
         rGnOaqMJeDPUkPobL09OwGme4JhFecn8brVi9VptbuuFUhV4Vyuhib3FQY41pjO1Nf/V
         CCw07EEHswVBxyxJZ4gVgirDss1QINF+ODkf+Le+KMRuXfnV2sL6zH7c3v8Ld+SD/LjP
         LkwiwhYjVKYQEE+aj3gQT9mQVEkgcFSNI1ivR+aob7/gxxyM+rdqht75HkCneSzQExqp
         dkgiZZ5zTkt/3ZyfEpp/U9K5bvK3n7ey7z3bb8hBShH3ChWwwNcN1xabLLyTL30Hw8I7
         hqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757866623; x=1758471423;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHfQfaNhE376CkNmiYZYTQUu0TvMLQbCRNkJjZT7v68=;
        b=U658bM3GV0IU/bulvu0GtSBKzl68Z7vJpF4oHoAD7oYZd+2qH1dlLiJ8MghQD3IN5U
         uv86BYzsyf1zCvUUS0RyrcOka39uMftBCCu0C4KBAJloJ3SIlwTvxnLzuJM7xPvNJWlQ
         dAj7vtRJDJ4avYCWL9JvSP3TImLKhIl70J27SjcTG+u/BxKRuJV6Tp4sDgXrimMtz5Nu
         rFVDKaxQ4QbfVJqJWnKpaXjboNe82wvG9SxMnlHTb183ainuVIbDcUzIhcLdTnIg/tJI
         3qxrBXdtQekAU+vWBa8yhxVpbCqO1RYbomHvaHC5fa0lK+nGdrz6GmSZxNquNgbZT8ZX
         zKMg==
X-Forwarded-Encrypted: i=1; AJvYcCVqnKHPjh3FD9t1m88ON6HV3gL6r/mZ+7ygv8XOaYIp5htwkVpwFwH99mBCqEPkoSnMepjp+GKmu96cwsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsURhHbUgYHozS7mzWzZ1NbS0JgUNpzTJYXOkD1A3xlAQyWCh3
	98XS6RYiMFdR2iF8/Jb1RdtkKirkzunA2vBYCmtCVw3nuTKOaBIlgWLV
X-Gm-Gg: ASbGncs1zyAg6+0ut4XRqBfxuIpt/HzbmDZUib0gofxxkXF+lzh0t7MoJlSDDHyMHEx
	bmRW6YJdeVOBuuzM4zCMb5UVVHLlXooczHhTIDRpL8beNCuOdLTpTDBhZQUYw1LuqCVnDI7L+CH
	RNOo8chOjr8qNWxvyKdHpEUZb1z/X1S3IYgZwnUT4a9LFETAr5CwPog4Olmj4ZShlWvJs2DfSwT
	w35ewvErjk/KKWDbiuw81Svdsg62D33PpPFjfhVkOv5eGBWe//fhv+VWjxvzwp0DnbB0BHphtmh
	4kYA4RSobBecJ22US9yP/QrHItTlawrGIcI0wz7UglSBvRgcz8LYsVJ5zeazasXMHSBP7NK2czZ
	vBjt/ajtKXrcgT4B6qpl5E5iXmsoThxiPplep2P75RPw=
X-Google-Smtp-Source: AGHT+IFBdVQ5WdHk8mTH1q+OPlFBftcvNPg40I/u2Qs2j0u22IjgQh7Xfs6CdY7txX411Mjc7ZKVbA==
X-Received: by 2002:a05:6a00:809:b0:772:6235:7038 with SMTP id d2e1a72fcca58-7761208c93amr9813558b3a.10.1757866623058;
        Sun, 14 Sep 2025 09:17:03 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:7f0:9240:8534:6a:af3e:787a:d2c8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a48c19sm10912022b3a.36.2025.09.14.09.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 09:17:02 -0700 (PDT)
Date: Sun, 14 Sep 2025 13:16:54 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_1/2=5D_dt-bindings=3A_input=3A_add_ST?=
 =?US-ASCII?Q?-Microelectronics_FTS2BA61Y_touchscreen_binding?=
User-Agent: Thunderbird for Android
In-Reply-To: <716da762-3aa8-4c39-b9fe-8e923b20a0d5@kernel.org>
References: <20250911211910.45903-1-ghatto404@gmail.com> <20250911211910.45903-2-ghatto404@gmail.com> <716da762-3aa8-4c39-b9fe-8e923b20a0d5@kernel.org>
Message-ID: <CF4D01CD-5C96-44A1-B7E0-BF3D77EFE5F5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 14, 2025 11:48:49 AM GMT-03:00, Krzysztof Kozlowski <krzk@ker=
nel=2Eorg> wrote:
>On 11/09/2025 23:19, Eric Gon=C3=A7alves wrote:
>> Add the bindings for ST-Microelectronics FTS2BA61Y capacitive touchscre=
en=2E
>
>Please wrap commit message according to Linux coding style / submission
>process (neither too early nor over the limit):
>https://elixir=2Ebootlin=2Ecom/linux/v6=2E4-rc1/source/Documentation/proc=
ess/submitting-patches=2Erst#L597
The commit description is 74 characters
long, and the name is 73?
>
>A nit, subject: drop second/last, redundant "bindings"=2E The
>"dt-bindings" prefix is already stating that these are bindings=2E
>See also:
>https://elixir=2Ebootlin=2Ecom/linux/v6=2E17-rc3/source/Documentation/dev=
icetree/bindings/submitting-patches=2Erst#L18
Thanks, will do!
>>=20
>> Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>
>
>
>> +
>> +properties:
>> +  compatible:
>> +    const: st,fts2ba61y
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  avdd-supply: true
>> +  vdd-supply: true
>> +
>> +unevaluatedProperties: false
>
>This goes after required: field=2E
>
>Other than that - why isn't this finished (non RFC)? Code looks ok, but
>I also did not look that thorough=2E
>
>Best regards,
>Krzysztof

