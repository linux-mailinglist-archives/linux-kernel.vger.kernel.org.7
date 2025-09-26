Return-Path: <linux-kernel+bounces-834164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2CBA4158
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9017368D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCE1BD9D3;
	Fri, 26 Sep 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoY0a4ar"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A661187554
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896279; cv=none; b=HWKLhDPiEe0bLAoILIgxZVxkqmF3vx79UiDMzLUqwb+3gNxF1XEFgR4A6wMMPW3xgWbFRVOcpBLqBHXn0mNWC//ksszWD/DMOyjCV1Ht3Zd6dlNybM53PeF5SNhLoB2bczt6uCgoUWZif2Q3NQvmWrJkyyv2Yuw6HW2R4SRBBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896279; c=relaxed/simple;
	bh=QJ4QUf48jLETSns85vdQdgej39ipWym6Bky+pfG3R9k=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=FqIsS7g9KU3YUjQ3wcAX/izzYxB/0MaPG6ukbCa5wtZMsq70y3ahPxSPX7mzfokGIaqj5oVGp583n/QEk7CLFFGDca1AgtmteUv3Us+TDSjb3ycaDGvSvW7nXj0BARIdPsahPihx00bLV8O37xeiYFzzYoSzFLT7rLmQD41MtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoY0a4ar; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso13921595e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758896276; x=1759501076; darn=vger.kernel.org;
        h=cc:autocrypt:subject:to:content-language:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJ4QUf48jLETSns85vdQdgej39ipWym6Bky+pfG3R9k=;
        b=VoY0a4arWiklUf4ayIfW4kcaE+pDSQM9pcM9uRnAasTx8IShnhNomsT/4C9cdcfgFK
         OoNQwdNr7zVy8p3hth2LpJPZbyUX5svbCIX9dblUrWkBQVdHm9Abm2ooOKZFx/8vziW4
         yHxszhSslPdHbM94MIGb4Q1jtZ37cB5T9XMUgdi5Sl/MAa/o1ip56pnL5qUQGSQBPqtt
         d2AK9YTTH4ghF4V2x87EuBCHUqb5mSMaI51GlBEBiXR2OwuR/Zx3ezxT47zk9wZZk8mA
         xuHJYOSIAzNzHGyscdz/+gFoicq9wNG0TxCgOOyDur2ng1PwpNROzaSC0Uo+VM2M7W8O
         MMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896276; x=1759501076;
        h=cc:autocrypt:subject:to:content-language:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QJ4QUf48jLETSns85vdQdgej39ipWym6Bky+pfG3R9k=;
        b=KbWq8nh0cOjDupu+swHBHYtdQxeP1vQ/VRsSJ5dIhK7M2RPPvJjGJyM2zeRkF0tS1v
         0gZs2pg/trCK+QvoMA7S6sMMiYAIIEa0TSy2R3utbRMwa6JI/fffq9/kZwSsw5cyYGNq
         9DyBR7MXgSJ2Q6cRpAR9kG1wfCxVOGF88s1MGu+B7UTkakPIUiGjz/zWNk4roB//+KXC
         hgpFeEhNv/dvkhepJl9log7dFByKwb7k1TLbyoLfSbTKMeG0wW4Qsucn04jRd+e+/XKf
         cUhDluG9v4+mdtfT0q8290TE+o6vMz43JH74FTaN/7SBxY/+MgkfvDNmAv3lonJLcOwT
         3ZLA==
X-Gm-Message-State: AOJu0Yw/tV0ZxITy8G/sFBaEK3/hTnA0eKHvGTYiWmyDD3P0rCRkW7ru
	s8/Q9NWCj6KIWlAQVl7eP30oneljTdTYLjiguqa8HlrVR9QHJmtOwI7Ay+0fEc2D
X-Gm-Gg: ASbGncuApqAMPGqtvFSEnd1WKX7CagrPDbroDQSqacsbLiW3zp2UsTWqdSghfxsIwO6
	DyeYQSg/PKl6GnZuwwLLQH0x5DzZrLmvrfPquW69xP3QYFIyZZOWfOh6hqnsjAWtnQQVvgc1mPO
	2mmrl/+dkCHrUMNE0UVd7dRGJ0BAJsEySDXZWxE3xT7rcF56zo2YlOBvURWAFhE7v2ahVYMmxY1
	WqeFJNKv+YhhVAQgENlqGLVFKCBI1bAW7HHaWpQlo4iNTm373Db31QPDlk7+IF3hOubhWFZGrzs
	AMg4v4uH7v2rYy1DKGSwB73/QNaA0DBD0DzEufkmx0cRPAgrMBASty9EeNSw64kgZHzh/aTKfj+
	GqskK6N4aG5J7N5nHgbbkT2IIwkJAfg7gJerHTBeZ
X-Google-Smtp-Source: AGHT+IGc74HcN0ru/qY8l8ltUEqPQYLvrB8zS0LikU78NYGd3NMsA03h0k6eeMDuzx8jvlSsYuutgg==
X-Received: by 2002:a05:600c:1695:b0:45f:2869:c3b2 with SMTP id 5b1f17b1804b1-46e32a1973cmr50371225e9.33.1758896275643;
        Fri, 26 Sep 2025 07:17:55 -0700 (PDT)
Received: from [192.168.1.201] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e330d1d2fsm39069445e9.3.2025.09.26.07.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:17:54 -0700 (PDT)
Message-ID: <391ee227-54e2-475c-9811-710fa22687ef@gmail.com>
Date: Fri, 26 Sep 2025 15:17:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
To: Wensheng Wang <wenswang@yeah.net>, Guenter Roeck <linux@roeck-us.net>,
 Noah Wang <wenswang@yeah.net>, linux-hwmon@vger.kernel.org
Subject: re: hwmon: add MP2925 and MP2929 driver
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JFxrbS9sR0baaTCprrPNF1qR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JFxrbS9sR0baaTCprrPNF1qR
Content-Type: multipart/mixed; boundary="------------1Y3dno2XoQSvEglP5PjRh5W5";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Wensheng Wang <wenswang@yeah.net>, Guenter Roeck <linux@roeck-us.net>,
 Noah Wang <wenswang@yeah.net>, linux-hwmon@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <391ee227-54e2-475c-9811-710fa22687ef@gmail.com>
Subject: re: hwmon: add MP2925 and MP2929 driver

--------------1Y3dno2XoQSvEglP5PjRh5W5
Content-Type: multipart/mixed; boundary="------------ZH3zyv0M99GcXUXWEhTpIX7k"

--------------ZH3zyv0M99GcXUXWEhTpIX7k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClN0YXRpYyBhbmFseXNpcyBvbiBsaW51eC1uZXh0IGhhcyBmb3VuZCBhbiBpc3N1
ZSBpbiBmdW5jdGlvbiANCm1wMjkyNV93cml0ZV93b3JkX2RhdGEgd2l0aCB0aGUgZm9sbG93
aW5nIGNvbW1pdDoNCg0KY29tbWl0IGIzYTRlZmM4ODYwMWNiNWZjOTdiNGFlMjNjNDc4NzAw
YTYwMzAyZGENCkF1dGhvcjogV2Vuc2hlbmcgV2FuZyA8d2Vuc3dhbmdAeWVhaC5uZXQ+DQpE
YXRlOiAgIFRodSBTZXAgMTggMTY6MDY6MDMgMjAyNSArMDgwMA0KDQogICAgIGh3bW9uOiBh
ZGQgTVAyOTI1IGFuZCBNUDI5MjkgZHJpdmVyDQoNCg0KVGhlIGlzc3VlIGlzIGFzIGZvbGxv
d3M6DQoNCiAgICAgICAgIGNhc2UgUE1CVVNfVk9VVF9PVl9GQVVMVF9MSU1JVDoNCiAgICAg
ICAgIGNhc2UgUE1CVVNfVk9VVF9VVl9GQVVMVF9MSU1JVDoNCiAgICAgICAgICAgICAgICAg
cmV0ID0gcG1idXNfd3JpdGVfd29yZF9kYXRhKGNsaWVudCwgcGFnZSwgcmVnLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHJldCAmIH5HRU5NQVNL
KDExLCAwKSkgfA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRklFTERfUFJF
UChHRU5NQVNLKDExLCAwKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRElWX1JPVU5EX0NMT1NFU1Qod29yZCAqIA0KTVAyOTI1X1ZPVVRfT1ZVVl9E
SVYsDQogIA0KTVAyOTI1X1ZPVVRfT1ZVVl9VSU5UKSkpOw0KICAgICAgICAgICAgICAgICBi
cmVhazsNCg0KVGhlIGNhbGwgdG8gcG1idXNfd3JpdGVfd29yZF9kYXRhKCkgaXMgYWNjZXNz
aW5nIHZhcmlhYmxlIHJldCB2aWEgdGhlIA0KbWFzayB+R0VOTUFTSygxMSwgMCkgaG93ZXZl
ciBhdCB0aGlzIHBvaW50IHJldCBoYXMgbm90IGJlZW4gaW5pdGlhbGl6ZWQgDQpzbyBpdCBj
b250YWlucyBhIGdhcmJhZ2UgdmFsdWUuDQoNCkNvbGluDQo=
--------------ZH3zyv0M99GcXUXWEhTpIX7k
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

--------------ZH3zyv0M99GcXUXWEhTpIX7k--

--------------1Y3dno2XoQSvEglP5PjRh5W5--

--------------JFxrbS9sR0baaTCprrPNF1qR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmjWoF8FAwAAAAAACgkQaMKH38aoAiYe
hg/9FJ5C9m4Ujqges9dxdgjMcMPS7zjHjULQpKGNjppat/w3gnZAyEEDcQCSlDMsouoSgu/TtHPr
tvlx2Cy+aGBI4j0JhNZp3qjpelqJHLtZbNFXTpfATvqMTtiaGHywkK3ZbBPw4nt/leM7Y2WimWYr
gZjCzqA5IdRFsXuTUoX7JJ3/6uwp7/o652xg7QKjDL5SA+fvWH/3oo5WtnyRQciurYoUDO5ke1Wc
UQKaXyL2f4ez5G3nlTECN4+C7z4v6I2ei9Shoh04rfsKFwX/y5Zm3I3ZPiCQk0mSsoixX4kd+Zth
VbeNVG6fk/Y0ClWgb1VaAWj6p6MoTxHBEW4GAijjzJ/9Nxx4vOMTFce9JkoMetgPKpcnq6ofQT9f
Bsj4N/ekpuq1DSO6PHm9tl/qfRFlzpdGWxp4CSz9j30FMEQoS06qRdlY/5y+V1x7LLvVQxwlD0lY
wODr7nayT7aSJOL6o3D/pVuA/ifXk1+u2+FWcF7uYoewSZJMmNtxIaRO5YhvoSsupkh9cEybwUuO
AdT6S496Kk1IRmoSe10eIQ/i5hmQ/Zt2/JGb/qW6M7EPZPeN3EzSuI4Uht7nwXzrekCd6FeW6N1J
VFQk6LKELTIBlSWkz23ckTQWsNs0ddYNPlekhe6iz4KCBinfxfYK1gSrO3SZjvimeGIy/HOYZ2nx
4AA=
=iFUU
-----END PGP SIGNATURE-----

--------------JFxrbS9sR0baaTCprrPNF1qR--

