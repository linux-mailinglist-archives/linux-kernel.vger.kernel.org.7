Return-Path: <linux-kernel+bounces-828201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59EB942A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5C93BE290
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CDE22A1C5;
	Tue, 23 Sep 2025 04:01:02 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996B249E5;
	Tue, 23 Sep 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758600061; cv=none; b=icg4j/zlO3nlnrH+GrjL/Ysg0YW0sjfR4nY8uknSFuUrLyTfTBN3Nr6ceTHfU4ci+qa7PZjTviNUUH2zvMCbxHc7XPV8BvYyPmcMtRM1y0NFitJ2mXStE0rY7jnce/Izyx3rcy0nngH7Dp65Uz9/JbyKqcLL+cZV2gPsKuqBOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758600061; c=relaxed/simple;
	bh=+sA7JeshJtfQ4g+oGvoDEApvUWPOG6PAyKJcP78c1LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rsAswCG40VhTnUqL7c+kg1ZpTEng/PwhWhDkLptvHWPfIU/R51joJtNKRAk2XtAwjsvmxu6p08JUHEXfbbGd4ECcQ6IBO6Wdpw0rae7cr98umj+p3QhNRfi1xIyGxrv4Rf+1DhZBbk4s90WhmgDEifo4mKN9drr9oGjsXlMjC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "lance.yang@linux.dev"
	<lance.yang@linux.dev>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"kees@kernel.org" <kees@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
	"pauld@redhat.com" <pauld@redhat.com>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [????] Re: [PATCH][RFC] hung_task: Support to panic when the
 maximum number of hung task warnings is reached
Thread-Topic: [????] Re: [PATCH][RFC] hung_task: Support to panic when the
 maximum number of hung task warnings is reached
Thread-Index: AQHcLDttVizJ2u6zwEeKMgiwnSexq7SfmowAgACJIFA=
Date: Tue, 23 Sep 2025 04:00:03 +0000
Message-ID: <f11f4dd1983f4073a8008112e55f92f8@baidu.com>
References: <20250923033740.2696-1-lirongqing@baidu.com>
 <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
In-Reply-To: <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
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
X-FEAS-Client-IP: 172.31.3.11
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE1vcnRvbiA8
YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogMjAyNcTqOdTCMjPI1SAxMTo0Ng0K
PiBUbzogTGksUm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiBDYzogY29yYmV0QGx3
bi5uZXQ7IGxhbmNlLnlhbmdAbGludXguZGV2OyBtaGlyYW1hdEBrZXJuZWwub3JnOw0KPiBwYXVs
bWNrQGtlcm5lbC5vcmc7IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsgbWluZ29A
a2VybmVsLm9yZzsNCj4gZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyByb3N0ZWR0QGdvb2Rt
aXMub3JnOyBrZWVzQGtlcm5lbC5vcmc7DQo+IGFybmRAYXJuZGIuZGU7IGZlbmcudGFuZ0BsaW51
eC5hbGliYWJhLmNvbTsgcGF1bGRAcmVkaGF0LmNvbTsNCj4gam9lbC5ncmFuYWRvc0BrZXJuZWwu
b3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFs/Pz8/XSBSZTogW1BBVENIXVtSRkNdIGh1bmdfdGFzazogU3Vw
cG9ydCB0byBwYW5pYyB3aGVuIHRoZQ0KPiBtYXhpbXVtIG51bWJlciBvZiBodW5nIHRhc2sgd2Fy
bmluZ3MgaXMgcmVhY2hlZA0KPiANCj4gT24gVHVlLCAyMyBTZXAgMjAyNSAxMTozNzo0MCArMDgw
MCBsaXJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4gd3JvdGU6DQo+IA0KPiA+IEN1cnJl
bnRseSB0aGUgaHVuZyB0YXNrIGRldGVjdG9yIGNhbiBlaXRoZXIgcGFuaWMgaW1tZWRpYXRlbHkg
b3INCj4gPiBjb250aW51ZSBvcGVyYXRpb24gd2hlbiBodW5nIHRhc2tzIGFyZSBkZXRlY3RlZC4g
SG93ZXZlciwgdGhlcmUgYXJlDQo+ID4gc2NlbmFyaW9zIHdoZXJlIHdlIHdhbnQgYSBtb3JlIGJh
bGFuY2VkIGFwcHJvYWNoOg0KPiA+DQo+ID4gLSBXZSBkb24ndCB3YW50IHRoZSBzeXN0ZW0gdG8g
cGFuaWMgaW1tZWRpYXRlbHkgd2hlbiBhIGZldyBodW5nIHRhc2tzDQo+ID4gICBhcmUgZGV0ZWN0
ZWQsIGFzIHRoZSBzeXN0ZW0gbWF5IGJlIGFibGUgdG8gcmVjb3Zlcg0KPiA+IC0gQW5kIHdlIGFs
c28gZG9uJ3Qgd2FudCB0aGUgc3lzdGVtIHRvIHN0YWxsIGluZGVmaW5pdGVseSB3aXRoIG11bHRp
cGxlDQo+ID4gICBodW5nIHRhc2tzDQo+ID4NCj4gPiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEg
bmV3IG1vZGUgKHZhbHVlIDIpIGZvciB0aGUgaHVuZyB0YXNrIHBhbmljIGJlaGF2aW9yLg0KPiA+
IFdoZW4gc2V0IHRvIDIsIHRoZSBzeXN0ZW0gd2lsbCBwYW5pYyBvbmx5IGFmdGVyIHRoZSBtYXhp
bXVtIG51bWJlciBvZg0KPiA+IGh1bmcgdGFzayB3YXJuaW5ncyAoaHVuZ190YXNrX3dhcm5pbmdz
KSBoYXMgYmVlbiByZWFjaGVkLg0KPiA+DQo+ID4gVGhpcyBwcm92aWRlcyBhIG1pZGRsZSBncm91
bmQgYmV0d2VlbiBpbW1lZGlhdGUgcGFuaWMgYW5kIHBvdGVudGlhbGx5DQo+ID4gaW5maW5pdGUg
c3RhbGwsIGFsbG93aW5nIGZvciBhdXRvbWF0ZWQgdm1jb3JlIGdlbmVyYXRpb24gYWZ0ZXIgYQ0K
PiA+IHJlYXNvbmFibGUNCj4gDQo+IEkgYXNzdW1lIHRoZSBzYW1lIGFyZ3VtZW50IGFwcGxpZXMg
dG8gdGhlIE5NSSB3YXRjaGRvZywgdG8gdGhlIHNvZnRsb2NrdXANCj4gZGV0ZWN0b3IgYW5kIHRv
IHRoZSBSQ1Ugc3RhbGwgZGV0ZWN0b3I/DQoNClRydWUsIGVzcGVjaWFsIFJDVSBzdGFsbCBkZXRl
Y3Rvcg0KDQo+IA0KPiBBIGdlbmVyYWwgZnJhbWV3b3JrIHRvIGhhbmRsZSBhbGwgb2YgdGhlc2Ug
bWlnaHQgYmUgYmV0dGVyLiAgQnV0IHdoeSBkbyBpdCBpbg0KPiBrZXJuZWwgYXQgYWxsPyAgV2hh
dCBhYm91dCBhIHVzZXJzcGFjZSBkZXRlY3RvciB3aGljaCBwYXJzZXMga2VybmVsIGxvZ3MgKG9y
DQo+IG5ldyBwcm9jZnMgY291bnRlcnMpIGFuZCBtYWtlcyBzdWNoIGRlY2lzaW9ucz8NCg0KDQpC
eSBsZXZlcmFnaW5nIGV4aXN0aW5nIGtlcm5lbCBtZWNoYW5pc21zLCBpbXBsZW1lbnRhdGlvbiBp
biBrZXJuZWwgaXMgdmVyeSBzaW1wbGUgYW5kIHJlbGlhYmxlLCBJIHRoaW5rDQoNClRoYW5rcw0K
DQotTGkNCg0K

