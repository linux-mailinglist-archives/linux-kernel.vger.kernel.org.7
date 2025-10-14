Return-Path: <linux-kernel+bounces-852277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0EFBD8919
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AAC33522C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558402EB5B0;
	Tue, 14 Oct 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MDf0Qu7U"
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DD2EBDD0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435466; cv=none; b=XoILQ9enNFnMYCsVP4JcFshipz6D4W25ppyYrpFTqbPjosO5PY6whK+KBwUmsKGuQ4AMx71aBdHnPu6Ur7uk2UUomLxXzfS88t4CG576rI83JUS8QtzKSrz6UDIFsRj0VcqdpuxTkR2y+GkYNrdzr5gvs+JL4F/VLepWxb08WeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435466; c=relaxed/simple;
	bh=7DHLx6gsuw+MXIuw6hDpegzNkV1LsoIxv5qrvoARnmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kL6S8ofIIiUP8I75l9nc5Qjr0VxSXmgOhHW2mUVNamnvjtkdHtx9wO6Uij72w350PkQrlE0U9J3lnSdgKOT5TXZjEvXuzc2lVUMqlRMXMr9OrVvZ2xSr48PGXiCpDcLxHIw9kuaqjfGi3ZKUTIq7Jyp3xqyJqt0Jym/fHHcjOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MDf0Qu7U; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7DHLx6gsuw+MXIuw6hDpegzNkV1LsoIxv5qrvoARnmU=;
	b=MDf0Qu7UfP2f//YbJLYeLhU9sclJ2y8TGGm5NyR0RQUISYZkoFU57VPrFik1/pOP1UZZpKnQm
	k3TLHogJFyWf89ynVK2X2V6n7qaaJXrmbWzmp9ILZM+HLcET8tK76p4ZjPhrmYnLB/L2SiILXyd
	h5EntZF618TjDuBvpC51l8M=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cm8br13LQz1P6hy;
	Tue, 14 Oct 2025 17:50:47 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cm8Zm0sscz6K6mZ;
	Tue, 14 Oct 2025 17:49:52 +0800 (CST)
Received: from dubpeml100006.china.huawei.com (unknown [7.214.145.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 31B7E1402E9;
	Tue, 14 Oct 2025 17:50:50 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100006.china.huawei.com (7.214.145.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 10:50:49 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 10:50:49 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>, Salil Mehta
	<salil.mehta@opnsrc.net>
CC: Marc Zyngier <maz@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, "mst@redhat.com"
	<mst@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
	<philmd@linaro.org>, "ardb@kernel.org" <ardb@kernel.org>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>,
	"gustavo.romero@linaro.org" <gustavo.romero@linaro.org>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
	<miguel.luis@oracle.com>, "darren@os.amperecomputing.com"
	<darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
	<ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
	<vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
	<gankulkarni@os.amperecomputing.com>, "wangyanan (Y)"
	<wangyanan55@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
Thread-Topic: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
Thread-Index: AQHcOJEPLIyaftchIkq5VYDgYw17SLS5xPAAgAXz6gCAACTfAIAAYtoAgACrjQCAAGycAIAAEwzg
Date: Tue, 14 Oct 2025 09:50:49 +0000
Message-ID: <6ef5f8d7b52b4eee8dbf9186046e920c@huawei.com>
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
 <86v7koxk1z.wl-maz@kernel.org>
 <CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
 <867bwzxe9r.wl-maz@kernel.org>
 <CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
 <CAJ7pxebGOj5Z1iW6VPjzj73eY1hZFjS5uXMkee8XCm09DtFcKQ@mail.gmail.com>
 <CAFEAcA8VL4wE2w9PegPD_AVSKCZzzzx-jFru7dDOq4Tz5xs76A@mail.gmail.com>
In-Reply-To: <CAFEAcA8VL4wE2w9PegPD_AVSKCZzzzx-jFru7dDOq4Tz5xs76A@mail.gmail.com>
Accept-Language: en-US
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

SGkgUGV0ZXIsDQoNCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE0LCAyMDI1IDEwOjMxIEFNDQo+IA0KPiBP
biBUdWUsIDE0IE9jdCAyMDI1IGF0IDA0OjAyLCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAb3Bu
c3JjLm5ldD4gd3JvdGU6DQo+ID4gT24gTW9uLCBPY3QgMTMsIDIwMjUgYXQgNDo0OOKAr1BNIFBl
dGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gPiBU
aGF0IHNhaWQsIFFFTVUncyBjdXJyZW50IGNvZGUgZm9yIHRoaXMgY291bGQgYmUgcmVmYWN0b3Jl
ZCB0byBhdm9pZA0KPiA+ID4gdGhlIHJlc2V0LXRpbWUgcmVhZCBvZiBJQ0NfQ1RMUl9FTDEgZnJv
bSB0aGUga2VybmVsLg0KPiA+ID4gV2UgZG8gdGhpcyBzbyB3ZSBjYW4gc2V0IHRoZSB1c2Vyc3Bh
Y2Ugc3RydWN0IGZpZWxkIGZvciB0aGlzDQo+ID4gPiByZWdpc3RlciB0byB0aGUgcmlnaHQgdmFs
dWUuIEJ1dCB3ZSBjb3VsZCBhc2sgdGhlIGtlcm5lbCBmb3IgdGhhdA0KPiA+ID4gdmFsdWUgb25j
ZSBvbiBWTSBzdGFydHVwIHNpbmNlIGl0J3Mgbm90IGdvaW5nIHRvIGNoYW5nZSBtaWQtcnVuLg0K
PiA+ID4NCj4gPiA+IFRoYXQgd291bGQgYnJpbmcgSUNDX0NUTFJfRUwxIGludG8gbGluZSB3aXRo
IHRoZSBvdGhlciBjcHVpZg0KPiA+ID4gcmVnaXN0ZXJzLCB3aGVyZSBRRU1VIGFzc3VtZXMgaXQg
a25vd3Mgd2hhdCB0aGUga2VybmVsJ3MgcmVzZXQgdmFsdWUNCj4gPiA+IG9mIHRoZW0gaXMgKG1v
c3RseSAiMCIpIGFuZCBkb2Vzbid0IGJvdGhlciB0byBhc2suDQo+ID4gPiBUaGlzIGlzIGRpZmZl
cmVudCBmcm9tIGhvdyB3ZSBoYW5kbGUgT05FX1JFRyBzeXNyZWdzLCB3aGVyZSBJJ20NCj4gPiA+
IHByZXR0eSBzdXJlIHdlIGRvIGFzayB0aGUga2VybmVsIHRoZSB2YWx1ZSBvZiBhbGwgb2YgdGhl
bSBvbiBhIHZjcHUNCj4gPiA+IHJlc2V0LiAoQW5kIHRoZW4gd3JpdGUgdGhlIHZhbHVlcyBiYWNr
IGFnYWluLCB3aGljaCBpcyBhIGJpdCBzaWxseQ0KPiA+ID4gYnV0IG5vYm9keSdzIGV2ZXIgc2Fp
ZCBpdCB3YXMgYSBwZXJmb3JtYW5jZSBwcm9ibGVtIGZvciB0aGVtIDotKSkNCj4gPg0KPiA+DQo+
ID4gVGhpcyBpcyBlZmZlY3RpdmVseSB3aGF0IHRoZSBtZW50aW9uZWQgcGF0Y2ggaW4gdGhlIGNv
bW1pdC1sb2cgaXMgZG9pbmcuDQo+ID4gUGFzdGluZyBoZXJlIGFnYWluOg0KPiA+DQo+ID4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MTAwMTAxMDEyNy4zMDkyNjMxLTIy
LXNhbGlsLm1laA0KPiA+IHRhQG9wbnNyYy5uZXQvDQo+IA0KPiBObywgdGhhdCBpcyBub3Qgd2hh
dCBJIGhhdmUgaW4gbWluZC4gV2hhdCBJIG1lYW4gaXMgdGhhdCB3ZSBjYW4ganVzdCByZWFkIHRo
ZQ0KPiBJQ0NfQ1RMUl9FTDEgdmFsdWUgb25jZSBvbiBzdGFydHVwIChpbiBvdXIgcmVhbGl6ZSBt
ZXRob2QsIEkgdGhpbmspIGFuZCB0aGVuDQo+IHVzZSB0aGF0IHZhbHVlIGluIHJlc2V0LiBUaGF0
IHNob3VsZCBub3QgcmVxdWlyZSBhbnkgb2YgdGhhdCBtYWNoaW5lcnkgdG8NCj4gcGF1c2UgdGhl
IFZNIGFuZCBrZWVwIHJldHJ5aW5nLg0KDQoNCkluZGVlZCBhbmQgdGhhdOKAmXMgd2hhdCBJIGRp
ZCBpbml0aWFsbHkgYW5kIGhhZCBmZXRjaGVkIHRoZSB2YWx1ZSBvbmNlIGluIEdJQ3YzDQpyZWFs
aXplIGJ1dCBpdCBodW5nIHRoZSBWTSBpbml0aWFsaXphdGlvbiBsZWcgZHVyaW5nIGFjY2Vzcy4N
Cg0KQlRXLCBjYW4gd2Ugc2FmZWx5IGFzc3VtZSB0aGF0IHZhbHVlIG9mIHRoaXMgcmVnaXN0ZXIg
d2lsbCBiZSBzYW1lIGFjcm9zcyBhbGwNCnZDUFVzIChpLmUuIGlzIGp1c3QgZm9yIFNNUCBjYXNl
IGFuZCBpZ25vcmUgaGV0ZXJvZ2Vub3VzKT8gDQoNCg0KQmVzdCByZWdhcmRzDQpTYWxpbA0KDQoN
Cj4gDQo+IC0tIFBNTQ0K

