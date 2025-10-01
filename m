Return-Path: <linux-kernel+bounces-838652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C2BAFD45
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8996174E76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757A2D9488;
	Wed,  1 Oct 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWk1LNaP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073302494FF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310006; cv=none; b=cu5XRWRgpeiRNoL5nXe8gtDMgAmZQXgH+Yr3cpkknHb8fiSE7ygNv+EOrg+FyRnijZe5TomPhR4XCVQ/mIz0xSst0NVwiPMVrbph1ACo0Tlvnp8rM0vlLC+IJZirJjAUmxCuXJE+5Bt05HIVmUtouZVPptjpgdarWpXY7z7+Qm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310006; c=relaxed/simple;
	bh=akruguUlMk4PCTOgTyjiWg/kpbuAfV7wGO7BxGg3Y7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZ21PgSGtc0+zFuAxBjq1DNsW0rGujjcTawCCyHnxadNxHW61hrOqSaJ5kFLJhJTzLVc9eKfnXf0UHqdCCQylg0+hr4jDwvpaPNu1sZGoJ2AQ0x+xNcmVV3Hf5UVgw6oXkJ5YI4hG10jkndRQG7n4A7ShjQqTltdO4U4bsrQtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWk1LNaP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso54435855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759310001; x=1759914801; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akruguUlMk4PCTOgTyjiWg/kpbuAfV7wGO7BxGg3Y7U=;
        b=YWk1LNaPgz3Ckqy0AM1JJW2h6v+DVimsjcc/GBxzrTctzQ/hqv0aJoMfVglTn9iZMq
         EM+EA3857bSISvm6Jz9zIBsfDaQ6+zg5gziMprIH36qGs7rormcRkbpX4jkcuw34XWNg
         GD0If2BP/tdmoaGUO3eBAmGT6oY1yvbOI/+ByqW4TqXjndLzeZxg41St7dPI4sFAmW5K
         lpmmD6rurx2kjR/p+wC2s69pdEtIO71Jv6r9Rk5akQdcnUiAuGa0RWFkyrTTtCw4OjbN
         IYralWf3qyMYvp29hWEGC0i8b1JQnyPIE728rxVkif9L1gTGF3uJP6NwRmsNvS8nrH5k
         jceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310001; x=1759914801;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akruguUlMk4PCTOgTyjiWg/kpbuAfV7wGO7BxGg3Y7U=;
        b=DnGyEoHIfpQR796dHbBkxfP9gmepThiPknafa/bOFqShrO33+GyuO6R3EuZIVppQZY
         PkKcB3ZZNspWG4+HlUJcevBQTkUbYt4cMuduizSjhRXvThu6JzyQqhhVM2SKVUHgsmiq
         UO5MjHNPJjJ4Q7A/VlEkTOkKtqVWVbljnWvC5nDx2G3HggjBdXsrZBih5FylBGMFlRB7
         5cSwOFQ/SKWm3JWVN9UI8EFsgoyyFw27HPNg2ioTNIL+8F4t7QxdDgI3QSr0fkQKM/zF
         LNT4kZKQc59ijTPwFomelr5m0c/b/4GeCLZ0QHneZFH4bA2vzekp6rMhFIcHGijm49Oe
         wf7g==
X-Gm-Message-State: AOJu0Yxr8pfVn0XottjVzu/3YBkmIMl+oikeNz4NU2Gl0UMOr7puFynP
	bynllhZ+8iiFi4a0swCx7rfp3VSPL8H61sFqLlolFGBr6yina5+Vtz8HlIf+AhYj+hA=
X-Gm-Gg: ASbGnct2sBZcEvmIV4sSF9tbs9hzh05WFBGPxho5wCMqHBhDDR3jDdvG3Zld69QKr7L
	ZB0qowW97p8011UazKNQJyFfsiAB4aGcNZl+DERn/xiAXeL3xLZyf50vrFUklylVTM8jf7d8blG
	34SiVSVnJkmvqfx01XpzOkT02FbHDjM6uOV8aNkHIvSwZAHgR22h/RU8M9MckRbSZ7xQr56Jvb9
	kjPq+HpPBgrorMbG2/mfKjtQE6TuwPHfN0sM+94fvHybI9QLrs6qNYXtRHfGpN3SAyerHQ5600J
	VYClddY5w/I5R6vYOCVKu8jqliNv7wK6UsQJ8UXliZv7Z7Uw0hY+lV5i/H4f90OdzPqeltZaqak
	koR8at9LHLAXthl2u/iS2sSKm5Vzj+cMv4Mng981jJOwlaAdQZgrR/dyD2zkwhaONRy/BeIhkHj
	Dc2xYvWMa07gT4giYxCS2KUnB7v1bVq8a2j4E3Sje61W97VqC0HDOYu2+7hdJi9fxibHRi
X-Google-Smtp-Source: AGHT+IFmWtHmtuJTY/pPssZKgyeRTwhhcwi0O9A8a4YoPc9vbgb8+dTjBI7NWy3cHtO7HmMUVCFPpA==
X-Received: by 2002:a05:600c:3150:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46e61219faamr22578695e9.11.1759310001142;
        Wed, 01 Oct 2025 02:13:21 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3b75sm29623905e9.7.2025.10.01.02.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:13:20 -0700 (PDT)
Message-ID: <fd98944e-52e4-4521-ae15-07f167b5dfbf@suse.com>
Date: Wed, 1 Oct 2025 11:13:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
 xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com> <aNv-kJbDXYJpievg@google.com>
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
In-Reply-To: <aNv-kJbDXYJpievg@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4NdA3Y0ivVEa007mP1hrOaWH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4NdA3Y0ivVEa007mP1hrOaWH
Content-Type: multipart/mixed; boundary="------------0KBQjINNJXNkhZ3AwbKqEaDf";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
 xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Message-ID: <fd98944e-52e4-4521-ae15-07f167b5dfbf@suse.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com> <aNv-kJbDXYJpievg@google.com>
In-Reply-To: <aNv-kJbDXYJpievg@google.com>

--------------0KBQjINNJXNkhZ3AwbKqEaDf
Content-Type: multipart/mixed; boundary="------------UW5EcluXxZS9wHFRe79bLUV0"

--------------UW5EcluXxZS9wHFRe79bLUV0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMTg6MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIFR1
ZSwgU2VwIDMwLCAyMDI1LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gV2hlbiBhdmFpbGFi
bGUgdXNlIG9uZSBvZiB0aGUgbm9uLXNlcmlhbGl6aW5nIFdSTVNSIHZhcmlhbnRzIChXUk1T
Uk5TDQo+PiB3aXRoIG9yIHdpdGhvdXQgYW4gaW1tZWRpYXRlIG9wZXJhbmQgc3BlY2lmeWlu
ZyB0aGUgTVNSIHJlZ2lzdGVyKSBpbg0KPj4gX193cm1zcnEoKS4NCj4+DQo+PiBGb3IgdGhl
IHNhZmUvdW5zYWZlIHZhcmlhbnRzIG1ha2UgX193cm1zcnEoKSB0byBiZSBhIGNvbW1vbiBi
YXNlDQo+PiBmdW5jdGlvbiBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nIHRoZSBBTFRFUk5BVElW
RSooKSBtYWNyb3MuIFRoaXMNCj4+IHJlcXVpcmVzIHRvIGxldCBuYXRpdmVfd3Jtc3IoKSB1
c2UgbmF0aXZlX3dybXNycSgpIGluc3RlYWQgb2YNCj4+IF9fd3Jtc3JxKCkuIFdoaWxlIGNo
YW5naW5nIHRoaXMsIGNvbnZlcnQgbmF0aXZlX3dybXNyKCkgaW50byBhbiBpbmxpbmUNCj4+
IGZ1bmN0aW9uLg0KPj4NCj4+IFJlcGxhY2UgdGhlIG9ubHkgY2FsbCBvZiB3c3Jtc3Jucygp
IHdpdGggdGhlIG5vdyBlcXVpdmFsZW50IGNhbGwgdG8NCj4+IG5hdGl2ZV93cm1zcnEoKSBh
bmQgcmVtb3ZlIHdzcm1zcm5zKCkuDQo+Pg0KPj4gVGhlIHBhcmF2aXJ0IGNhc2Ugd2lsbCBi
ZSBoYW5kbGVkIGxhdGVyLg0KPiANCj4gLi4uDQo+IA0KPj4gQEAgLTI2OCwyMSArMzU3LDYg
QEAgc3RhdGljIGlubGluZSBpbnQgd3Jtc3JxX3NhZmUodTMyIG1zciwgdTY0IHZhbCkNCj4+
ICAgCXJldHVybiBlcnI7DQo+PiAgIH0NCj4+ICAgDQo+PiAtLyogSW5zdHJ1Y3Rpb24gb3Bj
b2RlIGZvciBXUk1TUk5TIHN1cHBvcnRlZCBpbiBiaW51dGlscyA+PSAyLjQwICovDQo+PiAt
I2RlZmluZSBBU01fV1JNU1JOUyBfQVNNX0JZVEVTKDB4MGYsMHgwMSwweGM2KQ0KPj4gLQ0K
Pj4gLS8qIE5vbi1zZXJpYWxpemluZyBXUk1TUiwgd2hlbiBhdmFpbGFibGUuICBGYWxscyBi
YWNrIHRvIGEgc2VyaWFsaXppbmcgV1JNU1IuICovDQo+PiAtc3RhdGljIF9fYWx3YXlzX2lu
bGluZSB2b2lkIHdybXNybnModTMyIG1zciwgdTY0IHZhbCkNCj4gDQo+IEZZSSwgYSB1c2Ug
b2Ygd3Jtc3JucygpIGlzIGxpa2VseSBjb21pbmcgaW4gdGhyb3VnaCB0aGUgS1ZNICh4ODYp
IHRyZWUsIGNvbW1pdA0KPiA2NTM5MWZlYjA0MmIgKCJLVk06IFZNWDogQWRkIGhvc3QgTVNS
IHJlYWQvd3JpdGUgaGVscGVycyB0byBjb25zb2xpZGF0ZSBwcmVlbXB0aW9uDQo+IGhhbmRs
aW5nIikuDQoNClRoYW5rcyBmb3IgdGhlIGhlYWRzIHVwIQ0KDQo+IA0KPiBQcm9iYWJseSBt
YWtlcyBzZW5zZSB0byBzcGluIHYzIGFmdGVyIHRoZSBtZXJnZSB3aW5kb3c/ICBPciBvbiBs
aW51eC1uZXh0PyAoSQ0KPiBjYW4ndCB0ZWxsIHdoYXQgd2FzIHVzZWQgYXMgdGhlIGJhc2Us
IGFuZCBJIGRvdWJsZS1jaGVja2VkIHRoYXQgdGhlIGFib3ZlIGNvbW1pdA0KPiBpcyBpbiBs
aW51eC1uZXh0KS4NCg0KSSdsbCBmaW5kIGEgcHJvcGVyIHNvbHV0aW9uLiA6LSkNCg0KDQpK
dWVyZ2VuDQo=
--------------UW5EcluXxZS9wHFRe79bLUV0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------UW5EcluXxZS9wHFRe79bLUV0--

--------------0KBQjINNJXNkhZ3AwbKqEaDf--

--------------4NdA3Y0ivVEa007mP1hrOaWH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjc8K8FAwAAAAAACgkQsN6d1ii/Ey+W
oQf/Tlcx+hnflBEo7Nn5o7np17qk0I0N8Xr0pexu7UEQ/D0qTFOPwE93Gh85TYaljbv85+BWMWKn
dPrY/8w+EDFUMUwl1tmP1xbt0gJ+t8iyco8uWI8FYychx+Wto7SyYYRauM+B0Oh3qYCz3dw+3xJB
tOUr5YzP/IaXtnBdD6uYTdtUxvMxO9qvdRUDpsYqEspy3drDiyEcyLw07WF+V+IzSo+vDtjW6J1p
Q9vrbpgWHg6rI2CY+HL0GNIrrmjDcGL4S2EMXaY3oNz1Vvbt48aCQ8z1/Ix2LT/kYWy3WOK9dFQg
yL4QPZz18hvl7/pJ432L0lcoB8y8xow2vlLc4LkuEA==
=PUL6
-----END PGP SIGNATURE-----

--------------4NdA3Y0ivVEa007mP1hrOaWH--

