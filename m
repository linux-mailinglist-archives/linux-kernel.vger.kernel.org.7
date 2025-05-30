Return-Path: <linux-kernel+bounces-667766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DDFAC89B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E141BA2992
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E520296E;
	Fri, 30 May 2025 08:06:03 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4351D61AA
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592362; cv=none; b=tsf51qbwEJWfz46I5VehumjV7vpY5+reA7bvWVzDN4UxsLjyTt6+mH8jT8gowYr+X/Y1LqWSICOLjHaL+ux/jB+ZA0Y16L0JY9CS/WFwBXCOhf4yzU//c+s+GQhnjg++qsu13Irc22KTMEaoyIQq6ss1TzMND5xO5hyo4M1SMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592362; c=relaxed/simple;
	bh=wRPtvgAFvrNkQSxGuy5+SQwve3uu0xS+y0fxFvzjIzA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IHLk3dWgwoW6m0gRvWZpfzk4yAPr/dvW89EIhlFjljvy+MPoD+yNyebzJSn1NwrrN8K2QkgLe34oCbisOy6/2jh7BstPzQ8ja5jmgeJIDs/h2Rri9iH4fW/5deCp9Q4VH5sfRewjgd49wfAibIdGDzj2rJFKjK72phnpZwCm5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202505301604430790;
        Fri, 30 May 2025 16:04:43 +0800
Received: from jtjnmail201604.home.langchao.com (10.100.2.4) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 May 2025 16:04:42 +0800
Received: from jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322])
 by jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322%5]) with mapi
 id 15.01.2507.039; Fri, 30 May 2025 16:04:42 +0800
From: =?utf-8?B?U2ltb24gV2FuZyAo546L5Lyg5Zu9KQ==?= <wangchuanguo@inspur.com>
To: SeongJae Park <sj@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "david@redhat.com"
	<david@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "damon@lists.linux.dev"
	<damon@lists.linux.dev>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on
 sysfs-schemes
Thread-Topic: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on
 sysfs-schemes
Thread-Index: AdvRN0I/Pe3LT5XZQBaj9QtYPLbiIg==
Date: Fri, 30 May 2025 08:04:42 +0000
Message-ID: <d8e3000cfadb443681fabad65093b462@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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
tUid: 20255301604432de45734cce98a160adada192bf9edc5
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

DQo+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyB1c2Vfbm9kZXNfb2ZfdGllciB1bmRlcg0KPiA+ID4g
Pg0KPiA+ID4NCj4gL3N5cy9rZXJuZWwvbW0vZGFtb24vYWRtaW4va2RhbW9uZHMvPE4+L2NvbnRl
eHRzLzxOPi9zY2hlbWVzLzxOPi8NCj4gPiA+ID4NCj4gPiA+ID4gVGhlICd1c2Vfbm9kZXNfb2Zf
dGllcicgY2FuIGJlIHVzZWQgdG8gc2VsZWN0IG5vZGVzIHdpdGhpbiB0aGUNCj4gPiA+ID4gc2Ft
ZSBtZW1vcnkgdGllciBvZiB0YXJnZXRfbmlkIGZvciBEQU1PUyBhY3Rpb25zIHN1Y2ggYXMNCj4g
PiA+IERBTU9TX01JR1JBVEVfe0hPVCxDT0xEfS4NCj4gPiA+DQo+ID4gPiBDb3VsZCB5b3UgcGxl
YXNlIGVsYWJvcmF0ZSBpbiB3aGF0IHNldHVwIHlvdSB0aGluayB0aGlzIG9wdGlvbiBpcw0KPiA+
ID4gdXNlZnVsLCBhbmQgbWVhc3VyZW1lbnQgb2YgdGhlIHVzZWZ1bG5lc3MgaWYgeW91IGhhdmU/
DQo+ID4gPg0KPiA+ID4gSSdtIGFza2luZyB0aGUgYWJvdmUgcXVlc3Rpb24gYmVjYXVzZSBvZiBi
ZWxvdyByZWFzb25zLiAgTXkNCj4gPiA+IGFudGljaWFwdGVkIHVzYWdlIG9mIERBTU9TX01JR1JB
VEVfe0hPVCxDT0xEfSBpcyBmb3Igbm90IG9ubHkgbWVtb3J5DQo+ID4gPiB0aWVyaW5nIGJ1dCBn
ZW5lcmljIE5VTUEgbm9kZSBtYW5hZ2VtZW50LiAgQW5kIG15IHByb3Bvc2VkIHVzYWdlIG9mDQo+
ID4gPiB0aGVzZSBmb3IgbWVtb3J5IHRpZXJpbmcgaXMgbWFraW5nIHBlci1ub2RlIHByb21vdGlv
bi9kZW1vdGlvbiBmb3INCj4gPiA+IGdyYWR1YWxseSBwcm9tb3RpbmcgYW5kIGRlbW90aW5nIHBh
Z2VzIHN0ZXAgYnkgc3RlcCBiZXR3ZWVuIG5vZGUuDQo+ID4gPiBJdCBjb3VsZCBiZSBzbG93IGJ1
dCBJIGFudGljaXBhdGUgc3VjaCBzbG93IGJ1dCBjb250aW51ZWQNCj4gPiA+IHByb21vdGlvbi9k
ZW1vdGlvbiBpcyBtb3JlIGltcG9ydGFudCBmb3IgcmVsaWFibGUgcGVyZm9ybWFuY2Ugb24NCj4g
cHJvZHVjdGlvbiBzeXN0ZW1zIG9mIGxhcmdlIHRpbWUgc2NhbGUuDQo+ID4gPiBBbmQgSSBiZWxp
ZXZlIHRoZSBhcHByb2FjaCBjYW4gYmUgYXBwbGllZCB0byBnZW5lcmFsIE5VTUEgbm9kZXMNCj4g
PiA+IG1hbmFnZW1lbnQsIG9uY2UgREFNT04gaXMgZXh0ZW5kZWQgZm9yIHBlci1DUFUgYWNjZXNz
IG1vbml0b3JpbmcuDQo+ID4gPg0KPiA+ID4gSSdtIG5vdCBzYXlpbmcgdGhpcyBjaGFuZ2UgaXMg
bm90IHVzZWZ1bCwgYnV0IGFza2luZyB5b3UgdG8gZ2l2ZSBtZQ0KPiA+ID4gYSBjaGFuY2UgdG8g
bGVhcm4geW91ciBjaGFuZ2VzLCBiZXR0ZXIuDQo+ID4NCj4gPiBJIGJlbGlldmUgc29tZSB1c2Vy
cyBtYXkgd2FudCB0byDigIvigIt1c2Ugb25seSB0aGUgdGFyZ2V0IG5vZGUncyBtZW1vcnnigIvi
gIsNCj4gPiBhbmQgcmVzZXJ2ZSBvdGhlciBub2RlcyBpbiB0aGUgc2FtZSB0aWVyIGZvciBzcGVj
aWZpYyBhcHBsaWNhdGlvbnMuDQo+ID4gVGhlcmVmb3JlLCBJIGFkZGVkIGEgc3dpdGNoIGZpbGUg
dXNlX25vZGVzX29mX3RpZXIuDQo+IA0KPiBUaGFuayB5b3UgZm9yIGNsYXJpZnlpbmcsIFNpbW9u
Lg0KPiANCj4gQmVjYXVzZSB0aGlzIGlzIGFuIEFCSSBjaGFuZ2UgdGhhdCBkaWZmaWN1bHQgdG8g
cmV2ZXJ0IGFuZCB0aGVyZWZvcmUgd2UgbWF5DQo+IG5lZWQgdG8gc3VwcG9ydCBmb3IgbG9uZyB0
ZXJtLCBJJ2QgbGlrZSB0byBoYXZlIG1vcmUgY2xlYXIgdGhlb3J5IGFuZC9vciBkYXRhIGlmDQo+
IHBvc3NpYmxlLiAgSW4gbXkgaHVtYmxlIG9waW5pb24sIGFib3ZlIGNsYXJpZmljYXRpb24gZG9l
c24ndCBzb3VuZCBsaWtlIGENCj4gc3Ryb25nIGVub3VnaCBqdXN0aWZpY2F0aW9uIGZvciBBQkkg
Y2hhbmdlLg0KPiANCj4gTW9yZSBzcGVjaWZpY2FsbHksIGl0IHdvdWxkIGJlIGJldHRlciBpZiB5
b3UgY291bGQgYW5zd2VyIGJlbG93IHF1ZXN0aW9ucy4NCj4gV2hvIHdvdWxkIGJlIHN1Y2ggdXNl
cnMsIGhvdyBjb21tb24gdGhlIHVzZSBjYXNlIHdvdWxkIGJlLCBhbmQgd2hhdCBhcmUNCj4gdGhl
IGJlbmVmaXQgb2YgZG9pbmcgc28/ICBJcyB0aGF0IG9ubHkgdGhlb3J5PyAgT3IsIGEgcmVhbCBl
eGlzdGluZyB1c2UgY2FzZT8NCj4gQ2FuIHlvdSBzaGFyZSBtZWFzdXJlbWVudCBvZiB0aGUgYmVu
ZWZpdCBmcm9tIHRoaXMgY2hhbmdlIHRoYXQgbWVhc3VyZWQNCj4gZnJvbSByZWFsIHdvcmtsb2Fk
cyBvciBiZW5jaG1hcmtzPyAgSXMgdGhlcmUgYW4gYWx0ZXJuYXRpdmUgd2F5IHRvIGRvIHRoaXMN
Cj4gd2l0aG91dCBBQkkgY2hhbmdlPw0KDQoNCllvdXIgY29uY2VybiBpcyB0aGF0IGFkZGluZyB0
aGUgYm9vbCB1c2Vfbm9kZXNfb2ZfdGllciB2YXJpYWJsZSBhbmQgaW50cm9kdWNpbmcgDQphbiBh
ZGRpdGlvbmFsIHBhcmFtZXRlciB0byBtdWx0aXBsZSBmdW5jdGlvbnMgd291bGQgY2F1c2UgQUJJ
IGNoYW5nZXMsIGNvcnJlY3Q/4oCL4oCLDQoNCuKAi+KAi0kgcHJvcG9zZSBhdm9pZGluZyB0aGUg
Y3JlYXRpb24gb2YgdGhlICd1c2Vfbm9kZXNfb2ZfdGllcicgc3lzZnMgZmlsZS4gSW5zdGVhZCwg
DQp3ZSBjYW4gbW9kaWZ5IHRoZSBfX2RhbW9uX3BhX21pZ3JhdGVfZm9saW9fbGlzdCgpIGZ1bmN0
aW9uIHRvIGNoYW5nZSB0aGUgYWxsb3dlZF9tYXNrIA0KZnJvbSBOT0RFX01BU0tfTk9ORSB0byB0
aGUgZnVsbCBub2RlIG1hc2sgb2YgdGhlIGVudGlyZSB0aWVyIHdoZXJlIHRoZSB0YXJnZXRfbmlk
IHJlc2lkZXMuIA0KVGhpcyBhcHByb2FjaCB3b3VsZCBiZSBzaW1pbGFyIHRvIHRoZSBpbXBsZW1l
bnRhdGlvbiBpbiBjb21taXQgMzIwMDgwMjcyODkyDQogKCdtbS9kZW1vdGlvbjogZGVtb3RlIHBh
Z2VzIGFjY29yZGluZyB0byBhbGxvY2F0aW9uIGZhbGxiYWNrIG9yZGVyJykuDQoNCkknZCBsaWtl
IHRvIGNvbmZpcm0gdHdvIG1vZGlmaWNhdGlvbiBwb2ludHMgd2l0aCB5b3U6DQrigIvigIsxLlJl
Z2FyZGluZyBhbGxvY19taWdyYXRlX2ZvbGlvKCnigIvigIs6DQpSZXN0b3JpbmcgdGhlIG9yaWdp
bmFsIG5vZGVtYXNrIGFuZCBnZnBfbWFzayBpbiB0aGlzIGZ1bmN0aW9uIGlzIHRoZSBjb3JyZWN0
IGFwcHJvYWNoLCBjb3JyZWN0Pw0K4oCL4oCLMi5SZWdhcmRpbmcgREFNT04ncyBtaWdyYXRpb24g
bG9naWPigIvigIs6DQpUaGUgdGFyZ2V0IHNjb3BlIHNob3VsZCBiZSBleHBhbmRlZCBmcm9tIGEg
c2luZ2xlIHNwZWNpZmllZCBub2RlIHRvIHRoZSBlbnRpcmUgbWVtb3J5IHRpZXINCiAod2hlcmUg
dGhlIHRhcmdldCBub2RlIHJlc2lkZXMpLCBjb3JyZWN0Pw0K4oCL4oCLQ2FuIHdlIGNvbmZpcm0g
dGhlc2UgdHdvIHBvaW50cyBhcmUgYWdyZWVkIHVwb24/4oCLDQogDQo+ID4gSSB0aGluayBpdCBt
aWdodCBiZSBiZXR0ZXIgdG8gc2V0IHRoZSBkZWZhdWx0IHZhbHVlIG9mDQo+ID4gdXNlX25vZGVz
X29mX3RpZXIgdG8gdHJ1ZSAoaS5lLiwgYWxsb3cgdXNpbmcgZmFsbGJhY2sgbm9kZXMpLiBXaGF0
IGRvDQo+ID4geW91IHRoaW5rDQo+IA0KPiBJbiBteSBodW1ibGUgb3Bpbmlvbiwgd2UgY2FuIGNv
bnNpZGVyIHNldHRpbmcgaXQgdHJ1ZSBieSBkZWZhdWx0LCBpZiB3ZSBhZ3JlZQ0KPiB0aGUgYmVu
ZWZpdCBvZiB0aGUgY2hhbmdlIGlzIHNpZ25pZmljYW50LiAgV2l0aCBvbmx5IGN1cnJlbnRseSBn
aXZlbiBpbmZvcm1hdGlvbiwNCj4gSSBjYW5ub3QgZWFzaWx5IHNheSBpZiBJIHRoaW5rIHRoaXMg
Y2FuIHJlYWxseSBiZSB1c2VmdWwuICBBcyBhc2tlZCBhYm92ZWx5LCBtb3JlDQo+IGNsZWFyIHRo
b2VyeSBhbmQvb3IgcmVhbCBkYXRhIHdvdWxkIGJlIGhlbHBmdWwuDQo+IA0KPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IHdhbmdjaHVhbmd1byA8d2FuZ2NodWFuZ3VvQGluc3B1
ci5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9kYW1vbi5oICAgICAg
ICB8ICA5ICsrKysrKysrLQ0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9tZW1vcnktdGllcnMuaCB8
ICA1ICsrKysrDQo+ID4gPiA+ICBtbS9kYW1vbi9jb3JlLmMgICAgICAgICAgICAgIHwgIDYgKysr
Ky0tDQo+ID4gPiA+ICBtbS9kYW1vbi9scnVfc29ydC5jICAgICAgICAgIHwgIDMgKystDQo+ID4g
PiA+ICBtbS9kYW1vbi9wYWRkci5jICAgICAgICAgICAgIHwgMTkgKysrKysrKysrKysrLS0tLS0t
LQ0KPiA+ID4gPiAgbW0vZGFtb24vcmVjbGFpbS5jICAgICAgICAgICB8ICAzICsrLQ0KPiA+ID4g
PiAgbW0vZGFtb24vc3lzZnMtc2NoZW1lcy5jICAgICB8IDMxDQo+ID4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQo+ID4gPiA+ICBtbS9tZW1vcnktdGllcnMuYyAgICAgICAgICAg
IHwgMTMgKysrKysrKysrKysrKw0KPiA+ID4gPiAgc2FtcGxlcy9kYW1vbi9tdGllci5jICAgICAg
ICB8ICAzICsrLQ0KPiA+ID4gPiAgc2FtcGxlcy9kYW1vbi9wcmNsLmMgICAgICAgICB8ICAzICsr
LQ0KPiA+ID4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRp
b25zKC0pDQo+ID4gPg0KPiA+ID4gQ2FuIHdlIHBsZWFzZSBtYWtlIHRoaXMgY2hhbmdlIG1vcmUg
c2VwYXJhdGVkPyAgTWF5YmUgd2UgY2FuIHNwbGl0DQo+ID4gPiB0aGUgY2hhbmdlIGZvciBtZW1v
cnktdGllcnMuYywgREFNT04gY29yZSBsYXllciwgYW5kIERBTU9OIHN5c2ZzDQo+IGludGVyZmFj
ZS4NCj4gPiA+IFRoYXQgd2lsbCBtYWtlIHJldmlldyBtdWNoIGVhc2llci4NCj4gPg0KPiA+IFll
cyxJJ2xsIHNwbGl0IHRoaXMgcGF0Y2ggdG8gYmUgMiBwYXRjaGVzLg0KPiANCj4gVGhhbmsgeW91
IGZvciBhY2NlcHRpbmcgbXkgc3VnZ2VzdGlvbi4gIEJ1dCBJIHRoaW5rIGl0IGRlc2VydmVzIDMg
cGF0Y2hlcywNCj4gZWFjaCBmb3INCj4gDQo+IC0gbWVtb3J5LXRpZXJzLmMsDQo+IC0gREFNT04g
Y29yZSBsYXllciwgYW5kDQo+IC0gYW5kIERBTU9OIHN5c2ZzIGludGVyZmFjZS4NCj4gDQo+IEJ1
dCwgbGV0J3MgZnVydGhlciBkaXNjdXNzIG9uIHRoZSBoaWdoIGxldmVsIHRvcGljIChpZiB0aGlz
IGNoYW5nZSBpcyByZWFsbHkNCj4gYmVuZWZpY2lhbCBlbm91Z2ggdG8gbWFrZSBBQkkgY2hhbmdl
KS4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IFNKDQo+IA0KPiBbLi4uXQ0K

