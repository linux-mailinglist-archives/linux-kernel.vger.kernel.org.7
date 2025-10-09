Return-Path: <linux-kernel+bounces-846780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C1BC9060
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A10134FA18B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6AE2E2DFA;
	Thu,  9 Oct 2025 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="o49R6AlN"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEE32E1EE7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013021; cv=none; b=Ghhrql/FXf3cHjEJykKECmKq1Iyr+GMQaR0dLRV0oySiHtr/xZYolRqEKiRot93y3Uvqf2pMPV06TkRJ/LF7qDfExIfUqd3S0pzLlDjCdFbz35hxR43d7oy2Bs3akqpxMFcDr8w+UM0z7BQlDH6AZg9XSLpzldOk1wilSFSIwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013021; c=relaxed/simple;
	bh=LlE4cpJ9c3fYreTfvWCB2uidMxLuL2MaWecdKS7o3Aw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCrSapve8hn3UAXioLn8DLFfEZpGYqckMScRNkmJzv/G6xyJJXqD+kMmgOhltxxqOphx65nD0CC5Nw8EnkJo4SQo/61mvDfQJkMbHecosOolU6PX3nLzjroPlqEigtillCejKz30NAlpZhSw8rUiiHdcb+ACb2Kz13yjx8+QDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=o49R6AlN; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1C5C0240029
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760013018; bh=LlE4cpJ9c3fYreTfvWCB2uidMxLuL2MaWecdKS7o3Aw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Autocrypt:OpenPGP:From;
	b=o49R6AlN3PhwI9mHF0CoRR/3KwoiMmOp7miLVroV7PH2QA7Ae1FBqDLPRh+idhAd8
	 AMU3BIL02WeJrNOsgdaJNee0aGISDA4h6u3dednH1mESQ8IV4vuehGDgkpD+yTWm3V
	 vpDMIPJG9HEI+KSGvaUULjqTtPQ6fYQwZw5Tr00r8bg3tfNM0GMgknKz9RVVsgrPwf
	 5makBnukTUt97Vu7k7LiiS34U0alNOXsrYmV3FHYIAxk0XUkivkGZS6P0MliMOIbhS
	 vHb8dI+IGs+XaEIT0vpQBYUm5p0OYao0WNXp3TGR+MwYxrXIbmTn048STi65PScK6H
	 9bg38B7pWbhuw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cj8N73ywSz9rxD;
	Thu,  9 Oct 2025 14:30:15 +0200 (CEST)
Message-ID: <53fd34386cefd4a789c56a6e6d7c5618c06c531b.camel@posteo.de>
Subject: Re: [PATCH 4/4] leds: add driver for synology atmega1608 controlled
 LEDs
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Miguel
 Ojeda	 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Igor
 Korotin	 <igor.korotin.linux@gmail.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Vlastimil Babka	 <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki	 <urezki@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, 	linux-leds@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 09 Oct 2025 12:30:17 +0000
In-Reply-To: <DDDSCBNFRLG9.26UA3ZEOA9LJH@kernel.org>
References: <20251008181027.662616-1-markus.probst@posteo.de>
	 <20251008181027.662616-2-markus.probst@posteo.de>
	 <20251008181027.662616-3-markus.probst@posteo.de>
	 <20251008181027.662616-4-markus.probst@posteo.de>
	 <20251008181027.662616-5-markus.probst@posteo.de>
	 <DDDSCBNFRLG9.26UA3ZEOA9LJH@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

T24gVGh1LCAyMDI1LTEwLTA5IGF0IDE0OjIwICswMjAwLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3Rl
Ogo+IChOb3QgYSBmdWxsIHJldmlldyAobGV0J3Mgd29yayBvdXQgdGhlIGRlcGVuZGVuY2llcyBm
aXJzdCksIGJ1dAo+IHRoZXJlJ3Mgb25lCj4gdGhpbmcgdGhhdCBzdG9vZCBvdXQgdG8gbWUuKQo+
IAo+IE9uIFdlZCBPY3QgOCwgMjAyNSBhdCA4OjEwIFBNIENFU1QsIE1hcmt1cyBQcm9ic3Qgd3Jv
dGU6Cj4gPiArc3RydWN0IEF0bWVnYTE2MDhMZWQgewo+ID4gK8KgwqDCoCBhZGRyOiBBdG1lZ2Ex
NjA4TGVkQWRkcmVzcywKPiA+ICvCoMKgwqAgaWQ6IEF0bWVnYTE2MDhMZWRJZCwKPiA+ICsKPiA+
ICvCoMKgwqAgY2xpZW50OiBBUmVmPEkyY0NsaWVudD4sCj4gPiArCj4gPiArwqDCoMKgIG1vZGVf
bG9jazogQXJjPE11dGV4PCgpPj4sCj4gCj4gTXV0ZXg8KCk+IHJhaXNlcyBhbiBleWVicm93LCBz
aW5jZSBhIG11dGV4IHRoYXQgZG9lc24ndCBwcm90ZWN0Cj4gYW55dGhpbmcgaXMKPiBwb2ludGxl
c3MuIFNvLCBJIGFzc3VtZSBpdCBpcyBwcm90ZWN0aW5nIHNvbWUgZGF0YSwgYnV0IGluIGFuIHVu
c291bmQKPiB3YXkuCj4gCj4gPiAraW1wbCBBdG1lZ2ExNjA4TGVkIHsKPiA+ICvCoMKgwqAgZm4g
dXBkYXRlX21vZGUoJnNlbGYsIG1vZGU6IEF0bWVnYTE2MDhMZWRNb2RlKSAtPgo+ID4gUmVzdWx0
PEF0bWVnYTE2MDhMZWRNb2RlPiB7Cj4gPiArwqDCoMKgwqDCoMKgwqAgbGV0IF9ndWFyZCA9IHNl
bGYubW9kZV9sb2NrLmxvY2soKTsKPiAKPiBXaGF0IGV4YWN0bHkgZG9lcyB0aGUgbXV0ZXggcHJv
dGVjdCBpbiB0aGUgY29kZSBiZWxvdz8KT3RoZXJ3aXNlIHRoZXJlIHdvdWxkIGJlIGEgcmFjZSBj
b25kaXRpb24uIEVhY2ggcmVnaXN0ZXIgaGFzIDggYml0cywKZWFjaCBsZWQgaGFzIDIgYml0cy4g
SWYgdGhlIGxlZCBtb2RlIGlzIHVwZGF0ZWQgYXQgdGhlIHNhbWUgdGltZSB3aXRoCmFub3RoZXIg
b25lIGluIHRoZSBzYW1lIHJlZ2lzdGVyLCBpdCBjb3VsZCBsZWFkIHRvIHRoZSBmaXJzdCBhY3Rp
b24KYmVpbmcgb3ZlcndyaXR0ZW4gYnkgdGhlIHNlY29uZC4KTWVhbmluZyBpZiB0d28gYWN0aW9u
cyBydW4gYXQgdGhlIHNhbWUgdGltZToKLSBsZWQwIHJlYWRzIGZyb20gdGhlIHJlZ2lzdGVyCi0g
bGVkMSByZWFkcyBmcm9tIHRoZSByZWdpc3RlcgotIGxlZDAgd3JpdGVzIHRvIHRoZSByZWdpc3Rl
cgotIGxlZDEgd3JpdGVzIHRvIHRoZSByZWdpc3RlciAodGhlIGNoYW5nZXMgZm9yIGxlZDAgaGF2
ZSBiZWVuCm92ZXJ3cml0dGVuIGhlcmUsIGFzIGl0IGRpZCByZWFkIHRoZSByZWdpc3RlciBiZWZv
cmUgbGVkMCBoYXMgd3JpdHRlbgp0byBpdCkKCj4gCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqAg
bGV0IG11dCBjdXJyZW50ID0gc2VsZgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNsaWVu
dAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnJlYWRfYnl0ZV9kYXRhKHNlbGYuYWRkciBh
cyB1OCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5pbnNwZWN0X2Vycih8ZXJyfCB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIhKAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuY2xpZW50LmFzX3JlZigpLAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJmYWlsZWQgdG8gcmVhZCB7
OiMyeH06IHtlcnI6P31cbiIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2VsZi5hZGRyIGFzIHU4Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9KT87Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqAgY3VycmVudCA9Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoY3VycmVudCAmICFz
ZWxmLmlkLm1hc2soKSkgfCAoKChtb2RlIGFzIHU4KSA8PAo+ID4gc2VsZi5pZC5zaGlmdCgpKSAm
IHNlbGYuaWQubWFzaygpKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmNsaWVudAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLndyaXRlX2J5dGVfZGF0YShzZWxmLmFkZHIgYXMg
dTgsIGN1cnJlbnQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuaW5zcGVjdF9lcnIofGVy
cnwgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyISgKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmNsaWVudC5hc19yZWYo
KSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiZmFpbGVkIHRv
IHdyaXRlIHs6IzJ4fToge2Vycjo/fSIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc2VsZi5hZGRyIGFzIHU4Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9KT87Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqAgT2sobW9kZSkKPiA+ICvCoMKgwqAgfQo+ID4gK30KClRoYW5rcwotIE1hcmt1
cyBQcm9ic3QK


