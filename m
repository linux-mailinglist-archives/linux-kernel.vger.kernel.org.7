Return-Path: <linux-kernel+bounces-786446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD2B359F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B47AA834
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970429D28A;
	Tue, 26 Aug 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc50DpCn"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10618FDDB;
	Tue, 26 Aug 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203408; cv=none; b=jM0ClZXTk3M4v/tqAMYCmGWVRL6azZdRmqXRxAEhuWUG9sX0a/iCgot42ggsNk8AEvfmiYSZWMlfZEdEQn/EYPDGBWNXXq+zQYhi9MVTyuB01hKOAldcCg8aZehg+NKxFBiSLfaIGdminKBc6RvvjJh/c7L4JF064IFzlqqZJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203408; c=relaxed/simple;
	bh=67wkGaUGA9i0Nsl50Wohqz3RGqJEpwbjjFhjusahVUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/e4oY7LXYP5Ab0OpFu9YcSY1vQsaNDob/g3Ydhr9hv5XjTwGcHcshj5HnAk56Zqmvtz6ssPuCHFkfb9fziXG71qr9sl0DZENbxdermXmW3NPOQ4g27rglYzsNP6N9WqK3yXB0Pts6mTyOl4f07WCimmEMXmoNlsksw3AVlvBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc50DpCn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso1551666f8f.2;
        Tue, 26 Aug 2025 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756203405; x=1756808205; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67wkGaUGA9i0Nsl50Wohqz3RGqJEpwbjjFhjusahVUI=;
        b=kc50DpCnIn9EYZf9+Jjy8V52D0p6LmFakjEUWorrg2GEz/T4v3JhdK3n3Nib528xJm
         ZgYZ8G/CWcb1xChrcRQP9QNrwbCZjhMHBzpt81Q6Di7ICgkBePNqI2IfXLme4KJILXSi
         4b7sd6WxqKSpYzD+4iAboNHjGfjVksq7qLr7Ye5v0LlOIS93jm0ZZR5Uk8MZWx51ez78
         KHSgZ1FchFNFvVDsFG8WnuBV1O5zrAzwcy5Y7H8/7DJS3saeR8rBhz3OERJq+uHGt6xJ
         Za+0pyTBh8m4tTRuxvo5DkSFmlzSUk5yq9t6atrQdlvrm/wrk4pRSZIA8ju7TEd7W17F
         CHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756203405; x=1756808205;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67wkGaUGA9i0Nsl50Wohqz3RGqJEpwbjjFhjusahVUI=;
        b=u3g4jdQ7aUS4keojze1aWPAge/oMCOnPjYdBb3A2HeAOorp4lau/ctLb7zgTKe10wd
         ZRkN+9Y3QgIjisHEktUf4sUhdDZuhbZWrAoSosOlgeVFDpCev0qflzWB+6ej9HRuCkxu
         hQnEWc9ywLk1/fjVVcJk6Ech6oTiYmGxY5ZZSeBBjWCbC+teSYXaXiqpwO8q5TGf3GXZ
         ajkNtG9H94Fa61dRtJjXPuRQ4QPzcfm8C/D56p3ShEk3lZKwG/zW+TDrZj+HnlrdgJw2
         4klRKgA+WRt9EB2nGhU7zxwBAQSHk+Ii2TuvGIpxCveuidstKj14pY4n9XKyl6KXbQKK
         oOMw==
X-Forwarded-Encrypted: i=1; AJvYcCUcivTW/DVdvdueQyNhX1RnZnk7aeZ9s8RVM9UepnsW5ZSeoTvIChHhgVHDBQzJWFCzzd1jFXQYqn7u@vger.kernel.org, AJvYcCX1b7MkcjzwaZRuXu/EAA8Agq51Swws+7H+FTnuA8ukenHaZYxRl7R7UnktU74zzRjmWFRn4TysdbLmqeexQ9Q=@vger.kernel.org, AJvYcCXcHKJkRkKxsyQ6f0QH6mf8xZ/i8M7dJf2Wv9K2uWJPsMVKUPVNUHRwKWpTwKZuT9Oz959aDBFWyIakM3lM@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkMh6UC8upVknFuD/gPn/3th/dnVUmjuwGsVri/BWwq/uTpaO
	T5Q/60WLG/+92Q5KkX7gF+MK8f4yRQcVafSU4qCPez6Q5TVbXG92tVoZ
X-Gm-Gg: ASbGnct3r8qH5U296/qk6ZFuNqxWNX6UC/HvRiyPn4CSx9MwAqYRLuBmUpskzSv+J72
	mgieX6X+rQnUsaA8eyT9x4p9jYyMuG8HKKY6+aJ5/R6JoxgBcqamxNJa9SLr7tp3H+ejHw9KAAA
	8HuOxTKzF/APMmCGM8DPMMPKklPvM/kVSfeKImzdHhFQMLTow0nTFp7oVTPD+nUly6fU1QJ0jVz
	kI9yGSrecGP/ksEhFU9QpKhs9Dto6VZzQxs3aAnv3NBkdOeZBTV3sNprS96UCYnpVoslNjkmDoM
	8wK9AzpcKp07e5zJon5pS7hZUosKbHlabrz63hxVqXz0tun1ekTVd0p7cH3B2mBp9XVn91msVcg
	EHMeyMqdQQzpvnaDfhTcveacbHnyq
X-Google-Smtp-Source: AGHT+IFKhtfFgUfK0zXK1v9RwAURIlrulIjLOS45IVsQ6uBRK6y/p2JXvQQpQi55q6BMpfj/uCcofw==
X-Received: by 2002:a05:6000:178b:b0:3c8:e9d3:c38a with SMTP id ffacd0b85a97d-3c8e9d3d0bemr6530476f8f.5.1756203404785;
        Tue, 26 Aug 2025 03:16:44 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b66206a55sm12378505e9.3.2025.08.26.03.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 03:16:43 -0700 (PDT)
Message-ID: <5562694d-d21c-4c52-be39-41249456709d@gmail.com>
Date: Tue, 26 Aug 2025 11:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] USB: serial: remove extranenous ; after comment
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250826081712.1415484-1-colin.i.king@gmail.com>
 <aK2G8YSahB6CmKnc@hovoldconsulting.com>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <aK2G8YSahB6CmKnc@hovoldconsulting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uJvT90Fq63FqPh1KV0KB017N"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uJvT90Fq63FqPh1KV0KB017N
Content-Type: multipart/mixed; boundary="------------0O9Fc52BMQAzglarGnueVYx5";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <5562694d-d21c-4c52-be39-41249456709d@gmail.com>
Subject: Re: [PATCH][next] USB: serial: remove extranenous ; after comment
References: <20250826081712.1415484-1-colin.i.king@gmail.com>
 <aK2G8YSahB6CmKnc@hovoldconsulting.com>
In-Reply-To: <aK2G8YSahB6CmKnc@hovoldconsulting.com>

--------------0O9Fc52BMQAzglarGnueVYx5
Content-Type: multipart/mixed; boundary="------------kK4wpc2bFCCWiUFHN7Wsx5Og"

--------------kK4wpc2bFCCWiUFHN7Wsx5Og
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYvMDgvMjAyNSAxMTowNSwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiBPbiBUdWUsIEF1
ZyAyNiwgMjAyNSBhdCAwOToxNzoxMkFNICswMTAwLCBDb2xpbiBJYW4gS2luZyB3cm90ZToN
Cj4+IFRoZXJlIGlzIGEgcmVkdW5kYW50IHNlbWljb2xvbiBhZnRlciBhIGNvbW1lbnQsIHJl
bW92ZSBpdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4u
aS5raW5nQGdtYWlsLmNvbT4NCg0KTXkgYmFkLCB3aWxsIGRvIG5leHQgdGltZS4gQXBvbG9n
aWVzLg0KDQo+IA0KPiBOZXh0IHRpbWUsIHBsZWFzZSBpbmNsdWRlIHRoZSBkcml2ZXIgbmFt
ZSBpbiB0aGUgY29tbWl0IHN1bW1hcnkgcHJlZml4DQo+IChpLmUuICJVU0I6IHNlcmlhbDog
b3RpNjg1ODogLi4uIikuDQo+IA0KPiBJIGZpeGVkIGl0IHVwIHdoZW4gYXBwbHlpbmcuDQo+
IA0KPiBKb2hhbg0KDQo=
--------------kK4wpc2bFCCWiUFHN7Wsx5Og
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------kK4wpc2bFCCWiUFHN7Wsx5Og--

--------------0O9Fc52BMQAzglarGnueVYx5--

--------------uJvT90Fq63FqPh1KV0KB017N
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmitiWAFAwAAAAAACgkQaMKH38aoAiZ6
BBAAjFQgytN+93ZP2yW1j6q0wcpRha7VJWjl3Upyxk01imgZW92AzZ4n3mGsFluN+crgRThFJgII
lA16DUym8nHU3iJFzacT2UXjf/snNgD7d+DZH7+mI3YCdKAn621MGizkvIXRdo8vikody04spkuV
GG5a+2ebzFI1ZtkYhv1v0/1YPJmPdCDjWaKQIz6V8Oe++Y+6ocV3X6HEUonbnCEE3Aq38lYc5UYU
tP4q0dnNz9RY1GKTU1MJBP1jilRaqFGy7isx+Z/jf91OUGYpuVIVCIyAEfUA2Cl/8raGMVcBcnlI
s5L3jvDG+mNRLUzTGXJn9csHgjA7rWbi2bdIIdID1tO5H1usT9zTAuJdDdGbQg04Rqa36QLS/vD2
O3Xyu2n57G4a4cbwA6LROjvChgF27/GQ3Vu7yEh7Z9yMNys+pW0lcd6hNjMeA/KNjoOgvmqLwp5Y
cw6clzi4Cv/eiFP7sNkn7NVfvsIaBVS85Hx2f0aQx/krT7E6hE3ZXLbt67ZDKKsh/6Sb95xrnOLV
SAnmSHr0O1TavbdAEmuwPY2dhNPblcqLgoQ9Ggv/CE2AePyaXVVaawuqKHsk7aN6CHLjQawG62ul
Hv3HZbJAwcn48bNdU9ovTFUnpk2kkm0Oq1G/0c8hF1Dao8mLRMT1l8/G4VkB6J93V/cY5nJuWjfn
8j8=
=grpl
-----END PGP SIGNATURE-----

--------------uJvT90Fq63FqPh1KV0KB017N--

