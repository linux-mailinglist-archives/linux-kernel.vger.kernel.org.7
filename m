Return-Path: <linux-kernel+bounces-838777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40869BB01D2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECBF4C04EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0B62C0290;
	Wed,  1 Oct 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RZdUiXfb"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767A276050
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317403; cv=none; b=jadswKZiwxaOw+DoazVU8EBSeP+bOIq+UnLBjnLi61bcd2WwjX6zmKSbOQaDFX6DtVugdYlaCmekwcOQGB4FrblMguS1oITA9d/aEnRqbWMA1HYDm0kmy9smrHJEe2AweRCktXmAHTYmxGkIlMG91QUwEVS/vFT5GhtkdD0MDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317403; c=relaxed/simple;
	bh=Us3RGNaosu6Fbav2WvygvsP9QipjQ7koJivgMjJkE1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dh32/JFO5ef9gNeAzatUA0FLW7UpVeWdEjlCQ4+SO6j/1hYQcgaSlpYX3Q+zX+wPTXokp9I/5dtQMLY8+Xcxw3ZR9V1I5lk//YM9w1N5z76uJfzbiaZ3Bj6GvWXOhpYH8CLkubBrnwy4MiPXWF5oDFPqRIBI9wVmyZXblbAtv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RZdUiXfb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso4821037f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759317400; x=1759922200; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Us3RGNaosu6Fbav2WvygvsP9QipjQ7koJivgMjJkE1o=;
        b=RZdUiXfbih+vLz2o1vqyCI6Z6f4a96JUdbLp6qmssqL/RGZfFPWXBzg07Cl0IoSGix
         p9L9n7AkNLlFiUYOovY0l75vq7Q0jOwaVP1rARoP4aL3BtVz2txn/KIdAWlGSoKn2/LK
         VpQ/S9ZDl8XeEZIMy3I5cqeTtgUmWItqtiBynUiG6YGssa0+LX6KuQm0IY049pfUc8U8
         PfsRedyn0P811hOiWgIUYP5htrWuCeyiZ1f97ZWzs/gcXM5z+Q7ZOKUBnX2OWlAkkxkm
         oSx2OcsLBhleA6Nj1co6n9sshTY8eXYc66clKOXcUh40DIY0xagWwExkxAINlLftan5U
         cbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317400; x=1759922200;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Us3RGNaosu6Fbav2WvygvsP9QipjQ7koJivgMjJkE1o=;
        b=mFZa3F/2amOi9+gx/COk4nFeh1ZekBb65KsDmUF0FaLRVaVamluh66OHIXWfUZZrRg
         vivRnUfauzHaPZHfLF4Yx941d+4uVjpvYC9I2PIyWL3YViWx3xZ6u6L72FYK2INBhBp+
         BRchEeqm2Ih1WNZmbcbCM3VXdc6CtPzNSjHMl2xcjzGV/5K6vI1vMfBMBqdJmDBWIKC4
         HFHUGp8wdES8YPIWafnN6kRHSJxbgOTRs11zMCveB8OqSw5MLU/lQ87riikVIPdzULYh
         Kdb29iK+DkkzEDlHNpdmEm97qjh9J02DqMMmZsFX0n4ueCcyTSmcTg6dqGEiJ9T56Fhw
         svhA==
X-Gm-Message-State: AOJu0YzBxz6/Tqfg12weS575ACg/q2jB9IMxxAKxbqXBEMeb9YHDOK4S
	OYOBAFLoSdawgl7vXTX0NCDc+o6AIsjHWFpuhZnqt28YAbhygnRljMbbfP80jQBf9ag=
X-Gm-Gg: ASbGnctBy9cY3EUS+mW9TabmqaTM5RlBnRRRLdyZ5Wm7Lv83VY0PnPeMDxRc0bNFRPB
	NjahpA2doGZsvZMp88USZv+7tYo4WGK4QFXHOgk93cXzF012BCWnoC8x+l1L0SvYDifnAkT8fL4
	Cv6xQrpy1fN4yun6xDLF0BFuiagxuLp/aVkWsRvLX4WCgBar8rUhkFxw1Y3YZLKeDBjee7p15qI
	Ditw4UnDKQsRlYND8zsURjf/pcTHifTp5E+N9dH2V6+9KYwzI6ofW4/M2rXLr+7UoVfnl3v22KL
	0VuEWGdODS+ZZw1e3q/5j6OOra5fmLcnksXpEhioH9kqL5UQIpFU47vBUoM5O61ce+XzlcaZ+cH
	WhvDqNmcHQo3Ox0zOd2WfRTvv5Zsb8ucbMXFVo4uw8eDwSX0mAvAcnf9gFUcJHc/UeVY7LCZZJ+
	rVwmhd+U0tvnhvdvn57L2YAXnQdB6zJWQDtKjs0izV1ZuzRzEv9U9CzNuTCDVWLh1rPoe1
X-Google-Smtp-Source: AGHT+IE3kn0a8NENdjniwIU+j5OhXQ7l6Mqi1AUfdoXpvXHg54S60H217hWk1sPQ5YXIt2pzwDTNuA==
X-Received: by 2002:a05:6000:2890:b0:3ea:5f76:3f72 with SMTP id ffacd0b85a97d-42557819067mr2114616f8f.49.1759317400007;
        Wed, 01 Oct 2025 04:16:40 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602eccsm28161371f8f.40.2025.10.01.04.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 04:16:39 -0700 (PDT)
Message-ID: <293e8808-e239-412e-90bc-d13f671c6061@suse.com>
Date: Wed, 1 Oct 2025 13:16:38 +0200
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
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
 <b2e07601-80d9-4a6e-a60a-6667d679494c@suse.com>
 <20251001105058.GP3419281@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20251001105058.GP3419281@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------stGGOZiUldAj0mBmUveXWqFJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------stGGOZiUldAj0mBmUveXWqFJ
Content-Type: multipart/mixed; boundary="------------4T6xgb6eVG0okff40kDFOmcJ";
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
Message-ID: <293e8808-e239-412e-90bc-d13f671c6061@suse.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
 <b2e07601-80d9-4a6e-a60a-6667d679494c@suse.com>
 <20251001105058.GP3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251001105058.GP3419281@noisy.programming.kicks-ass.net>

--------------4T6xgb6eVG0okff40kDFOmcJ
Content-Type: multipart/mixed; boundary="------------oKxEWqnJU7tMmPI6qyZDPyGJ"

--------------oKxEWqnJU7tMmPI6qyZDPyGJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMTAuMjUgMTI6NTAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQsIE9j
dCAwMSwgMjAyNSBhdCAxMDo0OTozMUFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4+IFRoaW5raW5nIG1vcmUgYWJvdXQgdGhhdCBJIGJlbGlldmUgdGhlcmUgYXJlIGFk
ZGl0aW9uYWwgcHJvYmxlbXM6DQo+Pg0KPj4gSGF2aW5nIG92ZXJsYXBwaW5nIGFsdGVybmF0
aXZlcyBub3Qgc3RhcnRpbmcgYXQgdGhlIHNhbWUgYWRkcmVzcyB3aWxsIHJlc3VsdA0KPj4g
aW4gcHJvYmxlbXMgd2l0aCBsZW5ndGggcGFkZGluZyBvZiB0aGUgb3V0ZXIgYWx0ZXJuYXRp
dmUgaW4gY2FzZSB0aGUgaW5uZXINCj4+IG9uZSBzdGFydGluZyBsYXRlciBpcyBleHRlbmRp
bmcgcGFzdCB0aGUgZW5kIG9mIHRoZSBvdXRlciBvbmUuIFRoaXMgbWlnaHQgYmUNCj4+IHBv
c3NpYmxlIHRvIGhhbmRsZSwgYnV0IGl0IHdpbGwgYmUgdGVkaW91cy4NCj4gDQo+IFllcywg
dGhpcyBtdXN0IG5vdCBoYXBwZW4uDQo+IA0KPj4gVXNpbmcgeW91ciBpZGVhIHdpdGggcHZf
b3BzIGNvdWxkIHJlc3VsdCBpbiB0aGUgaW5uZXIgYWx0ZXJuYXRpdmUgbm90IGJlaW5nDQo+
PiBhdCB0aGUgc3RhcnQgb2YgdGhlIG91dGVyIGFsdGVybmF0aXZlIEFORCBiZWluZyBub3Qg
dGhlIGluaXRpYWwgY29kZS4gVGhpcw0KPj4gd291bGQgcmVzdWx0IGluIHBhdGNoaW5nIGlu
IHRoZSAuYWx0aW5zdHJ1Y3Rpb25zIGFyZWEgaW5zdGVhZCBvZiB0aGUgbm9ybWFsDQo+PiAu
dGV4dCBzaXRlLCByZXN1bHRpbmcgaW4gcG9zc2libGUgbG9zcyBvZiBhIHBhdGNoaW5nIGFj
dGlvbiBpZiB0aGUgcGF0Y2hlZA0KPj4gYXJlYSB3b3VsZCBoYXZlIGJlZW4gdXNlZCBhcyBh
IHJlcGxhY2VtZW50IGJlZm9yZS4NCj4gDQo+IE5vdCBxdWl0ZSwgdGhlIG5lc3RlZCBhbHRl
cm5hdGl2ZSB3YXMgaW4gdGhlIG9yaWdfaW5zbiBwYXJ0LiBTbyBpdCB3b3VsZA0KPiByZXN1
bHQgaW4gcGF0Y2hpbmcgdGhlIG9yaWcgdGV4dCB0d2ljZSwgb25jZSBmcm9tIHRoZSBpbm5l
ciAod2hpY2ggY29tZXMNCj4gZmlyc3QgaW4gdGhlIHBhdGNoIGxpc3QpIGFuZCB0aGVuIG9u
Y2UgYWdhaW4gZnJvbSB0aGUgb3V0ZXIgKHdoaWNoIGNvbWVzDQo+IGxhdGVyKS4NCg0KWWVz
LCBidXQgdGhhdCB3YXMgdGhlIG5hdGl2ZSBjYXNlIG9ubHkuDQoNCldpdGggcHZfb3BzIHRo
aXMgd291bGQgbWVhbiB0aGUgb3JpZ2luYWwgaW5zdHJ1Y3Rpb24gd291bGQgYmUgdGhlDQpw
YXJhdmlydC1jYWxsLCByZXN1bHRpbmcgaW4geW91ciBjb25zdHJ1Y3QgYmVjb21pbmcgYW4g
aW5uZXIgbmVzdGluZyBsZXZlbC4NCg0KPiANCj4+IFNvIGluIG15IG9waW5pb24gYWxsb3dp
bmcgYWx0ZXJuYXRpdmVzIHRvIG5lc3Qgd2l0aG91dCBhbGwgaW5uZXIgbGV2ZWxzDQo+PiBz
dGFydGluZyBhdCB0aGUgc2FtZSBsb2NhdGlvbiBhcyB0aGUgb3V0ZXJtb3N0IGxldmVsIHdv
dWxkIGJlIGEgcmVjZWlwdCBmb3INCj4+IGZhaWx1cmUuDQo+IA0KPiBDZXJ0YWlubHkgdHJp
Y2t5LCBubyBhcmd1bWVudCB0aGVyZS4NCj4gDQo+PiBJIHRoaW5rIEknbGwgd3JpdGUgYW5v
dGhlciBwYXRjaCB0byBCVUcoKSBpbiBjYXNlIHN1Y2ggYSBzaXR1YXRpb24gaXMgYmVpbmcN
Cj4+IGRldGVjdGVkLg0KPiANCj4gRmFpciBlbm91Z2g7IHdlIHNob3VsZCBub3QgY3VycmVu
dGx5IGhhdmUgYW55IHN1Y2ggY2FzZXMuIEFuZCBnb2luZyBieQ0KPiBteSBhdHRlbXB0IHRv
IG1ha2UgaXQgd29yaywgaXRzIGdvaW5nIHRvIGJlIHJlYWxseSB0cmlja3kgaW4gYW55IGNh
c2UuDQo+IA0KPiBCdXQgcGxlYXNlIHB1dCBvbiBhIGNvbW1lbnQgb24gd2h5LCB3aGljaCBl
eHBsYWlucyB0aGUgY29uc3RyYWludHMuDQoNCkFncmVlZC4NCg0KDQpKdWVyZ2VuDQo=
--------------oKxEWqnJU7tMmPI6qyZDPyGJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------oKxEWqnJU7tMmPI6qyZDPyGJ--

--------------4T6xgb6eVG0okff40kDFOmcJ--

--------------stGGOZiUldAj0mBmUveXWqFJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjdDZYFAwAAAAAACgkQsN6d1ii/Ey9z
OQf/SGJnn0Hc/EimivqwivrZCFAAtusnZFV/gXCrv1hLYoY00cJFqCJlF41MG2vWhyzfIrOAEFds
WMJxoSTu9YpqLa3qA5Njvm1+S/cudRGYiHTCumPUFpr/k1FY24PlOekDNMzqW2/Ib3t9Qs1bvb0S
0SK/9Ti3z+osBj9oEeCgag99MA3yqTzX3Afvpy7g35lfkl4VtR0YOLmkZsFwc0ke4vx74Lg8dS8p
GNKJpBjK/5jwFXLND3LJqi5oHQ2+R47S3p71iOMabM0KNINzY2jPO7c6Y2B0FqbmXoV/xx6cbg3S
aEgrlVNCU3XFfZCds3ITp40wojRGO7T4DDbXe5+ddw==
=QyLQ
-----END PGP SIGNATURE-----

--------------stGGOZiUldAj0mBmUveXWqFJ--

