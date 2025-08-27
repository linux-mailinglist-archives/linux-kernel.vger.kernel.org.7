Return-Path: <linux-kernel+bounces-787419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357ACB37605
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DACF1BA056A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23861F510;
	Wed, 27 Aug 2025 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyRFXR4P"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CC4C6C;
	Wed, 27 Aug 2025 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253685; cv=none; b=JbOOfwG29pXini7fOUE7UfM1BB3vv7dNTg8oKc4j4G2c7Zm7K/dXME6uzCKDXlbP2Sy35JF3FOq7vFTik5+yEVLUOQHfh4ns2fj+QPRNScLSsUm/qyLRHodqzTAtoeoIJTgQQBxjmzZfaXJYichGZzMKY+hDqfWHBVn2wUd0t5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253685; c=relaxed/simple;
	bh=GesxQibKq7ig0XWV//6ZAAmy/i/WlWBiRcUGfcr+9lY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ed0sdJga7miUvHa2tGOOYhBFFYmApYB0DWPJ1QscXEeASgqt+Ckp4amcx8nbWWCD7sssTtrbHT1v0lvVbiWjGrlvLQ4X3xc1GzXCrwDpqGw2Ff31dQuuHxlzH3bl5bTVCe6d5HBDC90nawuvC9dw6LlBsfZJcUdBbo3C7zOaR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyRFXR4P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24458272c00so73507555ad.3;
        Tue, 26 Aug 2025 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756253683; x=1756858483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GesxQibKq7ig0XWV//6ZAAmy/i/WlWBiRcUGfcr+9lY=;
        b=ZyRFXR4PQYlNll21lvcAInO2+nY/31m9PVr4LaO/g+UXFRrWfRS+MygmfJTnsykisu
         WclScirmefQd7iDGWB0bPQ9wVZylw7Vw9wgq7nVUll32UH5vTWHj0T+IX2TkO41bkq6Z
         uhI/LL6lbU8ef353Wx2tMziCgBSxGKQ2kl0c/b26YSvStgx9x4vfQYuX0ArCmFv58/09
         E9bwbQb12Fku+IJ1dsj7Z2PRW6MWHGZxX8n/3ewVFOm5q6G+FFFtUYZCX0u71hUFPlFq
         j1cQoZitbvJIsPIs/V5fWOz4iJZo5eOnF9tu/mX61OVg2PsLDIhBC0wVx1xflOPPkAr+
         z1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253683; x=1756858483;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GesxQibKq7ig0XWV//6ZAAmy/i/WlWBiRcUGfcr+9lY=;
        b=eKdtp8w2gi+75c0o23zRIA/S+jAmaTKp9/rtyZ3GQ2rJ4K9vwSxhmNOU0IMfe4q0ky
         YkA1BwKab/AYRidxu5C0PoQCBTYMOO8xHZvnT1t2G+cp1JwTlmodsGOann+DqCwLZVZf
         s04Gf5vnLLwe04EEQBoy+jhtvDtFD3pkI7HacopOHWGGF60FbRIWOpVY826sTR3NSWW5
         9apPm/7cBR2YCiVqJt9/vBIXGZGVUnkl6ptIQhjELTPm5UWfAjokKeicOphmnu1pxRVS
         Q8Nf7xJvsEDYS/BbhOX86IUtzGN37RHjVJHVeV5jlyH8UpookZhLRQ4TlGcwxCKe2X1x
         iuCA==
X-Forwarded-Encrypted: i=1; AJvYcCUVA7i6T2Dnod0T3y0LPYyxj0rAeBV+l+KcJujTlmm0m2H5rPd7Sbx85M+U6u1+yENvDnxrP3K0fCknsEyjlY0=@vger.kernel.org, AJvYcCWvF4gq+GNhrz7+XU329nJB6ekj//xzAo/c7g302H1gcqWSEnWpA6nspcaOq4mZZsRndMuKE1d71mO1bwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBypfgilf/0cNRdUaXyRHd1g3+4NVsD8pl9RWAacoV97HfZBp
	UuQh6ithvlg0m9+An4bPmimMjQkvtrpGh0BYo0KDF/JR2C6S6JwA1S0i
X-Gm-Gg: ASbGncuDVRS101RSQNacL4XT//NHp0YMAf0PXmMpWK+BY6YTVHksuuG+D1mhX48woSz
	LWSSRy5380X+6lpQ3SK1osbYAD0ZHHbMJlct2kskDIUI4zysLFPSqGgpxZXsdrHqf/1vzva4KSu
	GjUsgimPDwa/uqZRB5srFbke46gd7iqL8iu+hgA9an/IMuBVb5s62sbes5ABMyjECrSZmw7ANPF
	KFNiLmCJGFIJkn7+2pGOLkn0xiNgC9t/7g01o+JSLN0Ar6FPQ/Jiv38pmgQkyasUkPsRlZkmPqQ
	aN6WIaeFtaldbFq/Ve9zgTdsW0dTEURwm6gRJTGUFSGPiNBVbg7/KMTE64aLvdlJKXpmWBu2+Qh
	Zza01gy3HHslOlpz4TnYQ5SVuZ134FvNU1KTP9TX77xGFrbi62Ayy8SAXVpiXXdpFstApnyATF+
	Qa
X-Google-Smtp-Source: AGHT+IHQ4c7zdzDE0kc6fizEeLToo1ybgcuOGVsypLhTZUAsjziZJ6vX6Ee0Ckzoqcc+ZCXQ1EbtKA==
X-Received: by 2002:a17:903:198e:b0:242:e29e:d6a6 with SMTP id d9443c01a7336-2462ef66f01mr235266845ad.40.1756253683399;
        Tue, 26 Aug 2025 17:14:43 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a014sm106974815ad.7.2025.08.26.17.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 17:14:42 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:14:27 +0900 (JST)
Message-Id: <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
	<20250821035710.3692455-3-fujita.tomonori@gmail.com>
	<DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gVHVlLCAyNiBBdWcgMjAyNSAxNjoxMjo0NCArMDIwMA0KIkRhbmlsbyBLcnVtbXJpY2giIDxk
YWtyQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IE9uIFRodSBBdWcgMjEsIDIwMjUgYXQgNTo1NyBB
TSBDRVNULCBGVUpJVEEgVG9tb25vcmkgd3JvdGU6DQo+PiArcHViIGZuIHJlYWRfcG9sbF90aW1l
b3V0X2F0b21pYzxPcCwgQ29uZCwgVD4oDQo+PiArICAgIG11dCBvcDogT3AsDQo+PiArICAgIG11
dCBjb25kOiBDb25kLA0KPj4gKyAgICBkZWxheV9kZWx0YTogRGVsdGEsDQo+PiArICAgIHRpbWVv
dXRfZGVsdGE6IERlbHRhLA0KPj4gKykgLT4gUmVzdWx0PFQ+DQo+PiArd2hlcmUNCj4+ICsgICAg
T3A6IEZuTXV0KCkgLT4gUmVzdWx0PFQ+LA0KPj4gKyAgICBDb25kOiBGbk11dCgmVCkgLT4gYm9v
bCwNCj4+ICt7DQo+PiArICAgIGxldCBtdXQgbGVmdF9ucyA9IHRpbWVvdXRfZGVsdGEuYXNfbmFu
b3MoKTsNCj4+ICsgICAgbGV0IGRlbGF5X25zID0gZGVsYXlfZGVsdGEuYXNfbmFub3MoKTsNCj4+
ICsNCj4+ICsgICAgbG9vcCB7DQo+PiArICAgICAgICBsZXQgdmFsID0gb3AoKT87DQo+PiArICAg
ICAgICBpZiBjb25kKCZ2YWwpIHsNCj4+ICsgICAgICAgICAgICAvLyBVbmxpa2UgdGhlIEMgdmVy
c2lvbiwgd2UgaW1tZWRpYXRlbHkgcmV0dXJuLg0KPj4gKyAgICAgICAgICAgIC8vIFdlIGtub3cg
dGhlIGNvbmRpdGlvbiBpcyBtZXQgc28gd2UgZG9uJ3QgbmVlZCB0byBjaGVjayBhZ2Fpbi4NCj4+
ICsgICAgICAgICAgICByZXR1cm4gT2sodmFsKTsNCj4+ICsgICAgICAgIH0NCj4+ICsNCj4+ICsg
ICAgICAgIGlmIGxlZnRfbnMgPCAwIHsNCj4+ICsgICAgICAgICAgICAvLyBVbmxpa2UgdGhlIEMg
dmVyc2lvbiwgd2UgaW1tZWRpYXRlbHkgcmV0dXJuLg0KPj4gKyAgICAgICAgICAgIC8vIFdlIGhh
dmUganVzdCBjYWxsZWQgYG9wKClgIHNvIHdlIGRvbid0IG5lZWQgdG8gY2FsbCBpdCBhZ2Fpbi4N
Cj4+ICsgICAgICAgICAgICByZXR1cm4gRXJyKEVUSU1FRE9VVCk7DQo+PiArICAgICAgICB9DQo+
PiArDQo+PiArICAgICAgICBpZiAhZGVsYXlfZGVsdGEuaXNfemVybygpIHsNCj4+ICsgICAgICAg
ICAgICB1ZGVsYXkoZGVsYXlfZGVsdGEpOw0KPj4gKyAgICAgICAgICAgIGxlZnRfbnMgLT0gZGVs
YXlfbnM7DQo+PiArICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICBjcHVfcmVsYXgoKTsNCj4+
ICsgICAgICAgIGxlZnRfbnMgLT0gMTsNCj4gDQo+IEhvdyBkbyB3ZSBrbm93IHRoYXQgZWFjaCBp
dGVyYXRpb24gY29zdHMgMW5zPyBUbyBtYWtlIGl0IGV2ZW4gbW9yZSBvYnZpb3VzLCB3ZQ0KPiBk
b24ndCBjb250cm9sIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBjb25kKCkuIFNob3VsZG4ndCB3ZSB1
c2Uga3RpbWUgZm9yIHRoaXM/DQoNClRoZSBDIHZlcnNpb24gdXNlZCB0byB1c2Uga3RpbWUgYnV0
IGl0IGhhcyBiZWVuIGNoYW5nZWQgbm90IHRvOg0KDQo3MzQ5YTY5Y2YzMTIgKCJpb3BvbGw6IERv
IG5vdCB1c2UgdGltZWtlZXBpbmcgaW4gcmVhZF9wb2xsX3RpbWVvdXRfYXRvbWljKCkiKQ0KDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvM2QyYTJmNGU1NTM0ODkzOTJkODcxMTA4Nzk3YzNi
ZTA4Zjg4MzAwYi4xNjg1NjkyODEwLmdpdC5nZWVydCtyZW5lc2FzQGdsaWRlci5iZS8NCg0KSSBk
b26idCBrbm93IGlmIHRoZSBzYW1lIHByb2JsZW0gc3RpbGwgZXhpc3RzLCBidXQgSSB0aGluayB3
ZSBzaG91bGQNCmZvbGxvdyB0aGUgQyBpbXBsZW1lbnRhdGlvbi4gVXN1YWxseSB0aGVyZaJzIGEg
Z29vZCByZWFzb24gYmVoaW5kIGl0LA0KYW5kIGl0IGhhcyBiZWVuIHdvcmtpbmcgc28gZmFyLg0K
DQpJZiB3ZSB3YW50IHRvIGRvIGl0IGRpZmZlcmVudGx5IGluIFJ1c3QsIG1heWJlIHdlIHNob3Vs
ZCBmaXJzdCBkaXNjdXNzDQp0aGUgQyBpbXBsZW1lbnRhdGlvbi4NCg0K

