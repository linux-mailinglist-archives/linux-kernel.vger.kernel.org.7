Return-Path: <linux-kernel+bounces-774743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14327B2B6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946C5188B1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BA286422;
	Tue, 19 Aug 2025 02:04:32 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D1287507
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569071; cv=none; b=OeP5uL4k2ohfXSu74918IJ2Ur5R+jBylo3YXGUhCv8BAZZscwsL5ImM92QGHShN0KR6AwlrQ8a5juJ10lZSGNGew3fO7EhS1IOfQLXlVnMGMo71/2cQ15bfdWza4Az/XV+rKa8zQACrDSoRHJs9PKIQrdxY7REjxJaQQhKkuhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569071; c=relaxed/simple;
	bh=psYKo2bkCGwC4/3rMkNyW/c5mpSWN+i72kDOR2EoNss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMKjDKWAMIOZdKSTiDVKPvlg8BV0jm1wC+84y3odRMckKuoyI6I+Zj4KiQA6t+RyJDSaQ2KS2l7wjLrUyoeZOXGgTl1rKZ/BNih0Rji/C0S+56zfLR9y6X6Zgarz4IxKWfmr+j8ZHVIoSM6nDVYhkQqbv9FI3k+HoEF+Sg5dDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
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
Subject: RE: [????] Re: [PATCH][v2] x86/bugs: Fix GDS mitigation select for
 non-ARCH_CAP_GDS_CTRL CPUs
Thread-Topic: [????] Re: [PATCH][v2] x86/bugs: Fix GDS mitigation select for
 non-ARCH_CAP_GDS_CTRL CPUs
Thread-Index: AQHcDkNkk9KK039UBkewSTI3rWn+FLRoKagAgAET+BA=
Date: Tue, 19 Aug 2025 02:03:07 +0000
Message-ID: <455a7ad388c84d95887a5cede25f2825@baidu.com>
References: <20250816001905.2270-1-lirongqing@baidu.com>
 <20250818173302.33x5qvvw3mjmnixn@desk>
In-Reply-To: <20250818173302.33x5qvvw3mjmnixn@desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.3.13
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF3YW4gR3VwdGEgPHBh
d2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogMjAyNcTqONTCMTnI1SAx
OjMzDQo+IFRvOiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IENjOiB0Z2x4
QGxpbnV0cm9uaXguZGU7IGJwQGFsaWVuOC5kZTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IGpw
b2ltYm9lQGtlcm5lbC5vcmc7IG1pbmdvQHJlZGhhdC5jb207IGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbTsNCj4geDg2QGtlcm5lbC5vcmc7IGhwYUB6eXRvci5jb207IGRhdmlkLmthcGxhbkBh
bWQuY29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFs/Pz8/
XSBSZTogW1BBVENIXVt2Ml0geDg2L2J1Z3M6IEZpeCBHRFMgbWl0aWdhdGlvbiBzZWxlY3QgZm9y
DQo+IG5vbi1BUkNIX0NBUF9HRFNfQ1RSTCBDUFVzDQo+IA0KPiBPbiBTYXQsIEF1ZyAxNiwgMjAy
NSBhdCAwODoxOTowNUFNICswODAwLCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+IEZyb206IExpIFJv
bmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPg0KPiA+IFRoZSBjdXJyZW50IEdEUyBt
aXRpZ2F0aW9uIGxvZ2ljIGluY29ycmVjdGx5IHJldHVybnMgZWFybHkgd2hlbg0KPiA+IEFSQ0hf
Q0FQX0dEU19DVFJMIGlzIG5vdCBwcmVzZW50LCB3aGljaCBsZWFkcyB0byB0d28gcHJvYmxlbXM6
DQo+IA0KPiAuLi4gbm90IHByZXNlbnQ/IG9yIHRoZSBhdHRhY2sgdmVjdG9yIG1pdGlnYXRpb24g
aXMgdHVybmVkIG9mZj8NCg0KDQpTaG91bGQgYmUgIldoZW4gdGhlIGF0dGFjayB2ZWN0b3IgbWl0
aWdhdGlvbiBpcyB0dXJuZWQgb2ZmIg0KDQpJIHdpbGwgc2VuZCB2MywgdGhhbmtzDQoNCi1MaQ0K
DQo+IA0KPiA+IDEuIENQVXMgd2l0aG91dCBBUkNIX0NBUF9HRFNfQ1RSTCBzdXBwb3J0IGFyZSBp
bmNvcnJlY3RseSBtYXJrZWQgd2l0aA0KPiA+ICAgIEdEU19NSVRJR0FUSU9OX09GRiB3aGVuIHRo
ZXkgc2hvdWxkIGJlIG1hcmtlZCBhcw0KPiA+ICAgIEdEU19NSVRJR0FUSU9OX1VDT0RFX05FRURF
RC4NCj4gPg0KPiA+IDIuIFRoZSBtaXRpZ2F0aW9uIHN0YXRlIGNoZWNrcyBhbmQgbG9ja2luZyB2
ZXJpZmljYXRpb24gdGhhdCBmb2xsb3cgYXJlDQo+ID4gICAgc2tpcHBlZCwgd2hpY2ggbWVhbnM6
DQo+ID4gICAgLSBmYWlsIHRvIGRldGVjdCBpZiB0aGUgbWl0aWdhdGlvbiB3YXMgbG9ja2VkDQo+
ID4gICAgLSBtaXNzIHRoZSB3YXJuaW5nIHdoZW4gdHJ5aW5nIHRvIGRpc2FibGUgYSBsb2NrZWQg
bWl0aWdhdGlvbg0KPiA+DQo+ID4gUmVtb3ZlIHRoZSBlYXJseSByZXR1cm4gdG8gZW5zdXJlIHBy
b3BlciBtaXRpZ2F0aW9uIHN0YXRlIGhhbmRsaW5nLg0KPiA+IFRoaXMNCj4gPiBhbGxvd3M6DQo+
ID4gLSBQcm9wZXIgbWl0aWdhdGlvbiBjbGFzc2lmaWNhdGlvbiBmb3Igbm9uLUFSQ0hfQ0FQX0dE
U19DVFJMIENQVXMNCj4gPiAtIENvbXBsZXRlIG1pdGlnYXRpb24gc3RhdGUgdmVyaWZpY2F0aW9u
DQo+ID4NCj4gPiBUaGUgY2hhbmdlIGZpeGVzIHRoZSBmb2xsb3dpbmcgcnVudGltZSBpc3N1ZXMg
b2JzZXJ2ZWQ6DQo+ID4NCj4gPiBbICAgIDIuODA5MTQ3XSB1bmNoZWNrZWQgTVNSIGFjY2VzcyBl
cnJvcjogV1JNU1IgdG8gMHgxMjMgKHRyaWVkIHRvDQo+IHdyaXRlIDB4MDAwMDAwMDAwMDAwMDAx
MCkgYXQgcklQOiAweGZmZmZmZmZmYjM0NTI3YjgNCj4gKHVwZGF0ZV9nZHNfbXNyKzB4MzgvMHhl
MCkNCj4gPiBbICAgIDIuODA5MTQ3XSBDYWxsIFRyYWNlOg0KPiA+IFsgICAgMi44MDkxNDddICA8
VEFTSz4NCj4gPiBbICAgIDIuODA5MTQ3XSAgaWRlbnRpZnlfc2Vjb25kYXJ5X2NwdSsweDcyLzB4
OTANCj4gPiBbICAgIDIuODA5MTQ3XSAgc3RhcnRfc2Vjb25kYXJ5KzB4N2EvMHgxNDANCj4gPiBb
ICAgIDIuODA5MTQ3XSAgY29tbW9uX3N0YXJ0dXBfNjQrMHgxM2UvMHgxNDENCj4gPiBbICAgIDIu
ODA5MTQ3XSAgPC9UQVNLPg0KPiA+IFsgICAgMi44MDkxNDddIC0tLS0tLS0tLS0tLVsgY3V0IGhl
cmUgXS0tLS0tLS0tLS0tLQ0KPiA+IFsgICAgMi44MDkxNDddIFdBUk5JTkc6IENQVTogMSBQSUQ6
IDAgYXQNCj4gYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmM6MTA1MyB1cGRhdGVfZ2RzX21zcisw
eDliLzB4ZTANCj4gPg0KPiA+IEZpeGVzOiA4YzcyNjFhYmNiN2FkICgieDg2L2J1Z3M6IEFkZCBh
dHRhY2sgdmVjdG9yIGNvbnRyb2xzIGZvciBHRFMiKQ0KPiA+IFN1Z2dlc3RlZC1ieTogUGF3YW4g
R3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IA0KPiBSZXZpZXdlZC1i
eTogUGF3YW4gR3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT4NCg==

