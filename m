Return-Path: <linux-kernel+bounces-837274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6893BBABD65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E283A7843
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1284822E004;
	Tue, 30 Sep 2025 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J1SOwYYF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62282A1CA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217611; cv=none; b=SVXFOB+IymUlVQ7dWi7v7cbwWEhKJck0js6BfXLfpnIxKJE9PvwkLQhNr31HuNWzPgmC7Bc3ftXiW9p1I7zUl6kOdFQvNVvIdOMRt5DL0n1OTHJn17zH0AouaBuHjyPBMMx5bUVslIy2aOyu7dMPK9fr3lRbheS8EQ/2XbpoHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217611; c=relaxed/simple;
	bh=LH7JSLNC+J1cYeY45afhICPB6XyN1bTOloxodwFFhJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofX1E6g2JEgh0pO0vrUq/Sbl/gUwVBxfRbh7jwunq2PxSxpxlVWJnTap7mWW0vE8TptgViXGgaVG3Fd3ZIS+MChmCHIyr7qc9LRUbDCp9oomYbidkER6mu8qHnNX9m3yHsmwOFZ05jj6QcPccEGyvMVATCezTvNOHFeJPmSFDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J1SOwYYF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322da8so1090525066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759217607; x=1759822407; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LH7JSLNC+J1cYeY45afhICPB6XyN1bTOloxodwFFhJA=;
        b=J1SOwYYFk0FrljuQnfxcM/mJRNLWU+dXr62WcRtOvMwpJi2DnKl+3OdDLj8kdWE+Yk
         toy/8cgidOhQUIhjYF58bVy4DLHpCBIVrvwEXNhaQD4bCcE+PC+mq16RIs2L86CuDyQb
         83F+Rb4yxN7eiCZk9h9etSLxjIZ+ts9K9hNE5B6Ofu+EbqH9W9JKclORkjjFHUYx+Awq
         mhaCgugusH9UIZEV14f5FS4uCkraEsh35Sq9U3AAF0f1SdJ0YDuZ5Um4ejuGcd+ct6bE
         pUYY9/8Uxrs8FGJkjGOVSzWxbdLJFE1j+Fd26tbKbG8P2oXb/jKSddx3b/UWgMiRAr35
         dZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217607; x=1759822407;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LH7JSLNC+J1cYeY45afhICPB6XyN1bTOloxodwFFhJA=;
        b=qDuyjQqltXPF/eWq680K3vaS9q2C6sjF33G1o2D73MSTGFBYNPrBUgdaiBqKZ90c79
         HWva5lXUOL8YUVJ6QnXAOqYu2lt+VHQhzYM3anI95jMPEO+y4HvzlPSAZQ3+hGjfKvnF
         W/B1u5hBTxCqRD/4GKnsmtz3YkRDYY92sEJfqBi64iXFXGc4liTyG27uzfCclpkIOg3A
         W44wr2ckEBdWq2qstzOxMO1IdiZhpzjcC00zvDLNxGenV4nvx/pI2DpH0lA5VJsaFUvw
         m+YEAsEDRuBS+MKGl/y7Q8rUdMyJiF4X3LmynoyZloT4idTxLeVWMTFVNm2wLURwA5mj
         7GRA==
X-Gm-Message-State: AOJu0Yxq2fVfysYLQwXelRTSNtOkdH0x1pHg3ZiBy66LZfofsybI0R1V
	glop7tgF3jJpBSJ9/Jzy7AIg00wCDv/JlvrmxUCjtXZbfk348OI/6FcQMKE/KaDpd0I=
X-Gm-Gg: ASbGncvGhg6EQ816gFgbbxFa8IER9+NzE5cLRsXM3jC9mFI3NxIkyfr/yvpmoh8HTv6
	DBViAvRcFHd4lmzKHM6HtgiGIgF7SDSgEsY5h9lnOXKhsBiL0iO38Dd3UeE/BnyhSDYu7UxixG+
	fMLTKBSxihNjSWdWkcWA4T07cj5eRSsMha2BeIfGxDfrIOb68JWpJPY55hr98ZYOBveA2q2PP1V
	s8vJHAzf7rC7h33wQm47BvSUfRGyMygiD+Wm5eD01Ro5aVY+b1NCWVkUbsiFB4Am8MA5NaVVYXB
	VN8UYgCmecUElehGutDM9PxMWZhXjO6DMiEoSREJRT0Qu73gcGTaNcMVHgaJprjV2tkQTYSblrw
	fy+TXsseQpwwsHsrRbdqW2OijN/SeIMJk1/wPiLeDFXRHkw2a9qAdZBRMO06jeJLXAVszQh+eUf
	D4Dh6emt/8ov+FkteSnWxS4B+l1l5fqyIUcZmNtunW5f4s2wsdmrAaEgMM7+NSTwyTQ/qKETC9i
	bD0HeU=
X-Google-Smtp-Source: AGHT+IHn3muhov17i85liR9ZNyutHWBzGkZmwvX9SZoIhKRkrRd7ZNzc1Ym2TQ+BxZZPTinR/ngIbA==
X-Received: by 2002:a17:907:9805:b0:b33:a2ef:c7 with SMTP id a640c23a62f3a-b34beba93f8mr2231147466b.55.1759217606855;
        Tue, 30 Sep 2025 00:33:26 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f9eaa10e9sm303424066b.44.2025.09.30.00.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:33:26 -0700 (PDT)
Message-ID: <bd595b07-5f00-420f-8bc0-4009237d040c@suse.com>
Date: Tue, 30 Sep 2025 09:33:25 +0200
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
In-Reply-To: <20250930072643.GF3245006@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------A0uCjot4K6mFa4e3BWHPT9sn"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------A0uCjot4K6mFa4e3BWHPT9sn
Content-Type: multipart/mixed; boundary="------------ZIv0p8Y71dsvqKrqxL3w8s77";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <bd595b07-5f00-420f-8bc0-4009237d040c@suse.com>
Subject: Re: [PATCH 3/3] x86/alternative: Patch a single alternative location
 only once
References: <20250929112947.27267-1-jgross@suse.com>
 <20250929112947.27267-4-jgross@suse.com>
 <20250930072643.GF3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930072643.GF3245006@noisy.programming.kicks-ass.net>

--------------ZIv0p8Y71dsvqKrqxL3w8s77
Content-Type: multipart/mixed; boundary="------------FIUsUlFsabODgQN30YFxqNyV"

--------------FIUsUlFsabODgQN30YFxqNyV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMDk6MjYsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIFNl
cCAyOSwgMjAyNSBhdCAwMToyOTo0N1BNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
Pj4gSW5zdGVhZCBvZiBwYXRjaGluZyBhIHNpbmdsZSBsb2NhdGlvbiBwb3RlbnRpYWxseSBt
dWx0aXBsZSB0aW1lcyBpbg0KPj4gY2FzZSBvZiBuZXN0ZWQgQUxURVJOQVRJVkUoKXMsIGRv
IHRoZSBwYXRjaGluZyBvbmx5IGFmdGVyIGhhdmluZw0KPj4gZXZhbHVhdGVkIGFsbCBhbHRf
aW5zdHIgaW5zdGFuY2VzIGZvciB0aGF0IGxvY2F0aW9uLg0KPj4NCj4+IFRoaXMgaGFzIG11
bHRpcGxlIGFkdmFudGFnZXM6DQo+Pg0KPj4gLSBJbiBjYXNlIG9mIHJlcGxhY2luZyBhbiBp
bmRpcmVjdCB3aXRoIGEgZGlyZWN0IGNhbGwgdXNpbmcgdGhlDQo+PiAgICBBTFRfRkxBR19E
SVJFQ1RfQ0FMTCBmbGFnLCB0aGVyZSBpcyBubyBsb25nZXIgdGhlIG5lZWQgdG8gaGF2ZSB0
aGF0DQo+PiAgICBpbnN0YW5jZSBiZWZvcmUgYW55IG90aGVyIGluc3RhbmNlcyBhdCB0aGUg
c2FtZSBsb2NhdGlvbiAodGhlDQo+PiAgICBvcmlnaW5hbCBpbnN0cnVjdGlvbiBpcyBuZWVk
ZWQgZm9yIGZpbmRpbmcgdGhlIHRhcmdldCBvZiB0aGUgZGlyZWN0DQo+PiAgICBjYWxsKS4N
Cj4+DQo+PiAtIEluIGNhc2Ugb2YgbmVzdGVkIEFMVEVSTkFUSVZFKClzIHRoZXJlIGlzIG5v
IGludGVybWVkaWF0ZSByZXBsYWNlbWVudA0KPj4gICAgdmlzaWJsZS4gVGhpcyBhdm9pZHMg
YW55IHByb2JsZW1zIGluIGNhc2UgZS5nLiBhbiBpbnRlcnJ1cHQgaXMNCj4+ICAgIGhhcHBl
bmluZyBiZXR3ZWVuIHRoZSBzaW5nbGUgaW5zdGFuY2VzIGFuZCB0aGUgcGF0Y2hlZCBsb2Nh
dGlvbiBpcw0KPj4gICAgdXNlZCBkdXJpbmcgaGFuZGxpbmcgdGhlIGludGVycnVwdC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+
PiAtLS0NCj4+IFYyOg0KPj4gLSBuZXcgcGF0Y2gNCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9r
ZXJuZWwvYWx0ZXJuYXRpdmUuYyB8IDI3ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYw0KPj4gaW5kZXggNzM1Y2MwMTdmMmQzLi5j
Y2YwNzEzMWNkNDcgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRp
dmUuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCj4+IEBAIC02
NDgsNiArNjQ4LDggQEAgdm9pZCBfX2luaXRfb3JfbW9kdWxlIG5vaW5saW5lIGFwcGx5X2Fs
dGVybmF0aXZlcyhzdHJ1Y3QgYWx0X2luc3RyICpzdGFydCwNCj4+ICAgCXU4IGluc25fYnVm
ZltNQVhfUEFUQ0hfTEVOXTsNCj4+ICAgCXU4ICppbnN0cjsNCj4+ICAgCXN0cnVjdCBhbHRf
aW5zdHIgKmEsICpiOw0KPj4gKwl1bnNpZ25lZCBpbnQgaW5zdGFuY2VzID0gMDsNCj4+ICsJ
Ym9vbCBwYXRjaGVkID0gZmFsc2U7DQo+PiAgIA0KPj4gICAJRFBSSU5USyhBTFQsICJhbHQg
dGFibGUgJXB4LCAtPiAlcHgiLCBzdGFydCwgZW5kKTsNCj4+ICAgDQo+PiBAQCAtNjc3LDkg
KzY3OSwxMyBAQCB2b2lkIF9faW5pdF9vcl9tb2R1bGUgbm9pbmxpbmUgYXBwbHlfYWx0ZXJu
YXRpdmVzKHN0cnVjdCBhbHRfaW5zdHIgKnN0YXJ0LA0KPj4gICAJCSAqIHBhZGRpbmcgZm9y
IGFsbCBhbHRfaW5zdHIgZW50cmllcyBmb3IgdGhpcyBzaXRlIChuZXN0ZWQNCj4+ICAgCQkg
KiBhbHRlcm5hdGl2ZXMgcmVzdWx0IGluIGNvbnNlY3V0aXZlIGVudHJpZXMpLg0KPj4gICAJ
CSAqLw0KPj4gLQkJZm9yIChiID0gYSsxOyBiIDwgZW5kICYmIGluc3RyX3ZhKGIpID09IGlu
c3RyX3ZhKGEpOyBiKyspIHsNCj4+IC0JCQl1OCBsZW4gPSBtYXgoYS0+aW5zdHJsZW4sIGIt
Pmluc3RybGVuKTsNCj4+IC0JCQlhLT5pbnN0cmxlbiA9IGItPmluc3RybGVuID0gbGVuOw0K
Pj4gKwkJaWYgKCFpbnN0YW5jZXMpIHsNCj4+ICsJCQlmb3IgKGIgPSBhKzE7IGIgPCBlbmQg
JiYgaW5zdHJfdmEoYikgPT0gaW5zdHJfdmEoYSk7IGIrKykgew0KPj4gKwkJCQl1OCBsZW4g
PSBtYXgoYS0+aW5zdHJsZW4sIGItPmluc3RybGVuKTsNCj4+ICsJCQkJYS0+aW5zdHJsZW4g
PSBiLT5pbnN0cmxlbiA9IGxlbjsNCj4+ICsJCQl9DQo+PiArCQkJaW5zdGFuY2VzID0gYiAt
IGE7DQo+PiArCQkJcGF0Y2hlZCA9IGZhbHNlOw0KPj4gICAJCX0NCj4+ICAgDQo+PiAgIAkJ
aW5zdHIgPSBpbnN0cl92YShhKTsNCj4+IEBAIC02OTIsMTQgKzY5OCwxOSBAQCB2b2lkIF9f
aW5pdF9vcl9tb2R1bGUgbm9pbmxpbmUgYXBwbHlfYWx0ZXJuYXRpdmVzKHN0cnVjdCBhbHRf
aW5zdHIgKnN0YXJ0LA0KPj4gICAJCSAqIC0gZmVhdHVyZSBub3QgcHJlc2VudCBidXQgQUxU
X0ZMQUdfTk9UIGlzIHNldCB0byBtZWFuLA0KPj4gICAJCSAqICAgcGF0Y2ggaWYgZmVhdHVy
ZSBpcyAqTk9UKiBwcmVzZW50Lg0KPj4gICAJCSAqLw0KPj4gLQkJaWYgKCFib290X2NwdV9o
YXMoYS0+Y3B1aWQpID09ICEoYS0+ZmxhZ3MgJiBBTFRfRkxBR19OT1QpKSB7DQo+PiAtCQkJ
bWVtY3B5KGluc25fYnVmZiwgaW5zdHIsIGEtPmluc3RybGVuKTsNCj4+IC0JCQlvcHRpbWl6
ZV9ub3BzKGluc3RyLCBpbnNuX2J1ZmYsIGEtPmluc3RybGVuKTsNCj4+IC0JCX0gZWxzZSB7
DQo+PiArCQlpZiAoIWJvb3RfY3B1X2hhcyhhLT5jcHVpZCkgIT0gIShhLT5mbGFncyAmIEFM
VF9GTEFHX05PVCkpIHsNCj4+ICAgCQkJYXBwbHlfb25lX2FsdGVybmF0aXZlKGluc3RyLCBp
bnNuX2J1ZmYsIGEpOw0KPj4gKwkJCXBhdGNoZWQgPSB0cnVlOw0KPj4gICAJCX0NCj4+ICAg
DQo+PiAtCQl0ZXh0X3Bva2VfZWFybHkoaW5zdHIsIGluc25fYnVmZiwgYS0+aW5zdHJsZW4p
Ow0KPj4gKwkJaW5zdGFuY2VzLS07DQo+PiArCQlpZiAoIWluc3RhbmNlcykgew0KPj4gKwkJ
CWlmICghcGF0Y2hlZCkgew0KPj4gKwkJCQltZW1jcHkoaW5zbl9idWZmLCBpbnN0ciwgYS0+
aW5zdHJsZW4pOw0KPj4gKwkJCQlvcHRpbWl6ZV9ub3BzKGluc3RyLCBpbnNuX2J1ZmYsIGEt
Pmluc3RybGVuKTsNCj4+ICsJCQl9DQo+PiArCQkJdGV4dF9wb2tlX2Vhcmx5KGluc3RyLCBp
bnNuX2J1ZmYsIGEtPmluc3RybGVuKTsNCj4+ICsJCX0NCj4+ICAgCX0NCj4+ICAgDQo+PiAg
IAlrYXNhbl9lbmFibGVfY3VycmVudCgpOw0KPiANCj4gSSB0aGluayB5b3UgbG9zdCB0aGUg
b3B0aW1pemVfbm9wcygpIGNhbGwgZm9yIHRoZSBwYXRjaGVkIGNhc2UuDQo+IA0KPiBUaGF0
IGlzLCBub3RlIGhvdyBhcHBseV9vbmVfYWx0ZXJuYXRpdmUoKSBkb2VzIDB4OTAgcGFkZGlu
ZywgYnV0IHRoZW4NCj4geW91IG9ubHkgZG8gb3B0aW1pemVfbm9wcygpIHdoZW4gIXBhdGNo
ZWQuDQoNClRoZSBjYWxsIG9mIG9wdGltaXplX25vcHMoKSBpcyBwYXJ0IG9mIHRleHRfcG9r
ZV9hcHBseV9yZWxvY2F0aW9uKCkgd2hlbg0KcGF0Y2hpbmcsIGxpa2Ugd2l0aG91dCBteSBz
ZXJpZXMuDQoNCg0KSnVlcmdlbg0K
--------------FIUsUlFsabODgQN30YFxqNyV
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------FIUsUlFsabODgQN30YFxqNyV--

--------------ZIv0p8Y71dsvqKrqxL3w8s77--

--------------A0uCjot4K6mFa4e3BWHPT9sn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjbh8UFAwAAAAAACgkQsN6d1ii/Ey/j
bQf/SLUTmvpvq12zwJ2uoazZml7wLrmAqG6LOWdp3RWWbiPi7Js/qxP2J7hfIlEt5eV7h4RcsJCD
IxMI9H1t8TfYZFiz6oyT83gboBJB0maby1xAjNujP3fzL81OXRM7vT5mwRG7aa/H4fRk6SeJ5BvH
aFkGSYh2Ht4jE4cKEAvi4+KppkrOUX45Dm3RT7jzNa+XBPYZ59101Sb54EJGlSeqIaIN4q9kYGNI
HiRAZi/6Vz3OVO9ye2LFMxNu2WoHvSwvTlsi2zacgSzS6p3zp4I4F5kt+DDNQgkT5z0DJfSDQdEC
7IZE5wfVPHYoa5G/hFGKBf5B6IRZ1VWgxcW05BY2rA==
=WkJC
-----END PGP SIGNATURE-----

--------------A0uCjot4K6mFa4e3BWHPT9sn--

