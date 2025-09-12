Return-Path: <linux-kernel+bounces-813415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DEFB5450F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE913BA449
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B172D5419;
	Fri, 12 Sep 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBiUJwcL"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D82D5436
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665162; cv=none; b=QEBZSnCxeEFZ5U9IIKL9DSDFjtMc68s76UFRcNS8++ddOLQ9xgurYEdVt+QIb8WjEDAGQCX74YVCFG2lgYw2CcJC5SDAhfs6fvhAbfofaRMRuXsBIL4F+/HdFA6gLJ+VKaNUTpwhRDTczBSXbD9zq/ORPpYAmk9ik1GHaQrmY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665162; c=relaxed/simple;
	bh=vhi2EuqavcXxwlfTir9+euMwzSozgelH/J4dWHMTo+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sr5E4l1dX9pSSkF9ftuOgDQFyNXL2wS6dJMyrtOMmlVgLH2g734n1CcasZqfjnEjKTw0UU1NyVklCeiwAdJKAG9PV4Rvp+Ipu2zwSx9HB8Y3/9JkdIRuZTW92mPhDDPv0O3YaK8DGuZmYwvYz49c+VNGUU4J5At/B47Q6+0EQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBiUJwcL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b00a9989633so308639566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757665159; x=1758269959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vhi2EuqavcXxwlfTir9+euMwzSozgelH/J4dWHMTo+U=;
        b=kBiUJwcL+Ssl/y+VyCe1RlJ8p4diXKWe6/ocsWXryJcH+ON/n9zHd0HjuaEi6gDKG0
         aeL+n2cg/fi00p4yI2p90zRUdmxFWiBme7khQX67aZkMG38en9nvCD8Mf6FBm8tA2P7A
         9CrAs1q3fOpRczrWGH9ngiHpztS1nivK13IxzUcRWzXqP18T9N9UnRYyMzKPuNMRKAMp
         Pm7m1qrnYxDkae5nK0BB+nqB7UYQoJ1TJIacJoRJLCw/c85P4K6ykSAPKs71eMCLcNBq
         hZoKo/2WVGd8FAW5KxuLGTIqltbv9Zgb0YWvxFxv8E6/uj3iOQ5tkJA2VEzYsjNwbh2y
         VLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665159; x=1758269959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhi2EuqavcXxwlfTir9+euMwzSozgelH/J4dWHMTo+U=;
        b=uldlwwB6io2/T4BNIz9NRnaPcPQKhGexDOFqyIrdZOp3m5nI8t4JcxpmvBNb62TStt
         j47LMYjC202051govKeRZ9RWCYGvwP3vRRHK3hWk3IIvLjxuTLOcE/2Nyn9EmaoSoLer
         6kZ4Jx0wOz6aDryj0fTLr+xy0BxUppXhiHuJ4BeiFdws8ycL89g5G7u802nnj/1YKK8x
         lDdczPEsmvJpgNBGDRQn3BjHP2DYzT5oloZoSvIk2h92tNx7Z8Q4E9wq1K58G+Dk9u/T
         UPEkViTnOh6azsih4g7txODK9GJSfGfZOajwmOsBnthqDA5GYhhNYg8IELsMvCfDNPkW
         a2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6eBW2mJU5PGyse/DoA+NHNiuPSJTGv/prENGmqcphxZjgzeeztQz7vz05fG4Gin9HOc3YZsV08HyY1M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEAhjHWmavB6EanGJ5r/zCmwW4EtbbEgN7oB9zDBJSu+P1clb
	sveVQUjOf2f7hkRZQ4PZ8FhPZGmGJBHV4txg48Uajmyjuza4vwnlR2qM
X-Gm-Gg: ASbGncvvNeYut6nBMTpSe3bnYsxicSbBAhbvgs5gASeSsiJ0BwTA4NpVXtQUerKRemY
	uw7Ggj9VKlzIrV6x66HSkDBACiosPPBwMK2A//rtRI+m6ds8QZjJBMgzCcPFfmCp7jqREpSX+8I
	gEvj/wbM7su7bWUVPGX89RBoejgx1rAo7zKmTJQILQsDuZRsOdJdo+AJN7xer0kpP2nnKBNaN59
	jCONKPh2cva1v0P6lIGja2W9m5T4TuFGbrdkyNxmVlSGt6xDLaiBZ4HMFfNqO+ulaWuLN8i/Uw7
	Ht6cXqA1nOPYjfGf4GqDFBdQ4ZF1HTVkkgAMmet+mcIXead9tiz2iDiR1xf5Kkykd0+l7vj4NRh
	nTk0Vt5up0IzaZo2fGpCa7ajTTtGgATbQGA==
X-Google-Smtp-Source: AGHT+IGIb25WmUTwrRh32igxOEKD1OuE/LTa+jx62Fe1IbQtlhi43GGWY7MEtxlOVUMeowCxH3xDNw==
X-Received: by 2002:a17:907:6e8f:b0:afe:ac57:f0be with SMTP id a640c23a62f3a-b07a6934870mr642421066b.31.1757665158951;
        Fri, 12 Sep 2025 01:19:18 -0700 (PDT)
Received: from [10.5.0.2] ([185.128.9.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e599sm321218466b.108.2025.09.12.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:19:18 -0700 (PDT)
Message-ID: <5e279cf72409504861c80bb4d2e4e5f6bc59d94c.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, jic23@kernel.org,
 nuno.sa@analog.com, 	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, 	linux-iio@vger.kernel.org, s32@nxp.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 chester62515@gmail.com, mbrugger@suse.com, 	ghennadi.procopciuc@oss.nxp.com
Date: Fri, 12 Sep 2025 09:19:43 +0100
In-Reply-To: <CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
	 <20250910155759.75380-3-daniel.lezcano@linaro.org>
	 <d53b22d1-35d6-4fb8-ae56-3ba4953b64af@baylibre.com>
	 <ea57a466-97b3-49d4-8d1c-142fd49a0da2@linaro.org>
	 <CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTA5LTEyIGF0IDA4OjM4ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gRnJpLCBTZXAgMTIsIDIwMjUgYXQgMjowM+KAr0FNIERhbmllbCBMZXpjYW5vCj4gPGRh
bmllbC5sZXpjYW5vQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gT24gMTEvMDkvMjAyNSAyMjoxMCwg
RGF2aWQgTGVjaG5lciB3cm90ZToKPiA+ID4gT24gOS8xMC8yNSAxMDo1NyBBTSwgRGFuaWVsIExl
emNhbm8gd3JvdGU6Cj4gCj4gWyAuLi4gXQo+IAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qIGlpb19wdXNoX3RvX2J1ZmZlcnNfd2l0aF90aW1lc3RhbXAgc2hvdWxkIG5vdCBiZSBj
YWxsZWQKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2l0aCBkbWFfc2FtcGxl
cyBhcyBwYXJhbWV0ZXIuIFRoZSBzYW1wbGVzIHdpbGwgYmUKPiA+ID4gPiBzbWFzaGVkCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGlmIHRpbWVzdGFtcCBpcyBlbmFibGVkLgo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAKPiAvKgo+IMKgKiBCdHcsIGNv
bW1lbnQgc3R5bGUgZm9yIG11bHRpLWxpbmUKPiDCoCogY29tbWVudHMgaXMgd3JvbmcgZm9yIHRo
aXMgc3Vic3lzdGVtLgo+IMKgKiBVc2UgdGhpcyBhcyBhbiBleGFtcGxlLCBBbHNvLCByZWZlciB0
bwo+IMKgKiB0aGUgZnVuY3Rpb24gYXMgZnVuYygpLCBpLmUuIG1pbmQgdGhlIHBhcmVudGhlc2Vz
Lgo+IMKgKi8KPiAKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aW1lc3RhbXAgPSBp
aW9fZ2V0X3RpbWVfbnMoaW5kaW9fZGV2KTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXQgPSBpaW9fcHVzaF90b19idWZmZXJzX3dpdGhfdGltZXN0YW1wKGluZGlvX2RldiwKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5m
by0+YnVmZmVyLAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0aW1lc3RhbXApOwo+ID4gPiAKPiA+ID4gSXMgaXQgT0sgdG8gY2FsbCB0aGlz
IHdpdGggc3BpbmxvY2sgaGVsZD8gSXQgbG9va3MgbGlrZSBpdCBjYW4gY2FsbAo+ID4gPiBkZXZt
X2tyZWFsbG9jKCkgd2hpY2ggbWF5IHNsZWVwLgo+ID4gCj4gPiBJdCBzaG91bGQgYmUgb2ssIGRl
dm1fa3JlYWxsb2MgaXMgaW4gdGhlIGNvZGUgcGF0aCBvZgo+ID4gaWlvX3B1c2hfdG9fYnVmZmVy
c193aXRoX3RzX3VuYWxpZ25lZCgpLCBub3QgaW4KPiA+IGlpb19wdXNoX3RvX2J1ZmZlcnNfd2l0
aF90aW1lc3RhbXAoKQo+IAo+IFRoaXMgaXMgYSBnb29kIG9ic2VydmF0aW9uLCBjYW4gd2UgZG9j
dW1lbnQgdGhpcyBpbiB0aGUgcmVzcGVjdGl2ZQo+IGtlcm5lbC1kb2M6cyBwbGVhc2U/IEFsc28g
YWRkIG1pZ2h0X3NsZWVwKCkubWlnaHRfc2xlZXBfaWYoKSBpbiB0aGUKPiBhcHByb3ByaWF0ZSBm
dW5jdGlvbnMuCgpUaGF0J3MgYSBnb29kIGlkZWEhCgotIE51bm8gU8OhCg==


