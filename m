Return-Path: <linux-kernel+bounces-879708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05135C23CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6178D4F237E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E372E8B77;
	Fri, 31 Oct 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S5F9870o"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B62E0910
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899189; cv=none; b=YSoQugfe+gPkTPRN8ZQ8TFYS9oHr87b+1rfICHWMGEY1WhxiqLnEbMziE6B52sibNw/RTP6Fi1A+JrTr+wXpXF83EXJD29U4pqAKBjHPoGe1SRBMw6wcUBpRo7s+R2TL+cx+VwdPRrqqGlj7TU6813BYy9Pr0xW081GeP72LBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899189; c=relaxed/simple;
	bh=+NjzGhAHtDRHeBvaazZ1DsJgwXBMCElbWAslegY+rbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0M7bZXuMCKTq4kdHh+SFmaLhEBoRiozdbWs1lGaRe8xCPn0nIjGZaUl53AsGjFdWJVgnYHMCP5hLDBp6QpC0ZqyfBKf/S5bFbvobvn/ktRIiRd44bJg3CG+tvperNAEln4ljMLlcTiWn3AMHJntOrKZY3lx+rWzygW4HjPXKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S5F9870o; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so453954a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761899185; x=1762503985; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NjzGhAHtDRHeBvaazZ1DsJgwXBMCElbWAslegY+rbw=;
        b=S5F9870o/u95LK2ubbNut2oR9k8IonRi++hnQY39Br771wckxyDGyOB8I7EnR4tpcc
         qtVHp/ER8Q851Wa6Z/hzPpSz++djICEhaeJgY77gc7j+WjK+iB/VPxkpVgV0i43IKeTa
         f3CCURoxC+t4eVQCd6OGel7Gt2Q3R683vAo99ByUJr7X7DQ/cJQRYMacRxuIWusa6kRA
         LL5+SmcY5/h8PnbGJEHI/ZUNLDzUudzuTmZViGxjR4J0+s/0N4PGVrubAiBhOsvLHct2
         QbOjZItInFwCl2YqTixMwKm+bxi7CmoGXfy/kTc/42Jd2LwYW784fsDC1uSbkEBX+4Ue
         EHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899185; x=1762503985;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+NjzGhAHtDRHeBvaazZ1DsJgwXBMCElbWAslegY+rbw=;
        b=EHR7OI4asyIV81fnTJHzOHeza/HCBBXDDUwvLRid9BZLZfNPY4hn62reRrHBJO1JT3
         xrImg07gDzncu+Svr0f8wrnRWEjhPIunZgKy6wVP5MkuyhAqcbcrHgS5BB16T9SFBMOW
         IiEITP+dQQCUS7Vab8WjwY56RKkxD4SUiVs5Ifw3FlGy0ETsEiJcK1FzCqGcs1fzUp2J
         0+KYu/szCO42+Rsx40H9ffQKLctQcepHXz5J6eg+0NsLTQq+lTd1sbCVhSBF06w6rsha
         BvKc3DmgZ12amNS2udei+5u1m1f9SOOvs2f9MkZ4W72RnIPOtBqMnWLGgMKnsk7S1OmV
         lXEA==
X-Forwarded-Encrypted: i=1; AJvYcCUflw5E53hymtHMgEOx2/1cBGiwwG4EGnd98zGqUobZX/mbH4k5MKqKH0kHrcbx0MpRYo1IDGhD2A/0F2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MkvPSrQ7UZhFiTePHX+2Vj24T8QvqMAHDB+IbwzhOnZ1/kZo
	L6M5XLQ+7sLjezum7s8ZfdH0V2I2tLHSJ3/44prSDiNyl5kUYzMsX582JpBXIgsUKSE=
X-Gm-Gg: ASbGncvrT/9xW/6iM6LuEjuqjjQw0PEI+FHvdWm8ALzN35nraHjTEExSg/CJvbH4+xM
	oLSplXvI482wimgHswuF0adh6nNyTfmEg0NWoaer+sm0hP//cjNpMy2fduyXuDyn76/LLpYd1UI
	pp7eyn//F2YISkpSUzJ1G++9j7StPaZSjlt/LluWzQZT05uZG02PAUC6gULpxTA+ii3J1BMIW7h
	BcL025Ah6ak/NogJDAl9ITR8ZN6XJdYHg37TNMcGFG89j5GGNTf6ZyT5w2wa+ZNTOsli4hGJDre
	0evKo3HO2IxpubWbNhFj7scGip13AQzlVB1cvRmFIo+kmFXyHq2uUGimgxu+PXZYcMIp8az2eA3
	kJg1m7EhTiPctaw3kb5Q+dudEvl/LDEPiDnziIa6h8g1mKVWFMOR7LCVRL0LBjsajf4tNxoIFr0
	KluP7X+rhqWO+8AbxIcJ5rspqb8OxFNpsRVj+YeVs=
X-Google-Smtp-Source: AGHT+IE52yNlp2sTU4kqtK3kDMs1xq1Zmn7Phf6YHDr/FwfwMUQX92Kodls2Uqk1gGyKB1dLqXrrxQ==
X-Received: by 2002:a05:6402:13c1:b0:63b:d7f0:d93a with SMTP id 4fb4d7f45d1cf-64076f66ae8mr2138586a12.3.1761899185309;
        Fri, 31 Oct 2025 01:26:25 -0700 (PDT)
Received: from [10.203.83.168] (mob-176-247-67-93.net.vodafone.it. [176.247.67.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b390d71sm1084831a12.12.2025.10.31.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:26:24 -0700 (PDT)
Message-ID: <3e7944588d3011b6a144d70ab9027a05a1e230d0.camel@baylibre.com>
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 31 Oct 2025 09:26:19 +0100
In-Reply-To: <aQOVcCinTd-ZJJX3@lore-desk>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-2-flavra@baylibre.com> <aQOVcCinTd-ZJJX3@lore-desk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-toCKgrfB8dV8kmHVa9aE"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-toCKgrfB8dV8kmHVa9aE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

W21pc3NlZCB0aGlzIG9uZV0KCk9uIFRodSwgMjAyNS0xMC0zMCBhdCAxNzo0MiArMDEwMCwgTG9y
ZW56byBCaWFuY29uaSB3cm90ZToKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoGNoYW4tPmV4dF9pbmZv
ID0gc3RfbHNtNmRzeF9leHRfaW5mbzsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChpZCA9PSBTVF9M
U002RFNYX0lEX0FDQykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICho
dy0+c2V0dGluZ3MtPmV2ZW50X3NldHRpbmdzLndha2V1cF9yZWcuYWRkcikgewo+IAo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoaWQgPT0gU1RfTFNNNkRTWF9JRF9BQ0MgJiYKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGh3LT5zZXR0aW5ncy0+ZXZlbnRfc2V0dGluZ3Mud2FrZXVwX3JlZy5hZGRyKSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuLi4KPiDCoMKgwqDCoMKgwqDCoMKgfQoKSW4gcGF0
Y2ggNC85LCB0aGUgaW5uZXIgY29uZGl0aW9uYWwgd2lsbCBiZSByZXBsYWNlZCBieSBtb3JlIGdl
bmVyaWMgY29kZSwKc28gd2Ugd291bGQgcmV2ZXJ0IHRvIGlmIChpZCA9PSBTVF9MU002RFNYX0lE
X0FDQykgWy4uLl0KCg==


--=-toCKgrfB8dV8kmHVa9aE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkEcqsACgkQ7fE7c86U
Nl+8Dwv9Gr5kkOemEE0BT3tMcA0r4Fj9oWgSRTOcD/knPbaMHHuaQtz76lE99xXF
gVguBJx+Aq0dtrqVtS1Rg7JzyeYFXnaDtRDW8lNPGYiokGitcpyhlKXQlhMpIcrb
u2hCkP2X+QUhfgrmw14mTd4hVfiRKPh5NxxLRf6Y2tLh4s9tfCbvoDHk6eFHooPq
+nXbKByStxvBt4Z41imsXJFyIr158XyOBa7xEuLUj5XZGad6yKccZ2xWrZHcN2Af
+7Oj4dZ3CRnrbmUbV4w6h1/xzeJzPaeOFJGQ2qYntv/cKBdNTymTq1JZ6aLyl21d
pJ/EVzhfIYSOppRmNKYzXL5e8y06Gsgb5XtW5ZidCDVS2SVvlVDpSuFwsvKrGJPi
+ZBZ+6MKaYGiTdag4V9IMCDaEJNUyODn9Hl/lh/sdqXAWJtrmH91PTuP8GhFQQ8j
I6m4vW999UbZrEfpqFjKWDl9RchWDDe/Vf+bscKUGV2/RhhpOKf9koRtz+UMrfyY
FZBm/4C4
=VQFO
-----END PGP SIGNATURE-----

--=-toCKgrfB8dV8kmHVa9aE--

