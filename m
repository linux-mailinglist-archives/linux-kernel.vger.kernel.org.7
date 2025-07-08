Return-Path: <linux-kernel+bounces-721997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A739FAFD096
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C5B568154
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D32E659;
	Tue,  8 Jul 2025 16:23:52 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE52E5416
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991832; cv=none; b=uZoc/xMnsBocxTYteqOzhy6fnxEUitwio4aUePYSaj4ztSMSdhksnz5xdoh6n6dK3+EQDH1Ftn76D6/GfeqgGpWW19tIgnt5patzQSwb4kz3bdUjDOt7yk8OPduXGL7YZwVhTghO3VPMDjlvjvlFstRgcqzB3vi3/u5TNMkkCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991832; c=relaxed/simple;
	bh=MtGa2Y+6oxSfcCiplPxDDTowkK7ULExVJ7p8Jx+X+ZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQwpXLFllwJ7IBdk07Y2I5N1+nLt5VID4iIqMViSZHHCj52WwognwachDqIQds3IHn2L2iyfvHSiAGJjGJfjZZ9HBFXq6UqPBP4bjOgMmvuApA6KoioIAJTKTxXJlj0JZBK9BwjjqvxUM0H81oXdESKo0nmcflrItOBRamV43fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bc5sn6t2Rz1rqRn;
	Wed,  9 Jul 2025 00:19:41 +0800 (CST)
Received: from kwepemf200003.china.huawei.com (unknown [7.202.181.229])
	by mail.maildlp.com (Postfix) with ESMTPS id AFECA180466;
	Wed,  9 Jul 2025 00:23:45 +0800 (CST)
Received: from kwepemh100012.china.huawei.com (7.202.181.97) by
 kwepemf200003.china.huawei.com (7.202.181.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 00:23:45 +0800
Received: from kwepemh100012.china.huawei.com ([7.202.181.97]) by
 kwepemh100012.china.huawei.com ([7.202.181.97]) with mapi id 15.02.1544.011;
 Wed, 9 Jul 2025 00:23:45 +0800
From: "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
To: Frederic Weisbecker <frederic@kernel.org>, "wangxiongfeng (C)"
	<wangxiongfeng2@huawei.com>
CC: "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiexiuqi <xiexiuqi@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBocnRpbWVyczogVXBkYXRlIG5ldyBDUFUncyBuZXh0?=
 =?gb2312?B?IGV2ZW50IGluIGhydGltZXJzX2NwdV9keWluZygp?=
Thread-Topic: [PATCH] hrtimers: Update new CPU's next event in
 hrtimers_cpu_dying()
Thread-Index: AQHb7+1OehEg9pjwRU2FlbA4UgYjRLQnpQoAgADC4MA=
Date: Tue, 8 Jul 2025 16:23:45 +0000
Message-ID: <d29ca2b182db4e8cba35db51467a961c@huawei.com>
References: <20250708101727.166892-1-wangxiongfeng2@huawei.com>
 <aG0RxASJqknbaUkM@localhost.localdomain>
In-Reply-To: <aG0RxASJqknbaUkM@localhost.localdomain>
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

LS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IEZyZWRlcmljIFdlaXNiZWNrZXIgW21haWx0bzpm
cmVkZXJpY0BrZXJuZWwub3JnXSANCreiy83KsbzkOiAyMDI1xOo31MI4yNUgMjA6NDENCsrVvP7I
yzogd2FuZ3hpb25nZmVuZyAoQykgPHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5jb20+DQqzrcvNOiBh
bm5hLW1hcmlhQGxpbnV0cm9uaXguZGU7IHRnbHhAbGludXRyb25peC5kZTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgWGlleGl1cWkgPHhpZXhpdXFpQGh1YXdlaS5jb20+OyBXYW5nc2hh
b2JvIChib2JvKSA8Ym9iby5zaGFvYm93YW5nQGh1YXdlaS5jb20+DQrW98ziOiBSZTogW1BBVENI
XSBocnRpbWVyczogVXBkYXRlIG5ldyBDUFUncyBuZXh0IGV2ZW50IGluIGhydGltZXJzX2NwdV9k
eWluZygpDQoNCkxlIFR1ZSwgSnVsIDA4LCAyMDI1IGF0IDA2OjE3OjI3UE0gKzA4MDAsIFhpb25n
ZmVuZyBXYW5nIGEgqKZjcml0IDoNCj4gV2hlbiB0ZXN0aW5nIHNvZnRpcnEgYmFzZWQgaHJ0aW1l
cnMgb24gYW4gQVJNMzIgYm9hcmQsIHdpdGggaGlnaCANCj4gcmVzb2x1dGlvbiBtb2RlIGFuZCBu
b2h6IGFyZSBib3RoIGluYWN0aXZlLCBzb2Z0aXJxIGJhc2VkIGhydGltZXJzIA0KPiBmYWlsZWQg
dG8gdHJpZ2dlciB3aGVuIG1vdmVkIGF3YXkgZnJvbSBhbiBvZmZsaW5lIENQVS4gVGhlIGZsb3dw
YXRoIGlzIA0KPiBhcyBmb2xsb3dzLg0KPiANCj4gQ1BVMAkJCQlDUFUxDQo+IAkJCQlzb2Z0aXJx
IGJhc2VkIGhydGltZXJzIGFyZSBxdWV1ZWQNCj4gCQkJCW9mZmxpbmUgQ1BVMQ0KPiAJCQkJbW92
ZSBocnRpbWVycyB0byBDUFUwIGluIGhydGltZXJzX2NwdV9keWluZygpDQo+IAkJCQlzZW5kIElQ
SSB0byBDUFUwIHRvIHJldHJpZ2dlciBuZXh0IGV2ZW50ICdzb2Z0aXJxX2V4cGlyZXNfbmV4dCcg
aXMgDQo+IEtUSU1FX01BWCBjYWxsIHJldHJpZ2dlcl9uZXh0X2V2ZW50KCkgaGlnaHJlcyBhbmQg
bm9oeiBpcyANCj4gaW5hY3RpdmUsanVzdCByZXR1cm4gJ3NvZnRpcnFfZXhwaXJlc19uZXh0JyBp
cyBub3QgdXBkYXRlZCBocnRpbWVyIA0KPiBzb2Z0aXJxIGlzIG5ldmVyIHRyaWdnZXJlZA0KPiAN
Cj4gU29tZSBzb2Z0aXJxIGJhc2VkIGhydGltZXJzIGFyZSBxdWV1ZWQgb24gQ1BVMS4gVGhlbiB3
ZSBvZmZsaW5lIENQVTEuDQo+IGhydGltZXJzX2NwdV9keWluZygpIG1vdmVzIGhydGltZXJzIGZy
b20gQ1BVMSB0byBDUFUwLCBhbmQgdGhlbiBpdCANCj4gc2VuZCBhIElQSSB0byBDUFUwIHRvIGxl
dCBDUFUwIGNhbGwgcmV0cmlnZ2VyX25leHRfZXZlbnQoKS4gQnV0IGhpZ2ggDQo+IHJlc29sdXRp
b24gbW9kZSBhbmQgbm9oeiBhcmUgYm90aCBpbmFjdGl2ZS4gU28gcmV0cmlnZ2VyX25leHRfZXZl
bnQoKSANCj4ganVzdCByZXR1cm5lZC4gJ3NvZnRpcnFfZXhwaXJlc19uZXh0JyBpcyBuZXZlciB1
cGRhdGVkIGFuZCByZW1haW5zIA0KPiBLVElNRV9NQVguIFNvIGhydGltZXIgc29mdGlycSBpcyBu
ZXZlciByYWlzZWQuDQo+IA0KPiBUbyBmaXggdGhpcyBpc3N1ZSwgd2UgY2FsbCBocnRpbWVyX3Vw
ZGF0ZV9uZXh0X2V2ZW50KCkgaW4NCj4gaHJ0aW1lcnNfY3B1X2R5aW5nKCkgdG8gdXBkYXRlICdz
b2Z0aXJxX2V4cGlyZXNfbmV4dCcgZm9yIHRoZSBuZXcgQ1BVLg0KPiBJdCBhbHNvIHVwZGF0ZSBo
YXJkaXJxIGhydGltZXIncyBuZXh0IGV2ZW50LCBidXQgaXQgc2hvdWxkIGhhdmUgbm8gYmFkIA0K
PiBlZmZlY3QuDQo+IA0KPiBGaXhlczogNWMwOTMwY2NhYWQ1ICgiaHJ0aW1lcnM6IFB1c2ggcGVu
ZGluZyBocnRpbWVycyBhd2F5IGZyb20gDQo+IG91dGdvaW5nIENQVSBlYXJsaWVyIikNCj4gU2ln
bmVkLW9mZi1ieTogWGlvbmdmZW5nIFdhbmcgPHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5jb20+DQo+
IC0tLQ0KPiAga2VybmVsL3RpbWUvaHJ0aW1lci5jIHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC90aW1lL2hydGltZXIuYyBiL2tlcm5lbC90aW1lL2hydGltZXIuYyBpbmRleCANCj4gMzA4
OTlhOGNjNTJjLi5mZjk3ZWIzNmMxMTYgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC90aW1lL2hydGlt
ZXIuYw0KPiArKysgYi9rZXJuZWwvdGltZS9ocnRpbWVyLmMNCj4gQEAgLTIyOTgsOCArMjI5OCwx
MSBAQCBpbnQgaHJ0aW1lcnNfY3B1X2R5aW5nKHVuc2lnbmVkIGludCBkeWluZ19jcHUpDQo+ICAJ
LyoNCj4gIAkgKiBUaGUgbWlncmF0aW9uIG1pZ2h0IGhhdmUgY2hhbmdlZCB0aGUgZmlyc3QgZXhw
aXJpbmcgc29mdGlycQ0KPiAgCSAqIHRpbWVyIG9uIHRoaXMgQ1BVLiBVcGRhdGUgaXQuDQo+ICsJ
ICogV2UgYWxzbyBuZWVkIHRvIHVwZGF0ZSAnc29mdGlycV9leHBpcmVzX25leHQnIGhlcmUsIGJl
Y2F1c2UgaXQgd2lsbA0KPiArCSAqIG5vdCBiZSB1cGRhdGVkIGluIHJldHJpZ2dlcl9uZXh0X2V2
ZW50KCkgaWYgaGlnaCByZXNvbHV0aW9uIG1vZGUNCj4gKwkgKiBhbmQgbm9oeiBhcmUgYm90aCBp
bmFjdGl2ZS4NCj4gIAkgKi8NCj4gLQlfX2hydGltZXJfZ2V0X25leHRfZXZlbnQobmV3X2Jhc2Us
IEhSVElNRVJfQUNUSVZFX1NPRlQpOw0KPiArCWhydGltZXJfdXBkYXRlX25leHRfZXZlbnQobmV3
X2Jhc2UpOw0KPiAgCS8qIFRlbGwgdGhlIG90aGVyIENQVSB0byByZXRyaWdnZXIgdGhlIG5leHQg
ZXZlbnQgKi8NCj4gIAlzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUobmNwdSwgcmV0cmlnZ2VyX25l
eHRfZXZlbnQsIE5VTEwsIDApOw0KDQpJdCBzZWVtcyB0aGF0IGEgc2ltaWxhciBwcm9ibGVtIGNh
biBoYXBwZW4gd2hpbGUgZW5xdWV1ZWluZyBhIHRpbWVyIGZyb20gYW4gb2ZmbGluZSBDUFUgKHNl
ZSB0aGUgY2FsbCB0byBzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGVfYXN5bmMoKSkuDQoNCkhvdyBh
Ym91dCB0aGlzICh1bnRlc3RlZCkgaW5zdGVhZD8gcmV0cmlnZ2VyX25leHRfZXZlbnQsIGlzIG5v
dCBhIGZhc3QgcGF0aCBzbyB3ZSBkb24ndCBjYXJlIGFib3V0IHJhcmUgZXh0cmEgY29zdDoNCg0K
ZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL2hydGltZXIuYyBiL2tlcm5lbC90aW1lL2hydGltZXIu
YyBpbmRleCAzMDg5OWE4Y2M1MmMuLmU4YzQ3OTMyOTI4MiAxMDA2NDQNCi0tLSBhL2tlcm5lbC90
aW1lL2hydGltZXIuYw0KKysrIGIva2VybmVsL3RpbWUvaHJ0aW1lci5jDQpAQCAtNzg3LDEwICs3
ODcsMTAgQEAgc3RhdGljIHZvaWQgcmV0cmlnZ2VyX25leHRfZXZlbnQodm9pZCAqYXJnKQ0KIAkg
KiBvZiB0aGUgbmV4dCBleHBpcmluZyB0aW1lciBpcyBlbm91Z2guIFRoZSByZXR1cm4gZnJvbSB0
aGUgU01QDQogCSAqIGZ1bmN0aW9uIGNhbGwgd2lsbCB0YWtlIGNhcmUgb2YgdGhlIHJlcHJvZ3Jh
bW1pbmcgaW4gY2FzZSB0aGUNCiAJICogQ1BVIHdhcyBpbiBhIE5PSFogaWRsZSBzbGVlcC4NCisJ
ICoNCisJICogSW4gcGVyaW9kaWMgbG93IHJlc29sdXRpb24gbW9kZSwgdGhlIG5leHQgc29mdGly
cSBleHBpcmF0aW9uDQorCSAqIG11c3QgYWxzbyBiZSB1cGRhdGVkLg0KIAkgKi8NCi0JaWYgKCFo
cnRpbWVyX2hyZXNfYWN0aXZlKGJhc2UpICYmICF0aWNrX25vaHpfYWN0aXZlKQ0KLQkJcmV0dXJu
Ow0KDQpDb3VsZCB5b3UgZXhwbGFpbiBpbiBkZXRhaWwgd2h5IHRoaXMganVkZ21lbnQgaXMgYWRk
ZWQ/IElzIGl0IGR1ZSB0byBzZWN1cml0eSBpc3N1ZXMgb3IgZWZmaWNpZW5jeSBpbXBhY3Q/DQoN
Ci0gV2FuZyBTaGFvQm8NCg0KDQoJcmF3X3NwaW5fbG9jaygmYmFzZS0+bG9jayk7DQogCWhydGlt
ZXJfdXBkYXRlX2Jhc2UoYmFzZSk7DQogCWlmIChocnRpbWVyX2hyZXNfYWN0aXZlKGJhc2UpKQ0K
QEAgLTIyOTUsMTEgKzIyOTUsNiBAQCBpbnQgaHJ0aW1lcnNfY3B1X2R5aW5nKHVuc2lnbmVkIGlu
dCBkeWluZ19jcHUpDQogCQkJCSAgICAgJm5ld19iYXNlLT5jbG9ja19iYXNlW2ldKTsNCiAJfQ0K
IA0KLQkvKg0KLQkgKiBUaGUgbWlncmF0aW9uIG1pZ2h0IGhhdmUgY2hhbmdlZCB0aGUgZmlyc3Qg
ZXhwaXJpbmcgc29mdGlycQ0KLQkgKiB0aW1lciBvbiB0aGlzIENQVS4gVXBkYXRlIGl0Lg0KLQkg
Ki8NCi0JX19ocnRpbWVyX2dldF9uZXh0X2V2ZW50KG5ld19iYXNlLCBIUlRJTUVSX0FDVElWRV9T
T0ZUKTsNCiAJLyogVGVsbCB0aGUgb3RoZXIgQ1BVIHRvIHJldHJpZ2dlciB0aGUgbmV4dCBldmVu
dCAqLw0KIAlzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUobmNwdSwgcmV0cmlnZ2VyX25leHRfZXZl
bnQsIE5VTEwsIDApOw0KIA0K

