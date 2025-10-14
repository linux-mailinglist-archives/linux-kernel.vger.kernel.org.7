Return-Path: <linux-kernel+bounces-852811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF56BD9F87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694531926E66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB472030A;
	Tue, 14 Oct 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L3IFsbrM"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD626E16E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451736; cv=none; b=ShlGQSGm0wPmX8mfLoHx5RET9iVaJDIzs2UR3On/6lbMt3G04xa5Ifv1Zioj0jXTMm/lFeGIPZmyNYQrVCiUtHYCea8Os5HhtRM42GTLu1vlWoyCyADwNCr/O43r00LUuq2Ber1VSqu6d89CIrqaAQHn6fO9i0PgyEWYsWtgnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451736; c=relaxed/simple;
	bh=GABh/HKduyrdGwr6xAzRNBvFzSjhx/HBjrWVKj2D8ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs2K6eS4s337tu03RFKUgnzqBprLB8ufXZQqYNh+IGo+p3U9ADoUWKBHQkqwH0wif97Zu09TfyZiaS1+kZwNANy3Y0fOA6PLMNsD2+lhyvrmGJNZ5AgOlbK5ITkLmRymQbGMqFalQfMDWYOgnamcNcqJITwNNkeTKdtylryUfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L3IFsbrM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso9397294a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760451732; x=1761056532; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GABh/HKduyrdGwr6xAzRNBvFzSjhx/HBjrWVKj2D8ug=;
        b=L3IFsbrMIwy+HJ0vHQIfoT5Y2DMe9v7o7aQgsZ8pdPgCKAKlCpOdRPxc9OiuVhsWJk
         svzlblO3cPEl2fqYSfJwQ+tR00Bk0hlVyAa+Nfaz9zefBxWLYDRfEaVNt78mxlM2bv5Z
         INF842MK50B776daUWajfTIoo2KNxHepzUOoo1ZlUQbmjOJOYhBi8j0OUVAJ6AmkWGjC
         fm2MWZW06F9WH1dsd7Oy7mHD/T6VHrwjlzF9C7/dIpUY/UEkvjJx6Qd5j0oUFCpkCfg3
         B7JvrDGF78sFdAEslJ+mAnrUst0xvVIneqWjWVPRJiZ6CmhivIQSihGJbzAME134UYO1
         k5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760451732; x=1761056532;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GABh/HKduyrdGwr6xAzRNBvFzSjhx/HBjrWVKj2D8ug=;
        b=Y33oOMzsVR0Kmcf/mF6cKxRr8iIan/4fccy+UktDa6jKE7dnlazEKOAwz/N6n6h9aL
         LvqWnxaoknZCLESAq+K08pGECM87ip4SVqCijeOCZYEUYYXcfWYiJDkfah95im+feacC
         t1yWdj4BUvqVO1BvahLhSaffvVOe9kefJGYk125MZFegLIsrQ5OeZmUJHvBhT+E1yxB4
         XRcJPNdFv1qC1KUfbHG7rD36rIt/xGJXv0ko4UDzI6n6lHhnJ+3X9ywKYWvz7b7KFN7X
         GKQRnHkyIdS8WISNhnmiQLc6Y/DTbMB62etnr2zkSXhzJLhco5MY1SUB/mfrMd2yKKLu
         DTyA==
X-Gm-Message-State: AOJu0YxS6siH8ZT/XqGwKQvKLLNTMEaDnkIOANlIujbBUjM9kyPAR+SA
	Xe/ncygjgsnP6QdcK/sr1gTE8pKLWa3m8ZNfXvsMlQ7t5bU6gHDWejUqHga8JjQLPpE=
X-Gm-Gg: ASbGncvTFRM9hsEu1kp3MdidYSn1z1O/eNV2P1EplRmQ7Z1Su//HFtOqQC1YpMag/FD
	xKO2s+6gwjXhD1jYXFl7ZuBpUQBISYk8iECSkfx5VQ0JcL5SZU0KzAI5rq6CexXBgbvL0bmI6hC
	3+j0cUzJlPR/W/NxXxruPz3jhpEANPkYbg+DJ4neUDJGbfckh41knFqwMdB4+nTcqvz7+CCMx1i
	OC7LqFYHoS6ppFTpyOSGYQYvQMckVSwh8LSrELf/47/mMiS6KP/ecYm9ANgu2x36Jg+Fz4yF5LB
	NVs4X7uewMzq1c3TQ6IkYhu6kU/nE6d334zcViC7vC1nziY+68B5wyXjTxBrTSOjk6Byz9tyiSv
	/K+9tNXjPV+c7FH1xhTsY0jc55qmyppAs6+frzSUvJSEv4iLGiKC71VupYOkYeJG1pyzg2oBGzf
	Z2wDU50TttdjSXE3GbHJMcMC6hs4MiyGvOqF534WqkVWfAo5VwrkZuUjHnPAiZF4w=
X-Google-Smtp-Source: AGHT+IFEryBCMQzZcS+YZh3GDTLuErR8aW7aqRI2+9lk2efvQafMbSgKOAgZqB5+G5vNlW8UjTAAPg==
X-Received: by 2002:a05:6402:5192:b0:636:254a:148a with SMTP id 4fb4d7f45d1cf-639d5c50af1mr23142467a12.28.1760451730386;
        Tue, 14 Oct 2025 07:22:10 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c321341sm11215691a12.38.2025.10.14.07.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:22:10 -0700 (PDT)
Message-ID: <c0fb45d5-c4a0-498d-8378-dd96ec261c8c@suse.com>
Date: Tue, 14 Oct 2025 16:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
 <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
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
In-Reply-To: <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7DqoqMWqRP5j585Q36wRWVht"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7DqoqMWqRP5j585Q36wRWVht
Content-Type: multipart/mixed; boundary="------------mhihtJue4y4zSjl30BHWmV6b";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Message-ID: <c0fb45d5-c4a0-498d-8378-dd96ec261c8c@suse.com>
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
 <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
In-Reply-To: <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>

--------------mhihtJue4y4zSjl30BHWmV6b
Content-Type: multipart/mixed; boundary="------------wM49iSEIGTYb7sU0EeNLVo40"

--------------wM49iSEIGTYb7sU0EeNLVo40
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMTAuMjUgMTY6MTIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMTQsIDIwMjUgYXQgMDQ6MDg6NDdQTSArMDIwMCwgSsO8cmdlbiBHcm/DnyB3cm90ZToN
Cj4+IEFuZCBqdXN0IGZvciB0aGUgcmVjb3JkOiBOTUkgaGFuZGxpbmcgaXMgdXNpbmcgQUxU
RVJOQVRJVkVfMiwgc28geW91DQo+PiBjYW4ndCBqdXN0ICJkaXNhYmxlIGludGVycnVwdHMi
IGFuZCBiZSBzdXJlIGl0IHdpbGwgd29yay4NCj4gDQo+IEFyZSB5b3UgZml4aW5nIGFueXRo
aW5nIHlvdSdyZSBhY3R1YWxseSBoaXR0aW5nIHdoaWxlIHBhdGNoaW5nIGFsdGVybmF0aXZl
cyBvcg0KPiBhcmUgeW91IHRhbGtpbmcgaHlwb3RoZXRpY2FsbHkgaGVyZT8NCg0KSSByZWFs
bHkgcmFuIGludG8gaXNzdWVzIHdoaWxlIHdyaXRpbmcgbXkgcGFyYXZpcnQgTVNSIHNlcmll
cywgYXMgSSBoYWQNCmFuIEFMVEVSTkFUSVZFMygpIGludm9jYXRpb24gbW9kaWZ5aW5nIHRo
ZSBvcmlnaW5hbCBpbnN0cnVjdGlvbiAodGhlDQppbmRpcmVjdCBwYXJhdmlydCBjYWxsKSB3
aXRoIGFuIFdSTVNSIGFuZCB0aGVuIHRyeWluZyB0byB0dXJuIHRoZSBubw0KbG9uZ2VyIGV4
aXN0aW5nIGluZGlyZWN0IGNhbGwgaW50byBhIGRpcmVjdCBvbmUuDQoNClNvIEkgZGlkbid0
IGhhdmUgdGhlIGludGVybWVkaWF0ZSBpc3N1ZSBpbiBpbnRlcnJ1cHQgaGFuZGxpbmcsIGJ1
dCB0aGUNCmlzc3VlIHdpdGggcnVsZXMgaG93IHRvIHBsYWNlIGluZGlyZWN0IGNhbGwgcmVw
bGFjZW1lbnRzIGluIEFMVEVSTkFUSVZFbigpDQppbnZvY2F0aW9ucy4NCg0KVGhlIGludGVy
cnVwdCBoYW5kbGluZyBzdGlsbCBtaWdodCBiZSBhIHRoaW5nLCB3aGlsZSBOTUkgaXMgZm9y
IHN1cmUgcmF0aGVyDQp1bmxpa2VseS4NCg0KPiANCj4gQmVjYXVzZSBJIGNhbid0IHRoaW5r
IG9mIGFuIGVhc3kgd2F5IHRvIHRyaWdnZXIgTk1JcyB0aGF0IGVhcmx5IGR1cmluZyBib290
LA0KPiB3aGVuIG5vdCBldmVuIFNNUCBpcyB1cC4NCj4gDQoNCk5NSXMgYXJlIHByb2JhYmx5
IHJlYWxseSBhIG1vcmUgdGhlb3JldGljYWwgaXNzdWUuIEFuZCBldmVuIGlmIE5NSXMgYXJl
DQphZmZlY3RlZCwgdGhleSB3aWxsIHN0aWxsIGJlIGFmZmVjdGVkIGluIGNhc2UgdGhleSBo
YXBwZW4ganVzdCB3aGVuIGhhbGYgb2YNCnRoZSBuZXcgaW5zdHJ1Y3Rpb24gYnl0ZXMgaGF2
ZSBiZWVuIHdyaXR0ZW4uDQoNCg0KSnVlcmdlbg0K
--------------wM49iSEIGTYb7sU0EeNLVo40
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------wM49iSEIGTYb7sU0EeNLVo40--

--------------mhihtJue4y4zSjl30BHWmV6b--

--------------7DqoqMWqRP5j585Q36wRWVht
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjuXJEFAwAAAAAACgkQsN6d1ii/Ey8n
jwf/dS5ihsIeENIqQOOgitaObH3Pkwx/oxBt9Ibg6OHFhrcpZbioy6l0Hy8EXhOQ6Wpe57X680Vz
I2l8NCdzcdmQK2Y2AC2aZR3jyPF1/3XeruevNZ/yjavT2bJa85ty5yACUwHn4xw2bo99jkzOwGUx
+E5rxrJpCkYvJUjN1LzMjNkhkFaJc6fHBZVBRWIN7hhSVlkuz4S5/GBg8VU3z/T4isb7fL4zA+af
X8VpAP2u5WvprzQc+WT3uNij/dqwGkzo5IT7d/x+EDQ/T3Up2N5xF3f305dgOrhFsWJxGhHXhUqH
5/A4zguzWn/ntgGRR3ET5Wfqo0JKnJID16Fvhqy9hQ==
=BuaM
-----END PGP SIGNATURE-----

--------------7DqoqMWqRP5j585Q36wRWVht--

