Return-Path: <linux-kernel+bounces-767992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC85B25BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9151C83A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0FF23AB88;
	Thu, 14 Aug 2025 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D76yLqre"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24223771E;
	Thu, 14 Aug 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151916; cv=none; b=HNEx08KbXp+ueIxcUjcHwXItXcphwTzj4l+u28M9B62smJwhjZKqGng57peEjANRcxS3ZxX+XQTpFTwWuQUk1GAjvNj8YfZknbYlXCvpnjV2GUVrQ0GgkC7/wc/JX+Cx400MuvY/TH4VIdVUtc4YAYGsG9LG+LGOcVoZHsTXWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151916; c=relaxed/simple;
	bh=kmwt8fiGbWLmRNWRjlhDa9T8TcCVGv3HdEByzN0nho0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GAnXUVf9yON4HjcUOdPXqhtIJHQoStX+wdqpyNRIVOMmfvsw2GBaMp0nMn39EjMiwW4FUHpCQiwFMEu9C1oNQH+SxvGAWpwZgOTLR3wffZW9b6y+qc/Y1PFNj5xc2rIZmlr/AjZFkoqvLUl2Ph7GE/AYau/2y2uq0pyTNYkqYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D76yLqre; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-244582738b5so4577845ad.3;
        Wed, 13 Aug 2025 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755151914; x=1755756714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmwt8fiGbWLmRNWRjlhDa9T8TcCVGv3HdEByzN0nho0=;
        b=D76yLqre63JVxNROOaWBkfdyjncvvPqw3sOseTuyTTEpq44JwAst8JjDw/DaTk97WT
         sgQblBhzHYI/v8l92F4I/6jlX6l7ER6k7jyrDIDHXWQrLJaX43gmh3LNizK3+jcOi3bS
         z3suTDlYe0TusKfVW80JfqO9AeWQNOrU++hUloB1fVea1ERpTsOuJuST23bNnuHOZOAP
         x4boJRwZEXK5Wz3mC0mqdzhdAF9g1F0jbRgudZn/ujHF4kQbHJ4VkQeEhQiZ6HdIpva+
         M5WjXTTpPMYcAYd7IqZPNRIId/rRF5ssEvoqta53MwDjTXz5Hn0oxtfz8lhs9qO96bEm
         Prhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755151914; x=1755756714;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmwt8fiGbWLmRNWRjlhDa9T8TcCVGv3HdEByzN0nho0=;
        b=eqXXHoAea8BPfkJFrWKvX4o/oaqpz53Vm2xlqNk3+0V0NV1XLB+sVsJoZOQOE6zfqb
         AHdcptY08yN3kArgeejPkmOToJhOcBlet3wkXKkbvBV0csNZafGn7IE9987dkuSoNyqk
         d1hyaUWy5m4hIHDR9OVjF5aNofo1C2PazjuwY3Rlm6FHzqQa+G+kmer7iOUGY4Q7xifr
         EUDCWl0Gz+rMKwytTjXAh5VU2dpS/O7XgTzydcKDf0NlHBkC+mGIQYjgxCQwSCj/Zcyz
         afwuuH50KLLkOTHZQVFyO4V2aFIbz3gdqXJWSaGNMovMJBirO8d0B8tNnPuH5JSiyJBC
         Z9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUls0+Z5kof7cxnWq50vwiIuSjL524Kclh/1bDruLGJ0GrapyDKVyz8taurqQRStqsuNoEBLidDckzZxjTzDBo=@vger.kernel.org, AJvYcCVRDL9Mq1B/37nDdNLKFTK1Boew/QaNWJnGqoD7aqfzoAPBZPqbJJuOWxc67yjwRfPdc8hcwUDylLADBGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDxOFNWxKTP7cZ6Nj5RrjVqzsejtlaJj04hTL7p+0DnqPTGOr
	GCL4z9XWbL1BG9V8XMy8Z87wbIByMdXMBLTNUKgyIEGw143pJIF3JKk8
X-Gm-Gg: ASbGncvr5giIapfOh3VHAj6VwHgg4thUmy44Lia9qIKt3za5Hk9A/r8g7dEoPLJAv24
	/qldRTUXVkrmicelJdoC0Rs6uIOKgZ6LDJTuBE/4i6ScQslKia8KqTkLgQAdrT4OmX5zdn5Q6i2
	58DE2ua7fKXHTLGoSk4GxqMvJSlOOLvFdmTGyYI2pcG+Ix2FQNbmO3A/X+22EpQt7V+63e43UtR
	wUHJBCeDgopFb1BvezI/bsUH49LvlO900020Xrh/93CBdmHx+Os0aqCBcF69Mmjftna5U2/dtIt
	ccT/j7ESlOuHDuCzDqLYlcnQUVd5eKKqZqIpWaaMIeWnFpFp0rctjaeVXVuq7rHFur5ZTpJkxpA
	vi+zW1Vgt1cjud6VwM26NOMCThXvZyzSvEr0Qsnd0t6m8bZEdznYYZE3yug59a4c9mqsum0fagx
	As
X-Google-Smtp-Source: AGHT+IHgr7iVIJfwXjhhOlm4dg7s8qa4l1b4p1J2IhloSLiVNBtyIEvClp6yQcnRWvm8inpGG6sAoA==
X-Received: by 2002:a17:902:ce0f:b0:240:72e9:87bb with SMTP id d9443c01a7336-244586c3844mr29551235ad.42.1755151914361;
        Wed, 13 Aug 2025 23:11:54 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aac2e0sm340014805ad.171.2025.08.13.23.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:11:53 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:11:47 +0900 (JST)
Message-Id: <20250814.151147.29094382820492173.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com,
 me@kloenk.dev
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aJm9A_D-zlJtbV6X@google.com>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
	<20250811041039.3231548-3-fujita.tomonori@gmail.com>
	<aJm9A_D-zlJtbV6X@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gTW9uLCAxMSBBdWcgMjAyNSAwOTo1MDo1OSArMDAwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIE1vbiwgQXVnIDExLCAyMDI1IGF0IDAxOjEwOjM4
UE0gKzA5MDAsIEZVSklUQSBUb21vbm9yaSB3cm90ZToNCj4+IEFkZCByZWFkX3BvbGxfdGltZW91
dCBmdW5jdGlvbnMgd2hpY2ggcG9sbCBwZXJpb2RpY2FsbHkgdW50aWwgYQ0KPj4gY29uZGl0aW9u
IGlzIG1ldCBvciBhIHRpbWVvdXQgaXMgcmVhY2hlZC4NCj4+IA0KPj4gVGhlIEMncyByZWFkX3Bv
bGxfdGltZW91dCAoaW5jbHVkZS9saW51eC9pb3BvbGwuaCkgaXMgYSBjb21wbGljYXRlZA0KPj4g
bWFjcm8gYW5kIGEgc2ltcGxlIHdyYXBwZXIgZm9yIFJ1c3QgZG9lc24ndCB3b3JrLiBTbyB0aGlz
IGltcGxlbWVudHMNCj4+IHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkgaW4gUnVzdC4NCj4+IA0KPj4g
VGhlIEMgdmVyc2lvbiB1c2VzIHVzbGVlcF9yYW5nZSgpIHdoaWxlIHRoZSBSdXN0IHZlcnNpb24g
dXNlcw0KPj4gZnNsZWVwKCksIHdoaWNoIHVzZXMgdGhlIGJlc3Qgc2xlZXAgbWV0aG9kIHNvIGl0
IHdvcmtzIHdpdGggc3BhbnMgdGhhdA0KPj4gdXNsZWVwX3JhbmdlKCkgZG9lc24ndCB3b3JrIG5p
Y2VseSB3aXRoLg0KPj4gDQo+PiBUaGUgc2xlZXBfYmVmb3JlX3JlYWQgYXJndW1lbnQgaXNuJ3Qg
c3VwcG9ydGVkIHNpbmNlIHRoZXJlIGlzIG5vIHVzZXINCj4+IGZvciBub3cuIEl0J3MgcmFyZWx5
IHVzZWQgaW4gdGhlIEMgdmVyc2lvbi4NCj4+IA0KPj4gcmVhZF9wb2xsX3RpbWVvdXQoKSBjYW4g
b25seSBiZSB1c2VkIGluIGEgbm9uYXRvbWljIGNvbnRleHQuIFRoaXMNCj4+IHJlcXVpcmVtZW50
IGlzIG5vdCBjaGVja2VkIGJ5IHRoZXNlIGFic3RyYWN0aW9ucywgYnV0IGl0IGlzIGludGVuZGVk
DQo+PiB0aGF0IGtsaW50IFsxXSBvciBhIHNpbWlsYXIgdG9vbCB3aWxsIGJlIHVzZWQgdG8gY2hl
Y2sgaXQgaW4gdGhlDQo+PiBmdXR1cmUuDQo+IA0KPiBJIHdvdWxkIGRyb3AgdGhpcyBwYXJhZ3Jh
cGguIFlvdSBoYXZlIGEgY2FsbCB0byBtaWdodF9zbGVlcCgpIG5vdy4NCg0KRG8geW91IG1lYW4g
dGhhdCwgc2luY2UgaXSicyBvYnZpb3VzIG1pZ2h0X3NsZWVwKCkgY2FuIG9ubHkgYmUgdXNlZCBp
bg0KYSBub24tYXRvbWljIGNvbnRleHQsIHRoZSBhYm92ZSBzdGF0ZW1lbnQgaXMgcmVkdW5kYW50
IGFuZCBjYW4gYmUNCmRyb3BwZWQ/DQoNCj4+ICsjW3RyYWNrX2NhbGxlcl0NCj4+ICtwdWIgZm4g
cmVhZF9wb2xsX3RpbWVvdXQ8T3AsIENvbmQsIFQ+KA0KPj4gKyAgICBtdXQgb3A6IE9wLA0KPj4g
KyAgICBtdXQgY29uZDogQ29uZCwNCj4+ICsgICAgc2xlZXBfZGVsdGE6IERlbHRhLA0KPj4gKyAg
ICB0aW1lb3V0X2RlbHRhOiBPcHRpb248RGVsdGE+LA0KPj4gKykgLT4gUmVzdWx0PFQ+DQo+PiAr
d2hlcmUNCj4+ICsgICAgT3A6IEZuTXV0KCkgLT4gUmVzdWx0PFQ+LA0KPj4gKyAgICBDb25kOiBG
bk11dCgmVCkgLT4gYm9vbCwNCj4gDQo+IEkgd291bGQgY29uc2lkZXIganVzdCB3cml0aW5nIHRo
aXMgYXM6DQo+DQo+IHB1YiBmbiByZWFkX3BvbGxfdGltZW91dDxUPigNCj4gICAgIG11dCBvcDog
aW1wbCBGbk11dCgpIC0+IFJlc3VsdDxUPiwNCj4gICAgIG11dCBjb25kOiBpbXBsIEZuTXV0KCZU
KSAtPiBib29sLA0KPiAgICAgc2xlZXBfZGVsdGE6IERlbHRhLA0KPiAgICAgdGltZW91dF9kZWx0
YTogT3B0aW9uPERlbHRhPiwNCj4gKSAtPiBSZXN1bHQ8VD4NCg0KU3VyZWx5LCBJJ2xsIGRvLg0K
DQo+IEFuZCBJIHdvdWxkIGFsc28gY29uc2lkZXIgYWRkaW5nIGEgbmV3IGVycm9yIHR5cGUgY2Fs
bGVkIFRpbWVvdXRFcnJvcg0KPiBzaW1pbGFyIHRvIEJhZEZkRXJyb3IgaW4gYHJ1c3Qva2VybmVs
L2ZzL2ZpbGUucnNgLiBUaGF0IHdheSwgd2UgcHJvbWlzZQ0KPiB0byB0aGUgY2FsbGVyIHRoYXQg
d2UgbmV2ZXIgcmV0dXJuIGVycm9yIGNvZGVzIG90aGVyIHRoYW4gYSB0aW1lb3V0Lg0KDQpVbmRl
cnN0b29kLCBJJ2xsLg0KDQo+IEFub3RoZXIgdGhpbmcgaXMgdGhlIGB0aW1lb3V0X2RlbHRhYCBv
cHRpb24uIEkgd291bGQganVzdCBoYXZlIHdyaXR0ZW4NCj4gaXQgYXMgdHdvIG1ldGhvZHMsIG9u
ZSB0aGF0IHRha2VzIGEgdGltZW91dCBhbmQgb25lIHRoYXQgZG9lc24ndC4gVGhhdA0KPiB3YXks
IGNhbGxlcnMgdGhhdCBkb24ndCBuZWVkIGEgdGltZW91dCBkbyBub3QgbmVlZCB0byBoYW5kbGUg
dGltZW91dA0KPiBlcnJvcnMuIChEbyB3ZSBoYXZlIGFueSB1c2VycyB3aXRob3V0IGEgdGltZW91
dD8gSWYgbm90LCBtYXliZSBqdXN0DQo+IHJlbW92ZSB0aGUgT3B0aW9uLikNCg0KSSdsbCByZW1v
dmUgdGhlIE9wdGlvbiBhbmQgbGV0J3Mgc2VlIGlmIHdlomxsIG5lZWQgYSB2ZXJzaW9uIHdpdGhv
dXQgYQ0KdGltZW91dC4NCg0KDQo+PiArew0KPj4gKyAgICBsZXQgc3RhcnQ6IEluc3RhbnQ8TW9u
b3RvbmljPiA9IEluc3RhbnQ6Om5vdygpOw0KPj4gKyAgICBsZXQgc2xlZXAgPSAhc2xlZXBfZGVs
dGEuaXNfemVybygpOw0KPj4gKw0KPj4gKyAgICAvLyBVbmxpa2UgdGhlIEMgdmVyc2lvbiwgd2Ug
YWx3YXlzIGNhbGwgYG1pZ2h0X3NsZWVwKClgLg0KPj4gKyAgICBtaWdodF9zbGVlcCgpOw0KPj4g
Kw0KPj4gKyAgICBsb29wIHsNCj4+ICsgICAgICAgIGxldCB2YWwgPSBvcCgpPzsNCj4+ICsgICAg
ICAgIGlmIGNvbmQoJnZhbCkgew0KPj4gKyAgICAgICAgICAgIC8vIFVubGlrZSB0aGUgQyB2ZXJz
aW9uLCB3ZSBpbW1lZGlhdGVseSByZXR1cm4uDQo+PiArICAgICAgICAgICAgLy8gV2Uga25vdyB0
aGUgY29uZGl0aW9uIGlzIG1ldCBzbyB3ZSBkb24ndCBuZWVkIHRvIGNoZWNrIGFnYWluLg0KPj4g
KyAgICAgICAgICAgIHJldHVybiBPayh2YWwpOw0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICAgICAg
aWYgbGV0IFNvbWUodGltZW91dF9kZWx0YSkgPSB0aW1lb3V0X2RlbHRhIHsNCj4+ICsgICAgICAg
ICAgICBpZiBzdGFydC5lbGFwc2VkKCkgPiB0aW1lb3V0X2RlbHRhIHsNCj4+ICsgICAgICAgICAg
ICAgICAgLy8gVW5saWtlIHRoZSBDIHZlcnNpb24sIHdlIGltbWVkaWF0ZWx5IHJldHVybi4NCj4+
ICsgICAgICAgICAgICAgICAgLy8gV2UgaGF2ZSBqdXN0IGNhbGxlZCBgb3AoKWAgc28gd2UgZG9u
J3QgbmVlZCB0byBjYWxsIGl0IGFnYWluLg0KPj4gKyAgICAgICAgICAgICAgICByZXR1cm4gRXJy
KEVUSU1FRE9VVCk7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICAg
ICAgaWYgc2xlZXAgew0KPj4gKyAgICAgICAgICAgIGZzbGVlcChzbGVlcF9kZWx0YSk7DQo+PiAr
ICAgICAgICB9DQo+IA0KPiBJIHdvdWxkIGp1c3QgZG86DQo+IA0KPiBpZiAhc2xlZXBfZGVsdGEu
aXNfemVybygpIHsNCj4gICAgIGZzbGVlcChzbGVlcF9kZWx0YSk7DQo+IH0NCj4gDQo+IGluc3Rl
YWQgb2YgdGhlIGV4dHJhIHZhcmlhYmxlLg0KDQpJJ2xsIGluIHRoZSBuZXh0IHZlcnNpb24uDQo=

