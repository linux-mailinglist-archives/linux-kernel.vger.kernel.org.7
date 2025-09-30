Return-Path: <linux-kernel+bounces-837373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA1BAC2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618681922EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090092F39B0;
	Tue, 30 Sep 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S7rVKLic"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514F244665
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222977; cv=none; b=tL7zRz1trrmswBT4iTYMb25lXm6Lh5quFpfZ1aowN8JL6iWZcewW218LrledAjr/cLi0yrlfNw08J5t4Rfkj0ZMZTmCuiCyEP2s/RZiJ51u3kr65AyXvIPLKAuSAho8FvUYz4AgSrBPHDgKRYcwzhorHVWb/6pAIZ6/b6FB+/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222977; c=relaxed/simple;
	bh=LtMOHW+53F0W8gofi/abbzsPPcLlqTFKatap2a1mWHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMAJKb0Vh7IfIA0oxqVxhvkprqfLYH/E7g95jyV2bpaqu1UpVeK/gn0vV80Pu1lXh3M5lio8yfg/6juPkILZqqAr9JLe18d9IAA+VOz2MO75BW9eTEuMgCjh6anuS5fE83KjBwR0OJs+EHVfQg4k32Y2AdiBUX20VnCF3uhiTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S7rVKLic; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b30ead58e0cso1060165666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759222973; x=1759827773; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LtMOHW+53F0W8gofi/abbzsPPcLlqTFKatap2a1mWHc=;
        b=S7rVKLicImSqaoc+WThtk2L8FX10N11/RKKwDkc8x77Fs0grsQyax3j2FB6hlp3U6r
         QnrEEo46OOOmETnIJbbkGlnj43qrCPSjCC3a7KNQxcK042S4uLWEQzvT3sqrJjqMqxj7
         7okq4vGz0Jdvan36Oofzf/+Ey9c0CzRGivTEH+upZBOamKIEjl0/yTjzd1G2feeCk5TM
         kHovwMqoFmv7Pio64GaMBniLUKJPEh4Ju948kf8qTVr3Nzul/KxRAWoSA+8uIJSNvDBe
         B44eAB4PP0BGIjCX7BhlGuYi2fBuZA/0+VHSB6b4J9JZHxPRCnfdTyVKoVvT7JHHgyvu
         PpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222973; x=1759827773;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtMOHW+53F0W8gofi/abbzsPPcLlqTFKatap2a1mWHc=;
        b=NFyJ/EdNr6aO1Q0IZptjLUKA/G3rZe3GWggKSCJ6gNEFsV6LazkAlUVy56b1bYM37q
         7cGKrtwth7ArmQemB2QTQlZOz9C6pHo26kHGBWL1+EWq6+eJf86yJ4jalCrBIn+MetU3
         /AgGxxZNukBd8jya1gB+xX56FvEsdpPruVjhvIqIJpgfCjfVqkeUoPqse4r2WkJ4EmBM
         Or2S7JXnQBXc9XNxNMP1WOH5oIexfV7oUJnELQwHP/hG/9fyw8NVRRklOsbQ/RSCCMTM
         3THqyUN01LapAtIOuP7bdU5TuSGRgyR9GNhImTtmhqbkbLNuZh/w/pLav2PqjbeZtw0V
         kLyA==
X-Gm-Message-State: AOJu0Yzc3QglOPOGpE0xWKvPr/yYnh2wibjVfu5ToO1owBcLlEOaIhf7
	7XB1+2celPcE/AQf8R9yZZgcCKBHPcnYHEPtaH3EvWDM2cohtb+aIcDAe9LCtQnKdBA=
X-Gm-Gg: ASbGncstDXIRUdfgZgvKAr/FAR2lWqbIMg/hnuJrivYosXX5Qkd4VAgFiR4i24MOjxP
	cTgNr2+Tb61Sl73ZTjY0608qQ3nDbl7TJhEp+UuBc/8u8Gq/XqmY0/hcJGrqsm5YcquzmF6e0h6
	D72+dhMC3oTVYIFTKeoEi5Xt9f3gire8F9SO1nAJ4sIMfteaSorSbcGnvfSYX8y+fPzhtcg2iRm
	FM8y/osfvNf3q6sb4zRbiLXKmW5KiOi8mm43dg2k3KabDHo1HjwbMI967LAti3YBMfGhnMK0Mbh
	ZGDsz2kA/Nc9dm3AtymHgIEgx2ZgpZfiDJVwcn2VQs9RxZYH3ZVgFSZyhRQl3fruq2Wg4gwDEof
	Rl1RebK18M+AxNA+ahhB6navcumrVR1ta8UuIqIGYvK7dmxSYko3dl6CgCdNmd8yLZa6JXR9blg
	/+n0AaBzAEN1s7xVwOF7FgNjimLf5Yd9zuq0idnm4ZTsi5F4xv6NFD8LcTYSC2g4xdjgNi
X-Google-Smtp-Source: AGHT+IEhBcJxRX85g9uAkfqQnAOM8ZX84eGYiI6CL0xWr5Dy3J8XRMl2kqQOdaPWOVnka4EPHeMGbA==
X-Received: by 2002:a17:907:d7c1:b0:b3a:ecc1:7774 with SMTP id a640c23a62f3a-b3aecc183bamr1092767766b.53.1759222973125;
        Tue, 30 Sep 2025 02:02:53 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3c40d9ced1sm557968466b.80.2025.09.30.02.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:02:52 -0700 (PDT)
Message-ID: <1541b670-8b29-42a5-a58d-34d85197751d@suse.com>
Date: Tue, 30 Sep 2025 11:02:52 +0200
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
In-Reply-To: <20250930083827.GI3245006@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EDjdRPJRmmUK5bP0S1o6gxj8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EDjdRPJRmmUK5bP0S1o6gxj8
Content-Type: multipart/mixed; boundary="------------SnAjFPsvrro8lhJGEyYEiJll";
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
Message-ID: <1541b670-8b29-42a5-a58d-34d85197751d@suse.com>
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-12-jgross@suse.com>
 <20250930083827.GI3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930083827.GI3245006@noisy.programming.kicks-ass.net>

--------------SnAjFPsvrro8lhJGEyYEiJll
Content-Type: multipart/mixed; boundary="------------dMBscmw5LmvOz0wWFtddEw66"

--------------dMBscmw5LmvOz0wWFtddEw66
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMTA6MzgsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAzMCwgMjAyNSBhdCAwOTowMzo1NUFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCByZWFkX21zcih1MzIgbXNyKQ0K
Pj4gK3sNCj4+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYp
KQ0KPj4gKwkJcmV0dXJuIHhlbl9yZWFkX21zcihtc3IpOw0KPj4gKw0KPj4gKwlyZXR1cm4g
bmF0aXZlX3JkbXNycShtc3IpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgX19hbHdheXNf
aW5saW5lIGludCByZWFkX21zcl9zYWZlKHUzMiBtc3IsIHU2NCAqcCkNCj4+ICt7DQo+PiAr
CWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBWKSkNCj4+ICsJCXJl
dHVybiB4ZW5fcmVhZF9tc3Jfc2FmZShtc3IsIHApOw0KPj4gKw0KPj4gKwlyZXR1cm4gbmF0
aXZlX3JlYWRfbXNyX3NhZmUobXNyLCBwKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIF9f
YWx3YXlzX2lubGluZSB2b2lkIHdyaXRlX21zcih1MzIgbXNyLCB1NjQgdmFsKQ0KPj4gK3sN
Cj4+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpKQ0KPj4g
KwkJeGVuX3dyaXRlX21zcihtc3IsIHZhbCk7DQo+PiArCWVsc2UNCj4+ICsJCW5hdGl2ZV93
cm1zcnEobXNyLCB2YWwpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgX19hbHdheXNfaW5s
aW5lIGludCB3cml0ZV9tc3Jfc2FmZSh1MzIgbXNyLCB1NjQgdmFsKQ0KPj4gK3sNCj4+ICsJ
aWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpKQ0KPj4gKwkJcmV0
dXJuIHhlbl93cml0ZV9tc3Jfc2FmZShtc3IsIHZhbCk7DQo+PiArDQo+PiArCXJldHVybiBu
YXRpdmVfd3JpdGVfbXNyX3NhZmUobXNyLCB2YWwpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0
aWMgX19hbHdheXNfaW5saW5lIHU2NCByZHBtYyhpbnQgY291bnRlcikNCj4+ICt7DQo+PiAr
CWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBWKSkNCj4+ICsJCXJl
dHVybiB4ZW5fcmVhZF9wbWMoY291bnRlcik7DQo+PiArDQo+PiArCXJldHVybiBuYXRpdmVf
cmVhZF9wbWMoY291bnRlcik7DQo+PiArfQ0KPiANCj4gRWdhZHMsIGRpZG4ndCB3ZSBqdXN0
IGNvbnN0cnVjdCBnaWFudCBBTFRFUk5BVElWRSgpcyBmb3IgdGhlIG5hdGl2ZV8NCj4gdGhp
bmdzPyBXaHkgd3JhcCB0aGF0IGluIGEgY3B1X2ZlYXR1cmVfZW5hYmxlZCgpIGluc3RlYWQg
b2YganVzdCBhZGRpbmcNCj4gb25lIG1vcmUgY2FzZSB0byB0aGUgQUxURVJOQVRJVkUoKSA/
DQoNClRoZSBwcm9ibGVtIEkgZW5jb3VudGVyZWQgd2l0aCB1c2luZyBwdl9vcHMgd2FzIHRv
IGltcGxlbWVudCB0aGUgKl9zYWZlKCkNCnZhcmlhbnRzLiBUaGVyZSBpcyBubyBzaW1wbGUg
d2F5IHRvIGRvIHRoYXQgdXNpbmcgQUxURVJOQVRJVkVfPG4+KCksIGFzDQppbiB0aGUgWGVu
IFBWIGNhc2UgdGhlIGNhbGwgd2lsbCByZW1haW4sIGFuZCBJIGRpZG4ndCBmaW5kIGEgd2F5
IHRvDQpzcGVjaWZ5IGEgc2FuZSBpbnRlcmZhY2UgYmV0d2VlbiB0aGUgY2FsbC1zaXRlIGFu
ZCB0aGUgY2FsbGVkIFhlbiBmdW5jdGlvbg0KdG8gcmV0dXJuIHRoZSBlcnJvciBpbmRpY2F0
b3IuIFJlbWVtYmVyIHRoYXQgYXQgdGhlIGNhbGwgc2l0ZSB0aGUgbWFpbg0KaW50ZXJmYWNl
IGlzIHRoZSBvbmUgb2YgdGhlIFJETVNSL1dSTVNSIGluc3RydWN0aW9ucy4gVGhleSBsYWNr
IGFuIGVycm9yDQppbmRpY2F0b3IuDQoNCkluIFhpbidzIHNlcmllcyB0aGVyZSB3YXMgYSBw
YXRjaCB3cml0dGVuIGluaXRpYWxseSBieSB5b3UgdG8gc29sdmUgc3VjaA0KYSBwcm9ibGVt
IGJ5IGFkZGluZyB0aGUgX0FTTV9FWFRBQkxFX0ZVTkNfUkVXSU5EKCkgZXhjZXB0aW9uIHRh
YmxlIG1ldGhvZC4NCkkgdGhpbmsgdGhpcyBpcyBhIGRlYWQgZW5kLCBhcyBpdCB3aWxsIGJy
ZWFrIHdoZW4gdXNpbmcgYSBzaGFkb3cgc3RhY2suDQoNCkFkZGl0aW9uYWxseSBJIGZvdW5k
IGEgcmF0aGVyIHVnbHkgaGFjayBvbmx5IHRvIGF2b2lkIHJlLWl0ZXJhdGluZyBtb3N0IG9m
DQp0aGUgYmFyZSBtZXRhbCBBTFRFUk5BVElWRSgpIGZvciB0aGUgcGFyYXZpcnQgY2FzZS4g
SXQgaXMgcG9zc2libGUsIGJ1dCB0aGUNCmJhcmUgbWV0YWwgY2FzZSBpcyBnYWluaW5nIG9u
ZSBhZGRpdGlvbmFsIEFMVEVSTkFUSVZFIGxldmVsLCByZXN1bHRpbmcgaW4NCnBhdGNoaW5n
IHRoZSBvcmlnaW5hbCBpbnN0cnVjdGlvbiB3aXRoIGFuIGlkZW50aWNhbCBjb3B5IGZpcnN0
Lg0KDQpBbm90aGVyIGJlbmVmaXQgb2YgbXkgYXBwcm9hY2ggaXMgdGhlIGRyb3BwaW5nIG9m
ICIjaW5jbHVkZSA8YXNtL3BhcmF2aXJ0Lmg+Ig0KZnJvbSBtc3IuaCwgd2hpY2ggaXMgbWFr
aW5nIGxpZmUgYSBsaXR0bGUgYml0IGVhc2llci4NCg0KDQpKdWVyZ2VuDQo=
--------------dMBscmw5LmvOz0wWFtddEw66
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------dMBscmw5LmvOz0wWFtddEw66--

--------------SnAjFPsvrro8lhJGEyYEiJll--

--------------EDjdRPJRmmUK5bP0S1o6gxj8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjbnLwFAwAAAAAACgkQsN6d1ii/Ey8j
Ngf/VhebFnmOYuETy4RiRDShiplntQglNhvDrVEDyiRLy20bM8s5hGdcLlc5Ssv2N8wntccp4htO
cF31CpnEhQS88HO7CbdPODQ8YKH1jlN8O00AsgRcnllqRgkpv83VzAGMyqyjHiAhCYsoDdrO3Kfk
kgj30NsD+ftCgYzYmd1MwMQ0k0XcjRQ5mBLspsF3XtSUJKQwrhyP+5y6OBQnMmzWSbHncqrAdpGi
CC9OZfIq3E6H9GbKVkVBul4kSjewsKQGXlpZTaE95Bsq2oKjR4aElYvfPqRqSKhroCdcNjZDRQJp
0jFNZkvzBmshvDti9g0rJCROakm32uq0FwPmlX6PhA==
=CfFP
-----END PGP SIGNATURE-----

--------------EDjdRPJRmmUK5bP0S1o6gxj8--

