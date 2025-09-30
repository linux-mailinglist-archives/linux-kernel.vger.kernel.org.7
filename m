Return-Path: <linux-kernel+bounces-837313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62FBABF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3251921C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7B2F362B;
	Tue, 30 Sep 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IlPOPDkD"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4224167A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219465; cv=none; b=kuTUNWy1hPEV9ioMJWuVcq+Kd9vp+6TITL5Fevc372jin5tPahBlI6tOFq9FpJdjDtQ6Y362URF+uWpLwIYz3nGynOdfjXUtyRPhYPOAOp2uby0gGkOa2iF3QnmoRw4ipcQw7IZXu4ZJFAF1fmW1r5YL0dEfpN5+LfBXSj+bLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219465; c=relaxed/simple;
	bh=20W55ywDhk1lYvwC8SBr+Gv+ZxnGVW51cUiUU6k7I9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=px8zDg5jr/Woa6Fr3NiPtSMjDliq6tGwh+mYwTHkHsibrgMwtnjUGlNjncqQMwdWoXvJRoqYvijmTOzRQL3dVinc3mTHASphgjoIPJsB0gOwRQmJr09Bf3MZ7JmGIOxSyH0/LF+8QLrKZ4AkGNJ20izsY9goy4exwoJJqTzxOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IlPOPDkD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3da3b34950so374559566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759219461; x=1759824261; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20W55ywDhk1lYvwC8SBr+Gv+ZxnGVW51cUiUU6k7I9Q=;
        b=IlPOPDkDWoK2N3XH9W1suEoeiA7iVtIrimCCHeBpFhu9YaPiCBJ3IKZHxNYGl7DGm9
         jUq91nNZLNM+H/fNjPwfUvEOBlZWxIt5Htv8WP/a6TRQe6hp4G1LPPm3C2jTkfhPNhzU
         38DGx0Hhy6OGgAKVdAZo+Ecuq0d8lLaXMgZZvrKUsuZUIc+XwBpsNNai1+IyOlseXFYo
         xsfcP19W9fa+Ev27pjn6BGWCNam0AzN11CwHSv/wkMYwCX5BIAdHcvwbtbI9n47pCN+a
         783TNJ3pwVktX+V0q7vnHEkuV+hR/OFq7x+VZ8OisaBppmqQYBDlwlv+AZmab9PI6FKC
         LyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759219461; x=1759824261;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20W55ywDhk1lYvwC8SBr+Gv+ZxnGVW51cUiUU6k7I9Q=;
        b=dJe+XEEPbTF4TT+/SrNvivbDYdhwkHsyD7rOw4BGlqNm5F8hZQODT9Oc+rVyPxt7j1
         Itrus5e6LT/FYvyn2Sb4QGW6p+3zNiT97fugi4scUXG7tIJksHIzSo4BDFQpyWNqMiMd
         hFRYUM03btZeS70Y3bJAtxqMrE427E/3Nd6feF6swlT92rV6qfCkIcikpDpRyHDamWHt
         ZmX08kZBdXjCCej/OkAkkiFepcewbz2AfNzUJ6fyD3kiB89HVZjwZZ3zCMFt9Rs4KxFP
         cRnbcbSjoJA2UBzR8Z2beZdxDR/K/v/2825agwoJ1WVR1EuLDH82Pn4SyKg18w6aEOSH
         r7KQ==
X-Gm-Message-State: AOJu0YxDxRQD1q/0NryEAglOuiq/0ABdUoJZ44kYkwgaf5l3Rh2rp0Xk
	z5vA8vYLGUEqDKrZpup3nUunPHK+qtEmW4VW+AX2lmZS+UnW2Ug+cZW4zpJS08dhGP4=
X-Gm-Gg: ASbGnct9BEjrAtsScSUBY9w6e9cffnNSRp5scLE7oiJAfo1BC0ZX4Udi9yBnliYn4RU
	pSzpIPNl8kFsWz9bWhwE9b6LYzrHj1LALAbTYIQhOitj7xM/nPlV9z7hkjycQEI5mHoUtjqwE9T
	9Z7hCqV1fUSsA7CKe5R9Z+dIhLpsgw3Jo7r4ta8o5hmaxuaUAy1XxRUf9f04RAhsIsCbqHLYQjJ
	GnntKW6JON3Fn6TwBsIzpsRqAkd+Vx6k1RrQodBrUL/jAoi7mdzGhgweSRxbiym6e3s3uGNHiTD
	vELvvnpZerEGh5WdGaZzqueeofV3dENXD5SWNLeFZck8KvATUvnX77TCwcxSeWbXQk6iXCtVFcC
	eeg/axfY80kQvUBagRWwXSHO2Vzw5w9mw8WcqfNHq4Yl374o+6s/PY9hJvSaI4aoYWGiB7N4V47
	Vq1qa+L4haILokSI5fcDMaS+NJ3PJSTqM4rsIkTH1bBpa5oRbkGhbaElqzz6XqFsy5Z0LAyArgT
	jcEHio=
X-Google-Smtp-Source: AGHT+IEgcc4O8dVT3gESBFgWkrr1wioROhaJ5vuhxYMggI6t/XYJd3uiLJ3To442+EvbpifA8ey3Ng==
X-Received: by 2002:a17:907:1c10:b0:b04:c373:2833 with SMTP id a640c23a62f3a-b34ba450e37mr2109050466b.32.1759219461214;
        Tue, 30 Sep 2025 01:04:21 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fca1sm302778766b.101.2025.09.30.01.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:04:20 -0700 (PDT)
Message-ID: <c59c9724-ee35-45bf-a368-a440b45750c5@suse.com>
Date: Tue, 30 Sep 2025 10:04:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/alternative: Patch a single alternative location
 only once
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20250929112947.27267-1-jgross@suse.com>
 <20250929112947.27267-4-jgross@suse.com>
 <20250930072643.GF3245006@noisy.programming.kicks-ass.net>
 <bd595b07-5f00-420f-8bc0-4009237d040c@suse.com>
 <20250930073910.GH4067720@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250930073910.GH4067720@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Hoqd5gE0ylo4rUMPWB0uAxRU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Hoqd5gE0ylo4rUMPWB0uAxRU
Content-Type: multipart/mixed; boundary="------------YkRApAghdKu02bsmVcRCdDV7";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c59c9724-ee35-45bf-a368-a440b45750c5@suse.com>
Subject: Re: [PATCH 3/3] x86/alternative: Patch a single alternative location
 only once
References: <20250929112947.27267-1-jgross@suse.com>
 <20250929112947.27267-4-jgross@suse.com>
 <20250930072643.GF3245006@noisy.programming.kicks-ass.net>
 <bd595b07-5f00-420f-8bc0-4009237d040c@suse.com>
 <20250930073910.GH4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930073910.GH4067720@noisy.programming.kicks-ass.net>

--------------YkRApAghdKu02bsmVcRCdDV7
Content-Type: multipart/mixed; boundary="------------W7bf6OImBzxqJlHk00Pg4CC7"

--------------W7bf6OImBzxqJlHk00Pg4CC7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMDk6MzksIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAzMCwgMjAyNSBhdCAwOTozMzoyNUFNICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
Pj4gT24gMzAuMDkuMjUgMDk6MjYsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiANCj4+Pj4g
QEAgLTY5MiwxNCArNjk4LDE5IEBAIHZvaWQgX19pbml0X29yX21vZHVsZSBub2lubGluZSBh
cHBseV9hbHRlcm5hdGl2ZXMoc3RydWN0IGFsdF9pbnN0ciAqc3RhcnQsDQo+Pj4+ICAgIAkJ
ICogLSBmZWF0dXJlIG5vdCBwcmVzZW50IGJ1dCBBTFRfRkxBR19OT1QgaXMgc2V0IHRvIG1l
YW4sDQo+Pj4+ICAgIAkJICogICBwYXRjaCBpZiBmZWF0dXJlIGlzICpOT1QqIHByZXNlbnQu
DQo+Pj4+ICAgIAkJICovDQo+Pj4+IC0JCWlmICghYm9vdF9jcHVfaGFzKGEtPmNwdWlkKSA9
PSAhKGEtPmZsYWdzICYgQUxUX0ZMQUdfTk9UKSkgew0KPj4+PiAtCQkJbWVtY3B5KGluc25f
YnVmZiwgaW5zdHIsIGEtPmluc3RybGVuKTsNCj4+Pj4gLQkJCW9wdGltaXplX25vcHMoaW5z
dHIsIGluc25fYnVmZiwgYS0+aW5zdHJsZW4pOw0KPj4+PiAtCQl9IGVsc2Ugew0KPj4+PiAr
CQlpZiAoIWJvb3RfY3B1X2hhcyhhLT5jcHVpZCkgIT0gIShhLT5mbGFncyAmIEFMVF9GTEFH
X05PVCkpIHsNCj4+Pj4gICAgCQkJYXBwbHlfb25lX2FsdGVybmF0aXZlKGluc3RyLCBpbnNu
X2J1ZmYsIGEpOw0KPj4+PiArCQkJcGF0Y2hlZCA9IHRydWU7DQo+Pj4+ICAgIAkJfQ0KPj4+
PiAtCQl0ZXh0X3Bva2VfZWFybHkoaW5zdHIsIGluc25fYnVmZiwgYS0+aW5zdHJsZW4pOw0K
Pj4+PiArCQlpbnN0YW5jZXMtLTsNCj4+Pj4gKwkJaWYgKCFpbnN0YW5jZXMpIHsNCj4+Pj4g
KwkJCWlmICghcGF0Y2hlZCkgew0KPj4+PiArCQkJCW1lbWNweShpbnNuX2J1ZmYsIGluc3Ry
LCBhLT5pbnN0cmxlbik7DQo+Pj4+ICsJCQkJb3B0aW1pemVfbm9wcyhpbnN0ciwgaW5zbl9i
dWZmLCBhLT5pbnN0cmxlbik7DQo+Pj4+ICsJCQl9DQo+Pj4+ICsJCQl0ZXh0X3Bva2VfZWFy
bHkoaW5zdHIsIGluc25fYnVmZiwgYS0+aW5zdHJsZW4pOw0KPj4+PiArCQl9DQo+Pj4+ICAg
IAl9DQo+Pj4+ICAgIAlrYXNhbl9lbmFibGVfY3VycmVudCgpOw0KPj4+DQo+Pj4gSSB0aGlu
ayB5b3UgbG9zdCB0aGUgb3B0aW1pemVfbm9wcygpIGNhbGwgZm9yIHRoZSBwYXRjaGVkIGNh
c2UuDQo+Pj4NCj4+PiBUaGF0IGlzLCBub3RlIGhvdyBhcHBseV9vbmVfYWx0ZXJuYXRpdmUo
KSBkb2VzIDB4OTAgcGFkZGluZywgYnV0IHRoZW4NCj4+PiB5b3Ugb25seSBkbyBvcHRpbWl6
ZV9ub3BzKCkgd2hlbiAhcGF0Y2hlZC4NCj4+DQo+PiBUaGUgY2FsbCBvZiBvcHRpbWl6ZV9u
b3BzKCkgaXMgcGFydCBvZiB0ZXh0X3Bva2VfYXBwbHlfcmVsb2NhdGlvbigpIHdoZW4NCj4+
IHBhdGNoaW5nLCBsaWtlIHdpdGhvdXQgbXkgc2VyaWVzLg0KPiANCj4gSW5kZWVkIGl0IGlz
LiBDbGVhcmx5IEkgbmVlZCBtb3JlIHdha2V1cCBqdWljZSA6LSkNCj4gDQo+IFRoZXJlZm9y
ZSB0aGUgcGF0Y2hlcyBzZWVtIGZpbmUuIEknbGwgdHJ5IGFuZCBob2xkIG9udG8gdGhlbSB1
bnRpbCB0aGUNCj4gbWVyZ2Ugd2luZG93IGNsb3NlcyBhbmQgdGhlbiBzdGljayB0aGVtIGlu
IHg4Ni9jb3JlIG9yIHRoZXJlYWJvdXQuDQoNClRoYW5rcy4NCg0KDQpKdWVyZ2VuDQo=
--------------W7bf6OImBzxqJlHk00Pg4CC7
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------W7bf6OImBzxqJlHk00Pg4CC7--

--------------YkRApAghdKu02bsmVcRCdDV7--

--------------Hoqd5gE0ylo4rUMPWB0uAxRU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjbjwQFAwAAAAAACgkQsN6d1ii/Ey89
zgf+KUASRm7dSDTQ7lpqJJ7Dyyk3i5Vyt56u5ZnIC0NZn+Gfzr/8tZuhCAWzL81shah6ZKUPPLYU
cxtYWcxQRaPwPfd9mcdn0hpgF/CGmSA6CFG38wel/DqwZLXq7xpAgSWftnWQvkpdlDIxELEB+LNB
VDATlFoAx9qgMgrSMWYNNYKvb7Ku0vpPDCi/zV6lX7maXvoPsS+avMcxLLdw6cdJ2LuAiKwvyUD0
Valk+t2VQNkgSCdy8la01ChG6tRUWD9/uHI8TZprDJ1zLvz6OCuVxeaWtSFRJsQTrbJRcF0eKi1A
9J0f73fKnVn2z1RnEIw1I4SKerNF+rKIL5y8ZKT18Q==
=7b7p
-----END PGP SIGNATURE-----

--------------Hoqd5gE0ylo4rUMPWB0uAxRU--

