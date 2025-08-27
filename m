Return-Path: <linux-kernel+bounces-788564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE02B38676
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47CE1C214D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BE1E0E08;
	Wed, 27 Aug 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b3Cb13Vu"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879E2798EA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308085; cv=none; b=dFyn6nC5UajDNIAsEA2/PNqG+1PTRZt0qi8NQHb9bAgx90a7JbU/qI6p5F/Z5A6ecGzD61Dz6/l4CJQqmvYpjBcXtkWAnKrGrAqp4jHTw6/w/NC6OT9UYrx2YWEGzvsxa+aC13dm8+R3rdRGPh8HIgADP35A29nQB0iOhDJEVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308085; c=relaxed/simple;
	bh=ZJ4Lyh9S68n97ZQMBN60BvENdELiq1GBSuRV257pKsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMnBHpoDd+oIPC1KxuliOtU41/UxaoN0I0p5rulYOP62VRr0vuuADKpk5ojlH9al42VkC68yfoGkWMAaCBhtIccz+8INgST53YuGv4Q+Xh95iGgzG12oRzBiywEu1rEkvlngPXBfl/PUxlwKFb/XQN7gbTECBMoniPPXHHWLdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b3Cb13Vu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c84aea9d32so1888642f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756308081; x=1756912881; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJ4Lyh9S68n97ZQMBN60BvENdELiq1GBSuRV257pKsw=;
        b=b3Cb13Vun3g+KIqT13lQsDVqYh+TIyawa12E0ryqJLWtOpnZbsv3DWydW3lK8UddB5
         T1PD23HMb8UUokdCX0i3VRuXSveiUaUFlpbh5pegu56CzNDV2l8vT0Z6qHIK7Ugd42pt
         knuduGCx7xIsaA2UTWR4Oh7J4HZ+jQ0cMvJ2YgryQmhmBiCVu0y32M6zeujgu30wV+qz
         DdwMOHBdjw0MswYhXh8Y+UjDAhAMjclXNLbnPTrChkBAEv7gfRyr85eipytdRzBfjjgk
         5Tza2eM4bWuuPWUPSc4XPDX4Sz558lxkrxtEKB2XDtXZK4mOFBOE4YpkiPnvKCVlxPBL
         k+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308081; x=1756912881;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ4Lyh9S68n97ZQMBN60BvENdELiq1GBSuRV257pKsw=;
        b=M2SAqUNJpeJM5nQDNWQr2m2Ib0ZxNT1FIOZpE845FuDyCNXMZBaFef2KVn4nioq4Bk
         t3CWJjpajhvHeWYo54boS6BK34ZFw5m0V/o88paS4nnwsoJBngR0ySNbG2O8hDNyTaXb
         niizGruNZcJEUkqNclvv5KHN1mzy4EDsPACx40Xqpa2xp/NzHbujVbymn/kRytC8MlYR
         EhJNpLiS8KHsY7ZPv2BfRwUnpMRKvCzx8wO6mb3pcBnx7kDMPbbIpZ6gLaVKTuqlPq8+
         UlZ1hJdRweZxuj15Ih2v96SKA2TDRdnb95lqbUA4hedxhGRvLwZlMKC4QIsdNLu9rT6t
         sAWA==
X-Forwarded-Encrypted: i=1; AJvYcCXf2r2MWbanqdGjRO96bS6mwqDHjbHbWHi26/Yu1FIyhc09p6yJ0UpoU2244fhvg+N4BgD0thyT3xowViI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNhR+BDWVmIGods9er6iLJf1HWnVa3YZyx9HpEdHj11q+Oi+n
	1YGbj4udlKm/jNxGW8b3NsQOQAvLI/xu9c29kHt+CqAKr/kd7Q5uzZiF5pv5PY4Nj/tR/ZTK0qq
	c439/9Es=
X-Gm-Gg: ASbGncswqhQ5bKXZIrdp1sbtath890T2EE0mjNRS/SObgvbrFi9vRd2KBZK/zEmczne
	SoOdpcgSKxUx8Bok7aiGQvKGEsliGz1h14Zp45L82R+r76Xn6uvy8z8aXypJN+D84chyIekbnrZ
	ZJt6OtiGuRFBFaeS91bWqImAcS36Vl3ikpcEcv++mHwW2NiNm4UB3A03/DwhyPZ6W3KcbrLMT9B
	x6fl4l+KoY1k9bS4UMI4UFEdShDcEO9J41P8OcgAKusmtz87P3Y4FIux0qU0vnUF9/zsLvd7uSW
	4nJXkR8isvZcfAW9b1iYnYXOsLsKmUc0/zVdlzdK1p8WTtJGJc4CN0NMro1ZU/RkUPhLWbisWht
	hbREXVZ/W9l/0SWMiEDimZEr7h9fcOzghGF+wj/jTu55oXGBaENVoL+e5ohDElN+rnoVEPbuMfp
	I77kRecDYLueX9jEoj8jhuNfgbKIjrpDkbL7Zi3TEw4h3WtqSN+lntDA5w9A==
X-Google-Smtp-Source: AGHT+IFKXKZ8cN3iLWN6n8+GBiZKGmyEDPex9uDRHeEYZf4mmSeyQ5c4G4NvKVn2qSQawBYHsXZ4CQ==
X-Received: by 2002:a05:6000:1ac8:b0:3ca:99ad:5191 with SMTP id ffacd0b85a97d-3ca99ad5743mr5990663f8f.8.1756308081046;
        Wed, 27 Aug 2025 08:21:21 -0700 (PDT)
Received: from ?IPV6:2003:e5:872d:6400:8c05:37ee:9cf6:6840? (p200300e5872d64008c0537ee9cf66840.dip0.t-ipconnect.de. [2003:e5:872d:6400:8c05:37ee:9cf6:6840])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba390sm22239966f8f.12.2025.08.27.08.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 08:21:20 -0700 (PDT)
Message-ID: <2d7bceff-d70f-4f17-b833-380ffc06577e@suse.com>
Date: Wed, 27 Aug 2025 17:21:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] xen/events: Return -EEXIST for bound VIRQs
To: Jason Andryuk <jason.andryuk@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250826005517.41547-1-jason.andryuk@amd.com>
 <20250826005517.41547-3-jason.andryuk@amd.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20250826005517.41547-3-jason.andryuk@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yVAY1BcNylNoOBfWz0aii7DJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yVAY1BcNylNoOBfWz0aii7DJ
Content-Type: multipart/mixed; boundary="------------0ny5680ISBnZo4aAVwoi2CT4";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jason Andryuk <jason.andryuk@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <2d7bceff-d70f-4f17-b833-380ffc06577e@suse.com>
Subject: Re: [PATCH v2 2/3] xen/events: Return -EEXIST for bound VIRQs
References: <20250826005517.41547-1-jason.andryuk@amd.com>
 <20250826005517.41547-3-jason.andryuk@amd.com>
In-Reply-To: <20250826005517.41547-3-jason.andryuk@amd.com>

--------------0ny5680ISBnZo4aAVwoi2CT4
Content-Type: multipart/mixed; boundary="------------lcecfKkKjQpW638uz1722be8"

--------------lcecfKkKjQpW638uz1722be8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDguMjUgMDI6NTUsIEphc29uIEFuZHJ5dWsgd3JvdGU6DQo+IENoYW5nZSBmaW5k
X3ZpcnEoKSB0byByZXR1cm4gLUVFWElTVCB3aGVuIGEgVklSUSBpcyBib3VuZCB0byBhDQo+
IGRpZmZlcmVudCBDUFUgdGhhbiB0aGUgb25lIHBhc3NlZCBpbi4gIFdpdGggdGhhdCwgcmVt
b3ZlIHRoZSBCVUdfT04oKQ0KPiBmcm9tIGJpbmRfdmlycV90b19pcnEoKSB0byBwcm9wb2dh
dGUgdGhlIGVycm9yIHVwd2FyZHMuDQo+IA0KPiBTb21lIFZJUlFzIGFyZSBwZXItY3B1LCBi
dXQgb3RoZXJzIGFyZSBwZXItZG9tYWluIG9yIGdsb2JhbC4gIFRob3NlIG11c3QNCj4gYmUg
Ym91bmQgdG8gQ1BVMCBhbmQgY2FuIHRoZW4gbWlncmF0ZSBlbHNld2hlcmUuICBUaGUgbG9v
a3VwIGZvcg0KPiBwZXItZG9tYWluIGFuZCBnbG9iYWwgd2lsbCBwcm9iYWJseSBmYWlsIHdo
ZW4gbWlncmF0ZWQgb2ZmIENQVSAwLA0KPiBlc3BlY2lhbGx5IHdoZW4gdGhlIGN1cnJlbnQg
Q1BVIGlzIHRyYWNrZWQuICBUaGlzIG5vdyByZXR1cm5zIC1FRVhJU1QNCj4gaW5zdGVhZCBv
ZiBCVUdfT04oKS4NCj4gDQo+IEEgc2Vjb25kIGNhbGwgdG8gYmluZCBhIHBlci1kb21haW4g
b3IgZ2xvYmFsIFZJUlEgaXMgbm90IGV4cGVjdGVkLCBidXQNCj4gbWFrZSBpdCBub24tZmF0
YWwgdG8gYXZvaWQgdHJ5aW5nIHRvIGxvb2sgdXAgdGhlIGlycSwgc2luY2Ugd2UgZG9uJ3QN
Cj4ga25vdyB3aGljaCBwZXJfY3B1KHZpcnFfdG9faXJxKSBpdCB3aWxsIGJlIGluLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSmFzb24gQW5kcnl1ayA8amFzb24uYW5kcnl1a0BhbWQuY29t
Pg0KPiAtLS0NCj4gVjI6DQo+IE5ldw0KPiAtLS0NCj4gICBkcml2ZXJzL3hlbi9ldmVudHMv
ZXZlbnRzX2Jhc2UuYyB8IDE3ICsrKysrKysrKysrKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMgYi9kcml2ZXJzL3hlbi9ldmVu
dHMvZXZlbnRzX2Jhc2UuYw0KPiBpbmRleCAxOTlhZmU1OWYzNTcuLmE4NWJjNDNmNDM0NCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gKysr
IGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gQEAgLTEzMTQsMTAgKzEz
MTQsMTIgQEAgaW50IGJpbmRfaW50ZXJkb21haW5fZXZ0Y2huX3RvX2lycV9sYXRlZW9pKHN0
cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0xfR1BM
KGJpbmRfaW50ZXJkb21haW5fZXZ0Y2huX3RvX2lycV9sYXRlZW9pKTsNCj4gICANCj4gLXN0
YXRpYyBpbnQgZmluZF92aXJxKHVuc2lnbmVkIGludCB2aXJxLCB1bnNpZ25lZCBpbnQgY3B1
LCBldnRjaG5fcG9ydF90ICpldnRjaG4pDQo+ICtzdGF0aWMgaW50IGZpbmRfdmlycSh1bnNp
Z25lZCBpbnQgdmlycSwgdW5zaWduZWQgaW50IGNwdSwgZXZ0Y2huX3BvcnRfdCAqZXZ0Y2hu
LA0KPiArCQkgICAgIGJvb2wgcGVyY3B1KQ0KPiAgIHsNCj4gICAJc3RydWN0IGV2dGNobl9z
dGF0dXMgc3RhdHVzOw0KPiAgIAlldnRjaG5fcG9ydF90IHBvcnQ7DQo+ICsJYm9vbCBleGlz
dHMgPSBmYWxzZTsNCj4gICAJaW50IHJjOw0KPiAgIA0KPiAgIAltZW1zZXQoJnN0YXR1cywg
MCwgc2l6ZW9mKHN0YXR1cykpOw0KPiBAQCAtMTMyOSwxMiArMTMzMSwxNiBAQCBzdGF0aWMg
aW50IGZpbmRfdmlycSh1bnNpZ25lZCBpbnQgdmlycSwgdW5zaWduZWQgaW50IGNwdSwgZXZ0
Y2huX3BvcnRfdCAqZXZ0Y2huKQ0KPiAgIAkJCWNvbnRpbnVlOw0KPiAgIAkJaWYgKHN0YXR1
cy5zdGF0dXMgIT0gRVZUQ0hOU1RBVF92aXJxKQ0KPiAgIAkJCWNvbnRpbnVlOw0KPiAtCQlp
ZiAoc3RhdHVzLnUudmlycSA9PSB2aXJxICYmIHN0YXR1cy52Y3B1ID09IHhlbl92Y3B1X25y
KGNwdSkpIHsNCj4gKwkJaWYgKHN0YXR1cy51LnZpcnEgIT0gdmlycSkNCj4gKwkJCWNvbnRp
bnVlOw0KPiArCQlpZiAoc3RhdHVzLnZjcHUgPT0geGVuX3ZjcHVfbnIoY3B1KSkgew0KPiAg
IAkJCSpldnRjaG4gPSBwb3J0Ow0KPiAgIAkJCXJldHVybiAwOw0KPiArCQl9IGVsc2UgaWYg
KCFwZXJjcHUpIHsNCj4gKwkJCWV4aXN0cyA9IHRydWU7DQo+ICAgCQl9DQo+ICAgCX0NCj4g
LQlyZXR1cm4gLUVOT0VOVDsNCj4gKwlyZXR1cm4gZXhpc3RzID8gLUVFWElTVCA6IC1FTk9F
TlQ7DQo+ICAgfQ0KPiAgIA0KPiAgIC8qKg0KPiBAQCAtMTM4MSw4ICsxMzg3LDkgQEAgaW50
IGJpbmRfdmlycV90b19pcnEodW5zaWduZWQgaW50IHZpcnEsIHVuc2lnbmVkIGludCBjcHUs
IGJvb2wgcGVyY3B1KQ0KPiAgIAkJCWV2dGNobiA9IGJpbmRfdmlycS5wb3J0Ow0KPiAgIAkJ
ZWxzZSB7DQo+ICAgCQkJaWYgKHJldCA9PSAtRUVYSVNUKQ0KPiAtCQkJCXJldCA9IGZpbmRf
dmlycSh2aXJxLCBjcHUsICZldnRjaG4pOw0KPiAtCQkJQlVHX09OKHJldCA8IDApOw0KPiAr
CQkJCXJldCA9IGZpbmRfdmlycSh2aXJxLCBjcHUsICZldnRjaG4sIHBlcmNwdSk7DQo+ICsJ
CQlpZiAocmV0KQ0KPiArCQkJCWdvdG8gb3V0Ow0KDQpJIHRoaW5rIHlvdSBhcmUgbGVha2lu
ZyBpbmZvIGhlcmUuIEkgZ3Vlc3MgYSBjYWxsIG9mIF9fdW5iaW5kX2Zyb21faXJxKCkgaXMN
CndhbnRlZCBsaWtlIGluIHRoZSBlcnJvciBjYXNlIGJlbG93IChub3RlIHRoYXQgdGhlIGNh
c2Ugb2Ygbm8gdmFsaWQgZXZ0Y2huIGlzDQpoYW5kbGVkIHRoZXJlIGp1c3QgZmluZSkuDQoN
Cg0KSnVlcmdlbg0K
--------------lcecfKkKjQpW638uz1722be8
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------lcecfKkKjQpW638uz1722be8--

--------------0ny5680ISBnZo4aAVwoi2CT4--

--------------yVAY1BcNylNoOBfWz0aii7DJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmivInAFAwAAAAAACgkQsN6d1ii/Ey9u
nQf/d2Dv3yKWrLHyL84Dft14w1Ylc/XDu3j8B2EBCbORfuQGnulpJHpA3Bf/C67kluGYPk4U3SvT
GWs7HyWg6xQB73aG9pw4No4UbvNdWrFR9YHYPZ57D4icpbMyb0e0xREjeDT5FogUXUL0Y6NUnH+R
qR37bGsxlvLkCQ6FPMs73UJiSWZgRL7hy1KkC9FSiQnTkrI1/Ju7dtyD8boYs6Pzhj5yLQjpm78V
Ev6HA8Zeoe0VDvhbX1o6/0WjeCtWKYE4GRHEUnCGoNRzN422HR6jj38iOuVmRARrMKI/n2Br18it
NjMp+X/TIiAgeIXxz506MnbPv77aD8aZwSVBx/3d5w==
=ygjV
-----END PGP SIGNATURE-----

--------------yVAY1BcNylNoOBfWz0aii7DJ--

