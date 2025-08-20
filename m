Return-Path: <linux-kernel+bounces-777534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4AB2DA92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA8C7B6664
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65412E36FF;
	Wed, 20 Aug 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLBhEeLx"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF02D47F2;
	Wed, 20 Aug 2025 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688315; cv=none; b=lBQNb7etOgVpjQtmlj5PxHV/jS2kZMoobci18BdRM7WYED7prQKonkTjLXqbqr65ZIgYOOuJm70gw7oYRGvTPRWbqG6PC29NWhqCJT2SKcbDrV0CeNzzYrIV4dbPerJ/tA1+L7SuTJpKnzAF/KNBTNEpJoYzOZJNDj7CPMCKVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688315; c=relaxed/simple;
	bh=8ldqBdkFdM1w1dqFgmfPDteMDbpSSPRdNIj1VewVOYk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YeSgwFXwu6YuXlls5Shsch4t7DiLn/JCjj8lRGLbHXhLoKpnu40mlrUh/ztcpUn0h68HVBlZthMfrq6E/s9PjFCM7sQ/ZwsrNLf2g5E7bnBK0MmV1U3qCwH5qEeNZHdKKsc4I6bCL3KHyFNlhz45ZOwTMRQrNEfTefi//qKZ83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLBhEeLx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e93370ab8so498565b3a.1;
        Wed, 20 Aug 2025 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755688313; x=1756293113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ldqBdkFdM1w1dqFgmfPDteMDbpSSPRdNIj1VewVOYk=;
        b=jLBhEeLxQdk9dKmeCjMyxBUS3bJ2jfAc3uHC76t17gLKvlx8WmFWpjgvVnSiN0SLNS
         z8aaaLRY89kkrqXp2+zqkzdooHtG0s8GXTk4dLmmdK05vrQX41X+b4rwtZnIzBgZoP/M
         ka1eq80DItVTPcXykpmwyBl3dUelwmYeLQlzv/xETYdm6tqK/K5pFvxw1mISR2eKCbdL
         w/2EGNVLLkbraJs+SCYhJbYWhCrMo9pF+NPdbG6Z7PRoH+NknKFt/iEgSYMgRIrTi2h4
         4iMGrXKXA0px2OfT/aw3R2naasZBYw6W6T1fD2MKakjNtvEk/4hMbFj+fGSj125ObjH/
         wZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688313; x=1756293113;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ldqBdkFdM1w1dqFgmfPDteMDbpSSPRdNIj1VewVOYk=;
        b=E2JAikg/0eZ43E3Wzng9OQsX115Ro8EncD8S8888CnwHGeyoacmDSHZQWDyAHTHRFH
         U88WLSwHImrW6wvBVAQ+7r85PuJLNWlMIasHmAE3BWFHli0i2zz2cqYmGnSxurHlcwo5
         4Qh2VlRRuAO+Piu3CE4B9PxUSlUTh0j5Tek35nvwrSxsrIFmFiHZndgja9Cf5dl6ecdG
         N32sHzs3V0PxUmuIhkDLU9rvjAsVRLyBY+JgxLorQ7xTII3EpEiu6lJz+6eVxSCaKzrI
         a645w+ykRgUCVPFZBbdgpdCHSvjAn9Ti/Lt0Kdr0/N61H+MYdsOqueyXf3iFszNtWGto
         6K+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6viMYHJ+f0hppf/8NuhqkGGvVsx6jgFdRfdLX2Y/lzqwT1KtI9pZp5bm5zOCJJe9wk1tvyF/bjx4meFQ=@vger.kernel.org, AJvYcCUQUqCqqZ8pfG5QbM4ISPmtGkrW870RhLBQOPONN83YDxwM031HJOB5IMMk6he4BINiBVll19aMSKHmO1PXQ+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4O5A6LDPCZ5jTTfmn/DDiFukuwlvz0hOcuaOxeuSb6FFP9PQ
	ah5y9khkF7rfQ/4YWD2WfaUM7magTb4shgFYpB28FNoqvYa3yuZL7eyH
X-Gm-Gg: ASbGncuOYJlRx5ctRLaJM4agHcd2YFN0+OkoWyoOGCY/F7f0ogs98A0KBRsIKmNI6Pg
	XzO3c4+logEXmYuPt56LYcmv7vVUoLq/HM/GU6YHa5OgxrB8ExurPqIQNlLf20BmJPIoy+yt2R8
	AIBE/EhJE+eIXMRVi4blli8tnTuJZehnB8hCsQwHPtehtcsrxccpGtGzKVUt29F72oHwOCxs6u8
	ais8oO/KkCv3eIJB1CdNfVK96MyqqDp3Q2KnvgwN9F72G74bCAYDPxax+hLyqEJZiiCV8N7yG+7
	j9DiMiSkKY4Lgsy4Z0kPbe8IivX0RP7kQZ41LXcyE6OsIBC6bS+sCd6+Np1eGzvD/S4rkB/xRHA
	Ymkn3krsll68X/AMex1DDl6UIte2Ll5/yP1BrEjlsZgMThG3BvEn0SnPBdXnA8G98eYXMsiwneC
	/6
X-Google-Smtp-Source: AGHT+IHS+uX8Lb3LRD4/8MFkf0JISSu19nYG/H2AX0qvShvcoRrChOmid88P7jHQPVgCwCeiHRbL9g==
X-Received: by 2002:a05:6a20:3ca7:b0:232:22a4:bd2b with SMTP id adf61e73a8af0-2431b93a316mr4270565637.33.1755688312725;
        Wed, 20 Aug 2025 04:11:52 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640908d9sm1993021a12.29.2025.08.20.04.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:11:52 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:11:39 +0900 (JST)
Message-Id: <20250820.201139.2145357080225408024.fujita.tomonori@gmail.com>
To: acourbot@nvidia.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, daniel.almeida@collabora.com,
 me@kloenk.dev
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DC5ZPDQADDJT.32SFK2OHDRGTG@nvidia.com>
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
	<20250817044724.3528968-3-fujita.tomonori@gmail.com>
	<DC5ZPDQADDJT.32SFK2OHDRGTG@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gVHVlLCAxOSBBdWcgMjAyNSAwOTo0OTozOCArMDkwMA0KIkFsZXhhbmRyZSBDb3VyYm90IiA8
YWNvdXJib3RAbnZpZGlhLmNvbT4gd3JvdGU6DQoNCj4gT24gU3VuIEF1ZyAxNywgMjAyNSBhdCAx
OjQ3IFBNIEpTVCwgRlVKSVRBIFRvbW9ub3JpIHdyb3RlOg0KPj4gQWRkIHJlYWRfcG9sbF90aW1l
b3V0IGZ1bmN0aW9uIHdoaWNoIHBvbGwgcGVyaW9kaWNhbGx5IHVudGlsIGENCj4+IGNvbmRpdGlv
biBpcyBtZXQgb3IgYSB0aW1lb3V0IGlzIHJlYWNoZWQuDQo+Pg0KPj4gVGhlIEMncyByZWFkX3Bv
bGxfdGltZW91dCAoaW5jbHVkZS9saW51eC9pb3BvbGwuaCkgaXMgYSBjb21wbGljYXRlZA0KPj4g
bWFjcm8gYW5kIGEgc2ltcGxlIHdyYXBwZXIgZm9yIFJ1c3QgZG9lc24ndCB3b3JrLiBTbyB0aGlz
IGltcGxlbWVudHMNCj4+IHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkgaW4gUnVzdC4NCj4+DQo+PiBU
aGUgQyB2ZXJzaW9uIHVzZXMgdXNsZWVwX3JhbmdlKCkgd2hpbGUgdGhlIFJ1c3QgdmVyc2lvbiB1
c2VzDQo+PiBmc2xlZXAoKSwgd2hpY2ggdXNlcyB0aGUgYmVzdCBzbGVlcCBtZXRob2Qgc28gaXQg
d29ya3Mgd2l0aCBzcGFucyB0aGF0DQo+PiB1c2xlZXBfcmFuZ2UoKSBkb2Vzbid0IHdvcmsgbmlj
ZWx5IHdpdGguDQo+Pg0KPj4gVGhlIHNsZWVwX2JlZm9yZV9yZWFkIGFyZ3VtZW50IGlzbid0IHN1
cHBvcnRlZCBzaW5jZSB0aGVyZSBpcyBubyB1c2VyDQo+PiBmb3Igbm93LiBJdCdzIHJhcmVseSB1
c2VkIGluIHRoZSBDIHZlcnNpb24uDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IEFuZHJlYXMgSGluZGJv
cmcgPGEuaGluZGJvcmdAa2VybmVsLm9yZz4NCj4+IFJldmlld2VkLWJ5OiBGaW9uYSBCZWhyZW5z
IDxtZUBrbG9lbmsuZGV2Pg0KPj4gVGVzdGVkLWJ5OiBEYW5pZWwgQWxtZWlkYSA8ZGFuaWVsLmFs
bWVpZGFAY29sbGFib3JhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEZVSklUQSBUb21vbm9yaSA8
ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbT4NCj4gDQo+IFRlc3RlZCB0aGlzIHdpdGggbm92YS1j
b3JlLCBhbmQgaXQgc2VlbXMgdG8gd29yayBmaW5lIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IEFsZXhh
bmRyZSBDb3VyYm90IDxhY291cmJvdEBudmlkaWEuY29tPg0KPiBUZXN0ZWQtYnk6IEFsZXhhbmRy
ZSBDb3VyYm90IDxhY291cmJvdEBudmlkaWEuY29tPg0KDQpUaGFua3MhDQoNCj4gSnVzdCBvbmUg
bGFzdCBjb21tZW50IGFib3V0IHRoZSBkb2N1bWVudGF0aW9uIGJlbG93Lg0KPiANCj4gPHNuaXA+
DQo+PiArLy8vIFBvbGxzIHBlcmlvZGljYWxseSB1bnRpbCBhIGNvbmRpdGlvbiBpcyBtZXQgb3Ig
YSB0aW1lb3V0IGlzIHJlYWNoZWQuDQo+PiArLy8vDQo+PiArLy8vIFRoZSBmdW5jdGlvbiByZXBl
YXRlZGx5IGV4ZWN1dGVzIHRoZSBnaXZlbiBvcGVyYXRpb24gYG9wYCBjbG9zdXJlIGFuZA0KPj4g
Ky8vLyBjaGVja3MgaXRzIHJlc3VsdCB1c2luZyB0aGUgY29uZGl0aW9uIGNsb3N1cmUgYGNvbmRg
Lg0KPj4gKy8vLw0KPj4gKy8vLyBJZiBgY29uZGAgcmV0dXJucyBgdHJ1ZWAsIHRoZSBmdW5jdGlv
biByZXR1cm5zIHN1Y2Nlc3NmdWxseSB3aXRoIHRoZSByZXN1bHQgb2YgYG9wYC4NCj4+ICsvLy8g
T3RoZXJ3aXNlLCBpdCB3YWl0cyBmb3IgYSBkdXJhdGlvbiBzcGVjaWZpZWQgYnkgYHNsZWVwX2Rl
bHRhYA0KPj4gKy8vLyBiZWZvcmUgZXhlY3V0aW5nIGBvcGAgYWdhaW4uDQo+PiArLy8vDQo+PiAr
Ly8vIFRoaXMgcHJvY2VzcyBjb250aW51ZXMgdW50aWwgZWl0aGVyIGBjb25kYCByZXR1cm5zIGB0
cnVlYCBvciB0aGUgdGltZW91dCwNCj4+ICsvLy8gc3BlY2lmaWVkIGJ5IGB0aW1lb3V0X2RlbHRh
YCwgaXMgcmVhY2hlZC4gSWYgYHRpbWVvdXRfZGVsdGFgIGlzIGBOb25lYCwNCj4gDQo+IEZvciBw
cmVjaXNpb246ICJUaGlzIHByb2Nlc3MgY29udGludWVzIHVudGlsIGVpdGhlciBgb3BgIHJldHVy
bnMgYW5kDQo+IGVycm9yLCBgY29uZGAgcmV0dXJucyBgdHJ1ZWAsIG9yIHRoZSB0aW1lb3V0IHNw
ZWNpZmllZCBieQ0KPiBgdGltZW91dF9kZWx0YWAgaXMgcmVhY2hlZC4iDQoNCkluZGVlZCwgYG9w
YCBzaG91bGQgYmUgbWVudGlvbmVkIGhlcmUuDQoNCkkgdGhpbmsgaXQgc2hvdWxkIGJlICJvcCBy
ZXR1cm5zIGFuIGVycm9yIiwgbm90ICJvcCByZXR1cm5zIGFuZCBlcnJvciIsDQpyaWdodD8NCg0K
VGhlcmUgYXJlIHRocmVlIGFsdGVybmF0aXZlcywgc28gSaJkIHJlbW92ZSAiZWl0aGVyIi4gVGhl
IHNlbnRlbmNlDQp3b3VsZCBiZToNCg0KVGhpcyBwcm9jZXNzIGNvbnRpbnVlcyB1bnRpbCBlaXRo
ZXIgYG9wYCByZXR1cm5zIGFuIGVycm9yLCBgY29uZGANCnJldHVybnMgYHRydWVgLCBvciB0aGUg
dGltZW91dCBzcGVjaWZpZWQgYnkgYHRpbWVvdXRfZGVsdGFgIGlzDQpyZWFjaGVkLg0KDQpJIGp1
c3QgcmVhbGl6ZWQgdGhhdCAiSWYgYHRpbWVvdXRfZGVsdGFgIGlzIGBOb25lYCwiIGNvbW1lbnQg
aXMgb3V0ZGF0ZWQuIEknbGwgdXBkYXRlLg0KDQoNCj4+ICsvLy8gcG9sbGluZyBjb250aW51ZXMg
aW5kZWZpbml0ZWx5IHVudGlsIGBjb25kYCBldmFsdWF0ZXMgdG8gYHRydWVgIG9yIGFuIGVycm9y
IG9jY3Vycy4NCj4+ICsvLy8NCj4+ICsvLy8gVGhpcyBmdW5jdGlvbiBjYW4gb25seSBiZSB1c2Vk
IGluIGEgbm9uYXRvbWljIGNvbnRleHQuDQo+IA0KPiBIZXJlIEknZCBhZGQgYW4gZXJyb3JzIHNl
Y3Rpb246DQo+IA0KPiAjIEVycm9ycw0KPiANCj4gSWYgYG9wYCByZXR1cm5zIGFuIGVycm9yLCB0
aGVuIHRoYXQgZXJyb3IgaXMgcmV0dXJuZWQgZGlyZWN0bHkuDQo+IA0KPiBJZiB0aGUgdGltZW91
dCBzcGVjaWZpZWQgYnkgYHRpbWVvdXRfZGVsdGFgIGlzIHJlYWNoZWQsIHRoZW4NCj4gYEVycihF
VElNRURPVVQpYCBpcyByZXR1cm5lZC4NCg0KVGhhbmtzLCBsb29rcyBuaWNlLiBJJ2xsIGFkZCBp
dC4NCg0KDQo+PiArICAgIGxvb3Agew0KPj4gKyAgICAgICAgbGV0IHZhbCA9IG9wKCk/Ow0KPj4g
KyAgICAgICAgaWYgY29uZCgmdmFsKSB7DQo+PiArICAgICAgICAgICAgLy8gVW5saWtlIHRoZSBD
IHZlcnNpb24sIHdlIGltbWVkaWF0ZWx5IHJldHVybi4NCj4+ICsgICAgICAgICAgICAvLyBXZSBr
bm93IHRoZSBjb25kaXRpb24gaXMgbWV0IHNvIHdlIGRvbid0IG5lZWQgdG8gY2hlY2sgYWdhaW4u
DQo+IA0KPiBuaXQ6IHRoaXMgY29tbWVudCBsb29rcyBzdXBlcmZsdW91cyB0byBtZSwgdGhpcyBp
cyBhIGRpZmZlcmVudA0KPiBpbXBsZW1lbnRhdGlvbiBmcm9tIHRoZSBDIHZlcnNpb24gYW55d2F5
Lg0KDQpBIHByZXZpb3VzIHJldmlldyBtZW50aW9uZWQgdGhhdCwgc2luY2UgdGhpcyBmdW5jdGlv
biBzaGFyZXMgdGhlIHNhbWUNCm5hbWUgYXMgdGhlIEMgdmVyc2lvbiwgaXQncyBnb29kIHRvIG1h
a2UgdGhlIGRpZmZlcmVudCBiZWhhdmlvcg0KZXhwbGljaXQuIEl0IG1heSBiZSBhIGJpdCByZWR1
bmRhbnQsIGJ1dCBJJ2QgcHJlZmVyIHRvIGtlZXAgaXQuDQo=

