Return-Path: <linux-kernel+bounces-722805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6AAFDF30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8914B1BC1573
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725826A0E0;
	Wed,  9 Jul 2025 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S5XQUmaT"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD026A0AF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038592; cv=none; b=qTUpwv3yznubh/GG5XO+l2JtYV58egMpavE5EF9B8Wo7exBPg3lOUzeZk7PkmsFmYffRdnu1ciH67eTWng27B9ahHCUacFXTpTW7w5DxO3eU9jjCTLjX6dB3wQQQ1igTgSwvY+B6toQSXAKSs6MHqzKPtPpij4jdPgwianT90pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038592; c=relaxed/simple;
	bh=y6bo6jTBQUZUZij4pFk2/IgHoc0uEVi8AYBcjlGqR1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/Q/aOFLwzXf5Mhx/hNadUSe0iGC7RhQgfciMvjEOo39JqqwpRJMpuJyexdZPX82cvR1Q/Fcb5zPtBxlu9ZTqfKfvhf3jWH0DWzhK4kbL5Nwt8Wi/X5OV+0YMQEwy/9f5RR0IiwqwqHZpTtem+M0n+TXRnzSMC/3xFKvttRg/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S5XQUmaT; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so905880066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 22:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752038589; x=1752643389; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6bo6jTBQUZUZij4pFk2/IgHoc0uEVi8AYBcjlGqR1E=;
        b=S5XQUmaTOMhymRPrN1GS+2wV0zb0GZcliuLXuPbq6w7GjVILojtulYuNetrFEtcfvt
         SL1AJghXnLzHmXPwkGt3HWVJpQL0jESyXmskmJIXU9ndAU3Nf4Z50IZ9PMq4Jkh9kSlD
         06NJHe30x+djGxcR+DxpMfRBCq0ZrFFs471bVqJFNv2f+ntzaGq0U/jCVNAFBN6c8iDV
         qIKLw1FzlyzxPiXPbclFv07dyOGHBn6R/YuOWFxm4Na4mHuhepSJiF6pepM/+rrZpMfe
         R2ieDm5aHX5EU+xznMhUIWYEH0Al+lqLsL4nAd4UqF1aCO33joJUFv6jHyiy1Cj3OKOR
         TtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752038589; x=1752643389;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6bo6jTBQUZUZij4pFk2/IgHoc0uEVi8AYBcjlGqR1E=;
        b=vi9SLE6rAUECUSoysfcTRyfHJJWeePn/WgCNM7eA5pBHvuLqYrKFl2cKsmsO7FDROD
         9kPomX3WcTfnXU3DXunUhBdlelTV44i+fjavuc8JxQyCRWFRr9qZOz7gSAyHqueHiDbG
         a7CR/c/tJWVJeYN9nhgFzSbiKGaUPpx3xB2SEDouNsP7q1xasvUpGWMmGZJqHZ52hoVC
         1Ncw2siQGEnTWi9fHFdjv1hrC9UiUGUyQ2FIL7VsNzvq7w4k5ZOAyflEo+OsA+D8nOhC
         le2TVN11fT0Ig+gH2zks6Z1F0w2kXWY9k+a/QDN49eD7DAa2BofhpmacteUScOqYz5eq
         cm9g==
X-Gm-Message-State: AOJu0Yzj+z78oKyh0CXN3JLNUqO4s0sTctzuVR4H6jBuG7rTktFrR+M4
	8TtzLrH8vqiqs0FbdsVsg9IvlcG9ylLQRmdCovyNsXKeMnkz+HP1LAMv8zrc8t72Buc=
X-Gm-Gg: ASbGncsox7oMMFNzL0CnfqYZfN7A3fqldQ3/Xi6hHLBXTiGHc8W7qrJ81b87m7F6Dnq
	FOl3YbUN6KGP1Tx//pqDIv5ky/eAZQKBa39EA0/mH83BnCEpjTa9kR81g6XeJwBFQCnGc/lmFQj
	Q8HgrKYmEb2Z1IbicE979go7aD0c3OTVNRUC2LJywviRkwp0dZUlj1PXXCfMklwQNtv2nkNxbf6
	tXM8E/s5RPmwbI56cSq/EYC6jF6X3qJgPbvgwSLWLeVp/yz881j0MJ+gdsXxWjAUT0p/fgHnllb
	CNdmzZGuyTg/hYlixQwq38dJWGcxvFfATZhB9SM8FptVKx3ZJd2pbey6azGXkWyg6iexKwJeVrb
	KMlIMXd1FwSTMG3hfKWUoeSZfv5v/+JYNYBdAoU374eZDpFzygW4GJrqyNS1/209YM9As2m2b4Z
	WO/rOWOhBgjQaWc/QlwLo=
X-Google-Smtp-Source: AGHT+IEL1ciZDIadEiOnNaY3zATlwR5PH9VdDZRQ69lXbCIhVNHxXVP0Yk9/kdt1hktjREAdXoW8Pg==
X-Received: by 2002:a17:907:6e9f:b0:ae3:ce75:afd8 with SMTP id a640c23a62f3a-ae6cf78cbdemr98427966b.30.1752038588598;
        Tue, 08 Jul 2025 22:23:08 -0700 (PDT)
Received: from ?IPV6:2003:e5:8709:f00:6357:915b:11f9:6d20? (p200300e587090f006357915b11f96d20.dip0.t-ipconnect.de. [2003:e5:8709:f00:6357:915b:11f9:6d20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b03203sm1018414566b.131.2025.07.08.22.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 22:23:08 -0700 (PDT)
Message-ID: <287f6b7e-069e-4a79-b72a-ae11be4c235f@suse.com>
Date: Wed, 9 Jul 2025 07:23:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/gntdev: remove struct gntdev_copy_batch from stack
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 xen-devel@lists.xenproject.org, Abinash Singh <abinashsinghlalotra@gmail.com>
References: <20250703073259.17356-1-jgross@suse.com>
 <alpine.DEB.2.22.394.2507081150230.605088@ubuntu-linux-20-04-desktop>
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
In-Reply-To: <alpine.DEB.2.22.394.2507081150230.605088@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6N4e3vytxwGdIuo0Bs0tiwNj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6N4e3vytxwGdIuo0Bs0tiwNj
Content-Type: multipart/mixed; boundary="------------yNRAhQ00pt0J0yxQqc1Nhv2I";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 xen-devel@lists.xenproject.org, Abinash Singh <abinashsinghlalotra@gmail.com>
Message-ID: <287f6b7e-069e-4a79-b72a-ae11be4c235f@suse.com>
Subject: Re: [PATCH] xen/gntdev: remove struct gntdev_copy_batch from stack
References: <20250703073259.17356-1-jgross@suse.com>
 <alpine.DEB.2.22.394.2507081150230.605088@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2507081150230.605088@ubuntu-linux-20-04-desktop>

--------------yNRAhQ00pt0J0yxQqc1Nhv2I
Content-Type: multipart/mixed; boundary="------------CYRylcUoVD0qj02p6wFAPnxP"

--------------CYRylcUoVD0qj02p6wFAPnxP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMDcuMjUgMjE6MDEsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVGh1
LCAzIEp1bCAyMDI1LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gV2hlbiBjb21waWxpbmcg
dGhlIGtlcm5lbCB3aXRoIExMVk0sIHRoZSBmb2xsb3dpbmcgd2FybmluZyB3YXMgaXNzdWVk
Og0KPj4NCj4+ICAgIGRyaXZlcnMveGVuL2dudGRldi5jOjk5MTogd2FybmluZzogc3RhY2sg
ZnJhbWUgc2l6ZSAoMTE2MCkgZXhjZWVkcw0KPj4gICAgbGltaXQgKDEwMjQpIGluIGZ1bmN0
aW9uICdnbnRkZXZfaW9jdGwnDQo+Pg0KPj4gVGhlIG1haW4gcmVhc29uIGlzIHN0cnVjdCBn
bnRkZXZfY29weV9iYXRjaCB3aGljaCBpcyBsb2NhdGVkIG9uIHRoZQ0KPj4gc3RhY2sgYW5k
IGhhcyBhIHNpemUgb2YgbmVhcmx5IDFrYi4NCj4+DQo+PiBGb3IgcGVyZm9ybWFuY2UgcmVh
c29ucyBpdCBzaG91bGRuJ3QgYnkganVzdCBkeW5hbWljYWxseSBhbGxvY2F0ZWQNCj4+IGlu
c3RlYWQsIHNvIGFsbG9jYXRlIGEgbmV3IGluc3RhbmNlIHdoZW4gbmVlZGVkIGFuZCBpbnN0
ZWFkIG9mIGZyZWVpbmcNCj4+IGl0IHB1dCBpdCBpbnRvIGEgbGlzdCBvZiBmcmVlIHN0cnVj
dHMgYW5jaG9yZWQgaW4gc3RydWN0IGdudGRldl9wcml2Lg0KPj4NCj4+IEZpeGVzOiBhNGNk
YjU1NmNhZTAgKCJ4ZW4vZ250ZGV2OiBhZGQgaW9jdGwgZm9yIGdyYW50IGNvcHkiKQ0KPj4g
UmVwb3J0ZWQtYnk6IEFiaW5hc2ggU2luZ2ggPGFiaW5hc2hzaW5naGxhbG90cmFAZ21haWwu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMveGVuL2dudGRldi1jb21tb24uaCB8ICA0ICsrKw0K
Pj4gICBkcml2ZXJzL3hlbi9nbnRkZXYuYyAgICAgICAgfCA3MSArKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0
aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
eGVuL2dudGRldi1jb21tb24uaCBiL2RyaXZlcnMveGVuL2dudGRldi1jb21tb24uaA0KPj4g
aW5kZXggOWMyODZiMmExOTAwLi5hYzhjZTMxNzliYTIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL3hlbi9nbnRkZXYtY29tbW9uLmgNCj4+ICsrKyBiL2RyaXZlcnMveGVuL2dudGRldi1j
b21tb24uaA0KPj4gQEAgLTI2LDYgKzI2LDEwIEBAIHN0cnVjdCBnbnRkZXZfcHJpdiB7DQo+
PiAgIAkvKiBsb2NrIHByb3RlY3RzIG1hcHMgYW5kIGZyZWVhYmxlX21hcHMuICovDQo+PiAg
IAlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4+ICAgDQo+PiArCS8qIEZyZWUgaW5zdGFuY2VzIG9m
IHN0cnVjdCBnbnRkZXZfY29weV9iYXRjaC4gKi8NCj4+ICsJc3RydWN0IGdudGRldl9jb3B5
X2JhdGNoICpiYXRjaDsNCj4+ICsJc3RydWN0IG11dGV4IGJhdGNoX2xvY2s7DQo+PiArDQo+
PiAgICNpZmRlZiBDT05GSUdfWEVOX0dSQU5UX0RNQV9BTExPQw0KPj4gICAJLyogRGV2aWNl
IGZvciB3aGljaCBETUEgbWVtb3J5IGlzIGFsbG9jYXRlZC4gKi8NCj4+ICAgCXN0cnVjdCBk
ZXZpY2UgKmRtYV9kZXY7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZ250ZGV2LmMg
Yi9kcml2ZXJzL3hlbi9nbnRkZXYuYw0KPj4gaW5kZXggNjFmYWVhMWYwNjYzLi4xZjIxNjA3
NjU2MTggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3hlbi9nbnRkZXYuYw0KPj4gKysrIGIv
ZHJpdmVycy94ZW4vZ250ZGV2LmMNCj4+IEBAIC01Niw2ICs1NiwxOCBAQCBNT0RVTEVfQVVU
SE9SKCJEZXJlayBHLiBNdXJyYXkgPERlcmVrLk11cnJheUBjbC5jYW0uYWMudWs+LCAiDQo+
PiAgIAkgICAgICAiR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+Iik7DQo+PiAg
IE1PRFVMRV9ERVNDUklQVElPTigiVXNlci1zcGFjZSBncmFudGVkIHBhZ2UgYWNjZXNzIGRy
aXZlciIpOw0KPj4gICANCj4+ICsjZGVmaW5lIEdOVERFVl9DT1BZX0JBVENIIDE2DQo+PiAr
DQo+PiArc3RydWN0IGdudGRldl9jb3B5X2JhdGNoIHsNCj4+ICsJc3RydWN0IGdudHRhYl9j
b3B5IG9wc1tHTlRERVZfQ09QWV9CQVRDSF07DQo+PiArCXN0cnVjdCBwYWdlICpwYWdlc1tH
TlRERVZfQ09QWV9CQVRDSF07DQo+PiArCXMxNiBfX3VzZXIgKnN0YXR1c1tHTlRERVZfQ09Q
WV9CQVRDSF07DQo+PiArCXVuc2lnbmVkIGludCBucl9vcHM7DQo+PiArCXVuc2lnbmVkIGlu
dCBucl9wYWdlczsNCj4+ICsJYm9vbCB3cml0ZWFibGU7DQo+PiArCXN0cnVjdCBnbnRkZXZf
Y29weV9iYXRjaCAqbmV4dDsNCj4+ICt9Ow0KPj4gKw0KPj4gICBzdGF0aWMgdW5zaWduZWQg
aW50IGxpbWl0ID0gNjQqMTAyNDsNCj4+ICAgbW9kdWxlX3BhcmFtKGxpbWl0LCB1aW50LCAw
NjQ0KTsNCj4+ICAgTU9EVUxFX1BBUk1fREVTQyhsaW1pdCwNCj4+IEBAIC01ODQsNiArNTk2
LDggQEAgc3RhdGljIGludCBnbnRkZXZfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgZmlsZSAqZmxpcCkNCj4+ICAgCUlOSVRfTElTVF9IRUFEKCZwcml2LT5tYXBzKTsNCj4+
ICAgCW11dGV4X2luaXQoJnByaXYtPmxvY2spOw0KPj4gICANCj4+ICsJbXV0ZXhfaW5pdCgm
cHJpdi0+YmF0Y2hfbG9jayk7DQo+PiArDQo+PiAgICNpZmRlZiBDT05GSUdfWEVOX0dOVERF
Vl9ETUFCVUYNCj4+ICAgCXByaXYtPmRtYWJ1Zl9wcml2ID0gZ250ZGV2X2RtYWJ1Zl9pbml0
KGZsaXApOw0KPj4gICAJaWYgKElTX0VSUihwcml2LT5kbWFidWZfcHJpdikpIHsNCj4+IEBA
IC02MDgsNiArNjIyLDcgQEAgc3RhdGljIGludCBnbnRkZXZfcmVsZWFzZShzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmxpcCkNCj4+ICAgew0KPj4gICAJc3RydWN0IGdu
dGRldl9wcml2ICpwcml2ID0gZmxpcC0+cHJpdmF0ZV9kYXRhOw0KPj4gICAJc3RydWN0IGdu
dGRldl9ncmFudF9tYXAgKm1hcDsNCj4+ICsJc3RydWN0IGdudGRldl9jb3B5X2JhdGNoICpi
YXRjaDsNCj4+ICAgDQo+PiAgIAlwcl9kZWJ1ZygicHJpdiAlcFxuIiwgcHJpdik7DQo+PiAg
IA0KPj4gQEAgLTYyMCw2ICs2MzUsMTQgQEAgc3RhdGljIGludCBnbnRkZXZfcmVsZWFzZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmxpcCkNCj4+ICAgCX0NCj4+ICAg
CW11dGV4X3VubG9jaygmcHJpdi0+bG9jayk7DQo+PiAgIA0KPj4gKwltdXRleF9sb2NrKCZw
cml2LT5iYXRjaF9sb2NrKTsNCj4+ICsJd2hpbGUgKHByaXYtPmJhdGNoKSB7DQo+PiArCQli
YXRjaCA9IHByaXYtPmJhdGNoOw0KPj4gKwkJcHJpdi0+YmF0Y2ggPSBiYXRjaC0+bmV4dDsN
Cj4+ICsJCWtmcmVlKGJhdGNoKTsNCj4+ICsJfQ0KPj4gKwltdXRleF91bmxvY2soJnByaXYt
PmJhdGNoX2xvY2spOw0KPj4gKw0KPj4gICAjaWZkZWYgQ09ORklHX1hFTl9HTlRERVZfRE1B
QlVGDQo+PiAgIAlnbnRkZXZfZG1hYnVmX2ZpbmkocHJpdi0+ZG1hYnVmX3ByaXYpOw0KPj4g
ICAjZW5kaWYNCj4+IEBAIC03ODUsMTcgKzgwOCw2IEBAIHN0YXRpYyBsb25nIGdudGRldl9p
b2N0bF9ub3RpZnkoc3RydWN0IGdudGRldl9wcml2ICpwcml2LCB2b2lkIF9fdXNlciAqdSkN
Cj4+ICAgCXJldHVybiByYzsNCj4+ICAgfQ0KPj4gICANCj4+IC0jZGVmaW5lIEdOVERFVl9D
T1BZX0JBVENIIDE2DQo+PiAtDQo+PiAtc3RydWN0IGdudGRldl9jb3B5X2JhdGNoIHsNCj4+
IC0Jc3RydWN0IGdudHRhYl9jb3B5IG9wc1tHTlRERVZfQ09QWV9CQVRDSF07DQo+PiAtCXN0
cnVjdCBwYWdlICpwYWdlc1tHTlRERVZfQ09QWV9CQVRDSF07DQo+PiAtCXMxNiBfX3VzZXIg
KnN0YXR1c1tHTlRERVZfQ09QWV9CQVRDSF07DQo+PiAtCXVuc2lnbmVkIGludCBucl9vcHM7
DQo+PiAtCXVuc2lnbmVkIGludCBucl9wYWdlczsNCj4+IC0JYm9vbCB3cml0ZWFibGU7DQo+
PiAtfTsNCj4+IC0NCj4+ICAgc3RhdGljIGludCBnbnRkZXZfZ2V0X3BhZ2Uoc3RydWN0IGdu
dGRldl9jb3B5X2JhdGNoICpiYXRjaCwgdm9pZCBfX3VzZXIgKnZpcnQsDQo+PiAgIAkJCQl1
bnNpZ25lZCBsb25nICpnZm4pDQo+PiAgIHsNCj4+IEBAIC05NTMsMzYgKzk2NSw1MyBAQCBz
dGF0aWMgaW50IGdudGRldl9ncmFudF9jb3B5X3NlZyhzdHJ1Y3QgZ250ZGV2X2NvcHlfYmF0
Y2ggKmJhdGNoLA0KPj4gICBzdGF0aWMgbG9uZyBnbnRkZXZfaW9jdGxfZ3JhbnRfY29weShz
dHJ1Y3QgZ250ZGV2X3ByaXYgKnByaXYsIHZvaWQgX191c2VyICp1KQ0KPj4gICB7DQo+PiAg
IAlzdHJ1Y3QgaW9jdGxfZ250ZGV2X2dyYW50X2NvcHkgY29weTsNCj4+IC0Jc3RydWN0IGdu
dGRldl9jb3B5X2JhdGNoIGJhdGNoOw0KPj4gKwlzdHJ1Y3QgZ250ZGV2X2NvcHlfYmF0Y2gg
KmJhdGNoOw0KPj4gICAJdW5zaWduZWQgaW50IGk7DQo+PiAgIAlpbnQgcmV0ID0gMDsNCj4+
ICAgDQo+PiAgIAlpZiAoY29weV9mcm9tX3VzZXIoJmNvcHksIHUsIHNpemVvZihjb3B5KSkp
DQo+PiAgIAkJcmV0dXJuIC1FRkFVTFQ7DQo+PiAgIA0KPj4gLQliYXRjaC5ucl9vcHMgPSAw
Ow0KPj4gLQliYXRjaC5ucl9wYWdlcyA9IDA7DQo+PiArCW11dGV4X2xvY2soJnByaXYtPmJh
dGNoX2xvY2spOw0KPj4gKwlpZiAoIXByaXYtPmJhdGNoKSB7DQo+PiArCQliYXRjaCA9IGtt
YWxsb2Moc2l6ZW9mKCpiYXRjaCksIEdGUF9LRVJORUwpOw0KPj4gKwl9IGVsc2Ugew0KPj4g
KwkJYmF0Y2ggPSBwcml2LT5iYXRjaDsNCj4+ICsJCXByaXYtPmJhdGNoID0gYmF0Y2gtPm5l
eHQ7DQo+PiArCX0NCj4+ICsJbXV0ZXhfdW5sb2NrKCZwcml2LT5iYXRjaF9sb2NrKTsNCj4g
DQo+IEkgYW0gY29uY2VybmVkIGFib3V0IHRoZSBwb3RlbnRpYWxseSB1bmJvdW5kZWQgYW1v
dW50IG9mIG1lbW9yeSB0aGF0DQo+IGNvdWxkIGJlIGFsbG9jYXRlZCB0aGlzIHdheS4NCg0K
VW5ib3VuZGVkPyBJdCBjYW4gYmUgYXQgbW9zdCB0aGUgbnVtYmVyIG9mIHRocmVhZHMgdXNp
bmcgdGhlIGludGVyZmFjZQ0KY29uY3VycmVudGx5Lg0KDQo+IFRoZSBtdXRleCBpcyBhbHJl
YWR5IGEgcG90ZW50aWFsbHkgdmVyeSBzbG93IG9wZXJhdGlvbi4gQ291bGQgd2UgaW5zdGVh
ZA0KPiBhbGxvY2F0ZSBhIHNpbmdsZSBiYXRjaCwgYW5kIGlmIGl0IGlzIGN1cnJlbnRseSBp
biB1c2UsIHVzZSB0aGUgbXV0ZXggdG8NCj4gd2FpdCB1bnRpbCBpdCBiZWNvbWVzIGF2YWls
YWJsZT8NCg0KQXMgdGhpcyBpbnRlcmZhY2UgaXMgZS5nLiB1c2VkIGJ5IHRoZSBxZW11IGJh
c2VkIHFkaXNrIGJhY2tlbmQsIHRoZSBjaGFuY2VzDQphcmUgdmVyeSBoaWdoIHRoYXQgdGhl
cmUgYXJlIGNvbmN1cnJlbnQgdXNlcnMuIFRoaXMgd291bGQgaHVydCBtdWx0aS1yaW5nDQpx
ZGlzayBxdWl0ZSBiYWRseSENCg0KSXQgd291bGQgYmUgcG9zc2libGUgdG8gcmVwbGFjZSB0
aGUgbXV0ZXggd2l0aCBhIHNwaW5sb2NrIGFuZCBkbyB0aGUga21hbGxvYygpDQpvdXRzaWRl
IHRoZSBsb2NrZWQgcmVnaW9uLg0KDQo+IA0KPiBJIGFtIGFsc28gT0sgd2l0aCB0aGUgY3Vy
cmVudCBhcHByb2FjaCBidXQgSSB0aG91Z2h0IEkgd291bGQgYXNrLg0KPiANCj4gDQo+IA0K
PiANCj4+ICsJaWYgKCFiYXRjaCkNCj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4g
KwliYXRjaC0+bnJfb3BzID0gMDsNCj4+ICsJYmF0Y2gtPm5yX3BhZ2VzID0gMDsNCj4+ICAg
DQo+PiAgIAlmb3IgKGkgPSAwOyBpIDwgY29weS5jb3VudDsgaSsrKSB7DQo+PiAgIAkJc3Ry
dWN0IGdudGRldl9ncmFudF9jb3B5X3NlZ21lbnQgc2VnOw0KPj4gICANCj4+ICAgCQlpZiAo
Y29weV9mcm9tX3VzZXIoJnNlZywgJmNvcHkuc2VnbWVudHNbaV0sIHNpemVvZihzZWcpKSkg
ew0KPj4gICAJCQlyZXQgPSAtRUZBVUxUOw0KPj4gKwkJCWdudGRldl9wdXRfcGFnZXMoYmF0
Y2gpOw0KPj4gICAJCQlnb3RvIG91dDsNCj4+ICAgCQl9DQo+PiAgIA0KPj4gLQkJcmV0ID0g
Z250ZGV2X2dyYW50X2NvcHlfc2VnKCZiYXRjaCwgJnNlZywgJmNvcHkuc2VnbWVudHNbaV0u
c3RhdHVzKTsNCj4+IC0JCWlmIChyZXQgPCAwKQ0KPj4gKwkJcmV0ID0gZ250ZGV2X2dyYW50
X2NvcHlfc2VnKGJhdGNoLCAmc2VnLCAmY29weS5zZWdtZW50c1tpXS5zdGF0dXMpOw0KPj4g
KwkJaWYgKHJldCA8IDApIHsNCj4+ICsJCQlnbnRkZXZfcHV0X3BhZ2VzKGJhdGNoKTsNCj4+
ICAgCQkJZ290byBvdXQ7DQo+PiArCQl9DQo+PiAgIA0KPj4gICAJCWNvbmRfcmVzY2hlZCgp
Ow0KPj4gICAJfQ0KPj4gLQlpZiAoYmF0Y2gubnJfb3BzKQ0KPj4gLQkJcmV0ID0gZ250ZGV2
X2NvcHkoJmJhdGNoKTsNCj4+IC0JcmV0dXJuIHJldDsNCj4+ICsJaWYgKGJhdGNoLT5ucl9v
cHMpDQo+PiArCQlyZXQgPSBnbnRkZXZfY29weShiYXRjaCk7DQo+PiArDQo+PiArIG91dDoN
Cj4+ICsJbXV0ZXhfbG9jaygmcHJpdi0+YmF0Y2hfbG9jayk7DQo+PiArCWJhdGNoLT5uZXh0
ID0gcHJpdi0+YmF0Y2g7DQo+PiArCXByaXYtPmJhdGNoID0gYmF0Y2g7DQo+PiArCW11dGV4
X3VubG9jaygmcHJpdi0+YmF0Y2hfbG9jayk7DQo+PiAgIA0KPj4gLSAgb3V0Og0KPj4gLQln
bnRkZXZfcHV0X3BhZ2VzKCZiYXRjaCk7DQo+IA0KPiBPbmUgY2hhbmdlIGZyb20gYmVmb3Jl
IGlzIHRoYXQgaW4gY2FzZSBvZiBubyBlcnJvcnMsIGdudGRldl9wdXRfcGFnZXMgaXMNCj4g
bm90IGNhbGxlZCBhbnltb3JlLiBEbyB3ZSB3YW50IHRoYXQ/IFNwZWNpZmljYWxseSwgd2Ug
YXJlIG1pc3NpbmcgdGhlDQo+IGNhbGwgdG8gdW5waW5fdXNlcl9wYWdlc19kaXJ0eV9sb2Nr
DQoNCkkgZG9uJ3QgdGhpbmsgeW91IGFyZSByaWdodC4gVGhlcmUgd2FzIGEgInJldHVybiBy
ZXQiIGJlZm9yZSB0aGUgIm91dDoiDQpsYWJlbCBiZWZvcmUgbXkgcGF0Y2guDQoNCg0KSnVl
cmdlbg0K
--------------CYRylcUoVD0qj02p6wFAPnxP
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------CYRylcUoVD0qj02p6wFAPnxP--

--------------yNRAhQ00pt0J0yxQqc1Nhv2I--

--------------6N4e3vytxwGdIuo0Bs0tiwNj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmht/LsFAwAAAAAACgkQsN6d1ii/Ey9O
hQf+LRW8NcSWZaGwBSomAFRDMUUKfz6VmBeTg+J3jVEFs0cuIpEOqq5yaGAnLZv4oUlMsxBnsEEc
DCKNHcRwC5P86TZeqt1aiQGDpMP1HO9nXs9e7On/YGdi3E9XL9qxGOddNjfjMo9VEnDy2oQHj3jh
RD8I7e1HGhVTjjTnTInVtBtKyZ4kuR97+1L+PwhdkksPBWvQ/raFhn2Gbh4x6WRR+7b/NzU+LRxL
IMSBG8xSwsptJvkvaIxM15iJXJEjmZ8EnFlsYLh9RWvd5j4xGA20uzsW3Gw0LVU0/sRxRygErkBD
Kal7hhCES3gO1MuaR3ETp7eGeozHsFrjLP/3CPqLoQ==
=1482
-----END PGP SIGNATURE-----

--------------6N4e3vytxwGdIuo0Bs0tiwNj--

