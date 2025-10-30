Return-Path: <linux-kernel+bounces-878100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688A3C1FC76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00E9423506
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5D2E62A6;
	Thu, 30 Oct 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l1KEmDSw"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C02E5429
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823078; cv=none; b=qq82dPnNbH5hYEqKjNRoUPw0qDCM9RY3opW053YBx0QMiXxnjDB/T75P5RnfTYkJEoAQH3CFOjQAG5WrUh45g89Xr7s7yl7oM+ff8YO4NtUwIOjCkXZEicn0HyoBlEAbVlTCci4tN3wUh9k4689+SHY1ADeyFMCfG05EhYWr3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823078; c=relaxed/simple;
	bh=lq7BEuW2n5ynqHVnjtQ9Ly2DrLoKCdaRrCaQ0oltKjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2u4uxp76GUw2IDm6Am0E+H2BVTnZla5F78qeb5e6NCM2v9ERo91QdR4YwgUM3GWbDQD8RiOmqwqInK56ZbyNX/wnZHMW26l/hiP2oh0tJwp/Aux8z2w9Ic6ulqyH10AxblLCKgqhj6LLWwDzebM7ZX4xvtvQuomhCoSqAp2IHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l1KEmDSw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4f323cf89bso210501166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761823074; x=1762427874; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lq7BEuW2n5ynqHVnjtQ9Ly2DrLoKCdaRrCaQ0oltKjU=;
        b=l1KEmDSwLFfOp8nY2+6sZy3TI79hpaZ1MDbGNGUqElWTnRMnImwvIRw50FSIuv2Znq
         A4K5flOYjGgIc7TDvCwO15qKtFpCDepBCyC1ffgk/oTzzuMDiXTwVs09B0r+AJe+qtao
         f0OhTfgtNKmGfx9HDGYqTL+LJOzPLycre+EQb/wGmmwCr1ya3w1BQb04rA4fuZCb1vlU
         MBKmukwKX5TdG/h8T8Yd+w5aOKxo+csARqTUpvFikWoj5w8/EqyHUlsK1HoYdtf6KZYj
         ROeQYbbOe7St5/jTrD2hCOIOjrrIuFjFvIWxgdKhQbpjovgstxTkMRc3sGWl8rmWcV2b
         AprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823074; x=1762427874;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lq7BEuW2n5ynqHVnjtQ9Ly2DrLoKCdaRrCaQ0oltKjU=;
        b=pdyQbMxz8Qrp3UdJGqyh+lq547ArS58AgILo+NIqgp+xobSqg7d+lxdg8LOn+lbUJW
         2Pbvx+ax6gFTnBsAzKuXfjq+1N2YNfPxH08dtcoKpIrQAeEB2THo30TbIfOy7smPoNNz
         7uJ/MpKpqd50zNsu78A0r3hvMKtU2+4Toe01aWPSEXi3S61zBamOPM1lRb32IQ+g18TL
         mBNkxNvSGh2V8OJY1kHubIM3h4v09AYMHQ6kpO3byU8VvcMUuV1+uKkYW0EYnPIryMWj
         sKS59o5cU2Ii+Zok40mQ151YU+72VCQSriQhIN/6+issJq1kzhUkfPA5BpaUNKc9VyT9
         85dA==
X-Forwarded-Encrypted: i=1; AJvYcCWhZxX4VBl5vAZ7X3r1pESvw0AYLr4eLbKP44oglLyp6rx5MczKnk/WyNu6l4AwUy2E2haP1SAhqAeqovE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBti3u/SrXLVsYC3f8kH6rSxCf519nz9SMv4b7hYGdceUfjSr1
	o8mdvMtnj+7J2S4XK3jkE7BU/g3h3oplbODZ6KRQnu81FXwRckxUYr1K/8h4kSjAiu8=
X-Gm-Gg: ASbGncvVLthUNW5wsA+pOBMN1GYMVOvM/LL/ZaAktJFpAFrMZULzikqCrRyBCs5Ciq6
	yV7t+d9h3lSv/X+50/hHZZ11n/HJi/PfFVTz5AfkRIE/xZULWyURff5zG4SljynEtxwSSVC2AWL
	Avyc6I0YsPetI0Z868dMuuCl/cfuo6ZbTB2WLnPBzlH5TkT9LrHycb9ve9DPnlGUlbLPxtUcoc9
	IW2FAycMbMihHUZaEkhaimwlAiSceCeZPA6D6tUZblE3/qWQffDaVDxfolvAalkjAYvbiBILzzG
	J+OuBGlCYGj7CWtt3VsVVi7yxyKbNskLDslAhwpqzRiqnmbE3v6Z+mcdGEnBeramkltm35fAySj
	9vLq0Es/OQY5jYZbF96K1XwVbCoEZtaPHtBN2820sUTHZ1S42x//6v6Dq7egR58mI9sCVWQ4wc6
	QgufhxrZVtD4xKn3bp1Sk41rVqLorwIuoHtBJ71Q==
X-Google-Smtp-Source: AGHT+IEEACNDO96pasuBnVmobCRKQvEtDpyW5FXJZ8HwsoSFC6DD2+SOIZXxnhLwbOXdy/2fMsqR0Q==
X-Received: by 2002:a17:907:2d8d:b0:b40:b54d:e687 with SMTP id a640c23a62f3a-b703d5060dbmr589676466b.47.1761823074383;
        Thu, 30 Oct 2025 04:17:54 -0700 (PDT)
Received: from [10.203.83.89] (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f97f7sm1680747966b.51.2025.10.30.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:17:53 -0700 (PDT)
Message-ID: <78f1502c131a7f5bd6dc24c364aceff154501ece.camel@baylibre.com>
Subject: Re: [PATCH 7/9] iio: imu: st_lsm6dsx: make event management
 functions generic
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 12:17:52 +0100
In-Reply-To: <aQMerfm6peHvHAz2@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-8-flavra@baylibre.com>
	 <aQMerfm6peHvHAz2@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BJ2QOoYFWcD0DUYP13Md"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-BJ2QOoYFWcD0DUYP13Md
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI1LTEwLTMwIGF0IDEwOjE1ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gVGh1LCBPY3QgMzAsIDIwMjUgYXQgMDg6Mjc6NTBBTSArMDEwMCwgRnJhbmNlc2NvIExh
dnJhIHdyb3RlOgo+ID4gSW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBzdXBwb3J0IGZvciBtb3Jl
IGV2ZW50IHR5cGVzLCB1c2UgYW4KPiA+IGFycmF5IGluZGV4ZWQgYnkgZXZlbnQgSUQgaW5zdGVh
ZCBvZiBhIHNjYWxhciB2YWx1ZSB0byBzdG9yZQo+ID4gZW5hYmxlZCBldmVudHMsIGFuZCByZWZh
Y3RvciB0aGUgZnVuY3Rpb25zIHRvIGNvbmZpZ3VyZSBhbmQgcmVwb3J0Cj4gPiBldmVudHMgc28g
dGhhdCB0aGVpciBpbXBsZW1lbnRhdGlvbiBpcyBub3Qgc3BlY2lmaWMgZm9yIHdha2V1cAo+ID4g
ZXZlbnRzLiBNb3ZlIHRoZSBsb2dpYyB0byB1cGRhdGUgdGhlIGdsb2JhbCBldmVudCBpbnRlcnJ1
cHQgZW5hYmxlCj4gPiBmbGFnIGZyb20gc3RfbHNtNmRzeF9ldmVudF9zZXR1cCgpIHRvIGl0cyBj
YWxsaW5nIGZ1bmN0aW9uLCBzbyB0aGF0Cj4gPiBpdCBjYW4gdGFrZSBpbnRvIGFjY291bnQgYWxz
byBldmVudCBzb3VyY2VzIGRpZmZlcmVudCBmcm9tIHRoZQo+ID4gc291cmNlIGJlaW5nIGNvbmZp
Z3VyZWQuIFdoaWxlIGNoYW5naW5nIHRoZSBzaWduYXR1cmUgb2YgdGhlCj4gPiBzdF9sc202ZHN4
X2V2ZW50X3NldHVwKCkgZnVuY3Rpb24sIG9wcG9ydHVuaXN0aWNhbGx5IGFkZCB0aGUKPiA+IGN1
cnJlbnRseSB1bnVzZWQgYGF4aXNgIHBhcmFtZXRlciwgd2hpY2ggd2lsbCBiZSB1c2VkIHdoZW4g
YWRkaW5nCj4gPiBzdXBwb3J0IGZvciBlbmFibGluZyBhbmQgZGlzYWJsaW5nIGV2ZW50cyBvbiBh
IHBlciBheGlzIGJhc2lzLgo+IAo+IC4uLgo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X2xv
Y2soJmh3LT5jb25mX2xvY2spOwo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGVuYWJsZV9ldmVudCB8
fCAhKGh3LT5maWZvX21hc2sgJiBCSVQoc2Vuc29yLT5pZCkpKQo+ID4gK8KgwqDCoMKgwqDCoMKg
aWYgKCFlbmFibGVfZXZlbnQpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBl
bnVtIHN0X2xzbTZkc3hfZXZlbnRfaWQgb3RoZXJfZXZlbnQ7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yIChvdGhlcl9ldmVudCA9IDA7IG90aGVyX2V2ZW50IDwK
PiA+IFNUX0xTTTZEU1hfRVZFTlRfTUFYOyBvdGhlcl9ldmVudCsrKSB7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChvdGhlcl9ldmVudCAhPSBl
dmVudCAmJiBody0KPiA+ID5lbmFibGVfZXZlbnRbb3RoZXJfZXZlbnRdKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBh
bnlfZXZlbnRzX2VuYWJsZWQgPSB0cnVlOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKg
wqBpZiAoZW5hYmxlX2V2ZW50IHx8ICFhbnlfZXZlbnRzX2VuYWJsZWQpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3Qgc3RfbHNtNmRzeF9yZWcgKnJlZyA9
ICZody0+c2V0dGluZ3MtCj4gPiA+ZXZlbnRfc2V0dGluZ3MuZW5hYmxlX3JlZzsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmVnLT5hZGRyKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IHJlZ21hcF91
cGRhdGVfYml0cyhody0+cmVnbWFwLCByZWctPmFkZHIsCj4gPiByZWctPm1hc2ssCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gU1RfTFNNNkRTWF9TSElGVF9W
QUwoc3RhdGUsIHJlZy0+bWFzaykpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJyIDwgMCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gdW5sb2NrX291dDsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqB9
Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoZW5hYmxlX2V2ZW50IHx8ICghYW55X2V2ZW50c19lbmFi
bGVkICYmICEoaHctPmZpZm9fbWFzayAmCj4gPiBCSVQoc2Vuc29yLT5pZCkpKSkKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gX19zdF9sc202ZHN4X3NlbnNvcl9zZXRf
ZW5hYmxlKHNlbnNvciwgc3RhdGUpOwo+ID4gK3VubG9ja19vdXQ6Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgbXV0ZXhfdW5sb2NrKCZody0+Y29uZl9sb2NrKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
ZXJyIDwgMCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycjsK
PiAKPiBUaGlzIHdob2xlIGJsb2NrIGlzIGhhcmQgdG8gcmVhZC4gUGVyaGFwcyB5b3UgbmVlZCB0
byByZWZhY3RvciBpdCB0byBoYXZlCj4gc29tZXRoaW5nIGxpa2UKPiAKPiDCoMKgwqDCoMKgwqDC
oMKgaWYgKGVuYWJsZV9ldmVudCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZXJyID0gY2FsbF9oZWxwZXIxKCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
Li4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IF9fc3RfbHNtNmRzeF9z
ZW5zb3Jfc2V0X2VuYWJsZShzZW5zb3IsIHN0YXRlKTsKPiDCoMKgwqDCoMKgwqDCoMKgfSBlbHNl
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFueV9ldmVudHNfZW5hYmxlZCA9
IGNhbGxfaGVscGVyMigpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFh
bnlfZXZlbnRzX2VuYWJsZWQpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBlcnIgPSBjYWxsX2hlbHBlcjEoKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuLi4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIShody0+Zmlmb19tYXNrICYgQklUKHNlbnNv
ci0+aWQpKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZXJyID0KPiBfX3N0X2xzbTZkc3hfc2Vuc29yX3NldF9lbmFibGUo
c2Vuc29yLCBzdGF0ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDC
oMKgwqDCoMKgwqDCoH0KPiAKPiBXaXRoIHRoaXMgeW91IGNhbiBzZWUgdGhhdCBhY3R1YWxseSBo
ZWxwZXIxIGNhbiBiZSBtb2RpZmllZCAod2l0aCBvbmUKPiBhZGRpdGlvbmFsIHBhcmFtZXRlcikg
dG8gY29tYmluYXRpb24gb2YKPiAKPiBuZXdfaGVscGVyMSgpCj4gewo+IMKgwqDCoMKgwqDCoMKg
wqBlcnIgPSBjYWxsX2hlbHBlcjEoKTsKPiDCoMKgwqDCoMKgwqDCoMKgLi4uCj4gwqDCoMKgwqDC
oMKgwqDCoGlmICghKGh3LT5maWZvX21hc2sgJiBCSVQoc2Vuc29yLT5pZCkpKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIF9fc3RfbHNtNmRzeF9zZW5zb3Jfc2V0X2Vu
YWJsZShzZW5zb3IsIHN0YXRlKTsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gfQo+IAo+
IEFuZCB0aGUgYWJvdmUgZ29lcyBhcwo+IAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZW5hYmxlX2V2
ZW50KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSBuZXdfaGVscGVy
MShmYWxzZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBhbnlfZXZlbnRzX2VuYWJsZWQgPSBjYWxsX2hlbHBlcjIoKTsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghYW55X2V2ZW50c19lbmFibGVkKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IG5ld19o
ZWxwZXIxKGh3LT5maWZvX21hc2sgJiBCSVQoc2Vuc29yLQo+ID5pZCkpOwo+IMKgwqDCoMKgwqDC
oMKgwqB9Cj4gCj4gd2l0aCBhc3N1bWVkIGdvb2QgbmFtZXMgZ2l2ZW4gdGhpcyBsb29rcyB0byBt
ZSBtdWNoIGVhc2llciB0byB1bmRlcnN0YW5kLgoKV2lsbCBkbwoKPiAKPiA+ICtzdGF0aWMgYm9v
bAo+ID4gK3N0X2xzbTZkc3hfcmVwb3J0X21vdGlvbl9ldmVudChzdHJ1Y3Qgc3RfbHNtNmRzeF9o
dyAqaHcpCj4gCj4gV2h5IG5vdCBvbmUgbGluZT8KClRoaXMgZnVuY3Rpb24gd2FzIGFscmVhZHkg
dGhlcmUgYXMgaXMsIGV2ZW4gdGhvdWdoIHRoZSBkaWZmIG1ha2VzIGl0IGFwcGVhcgphcyBhIG5l
dyBmdW5jdGlvbi4gV2lsbCBtYWtlIGl0IG9uZSBsaW5lLgoKPiAKPiA+ICt7Cj4gPiArwqDCoMKg
wqDCoMKgwqBib29sIGV2ZW50c19mb3VuZDsKPiAKPiBTZWVtcyB1c2VsZXNzLiBJcyB0aGlzIGZ1
bmN0aW9uIGdvaW5nIHRvIGJlIGV4cGFuZGVkIGRvd24gaW4gdGhlIHNlcmllcz8KClllcywgd2hl
biBhZGRpbmcgc3VwcG9ydCBmb3IgdGFwIGV2ZW50cyBpbiBwYXRjaCA5LzkuCgo+ID4gK8KgwqDC
oMKgwqDCoMKgZXZlbnRzX2ZvdW5kID0gc3RfbHNtNmRzeF9yZXBvcnRfZXZlbnRzKGh3LAo+ID4g
U1RfTFNNNkRTWF9FVkVOVF9XQUtFVVAsIElJT19FVl9UWVBFX1RIUkVTSCwKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgSUlPX0VWX0RJUl9FSVRIRVIpOwo+IAo+IElu
ZGVudGF0aW9uLgoKU2VlbXMgZ29vZCB0byBtZSwgd2hhdCBzaG91bGQgSSBjaGFuZ2U/Cgo+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIGV2ZW50c19mb3VuZDsKPiA+ICt9Cj4gCgo=


--=-BJ2QOoYFWcD0DUYP13Md
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkDSWAACgkQ7fE7c86U
Nl9W7gv/evMn9XbCYgpz3tmVmginbdwhoIqoK08ep1HZz+bA5L16npw88aSddvZs
gT8mUfvRUZxHdLhQhMHldPhyDG/cYuBYQ/w0lrW5aVN+/RlfwcC/gZ7hmmyNw1qq
+Dpyc/Fpnljq5ZaYVXfe0BTOpYq+FIqMwI8uYyZFC26tCnEi7ge99Z0fYcm/0l+M
QKaF+tDzIo8c7d/Bw058EYQNfSyNxU5Zd+Ah0DOHfXJHReAd96ivDQliCKLsJm2H
Pjj+fifaO4UTG8StE33/bTl/EbUzLP2Cljzxzsd3itHAwS25lytO4rTGmXVx1g9B
HEdbAIsTREN7yW65qrKI0jj8N/+WLeAAmCcHyEmQSfIHnkIarPcePLD4E6BlMb3a
o0UtNEjZI2BZwqhEAQqdiFU8FFvqbCmajsQBDmBo+UsyJlNNYi3DpMG+QU6KM/L8
nDHw//AFENXb1T/9rPRZGK8wg75YAEcpWOhMjfueFb5MnC++JXoOUm2/G6WYJ10r
AcNTJp6+
=o1MD
-----END PGP SIGNATURE-----

--=-BJ2QOoYFWcD0DUYP13Md--

