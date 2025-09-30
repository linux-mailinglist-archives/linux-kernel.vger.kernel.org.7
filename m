Return-Path: <linux-kernel+bounces-837333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4989BAC0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B4F1924E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214ED223DDF;
	Tue, 30 Sep 2025 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OXxIUt5k"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16F2BB17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221082; cv=none; b=rCj7bR2GJnHkR56TG/X/0BaqlpjS8O0HOZekbbKxOiaSaPwrURRf41Vraxfv1bUrmbKO8O6dP/f9C0q/WdFmEDw0W0YhRw9dzFpYezEaaFdYxI/d+7Jii0tvI7eN/OaarTK0LACws+r/uNnll/IMt614zdgQmfmfyml5U4QfK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221082; c=relaxed/simple;
	bh=AazPbwYGXxQ89XMBwgjwChc7UlMcnTcFt2Y33DI2EvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHeD7FNM6PhZ1CYtjYlJ5IDspdvD3fPrvtNxCvK8Ykqe0rFPeTue6ha0yjB7Z2SxwPkScg+R7NtbTMrkAefbtqVZp2+fb0sg6XmB5Kru5fp2CObcN+vsNMDwtKwGNQbYM2D920v3N3hR0UWtOlZnHNGZkrMbFWx/ucin39BEvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OXxIUt5k; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso11530697a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759221078; x=1759825878; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AazPbwYGXxQ89XMBwgjwChc7UlMcnTcFt2Y33DI2EvM=;
        b=OXxIUt5kHV71BpQyxUhIf2uMPmCgalXAVfv+Gp7hsRsbizxGcO1a2oI4yEKiGlIjiL
         xPk6ty6Kn4gbvjCX8R8S368+Sd0OiZaIGymxjCAJQh1a2RZqmnHuPGcHCwe8TO1+jN9D
         +6M/FAF1bK30lp87ZXfKe+6O8EDAkd9+QckNp+OB2BCt0+to6PC+3W396PXDS8n00Hit
         TnIXZF7d97WsH4IRzG6xG6GOmhlWoMNqB8H+Vtjib1qnwofTF1mTAFT5K1ABI08EWNcC
         4EKGzyZGQFyshVyxhNTx2ryNY+DnlS2YQ/5OtDg/H/bIpKzgQKpdlm8rbY0HfpEioQir
         5PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221078; x=1759825878;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AazPbwYGXxQ89XMBwgjwChc7UlMcnTcFt2Y33DI2EvM=;
        b=NUt/lX/OhZjdHe43XTLMsZ70YDwq2hvEtVwSNTD3AiyfhW7lubVI98xVLFOVZccuOv
         RkFQXMq83CtiIPxvBOG7bp9aPXjLalzuWk9KkEakk0P7l9CzHslA6c2A5di37+KE/9P9
         lpnNYpE5e5bk1pxao9d/IY0tsu/TZ6qK0uRafW9llOwbdR8tQPT5BniWRS7cOMh8M/5b
         dw27qY8Hx8YdVr4atc7BSyWljQ0YsnC+nGpzVz3v2jNBeeKlUIVokFb7/v6pZ42GxXVx
         0vr90EwcgoRzD8IY10teziVrBUxWuoBwMCi2y9GsXRkOjkd5QY3bpoUI/SkMS+u+lD+r
         sDWg==
X-Gm-Message-State: AOJu0Yy4bb6xfkCp+wzeNMkB5mMEk3P/ft6dXqy9hU+ymDKNJsrmvAL9
	ciQep44ypPAO66M3imGvSGMoTZQmj+F1lA/rEjwdoITW225iuqbnbIkKiuA0v9k0kxjk7Lsx1F+
	gSF0L
X-Gm-Gg: ASbGnctqdJBgOousMJCMgG720g7lgWWVHJfhsp0d8fJMVFLs/jej/2tW8wKF2IzzlaJ
	61L5dIN7ke+yGkw+ojpisjBJ8R1hc42v3u2180k6acEUh3/fB2f66bHtKL7JbKmzxyxU6Ve4/mA
	WbPicnBQc4qkqUQvzwkUw/FkbbPzHUqNiTKUfUa3m7K8xhOm6C66UYsK1r/oTxknUqev7leOcrM
	9ugp6Wi8tHcA0S1QmlDitAzeiPoongGLm1xPYrld9WzlNZ5P3t1K8jnUlSp1s/4SQoOp0mO9h1E
	znM4wK5EgDe1rGWPYxKqu0T75RcogV6nNCxxDlRnkYpUUdc3NqLxyXNcMJjRPTWxaQeVKNJPFpr
	51KhgJ5yJFXAAJMTg/rov+qZZ2GHEl4N0cszb9mqllvClC5Dd6Od0u8KcWRK8OiFCuzxxYfcqn9
	YAQdvbFFV7z0QRdwb1E77g41KtTWRpgqO3wEUZPKTLzyXP+pGLwVbgQLU+5TPPcDyR/hFD
X-Google-Smtp-Source: AGHT+IHfFSnR1JVKzk0+BaTjS9Ulwox0nAzIP0vLKmA+g2t35hqynOVYEqymhpW2wahQPQf3Yzuuew==
X-Received: by 2002:a05:6402:350a:b0:636:681e:a3dc with SMTP id 4fb4d7f45d1cf-636681ea5abmr1131781a12.36.1759221078094;
        Tue, 30 Sep 2025 01:31:18 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af53basm9680149a12.41.2025.09.30.01.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:31:17 -0700 (PDT)
Message-ID: <79ca36a3-6d2c-4851-b29a-24eacc6c32c0@suse.com>
Date: Tue, 30 Sep 2025 10:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] x86/extable: Add support for immediate form MSR
 instructions
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-9-jgross@suse.com>
 <20250930081442.GG3245006@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250930081442.GG3245006@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jjaBdrdqFxazhQx0xyFBgWOG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jjaBdrdqFxazhQx0xyFBgWOG
Content-Type: multipart/mixed; boundary="------------0hlwWgbJfoElpelBuywHzT7R";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <79ca36a3-6d2c-4851-b29a-24eacc6c32c0@suse.com>
Subject: Re: [PATCH v2 08/12] x86/extable: Add support for immediate form MSR
 instructions
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-9-jgross@suse.com>
 <20250930081442.GG3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930081442.GG3245006@noisy.programming.kicks-ass.net>

--------------0hlwWgbJfoElpelBuywHzT7R
Content-Type: multipart/mixed; boundary="------------te2xw92IzQvdo5wTuC2SLRom"

--------------te2xw92IzQvdo5wTuC2SLRom
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMTA6MTQsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAzMCwgMjAyNSBhdCAwOTowMzo1MkFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
Pj4gRnJvbTogIlhpbiBMaSAoSW50ZWwpIiA8eGluQHp5dG9yLmNvbT4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBYaW4gTGkgKEludGVsKSA8eGluQHp5dG9yLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gVjI6
DQo+PiAtIG5ldyBwYXRjaCwgdGFrZW4gZnJvbSB0aGUgUkZDIHYyIE1TUiByZWZhY3RvciBz
ZXJpZXMgYnkgWGluIExpDQo+PiAtLS0NCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNy
LmggfCAxOCArKysrKysrKysrKysrKysrKysNCj4+ICAgYXJjaC94ODYvbW0vZXh0YWJsZS5j
ICAgICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vbXNyLmgNCj4+IGluZGV4IDcxZjQxYWYxMTU5MS4uY2Y1MjA1MzAw
MjY2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgNCj4+ICsr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oDQo+PiBAQCAtNTYsNiArNTYsMjQgQEAg
c3RhdGljIGlubGluZSB2b2lkIGRvX3RyYWNlX3JlYWRfbXNyKHUzMiBtc3IsIHU2NCB2YWws
IGludCBmYWlsZWQpIHt9DQo+PiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBkb190cmFjZV9yZHBt
Yyh1MzIgbXNyLCB1NjQgdmFsLCBpbnQgZmFpbGVkKSB7fQ0KPj4gICAjZW5kaWYNCj4+ICAg
DQo+PiArLyoNCj4+ICsgKiBDYWxsZWQgb25seSBmcm9tIGFuIE1TUiBmYXVsdCBoYW5kbGVy
LCB0aGUgaW5zdHJ1Y3Rpb24gcG9pbnRlciBwb2ludHMgdG8NCj4+ICsgKiB0aGUgTVNSIGFj
Y2VzcyBpbnN0cnVjdGlvbiB0aGF0IGNhdXNlZCB0aGUgZmF1bHQuDQo+PiArICovDQo+PiAr
c3RhdGljIF9fYWx3YXlzX2lubGluZSBib29sIGlzX21zcl9pbW1faW5zbih2b2lkICppcCkN
Cj4+ICt7DQo+PiArCS8qDQo+PiArCSAqIEEgZnVsbCBkZWNvZGVyIGZvciBpbW1lZGlhdGUg
Zm9ybSBNU1IgaW5zdHJ1Y3Rpb25zIGFwcGVhcnMgZXhjZXNzaXZlLg0KPj4gKwkgKi8NCj4+
ICsjaWZkZWYgQ09ORklHX1g4Nl82NA0KPj4gKwljb25zdCB1OCBtc3JfaW1tX2luc25fcHJl
Zml4W10gPSB7IDB4YzQsIDB4ZTcgfTsNCj4+ICsNCj4+ICsJcmV0dXJuICFtZW1jbXAoaXAs
IG1zcl9pbW1faW5zbl9wcmVmaXgsIHNpemVvZihtc3JfaW1tX2luc25fcHJlZml4KSk7DQo+
IA0KPiBUaGlzIHNlZW1zIGZyYWdpbGUuIFRob3NlIHR3byBieXRlcyBhcmUgYmFzaWNhbGx5
IHRoZSBmaXJzdCB0d28gYnl0ZXMgb2YNCj4gVkVYMyBhbmQgb25seSBpbmRpY2F0ZSBWRVgz
Lm1hcDcuIFdoaWNoIGlzIG5vdCB2ZXJ5IHNwZWNpZmljLCBidXQgd2hlbg0KPiBjb21iaW5l
ZCB3aXRoIHRoZSBmYWN0IHRoYXQgdGhpcyBpcyBhbiBNU1IgZXhjZXB0aW9uLCBtaWdodCBq
dXN0IHdvcmsuDQo+IA0KPiBUcm91YmxlIGlzIHRoYXQgaXQgaXMgYWxzbyBwb3NzaWJsZSB0
byBlbmNvZGUgdGhlIGltbWVkaWF0ZSBmb3JtIHVzaW5nDQo+IEVWRVguIElmIGEgdG9vbGNo
YWluIHdlcmUgdG8gZG8gdGhhdCwgd2UnZCBmYWlsIHRvIGRldGVjdCBpdC4NCj4gDQo+IChB
bmQgdGhlcmUgaXMgc2VnbWVudCBwcmVmaXggc3R1ZmZpbmcgcG9zc2libGUgSSBzdXBwb3Nl
KQ0KPiANCj4+ICsjZWxzZQ0KPj4gKwlyZXR1cm4gZmFsc2U7DQo+PiArI2VuZGlmDQo+PiAr
fQ0KPj4gKw0KPj4gICAvKg0KPj4gICAgKiBfX3JkbXNyKCkgYW5kIF9fd3Jtc3IoKSBhcmUg
dGhlIHR3byBwcmltaXRpdmVzIHdoaWNoIGFyZSB0aGUgYmFyZSBtaW5pbXVtIE1TUg0KPj4g
ICAgKiBhY2Nlc3NvcnMgYW5kIHNob3VsZCBub3QgaGF2ZSBhbnkgdHJhY2luZyBvciBvdGhl
ciBmdW5jdGlvbmFsaXR5IHBpZ2d5YmFja2luZw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L21tL2V4dGFibGUuYyBiL2FyY2gveDg2L21tL2V4dGFibGUuYw0KPj4gaW5kZXggMmZkYzFm
MWY1YWRiLi5jMDIxZTRkYmM2OWQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9tbS9leHRh
YmxlLmMNCj4+ICsrKyBiL2FyY2gveDg2L21tL2V4dGFibGUuYw0KPj4gQEAgLTE2NiwyMyAr
MTY2LDUyIEBAIHN0YXRpYyBib29sIGV4X2hhbmRsZXJfdWFjY2Vzcyhjb25zdCBzdHJ1Y3Qg
ZXhjZXB0aW9uX3RhYmxlX2VudHJ5ICpmaXh1cCwNCj4+ICAgc3RhdGljIGJvb2wgZXhfaGFu
ZGxlcl9tc3IoY29uc3Qgc3RydWN0IGV4Y2VwdGlvbl90YWJsZV9lbnRyeSAqZml4dXAsDQo+
PiAgIAkJCSAgIHN0cnVjdCBwdF9yZWdzICpyZWdzLCBib29sIHdybXNyLCBib29sIHNhZmUs
IGludCByZWcpDQo+PiAgIHsNCj4+ICsJYm9vbCBpbW1faW5zbiA9IGlzX21zcl9pbW1faW5z
bigodm9pZCAqKXJlZ3MtPmlwKTsNCj4+ICsJdTMyIG1zcjsNCj4+ICsNCj4+ICsJaWYgKGlt
bV9pbnNuKQ0KPj4gKwkJLyoNCj4+ICsJCSAqIFRoZSAzMi1iaXQgaW1tZWRpYXRlIHNwZWNp
ZnlpbmcgYSBNU1IgaXMgZW5jb2RlZCBpbnRvDQo+PiArCQkgKiBieXRlIDUgfiA4IG9mIGFu
IGltbWVkaWF0ZSBmb3JtIE1TUiBpbnN0cnVjdGlvbi4NCj4+ICsJCSAqLw0KPj4gKwkJbXNy
ID0gKih1MzIgKikocmVncy0+aXAgKyA1KTsNCj4+ICsJZWxzZQ0KPj4gKwkJbXNyID0gKHUz
MilyZWdzLT5jeDsNCj4gDQo+IFRoaXMgc2VlbXMgdG8gaGF2ZSBmYWxsZW4gc3ViamVjdCB0
byB0aGUgVVMgdGFyaWZmIGluZHVjZWQge30gc2hvcnRhZ2UNCj4gb3Igc29tZXRoaW5nLg0K
PiANCj4gQWxzbywgRVZFWCBmb3JtIHdpbGwgaGF2ZSB0aGVtIGluIG90aGVyIGJ5dGVzIChv
bmUgZnVydGhlciwgb24gYWNjb3VudA0KPiBvZiBFVkVYIGJlaW5nIDQgYnl0ZXMsIHJhdGhl
ciB0aGFuIDMpLg0KPiANCj4gR2l2ZW4gdGhpcyByZWFsbHkgaXNuJ3QgYSBmYXN0IHBhdGgg
b3IgYW55dGhpbmcsIGhvdyBhYm91dCB3ZSBqdXN0IHVzZQ0KPiB0aGUgaW5zdHJ1Y3Rpb24g
ZGVjb2Rlcj8gU29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJc3RydWN0IGluc24gaW5zbjsNCj4g
CXUzMiBtc3IgPSAodTMyKXJlZ3MtPmN4Ow0KPiANCj4gCXJldCA9IGluc25fZGVjb2RlX2tl
cm5lbCgmaW5zbiwgKHZvaWQgKilyZWdzLT5pcCk7DQo+IAlpZiAoIXJldCAmJiBpbnNuLnZl
eF9wcmVmaXgubmJ5dGVzKQ0KPiAJCW1zciA9IGluc24uaW1tZWRpYXRlLnZhbHVlOw0KPiAN
Cj4gc2hvdWxkIGRvLCBJIHN1cHBvc2UuIElzbid0IHRoYXQgYm90aCBzaW1wbGVyIGFuZCBt
b3JlIHJvYnVzdD8NCj4gDQoNCldvcmtzIGZvciBtZS4NCg0KDQpKdWVyZ2VuDQo=
--------------te2xw92IzQvdo5wTuC2SLRom
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------te2xw92IzQvdo5wTuC2SLRom--

--------------0hlwWgbJfoElpelBuywHzT7R--

--------------jjaBdrdqFxazhQx0xyFBgWOG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjblVUFAwAAAAAACgkQsN6d1ii/Ey8s
YQf8CFicjmXsZZY6MoOlDMThhYc2WBjFUgx7Kh5LJBtlvOMHuX0/Tbt1BgAUwmu98qPaoVMMNhek
vJb4Chq0Supk9x2T+qcuUvDQdTWpAcmQmjgo8WtHVws+9rP0I7PP/UskP35HxWCUUU5PIvXLHMRg
B+XpIVCOfgjy/477JxAKuurWG9W/RbP4Yk80totcS8UZB9GLd0nMXuwA5QgDnnEHANcSok+Z9uTo
ebW3iVqXlIrj4kFRWz3VguP7h/HRIKilWUS40cJw9jUADrAIXWHjAmy5+r6KTIhcYvtjbq6EBEje
g8VCbP7uywCbmroh4rmWl1l9QanplpcIaaaoDU3Umg==
=IfU/
-----END PGP SIGNATURE-----

--------------jjaBdrdqFxazhQx0xyFBgWOG--

