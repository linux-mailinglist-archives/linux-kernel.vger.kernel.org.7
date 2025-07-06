Return-Path: <linux-kernel+bounces-711774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1232AEFF58
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9282E1C05FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0227C145;
	Tue,  1 Jul 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="RIEsf7Kb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA527AC43
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386539; cv=none; b=Ic2m+hkh1shZRw1JWf+GT9Qph+LCuxhHK8xVVnqJwNSYuZrUmUN069EO/L7DZLC+fiMQ5k/pGhbqDpAnrojnLsUm7X3N+BW3MsBgsr+WEwDLl7GPmv2B8dcP8mEpMUY0+5WNra0f1WEE/FTUz/RU+V2F9pQHjopniXzLo/3Xl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386539; c=relaxed/simple;
	bh=GTt5/sJ+Mk7s5SQ9rvLkygWD79RXCHwUxct6jqpRwT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgfluEwUvdAJXJmBCIYjM7QRM/M36EtAcHmTsqhjCcW52ae67qCXplJ6mEVAJKjzFfnRh3HPKiHVhye3g4ZnED4FnxVx3Bv/GtIJ3AjoN8TUgzDHQuBF6wSlyGEvAq/de6qyIHbZxAS2b+4Wa9eN8vxYF4jlvP1/mi+wGoJr8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=RIEsf7Kb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad574992fcaso594539666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1751386534; x=1751991334; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTt5/sJ+Mk7s5SQ9rvLkygWD79RXCHwUxct6jqpRwT4=;
        b=RIEsf7KbN4D9DbAQ9y5cmDpZoNktvMv4u/2i1X4otXkXAh269R7bTiNhz3Kv+Vw+pq
         ++o/VFk4lyTbl7qeNDBsEzrFuocX0wzVeXQvG84EcKlga0fGzaCFgiTCpNdy3XWyooxs
         u37VrCNChXlqID9L8A4M+gY4GtieLAz0l6MaRKrWktn6Nr/oLoC8hSEVBiIPNfpdFiOx
         peMVBuPpupqNt9b91t36WBX7kLrno0JwNfDHoIG/grIYZLV5O2iyDWVUSVlResYVNTZP
         TJUiJG4PoErBLT4BzNOPblP657gMqWrA8qKZ9MWI/Ob/4W741Dbj6c3SGo9uZMCRdhJB
         WF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386534; x=1751991334;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GTt5/sJ+Mk7s5SQ9rvLkygWD79RXCHwUxct6jqpRwT4=;
        b=MedvWqb+yG3O8UHuNvQktDLfiP9MlvA63AKQ6TP0ko1xkhdUFoWCEw8VR9Te/V9Rdp
         yk6QK6fJvGxGIliEDcsGwdBxoxACiUMDn4Hv9laZULVlNjsC+/QEdZt3rEZL9tPaeBIW
         aNTEVzJ4veFhrZXASJZCHo0y//VKLFpGLbteNnSWadToX6ZXUPaSfRB/5NeigHM3w/NJ
         dYPyywWR1A3xdF+KE6oW8yd/Im30HW7CQtwNxWMEJRnl76sEbUNORfFJwG2f8zNrU8+d
         hPtb6q7xnOZbipBk2XcYi5qa2o5bZtnCHzqOEZNhEduEwOnn4DJt6hSrVz3NJfdqdKJX
         lNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqdbIpPNhI3xzWwRVv1TKUIGY0dZSWS97RIVehzzZGS4DR3SCf/WlOwRwx3BW1hSya40e25fY+EauZz0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBkl37Os+Z4KEx06QL30om+RfDTyGW1szgb+cIwSMUUW+8ZdA
	5FAEdF7KOi/SrcS/kfDBYoP2NaBcgFi+VawO4iSoRbUoGoGixD3tcTi/tAHuhwEJ7feYQVtIOsK
	D7nvo
X-Gm-Gg: ASbGncvxQrK5xZLbisNSj6jRZxi9shuwD+4c7HLnKCoinZXUU48ZfPJ6HadGKac73Lk
	i0QLadwasq0q9UdWlMDWEBPEgKdj/DsFPLfpPNZhzoAm/pYieipSNY9gr34CCfhuTvyP4hIfMVt
	aL9BthDu6e8wy4ytnO+EHYEjbzCNIzl8thZchL7QXcAsUnOYC/BEcLkGbB9guS6GrlA2QeiF/Ju
	bOb+rOznGm+ceK6dk13B3p7L9OuR2fxhpJmwfXH2ukS2XrjzKzUvRh9U6lGiy6Qc54xrRK8Azlm
	AlDtQPULuZkcWM3GAPyGy2zgnU/w38xphqqxB6VXNtTj3WUG0P09Zom1OT7LSU1Nd8PWZRe7bzC
	BrYc=
X-Google-Smtp-Source: AGHT+IHDRrGS4QG2DXJxS3K4XAttOAuh4i2xHLQ2wivWs2K6P/3Cgub7X6HeNgNquAO3gOXJdxP+qA==
X-Received: by 2002:a17:907:3d92:b0:ae0:da16:f550 with SMTP id a640c23a62f3a-ae35011ffcbmr1741343766b.49.1751386534125;
        Tue, 01 Jul 2025 09:15:34 -0700 (PDT)
Received: from [10.144.229.245] ([185.254.75.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c83205effsm7656494a12.70.2025.07.01.09.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:15:33 -0700 (PDT)
Message-ID: <8965bd80-2e3b-42ae-b9fa-75ed451fc1e8@9elements.com>
Date: Tue, 1 Jul 2025 18:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel Xe SR-IOV support status
To: Michal Wajdeczko <michal.wajdeczko@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Badal Nilawar <badal.nilawar@intel.com>
References: <72fd3ae7-46da-4203-b583-3fb857e73542@9elements.com>
 <bb783b7b-80d8-4779-a8a4-ad495dd9948c@intel.com>
Content-Language: en-US, de-DE
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
In-Reply-To: <bb783b7b-80d8-4779-a8a4-ad495dd9948c@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cC2U05hPRsY7ye4lhyTNkhJk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cC2U05hPRsY7ye4lhyTNkhJk
Content-Type: multipart/mixed; boundary="------------pfwuG0QEz7MouZuTyKh43yC7";
 protected-headers="v1"
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Badal Nilawar <badal.nilawar@intel.com>
Message-ID: <8965bd80-2e3b-42ae-b9fa-75ed451fc1e8@9elements.com>
Subject: Re: Intel Xe SR-IOV support status
References: <72fd3ae7-46da-4203-b583-3fb857e73542@9elements.com>
 <bb783b7b-80d8-4779-a8a4-ad495dd9948c@intel.com>
In-Reply-To: <bb783b7b-80d8-4779-a8a4-ad495dd9948c@intel.com>

--------------pfwuG0QEz7MouZuTyKh43yC7
Content-Type: multipart/mixed; boundary="------------pqXRW5liqq0nP7KO9H8CH1Du"

--------------pqXRW5liqq0nP7KO9H8CH1Du
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTWljaGFsLA0KDQpPbiAwMS4wNy4yNSAxNjo1MiwgTWljaGFsIFdhamRlY3prbyB3cm90
ZToNCj4gSGkgTWFyY2VsbG8sDQo+IA0KPiBPbiAzMC4wNi4yMDI1IDEzOjQ3LCBNYXJjZWxs
byBTeWx2ZXN0ZXIgQmF1ZXIgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBTdGFydGluZyB3aXRo
IFRpZ2VyIExha2UsIHN1cHBvcnQgZm9yIEdWVC1nIHdhcyBkaXNjb250aW51ZWQgaW4gZmF2
b3Igb2YNCj4+IFNSLUlPViBmb3IgZ3JhcGhpY3MgdmlydHVhbGl6YXRpb25bMV0uIEN1cnJl
bnRseSwgdGhlIHVwc3RyZWFtIFhlDQo+PiBkcml2ZXJzIG9ubHkgc3VwcG9ydCBTUi1JT1Yg
b24gUGFudGhlciBMYWtlLiBUaGUgdGFibGUgYmVsb3cgc3VtbWFyaXplcw0KPj4gdGhlIGN1
cnJlbnQgc3RhdGUgYmFzZWQgb24gdGhlIC5oYXNfc3Jpb3YgZmxhZy4NCj4+DQo+PiB8IElu
dGVsIEdlbiB8IGRybS14ZS1uZXh0WzJdIHwgeGUtZm9yLUNJWzJdIHwgaW50ZWwgbHRzIGk5
MTVbM10gfA0KPj4gfCAtLS0tLS0tLS0gfCAtLS0tLS0tLS0tLS0tLSB8IC0tLS0tLS0tLS0t
LSB8IC0tLS0tLS0tLS0tLS0tLS0tIHwNCj4+IHwgVEdMwqDCoMKgwqDCoMKgIHzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbm8gfCBub8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgdjUuMTXC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4gfCBBREwvUlBMwqDCoCB8wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG5vIHwgeWVzIChkZWJ1ZynCoCB8IHY1LjE1wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwNCj4+IHwgTVRMwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbm8gfCBub8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgdjYuMcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwNCj4+IHwgQVJMwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbm8gfCBub8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgbm/CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4gfCBQVEzCoMKgwqDCoMKgwqAgfMKgwqDCoMKg
wqDCoMKgIHY2LjEzLjEgfCB5ZXPCoMKgwqDCoMKgwqDCoMKgwqAgfCBub8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+IA0KPiBOb3RlIHRoYXQgd2UgYWxzbyBoYXZlDQo+
IA0KPiAgICB8IEFUU00gICAgICB8ICAgICAgICAgICAgIG5vIHwgeWVzIChkZWJ1ZykgIHwN
Cj4gDQoNCkFoLCByaWdodC4gSSBzaG91bGQgaGF2ZSBjbGFyaWZpZWQgdGhhdCB0aGUgbGlz
dCBvbmx5IGluY2x1ZGVzIHBsYXRmb3JtcyANCndpdGggaW50ZWdyYXRlZCBHUFVzLg0KDQo+
Pg0KPj4gSW50ZXJlc3RpbmdseSwgdGhlIHhlL3RvcGljL3hlLWZvci1DSSB0ZXN0aW5nIGJy
YW5jaCBvbmx5IGNvdmVycyBTUi1JT1YNCj4+IHRlc3Rpbmcgb24gdGhlIEFETCBwbGF0Zm9y
bSBhbmQgbm90IHRoZSBNVEwgb3IgQVJMIHBsYXRmb3Jtcy4NCj4+DQo+PiBJcyB0aGVyZSBh
IHJlYXNvbiB3aHkgU1ItSU9WIGhhcyBub3QgeWV0IGJlZW4gZW5hYmxlZCBvbiB0aGUgb3Ro
ZXINCj4+IHBsYXRmb3Jtcz8NCj4gDQo+IFNpbmNlIHBsYXRmb3JtcyBiZWZvcmUgTE5MIGFy
ZSBub3Qgb2ZmaWNpYWxseSBzdXBwb3J0ZWQgYnkgdGhlIFhlDQo+IGRyaXZlciwgd2UgaGF2
ZSBvbmx5IGVuYWJsZWQgU1ItSU9WIG9uIHRob3NlIFNEViBwbGF0Zm9ybXMgd2hpY2ggYXJl
DQo+IGFjdGl2ZWx5IHVzZWQgYW5kIHRlc3RlZCBieSBvdXIgcHVibGljIENJLg0KPiANCg0K
VGhhdCdzIHVuZm9ydHVuYXRlIGJ1dCB1bmRlcnN0YW5kYWJsZS4NCkkgc3VwcG9zZSB0aGlz
IG1lYW5zIHRoZXJlIHdvbid0IGJlIG9mZmljaWFsIHN1cHBvcnQgZm9yIFNSLUlPViBvbiAN
CnBsYXRmb3JtcyB1c2luZyBlaXRoZXIgdGhlIGk5MTUgb3IgWGUgZHJpdmVyLg0KDQo+IA0K
Pj4gQXJlIHRoZXJlIGFueSBwbGFucyBvciB0aW1lbGluZSBmb3IgYWRkaW5nIHN1cHBvcnQg
Zm9yIHRoZW0/DQo+IA0KPiBBRkFJSyBpdOKAmXMgdW5saWtlbHkuIFdoaWxlIGluIGNhc2Ug
b2YgVEdMIHRoZSBlbmFibGluZyBpcyBqdXN0IGENCj4gb25lLWxpbmVyIHBhdGNoIHdpdGgg
bmV3IC5oYXNfc3Jpb3YgZmxhZywgaG93ZXZlciBmb3Igcm9idXN0IE1UTCBpdA0KPiB3b3Vs
ZCByZXF1aXJlIG11Y2ggbW9yZSBTUi1JT1Ygc3BlY2lmaWMgY29kZSB0byBiZSBhZGRlZCwg
YnV0IHRoZXJlIGlzDQo+IG5vIHBvaW50IHRvIGFkZCBhbnl0aGluZyB1bnRpbCB0aG9zZSBw
bGF0Zm9ybXMgaXRzZWxmIHdpbGwgYmUgZnVsbHkNCj4gdGVzdGVkIGluIHRoZSBuYXRpdmUg
bW9kZSAobm9uLXZpcnR1YWxpemVkKS4NCg0KVGhhbmtzIGZvciBjbGFyaWZ5aW5nISBJJ20g
cGFydGljdWxhcmx5IGludGVyZXN0ZWQgaW4gdGhlIHN0YXR1cyBvZiBNVEwgDQphbmQgQVJM
IGJlY2F1c2UgdGhleSBhcmUgdGhlIG1vc3QgcmVjZW50IGdlbmVyYXRpb25zIG9uIHRoZSBt
YXJrZXQuDQpXZSBhcmUgYWxyZWFkeSBleHBlcmltZW50aW5nIHdpdGggU1ItSU9WIG9uIHRo
ZXNlIHBsYXRmb3JtcyB0byBzZWUgaG93IA0Kc3RhYmxlIHRoZXkgYXJlIHBlcmZvcm1pbmcu
DQoNCk1hcmNlbGxvDQoNCj4gDQo+IE1pY2hhbA0KPiANCj4+DQo+PiBLaW5kIHJlZ2FyZHMs
DQo+PiBNYXJjZWxsbw0KPj4gLS0tDQo+PiBbMV0gaHR0cHM6Ly93d3cuaW50ZWwuY29tL2Nv
bnRlbnQvd3d3L3VzL2VuL3N1cHBvcnQvYXJ0aWNsZXMvMDAwMDU4NTU4Lw0KPj4gZ3JhcGhp
Y3MuaHRtbA0KPj4gWzJdIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0veGUN
Cj4+IFszXSBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvbGludXgtaW50ZWwtbHRzDQo+PiBb
NF0gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzYwMzMxNi8NCj4g
DQoNCg==
--------------pqXRW5liqq0nP7KO9H8CH1Du
Content-Type: application/pgp-keys; name="OpenPGP_0xE54B6622A5EDBF61.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE54B6622A5EDBF61.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3DGQYi
-----END PGP PUBLIC KEY BLOCK-----

--------------pqXRW5liqq0nP7KO9H8CH1Du--

--------------pfwuG0QEz7MouZuTyKh43yC7--

--------------cC2U05hPRsY7ye4lhyTNkhJk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEB0muAN3elg6p6gWSpVqlh6ibFBIFAmhkCZ8ACgkQpVqlh6ib
FBI2NhAAuiosZfsk0Qe0+mvTa9/sWoWFYq3dLkr2WKBBEPzKB53zu1rwKuxNvh9b
ZBQUaVXW6cAZuO6BVtU3ImghgkzMVM1k7DZ/ljNV12j12lA9eIMXdVv8fQJWeb+c
m9PLR3rwazR6coUtfhlim+HCByOjmVCCzy4yS0U7/WM1IBBK5OvB4YlmO7K78oWz
jBLftjel4rG4/J9Dz0v+YifE8sGBIxN8KF5yXCyCWQd84JTrjfNlVcf+ifaHEmCV
wkHi9KsqSQ9UiOny3p591IQfT8B3M1gxjFraoVGrZ48hm7J9Q+Zy6Ui1ItTR/jTe
fP4NGW38PzgcZ9IGc8G+5YwMlG3j8rcNQbYUJGYkPnOffmubu6yrXroMtUS16XbV
knovQCZ71nhag3yicUgoN+V3DugEjv5NjCaeEzxT86i+023af0bqSapmUZe7LnQl
sXsLeq66afJCaAH75Td+wc7aRdvRoPAFuZayiz/uhpwgo1gQcJAIVwofTNIt8XLh
c9zuDtQHfgq+nVuJhn9Wbzs2QCNny0h0W4I2bl/zuVmJZ5A2LmoecdtxPMo9sI73
IRhIq48cynvX+Dbu9V702w3tDj5NJ0zssnBlNwr+ZO1FNYXdQ6HNSJdnjnln17SR
zNv6whLO3chqt1V/UkCwG/mlaZPRGS1EJBIAUYZTS1n+ZH7GXEw=
=CB8c
-----END PGP SIGNATURE-----

--------------cC2U05hPRsY7ye4lhyTNkhJk--

