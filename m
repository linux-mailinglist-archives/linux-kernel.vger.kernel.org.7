Return-Path: <linux-kernel+bounces-770206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A117CB2786F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7478B634D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454FC292B38;
	Fri, 15 Aug 2025 05:29:21 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99456242D66
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235760; cv=none; b=E3vKm7Yu5gC+SA20DlfnuszVQeurdRx3uGlIAeURGPOsOLq2MpdRD96k96fvmwwzq5VZVakBkrL3HF9GnnQWsu+Uj/YafIMzitohXZCpc2QN/7vHaIh+HdAHcd74/YNRLahnD3v14nliexllVxmo4V3F938039tt55qg4kgIqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235760; c=relaxed/simple;
	bh=VURvw+k590gCXeGUBglVj+/8RkSid+pcYUblRadhAI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QHLgG4UpWqguMX2rQueVuwEt3BYNw9OeYheg9jM0dAAEMVsokpP+4tiCkWANSMHO6In/SDdXOmvFI8BOnMho/CY2ys/jbDKzXdiPCtQTNvudHU7NvVBupNmRQGp1XgZVKWj8ivBMrbpWBe/O/TPPN7I/JG3nZ5VWrZb1l4PRhlM=
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
Subject: RE: [????] Re: [PATCH] x86/bugs: Fix GDS mitigation check for CPUs
 without ARCH_CAP_GDS_CTRL
Thread-Topic: [????] Re: [PATCH] x86/bugs: Fix GDS mitigation check for CPUs
 without ARCH_CAP_GDS_CTRL
Thread-Index: AQHcDaVol6m8kQbUoUCDZWrxRnEWbA==
Date: Fri, 15 Aug 2025 05:28:18 +0000
Message-ID: <8caaa7fabf2446ffbac922dafaed3dc9@baidu.com>
References: <20250815035334.4230-1-lirongqing@baidu.com>
 <20250815050811.gm7nxcd7wn47lshy@desk>
In-Reply-To: <20250815050811.gm7nxcd7wn47lshy@desk>
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
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF3YW4gR3VwdGEgPHBh
d2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogMjAyNcTqONTCMTXI1SAx
MzowOQ0KPiBUbzogTGksUm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiBDYzogdGds
eEBsaW51dHJvbml4LmRlOyBicEBhbGllbjguZGU7IHBldGVyekBpbmZyYWRlYWQub3JnOw0KPiBq
cG9pbWJvZUBrZXJuZWwub3JnOyBtaW5nb0ByZWRoYXQuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5p
bnRlbC5jb207DQo+IHg4NkBrZXJuZWwub3JnOyBocGFAenl0b3IuY29tOyBkYXZpZC5rYXBsYW5A
YW1kLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbPz8/
P10gUmU6IFtQQVRDSF0geDg2L2J1Z3M6IEZpeCBHRFMgbWl0aWdhdGlvbiBjaGVjayBmb3IgQ1BV
cyB3aXRob3V0DQo+IEFSQ0hfQ0FQX0dEU19DVFJMDQo+IA0KPiBPbiBGcmksIEF1ZyAxNSwgMjAy
NSBhdCAxMTo1MzozNEFNICswODAwLCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+IEZyb206IExpIFJv
bmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPg0KPiA+IFRoZSBjb21taXQgOGM3MjYx
YWJjYjdhZCgieDg2L2J1Z3M6IEFkZCBhdHRhY2sgdmVjdG9yIGNvbnRyb2xzIGZvcg0KPiA+IEdE
UyIpIGNhdXNlZCBjYWxsIHRyYWNlcyBkdXJpbmcgc2Vjb25kYXJ5IENQVSBpbml0aWFsaXphdGlv
biBiZWNhdXNlDQo+ID4gaXQgZGlkbid0IHByb3Blcmx5IGhhbmRsZSBDUFVzIHRoYXQgbGFjayB0
aGUgQVJDSF9DQVBfR0RTX0NUUkwgY2FwYWJpbGl0eS4NCj4gPg0KPiA+IEZvciBDUFVzIHdpdGhv
dXQgQVJDSF9DQVBfR0RTX0NUUkwgc3VwcG9ydCwgd2Ugc2hvdWxkIHNldCB0aGUNCj4gPiBtaXRp
Z2F0aW9uIHRvIEdEU19NSVRJR0FUSU9OX1VDT0RFX05FRURFRCByYXRoZXIgdGhhbg0KPiA+IEdE
U19NSVRJR0FUSU9OX09GRiwgYXMgdGhlc2UgQ1BVcyBtYXkgc3RpbGwgYmUgdnVsbmVyYWJsZSBi
dXQgY2Fubm90DQo+IGRpc2FibGUgbWl0aWdhdGlvbi4NCj4gPg0KPiA+IEFkZCB0aGUgbWlzc2lu
ZyBjaGVjayBmb3IgQVJDSF9DQVBfR0RTX0NUUkwgdG8gcHJvcGVybHkgZGV0ZXJtaW5lIHRoZQ0K
PiA+IG1pdGlnYXRpb24gc3RhdGUgZm9yIGFmZmVjdGVkIENQVXMuDQo+ID4NCj4gPiBbICAgIDIu
ODA5MTQ3XSB1bmNoZWNrZWQgTVNSIGFjY2VzcyBlcnJvcjogUkRNU1IgZnJvbSAweDEyMyBhdCBy
SVA6DQo+IDB4ZmZmZmZmZmZiMzQ1MjgwNyAodXBkYXRlX2dkc19tc3IrMHg4Ny8weGUwKQ0KPiA+
ICh1cGRhdGVfZ2RzX21zcisweDg3LzB4ZTApDQo+ID4gWyAgICAyLjgwOTE0N10gQ2FsbCBUcmFj
ZToNCj4gPiBbICAgIDIuODA5MTQ3XSAgPFRBU0s+DQo+ID4gWyAgICAyLjgwOTE0N10gIGlkZW50
aWZ5X3NlY29uZGFyeV9jcHUrMHg3Mi8weDkwDQo+ID4gWyAgICAyLjgwOTE0N10gIHN0YXJ0X3Nl
Y29uZGFyeSsweDdhLzB4MTQwDQo+ID4gWyAgICAyLjgwOTE0N10gIGNvbW1vbl9zdGFydHVwXzY0
KzB4MTNlLzB4MTQxDQo+ID4gWyAgICAyLjgwOTE0N10gIDwvVEFTSz4NCj4gPiBbICAgIDIuODA5
MTQ3XSB1bmNoZWNrZWQgTVNSIGFjY2VzcyBlcnJvcjogV1JNU1IgdG8gMHgxMjMgKHRyaWVkIHRv
IHdyaXRlDQo+IDB4MDAwMDAwMDAwMDAwMDAxMCkgYXQgcklQOiAweGZmZmZmZmZmYjM0NTI3YjgN
Cj4gPiAodXBkYXRlX2dkc19tc3IrMHgzOC8weGUwKQ0KPiA+IFsgICAgMi44MDkxNDddIENhbGwg
VHJhY2U6DQo+ID4gWyAgICAyLjgwOTE0N10gIDxUQVNLPg0KPiA+IFsgICAgMi44MDkxNDddICBp
ZGVudGlmeV9zZWNvbmRhcnlfY3B1KzB4NzIvMHg5MA0KPiA+IFsgICAgMi44MDkxNDddICBzdGFy
dF9zZWNvbmRhcnkrMHg3YS8weDE0MA0KPiA+IFsgICAgMi44MDkxNDddICBjb21tb25fc3RhcnR1
cF82NCsweDEzZS8weDE0MQ0KPiA+IFsgICAgMi44MDkxNDddICA8L1RBU0s+DQo+ID4gWyAgICAy
LjgwOTE0N10gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ID4gWyAgICAy
LjgwOTE0N10gV0FSTklORzogQ1BVOiAxIFBJRDogMCBhdCBhcmNoL3g4Ni9rZXJuZWwvY3B1L2J1
Z3MuYzoxMDUzDQo+IHVwZGF0ZV9nZHNfbXNyKzB4OWIvMHhlMA0KPiA+DQo+ID4gRml4ZXM6IDhj
NzI2MWFiY2I3YWQgKCJ4ODYvYnVnczogQWRkIGF0dGFjayB2ZWN0b3IgY29udHJvbHMgZm9yIEdE
UyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyB8IDIgKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4g
PiBpbmRleCBiNzRiZjkzLi4zYWY5MTFjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvYnVncy5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gPiBA
QCAtMTA3MSw2ICsxMDcxLDggQEAgc3RhdGljIHZvaWQgX19pbml0IGdkc19zZWxlY3RfbWl0aWdh
dGlvbih2b2lkKQ0KPiA+ICAJCQlnZHNfbWl0aWdhdGlvbiA9IEdEU19NSVRJR0FUSU9OX0ZVTEw7
DQo+ID4gIAkJZWxzZSB7DQo+ID4gIAkJCWdkc19taXRpZ2F0aW9uID0gR0RTX01JVElHQVRJT05f
T0ZGOw0KPiA+ICsJCQlpZiAoISh4ODZfYXJjaF9jYXBfbXNyICYgQVJDSF9DQVBfR0RTX0NUUkwp
KQ0KPiANCj4gVGhpcyBjaGVjayBpcyBhbHJlYWR5IHByZXNlbnQgZmV3IGxpbmVzIGJlbG93Lg0K
PiANCj4gPiArCQkJCWdkc19taXRpZ2F0aW9uID0gR0RTX01JVElHQVRJT05fVUNPREVfTkVFREVE
Ow0KPiA+ICAJCQlyZXR1cm47DQo+IA0KPiBUbyBhdm9pZCBkdXBsaWNhdGluZywgYSBiZXR0ZXIg
Zml4IGNvdWxkIGJlIHRvIG5vdCByZXR1cm4gaGVyZSwgYW5kIGxldCB0aGUgbmV4dA0KPiBibG9j
ayBEVFJUOg0KDQpCdXQgaWYgY3B1IGhhcyBBUkNIX0NBUF9HRFNfQ1RSTCwgdGhlIG5leHQgYmxv
Y2sgd2lsbCBiZSBza2lwcGVkLCBhbmQgdGhlIGNvZGVzIGFmdGVyIGNoZWNraW5nIEFSQ0hfQ0FQ
X0dEU19DVFJMIGJsb2NrIHdpbGwgYmUgcnVuLCB0aGlzIGlzIG5vdCBleHBlY3RlZA0KDQpTbyBJ
IGFkZCBhIGR1cGxpY2F0aW5nIGNoZWNrDQoNCkJyDQoNCi1MaQ0KDQoNCj4gDQo+ICAgICAgICAg
IC8qIE5vIG1pY3JvY29kZSAqLw0KPiAgICAgICAgICBpZiAoISh4ODZfYXJjaF9jYXBfbXNyICYg
QVJDSF9DQVBfR0RTX0NUUkwpKSB7DQo+ICAgICAgICAgICAgICAgICAgaWYgKGdkc19taXRpZ2F0
aW9uICE9IEdEU19NSVRJR0FUSU9OX0ZPUkNFKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
Z2RzX21pdGlnYXRpb24gPQ0KPiBHRFNfTUlUSUdBVElPTl9VQ09ERV9ORUVERUQ7DQo+ICAgICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgICB9DQo=

