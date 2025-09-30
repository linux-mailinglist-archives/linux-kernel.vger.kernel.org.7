Return-Path: <linux-kernel+bounces-837548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E325EBAC8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966843216D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C92F83D4;
	Tue, 30 Sep 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VYw7XtKK"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBC219301
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229009; cv=none; b=RTUaGQ+oV0tXtSh82jCWcF3A4IkoSM9iFCnWH1jGpyQl7mK7SdrRcqoDMQvj6COzF5SIA3rXLTt/p2ywW4BOaZnn9mlQp4eqwzVuzJ7A/nQnXqUYLYc/5gvjj9DSliGn2LBst4BzonunnjumCxkpQTlyA/QcAK6b4+Tr8JUNwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229009; c=relaxed/simple;
	bh=RB0qYt5b5QDXjhC4b6AM5ldFgAgUmpY232wNN6bJqe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfUqGrZilTlRjeTua5r0kFiHK+TTJNGKHgeTWVb5Hht7mg1S0riulBsvecr6H8WjDWLssjuWbMM+MuWi16/mc8osKHYbn9QdVeKkcpMQIUKTl8Uxht7KVt4AHV5pOv/vfu9OIY/BapGsCMxczLE9B8w0gLEZ1tqxksrm8WeSrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VYw7XtKK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so8334858a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759229006; x=1759833806; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RB0qYt5b5QDXjhC4b6AM5ldFgAgUmpY232wNN6bJqe0=;
        b=VYw7XtKKvTFlTLUn9SKnFTeMXcXQBbXxJXiRdCf6Dl9zYWrH/elvq5Ezxmv2k/48bU
         o8f4UDkYGcxScKEqoFoweg1jfWM9WjXnZSL7XajHG1kRYRVTM/fxjE+xDbJJDDX85XWV
         VDy463spbq35zybnE4G5aT498VgHweGYKmpvB1OM44NHnl4n6i8ZcPKeordUPioBTywu
         BHZqASyvVmluHm/PBOSsNB3cDAgolXdjNWzIGcci7TKX8hqjvqbHB0yFmB3941pb+VTA
         iNZuUWrSxxWsG4+c1Qg8IPt3cWiY/Z5ko7wbbpNWCmh306eQLQXwXklPksHwGp7j4naG
         xR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229006; x=1759833806;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RB0qYt5b5QDXjhC4b6AM5ldFgAgUmpY232wNN6bJqe0=;
        b=LK6MFpkM5dca2wv0FqoV40AC867oVeH3jMj17/NwAoKXemdgeeSZ3AGsMY7pGsVYJb
         Nl16JsyVfuOjJa/OtvFjJg8vQaqeihh789i0aPJ8EIDX5xhf7nmBexefW/QyPL1tbYPn
         jv3pc02M3lgJXRFRho8b9r0RnrnlXzmvL7EMwEH131FCBGJHYEi2DH+n6tZFKo+W7eFW
         bkYm4MsnibJIuWcc4stv9rEVW7zqadXiGMHsrJEGDJKD2psUyeJGndw1/jqVOmFo9/AU
         OUxMvAhjCe+2BJ6E2q8Uxpmt4XW/10j/w/2xS055h2HHrd0T67bVyqQ59ki5iElAxfRk
         WFGQ==
X-Gm-Message-State: AOJu0Yx6O5tmuftJoKDVWPsxrUTEDdINyYFb0idWDfE1kWnuFOACFTjH
	ZiG1Yj71e+uh//F35am9UCnZ0fUaL5bV4c/wACkQhp1yDINiYz4DyGD9eYPS+QPoRB0=
X-Gm-Gg: ASbGncuC9WC+/hG4PUvFPhBVF3MNE5/ih2DXtzLnzhtz8b19lFCdSmkp3HlYfhIF0/l
	W3BAYEvoLr2TkTRCV00nV/RYxTA+qTmI/pddFC42OrCOP6UgrXrKgcfK7QxJcloRd3ctua/9UK2
	+VzLFk5OjMRt50PHgVJZRUkm3qPGd3q1D9GOWosTauzLTUhfsnJir/HQ9OTKqd1LxBRdpLJd8UC
	Ddg4EFQeO6WvuS49WQAMzpuIbxeqsf6C+uNvObTW9mdbi4MJ6abdyUs4sQT6HTaiSBzExSYxysM
	7xOmD7JnAiDFeusp4cw5Mp83PKypyh3+IXHhHlGRd9TLOusY7SfyJw+ChrFyW99Xh5msHSohxqs
	9/oGLqm6/wgj2Hjo54BHIMFRfK+lumipRwOuRbUDpH550w2x3CdXj5Y/2NFia2NbjggoICnoOMx
	Lv9VXaP9U3kKp4u24OQ1QgfbhbzNhG5r1MNBIvAgyQkHBl/hAUEYQBrgal4Bcj/ZEwytAY0DdbS
	VG6AIs=
X-Google-Smtp-Source: AGHT+IFoB6ZUUTPKr7sfETP2ZASQesBVMNfbsYpHO4UTgJXela1OGRUFljxnCYySfeW7+T6l2opvLA==
X-Received: by 2002:a05:6402:2109:b0:636:740:e4f8 with SMTP id 4fb4d7f45d1cf-6360740ef79mr9923703a12.18.1759229006040;
        Tue, 30 Sep 2025 03:43:26 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-636361773a6sm4497761a12.6.2025.09.30.03.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:43:25 -0700 (PDT)
Message-ID: <fefbd1ee-ab8c-465e-89bf-39cd2601fc60@suse.com>
Date: Tue, 30 Sep 2025 12:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-12-jgross@suse.com>
 <20250930083827.GI3245006@noisy.programming.kicks-ass.net>
 <1541b670-8b29-42a5-a58d-34d85197751d@suse.com>
 <20250930100404.GK4067720@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250930100404.GK4067720@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Qe0zjUS29flF23TwXpTKjQKv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Qe0zjUS29flF23TwXpTKjQKv
Content-Type: multipart/mixed; boundary="------------MO6SwkMMEKwBe0hiYG7210uG";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
Message-ID: <fefbd1ee-ab8c-465e-89bf-39cd2601fc60@suse.com>
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-12-jgross@suse.com>
 <20250930083827.GI3245006@noisy.programming.kicks-ass.net>
 <1541b670-8b29-42a5-a58d-34d85197751d@suse.com>
 <20250930100404.GK4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930100404.GK4067720@noisy.programming.kicks-ass.net>

--------------MO6SwkMMEKwBe0hiYG7210uG
Content-Type: multipart/mixed; boundary="------------uJZRcyqOhLjfs71u70ZapZ0Y"

--------------uJZRcyqOhLjfs71u70ZapZ0Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMTI6MDQsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAzMCwgMjAyNSBhdCAxMTowMjo1MkFNICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
Pj4gT24gMzAuMDkuMjUgMTA6MzgsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+IE9uIFR1
ZSwgU2VwIDMwLCAyMDI1IGF0IDA5OjAzOjU1QU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3Jv
dGU6DQo+Pj4NCj4+Pj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdTY0IHJlYWRfbXNyKHUz
MiBtc3IpDQo+Pj4+ICt7DQo+Pj4+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZF
QVRVUkVfWEVOUFYpKQ0KPj4+PiArCQlyZXR1cm4geGVuX3JlYWRfbXNyKG1zcik7DQo+Pj4+
ICsNCj4+Pj4gKwlyZXR1cm4gbmF0aXZlX3JkbXNycShtc3IpOw0KPj4+PiArfQ0KPj4+PiAr
DQo+Pj4+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIGludCByZWFkX21zcl9zYWZlKHUzMiBt
c3IsIHU2NCAqcCkNCj4+Pj4gK3sNCj4+Pj4gKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9YRU5QVikpDQo+Pj4+ICsJCXJldHVybiB4ZW5fcmVhZF9tc3Jfc2FmZSht
c3IsIHApOw0KPj4+PiArDQo+Pj4+ICsJcmV0dXJuIG5hdGl2ZV9yZWFkX21zcl9zYWZlKG1z
ciwgcCk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUg
dm9pZCB3cml0ZV9tc3IodTMyIG1zciwgdTY0IHZhbCkNCj4+Pj4gK3sNCj4+Pj4gKwlpZiAo
Y3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9YRU5QVikpDQo+Pj4+ICsJCXhlbl93
cml0ZV9tc3IobXNyLCB2YWwpOw0KPj4+PiArCWVsc2UNCj4+Pj4gKwkJbmF0aXZlX3dybXNy
cShtc3IsIHZhbCk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBfX2Fsd2F5c19p
bmxpbmUgaW50IHdyaXRlX21zcl9zYWZlKHUzMiBtc3IsIHU2NCB2YWwpDQo+Pj4+ICt7DQo+
Pj4+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpKQ0KPj4+
PiArCQlyZXR1cm4geGVuX3dyaXRlX21zcl9zYWZlKG1zciwgdmFsKTsNCj4+Pj4gKw0KPj4+
PiArCXJldHVybiBuYXRpdmVfd3JpdGVfbXNyX3NhZmUobXNyLCB2YWwpOw0KPj4+PiArfQ0K
Pj4+PiArDQo+Pj4+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCByZHBtYyhpbnQgY291
bnRlcikNCj4+Pj4gK3sNCj4+Pj4gKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVB
VFVSRV9YRU5QVikpDQo+Pj4+ICsJCXJldHVybiB4ZW5fcmVhZF9wbWMoY291bnRlcik7DQo+
Pj4+ICsNCj4+Pj4gKwlyZXR1cm4gbmF0aXZlX3JlYWRfcG1jKGNvdW50ZXIpOw0KPj4+PiAr
fQ0KPj4+DQo+Pj4gRWdhZHMsIGRpZG4ndCB3ZSBqdXN0IGNvbnN0cnVjdCBnaWFudCBBTFRF
Uk5BVElWRSgpcyBmb3IgdGhlIG5hdGl2ZV8NCj4+PiB0aGluZ3M/IFdoeSB3cmFwIHRoYXQg
aW4gYSBjcHVfZmVhdHVyZV9lbmFibGVkKCkgaW5zdGVhZCBvZiBqdXN0IGFkZGluZw0KPj4+
IG9uZSBtb3JlIGNhc2UgdG8gdGhlIEFMVEVSTkFUSVZFKCkgPw0KPj4NCj4+IFRoZSBwcm9i
bGVtIEkgZW5jb3VudGVyZWQgd2l0aCB1c2luZyBwdl9vcHMgd2FzIHRvIGltcGxlbWVudCB0
aGUgKl9zYWZlKCkNCj4+IHZhcmlhbnRzLiBUaGVyZSBpcyBubyBzaW1wbGUgd2F5IHRvIGRv
IHRoYXQgdXNpbmcgQUxURVJOQVRJVkVfPG4+KCksIGFzDQo+PiBpbiB0aGUgWGVuIFBWIGNh
c2UgdGhlIGNhbGwgd2lsbCByZW1haW4sIGFuZCBJIGRpZG4ndCBmaW5kIGEgd2F5IHRvDQo+
PiBzcGVjaWZ5IGEgc2FuZSBpbnRlcmZhY2UgYmV0d2VlbiB0aGUgY2FsbC1zaXRlIGFuZCB0
aGUgY2FsbGVkIFhlbiBmdW5jdGlvbg0KPj4gdG8gcmV0dXJuIHRoZSBlcnJvciBpbmRpY2F0
b3IuIFJlbWVtYmVyIHRoYXQgYXQgdGhlIGNhbGwgc2l0ZSB0aGUgbWFpbg0KPj4gaW50ZXJm
YWNlIGlzIHRoZSBvbmUgb2YgdGhlIFJETVNSL1dSTVNSIGluc3RydWN0aW9ucy4gVGhleSBs
YWNrIGFuIGVycm9yDQo+PiBpbmRpY2F0b3IuDQo+IA0KPiBXb3VsZCd2ZSBiZWVuIHVzZWZ1
bCBDaGFuZ2Vsb2cgbWF0ZXJpYWwgdGhhdCBJIHN1cHBvc2UuDQo+IA0KPj4gSW4gWGluJ3Mg
c2VyaWVzIHRoZXJlIHdhcyBhIHBhdGNoIHdyaXR0ZW4gaW5pdGlhbGx5IGJ5IHlvdSB0byBz
b2x2ZSBzdWNoDQo+PiBhIHByb2JsZW0gYnkgYWRkaW5nIHRoZSBfQVNNX0VYVEFCTEVfRlVO
Q19SRVdJTkQoKSBleGNlcHRpb24gdGFibGUgbWV0aG9kLg0KPj4gSSB0aGluayB0aGlzIGlz
IGEgZGVhZCBlbmQsIGFzIGl0IHdpbGwgYnJlYWsgd2hlbiB1c2luZyBhIHNoYWRvdyBzdGFj
ay4NCj4gDQo+IE5vIG1lbW9yaWVzLCBsZXQgbWUgZ28gc2VhcmNoLiBJIGZvdW5kIHRoaXM6
DQo+IA0KPiAgICBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgt
aWRlL3BhdGNoLzIwMjUwMzMxMDgyMjUxLjMxNzEyNzYtMTIteGluQHp5dG9yLmNvbS8NCj4g
DQo+IFRoYXQncyB0aGUgb3RoZXIgUGV0ZXIgOi0pDQoNCk9oLCBteSBiYWQsIHNvcnJ5LiA6
LSkNCg0KPiBBbnl3YXksIHdpdGggc2hhZG93c3RhY2sgeW91IHNob3VsZCBiZSBhYmxlIHRv
IGZyb2IgU1NQIGFsb25nIHdpdGggU1AgaW4NCj4gdGhlIGV4Y2VwdGlvbiBjb250ZXh0LiBJ
SVJDIHRoZSBTU1AgJ3JldHVybicgdmFsdWUgaXMgb24gdGhlIFNTIGl0c2VsZiwNCj4gc28g
YSBXUlNTIHRvIHRoYXQgZmllbGQgY2FuIGVhc2lseSBtYWtlIHRoZSB3aG9sZSBDQUxMIGdv
IGF3YXkuDQoNClllYWgsIGJ1dCBiZWluZyBhYmxlIHRvIGF2b2lkIGFsbCBvZiB0aGF0IGRh
bmNlIHdvdWxkbid0IGJlIHRvbyBiYWQgZWl0aGVyLg0KDQo+PiBBZGRpdGlvbmFsbHkgSSBm
b3VuZCBhIHJhdGhlciB1Z2x5IGhhY2sgb25seSB0byBhdm9pZCByZS1pdGVyYXRpbmcgbW9z
dCBvZg0KPj4gdGhlIGJhcmUgbWV0YWwgQUxURVJOQVRJVkUoKSBmb3IgdGhlIHBhcmF2aXJ0
IGNhc2UuIEl0IGlzIHBvc3NpYmxlLCBidXQgdGhlDQo+PiBiYXJlIG1ldGFsIGNhc2UgaXMg
Z2FpbmluZyBvbmUgYWRkaXRpb25hbCBBTFRFUk5BVElWRSBsZXZlbCwgcmVzdWx0aW5nIGlu
DQo+PiBwYXRjaGluZyB0aGUgb3JpZ2luYWwgaW5zdHJ1Y3Rpb24gd2l0aCBhbiBpZGVudGlj
YWwgY29weSBmaXJzdC4NCj4gDQo+IE9UT0ggdGhlIGFib3ZlIGdlbmVyYXRlcyBhdHJvY2lv
dXMgY3JhcCBjb2RlIDovDQoNClllcy4NCg0KPiBZb3UgZ2V0IHRoYXQgX3N0YXRpY19jcHVf
aGFzKCkgY3J1ZCwgd2hpY2ggaXMgYmFzaWNhbGx5IGEgcmVhbGx5IGZhdA0KPiBqdW1wX2xh
YmVsIChiZWNhdXNlIGl0IG5lZWRzIHRvIGluY2x1ZGUgdGhlIHJ1bnRpbWUgdGVzdCkgYW5k
IHRoZW4gdGhlDQo+IGNvZGUgZm9yIGJvdGggeW91ciB4ZW4gdGhpbmcgYW5kIHRoZSBhbHRl
cm5hdGl2ZS4NCg0KU2VlaW5nIGJvdGggdmFyaWFudHMgd291bGQgbWFrZSBpdCBlYXNpZXIg
dG8gZGVjaWRlLCBJIGd1ZXNzLg0KDQo+IA0KPiAvbWUgcG9uZGVycyB0aGluZ3MgYSBiaXQu
Lg0KPiANCj4+IFJlbWVtYmVyIHRoYXQgYXQgdGhlIGNhbGwgc2l0ZSB0aGUgbWFpbiBpbnRl
cmZhY2UgaXMgdGhlIG9uZSBvZiB0aGUNCj4+IFJETVNSL1dSTVNSIGluc3RydWN0aW9ucy4g
VGhleSBsYWNrIGFuIGVycm9yIGluZGljYXRvci4NCj4gDQo+IFRoaXMsIHRoYXQgaXNuJ3Qg
dHJ1ZS4NCj4gDQo+IE5vdGUgaG93IGV4X2hhbmRsZXJfbXNyKCkgdGFrZXMgYSByZWcgYXJn
dW1lbnQgYW5kIGhvdyB0aGF0IHNldHMgdGhhdA0KPiByZWcgdG8gLUVJTy4gU2VlIGhvdyB0
aGUgY3VycmVudCBuYXRpdmVfcmVhZF9tc3Jfc2FmZSgpIHVzZXMgdGhhdDoNCj4gDQo+ICAg
IF9BU01fRVhUQUJMRV9UWVBFX1JFRygxYiwgMmIsIEVYX1RZUEVfUkRNU1JfU0FGRSwgJVtl
cnJdKQ0KPiANCj4gKGFsc28gbm90ZSBob3cgdXNpbmcgX0FTTV9FWFRBQkxFX1RZUEUoMWIs
IDJiLCBFWF9UWVBFXypfU0FGRSkgbGlrZSB5b3UNCj4gZG8sIHdpbGwgcmVzdWx0IGluIHJl
ZyBiZWluZyAwIG9yIGF4LiBTY3JpYmJsaW5nIHlvdXIgMCByZXR1cm4gdmFsdWUpDQo+IA0K
PiBJdCB2ZXJ5IGV4cGxpY2l0bHkgdXNlcyBAZXJyIGFzIGVycm9yIHJldHVybiB2YWx1ZS4g
U28geW91ciBjYWxsIHdvdWxkDQo+IHJldHVybiBlYXg6ZWR4IGFuZCB0YWtlIGVjeCB0byBi
ZSB0aGUgbXNyLCBidXQgdGhlcmUgaXMgbm90aGluZyBzdG9wcGluZw0KPiB1cyBmcm9tIHRo
ZW4gdXNpbmcgc2F5IGVieCBmb3IgZXJyb3IgcmV0dXJuLCBsaWtlOg0KPiANCj4gCWludCBl
cnIgPSAwOw0KPiANCj4gCWFzbV9pbmxpbmUoDQo+IAkJIjE6XG4iDQo+IAkJQUxURVJOQVRJ
VkUoImRzIHJkbXNyIiwNCj4gCQkJICAgICJjYWxsIHhlbl9yZG1zciIsIFhFTlBWKQ0KPiAJ
CSIyOlxuIg0KPiANCj4gCQlfQVNNX0VYVEFCTEVfVFlQRV9SRUcoMWIsIDJiLCBFWF9UWVBF
X1JETVNSX1NBRkUsICUlZWJ4KQ0KPiANCj4gCQk6ICJhIiAoYXgpLCAiZCIgKGR4KSwgIiti
IiAoZXJyKQ0KPiAJCTogImMiIChtc3IpKTsNCj4gDQo+IAlyZXR1cm4gZXJyOw0KPiANCj4g
SG1tPw0KDQpPaCwgaW5kZWVkLg0KDQpMZXQgbWUgdHJ5IHRoYXQgYW5kIHdlIGNhbiBjaG9v
c2UgdGhlIGxlc3MgZXZpbC4gOi0pDQoNCg0KSnVlcmdlbg0K
--------------uJZRcyqOhLjfs71u70ZapZ0Y
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------uJZRcyqOhLjfs71u70ZapZ0Y--

--------------MO6SwkMMEKwBe0hiYG7210uG--

--------------Qe0zjUS29flF23TwXpTKjQKv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjbtE0FAwAAAAAACgkQsN6d1ii/Ey/F
Wwf/WJOrBM6l0KctiSZXfPxyAVz7Y/KfXcHiWmWbh3r15Ml4P9c5SriRck4+1ZNyDHTjpJqxuW+V
5o0V0U9d15MIlc4Y3DG/WW1zU3SHaEY09GY0cs3msFpo15nmFCcyBkXBkHg69Y31d+kuUJvAmJVs
GnVzrwyc9dv/+IjvKt3q/fHpLuLi479emvZfu/N0uu+8d2VAiVUS7GR9atv9zMDl7MyqHFo1bDU0
KFck8rebX+E3IpdcnQWa0XI5lc9ZrGO0FPWy5slNIHji7WEVhFMbdkjwLG3lOdzwbOvY/YSeX5SV
z1mDUwq37oseNVJ3s/9tRX9+WRhTqYzWHdFR3+bYaA==
=tsHn
-----END PGP SIGNATURE-----

--------------Qe0zjUS29flF23TwXpTKjQKv--

