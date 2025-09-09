Return-Path: <linux-kernel+bounces-808903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CCCB50608
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7367ACF0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D549631CA7D;
	Tue,  9 Sep 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/ro+LTf"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3C303A26
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445384; cv=none; b=UXj/3ZI6wtYkNvb05/JitrSX/f89US5tGJl6ey00wfo4oPUxxdUft1zPXnsS7wnBColV7fZdPqa25KNZDT1Eb3cgYu3hQG0iivqZuywDs8rGdT7Ibi+toSJ8hESNBlAp2BpJd6t3AzheQ3JMlxN4Mp8RkGmuJX6fhLWoQAxZ/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445384; c=relaxed/simple;
	bh=hHkQK3GE/XJTsTTDsptOxH8G6kVpuv0h9J2bGvreJ4s=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=IgStuODFV2tbRnf3HqqaTXIYAMR7q1hkYYWNBD5TyBm3AArX4wAcTNUH8gRFBhJkmyBsQQ5G76FscTIELsX1xx9DcrNaSKr5MrLMb246Cj/Kdd4dMnP9mKzINLsbTcqM9tSZmK1w34mv0gawgVwh7GFRqX5jREODPu1nIagql5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/ro+LTf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so4191909f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445381; x=1758050181; darn=vger.kernel.org;
        h=autocrypt:subject:cc:to:content-language:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHkQK3GE/XJTsTTDsptOxH8G6kVpuv0h9J2bGvreJ4s=;
        b=d/ro+LTf9t0Q9vdqlOTuhha0+JDJ2K8xf7Wv6RZqBwCMTLr0OfGH7odS0z1NrdYH5S
         xoKNk8TciuuaMdRyYqtfW7XX/tf/eyU6z+Ce1QReQC3DWfuy2NALMayvfSofS7X56j91
         gxB2ZzgFE5tjzbO5mlG1DQ5ep00pD8ezhlo2PzcxXGVMAPaPOS+hs8h6a+O+kuA48dgz
         SR/NFrejJi68Uy3gPnxv1XGYAHpl2ztdyqnmIaFHMQEYy+bbfYHVtOE7JkunjRS45vhz
         Vwng4u41qRWbHOWzYwl5ThHCWlZoJ8pGTCoKXw+xb4iB+qtkZ725ZDP8Fchngy9JYzbg
         HbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445381; x=1758050181;
        h=autocrypt:subject:cc:to:content-language:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHkQK3GE/XJTsTTDsptOxH8G6kVpuv0h9J2bGvreJ4s=;
        b=dBxX1Y0gtig5Wl8RbT3VhORXhnZGq6UB+CUMw2ItkvUmT1hHh0hPElZsrRaeFVSQ5P
         OaHqxGftM9aW5oF+QDXOXiYWw5lD4Oiz6ga0F8hboHYl5Lw8JWdNni3KHDeM2P3Z5o5G
         UhfldkCTMK3jtzCJYyeKIKRM4/L5NF1vlXpMAS2KU2n/qzzS0JbHQL6idoisEGNLcexE
         VF4dsoEnFWVqVQPCbjhxfpNvpZ0qYclfy1frjRWhUT1VwawU7gYLPo1u4xTr+P04ko1O
         qFt/frC+GD/ACrYMjiGMA7QpPz8A6SMMupxQq6NrgQRrDSqm4ZuMwS6u6oDqKbOAix9T
         BVxg==
X-Gm-Message-State: AOJu0YxoE1SvWtO/wAu4SAN25fyvypEPcdyeb2+BaD6dKOylBH4VLA9W
	4Pe4IW1GrpRZqyAVECodbLNYee3GU8hLwnBrLUBZ5BuwKs7crdE+TMZo
X-Gm-Gg: ASbGncs5lWk8Lhcf+ntC6Gfyjc4mgsZ/Cru6/zrwg2kyVGSclNxt6/Pc75bfbTnM+Hj
	aeTXACOIMj87WS2cWHYjJhL4s61dCfohGSm3vMwrWO5pUbKmT2XEhfq4x43olKHkigPLa+8482O
	tdC77tkwzZoDUflmPWetqjOYaJ8ajRAWu9en+qf1kp6rMryKRrsc2wTNE6/yYMUAg/0Wy92AI+D
	vtFdjYqNoSFCVIL/5lrFyl5birYghpER9AiPlNm9OqzMebCyl8+bUomOftsOh16ccOfEd338u7w
	1PA+ftAHEczFrZY1jZEoyutXq3alh68ZkU+CZUlOhhKZ6zyhFkCZ6aui8oqG7vJgqmqnegrwnbo
	mnlYOG6H+82wAa0hK/Mn6PPiN4xUy
X-Google-Smtp-Source: AGHT+IE0WBf0J0vcKYPJbdmTFHtnBkTAwoYlm+VrB+pdSF86XVemMGHJmBAB1coBfCHzt4JcdT1KeQ==
X-Received: by 2002:a05:6000:200c:b0:3df:d8ea:1f7b with SMTP id ffacd0b85a97d-3e64c87e42dmr9339238f8f.51.1757445380734;
        Tue, 09 Sep 2025 12:16:20 -0700 (PDT)
Received: from [192.168.1.201] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e75223f607sm3723392f8f.51.2025.09.09.12.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:16:20 -0700 (PDT)
Message-ID: <5002d4f9-4999-4a84-9329-edb20098fd7a@gmail.com>
Date: Tue, 9 Sep 2025 20:15:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
To: Calixte Pernot <calixte.pernot@grenoble-inp.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: vt: add support for smput/rmput escape codes
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aggXICQzrDYng3gBgU9JCKiN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aggXICQzrDYng3gBgU9JCKiN
Content-Type: multipart/mixed; boundary="------------05POPbpOpbsg1Xh3CrrVr5yE";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Calixte Pernot <calixte.pernot@grenoble-inp.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <5002d4f9-4999-4a84-9329-edb20098fd7a@gmail.com>
Subject: re: vt: add support for smput/rmput escape codes

--------------05POPbpOpbsg1Xh3CrrVr5yE
Content-Type: multipart/mixed; boundary="------------m0hJcm2WmnvRep10AGvLLkce"

--------------m0hJcm2WmnvRep10AGvLLkce
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClN0YXRpYyBhbmFseXNpcyBvbiBsaW51eC1uZXh0IGRldGVjdGVkIGFuIGlzc3Vl
IHdpdGggdGhlIGZvbGxvd2luZyBjb21taXQ6DQoNCmNvbW1pdCAyMzc0M2JhNjQ3MDlhOWMx
MzdjMWI5MjhmOGI4ZTAwZDg0NmFmOWNjDQpBdXRob3I6IENhbGl4dGUgUGVybm90IDxjYWxp
eHRlLnBlcm5vdEBncmVub2JsZS1pbnAub3JnPg0KRGF0ZTogICBNb24gQXVnIDI1IDE0OjU2
OjA5IDIwMjUgKzAyMDANCg0KICAgICB2dDogYWRkIHN1cHBvcnQgZm9yIHNtcHV0L3JtcHV0
IGVzY2FwZSBjb2Rlcw0KDQoNClRoZSBpc3N1ZSBpcyBhcyBmb2xsb3dzIGluIGRyaXZlcnMv
dHR5L3Z0L3Z0LmMgZnVuY3Rpb24gdmNfZGVhbGxvY2F0ZSwgDQp3aXRoIG15IG5vZGVzIHBy
ZWZpeGVkIGJ5ICMjIyMjDQoNCnN0cnVjdCB2Y19kYXRhICp2Y19kZWFsbG9jYXRlKHVuc2ln
bmVkIGludCBjdXJyY29ucykNCnsNCiAgICAgICAgIHN0cnVjdCB2Y19kYXRhICp2YyA9IE5V
TEw7ICAgICMjIyMgdmMgaXMgc2V0IHRvIG51bGwNCg0KDQogICAgICAgICBXQVJOX0NPTlNP
TEVfVU5MT0NLRUQoKTsNCg0KICAgICAgICAgaWYgKHZjX2NvbnNfYWxsb2NhdGVkKGN1cnJj
b25zKSkgew0KICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnRfbm90aWZpZXJfcGFyYW0gcGFy
YW07DQoNCgkJIyMjIyMgdnMgaXMgb25seSBzZXQgaW4gdGhpcyBpZiBibG9jaw0KDQogICAg
ICAgICAgICAgICAgIHBhcmFtLnZjID0gdmMgPSB2Y19jb25zW2N1cnJjb25zXS5kOw0KCQkJ
CQ0KCQkJDQoNCiAgICAgICAgICAgICAgICAgYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4o
JnZ0X25vdGlmaWVyX2xpc3QsIA0KVlRfREVBTExPQ0FURSwgJnBhcmFtKTsNCiAgICAgICAg
ICAgICAgICAgdmNzX3JlbW92ZV9zeXNmcyhjdXJyY29ucyk7DQogICAgICAgICAgICAgICAg
IHZpc3VhbF9kZWluaXQodmMpOw0KICAgICAgICAgICAgICAgICBjb25fZnJlZV91bmltYXAo
dmMpOw0KICAgICAgICAgICAgICAgICBwdXRfcGlkKHZjLT52dF9waWQpOw0KICAgICAgICAg
ICAgICAgICB2Y191bmlzY3Jfc2V0KHZjLCBOVUxMKTsNCiAgICAgICAgICAgICAgICAga2Zy
ZWUodmMtPnZjX3NjcmVlbmJ1Zik7DQogICAgICAgICAgICAgICAgIHZjX2NvbnNbY3VycmNv
bnNdLmQgPSBOVUxMOw0KICAgICAgICAgfQ0KDQoJIyMjIyMgdmMgaXMgcG90ZW50aWFsbHkg
bnVsbCBhbmQgYmVpbmcgZGVyZWZlcmVuY2VkIGJlbG93Og0KDQogICAgICAgICBpZiAodmMt
PnZjX3NhdmVkX3NjcmVlbiAhPSBOVUxMKSB7DQogICAgICAgICAgICAgICAgIGtmcmVlKHZj
LT52Y19zYXZlZF9zY3JlZW4pOw0KICAgICAgICAgICAgICAgICB2Yy0+dmNfc2F2ZWRfc2Ny
ZWVuID0gTlVMTDsNCiAgICAgICAgIH0NCiAgICAgICAgIHJldHVybiB2YzsNCn0NCg0KDQpU
aGUgaXNzdWUgaXMgdGhhdCB2YyBpcyBvbmx5IHNldCBpbiB0aGUgaWYgKHZjX2NvbnNfYWxs
b2NhdGVkKGN1cnJjb25zKSkgDQppZiBibG9jaywgYW5kIHdoZW4gaXQgaXMgbm90IHNldCwg
d2UgZW5kIHVwIHdpdGggYSBudWxsIHBvaW50ZXIgDQpkZS1yZWZlcmVuY2Ugb24gdGhlIGlm
ICh2Yy0+dmNfc2F2ZWRfc2NyZWVuICE9IE5VTEwpIGNoZWNrLg0KDQpJIHN1Z2dlc3QgbW92
aW5nIHRoYXQgbGF0dGVyIGNoZWNrIGludG8gdGhlIGVhcmxpZXIgaWYgYmxvY2suDQoNCkNv
bGluDQo=
--------------m0hJcm2WmnvRep10AGvLLkce
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

--------------m0hJcm2WmnvRep10AGvLLkce--

--------------05POPbpOpbsg1Xh3CrrVr5yE--

--------------aggXICQzrDYng3gBgU9JCKiN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmjAfNUFAwAAAAAACgkQaMKH38aoAiYr
qg//dCRnH38JDj+o/F5Ltyg655iX39ybQXK2K806JqFOuMYPd9pFF2AO8jbEEN9j3KBENtcWTkWk
BYFIAnjHiuo5lLXKkWccCln/z+m3/SKgYzvwWv+VFasJAI3xdgMGEGnG5YyhW8hl2rFCDYDD/m5b
t/dQ6+jY09ywWG1feFlhm7RZCQxRSqTknIkbpbqOgp6aLkM1GUmBNL4k4HzkQtViRiQzTtUs9gp7
wpjDaBGoCcsRducwl5NlLi7a/eMGaq5IUDUhvsD8xiLf8PpxLlmzmymMq9IPtt4bT3NXqRX6Rvxn
ytztGLCA2j3jaYae5auB+1vdNMdmBRGe4Ag+mjiVqe+BpINcxnm7AoIFQzJlnTPdhfkGrnrsff0+
WieFnqxDd/xTqz3RF+YUEwOM79kXn3VX3U4vUcADGp9RwFU/9s4JYeUYidi1N52cz65eXdwYvKuu
pzt5w4+5s4IwA71NbhSBobsZ+aMQnWRDoviJvKXuU1nEkF5B/rmLk3JpV/qh3Ulk5OYy7tejNPBf
47Hj7Z9AEh+g8kIIuqwk60biWoxGjpkQZsei1rnZGW1vGWGoBWci77uR/tUYNYgHBFNAC8jKxjJa
natIT30zByF08GVYLdTBXffdzbiyPF/vStyOfSKDP7gr+Wasp7Jgicbw0jVZBk/6xgIyew7FCRs1
aQE=
=1ztn
-----END PGP SIGNATURE-----

--------------aggXICQzrDYng3gBgU9JCKiN--

