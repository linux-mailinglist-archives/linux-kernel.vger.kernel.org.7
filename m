Return-Path: <linux-kernel+bounces-771592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB96B28926
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AB6A21D59
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68006C8CE;
	Sat, 16 Aug 2025 00:16:38 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE915A8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303398; cv=none; b=eLOKSCe8JXwOuBWsLkslrlHuMYjsOqiI/MFk2J8HySpeWbsrM6zFeifbEkkM+KkkyHUwwzzdKcxg8sweyTkSOBaEn2jem/B0fZIzVKQsqEDWXoUxoDBhRH1uBFICIh9lLkpYkT+RTCyaBRB1HtrULnvwDEy/g69S6GXp5xXq6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303398; c=relaxed/simple;
	bh=y8isc9z85O0HGhdnNW3E2I+l3vWgPGE5+cOMZia7esY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q2HS+B2uIIQvqKFR0e/uFWYzR1G01qSH1oLSlTQPkJWpk0E6wtJed2jnMmE9dMpvd5Vfgdh/t9XHqFMR8w2FH6FC6pDsYllAZhObhgHpOKLPv5Wl6mJcQ2MTa1JFm0CAJBGrWhG88o6bRyp6pAnNeh6BosZ7BPr7AvdMa82lYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "david.kaplan@amd.com"
	<david.kaplan@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Re: [????] Re: [PATCH] x86/bugs: Fix GDS mitigation check for
 CPUs without ARCH_CAP_GDS_CTRL
Thread-Topic: Re: [????] Re: [PATCH] x86/bugs: Fix GDS mitigation check for
 CPUs without ARCH_CAP_GDS_CTRL
Thread-Index: AdwOQrts3RmaX2f/Rn6fQ4EXML6jwA==
Date: Sat, 16 Aug 2025 00:15:20 +0000
Message-ID: <2a53cf1c48b44ea4b12debeed7521d50@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.48
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IA0KPiBIb3cgaXMgdGhhdCBhIHByb2JsZW0/IFRoYXQgaXMgaG93IGl0IHdhcyBvcmlnaW5h
bGx5IGltcGxlbWVudGVkLg0KPiANCj4gSW5mYWN0LCB0aGUgZm9sbG93aW5nIGNoZWNrcyBhcmUg
cmVxdWlyZWQgZm9yIHRoZSBjb3JyZWN0IGJlaGF2aW9yOg0KDQoNCllvdSBhcmUgcmlnaHQsIEkg
d2lsbCByZXNlbmQgdGhpcyBwYXRjaA0KDQpUaGFua3MNCg0KLUxpDQoNCj4gDQo+ICAgICAgICAg
IGlmIChtY3VfY3RybCAmIEdEU19NSVRHX0xPQ0tFRCkgew0KPiAgICAgICAgICAgICAgICAgIGlm
IChnZHNfbWl0aWdhdGlvbiA9PSBHRFNfTUlUSUdBVElPTl9PRkYpDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBwcl93YXJuKCJNaXRpZ2F0aW9uIGxvY2tlZC4gRGlzYWJsZSBmYWlsZWQuXG4i
KTsNCj4gCS4uLg0KPiAgICAgICAgICAgICAgICAgIGdkc19taXRpZ2F0aW9uID0gR0RTX01JVElH
QVRJT05fRlVMTF9MT0NLRUQ7DQo+ICAgICAgICAgIH0NCj4gDQo+IElmIHRoZSBHRFMgbWljcm9j
b2RlIG1pdGlnYXRpb24gaXMgbG9ja2VkIGJlZm9yZSB0aGUga2VybmVsIGJvb3QsIE1TUiB3cml0
ZSBmb3INCj4gT0ZGIHdpbGwgbm90IHRha2UgZWZmZWN0IGFueXdheXMuIEFuZCB5b3UgcmVwb3J0
IE9GRiB3aGVuIHRoZSBtaXRpZ2F0aW9uIGlzDQo+IGxvY2tlZCB0byBPTi4gV2hpbGUgYWxzbyB0
cmlnZ2VyaW5nIGJlbG93IFdBUk5fT05fT05DRSgpOg0KPiANCj4gdXBkYXRlX2dkc19tc3IoKQ0K
PiB7DQo+IC4uLg0KPiAgICAgICAgICAvKg0KPiAgICAgICAgICAgKiBDaGVjayB0byBtYWtlIHN1
cmUgdGhhdCB0aGUgV1JNU1IgdmFsdWUgd2FzIG5vdCBpZ25vcmVkLg0KPiBXcml0ZXMgdG8NCj4g
ICAgICAgICAgICogR0RTX01JVEdfRElTIHdpbGwgYmUgaWdub3JlZCBpZiB0aGlzIHByb2Nlc3Nv
ciBpcyBsb2NrZWQgYnV0IHRoZQ0KPiBib290DQo+ICAgICAgICAgICAqIHByb2Nlc3NvciB3YXMg
bm90Lg0KPiAgICAgICAgICAgKi8NCj4gICAgICAgICAgcmRtc3JxKE1TUl9JQTMyX01DVV9PUFRf
Q1RSTCwgbWN1X2N0cmxfYWZ0ZXIpOw0KPiAgICAgICAgICBXQVJOX09OX09OQ0UobWN1X2N0cmwg
IT0gbWN1X2N0cmxfYWZ0ZXIpOw0K

