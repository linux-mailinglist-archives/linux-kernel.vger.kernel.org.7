Return-Path: <linux-kernel+bounces-787584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41129B37848
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3821A1B22A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED82D0621;
	Wed, 27 Aug 2025 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt1B0XUe"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E672773C3;
	Wed, 27 Aug 2025 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262626; cv=none; b=fhA5yhbFatk/IcRnAjFQL1l8YCZseYqHcS7Xgy3yO79DOi9mRvyUO3bcoRi4kphJqbpBWEi2TLFPWQ6h0MAF3lE72qk5Jkf9bsFx3n2Ww9gkwATjCUdRET3fpTedyGwtrdm6S4rXIDAKsbPJAEJGwq0OcVC6xKuhFOHZE9qckPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262626; c=relaxed/simple;
	bh=0cXawgk3itjjgVGVqi+0E78AvKI0fX8hUIgVJ8akFs8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o18CgGQNGmdYsKezrvEbQ7OI2hfeWSfRLswDw0/PN2ZVvDqBevhL+urA/FxFfmBsYjEP925AdO0psStyMUjYh8wv+bLy63d+HDoeCVEcpMH6XSuzDXr14urUWXy37TmmQE2qJ11jveIpOZTDqBJTkQxTceCd3Blm6m4MzlRSWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt1B0XUe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3254e80ba08so4542383a91.1;
        Tue, 26 Aug 2025 19:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756262624; x=1756867424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cXawgk3itjjgVGVqi+0E78AvKI0fX8hUIgVJ8akFs8=;
        b=gt1B0XUerE0xopnK2nCrLWMTXiw6cmIVMosZvs3lYSxNfUq1qEVfghcu4Fj7Gqve2H
         LPOxC2x6sBZQXeMt93VegCB7ZqU5XgTx+CnV+PA6gT+tFAqYt1vZ6ZeIM0/xZnT6Pp/2
         RcNuiS+TpKYb1qFMQi+4fY4keFVsIynYP2fvX9umsFWmemY3W5VbzA1LeOJPRvuuL2if
         hGMn5P4Y89TGaknwf+5fRCvlBSkbIzkMSSR9QqLyQnj06U29DuWCdagrKxoik8wrL4GZ
         baYnEQqrIznJ933hUU8G+JpBvJbMSOnek+hYSkcQYIA6pCHoMqqSpOYHPU+Hw28kRAaM
         Swmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756262624; x=1756867424;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0cXawgk3itjjgVGVqi+0E78AvKI0fX8hUIgVJ8akFs8=;
        b=oVOZsF0JoQcd2Nw1CDL0hUHYkhCCdEuFWe5jgfdo62vPXvj+XNanylbryuNhkGD4sE
         ZrcCPFsOTCxtYLFUjaWfPQP0QRZROnB8LxRg5saCThexnvEx5+MiXbm1bFH/E+uUGm78
         DAdiXPbzrSIdJqeaymDgvOfifucmzzo2a9+9Gych/vo6n0umNDXyxtQgEXTrA3q5Y/nM
         L6Lu0Uq1SZoelGHw7IXbptf6uT6HU1RBicmT5pTcFd47MM1OiiLNmw1ODVraTd1VvEBQ
         UEjrwN0qBBMWbU79eG00OgotXtBoIaVNQM1lQ7hbSa2yBBvWV6xfV4jtipbnx7LPMrHv
         aVsg==
X-Forwarded-Encrypted: i=1; AJvYcCWDAL3IjwD2LmT9GwtVxRMj5VRL149LqHs8IoWUgyRTkaA1cjDyDZ/uzqwPT1sClvCTJaP1vyTe5PQSwlllx+k=@vger.kernel.org, AJvYcCWb5vrTIpha5KazkoqQjzG0K+sy27feye8a+OhPslHym6u7w9UfkdQhRYMLAG3oRGr+djmuAFgKDpMNh98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9K0rBGq0CMDT1lH44v//EUfUC/q/vaiCi+UIWKHjeqDkhNOQ
	+RzZt2Mn2nR6WDs7nWg0+CFKXPsuwkEkFCskCzhcqBwHmPDVzROjU+mF
X-Gm-Gg: ASbGncttT+egpjNyzKdFneEJ/KqGFAlbY3VLECFjP216l4ftZcCamtkuypwFA0Eib6o
	Dbk7CHPIhEdFuBRBz722pvLTsdA0L9nsPjO4hZNwXSQVoZDieCXqpaEM1j+eN4Sfu2LNFbEshrH
	2yM72J+/ZMgg0t1lNzRd/yDFWRE1zUwT8NtdXGQI8tEn7husbjsq/2Am+ZGG4/X5YDBWSQqz4lX
	aLfkslf5TIcSbZEqPMwZ8rU31MhR6VYbozyUBMmdjpzISnvrhO8M7fkRdRNnz63WMePU/8omWs/
	WBS1Z/XA8gWutF0Q+gVa/CYAF2sn98Sg0Ku2oprqzo69iq35zrJoAyXHAGk04shUx88N+C4iEVs
	3AZKpXmpH/a8agQlom8b5x0PcX05Z3KSmzgw6NpnXOJBvhhsUMS6DHpfp+ckNxPtJXR4MyT42nf
	sx
X-Google-Smtp-Source: AGHT+IFXyKWVFyiHMhyqcWwWVk2QQRLquuCmxP+0ijcJ5KHHTloKdyVoHtW+w22joQsn8U9KI2NH/g==
X-Received: by 2002:a17:903:3b8f:b0:246:2e9:daa4 with SMTP id d9443c01a7336-2462edeeac7mr247727355ad.6.1756262623679;
        Tue, 26 Aug 2025 19:43:43 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887ff04sm108527775ad.120.2025.08.26.19.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:43:42 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:43:27 +0900 (JST)
Message-Id: <20250827.114327.709618113348118831.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com
Subject: Re: [PATCH v1 1/2] rust: add udelay() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <793E15AB-D69C-49F5-823E-A57F343BA3F4@collabora.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
	<20250821035710.3692455-2-fujita.tomonori@gmail.com>
	<793E15AB-D69C-49F5-823E-A57F343BA3F4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gVHVlLCAyNiBBdWcgMjAyNSAwOTo0NDoyNyAtMDMwMA0KRGFuaWVsIEFsbWVpZGEgPGRhbmll
bC5hbG1laWRhQGNvbGxhYm9yYS5jb20+IHdyb3RlOg0KDQo+PiArLy8vIEluc2VydHMgYSBkZWxh
eSBiYXNlZCBvbiBtaWNyb3NlY29uZHMgd2l0aCBidXN5IHdhaXRpbmcuDQo+PiArLy8vDQo+PiAr
Ly8vIEVxdWl2YWxlbnQgdG8gdGhlIEMgc2lkZSBbYHVkZWxheSgpYF0sIHdoaWNoIGRlbGF5cyBp
biBtaWNyb3NlY29uZHMuDQo+PiArLy8vDQo+PiArLy8vIGBkZWx0YWAgbXVzdCBiZSB3aXRoaW4g
YFswLCBgTUFYX1VERUxBWV9NU2BdYCBpbiBtaWxsaXNlY29uZHM7DQo+PiArLy8vIG90aGVyd2lz
ZSwgaXQgaXMgZXJyb25lb3VzIGJlaGF2aW9yLiBUaGF0IGlzLCBpdCBpcyBjb25zaWRlcmVkIGEg
YnVnIHRvDQo+PiArLy8vIGNhbGwgdGhpcyBmdW5jdGlvbiB3aXRoIGFuIG91dC1vZi1yYW5nZSB2
YWx1ZSwgaW4gd2hpY2ggY2FzZSB0aGUgZnVuY3Rpb24NCj4+ICsvLy8gd2lsbCBpbnNlcnQgYSBk
ZWxheSBmb3IgYXQgbGVhc3QgdGhlIG1heGltdW0gdmFsdWUgaW4gdGhlIHJhbmdlIGFuZA0KPj4g
Ky8vLyBtYXkgd2FybiBpbiB0aGUgZnV0dXJlLg0KPj4gKy8vLw0KPj4gKy8vLyBUaGUgYmVoYXZp
b3IgYWJvdmUgZGlmZmVycyBmcm9tIHRoZSBDIHNpZGUgW2B1ZGVsYXkoKWBdIGZvciB3aGljaCBv
dXQtb2YtcmFuZ2UNCj4+ICsvLy8gdmFsdWVzIGNvdWxkIGxlYWQgdG8gYW4gb3ZlcmZsb3cgYW5k
IHVuZXhwZWN0ZWQgYmVoYXZpb3IuDQo+PiArLy8vDQo+PiArLy8vIFtgdWRlbGF5KClgXTogaHR0
cHM6Ly9kb2NzLmtlcm5lbC5vcmcvdGltZXJzL2RlbGF5X3NsZWVwX2Z1bmN0aW9ucy5odG1sI2Mu
dWRlbGF5DQo+PiArcHViIGZuIHVkZWxheShkZWx0YTogRGVsdGEpIHsNCj4+ICsgICAgY29uc3Qg
TUFYX1VERUxBWV9ERUxUQTogRGVsdGEgPSBEZWx0YTo6ZnJvbV9taWxsaXMoYmluZGluZ3M6Ok1B
WF9VREVMQVlfTVMgYXMgaTY0KTsNCj4gDQo+IFdlIHNob3VsZCBwZXJoYXBzIGFkZCBhIGJ1aWxk
X2Fzc2VydCBoZXJlIHRvIG1ha2Ugc3VyZSB0aGlzIGNhc3QgaXMgYWx3YXlzIHZhbGlkPw0KDQpB
cmUgeW91IGNvbmNlcm5lZCB0aGF0IGJpbmRpbmdzOjpNQVhfVURFTEFZX01TIG1pZ2h0IGV4Y2Vl
ZCBpNjQ6Ok1BWD8NCg0KSWYgc28sIHN1Y2ggYSB2YWx1ZSBzZWVtcyB1bnJlYWxpc3RpYyBhcyBh
IGRlbGF5LiBXaGlsZQ0KYmluZGluZ3M6Ok1BWF9VREVMQVlfTVMgaXMgYXJjaGl0ZWN0dXJlLWRl
cGVuZGVudCwgaXRzIG1heGltdW0gaXMNCmN1cnJlbnRseSAxMCwgc28gSSBkb26idCB0aGluayB0
aGlzIHdpbGwgZXZlciBiZWNvbWUgYW4gaXNzdWUgaW4gdGhlDQpmdXR1cmUuDQoNCklmIHJlYWxs
eSBuZWNlc3NhcnksIHdlIGNvdWxkIGFkZCBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5ncz8N
Cg0KYnVpbGRfYXNzZXJ0IShpMTI4Ojpmcm9tKGJpbmRpbmdzOjpNQVhfVURFTEFZX01TKSA8IGk2
NDo6TUFYLmludG8oKSk7DQoNCj4+ICsNCj4+ICsgICAgbGV0IGRlbHRhID0gaWYgKERlbHRhOjpa
RVJPLi49TUFYX1VERUxBWV9ERUxUQSkuY29udGFpbnMoJmRlbHRhKSB7DQo+PiArICAgICAgICBk
ZWx0YQ0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgLy8gVE9ETzogQWRkIFdBUk5fT05D
RSgpIHdoZW4gaXQncyBzdXBwb3J0ZWQuDQo+PiArICAgICAgICBNQVhfVURFTEFZX0RFTFRBDQo+
PiArICAgIH07DQo+PiArDQo+PiArICAgIC8vIFNBRkVUWTogSXQgaXMgYWx3YXlzIHNhZmUgdG8g
Y2FsbCBgdWRlbGF5KClgIHdpdGggYW55IGR1cmF0aW9uLg0KPj4gKyAgICB1bnNhZmUgew0KPj4g
KyAgICAgICAgLy8gQ29udmVydCB0aGUgZHVyYXRpb24gdG8gbWljcm9zZWNvbmRzIGFuZCByb3Vu
ZCB1cCB0byBwcmVzZXJ2ZQ0KPj4gKyAgICAgICAgLy8gdGhlIGd1YXJhbnRlZTsgYHVkZWxheSgp
YCBpbnNlcnRzIGEgZGVsYXkgZm9yIGF0IGxlYXN0DQo+PiArICAgICAgICAvLyB0aGUgcHJvdmlk
ZWQgZHVyYXRpb24sIGJ1dCB0aGF0IGl0IG1heSBkZWxheSBmb3IgbG9uZ2VyDQo+PiArICAgICAg
ICAvLyB1bmRlciBzb21lIGNpcmN1bXN0YW5jZXMuDQo+PiArICAgICAgICBiaW5kaW5nczo6dWRl
bGF5KGRlbHRhLmFzX21pY3Jvc19jZWlsKCkgYXMgY191bG9uZykNCj4+ICsgICAgfQ0KPj4gK30N
Cj4+IC0tIA0KPj4gMi40My4wDQo+PiANCj4+IA0KPiANCj4gV2l0aCB0aGUgY2hhbmdlIHlvdSBz
dWdnZXN0ZWQgZm9yIHRoZSBzYWZldHkgY29tbWVudCBpbiB1ZGVsYXk6DQo+IA0KPiBSZXZpZXdl
ZC1ieTogRGFuaWVsIEFsbWVpZGEgPGRhbmllbC5hbG1laWRhQGNvbGxhYm9yYS5jb20+DQoNCkFz
IE1pZ3VlbCB3cm90ZSwgYW55IGR1cmF0aW9uIGlzIHNhZmUgZnJvbSBSdXN0onMgcGVyc3BlY3Rp
dmUsIGFuZCBpdA0Kd29uonQgaW52b2tlIFVCIG9uIHRoZSBDIHNpZGUgZWl0aGVyLg0KDQpTbyBJ
J20gbm90IHN1cmUgdGhlIGFib3ZlIHNhZmV0eSBjb21tZW50IG5lZWRzIHRvIGJlIGNoYW5nZWQu
IExldKJzDQphc2sgZm9yIEFuZHJlYXOicyBvcGluaW9uLg0KDQo=

