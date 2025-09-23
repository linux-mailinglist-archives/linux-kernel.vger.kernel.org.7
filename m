Return-Path: <linux-kernel+bounces-828394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFCBB94887
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D13AD5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416530F545;
	Tue, 23 Sep 2025 06:17:12 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98241263F3C;
	Tue, 23 Sep 2025 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608231; cv=none; b=D+4yksZDKMBD7ng4qC4cK6G7x0C4c5+yQnE0Exzzfjb+3NPYN2gXlJqHOc+g6hpLz5inYfIq0BX1c3WZMhstyFQfjn6KMIUshf9EADCkjTjPAOdQu0KHlfdxavQTh82dzq88IrPdBFqTxUQCOLgZn/aIs9mhLlxOsPokZmBZQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608231; c=relaxed/simple;
	bh=/k0HI1awLxSRUCHOMjkfcY4oglNEQnEO/vNe46Cbdqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFeCrdgrDVn+QkNbrBH7ywxDxeqz8T3buaqMfwH2Lo3q8xpd+dHCZfosBaAORU+5tCPSHbmVaDArR4JZRjnzDjYaLbxFGRWVIWc/sv+vr9evSaBVlsi+7VMbLiHKhnKRZju0nWWI99IGfvbuZG7hTBKm0/XzfhYjQksHICAP6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "lance.yang@linux.dev" <lance.yang@linux.dev>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"kees@kernel.org" <kees@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
	"pauld@redhat.com" <pauld@redhat.com>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbPz8/P10gUmU6IFtQQVRDSF1bUkZD?=
 =?utf-8?B?XSBodW5nX3Rhc2s6IFN1cHBvcnQgdG8gcGFuaWMgd2hlbiB0aGUgbWF4aW11?=
 =?utf-8?Q?m_number_of_hung_task_warnings_is_reached?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFs/Pz8/XSBSZTogW1BBVENIXVtSRkNdIGh1?=
 =?utf-8?B?bmdfdGFzazogU3VwcG9ydCB0byBwYW5pYyB3aGVuIHRoZSBtYXhpbXVtIG51?=
 =?utf-8?Q?mber_of_hung_task_warnings_is_reached?=
Thread-Index: AQHcLDttVizJ2u6zwEeKMgiwnSexq7SfmowAgACJIFD//51tAIAAiErQ
Date: Tue, 23 Sep 2025 06:16:03 +0000
Message-ID: <d334c33bc11243cd9ab31ebe8e4310ca@baidu.com>
References: <20250923033740.2696-1-lirongqing@baidu.com>
 <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
 <f11f4dd1983f4073a8008112e55f92f8@baidu.com>
 <36db2f10-ebbe-4ecd-b27f-e02d9e1569c2@paulmck-laptop>
In-Reply-To: <36db2f10-ebbe-4ecd-b27f-e02d9e1569c2@paulmck-laptop>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBFLiBNY0tlbm5l
eSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI15bm0OeaciDIz5pelIDE0OjA0DQo+
IFRvOiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IENjOiBBbmRyZXcgTW9y
dG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgY29yYmV0QGx3bi5uZXQ7DQo+IGxhbmNl
LnlhbmdAbGludXguZGV2OyBtaGlyYW1hdEBrZXJuZWwub3JnOw0KPiBwYXdhbi5rdW1hci5ndXB0
YUBsaW51eC5pbnRlbC5jb207IG1pbmdvQGtlcm5lbC5vcmc7DQo+IGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbTsgcm9zdGVkdEBnb29kbWlzLm9yZzsga2Vlc0BrZXJuZWwub3JnOw0KPiBhcm5k
QGFybmRiLmRlOyBmZW5nLnRhbmdAbGludXguYWxpYmFiYS5jb207IHBhdWxkQHJlZGhhdC5jb207
DQo+IGpvZWwuZ3JhbmFkb3NAa2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBb5aSW6YOo6YKu5Lu2
XSBSZTogWz8/Pz9dIFJlOiBbUEFUQ0hdW1JGQ10gaHVuZ190YXNrOiBTdXBwb3J0IHRvIHBhbmlj
DQo+IHdoZW4gdGhlIG1heGltdW0gbnVtYmVyIG9mIGh1bmcgdGFzayB3YXJuaW5ncyBpcyByZWFj
aGVkDQo+IA0KPiBPbiBUdWUsIFNlcCAyMywgMjAyNSBhdCAwNDowMDowM0FNICswMDAwLCBMaSxS
b25ncWluZyB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4N
Cj4gPiA+IFNlbnQ6IDIwMjXlubQ55pyIMjPml6UgMTE6NDYNCj4gPiA+IFRvOiBMaSxSb25ncWlu
ZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gPiBDYzogY29yYmV0QGx3bi5uZXQ7IGxhbmNl
LnlhbmdAbGludXguZGV2OyBtaGlyYW1hdEBrZXJuZWwub3JnOw0KPiA+ID4gcGF1bG1ja0BrZXJu
ZWwub3JnOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+ID4gPiBtaW5nb0Br
ZXJuZWwub3JnOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHJvc3RlZHRAZ29vZG1pcy5v
cmc7DQo+ID4gPiBrZWVzQGtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7IGZlbmcudGFuZ0BsaW51
eC5hbGliYWJhLmNvbTsNCj4gPiA+IHBhdWxkQHJlZGhhdC5jb207IGpvZWwuZ3JhbmFkb3NAa2Vy
bmVsLm9yZzsNCj4gPiA+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFs/Pz8/XSBSZTogW1BBVENIXVtSRkNdIGh1
bmdfdGFzazogU3VwcG9ydCB0byBwYW5pYyB3aGVuDQo+ID4gPiB0aGUgbWF4aW11bSBudW1iZXIg
b2YgaHVuZyB0YXNrIHdhcm5pbmdzIGlzIHJlYWNoZWQNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDIz
IFNlcCAyMDI1IDExOjM3OjQwICswODAwIGxpcm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29t
Pg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IEN1cnJlbnRseSB0aGUgaHVuZyB0YXNrIGRldGVj
dG9yIGNhbiBlaXRoZXIgcGFuaWMgaW1tZWRpYXRlbHkgb3INCj4gPiA+ID4gY29udGludWUgb3Bl
cmF0aW9uIHdoZW4gaHVuZyB0YXNrcyBhcmUgZGV0ZWN0ZWQuIEhvd2V2ZXIsIHRoZXJlDQo+ID4g
PiA+IGFyZSBzY2VuYXJpb3Mgd2hlcmUgd2Ugd2FudCBhIG1vcmUgYmFsYW5jZWQgYXBwcm9hY2g6
DQo+ID4gPiA+DQo+ID4gPiA+IC0gV2UgZG9uJ3Qgd2FudCB0aGUgc3lzdGVtIHRvIHBhbmljIGlt
bWVkaWF0ZWx5IHdoZW4gYSBmZXcgaHVuZyB0YXNrcw0KPiA+ID4gPiAgIGFyZSBkZXRlY3RlZCwg
YXMgdGhlIHN5c3RlbSBtYXkgYmUgYWJsZSB0byByZWNvdmVyDQo+ID4gPiA+IC0gQW5kIHdlIGFs
c28gZG9uJ3Qgd2FudCB0aGUgc3lzdGVtIHRvIHN0YWxsIGluZGVmaW5pdGVseSB3aXRoIG11bHRp
cGxlDQo+ID4gPiA+ICAgaHVuZyB0YXNrcw0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGNvbW1pdCBp
bnRyb2R1Y2VzIGEgbmV3IG1vZGUgKHZhbHVlIDIpIGZvciB0aGUgaHVuZyB0YXNrIHBhbmljDQo+
IGJlaGF2aW9yLg0KPiA+ID4gPiBXaGVuIHNldCB0byAyLCB0aGUgc3lzdGVtIHdpbGwgcGFuaWMg
b25seSBhZnRlciB0aGUgbWF4aW11bSBudW1iZXINCj4gPiA+ID4gb2YgaHVuZyB0YXNrIHdhcm5p
bmdzIChodW5nX3Rhc2tfd2FybmluZ3MpIGhhcyBiZWVuIHJlYWNoZWQuDQo+ID4gPiA+DQo+ID4g
PiA+IFRoaXMgcHJvdmlkZXMgYSBtaWRkbGUgZ3JvdW5kIGJldHdlZW4gaW1tZWRpYXRlIHBhbmlj
IGFuZA0KPiA+ID4gPiBwb3RlbnRpYWxseSBpbmZpbml0ZSBzdGFsbCwgYWxsb3dpbmcgZm9yIGF1
dG9tYXRlZCB2bWNvcmUNCj4gPiA+ID4gZ2VuZXJhdGlvbiBhZnRlciBhIHJlYXNvbmFibGUNCj4g
PiA+DQo+ID4gPiBJIGFzc3VtZSB0aGUgc2FtZSBhcmd1bWVudCBhcHBsaWVzIHRvIHRoZSBOTUkg
d2F0Y2hkb2csIHRvIHRoZQ0KPiA+ID4gc29mdGxvY2t1cCBkZXRlY3RvciBhbmQgdG8gdGhlIFJD
VSBzdGFsbCBkZXRlY3Rvcj8NCj4gPg0KPiA+IFRydWUsIGVzcGVjaWFsIFJDVSBzdGFsbCBkZXRl
Y3Rvcg0KPiANCj4gVGhlcmUgYXJlIHRoZSBwYW5pY19vbl9yY3Vfc3RhbGwgYW5kIG1heF9yY3Vf
c3RhbGxfdG9fcGFuaWMgc3lzY3Rscywgd2hpY2gNCj4gdG9nZXRoZXIgYWxsb3cgeW91IHRvIHBh
bmljIGFmdGVyIChzYXkpIHRocmVlIFJDVSBDUFUgc3RhbGwgd2FybmluZ3MuDQo+IERvZXMgdGhv
c2UgZG8gd2hhdCB5b3UgbmVlZD8NCg0KDQoNClllcywgdGhpcyBpcyB3aGF0IEkgbmVlZC4gUkNV
IGhhcyBiZWVuIGltcGxlbWVudGVkLg0KDQpUaGFua3MNCg0KDQotTGkNCg0KPiANCj4gCQkJCQkJ
CVRoYW54LCBQYXVsDQo+IA0KPiA+ID4gQSBnZW5lcmFsIGZyYW1ld29yayB0byBoYW5kbGUgYWxs
IG9mIHRoZXNlIG1pZ2h0IGJlIGJldHRlci4gIEJ1dCB3aHkNCj4gPiA+IGRvIGl0IGluIGtlcm5l
bCBhdCBhbGw/ICBXaGF0IGFib3V0IGEgdXNlcnNwYWNlIGRldGVjdG9yIHdoaWNoDQo+ID4gPiBw
YXJzZXMga2VybmVsIGxvZ3MgKG9yIG5ldyBwcm9jZnMgY291bnRlcnMpIGFuZCBtYWtlcyBzdWNo
IGRlY2lzaW9ucz8NCj4gPg0KPiA+DQo+ID4gQnkgbGV2ZXJhZ2luZyBleGlzdGluZyBrZXJuZWwg
bWVjaGFuaXNtcywgaW1wbGVtZW50YXRpb24gaW4ga2VybmVsIGlzDQo+ID4gdmVyeSBzaW1wbGUg
YW5kIHJlbGlhYmxlLCBJIHRoaW5rDQo+ID4NCj4gPiBUaGFua3MNCj4gPg0KPiA+IC1MaQ0KPiA+
DQo=

