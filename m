Return-Path: <linux-kernel+bounces-768645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181FDB2639F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4C61CC55A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1363009E1;
	Thu, 14 Aug 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwca1JKr"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66202EA472
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168855; cv=none; b=WMNsSmX0k9t0XNSIcOixfN9ieycSpbSafvJFsomME8fndSlfUVXwCLryBW59cZuALF2/Xh3plkN9XvhhlsJ9ip9dDkKF4IGYM24dxfjGE3OMP98hUWmcYknY8p3Bn7TZtz/o+AqBAQARxt9Sy/HA+UrvdCwl6WDhtMAZUsUdzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168855; c=relaxed/simple;
	bh=i6NMrOrfBsbi7eEHhMx2Jg+ZLwA+A5SHXYgNjvrmABM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=rPeOjnPDyMvdHZF5MuqiX5J1wFcK0HzCJmQa1QUK+LUr32ikt/riKplmhfWDqe3uy41Nx18LjCGR0rtHrCzFd/mMXbQvvMYQ9xAv+vCYlAMHhJSfMGLynXOYXow6cmqopVLwo6t+4Avcktrml3Iw7JpBzjKDzC5QN1PQzaBTqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwca1JKr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso4175835e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168852; x=1755773652; darn=vger.kernel.org;
        h=to:autocrypt:subject:from:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i6NMrOrfBsbi7eEHhMx2Jg+ZLwA+A5SHXYgNjvrmABM=;
        b=Wwca1JKrviQPI5lPe0+3pl7EVc3uBRu7HG9OXAnU/XfAYQoPgLub8Xq/Ydgjr9Avld
         Rd8jbmsIqStuCs1+Wm3KQjT7hu1gp7IhhKINPRXeqak212ApTHLJjdU1NMRSA3EJdsSE
         bt9chnPqsMAB4H1sjPA/pXBNOHrtCZ6Yez5xOduShhMbH8uHRgG5SOlg1NO02vLWI4e/
         Sp4bEjp1J2DoLzemT3Zo3UCKbwLQ39bcFGhK7lw/0hXYdzLbFfaWoxyVkJxwsS/dYB1b
         kGepf/sYPBfP4iq5bhOWoZiB4V3QoVBMUZgqV0YKVBtGs5EMQ6bNiB+j5LxfeFTh12JI
         vN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168852; x=1755773652;
        h=to:autocrypt:subject:from:content-language:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6NMrOrfBsbi7eEHhMx2Jg+ZLwA+A5SHXYgNjvrmABM=;
        b=wqk3KRLNYRsJRH0TRBlcygc2w7+EdhbhJdp9CgV2PwwPhGJ5H0eNOOn3uame9K6vhv
         Il2LVL+/QEsBUmjzlY7l9YhQ8Qg+mFOz5l0PV/YJoIegh3i7BXwdw9aj10SrbqUoD9zD
         SComfKQ0dUghZ6qkhB8ZpzNJsqIhVj3badTIvtbmGFLnyvbbEm/FbwXptQi7u1LhHGne
         UJ+TJAMIzZfPOhMqWvKNoAV4qQXWa85kTl9xKP7aRlJVkxVRr7UMAtQAQAn96W7O0Qd9
         e0cqV1/Wma+qkiW3zGO00yAUfXmbF+G09lCrmBF9H0JVaBIrd0md8tJYtjuGxVCiAfBp
         44AQ==
X-Gm-Message-State: AOJu0Yyh9X5aU/jrGO197LIV1bqmfHh1czt9fw5p1kJTe2STyXWMEd0M
	BHgMFYMHIyj9nOJjSCVp6agP2pMjzYYpl6H62XuKc/VXVgSy/JV+F1wtAeNPrbdc
X-Gm-Gg: ASbGncv4LwFvbxRbK7SICvODabFZyE8z4C+T7++xDCracyroLjDUdVMMt/lXbQc8Nlg
	5gymwvWYIampKKq8ILexNdQ4h0FMLjuAENeXscQ1123bl6K/O5PC+1Dt0yqqpLzu0wmQtVuRB/q
	3DoSooAJcdnTwvZCk2FiJ5H+i+ImoPNMSRHLWP1++g99m0G1jjJRFJl8u/zSqfECZJR0T2hEdUs
	nruBFkzBWtb4tGHJ64w+w8l65+NjceKcwQtH/FIxqabNaA9uZk6Oq8l1z35ffq8fjk5syHPYG0o
	7vOPOSWfRWHzCQ7P9GuKGL5xijaNOHcHTSPDfF+Elwh6ONItzXZWRS3qTVvtQ4f1L8HgPdfbJ4H
	XF2QzU3QxapGbfO3PR0YXhcftw0tCtcFw9W0aqarR2DlDNPJJdpsR0eBRMlY=
X-Google-Smtp-Source: AGHT+IH16HjgomMN2dh/XAyQbhrYYnXx3WklXNRuoxUS9ImwE0yzGDa2vY/0ZB/1Bdzc+IhxDIXAZw==
X-Received: by 2002:a05:600c:450e:b0:458:f70d:ebd7 with SMTP id 5b1f17b1804b1-45a1b66d5c9mr18529065e9.20.1755168851436;
        Thu, 14 Aug 2025 03:54:11 -0700 (PDT)
Received: from [10.55.1.176] (188.70.78.188.dynamic.jazztel.es. [188.78.70.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6fba41sm16627925e9.20.2025.08.14.03.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 03:54:10 -0700 (PDT)
Message-ID: <51e650f7-39f3-4e06-a3ed-9941e0ccb0c0@gmail.com>
Date: Thu, 14 Aug 2025 12:54:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, es
From: "David C. Manuelda" <stormbyte@gmail.com>
Subject: Proposal: Make CONFIG_DRM_TTM_HELPER a user-configurable option
Autocrypt: addr=stormbyte@gmail.com; keydata=
 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
 keS4m75L
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0G536LPjOhwC1KI7fL9FSAKs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0G536LPjOhwC1KI7fL9FSAKs
Content-Type: multipart/mixed; boundary="------------51myZiFgNOLS20v0HMRsMfEI";
 protected-headers="v1"
From: "David C. Manuelda" <stormbyte@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <51e650f7-39f3-4e06-a3ed-9941e0ccb0c0@gmail.com>
Subject: Proposal: Make CONFIG_DRM_TTM_HELPER a user-configurable option

--------------51myZiFgNOLS20v0HMRsMfEI
Content-Type: multipart/mixed; boundary="------------s0ppEJguwEdGHNZDw0Ws0DnX"

--------------s0ppEJguwEdGHNZDw0Ws0DnX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJJ20gd29ya2luZyB3aXRoIGV4dGVybmFsIERSTSBkcml2ZXJzIChzdWNo
IGFzIE5WSURJQSdzIHByb3ByaWV0YXJ5IA0KbW9kdWxlKSwgYW5kIEkndmUgbm90aWNlZCB0
aGF0IGBDT05GSUdfRFJNX1RUTV9IRUxQRVJgIGlzIGN1cnJlbnRseSBub3QgDQp1c2VyLXNl
bGVjdGFibGXigJRpdCBnZXRzIHB1bGxlZCBpbiBvbmx5IHdoZW4gZW5hYmxpbmcgb3RoZXIg
ZHJpdmVycyBsaWtlIA0KYG5vdXZlYXVgLCBgYW1kZ3B1YCwgZXRjLg0KDQpUaGlzIGNyZWF0
ZXMgYSBzaXR1YXRpb24gd2hlcmUsIGluIG9yZGVyIHRvIGJ1aWxkIHN1cHBvcnQgZm9yIGV4
dGVybmFsIA0KZHJpdmVycyB0aGF0IGRlcGVuZCBvbiBgRFJNX1RUTV9IRUxQRVJgLCBvbmUg
bXVzdCBhbHNvIGVuYWJsZSB1bnJlbGF0ZWQgDQpEUk0gZHJpdmVycywgd2hpY2ggbWF5IG5v
dCBiZSBkZXNpcmVkIGluIGNlcnRhaW4gc2V0dXBzLg0KDQpJbiBteSBodW1ibGUgb3Bpbmlv
biwgaXQgd291bGQgYmUgYmVuZWZpY2lhbCB0byBtYWtlIGBEUk1fVFRNX0hFTFBFUmAgYSAN
CmRpcmVjdGx5IHNlbGVjdGFibGUgb3B0aW9uIGluIGBtZW51Y29uZmlnYC4gVGhpcyB3b3Vs
ZCBhbGxvdyB1c2VycyB0byANCmVuYWJsZSBpdCBpbmRlcGVuZGVudGx5LCB3aXRob3V0IGRy
YWdnaW5nIGluIG90aGVyIGRyaXZlcnMuDQoNClRoYW5rcyBmb3IgeW91ciBhdHRlbnRpb24g
YW5kIGZvciBhbGwgdGhlIHdvcmsgeW91IGRvIG9uIHRoZSBrZXJuZWwuDQoNCkJlc3QgcmVn
YXJkcywNCkRhdmlkIEMuIE1hbnVlbGRhDQo=
--------------s0ppEJguwEdGHNZDw0Ws0DnX
Content-Type: application/pgp-keys; name="OpenPGP_0x813A1725FA18B780.asc"
Content-Disposition: attachment; filename="OpenPGP_0x813A1725FA18B780.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
9CjQugJlQaKYNhZ3keS4m75L
=3Df/eA
-----END PGP PUBLIC KEY BLOCK-----

--------------s0ppEJguwEdGHNZDw0Ws0DnX--

--------------51myZiFgNOLS20v0HMRsMfEI--

--------------0G536LPjOhwC1KI7fL9FSAKs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElxGNhLvh60ul/Hc7gToXJfoYt4AFAmidwFEFAwAAAAAACgkQgToXJfoYt4CY
CQ//bzMQXKThLTb2EYNYusGSyZgouB715x3wArc5iinX6ym0EGYTAtcwwIqqVPJhbpMOfzH6gMby
52PAlXrXAWVJcLdqz63NPdvo2wPWGtGAyu/E1mJHmb6rM19qe/2kAwKPx2/FRbzFBm9aqvKIiKSt
RzZPWV+OIAgo+PL/pPNcoxSD/eKp1ohA2nuku5hY773tfAzEsDgiKOf9hHGS5YdHLppi4OVVb7Hq
OcRtsU3VgBfQzHfA2EvyyemMNN8YTEfo7IxQJjrrtiRfHMxkq+Q0B+SjYVvvfm9xY2U1zTSu4b2L
R1Yghz6es8AaNPCsLUMqp+bpb+Dmw3nZDjqNYLwvXMgsZieJtTaGnRfI4nmqbR53x/85qjoRgvv/
ljARxmsMuA9riWijTUsYDXO1khGJAQJSm1Jd3e7+t5L2XaovQmGa0BxjEdWJZHBEV+PkYrnJ4cMe
NsKdut0kGxFNYyzw4jcR5I7HLa5wt9y0I2FwGc+zClRJyYAQBfw2j3tApG8thw7UDBSeOLLL0Ukl
D8o8S3qxqEe8F1h3Nfn03fTpHaGZS/kBFhkvgnW0OV28q6snYl/3qJ8NRwfT3FjPtaGvNKwD/w9e
zD8myrVeHlTj06YzJZr+6YROC5s2GXoJFamgLZD0/uRepNNdnDPaBtrGlHaGaVIzn8QwU74kMpNE
G5w=
=ItkC
-----END PGP SIGNATURE-----

--------------0G536LPjOhwC1KI7fL9FSAKs--

