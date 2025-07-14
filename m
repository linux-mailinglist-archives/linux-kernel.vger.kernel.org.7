Return-Path: <linux-kernel+bounces-729552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D6B0384C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8C9174376
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1E2367AD;
	Mon, 14 Jul 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LFMLqK5a"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCD2E371E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479455; cv=none; b=VZc3e4cnn4l0P8SugCEJhU4JPQvn/tcz5UxXjFMnnAO2D3jlu9LjDU4Gm0GnUAMa9EL7DV1k13KAGdgriDx2TRjZbaE2XpDdpdxs85QxMtVKvf9V4OzlbehY75pvUb/xN+IEO5S2eg+vgDmMqkA+UytHABPHjuJ0141WtASzuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479455; c=relaxed/simple;
	bh=xIldg95nRXPC6sI29lFSjNy87gD6mmspWkvCoiW8Huo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4P59h7zZZeMMDLz7U0u/mu421QgfPBW8IbNfqDauIRZCeTgIZxmZEwwYTex0sS91ZJgDszZAY/W/HqXg4+qHAyEwxK65GXwWrkygIVWx5o5LvKyqcW6lRX/ugk+KadwOSmmBu7H7ybr9xw8gMvW6/MJTM8gcJmsNT329RrP4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LFMLqK5a; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso3115909f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752479449; x=1753084249; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIldg95nRXPC6sI29lFSjNy87gD6mmspWkvCoiW8Huo=;
        b=LFMLqK5ajcKD5Z8d+rjDQMgwuBVGKH/nul+DgVNLNxpItqhlGkF6TtuMTOq85lHNrX
         eteSpoPEKnm9K3Bi5fFNgiwAG1/ATmXvr+6Jy/4zPuJ2eiFZYzA6gwfVeCrpG1u28l+o
         xLjEELO5AT9e33L2GaEjlg8bLOKDaV2QESC9lRCxtXQtOcO8svCBESb5QYmrw32NfF8w
         PQx/Kyj1Ph7P4PDRfWLaxxKKkbC0vAo0Ia+k/B+qR7QGR0TD9WdmW6Sgt0jhoDWuDDG9
         ArqF1m35DGYrswCnRLlfrj0Vo822aU00h8sBxCMXoCy+B/9CqQgoacl9EV8ZMJ5pIKWl
         cVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479449; x=1753084249;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIldg95nRXPC6sI29lFSjNy87gD6mmspWkvCoiW8Huo=;
        b=Mh4bc4L+rwvgXXNA239TRG39VXL2QRFOwT487ArgZaoqJw6HzThM3KmL8hMKQXOLul
         /QDQhilt2KPI8nXURLzs53oA7RUUhl/lAe0pvDIhOEDCfmVsPgIAxkYs2Smet9toHeBx
         gSFwX2hA7w47TBZ6cuX7l0W5Qsl22Qi5Vd1iHEltKv0qrfNdLPPNfH4BxnJsukkHPwJt
         JGENY7I9hU6VujHQkSoOtgz7M5JPJ1ubI4YbAfjaqTjVw4IttQZ8VP8vsdFEW/2cqihx
         ay7FIjqQibFm8NgyA/WUMoTlmhI9uRlfwDwMAihyiJH/LZlBg6TWUNmTIjMeqTugSpe9
         3Qfw==
X-Forwarded-Encrypted: i=1; AJvYcCVWMtdTPF7SlFIDSmOyfjlhy1AfzvhKGeQOKyekOVEsYz6b7dzUM1mhs60MTYsdKnnWJn9BxcPlhKu/aV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydeWW+jqT4dBBcQJ3/mDopGoSYjUPMsqw9gQz1NEIqL4DhRc5w
	ktl8GlzqlWbr+B3DSzOkWpLEseE1PR4Pk6hnbhOwOfS81JqQR0d222K6ytgoocsbN7I=
X-Gm-Gg: ASbGnctyxbv9FJXutDaOTWMh9amVrD5E+kcvCsm0DueN+IR//pFHf++kq0xnvMKT6/s
	xp8vWTVkXqzAlEuBgFHupaC8zFGbHeQBR3TlCRcJ8LP8F8VZryuqD9Axro/LDElXZbyNRKwvy97
	0skUeZTDKLVCsIFk92AGzx2Hf9Wz3SFjL/fe8l4fY6Il5DLADYU4rGV3HtDaTfxtYnZMlY00tzU
	io+5IR4irOp+6sUFRL08uPo8jDM2CUWJVQDjAI8J5R5Ft6wC4mLSA2qtFUnePl39u+xHI8bnT7u
	DOXetVTRy7Pr1VSiQnv16x9cwcovT9GuwBe3K89c7wCO4hau0/wjKWzOxVJGP9FQcIpIXACP4Fh
	/gMhJxqNYHmWVF26u8acGvjIjqTZoL1GIM3IJ4fofCxCnyiaj5JjuTTxFE65yD+4ZJqGvHzdHg8
	tu994BEmtKg4gstvBaHqvtJPQYKG5p8KIXtqFI411p8G0K
X-Google-Smtp-Source: AGHT+IGfstpqer0pnI0ZFNlrjA2M5XcNhZGtJxASA8rbVo6oCGZUGTo41nfDvVJEdgE7geJapCKDWg==
X-Received: by 2002:a05:6000:2dc3:b0:3a4:f6ed:767a with SMTP id ffacd0b85a97d-3b5f18d989fmr10479310f8f.38.1752479449509;
        Mon, 14 Jul 2025 00:50:49 -0700 (PDT)
Received: from ?IPV6:2003:e5:8709:f00:6357:915b:11f9:6d20? (p200300e587090f006357915b11f96d20.dip0.t-ipconnect.de. [2003:e5:8709:f00:6357:915b:11f9:6d20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm164848045e9.6.2025.07.14.00.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 00:50:49 -0700 (PDT)
Message-ID: <d3844036-c1f0-427f-824e-d4e8d0d890e4@suse.com>
Date: Mon, 14 Jul 2025 09:50:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: Remove some deadcode (x)
To: linux@treblig.org, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250713132625.164728-1-linux@treblig.org>
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
In-Reply-To: <20250713132625.164728-1-linux@treblig.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------njMfApSgwR0gpdCDJ80Slmx2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------njMfApSgwR0gpdCDJ80Slmx2
Content-Type: multipart/mixed; boundary="------------oznbd1bzWMDUnRIqUV7Nmirj";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: linux@treblig.org, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <d3844036-c1f0-427f-824e-d4e8d0d890e4@suse.com>
Subject: Re: [PATCH] xen: Remove some deadcode (x)
References: <20250713132625.164728-1-linux@treblig.org>
In-Reply-To: <20250713132625.164728-1-linux@treblig.org>

--------------oznbd1bzWMDUnRIqUV7Nmirj
Content-Type: multipart/mixed; boundary="------------WBTmppGMVAVGGcQg7lQUzRqO"

--------------WBTmppGMVAVGGcQg7lQUzRqO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDcuMjUgMTU6MjYsIGxpbnV4QHRyZWJsaWcub3JnIHdyb3RlOg0KPiBGcm9tOiAi
RHIuIERhdmlkIEFsYW4gR2lsYmVydCIgPGxpbnV4QHRyZWJsaWcub3JnPg0KPiANCj4gUmVt
b3ZlIHRocmVlIHVuY2FsbGVkIGZ1bmN0aW9uczoNCj4gDQo+ICAgIHhlbmJ1c19ta2Rpcigp
IHdhcyBhZGRlZCBpbiAyMDA3IGJ5DQo+IGNvbW1pdCA0YmFjMDdjOTkzZDAgKCJ4ZW46IGFk
ZCB0aGUgWGVuYnVzIHN5c2ZzIGFuZCB2aXJ0dWFsIGRldmljZSBob3RwbHVnDQo+IGRyaXZl
ciIpDQo+IGJ1dCBoYXMgcmVtYWluZWQgdW51c2VkLg0KPiANCj4gICAgeGVuX2dldF9ydW5z
dGF0ZV9zbmFwc2hvdCgpIGxhc3QgdXNlIHdhcyByZW1vdmVkIGluIDIwMTYgYnkNCj4gY29t
bWl0IDZiYTI4NmFkODQ1NyAoInhlbjogc3VwcG9ydCBydW5xdWV1ZSBzdGVhbCB0aW1lIG9u
IHhlbiIpDQo+IHdoaWNoIHJlcGxhY2VzIHRoZSB1c2UgYnkgdGhlIF9jcHUgdmVyc2lvbi4N
Cj4gDQo+ICAgIHhlbl9yZXN1bWVfbm90aWZpZXJfdW5yZWdpc3RlcigpIGxhc3QgdXNlIHdh
cyByZW1vdmVkIGluIDIwMTcgYnkNCj4gY29tbWl0IDE5MTRmMGNkMjAzYyAoInhlbi9hY3Bp
OiB1cGxvYWQgUE0gc3RhdGUgZnJvbSBpbml0LWRvbWFpbiB0byBYZW4iKQ0KPiANCj4gUmVt
b3ZlIHRoZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0
IDxsaW51eEB0cmVibGlnLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpn
cm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=
--------------WBTmppGMVAVGGcQg7lQUzRqO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------WBTmppGMVAVGGcQg7lQUzRqO--

--------------oznbd1bzWMDUnRIqUV7Nmirj--

--------------njMfApSgwR0gpdCDJ80Slmx2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmh0ttgFAwAAAAAACgkQsN6d1ii/Ey+Y
ygf/WmMTqV3T8Yvag5xY8Pf42LvKU5So8M7IyHu1RbbkN8xc6BXig4V1jLvvWEaBrUR8WjxfYqQg
Vew9sbWztI7c7zzxwKTxFPVxGNGNONDAbqHTrDeUJ61mVz6AefEBE7YR2397lAj9//7oZuC27FK8
pdfK9tE6v7ma5YkstPTL71VQ35PzVd7NxFd3MEnhPyKAycT6MEFckr1xZ64CKWW/MXApmlM9TpAj
qXx+iRWYnd5fjdOLqePNmpmzBQvfmYeTGTqX59eECBQbkwMrUabHPTGvYLRpFBUZH1bd/h5/Mbh2
Ea6kS9NlgSTiQZL1gWAisHOZUKUylkroKdfTc3dhIA==
=aj7k
-----END PGP SIGNATURE-----

--------------njMfApSgwR0gpdCDJ80Slmx2--

