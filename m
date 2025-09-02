Return-Path: <linux-kernel+bounces-797095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89EB40BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7737C3AFFE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1E32ED2D;
	Tue,  2 Sep 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO++hThI"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054B2DF125
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833128; cv=none; b=UQWQ+j9aDrdk4A4iMTuwk4G3xO5Oemy1s2UgmGHlc9+k2b4SoDgXCbRwS8Tealbj7b8aPpidWinlsZJzJfme162BgyvWaorPMY10eIKjD8uv4MjL6eYlqlvhagH0aPSombxkqnwhTBVBek6zWF75vfy+0G1XZsFflvv6OGPIJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833128; c=relaxed/simple;
	bh=kLulON52Om8Z4pxIZY5CU/uTaHP2ba0qiEFKMMgQMjs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=p5r7ItNSVmXldC8DyGeVNM2U+YWekqnYf5j8x5Z2m2zLCkX+1XnLDZbG86+v/rhgtdFHeOSv1NB2o7kApnuQpQei5ptli1lf+bGxiR/d5gUiGFFPe5KBsjNqJ5H8ki4zKuvuYQY9l1Q8uu+o7XL0wpDKGyBG2WctzEo0RlQy/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO++hThI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7fac8fdea9fso515023185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833125; x=1757437925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KlKi1IhPbIREB5l7Jtf5VR1Ks6tYfzbySz3T1LU0wCM=;
        b=HO++hThITb3UH2fCL71Pu2JP7zrwAhCdmh89+HCNAmihfmZHKpoYVFGrcU2d7erk6c
         4baWaOSjQmG90Cp8ab+QUTnDK213qUkMXRCdZIHqVyvaft2tgVV+6/1yadQHK5h+9ZTJ
         0k7uwp1I3ZYEQBRzPLH2gUSyxfNwCTlcB8YjGMzouU1e0KnzwXYiS+ykSqprJV0ORLs0
         00kwGVlo2ybn4cEYcgkmjFNFztd4YeulZkSl6M9SyAHyS6OFiBbr/K8wx/UekpMfFxJd
         soBsfiofNKioltj9Ljg2lxt2UqsyQ/rbGKV7FDhYNiPsx8pVk2pMJ4Nu6ivMGSbO1NXK
         WmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833125; x=1757437925;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlKi1IhPbIREB5l7Jtf5VR1Ks6tYfzbySz3T1LU0wCM=;
        b=S3ExosIGSgyIT5hl2tk3NAOy83ekxK+p+4QuxMCFEWO+p24skYa6W4OtQQakJwQY6m
         qgYE4Klzpxer5vPdmarXAUIZw8oqAvy6HHaocaU5Wenu21OtSsbx34kQrH27zSCILcas
         EiAC5l1UbjWEID9dO+R6B/rEg6q7RhT+6aHUHlHeb1mrrSdD5q/FhRdnUwmnbnf9hWGX
         bnYVAJ4RAd+z7bXjJaOXdjwi9ABxgBTIrivR4FTl16q3pPdsTBH+i5jR/fZOCHTYn3lP
         RZtFkOuTrDWUQDVM4i9A796+/mTL5SybdQjDpfaE4J8/9j08m+Om1e1qosCwhy//VwVf
         tBXg==
X-Forwarded-Encrypted: i=1; AJvYcCVglIsgOd+dN6meZuI9xnUGXILvjujJywMFM8YknX1VvsuA3TSbGSG91rGE2Z54bSwxBRym/HDh8vCqxPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMN0/t5rOBkWFJ1ij3fkfZHGvozgGZDKnTY9w+rKF/BWFLEy3p
	1h3lJVylap0+sqimtXiJ0dhXQutSDV1VLW9z49bfASBJ8VrIE86KFpy0RdabzBy8
X-Gm-Gg: ASbGncudonGwI4vcNO70cUZSEvYuYNJvVGE4Xn5JALZMHdjc9i8VFSzdfRLUzrQLuXO
	xwa/57V/0c2YODON9MscCzuzZJ6FYHPmVAv2+cyBZU2x1fYfKL5qc/ODnKen+ex+Q7g+zBKiFO2
	7vkJSjbIvkB3y2rN6VcIzSZUsiDnVUX4PrphM5biMfkq9ebsPi7MxhikEllk7eI1Bw/ispAhaFX
	Is1hUCkLhkEbUcyWky2jaXn2yKh1LnYGtzfuuSKAwq6g+y6rod858EEATYThvvhG6h6Vlgesgk0
	upP8L6ppZGi23o82iCH2AWcTiB/rOejA+RaNsOP2Y3umB2N//7MhmCtxyobcTtGMXgQGB+gjdAb
	X62QnIpK+zC8eAqmC7mwcgS6J1JToPDRAuQ5D8VeuaoSdCRBaXxs9pu6hCPMXL1TzGt/kkHtWU5
	Kn+Bk9IK4qdBm12XvZ
X-Google-Smtp-Source: AGHT+IGK9pnmJgZZVbnYhzD6px9+M8pC8AT2KOK1+mA3Nlw4acAgZS6CxphBrR5H2vApZUyS5piFjg==
X-Received: by 2002:a05:620a:4151:b0:807:b04:e8fe with SMTP id af79cd13be357-8070b04ff2dmr345506185a.65.1756833125190;
        Tue, 02 Sep 2025 10:12:05 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069c1536bcsm167184185a.45.2025.09.02.10.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:12:04 -0700 (PDT)
Date: Tue, 02 Sep 2025 13:12:00 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/5=5D_auxdisplay=3A_linedisp=3A_displa?=
 =?US-ASCII?Q?y_static_message_when_length_=3C=3D_display_size?=
User-Agent: Thunderbird for Android
In-Reply-To: <aLbA1Ma9Cig3gbWV@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com> <20250901020033.60196-3-jefflessard3@gmail.com> <aLbA1Ma9Cig3gbWV@smile.fi.intel.com>
Message-ID: <8821938C-2C77-49CA-B2F5-E2A7F0B95449@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 2 septembre 2025 06 h 03 min 00 s HAE, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> a =C3=A9crit=C2=A0:
>On Sun, Aug 31, 2025 at 10:00:26PM -0400, Jean-Fran=C3=A7ois Lessard wrot=
e:
>> Currently, when a message shorter than the display size is written, the
>> content wraps around (e=2Eg=2E, "123" on a 4-digit display shows "1231"=
)
>> without scrolling, which is confusing and unintuitive=2E
>>=20
>> Change behavior to display short messages statically with space padding
>> (e=2Eg=2E "123 ") while only scrolling messages longer than the display=
 width=2E
>> This provides more natural behavior that aligns with user expectations
>> and current linedisp_display() kernel-doc=2E
>>=20
>> The scroll logic is also consolidated into a helper function for clarit=
y=2E
>>=20
>> No API changes are introduced=2E
>
>=2E=2E=2E
>
>>  /**
>>   * linedisp_scroll() - scroll the display by a character
>>   * @t: really a pointer to the private data structure
>
>>  	linedisp->scroll_pos %=3D linedisp->message_len;
>> =20
>>  	/* rearm the timer */
>> -	if (linedisp->message_len > num_chars && linedisp->scroll_rate)
>> +	if (should_scroll(linedisp))
>>  		mod_timer(&linedisp->timer, jiffies + linedisp->scroll_rate);
>>  }
>> =20
>
>=2E=2E=2E
>
>>  	linedisp->message_len =3D count;
>>  	linedisp->scroll_pos =3D 0;
>> =20
>> -	/* update the display */
>> -	linedisp_scroll(&linedisp->timer);
>> +	if (should_scroll(linedisp)) {
>> +		/* display scrolling message */
>> +		linedisp_scroll(&linedisp->timer);
>> +	} else {
>> +		/* display static message */
>> +		memset(linedisp->buf, ' ', linedisp->num_chars);
>> +		memcpy(linedisp->buf, linedisp->message,
>> +		       umin(linedisp->num_chars, linedisp->message_len));
>> +		linedisp->ops->update(linedisp);
>> +	}
>
>Hmm=2E=2E=2E But it seems the linedisp_scroll already has a check, why do=
 we need
>an additional one here? Perhaps we need to pad a message somewhere else a=
nd
>guarantee it won't ever be less than num_chars?
>

Semantically, linedisp_scroll should scroll=2E I think it's better to have=
 two
distinct paths with their specific logic:
1=2E Scroll: circular display and rearm the timer
2=2E Static: padding and direct update

But you're absolutely right=2E Given the explicit should_scroll() conditio=
nal
outside, the check inside linedisp_scroll() is now redundant=2E I'll remov=
e it
after testing to streamline the code paths and eliminate the duplication=
=2E



