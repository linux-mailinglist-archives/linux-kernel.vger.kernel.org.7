Return-Path: <linux-kernel+bounces-837350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C7BAC1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D527A9AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC12853EF;
	Tue, 30 Sep 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mv3TOeKE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC213B7AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221988; cv=none; b=Vehx2Lpe6vGklbafEHA/9b4K86SIJgw2J2cccLY9xmqk36rAOAmynBYlaHdhd2QlkdwACPkVExBkNiY5FV1n6f8lGmHf+h7b+MU4zSjkg3ImRMqqkahv+8b8NEy/ks2N8R7fZuR2s7qGv9NugD6SECtI4A2xBU87rSeygDybG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221988; c=relaxed/simple;
	bh=n073neUCiDTGhaEDHA2IjeRoyHl37uk5yKvHEz0WeF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8ho38r5OAZaMw9WbpwhI5R9eg4IrlTkvlzFa6VK8x73TiuJGaxDy5F3XauEvzLexYaPuIMAftLGCpCbEjF4W4FyWynp8DPbFamqPdpwwEo8F2hFHadCloWYXyofi7+rc0ud12s0lq+5pD9fbwaJRI6JtFPawJ6tiqN4HlTMRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mv3TOeKE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so10313512a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759221985; x=1759826785; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n073neUCiDTGhaEDHA2IjeRoyHl37uk5yKvHEz0WeF0=;
        b=Mv3TOeKEN6Zr/0oLsjVqT/vDb6MxZdEz6gUlUfGcfshUnYRmVVvsojFoiIhezkFbqR
         xSDxYXAd3Ea01B93c79nK3tr3DhcmGZDoQHC4T68F7PlgkMbnux3sxFrdfCKOR+0+jC/
         o00TfORGWVgOxB8rr7qpz8/eVEIMtvi3XmzBMXiD8FFFHPpcBIy2qlB/Ih4cKA/9HCNK
         owTslWKT60XzY6JsVuYBNsoBw6AUcf2FxU2HjAJBou3RKLDT97+gnkn159eVLyxIZuoQ
         dtB2BpmWd+M9lIkf42IegTdo+U/1mS5/27K2IjHJstqLliQtDb7gUM6l1LOQxcDmgddg
         ubbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221985; x=1759826785;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n073neUCiDTGhaEDHA2IjeRoyHl37uk5yKvHEz0WeF0=;
        b=RIB3YyyFEU+c4wEhs6Uyi2mH7O/SGYQuSmg0LIc/Hpea4d1Le0xJrpYPydZ62cfClR
         yZ2YsWEbJWuTXH3thA3QGa3WdZGvrhPyLhe2oavrvJ331kdHJtxbP3zFhLCTGGiHS0w7
         aMf4Y6TOYDbmkW2ZNOMlVFHYYowYoLpDerx9USh0ZDRpFVvYtN4T0wPgfJcEbRaUEgkd
         FI1fI9iONDUjoGDUUgh9SpKyL1juODGjO76RLRQyvMYUHDX/3GHDWpCpfDwZi/K40yMM
         SRAyLIrg58S52q/Pu3pP/UOXRHMuBC/ixNnihlS8IcPMmWhKYoSUYn1pG+ZUnws6L256
         Jx3A==
X-Gm-Message-State: AOJu0YzXB42DNc/0P7E0+vN2GNBhGCRS3FK05/wDB67deEmyUHCJowzN
	Pr9vNR7/sZKHnqhwREPxSBcUeciWHusKqM/4zMMzL0oMDvyhucip2U9KM3SX9JreDnM=
X-Gm-Gg: ASbGncuyI84ZnyvtMHrXBmwjwxZ1iU02bK7Wbj1jPLNdfWHBCOgaV4WJ9rJX0NeIUeM
	By53kLnFo4I1ayo8KhjpLE6YRzgjH8aPlamEp1hf3nnsYiLTIfJX/ay1WJzxPWHfFPMS5j2fPIK
	rupT0KsteAQL10ljX2veT/cqUl4DnIJ38pb9nZnWKErfI+MRZvC79aj6bWajXEnJJIo1xVbYp9u
	0RpMPKz1IyyO3IaoQiyFxyhLbsBmBDDWtS/MuESlPz8uFKtmsy+ed1RxpJjiZ9/fhZY79KWXlwj
	5nrmwPrFaKokeRcfsqZLlP4zDekQTd+rubpy9/e+COvo5SV9eZ6m7qoQRcZcjhqUot0CCM5aGLn
	pPgGkmV0ZyTcB2egEAzo2YH9R0yQmfJ3STk2DhQV6VCdDm4DqvxMrO7TT/7NdP9g3jzXPcDI1ZE
	EVVi4/8Nyic3A8kv08UBzSLAu3mBAcbGrEyduaWFH2BdvetMPVeGN4eptyW656Cs9TnOIhzXK6r
	z3ymSs=
X-Google-Smtp-Source: AGHT+IHxsEMyNpkOmoP1U/w50PEW9dqktFGCuYCKbZWdgaPwWE+RQg0SNgb7DMeYUYG17C1wAJEwQA==
X-Received: by 2002:a17:907:969f:b0:b3f:e1e9:22c1 with SMTP id a640c23a62f3a-b3fe1e92469mr628491566b.53.1759221984572;
        Tue, 30 Sep 2025 01:46:24 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9769bsm1105990566b.99.2025.09.30.01.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:46:24 -0700 (PDT)
Message-ID: <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
Date: Tue, 30 Sep 2025 10:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
 xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WyvLv7FPqaRR3LZWOKqhQ93Q"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WyvLv7FPqaRR3LZWOKqhQ93Q
Content-Type: multipart/mixed; boundary="------------aKTd8pK9QFbBkB2G6cgX0bFZ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
 xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Message-ID: <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930083137.GH3245006@noisy.programming.kicks-ass.net>

--------------aKTd8pK9QFbBkB2G6cgX0bFZ
Content-Type: multipart/mixed; boundary="------------N30kQOTdZwedXtdN5VMqEbar"

--------------N30kQOTdZwedXtdN5VMqEbar
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMTA6MzEsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAzMCwgMjAyNSBhdCAwOTowMzo1M0FNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgX193cm1zcnFfY29uc3RhbnQo
dTMyIG1zciwgdTY0IHZhbCwgaW50IHR5cGUpDQo+PiArew0KPj4gKwlCVUlMRF9CVUdfT04o
IV9fYnVpbHRpbl9jb25zdGFudF9wKG1zcikpOw0KPj4gKw0KPj4gKwlhc21faW5saW5lIHZv
bGF0aWxlIGdvdG8oDQo+PiArCQkiMTpcbiINCj4+ICsJCUFMVEVSTkFUSVZFXzIoUFJFUEFS
RV9SQ1hfUkRYX0ZPUl9XUk1TUg0KPj4gKwkJCSAgICAgICIyOiBkcyB3cm1zciIsDQo+PiAr
CQkJICAgICAgUFJFUEFSRV9SQ1hfUkRYX0ZPUl9XUk1TUg0KPj4gKwkJCSAgICAgIEFTTV9X
Uk1TUk5TLA0KPj4gKwkJCSAgICAgIFg4Nl9GRUFUVVJFX1dSTVNSTlMsDQo+PiArCQkJICAg
ICAgQVNNX1dSTVNSTlNfSU1NLA0KPj4gKwkJCSAgICAgIFg4Nl9GRUFUVVJFX01TUl9JTU0p
DQo+PiArCQlfQVNNX0VYVEFCTEVfVFlQRSgxYiwgJWxbYmFkbXNyXSwgJWNbdHlwZV0pCS8q
IEZvciBXUk1TUk5TIGltbWVkaWF0ZSAqLw0KPj4gKwkJX0FTTV9FWFRBQkxFX1RZUEUoMmIs
ICVsW2JhZG1zcl0sICVjW3R5cGVdKQkvKiBGb3IgV1JNU1IoTlMpICovDQo+PiArDQo+PiAr
CQk6DQo+PiArCQk6IFt2YWxdICJhIiAodmFsKSwgW21zcl0gImkiIChtc3IpLCBbdHlwZV0g
ImkiICh0eXBlKQ0KPj4gKwkJOiAibWVtb3J5IiwgImVjeCIsICJyZHgiDQo+PiArCQk6IGJh
ZG1zcik7DQo+PiArDQo+PiArCXJldHVybiBmYWxzZTsNCj4+ICsNCj4+ICtiYWRtc3I6DQo+
PiArCXJldHVybiB0cnVlOw0KPj4gK30NCj4gDQo+IEp1c3Qgd29uZGVyaW5nLCB3b3VsZCBz
b21ldGhpbmcgdGhpcyB3b3JrPw0KPiANCj4gCWFzbV9pbmxpbmUgdm9sYXRpbGUgZ290bygN
Cj4gCQkiMTpcbiINCj4gCQlBTFRFUk5BVElWRShQUkVQQVJFX1JDWF9SRFhfRk9SX1dSTVNS
DQo+IAkJCSAgICAiMjpcbiINCj4gCQkJICAgIEFMVEVSTkFUSVZFKCJkcyB3cm1zciIsDQo+
IAkJCSAgICAgICAgICAgICAgICBBU01fV1JNU1JOUywgWDg2X0ZFQVRVUkVfV1JNU1JOUyks
DQo+IAkJCSAgICBBU01fV1JNU1JOU19JTU0sIFg4Nl9GRUFUVVJFX01TUl9JTU0pOw0KPiAJ
CV9BU01fRVhUQUJMRV9UWVBFKDFiLCAlbFtiYWRtc3JdLCAlY1t0eXBlXSkJLyogRm9yIFdS
TVNSTlMgaW1tZWRpYXRlICovDQo+IAkJX0FTTV9FWFRBQkxFX1RZUEUoMmIsICVsW2JhZG1z
cl0sICVjW3R5cGVdKQkvKiBGb3IgV1JNU1IoTlMpICovDQo+IA0KPiAJCToNCj4gCQk6IFt2
YWxdICJhIiAodmFsKSwgW21zcl0gImkiIChtc3IpLCBbdHlwZV0gImkiICh0eXBlKQ0KPiAJ
CTogIm1lbW9yeSIsICJlY3giLCAicmR4Ig0KPiAJCTogYmFkbXNyKTsNCj4gDQo+IEl0cyBh
IGJpdCB3ZWlyZCBiZWNhdXNlIHRoZSBuZXN0ZWQgYWx0ZXJuYXRpdmUgaXNuJ3QgZm9yIHRo
ZSBleGFjdCBzYW1lDQo+IHBvc2l0aW9uIEkgc3VwcG9zZS4gQnV0IEkgZmluZCBpdCBhIG1v
cmUgcmVhZGFibGUgZm9ybS4NCg0KSSBkb24ndCB0aGluayBpdCB3b3VsZCB3b3JrLiBOZXN0
ZWQgQUxURVJOQVRJVkUoKXMgZG8gd29yayBvbmx5IHdpdGgNCmFsbCBvZiB0aGVtIHN0YXJ0
aW5nIGF0IHRoZSBzYW1lIGxvY2F0aW9uLiBIYXZlIGEgbG9vayBhdCB0aGUNCkFMVEVSTkFU
SVZFKCkgbWFjcm8sIHdoaWNoIGlzIGRlZmluaW5nIHRoZSBsYWJlbCAiNzcxIiB2aWEgT0xE
SU5TVFIoKQ0KYW5kIHRoZW4gcmVmZXJyaW5nIHRvIHRoaXMgbGFiZWwgdmlhIEFMVElOU1RS
X0VOVFJZKCkuIEluIHlvdXIgY2FzZQ0KdGhlIEFMVElOU1RSX0VOVFJZKCkgb2YgdGhlIG91
dGVyIEFMVEVSTkFUSVZFKCkgaW52b2NhdGlvbiB3b3VsZCBmaW5kDQp0aGUgd3JvbmcgIjc3
MSIgbGFiZWwgKHRoZSBvbmUgb2YgdGhlIGlubmVyIEFMVEVSTkFUSVZFKCkpLg0KDQpBbGxv
d2luZyBzdWNoIGNvbnN0cnVjdHMgd291bGQgcHJvYmFibHkgcmVxdWlyZSBzd2l0Y2hpbmcg
ZnJvbSBwcmVwcm9jZXNzb3INCm1hY3JvcyB0byBhc3NlbWJsZXIgbWFjcm9zLg0KDQoNCkp1
ZXJnZW4NCg==
--------------N30kQOTdZwedXtdN5VMqEbar
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------N30kQOTdZwedXtdN5VMqEbar--

--------------aKTd8pK9QFbBkB2G6cgX0bFZ--

--------------WyvLv7FPqaRR3LZWOKqhQ93Q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjbmN8FAwAAAAAACgkQsN6d1ii/Ey/F
awf/fno3luNeDyyPCvIMnrq1g+67KuO6WYcxOoweSiZcMtyPM9Uz5GnGBU9o7sorklegCHuQQ4al
ZffznYe40JhyZ9tNG8AxL4Lmo8j0CPbTOJXCL0m99rJMR3LpVFboU8fFeOe14jjewN+yw3u6RES4
D9BAlUnTfwrXVZf7z5wg1H3kwU6NXhUBNHfQxYDBCfI8qVmlmGI9GAWZp+Opj+4cdfwThp7iMuda
p2aF1Kvs4z0V/o+EmepBogTBccSFvbT0SW2mZvty3nPMIuELOA9UstzbESAqfwyshMD+H+rWJbTu
HVQb02U5G64+ieSeh0Aqe+FVohJKU4NcvgevOp0rlw==
=bYlT
-----END PGP SIGNATURE-----

--------------WyvLv7FPqaRR3LZWOKqhQ93Q--

