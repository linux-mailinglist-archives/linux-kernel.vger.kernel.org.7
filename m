Return-Path: <linux-kernel+bounces-807706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB977B4A81E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE04E270E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F0129E0EE;
	Tue,  9 Sep 2025 09:30:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B1287255;
	Tue,  9 Sep 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410214; cv=none; b=PwKhminDPrdZxZiInDMeK5IyuEaT98D5tZoT0hpdQpLJ+2dTH3cO6WNh4RjXebe/amjBA8IR03Pt4VjUfwglMCvWbVln7Vh6P4/Qv6M0dWmQxmoPnkxDouIoyJqxFmqDGW60k6UzP1xnUdKKqqt6QImVEJ9LYJgrSONLAOvNMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410214; c=relaxed/simple;
	bh=ZS+DAE9/Z9nXzpidJmud1I5Zwcs3iyPVMBV5PQxLTCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6c3SFXuLhzmVDFtwpLzX/VZ21sR0nuwMNgejy+Nzmg0unf3nQasMT+/g8HbQXSMc2aw/cZRPU8ZuQItI/vq25CI5WQjp/QrFOCVVYU1jyRUQcEHfYTCDCXBhk/sck4SZf+3lNmJGMTlJMkzNCv5w4dZUuUBk4JdxTc7ILmtueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cLdjS4SJ1z13NYc;
	Tue,  9 Sep 2025 17:26:04 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id B0E901402C4;
	Tue,  9 Sep 2025 17:30:03 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (7.202.181.122) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 17:30:03 +0800
Received: from kwepemh200013.china.huawei.com ([7.202.181.122]) by
 kwepemh200013.china.huawei.com ([7.202.181.122]) with mapi id 15.02.1544.011;
 Tue, 9 Sep 2025 17:30:03 +0800
From: "zhangxiaomeng (A)" <zhangxiaomeng13@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "mhiramat@kernel.org" <mhiramat@kernel.org>, "dhowells@redhat.com"
	<dhowells@redhat.com>, "wsa@kernel.org" <wsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBpMmM6IEZpeCBPT0IgYWNjZXNzIGluIHRyYWNlX2V2?=
 =?gb2312?B?ZW50X3Jhd19ldmVudF9zbWJ1c193cml0ZQ==?=
Thread-Topic: [PATCH] i2c: Fix OOB access in trace_event_raw_event_smbus_write
Thread-Index: AQHcHELNHRvaa1K3UkS4EFSwZAlRm7SKnwcQ
Date: Tue, 9 Sep 2025 09:30:03 +0000
Message-ID: <39437e40a6f14c5189e86cffb0b6abb5@huawei.com>
References: <20250821012312.3591166-1-zhangxiaomeng13@huawei.com>
 <20250902154957.7987e5ff@batman.local.home>
In-Reply-To: <20250902154957.7987e5ff@batman.local.home>
Accept-Language: en-US
Content-Language: zh-CN
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

SSBwcmV2aW91c2x5IGF0dGVtcHRlZCB0byBhcHBseSBhIGZpeCB3aXRoaW4gdGhlIGkyY2Rldl9p
b2N0bF9zbWJ1cyBmdW5jdGlvbi4gV2hpbGUgdGhpcyBhcHByb2FjaCB3YXMgc3VjY2Vzc2Z1bCBp
biBwcmV2ZW50aW5nIHRoZSB3YXJuaW5nLCBJIGZvdW5kIHRoYXQgdGhlIHJlcXVpcmVkIGNoYW5n
ZXMgd2VyZSBxdWl0ZSBleHRlbnNpdmUuIFRoZSBXQVJOIGlzIHRyaWdnZXJlZCBieSB0aGUgdHJh
Y2Vfc21idXNfd3JpdGUgdHJhY2Vwb2ludCwgd2hpY2ggcGVyZm9ybXMgYSBtZW1jcHkoX19lbnRy
eS0+YnVmLCBkYXRhLT5ibG9jaywgbGVuKSBmb3Igd3JpdGUgb3BlcmF0aW9ucyBvbiB0aHJlZSBz
cGVjaWZpYyBibG9jayBwcm90b2NvbHM6IEkyQ19TTUJVU19CTE9DS19EQVRBLCBJMkNfU01CVVNf
STJDX0JMT0NLX0RBVEEsIGFuZCBJMkNfU01CVVNfQkxPQ0tfUFJPQ19DQUxMLiBUbyBmaXggdGhp
cyBpbiBpMmNkZXZfaW9jdGxfc21idXMsIGl0IHdvdWxkIGJlIG5lY2Vzc2FyeSB0byBhZGQgY2hl
Y2tzIGZvciBhbGwgdGhyZWUgb2YgdGhlc2UgY2FzZXMsIHdoaWNoIG1ha2VzIHRoZSBzb2x1dGlv
biByYXRoZXIgY29tcGxleC4NCg0KLS14aWFvbWVuZw0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+
yMs6IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPiANCreiy83KsbzkOiAyMDI1
xOo51MIzyNUgMzo1MA0KytW8/sjLOiB6aGFuZ3hpYW9tZW5nIChBKSA8emhhbmd4aWFvbWVuZzEz
QGh1YXdlaS5jb20+DQqzrcvNOiBtaGlyYW1hdEBrZXJuZWwub3JnOyBkaG93ZWxsc0ByZWRoYXQu
Y29tOyB3c2FAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
dHJhY2Uta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6IFtQQVRDSF0gaTJjOiBGaXgg
T09CIGFjY2VzcyBpbiB0cmFjZV9ldmVudF9yYXdfZXZlbnRfc21idXNfd3JpdGUNCg0KT24gVGh1
LCAyMSBBdWcgMjAyNSAwMToyMzoxMiArMDAwMA0KWGlhb21lbmcgWmhhbmcgPHpoYW5neGlhb21l
bmcxM0BodWF3ZWkuY29tPiB3cm90ZToNCg0KPiBUaGUgc21idXNfd3JpdGUgdHJhY2Vwb2ludCBj
b3BpZXMgX19lbnRyeS0+bGVuIGJ5dGVzIGludG8gYSBmaXhlZCANCj4gSTJDX1NNQlVTX0JMT0NL
X01BWCArIDIgYnVmZmVyLiBPdmVyc2l6ZWQgbGVuZ3RocyAoZS5nLiwgNDYpIGV4Y2VlZCANCj4g
dGhlIGRlc3RpbmF0aW9uIGFuZCBvdmVyLXJlYWQgdGhlIHNvdXJjZSBidWZmZXIsIHRyaWdnZXJp
bmcgT09CIA0KPiB3YXJuaW5nOg0KPiANCj4gbWVtY3B5OiBkZXRlY3RlZCBmaWVsZC1zcGFubmlu
ZyB3cml0ZSAoc2l6ZSA0OCkgb2Ygc2luZ2xlIGZpZWxkIA0KPiAiZW50cnktPmJ1ZiIgYXQgaW5j
bHVkZS90cmFjZS9ldmVudHMvc21idXMuaDo2MCAoc2l6ZSAzNCkNCj4gDQo+IENsYW1wIHRoZSBj
b3B5IHNpemUgdG8gSTJDX1NNQlVTX0JMT0NLX01BWCArIDIgYmVmb3JlIG1lbWNweSgpLg0KPiBU
aGlzIG9ubHkgYWZmZWN0cyB0cmFjaW5nIGFuZCBkb2VzIG5vdCBjaGFuZ2UgSTJDIHRyYW5zZmVy
IGJlaGF2aW9yLg0KPiANCj4gRml4ZXM6IDhhMzI1OTk3ZDk1ZCAoImkyYzogQWRkIG1lc3NhZ2Ug
dHJhbnNmZXIgdHJhY2Vwb2ludHMgZm9yIFNNQlVTIA0KPiBbdmVyICMyXSIpDQo+IFNpZ25lZC1v
ZmYtYnk6IFhpYW9tZW5nIFpoYW5nIDx6aGFuZ3hpYW9tZW5nMTNAaHVhd2VpLmNvbT4NCj4gLS0t
DQo+ICBpbmNsdWRlL3RyYWNlL2V2ZW50cy9zbWJ1cy5oIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZl
bnRzL3NtYnVzLmggDQo+IGIvaW5jbHVkZS90cmFjZS9ldmVudHMvc21idXMuaCBpbmRleCA3MWE4
N2VkZmM0NmQuLmUzMDZkOGI5MjhjMyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS90cmFjZS9ldmVu
dHMvc21idXMuaA0KPiArKysgYi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9zbWJ1cy5oDQo+IEBAIC01
Nyw2ICs1Nyw4IEBAIFRSQUNFX0VWRU5UX0NPTkRJVElPTihzbWJ1c193cml0ZSwNCj4gIAkJY2Fz
ZSBJMkNfU01CVVNfSTJDX0JMT0NLX0RBVEE6DQo+ICAJCQlfX2VudHJ5LT5sZW4gPSBkYXRhLT5i
bG9ja1swXSArIDE7DQo+ICAJCWNvcHk6DQo+ICsJCQlpZiAoX19lbnRyeS0+bGVuID4gSTJDX1NN
QlVTX0JMT0NLX01BWCArIDIpDQo+ICsJCQkJX19lbnRyeS0+bGVuID0gSTJDX1NNQlVTX0JMT0NL
X01BWCArIDI7DQo+ICAJCQltZW1jcHkoX19lbnRyeS0+YnVmLCBkYXRhLT5ibG9jaywgX19lbnRy
eS0+bGVuKTsNCj4gIAkJCWJyZWFrOw0KPiAgCQljYXNlIEkyQ19TTUJVU19RVUlDSzoNCg0KVGhl
IGNvZGUgaGFzOg0KDQogICAgICAgICAgICAgICAgc3dpdGNoIChwcm90b2NvbCkgew0KICAgICAg
ICAgICAgICAgIGNhc2UgSTJDX1NNQlVTX0JZVEVfREFUQToNCiAgICAgICAgICAgICAgICAgICAg
ICAgIF9fZW50cnktPmxlbiA9IDE7DQogICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGNvcHk7
DQogICAgICAgICAgICAgICAgY2FzZSBJMkNfU01CVVNfV09SRF9EQVRBOg0KICAgICAgICAgICAg
ICAgIGNhc2UgSTJDX1NNQlVTX1BST0NfQ0FMTDoNCiAgICAgICAgICAgICAgICAgICAgICAgIF9f
ZW50cnktPmxlbiA9IDI7DQogICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGNvcHk7DQogICAg
ICAgICAgICAgICAgY2FzZSBJMkNfU01CVVNfQkxPQ0tfREFUQToNCiAgICAgICAgICAgICAgICBj
YXNlIEkyQ19TTUJVU19CTE9DS19QUk9DX0NBTEw6DQogICAgICAgICAgICAgICAgY2FzZSBJMkNf
U01CVVNfSTJDX0JMT0NLX0RBVEE6DQogICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5s
ZW4gPSBkYXRhLT5ibG9ja1swXSArIDE7DQogICAgICAgICAgICAgICAgY29weTogICANCiAgICAg
ICAgICAgICAgICAgICAgICAgIG1lbWNweShfX2VudHJ5LT5idWYsIGRhdGEtPmJsb2NrLCBfX2Vu
dHJ5LT5sZW4pOw0KICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICAgICAg
ICAgY2FzZSBJMkNfU01CVVNfUVVJQ0s6DQogICAgICAgICAgICAgICAgY2FzZSBJMkNfU01CVVNf
QllURToNCiAgICAgICAgICAgICAgICBjYXNlIEkyQ19TTUJVU19JMkNfQkxPQ0tfQlJPS0VOOg0K
ICAgICAgICAgICAgICAgIGRlZmF1bHQ6DQogICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5
LT5sZW4gPSAwOw0KICAgICAgICAgICAgICAgIH0NCg0KSSBvbmx5IHNlZSB0d28gY2FsbHMgdG8g
dGhlIGNvcHkgd2hlcmUgb25lIGlzIGxlbiA9IDEgYW5kIHRoZSBvdGhlciBpcyBsZW4gPSAyLiBX
aHkgbm90IHB1dCB0aGUgY2hlY2sgYmVmb3JlIHRoZSBjb3B5IGxhYmVsPw0KDQotLSBTdGV2ZQ0K
DQo=

