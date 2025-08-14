Return-Path: <linux-kernel+bounces-768007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75235B25BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901DD1BC625E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED639244692;
	Thu, 14 Aug 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR4ObNlt"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD703242D76;
	Thu, 14 Aug 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152996; cv=none; b=K/2SHakWh7+ilJdh3FFrtRuAQtMMrmznj8ZoeP+hcnO8ukw7e/NLGEvZRQqDJrFKHXDJHmAr4C50fC5h7DwMzk2L1PwEpzpjdqU6HERlJggwvgV30BQxOYci8mVZDY1ZmGbNrDXQR+XioxYXXRly+i6ST9fe+4LuDS2XZkSa5+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152996; c=relaxed/simple;
	bh=lerQ2MZOPc6AJsNjOQaocKj4yryvf5mkENxkW+9AF7Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NpxAcI3oq5L2ocZNTGJdJs/mZgjkrw2174fV5+JyJUm7LilyRzKYt/qNZTdy/6zNoZ/2QX7UdwtF7FO8ykfcWmkwFoQ85qasPF9jLxv/igbj7iZTKtwX4qxa/zwMFxIXjHzw+6s3BLnLBuiCTAQsdVWYvn7M82CtHOlofYRnBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR4ObNlt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-321cf75482fso1593792a91.0;
        Wed, 13 Aug 2025 23:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755152993; x=1755757793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lerQ2MZOPc6AJsNjOQaocKj4yryvf5mkENxkW+9AF7Q=;
        b=XR4ObNltNHoSux8PLHL3zP/9v6eqyq2kbRN9PFcocpU/OjoiPG5/HUfflad8UKZY8p
         qB4rj4+aC5dMocNksEbKDAemGEM2N9ZhGNCDu41rdVSBIa0ryXGlw23ehGqvT153L/VZ
         8P0jwGi6aK1+dACAXtpzMR5wbnxuEhazdaSC+uu/cnIRex/g8GODvxrUirXRfKUsL4Da
         7xl6YWg1In6dOK1FqVqeoS7BHMkFf6RaO7AFAP8JSbzR+Hid641gr+/Gvz+gVL13D53+
         awhltRtUT8BXwK+X5IODzpjFaf2LSDoGSfetcTgYO6sRMgYsASK58jEpYnlhSCDhInyR
         lusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755152993; x=1755757793;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lerQ2MZOPc6AJsNjOQaocKj4yryvf5mkENxkW+9AF7Q=;
        b=rl/hXqDDW4EGwqbKZFoeCIaXCuqfv9xSsOv7elcAcAP933yGt1f9aNh2VNJrphA4Rd
         mGsEe4xQth5L5ynG+G2DRbYRDYyYr6QTqNoQ4tKk4RnVFmbg7vaMWELzL2VOJOScHKww
         N/GeDohZTFXy7atUqfgquyVpZ9TTa0S7IK28JAgWeIO+643oM0Q9EAgAhjywqadM23m8
         8mraWagIuKbbdekSePWJLiRMJplcswWRA9FjXKXKIcprUBWkzbIh0PvMgquZJUEgJIjU
         dvkds9SDVkN7fSvX5SZ9ojCeYk8cWpqP+w8C+3u2mSM5UAX057aiRSIqPm3GCdnxw3uw
         Xe2A==
X-Forwarded-Encrypted: i=1; AJvYcCUCAzy4JeAHOiusLmn5KE9CVoXKRxWuHdGnC21CQaNEhT3w5RoNzYQOdCwAL6ebzeaIGsjh5tPyF60aU2s=@vger.kernel.org, AJvYcCUJj4C8YT5BMX2SkPdDDrVU2GDvdp7VVLY9EhtjM8TIy5musXJ3OS784BpSN+1lCRqQBKUeGjPolv4Lda+BHGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Q24zqDU+TUHt7DPXGN8bAi7+jGnNXmnAooTep2rWdMuk4lax
	L2iID4CuKtpiQTueUyT7Anq5S6TsWNlUVMJgQupXGbH/vgYUoPx0dg+U
X-Gm-Gg: ASbGncuMnwWY5hco6w5iYcVNH+61GszY/Sk305hoFAZckGcXldFh1t/rjZDCQEECaje
	+QF6zSv78Q4U5GjwvD7Xnve9E3OaCFWznV86xh+VTPVEVXLcZC5RDmHX9hqueMTGHBQsF5pnVyZ
	tHCHRSy2rNtVasb0AEC0ZIQ47ZfCHbLTN0j1kL1mSdXHFNWRjUvD2eg3vhQGvpVvlqqvKY9wCR0
	mu//gozZGzvQBLLu7bakAkjrHJb9ka1urltBHM/1yTq13QL9M+WPHdqyqzb4hhwoPKPBK+iVgnY
	0st7Q7NkVuCyOmf6sfuoImqqTls+lvIuoeUQaLWiG7HjXkeJv3+Z8FkS+aTmprLrQWsmodGKfDY
	XuMVc4asH+MAnN/jTK6fLZOFjmkJuAYUShToRbbI0aqhNbeysoteUNwqKQiyN7H0F3aUK/tHSnx
	8q
X-Google-Smtp-Source: AGHT+IG76bhh0wH1rZZRGiM2iEReGw4fSXINCKbw7F49Rlfdx7M/cegp+C6UCMwLtJk+eQ6TnRiBYw==
X-Received: by 2002:a17:90b:1d47:b0:321:c56e:7569 with SMTP id 98e67ed59e1d1-3232978c6c6mr2300638a91.10.1755152992850;
        Wed, 13 Aug 2025 23:29:52 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330da89d5sm739368a91.0.2025.08.13.23.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:29:52 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:29:36 +0900 (JST)
Message-Id: <20250814.152936.963617059163777662.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com,
 me@kloenk.dev
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DBZIBAUIBYNH.3I8AZG4I8I59E@kernel.org>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
	<20250811041039.3231548-3-fujita.tomonori@gmail.com>
	<DBZIBAUIBYNH.3I8AZG4I8I59E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gTW9uLCAxMSBBdWcgMjAyNSAxMTo1NTo1NiArMDIwMA0KIkRhbmlsbyBLcnVtbXJpY2giIDxk
YWtyQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IE9uIE1vbiBBdWcgMTEsIDIwMjUgYXQgNjoxMCBB
TSBDRVNULCBGVUpJVEEgVG9tb25vcmkgd3JvdGU6DQo+PiBBZGQgcmVhZF9wb2xsX3RpbWVvdXQg
ZnVuY3Rpb25zIHdoaWNoIHBvbGwgcGVyaW9kaWNhbGx5IHVudGlsIGENCj4+IGNvbmRpdGlvbiBp
cyBtZXQgb3IgYSB0aW1lb3V0IGlzIHJlYWNoZWQuDQo+Pg0KPj4gVGhlIEMncyByZWFkX3BvbGxf
dGltZW91dCAoaW5jbHVkZS9saW51eC9pb3BvbGwuaCkgaXMgYSBjb21wbGljYXRlZA0KPj4gbWFj
cm8gYW5kIGEgc2ltcGxlIHdyYXBwZXIgZm9yIFJ1c3QgZG9lc24ndCB3b3JrLiBTbyB0aGlzIGlt
cGxlbWVudHMNCj4+IHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkgaW4gUnVzdC4NCj4+DQo+PiBUaGUg
QyB2ZXJzaW9uIHVzZXMgdXNsZWVwX3JhbmdlKCkgd2hpbGUgdGhlIFJ1c3QgdmVyc2lvbiB1c2Vz
DQo+PiBmc2xlZXAoKSwgd2hpY2ggdXNlcyB0aGUgYmVzdCBzbGVlcCBtZXRob2Qgc28gaXQgd29y
a3Mgd2l0aCBzcGFucyB0aGF0DQo+PiB1c2xlZXBfcmFuZ2UoKSBkb2Vzbid0IHdvcmsgbmljZWx5
IHdpdGguDQo+Pg0KPj4gVGhlIHNsZWVwX2JlZm9yZV9yZWFkIGFyZ3VtZW50IGlzbid0IHN1cHBv
cnRlZCBzaW5jZSB0aGVyZSBpcyBubyB1c2VyDQo+PiBmb3Igbm93LiBJdCdzIHJhcmVseSB1c2Vk
IGluIHRoZSBDIHZlcnNpb24uDQo+Pg0KPj4gcmVhZF9wb2xsX3RpbWVvdXQoKSBjYW4gb25seSBi
ZSB1c2VkIGluIGEgbm9uYXRvbWljIGNvbnRleHQuIFRoaXMNCj4+IHJlcXVpcmVtZW50IGlzIG5v
dCBjaGVja2VkIGJ5IHRoZXNlIGFic3RyYWN0aW9ucywgYnV0IGl0IGlzIGludGVuZGVkDQo+PiB0
aGF0IGtsaW50IFsxXSBvciBhIHNpbWlsYXIgdG9vbCB3aWxsIGJlIHVzZWQgdG8gY2hlY2sgaXQg
aW4gdGhlDQo+PiBmdXR1cmUuDQo+Pg0KPj4gTGluazogaHR0cHM6Ly9ydXN0LWZvci1saW51eC5j
b20va2xpbnQgWzFdDQo+PiBSZXZpZXdlZC1ieTogRmlvbmEgQmVocmVucyA8bWVAa2xvZW5rLmRl
dj4NCj4+IFRlc3RlZC1ieTogRGFuaWVsIEFsbWVpZGEgPGRhbmllbC5hbG1laWRhQGNvbGxhYm9y
YS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEgVG9tb25vcmkgPGZ1aml0YS50b21vbm9y
aUBnbWFpbC5jb20+DQo+PiAtLS0NCj4+ICBydXN0L2tlcm5lbC90aW1lLnJzICAgICAgfCAgIDEg
Kw0KPj4gIHJ1c3Qva2VybmVsL3RpbWUvcG9sbC5ycyB8IDEwNCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gDQo+IEhtLCBhcmUgd2Ugc2hvdWxkIHRoaXMgc2hvdWxk
IGdvIGluIHRoZSB0aW1lIG1vZHVsZT8gSSBkb2VzIHVzZSB0aW1la2VlcGluZw0KPiBzdHVmZiwg
YnV0IG5vdCBldmVyeSB1c2VyIG9mIHRpbWVrZWVwaW5nIHN0dWZmIHNob3VsZCBnbyB1bmRlciB0
aGUgdGltZSBtb2R1bGUuDQo+IA0KPiBUaGlzIGlzIHJhdGhlciBJL08gc3R1ZmYgYW5kIEknZCBl
eHBlY3QgaXQgaW4gcnVzdC9rZXJuZWwvaW8vcG9sbC5ycyBpbnN0ZWFkLg0KDQpFaXRoZXIgaXMg
ZmluZSBieSBtZS4NCg0KSWYgdGhlcmUgYXJlIG5vIG90aGVyIG9waW5pb25zLCBJomxsIGdvIHdp
dGggaW8vcG9sbC5ycyBpbiB0aGUgbmV4dA0KdmVyc2lvbi4NCg0KDQo+PiArLy8vIGBgYHJ1c3QN
Cj4+ICsvLy8gdXNlIGtlcm5lbDo6c3luYzo6e1NwaW5Mb2NrLCBuZXdfc3BpbmxvY2t9Ow0KPj4g
Ky8vLyB1c2Uga2VybmVsOjp0aW1lOjpEZWx0YTsNCj4+ICsvLy8gdXNlIGtlcm5lbDo6dGltZTo6
cG9sbDo6cmVhZF9wb2xsX3RpbWVvdXQ7DQo+PiArLy8vDQo+PiArLy8vIGxldCBsb2NrID0gS0Jv
eDo6cGluX2luaXQobmV3X3NwaW5sb2NrISgoKSksIGtlcm5lbDo6YWxsb2M6OmZsYWdzOjpHRlBf
S0VSTkVMKT87DQo+PiArLy8vIGxldCBnID0gbG9jay5sb2NrKCk7DQo+PiArLy8vIHJlYWRfcG9s
bF90aW1lb3V0KHx8IE9rKCgpKSwgfCgpfCB0cnVlLCBEZWx0YTo6ZnJvbV9taWNyb3MoNDIpLCBT
b21lKERlbHRhOjpmcm9tX21pY3Jvcyg0MikpKTsNCj4gDQo+IEkgYXNzdW1lIHlvdSB3YW50IHRv
IGRlbW9uc3RyYXRlIG1pc3VzZSBmcm9tIGF0b21pYyBjb250ZXggaGVyZT8gSSdkIHJhdGhlciBu
b3QNCj4gZG8gc28uIEJ1dCBpZiB3ZSByZWFsbHkgd2FudCB0aGF0LCB0aGVyZSBzaG91bGQgYmUg
YSAqdmVyeSogb2J2aW91cyBjb21tZW50DQo+IGFib3V0IHRoaXMgYmVpbmcgd3Jvbmcgc29tZXdo
ZXJlLg0KDQpJIHdhcyBkaXNjdXNzaW5nIHdpdGggQW5kcmVhcywgYW5kIEmibGwgcmVtb3ZlIHRo
aXMgZXhhbXBsZS4NCg0KPj4gKy8vLyBkcm9wKGcpOw0KPj4gKy8vLw0KPj4gKy8vLyAjIE9rOjo8
KCksIEVycm9yPigoKSkNCj4+ICsvLy8gYGBgDQo+PiArI1t0cmFja19jYWxsZXJdDQo+PiArcHVi
IGZuIHJlYWRfcG9sbF90aW1lb3V0PE9wLCBDb25kLCBUPigNCj4+ICsgICAgbXV0IG9wOiBPcCwN
Cj4+ICsgICAgbXV0IGNvbmQ6IENvbmQsDQo+PiArICAgIHNsZWVwX2RlbHRhOiBEZWx0YSwNCj4+
ICsgICAgdGltZW91dF9kZWx0YTogT3B0aW9uPERlbHRhPiwNCj4+ICspIC0+IFJlc3VsdDxUPg0K
Pj4gK3doZXJlDQo+PiArICAgIE9wOiBGbk11dCgpIC0+IFJlc3VsdDxUPiwNCj4+ICsgICAgQ29u
ZDogRm5NdXQoJlQpIC0+IGJvb2wsDQo+PiArew0KPj4gKyAgICBsZXQgc3RhcnQ6IEluc3RhbnQ8
TW9ub3RvbmljPiA9IEluc3RhbnQ6Om5vdygpOw0KPj4gKyAgICBsZXQgc2xlZXAgPSAhc2xlZXBf
ZGVsdGEuaXNfemVybygpOw0KPj4gKw0KPj4gKyAgICAvLyBVbmxpa2UgdGhlIEMgdmVyc2lvbiwg
d2UgYWx3YXlzIGNhbGwgYG1pZ2h0X3NsZWVwKClgLg0KPiANCj4gSSB0aGluayB3ZSBzaG91bGQg
ZXhwbGFpbiB3aHksIGkuZS4gdGhlIGFyZ3VtZW50IGFib3V0IGJlaW5nIGVycm9yIHByb25lLCBj
bGVhcg0KPiBzZXBhcmF0aW9uIG9mIHJlYWRfcG9sbF90aW1lb3V0KCkgYW5kIHJlYWRfcG9sbF90
aW1lb3V0X2F0b21pYygpIGZvciBrbGludCwgZXRjLg0KPiAoSSBhbHNvIHRoaW5rIHRoZSBDIHZl
cnNpb24gc2hvdWxkIG5vdCBoYXZlIGRvbmUgdGhpcyBjb25kaXRpb25hbGx5IHRvIGJlZ2luDQo+
IHdpdGguKQ0KDQovLyBVbmxpa2UgdGhlIEMgdmVyc2lvbiwgd2UgYWx3YXlzIGNhbGwgYG1pZ2h0
X3NsZWVwKClgLCBiZWNhdXNlDQovLyBjb25kaXRpb25hbCBjYWxscyBhcmUgZXJyb3ItcHJvbmUu
IFdlIGNsZWFybHkgc2VwYXJhdGUgdGhlDQovLyBgcmVhZF9wb2xsX3RpbWVvdXQoKWAgYW5kIGBy
ZWFkX3BvbGxfdGltZW91dF9hdG9taWMoKWAgZnVuY3Rpb25zIGZvcg0KLy8gdG9vbHMgbGlrZSBr
bGludC4NCg0KTG9va3MgcmVhc29uYWJsZT8NCg0K

