Return-Path: <linux-kernel+bounces-786466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FBAB35A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AC51898C81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4C30AAA5;
	Tue, 26 Aug 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P3rTKOKn"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D2301460
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204785; cv=none; b=tOUA32kICKwxFRWKL55o7za3a4rFgFj3Z/R6Pypxhm0Tz+fwyCibIC2lXCyEsM9WdxPPuUKWvDRWm27QZqT8HnlecyBAlrZVX10bGgFOt/62Ia1cWtn/nqCSw0HLSu7hpyZnVZedkk+qinCRQFnbhOozQQeVeF7FGz9ZrWgSrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204785; c=relaxed/simple;
	bh=aubxpbk2XtBhI4C5/n2BXN9jWVxK0FlxNqKl7ieYfbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZjFdejMRRjkA8wik/ts8MfIypVMi/ywbfdsqact4GtubQazO33RVzcoYJrsemWPc9H7F31t/hoyww4ce92tKadwdi20gS1M87YJSLEdhrd/clgJVbefJrlav+2NO9NtPor8WJlTI1JCh81pmnqyALAnlxE8xN3Hca3gbv0fMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P3rTKOKn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so8139664a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756204781; x=1756809581; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aubxpbk2XtBhI4C5/n2BXN9jWVxK0FlxNqKl7ieYfbQ=;
        b=P3rTKOKngFfEdDU8bC/qwDXRZduesjQdFGbWiNvu/IHYkSP2WZ1XR79zfhVtn9h/4O
         A/nx6a5XdNlklW1l5Dq+osts43KoBmy3IYPtftkiIXmlat5ubLWkjk0K3V0B+nSuvygC
         UzGot7fkj4z1eGpss9X8XtHZr3KErBky8N7IIsa3mn3nmK7kClzTkuKBHwhJt74QlrrR
         M2JXWhGDGmwrD0vtoX4bMMFdCFhh4OUuPKSIzKWw4PtSODfqB8ksdssdz2aUdg9Gc2YF
         WNkH2BYWwtD2uS0qznpsMjqNYXMQzA9O+fxHWg4Z4P2ZK47dzM9T2hZb8G5KoDFlk1WM
         pBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756204781; x=1756809581;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aubxpbk2XtBhI4C5/n2BXN9jWVxK0FlxNqKl7ieYfbQ=;
        b=ttv0VNNIJVCB1gNmHc8G1faWGirDtBo5MacckiA+9lmvxY72R6rHH5+OfOLnBlu32o
         0ui9dCbLeEwT1UYYL+r1/te25bQsZEkUKoRYRlnp9RphPuW3tgFojp0L8bI/uadmfzAg
         vuW7suAG2n1LoH1Q+avrijJ1bTaeNcgLu45Q8mZjwxCGckozcVRYdWUWZ/x8uMopeqHT
         5vg4ymFmWZbKwpJkyLEEsV/E1wCZclSf6vJO9HdhymM/LcxGNaKTiHXC2LCdcZy1L/p7
         d7Oi90JBUkXLUaXO+kBI0Pfx6KxlOleUCukJe/618ZXr4A43QGGSbLkCWZFcEjlZQqM+
         n19A==
X-Forwarded-Encrypted: i=1; AJvYcCXwS9hdhNcTZIn5J+xreXVCJb7eqT/sMGJFW3DRGDiUpmKtEfFV6WnjkSWwyvaNLkiSppFO2XgX8mBgrN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qIvGBVsEn5B0ZM7Ln00n8U5uwm2riWFaRu4m+uzkumqYi0mg
	tiOg8KsE/9POU0a035el+aMrNNofXkxG1EV8FEYiFMZZSNHkzFzgbTGUeS+t4y2ynj8=
X-Gm-Gg: ASbGncvRn9L+ub1O8pX8VCs8Q5eV7qgHO0E/njsMgyYWumoC6kTv0RJfy5luFLcGnfL
	wZIvKyOqDOxdOtWUIhL+yIycimyuMLa4bPNduwivE8Dx2Hhl0ynKCL/RYJRry7061zOYjtg7iEn
	11o2NDblFX/YZ9qwWbQ8UZmG5o63qXb/UfJNBO7t8GS8ctvkxQ5ZT2SmYHSer7veXy9a4oe0U86
	rYzGeI4DreYK2yBzC+tJpyR7YrBskR8XoNYyUKWd643VC2SgUDq8gapxWKkjtXTup8m3D8X5IwN
	lKKovYkHEcTrv1M+u8B/4jlThpJBVXoIMn6wemKh4BVwkBCGuOZl1HwK9dGXRNmLbB48mgdoBZr
	5uGQB5nREyp/iPY1dQhpWfC1i98ZJNkwrBRf3S5QiZ34hWOeo+XwtMCVuKvvO6n8r7iUq1fMZ2s
	5EoHyeARMEqIbj5YQXFvI+vxsxZDPKwq1TlrVSIq/0P5K+aE3FDhkEaY3YTg==
X-Google-Smtp-Source: AGHT+IGTJ6kJcviN3gx0SsZhG3FYbsFiWuwc5ckYBN7HeTxHud9HajgH67qiuZuS9+NG+NFwi7i4Zg==
X-Received: by 2002:a05:6402:1d49:b0:61c:926e:24fd with SMTP id 4fb4d7f45d1cf-61c926e25dfmr1488413a12.34.1756204781534;
        Tue, 26 Aug 2025 03:39:41 -0700 (PDT)
Received: from ?IPV6:2003:e5:872d:6400:8c05:37ee:9cf6:6840? (p200300e5872d64008c0537ee9cf66840.dip0.t-ipconnect.de. [2003:e5:872d:6400:8c05:37ee:9cf6:6840])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c316f4e10sm6724132a12.29.2025.08.26.03.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 03:39:41 -0700 (PDT)
Message-ID: <6eb60b62-bd3a-4a64-9665-fc911cc7d869@suse.com>
Date: Tue, 26 Aug 2025 12:39:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Andrew Cooper <andrew.cooper3@citrix.com>
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <2365af70-d36f-4663-b819-59d886936ef5@zytor.com>
 <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
 <7047440a-0419-4982-961b-46f9b90a86e9@zytor.com>
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
In-Reply-To: <7047440a-0419-4982-961b-46f9b90a86e9@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RsLXUU2C1CGvpLiam006QHyM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RsLXUU2C1CGvpLiam006QHyM
Content-Type: multipart/mixed; boundary="------------qvfxUhM9j5tB42NwHbcTZLzf";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <6eb60b62-bd3a-4a64-9665-fc911cc7d869@suse.com>
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <2365af70-d36f-4663-b819-59d886936ef5@zytor.com>
 <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
 <7047440a-0419-4982-961b-46f9b90a86e9@zytor.com>
In-Reply-To: <7047440a-0419-4982-961b-46f9b90a86e9@zytor.com>

--------------qvfxUhM9j5tB42NwHbcTZLzf
Content-Type: multipart/mixed; boundary="------------yvNIYITvDlrd0dF2hWkwHAja"

--------------yvNIYITvDlrd0dF2hWkwHAja
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDguMjUgMDM6NTQsIFhpbiBMaSB3cm90ZToNCj4gT24gNi8xMS8yMDI1IDU6NTgg
QU0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBJJ20ganVzdCBkb2luZyBhIFYyIG9mIG15
IHNlcmllcywgYnV0IHRoaXMgdGltZSBpbmNsdWRpbmcgdGhlIGFkZGl0aW9uYWwNCj4+IHN1
cHBvcnQgb2YgdGhlIG5vbi1zZXJpYWxpemluZyBhbmQgaW1tZWRpYXRlIGZvcm1zLiBMZXRz
IHNlZSBob3cgdGhpcyB3aWxsDQo+PiBsb29rIGxpa2UuIEkgd2lsbCBkcm9wIHVzaW5nIHRo
ZSBFQVhfRURYXyogbWFjcm9zLCBidXQgZHVlIHRvIHRoZSByZWFzb24NCj4+IG1lbnRpb25l
ZCBhYm92ZSBJIHdvbid0IHN3aXRjaCB0byB5b3VyIHZhcmlhbnQgY29tcGxldGVseS4NCj4g
DQo+IEhpIEp1ZXJnZW4sDQo+IA0KPiBEbyB5b3UgaGF2ZSBhbnkgdXBkYXRlIG9uIHRoaXM/
DQoNCkkndmUgYmVlbiB2ZXJ5IGJ1c3kgd2l0aCBvdGhlciBzdHVmZiAoZG93bnN0cmVhbSwg
c2VjdXJpdHksIC4uLikuDQoNCkluIGJldHdlZW4gSSd2ZSBiZWVuIHdvcmtpbmcgb24gdGhl
IHNlcmllcy4gSSBob3BlIHRvIHBvc3QgaXQgc29tZSB0aW1lIGluDQpTZXB0ZW1iZXIuDQoN
Cg0KSnVlcmdlbg0K
--------------yvNIYITvDlrd0dF2hWkwHAja
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------yvNIYITvDlrd0dF2hWkwHAja--

--------------qvfxUhM9j5tB42NwHbcTZLzf--

--------------RsLXUU2C1CGvpLiam006QHyM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmitjuwFAwAAAAAACgkQsN6d1ii/Ey/W
VAf/bjOTfxBU5Ic3yxL8cIuWVKFrTuMx8Ynv73k4yHoMT//hTOT0Zeu6iqflODNSpNHcSDDpylbo
u5sZa0LLFzmKhpQGLF8+5RsnWrYCqMNydpYVbs9vCXf9VOl/QDrKBXIUo4KBzrhIIO6+SLzc1HcV
UrVnidE37h8kuKWvIgPTrHdzP81NAg3Nq/AMLccIGowCHmFAWjo49D9x57tfTirIZH3KzZzSYKeQ
/LjQtYhJx5bIQQ/fNns+bkx/uKUVAElX0VUf/B7KaPmsE3zg4hV/w/KDixyfeJFJNHthxrffaSH6
qSKMNizNhEdUMq2TEBSIu9QA7VukkUKXXVuaPop1lA==
=J7f0
-----END PGP SIGNATURE-----

--------------RsLXUU2C1CGvpLiam006QHyM--

