Return-Path: <linux-kernel+bounces-818405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3830B5914E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DB9188CADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615352882A1;
	Tue, 16 Sep 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CpntGtJu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9112857F2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012716; cv=none; b=gx/GZ7o2EVgAxewwBzliUlmPl+qV4mUXBPg+BHak9y+VTUHzbdoOXomQFnQKO7GFoDoC+o2EI8L4bRRkJZMOR35kUDEf7fFHfOEA4z+Z4SSe08c/bs3LfcuEFHlRXKAhvgbfdeySEaO4T5Q0n+7UgEgMN8sWvJ4Tpp3L92ZHvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012716; c=relaxed/simple;
	bh=ryhnbR8ogU3onzbU9s4iXvrz2Sm6U4Ln4HYoL7slWws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=at/MHccEgvlZj8CIQtdP8dOMIFPdvTkE3J6jajbiF80DPq3V0IGCjCYDlnYG2qAVfYy6+X94/jH6rl2Avvl8bmyBS1m5jvRjp9xGL+i7qMFe1yafqfScAQ0+aVQ9OMmYRitCuqDlMc41SZyHjLmMvVM0KhjCEnyCulMs92GiRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CpntGtJu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07d4d24d09so259567066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758012712; x=1758617512; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ryhnbR8ogU3onzbU9s4iXvrz2Sm6U4Ln4HYoL7slWws=;
        b=CpntGtJu+YqnO0KYK8HzsxWPEib76d5lm1gfNEdJnTqAzxqdlaxFhhtLumBYVhDBW2
         Ru12jNfABfUkbie1uGtM1iXqK3GGPvlD9hp3AmHSd5QdlsrFuiUmbfLhJ1PQ8urslWPY
         IUH61tvj9sCONVGHtTPBKQiwt2UW3wx5kMBI7JC5J/R8eAHHsXqJOiTM/SCWdhRC5iq/
         FG6ZZspVPmT6cuFjqqZPHDEMDGeKHgIsoYz/DrVV1zAC8kiPeJe8yFgoPhSm2AaM7UNQ
         hAV2W2delgkdX6FuWC1Pu88LLlBRonBTVxK+Q45FjFynHaIdmvHM+v+6wTsEeCPcyIjg
         A3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012712; x=1758617512;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryhnbR8ogU3onzbU9s4iXvrz2Sm6U4Ln4HYoL7slWws=;
        b=Q/5a+9sekp/1oevVCgf75Hj4Ig1X0uHIN6vE150wANlUrSyrSQXmy3KCgK3aBLWPpa
         52yC6p0zyI+jJ2lmwvhi8fpBWKK9FrdyOqh7b3zQ+j05IZOSsR+/3G+dczVoVldpOPSQ
         bxqaaqlL7bMDnYsGDoFnkPgiX44Z/DMTFQK9+uz6Gr7JzXu80Qk90JydaVIh+21QmEvS
         LhPZNGtcEs8HiFCdPWWVW3ovGh8DH7C4ScDoA4fLFvvwInN0FXNJIVYXbrmKhMUe+9tb
         JsKYBlaNHvmelaLzrDzstx8D41EIfWnXwnSmOz9b+DQnj0TLwHNIgUIFKjUvudpVyjM3
         GMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHpA9CRpG8ze037heRMJRMcRWUat4g6ofhBt9xzsGc15Qf/ayPSzFU8P4ExtLD4aaRdhlNkh/5CXYkUQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cFQ4KA34nHPK8lAWqfXEHupl+sg3/H2cVDXyr+zDB2m+qiEv
	vpoWSaF9afYHOU6VRp1pqUtZGZzOgr0G+XejJF+b+SMhrQEBgDI9NS0RtTojYxNux0uyI2tSWii
	47h+P
X-Gm-Gg: ASbGncud5OoyVdKNZo7BDahHz+o4ecQ7DhPo6lpdfi+JbtSY0hln6cwm9gxFaDf07rf
	/2N1dE36/KLSaZHj8OSMMJBLBAWMKgc7VboJZxIJjXap24WC6N9EgjjxzlUrr+mQYCjjhBHCf0E
	Fn2ZfQ32HxRCwZQ99VInKzrL6+wd5AtpzLPhUIcjfL5iG16fEQygIYBJ6JW4GOJOvGEo9+2rKiN
	YutlPdSSbBAYm4HIUNy3ZtDyyBc2n8UJs6H2wsAkEStyrsrU/80wvUf51MzSV4xoLFmKecVMzgd
	4w1tuCCvPFTgO44rvMoSlW0BFj9NsOkU43IPvvMa9YmXXadEvfOks/pVqbrffWZz/qpkew3oFu1
	U4Cf1i73nlS6QQXMx0gErDDy+riRCmqqfQAN/+OgH1Fif8hbLnHu8ON+GPWjUpCm3tVJM51P9CC
	G9JVHS+EjCLPT7rTGHR8pf+3JPC2Ks+ijo4vnu8Luldq8/CI3PJLxy9Aqw+6rW6ZeSGg==
X-Google-Smtp-Source: AGHT+IFl2uAQEwVyyHmp0zS3EApHzi3eMEPaC6gCLX8+a050NpqYZm3PzBd0Rtj2EOvxCv6Hw/DcAQ==
X-Received: by 2002:a17:907:3e1f:b0:b04:25ae:6c74 with SMTP id a640c23a62f3a-b07c354fadbmr1407218166b.9.1758012712061;
        Tue, 16 Sep 2025 01:51:52 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:be00:c26:b971:1ba7:9d8b? (p200300e5873dbe000c26b9711ba79d8b.dip0.t-ipconnect.de. [2003:e5:873d:be00:c26:b971:1ba7:9d8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c28f190fsm929966066b.39.2025.09.16.01.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:51:51 -0700 (PDT)
Message-ID: <af378199-d525-4358-a2b5-0e5393756ff1@suse.com>
Date: Tue, 16 Sep 2025 10:51:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-53283: xen/virtio: Fix NULL deref when a bridge of PCI
 root bus has no parent
To: Greg KH <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
References: <2025091624-CVE-2023-53283-674c@gregkh>
 <46cc57c6-bb57-4423-9fb2-37b5563c4dee@suse.com>
 <2025091624-reluctant-earphone-21a8@gregkh>
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
In-Reply-To: <2025091624-reluctant-earphone-21a8@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lrG1aD7OnZAxzrUaSUXr5fS4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lrG1aD7OnZAxzrUaSUXr5fS4
Content-Type: multipart/mixed; boundary="------------HjjoSMIq7a0z7w0yWntOGnmI";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <af378199-d525-4358-a2b5-0e5393756ff1@suse.com>
Subject: Re: CVE-2023-53283: xen/virtio: Fix NULL deref when a bridge of PCI
 root bus has no parent
References: <2025091624-CVE-2023-53283-674c@gregkh>
 <46cc57c6-bb57-4423-9fb2-37b5563c4dee@suse.com>
 <2025091624-reluctant-earphone-21a8@gregkh>
In-Reply-To: <2025091624-reluctant-earphone-21a8@gregkh>

--------------HjjoSMIq7a0z7w0yWntOGnmI
Content-Type: multipart/mixed; boundary="------------X70j0O4l8pyx9cxd7OjapAV2"

--------------X70j0O4l8pyx9cxd7OjapAV2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDkuMjUgMTA6MzYsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDE2LCAy
MDI1IGF0IDEwOjI5OjI2QU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBPbiAx
Ni4wOS4yNSAxMDoxMSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPj4+IEZyb206IEdy
ZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGtlcm5lbC5vcmc+DQo+Pj4NCj4+PiBEZXNjcmlw
dGlvbg0KPj4+ID09PT09PT09PT09DQo+Pj4NCj4+PiBJbiB0aGUgTGludXgga2VybmVsLCB0
aGUgZm9sbG93aW5nIHZ1bG5lcmFiaWxpdHkgaGFzIGJlZW4gcmVzb2x2ZWQ6DQo+Pj4NCj4+
PiB4ZW4vdmlydGlvOiBGaXggTlVMTCBkZXJlZiB3aGVuIGEgYnJpZGdlIG9mIFBDSSByb290
IGJ1cyBoYXMgbm8gcGFyZW50DQo+Pj4NCj4+PiBXaGVuIGF0dGVtcHRpbmcgdG8gcnVuIFhl
biBvbiBhIFFFTVUvS1ZNIHZpcnR1YWwgbWFjaGluZSB3aXRoIHZpcnRpbw0KPj4+IGRldmlj
ZXMgKGFsbCB4ODZfNjQpLCBmdW5jdGlvbiB4ZW5fZHRfZ2V0X25vZGUoKSBjcmFzaGVzIG9u
IGFjY2Vzc2luZw0KPj4+IGJ1cy0+YnJpZGdlLT5wYXJlbnQtPm9mX25vZGUgYmVjYXVzZSBh
IGJyaWRnZSBvZiB0aGUgUENJIHJvb3QgYnVzIGhhcyBubw0KPj4+IHBhcmVudCBzZXQ6DQo+
Pj4NCj4+PiBbICAgIDEuNjk0MTkyXVsgICAgVDFdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDI4OA0KPj4+IFsgICAgMS42
OTU2ODhdWyAgICBUMV0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBt
b2RlDQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAjUEY6IGVycm9yX2NvZGUoMHgwMDAw
KSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIFBHRCAw
IFA0RCAwDQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBPb3BzOiAwMDAwIFsjMV0gUFJF
RU1QVCBTTVAgTk9QVEkNCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIENQVTogMCBQSUQ6
IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDYuMy43LTEtZGVmYXVsdCAjMSBvcGVu
U1VTRSBUdW1ibGV3ZWVkIGE1NzdlYWU1Nzk2NGJiN2U4MzQ3N2I1YTU2NDVhMTc4MWRmOTkw
ZjANCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3Rh
bmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIHJlbC0xLjE1LjAtMC1nMmRkNGI5
Yi1yZWJ1aWx0Lm9wZW5zdXNlLm9yZyAwNC8wMS8yMDE0DQo+Pj4gWyAgICAxLjY5NjI5N11b
ICAgIFQxXSBSSVA6IGUwMzA6eGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2MrMHhkOS8w
eDFjMA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0gQ29kZTogNDUgMGMgODMgZTggYzkg
YTMgZWEgZmYgMzEgYzAgZWIgZDcgNDggOGIgODcgNDAgZmYgZmYgZmYgNDggODkgYzIgNDgg
OGIgNDAgMTAgNDggODUgYzAgNzUgZjQgNDggOGIgODIgMTAgMDEgMDAgMDAgNDggOGIgNDAg
NDAgPDQ4PiA4MyBiOCA4OCAwMiAwMCAwMCAwMCAwZiA4NCA0NSBmZiBmZiBmZiA2NiA5MCAz
MSBjMCBlYiBhNSA0OCA4OQ0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0gUlNQOiBlMDJi
OmZmZmZjOTAwNDAwMTNjYzggRUZMQUdTOiAwMDAxMDI0Ng0KPj4+IFsgICAgMS42OTYyOTdd
WyAgICBUMV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjg4ODAwNmM3NTAwMCBS
Q1g6IDAwMDAwMDAwMDAwMDAwMjkNCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIFJEWDog
ZmZmZjg4ODAwNWVkMTAwMCBSU0k6IGZmZmZjOTAwNDAwZjEwMGMgUkRJOiBmZmZmODg4MDA1
ZWUzMGQwDQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBSQlA6IGZmZmY4ODgwMDZjNzUw
MTAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogMDAwMDAwMDMzMDAwMDAwNg0KPj4+IFsg
ICAgMS42OTYyOTddWyAgICBUMV0gUjEwOiBmZmZmODg4MDA1ODUwMDI4IFIxMTogMDAwMDAw
MDAwMDAwMDAwMiBSMTI6IGZmZmZmZmZmODMwNDM5YTANCj4+PiBbICAgIDEuNjk2Mjk3XVsg
ICAgVDFdIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IGZmZmY4ODgwMDU2NTc5MDAgUjE1
OiBmZmZmODg4MDA2ZTNlMWU4DQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBGUzogIDAw
MDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODA0YTAwMDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBDUzogIGUwMzAg
RFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+Pj4gWyAgICAxLjY5
NjI5N11bICAgIFQxXSBDUjI6IDAwMDAwMDAwMDAwMDAyODggQ1IzOiAwMDAwMDAwMDAyZTM2
MDAwIENSNDogMDAwMDAwMDAwMDA1MDY2MA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0g
Q2FsbCBUcmFjZToNCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICA8VEFTSz4NCj4+PiBb
ICAgIDEuNjk2Mjk3XVsgICAgVDFdICB2aXJ0aW9fZmVhdHVyZXNfb2srMHgxYi8weGQwDQo+
Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgdmlydGlvX2Rldl9wcm9iZSsweDE5Yy8weDI3
MA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0gIHJlYWxseV9wcm9iZSsweDE5Yi8weDNl
MA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0gIF9fZHJpdmVyX3Byb2JlX2RldmljZSsw
eDc4LzB4MTYwDQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgZHJpdmVyX3Byb2JlX2Rl
dmljZSsweDFmLzB4OTANCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICBfX2RyaXZlcl9h
dHRhY2grMHhkMi8weDFjMA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0gIGJ1c19mb3Jf
ZWFjaF9kZXYrMHg3NC8weGMwDQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgYnVzX2Fk
ZF9kcml2ZXIrMHgxMTYvMHgyMjANCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICBkcml2
ZXJfcmVnaXN0ZXIrMHg1OS8weDEwMA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0gIHZp
cnRpb19jb25zb2xlX2luaXQrMHg3Zi8weDExMA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBU
MV0gIGRvX29uZV9pbml0Y2FsbCsweDQ3LzB4MjIwDQo+Pj4gWyAgICAxLjY5NjI5N11bICAg
IFQxXSAga2VybmVsX2luaXRfZnJlZWFibGUrMHgzMjgvMHg0ODANCj4+PiBbICAgIDEuNjk2
Mjk3XVsgICAgVDFdICBrZXJuZWxfaW5pdCsweDFhLzB4MWMwDQo+Pj4gWyAgICAxLjY5NjI5
N11bICAgIFQxXSAgcmV0X2Zyb21fZm9yaysweDI5LzB4NTANCj4+PiBbICAgIDEuNjk2Mjk3
XVsgICAgVDFdICA8L1RBU0s+DQo+Pj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBNb2R1bGVz
IGxpbmtlZCBpbjoNCj4+PiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIENSMjogMDAwMDAwMDAw
MDAwMDI4OA0KPj4+IFsgICAgMS42OTYyOTddWyAgICBUMV0gLS0tWyBlbmQgdHJhY2UgMDAw
MDAwMDAwMDAwMDAwMCBdLS0tDQo+Pj4NCj4+PiBUaGUgUENJIHJvb3QgYnVzIGlzIGluIHRo
aXMgY2FzZSBjcmVhdGVkIGZyb20gQUNQSSBkZXNjcmlwdGlvbiB2aWENCj4+PiBhY3BpX3Bj
aV9yb290X2FkZCgpIC0+IHBjaV9hY3BpX3NjYW5fcm9vdCgpIC0+IGFjcGlfcGNpX3Jvb3Rf
Y3JlYXRlKCkgLT4NCj4+PiBwY2lfY3JlYXRlX3Jvb3RfYnVzKCkgd2hlcmUgdGhlIGxhc3Qg
ZnVuY3Rpb24gaXMgY2FsbGVkIHdpdGgNCj4+PiBwYXJlbnQ9TlVMTC4gSXQgaW5kaWNhdGVz
IHRoYXQgbm8gcGFyZW50IGlzIHByZXNlbnQgYW5kIHRoZW4NCj4+PiBidXMtPmJyaWRnZS0+
cGFyZW50IGlzIE5VTEwgdG9vLg0KPj4+DQo+Pj4gRml4IHRoZSBwcm9ibGVtIGJ5IGNoZWNr
aW5nIGJ1cy0+YnJpZGdlLT5wYXJlbnQgaW4geGVuX2R0X2dldF9ub2RlKCkgZm9yDQo+Pj4g
TlVMTCBmaXJzdC4NCj4+Pg0KPj4+IFRoZSBMaW51eCBrZXJuZWwgQ1ZFIHRlYW0gaGFzIGFz
c2lnbmVkIENWRS0yMDIzLTUzMjgzIHRvIHRoaXMgaXNzdWUuDQo+Pg0KPj4gUGxlYXNlIHJl
dm9rZSB0aGlzIENWRS4gVGhlcmUgaXMgbm8gd2F5IGFuIHVucHJpdmlsZWdlZCB1c2VyIGNv
dWxkIHRyaWdnZXINCj4+IHRoaXMgaXNzdWUuDQo+IA0KPiBOb3JtYWwgdXNlcnMgY2FuJ3Qg
c3BpbiB1cCBxZW11IGluc3RhbmNlcz8gIEhvdyBkb2VzIHNvbWVvbmUgInN0YXJ0IFhlbiIN
Cj4gbGlrZSB0aGlzPyAgSSB0aG91Z2h0IGFueSB1c2VyIGNvdWxkIGRvIHRoYXQsIG9yIGlz
IHRoaXMgcmVzdHJpY3RlZCB0bw0KPiBvbmx5IHJvb3QgdXNlcnMgc29tZWhvdz8gIEFuZCBp
ZiAic29tZWhvdyIsIHdoYXQgaXMgdGhhdD8NCg0KVGhpcyBjcmFzaCBoYXMgYmVlbiBvYnNl
cnZlZCB3aGVuIHJ1bm5pbmcgWGVuIGluc2lkZSBhIEtWTSBndWVzdC4gVGhlIGNyYXNoDQpo
YXBwZW5lZCBpbiB0aGUgZG9tMCBvZiB0aGF0IFhlbiBpbnN0YW5jZS4gU28gYW55b25lIGJl
aW5nIGNhcGFibGUgdG8gc3RhcnQNCnRoaXMgS1ZNIGd1ZXN0IGlzIGFibGUgdG8gY2F1c2Ug
dGhpcyBjcmFzaCwgYnV0IHRoZSBzYW1lIHBlcnNvbiBjYW4ganVzdA0KdGVybWluYXRlIHRo
ZSBLVk0gZ3Vlc3QgY2F1c2luZyB0aGUgc2FtZSAiZGFtYWdlIi4gSSBkb24ndCB0aGluayBz
b21lb25lDQpjb250cm9sbGluZyB0aGUgS1ZNIGd1ZXN0IGNhbiBiZSBjYWxsZWQgInVucHJp
dmlsZWdlZCIgcmVnYXJkaW5nIHRoZSBndWVzdC4NCg0KDQpKdWVyZ2VuDQo=
--------------X70j0O4l8pyx9cxd7OjapAV2
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------X70j0O4l8pyx9cxd7OjapAV2--

--------------HjjoSMIq7a0z7w0yWntOGnmI--

--------------lrG1aD7OnZAxzrUaSUXr5fS4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjJJScFAwAAAAAACgkQsN6d1ii/Ey/o
Mwf+NKvF3PUmWGEsPks48AyqLukWHZ6HnE7CrDOrzLiwV4hooqwoVW6mCkckuLQo/pw8owaDJ3MJ
LffYLAaFpxtV7I/rsOvUjUVcDQysxOfL0KVo53WPr73+Li83kJpqP1sW3q3GpEFG1UKtEE1WRmdO
4cL/6nqjlB1sJBqkW7SlcdueRKe2JcIdMKivMPQP/TSWoKG4QBnixkxVtVaYhFzl5Qk2Ic2O9Q4y
OVk26MkdJpbqZgKQCIVVcyJ0JwKeBcaw+GEYkp+rKve/ZJrWRHdYZqE7PFLFOaYT5QzdQP+Qya7E
Hcf00HTtgjBo7Kh9KAB6CyMsDfxD8KLh3y8QhHolag==
=vvmk
-----END PGP SIGNATURE-----

--------------lrG1aD7OnZAxzrUaSUXr5fS4--

