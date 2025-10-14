Return-Path: <linux-kernel+bounces-852797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B2BD9F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC6503BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55244314D3A;
	Tue, 14 Oct 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Eh2mEGEn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF430F94E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451196; cv=none; b=cHfagTZwVJ5EH8EAM3JnDPRIJ8qpbex3nn+3+s03mEtkGe1/5x0m3dU/vkadbC9yl95uUh1nHKfg1eC/jO/n8MXBvLn7VZy9jTbMltODFcrjTBUtp7u45HporEkG8yWh3k7QS6mdimB0Dk3MwpSWApBSNKslyZexlwI7Ftdyc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451196; c=relaxed/simple;
	bh=xmPMxwAHnh2XmeLzkgxDTRL7YXtQNhNhlNedAyQ2dAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxnzcyRG/B02f34Qs9v/WkXnCQFB6Xf88he0eUl+4EpPbvdqS2OaHrg1Pm8iILUq/HHJsKhbWh2nV1eETk/74yeqELrywlSy9H0B/q68V2vRv4kEUmRk8I60oxhJY7F8fRVCCMalvwlQjZxZlWoi6o012bKCUu9etDz04sa71Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Eh2mEGEn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b50645ecfbbso1052106266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760451192; x=1761055992; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmPMxwAHnh2XmeLzkgxDTRL7YXtQNhNhlNedAyQ2dAM=;
        b=Eh2mEGEnGdaXWF3PCayzIrcKdhrVgeN2YdCY6nDarye9YkgBIOnwL5HQ1kGM5ywRQ+
         FSd9Qx/yddv0E/jOf1HATFPBGQ/+dLE4Bymio0NYdqocboXRI+CTdg2EuBzUqJqM4Mx4
         lgRBFjViSxVRzEefVNw0yKCXvz3gAwFoDJoNjLQTPbGe2El/UCvPdBgjJrlbWOIKBVcG
         9tJ0pgUxt4eSg5+GxyDSoTIg09lczvt8l9Lv2wRki0aT1zSQYCDiX3r+kksmESptrVTn
         UeW+eQttmr6lNI5TRUmZnnA+m3B4AxpML77Mh8NJo9DQ/eaaUO0KTfjq9+hCpae5DNsj
         cG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760451192; x=1761055992;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmPMxwAHnh2XmeLzkgxDTRL7YXtQNhNhlNedAyQ2dAM=;
        b=vLcHHCOlNCAjV7X1efxTMWmanZzPigjMjaluHMRech5sT6o2/cSOIK97LT1jbk2arU
         VN8fX5V59vhjFdEEFzPQOckkt7EY61Chm2njckt9Gv0VeGi2CtEjmzGHxEjhvjSF4noH
         mvxRL7svumhyNrJnIfksuGcktft2OqIE5sUKsQVphTdTtLXID5/uOir3/J8dMzGT54t1
         Xcu8PmVMuFw0EeEVxteq8RfZNeWp+tVZYA8HklqRF3NA1ypzhtfUrkDECHQW1FxRlh8w
         rw3UBdTszDKLt+oMOnH3yx1syRPf5PlL7kGmTbkvnAetKquh8E6ZXr1YlMy3h0SiuJ1Z
         Qagg==
X-Forwarded-Encrypted: i=1; AJvYcCX3gcjRmz3zbQXsd2915X4zCn9ZVQr6IhkSpD2MHQXWluFbN7j8osINCa1ES3zm/4QI88cK14paTG0fGjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9zIqRqzUD36eA8/VTcCLVvCWjSQgipBJQAWYDZgb+/lY1VbC
	cok8zTDo5aYy0y6DaT4PlmO+v25Sww4TMmfZZyb1KcPPjM6YrWlM0OmldhnfS2W4pwU=
X-Gm-Gg: ASbGncuAZCQRIMYJqTq1sbwzrZuwtbOx8t1A7CJ03zBgakbpGjwbBCd2hlFOHtze58+
	sI8LvAeYzwhNcV++vyA4LTkFcwzX9cGf2vKkdk9RcLv8MOfZutWkCyJ0rVgC0hMtF1tg1avuKts
	YyFAYpqjMEv1dsdBj1TXSddPAdErDZa+zsIzd/+ViGHXZdj/HbtVitXGgpmJB30dmC9PnO2064x
	+7OZ/LSRX0MF0B/HhqawruMVgCqmjJT8Sp844xCc0o1vzTAY6sWJLwMrVtZmGF3VhXYEb8pPQ+F
	sLPeV8ktfLcAtzvD38f+tXf1Tab845WxD2ODLT+6imj3gXR/sUBmGrGXC7OOc4ihKw6OB3CxKHh
	V4TF1E5Xx2HyDxJ61RDkbmMQIoyOfloni2zPMSuadH9vsWGZeRnUQIrp+7v74Jvvl5U+ZlyDGkV
	9I7c3hKzZ/yVTM07NjJy2fcOQvDdH04WzTP7xIXyFNm3vvtS548j/vCud3iiloIrw=
X-Google-Smtp-Source: AGHT+IEr3JkMLNyfcdwpiARCIBKFNT86O5ZVxZ/8oubWjpd77AOUG/Jm3mGB9VWZVB8Rc4Iz8mKCyw==
X-Received: by 2002:a17:907:2d0d:b0:b3d:6fff:9a0e with SMTP id a640c23a62f3a-b50ac2d792bmr2850490166b.53.1760451191839;
        Tue, 14 Oct 2025 07:13:11 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d65d4f12sm1166544866b.27.2025.10.14.07.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:13:11 -0700 (PDT)
Message-ID: <ddb38d36-0194-414c-8614-1f37b1f38283@suse.com>
Date: Tue, 14 Oct 2025 16:13:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
To: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>
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
In-Reply-To: <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0B07G3NvUBSCifgub3UBmaTb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0B07G3NvUBSCifgub3UBmaTb
Content-Type: multipart/mixed; boundary="------------6IOf4Ydaw3oWjtheCzQkYin2";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Message-ID: <ddb38d36-0194-414c-8614-1f37b1f38283@suse.com>
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>
In-Reply-To: <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>

--------------6IOf4Ydaw3oWjtheCzQkYin2
Content-Type: multipart/mixed; boundary="------------wj2zQAMxuWCFdXG8BU9czIiL"

--------------wj2zQAMxuWCFdXG8BU9czIiL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMTAuMjUgMTU6MjUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMTQsIDIwMjUgYXQgMDI6NTk6MDlQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPj4gQW5kIGZyYW5rbHksIHRoZSBqdXN0aWZpY2F0aW9uIGZvciB0aGlzIHBhdGNoIGlz
IGFsc28gbWVoOiBhbiBpbnRlcnJ1cHQgbWlnaHQNCj4+IHVzZSB0aGUgbG9jYXRpb24/IT8g
SWYgdGhpcyBpcyBhIHJlYWwgaXNzdWUgdGhlbiB3ZSBiZXR0ZXIgZGlzYWJsZSBJUlFzIGFy
b3VuZA0KPj4gaXQuIEJ1dCBub3QgbWFrZSB0aGUgY29kZSB5dWNreS4NCj4gDQo+IEFuZCB0
aGlzIHBhdGNoIGlzIG5vdCBkb2luZyB3aGF0IGl0IGlzIGNsYWltaW5nIGlzIGRvaW5nOg0K
PiANCj4gSGVyZSdzIGFuIGluY2FybmF0aW9uIG9mIFhTVEFURV9YU0FWRSB3aGljaCBpcyBh
IDMtd2F5IGFsdGVybmF0aXZlOg0KPiANCj4gQXQgbG9jYXRpb24gZmZmZmZmZmY4MTI4M2Nk
MywgaXQgcmVwbGFjZXMgdGhlIGRlZmF1bHQgWFNBVkUgd2l0aCBYU0FWRU9QVC4NCj4gDQo+
IFsgICAgMi40NTY2OTZdIFNNUCBhbHRlcm5hdGl2ZXM6IGZlYXQ6IDEwKjMyKzAsIG9sZDog
KHNhdmVfZnByZWdzX3RvX2Zwc3RhdGUrMHg0My8weGEwIChmZmZmZmZmZjgxMjgzY2QzKSBs
ZW46IDYpLCByZXBsOiAoZmZmZmZmZmY4OWMxZTZkOSwgbGVuOiA2KSBmbGFnczogMHgwDQo+
IFsgICAgMi40NTkzMTddIFNNUCBhbHRlcm5hdGl2ZXM6IGZmZmZmZmZmODEyODNjZDM6ICAg
b2xkX2luc246IDQ5IDBmIGFlIDY0IDI0IDQwCXhzYXZlNjQgMHg0MCglcjEyKQ0KPiBbICAg
IDIuNDYwODA2XSBTTVAgYWx0ZXJuYXRpdmVzOiBmZmZmZmZmZjg5YzFlNmQ5OiAgIHJwbF9p
bnNuOiA0OSAwZiBhZSA3NCAyNCA0MAl4c2F2ZW9wdDY0IDB4NDAoJXIxMikNCj4gWyAgICAy
LjQ2MzMxNl0gU01QIGFsdGVybmF0aXZlczogZmZmZmZmZmY4MTI4M2NkMzogZmluYWxfaW5z
bjogNDkgMGYgYWUgNzQgMjQgNDANCj4gDQo+IGFuZCB0aGVuIHRoYXQgZXhhY3Qgc2FtZSBs
b2NhdGlvbjoNCj4gDQo+IFsgICAgMi40NjQ3NTddIFNNUCBhbHRlcm5hdGl2ZXM6IGZlYXQ6
IDEwKjMyKzEsIG9sZDogKHNhdmVfZnByZWdzX3RvX2Zwc3RhdGUrMHg0My8weGEwIChmZmZm
ZmZmZjgxMjgzY2QzKSBsZW46IDYpLCByZXBsOiAoZmZmZmZmZmY4OWMxZTZkZiwgbGVuOiA2
KSBmbGFnczogMHgwDQo+IFsgICAgMi40NjczMTddIFNNUCBhbHRlcm5hdGl2ZXM6IGZmZmZm
ZmZmODEyODNjZDM6ICAgb2xkX2luc246IDQ5IDBmIGFlIDY0IDI0IDQwDQo+IFsgICAgMi40
Njg3NDZdIFNNUCBhbHRlcm5hdGl2ZXM6IGZmZmZmZmZmODljMWU2ZGY6ICAgcnBsX2luc246
IDQ5IDBmIGM3IDY0IDI0IDQwCXhzYXZlczY0IDB4NDAoJXIxMikNCj4gWyAgICAyLjQ3MDE2
N10gU01QIGFsdGVybmF0aXZlczogZmZmZmZmZmY4MTI4M2NkMzogZmluYWxfaW5zbjogNDkg
MGYgYzcgNjQgMjQgNDANCj4gDQo+IGdldHMgWFNBVkVTLg0KDQpPaCwgaW5kZWVkLCBJIHNo
b3VsZCBoYXZlIGFkYXB0ZWQgdGhlIHByaW50aW5nLiBUaGUgcGF0Y2hpbmcgaXMgZmluZSwN
Cml0IGlzIGp1c3QgdGhlIGRlYnVnIG91dHB1dCB3aGljaCBjbGFpbXMgdG8gaGF2ZSB3cml0
dGVuIDIgZGlmZmVyZW50DQppbnN0cnVjdGlvbnMgdG8gb2xkX2luc24sIHdoaWxlIGl0IGRp
ZG4ndC4NCg0KPiANCj4gU28sIGxvbmcgc3Rvcnkgc2hvcnQsIHRoaXMgbmVlZHMgbW9yZSB0
aG91Z2h0Og0KPiANCj4gMS4gY2hlY2sgd2hldGhlciBwYXRjaGluZyBpcyBuZWVkZWQNCj4g
DQo+IDIuIGEgaGVscGVyIGZ1bmN0aW9uIGV2YWx1YXRlcyBhbGwgaW5zdGFuY2VzIGFuZCBm
aWd1cmVzIG91dCB0aGUgZmluYWwgaW5zbg0KPiAgICAgYnl0ZXMgd2hpY2ggbmVlZCB0byBi
ZSBwYXRjaGVkIGFsb25nIHdpdGggdGhlIHByb3BlciBwYWRkaW5nDQo+IA0KPiAzLiB0aGUg
cHJvcGVyIGJ5dGVzIGFyZSBjb3BpZWQgaW50byB0aGUgdGFyZ2V0IGxvY2F0aW9uIGFuZCBh
bGwgZ29vZA0KPiANCj4gQnV0IG5vdCBsaWtlIHRoaXMgLSB0aGUgaWRlYSBpcyBzb21ld2hh
dCBvayBidXQgaXQgbmVlZHMgdG8gYmUgZXhlY3V0ZWQgaW4NCj4gYSBjbGVhbmVyIG1hbm5l
ci4NCj4gDQo+IEknZCBzYXkuDQoNCkkgY2FuIGhhdmUgYSB0cnkgd2l0aCB0aGlzIGFwcHJv
YWNoLg0KDQpDb3VsZCB0YWtlIHNvbWUgdGltZSwgdmFjYXRpb24gaXMgY29taW5nIHVwLi4u
DQoNCg0KSnVlcmdlbg0K
--------------wj2zQAMxuWCFdXG8BU9czIiL
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------wj2zQAMxuWCFdXG8BU9czIiL--

--------------6IOf4Ydaw3oWjtheCzQkYin2--

--------------0B07G3NvUBSCifgub3UBmaTb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjuWncFAwAAAAAACgkQsN6d1ii/Ey+4
Qwf/UonRgfqjDugzQ34GJn7AEt6SqSee7bGbBpFVMiCFxsUJNFcvU60lt4qYRyt3aKZ+8Ez7kUGt
j1eQZHLdoaxHfxXZ+BE/vr9hEET8KsDdkqFzTy2UeywSDkwGt1WK2Lpnne9DcJJAut5j1cuCg0iV
rk0ekvut4geRNLI4Rg7fMxC6eTAFxNBQ48cWBmCUw9tvq0lYghlLvSMZb+E4MuBDHrI+S7S3Ex3S
wAmaR46wbbCC8wJxN/dBAZnvP6hH4VqR1HBVZptyFv2MDh1UCmT1+39bwQgBjCdoV7PQiIm1Z7nO
9PnyxHOkzVmWo2c8K4Cs1GyIotx5GeGCZmPDh4R31g==
=pivJ
-----END PGP SIGNATURE-----

--------------0B07G3NvUBSCifgub3UBmaTb--

