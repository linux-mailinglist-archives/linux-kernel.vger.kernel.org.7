Return-Path: <linux-kernel+bounces-873794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3622FC14BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A9474EA536
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F8330B22;
	Tue, 28 Oct 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="R8GjW6zi"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697C198E91
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656474; cv=none; b=TbFkmPC5EE5eHEPf6IHeyougnTE0I5Vn2k6XSAUmOZmAkIFT5qk+HrZm4QZG98HlDicRmqtY4egvKmGW6zv9ua4p70K3CW2z6iOTU2UywJACUymBerFYle2IDupPOTDhzLfBEt7SyXDrZhYWfzsT3Nf6mD/oKsqWVIYD8z+vJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656474; c=relaxed/simple;
	bh=k+AJi12b9ShCywXsEOZYDh1wDvCvTun+vAJjGLYogTI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PJF0nmMi0mIPqBfwMEu2do+ji+AptsUDsOEPxjXmcsjC6RRkaWRK10awOIr5VJvcF/po3LX9Gk4c6dLDlgJtw6C2arlvWBlrFdWJaB9zhC4JW0ryTBoY1LLEkclSlhVWM4Nnzr/uzxbXFkCmiVPTLcFcy2b+dq2yCv9R0GHZ8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=R8GjW6zi; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k+AJi12b9ShCywXsEOZYDh1wDvCvTun+vAJjGLYogTI=;
	b=R8GjW6zi0SMB2/pC62WwzpzpIo1as9fnKH/d2Xj38ptlxYdouvIvVWb+hSBDb98qYXGno1/1A
	j8W3X7k72w9km32VypvNVjiA1aCm/bldCL12o6MY12TQOtitH8kNHME/EBZj/0xRSVbKLN31PQP
	EvRR0rSwlAdfSVVy7XcsrFo=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cwr8G3Wj0znTVF;
	Tue, 28 Oct 2025 21:00:30 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F7131A0188;
	Tue, 28 Oct 2025 21:01:08 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (7.185.36.8) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 21:01:07 +0800
Received: from dggpemf500012.china.huawei.com ([7.185.36.8]) by
 dggpemf500012.china.huawei.com ([7.185.36.8]) with mapi id 15.02.1544.011;
 Tue, 28 Oct 2025 21:01:07 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: David Hildenbrand <david@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Wangkefeng (OS Kernel Lab)"
	<wangkefeng.wang@huawei.com>, Sunnanyong <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH 3/3] mm/mremap: Use can_pte_batch_count() instead of
 folio_pte_batch() for pte batch
Thread-Topic: [RFC PATCH 3/3] mm/mremap: Use can_pte_batch_count() instead of
 folio_pte_batch() for pte batch
Thread-Index: AdxIAGeAcYzt2zsxR72Jnu3gPSGDrA==
Date: Tue, 28 Oct 2025 13:01:07 +0000
Message-ID: <c484887a684e42c3a775f13af93c3a9f@huawei.com>
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

T24gMjcuMTAuMjUgMTU6MDMsIFpoYW5nIFFpbG9uZyB3cm90ZToNCj4gPiBJbiBjdXJyZW50IG1y
ZW1hcF9mb2xpb19wdGVfYmF0Y2goKSwgMSkgcHRlX2JhdGNoX2hpbnQoKSBhbHdheXMgcmV0dXJu
DQo+ID4gb25lIHB0ZSBpbiBub24tQVJNNjQgbWFjaGluZSwgaXQgaXMgbm90IGVmZmljaWVudC4g
MikgTmV4dCwgaXQgbmVlZCB0bw0KPiA+IGFjcXVpcmUgYSBmb2xpbyB0byBjYWxsIHRoZSBmb2xp
b19wdGVfYmF0Y2goKS4NCj4gPg0KPiA+IER1ZSB0byBuZXcgYWRkZWQgY2FuX3B0ZV9iYXRjaF9j
b3VudCgpLCB3ZSBqdXN0IGNhbGwgaXQgaW5zdGVhZCBvZg0KPiA+IGZvbGlvX3B0ZV9iYXRjaCgp
LiBBbmQgdGhlbiByZW5hbWUgbXJlbWFwX2ZvbGlvX3B0ZV9iYXRjaCgpIHRvDQo+ID4gbXJlbWFw
X3B0ZV9iYXRjaCgpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgUWlsb25nIDx6aGFu
Z3FpbG9uZzNAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgIG1tL21yZW1hcC5jIHwgMTYgKysr
LS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vbXJlbWFwLmMgYi9tbS9tcmVt
YXAuYyBpbmRleA0KPiA+IGJkNzMxNDg5OGVjNS4uZDExZjkzZjE2MjJmIDEwMDY0NA0KPiA+IC0t
LSBhL21tL21yZW1hcC5jDQo+ID4gKysrIGIvbW0vbXJlbWFwLmMNCj4gPiBAQCAtMTY5LDI3ICsx
NjksMTcgQEAgc3RhdGljIHB0ZV90IG1vdmVfc29mdF9kaXJ0eV9wdGUocHRlX3QgcHRlKQ0KPiA+
ICAgCQlwdGUgPSBwdGVfc3dwX21rc29mdF9kaXJ0eShwdGUpOw0KPiA+ICAgI2VuZGlmDQo+ID4g
ICAJcmV0dXJuIHB0ZTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW50IG1yZW1hcF9mb2xp
b19wdGVfYmF0Y2goc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ID4gdW5zaWduZWQgbG9u
ZyBhZGRyLA0KPiA+ICtzdGF0aWMgaW50IG1yZW1hcF9wdGVfYmF0Y2goc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcNCj4gPiArYWRkciwNCj4gPiAgIAkJcHRlX3QgKnB0
ZXAsIHB0ZV90IHB0ZSwgaW50IG1heF9ucikNCj4gPiAgIHsNCj4gPiAtCXN0cnVjdCBmb2xpbyAq
Zm9saW87DQo+ID4gLQ0KPiA+ICAgCWlmIChtYXhfbnIgPT0gMSkNCj4gPiAgIAkJcmV0dXJuIDE7
DQo+ID4NCj4gPiAtCS8qIEF2b2lkIGV4cGVuc2l2ZSBmb2xpbyBsb29rdXAgaWYgd2Ugc3RhbmQg
bm8gY2hhbmNlIG9mIGJlbmVmaXQuICovDQo+ID4gLQlpZiAocHRlX2JhdGNoX2hpbnQocHRlcCwg
cHRlKSA9PSAxKQ0KPiA+IC0JCXJldHVybiAxOw0KPiA+IC0NCj4gPiAtCWZvbGlvID0gdm1fbm9y
bWFsX2ZvbGlvKHZtYSwgYWRkciwgcHRlKTsNCj4gPiAtCWlmICghZm9saW8gfHwgIWZvbGlvX3Rl
c3RfbGFyZ2UoZm9saW8pKQ0KPiA+IC0JCXJldHVybiAxOw0KPiA+IC0NCj4gPiAtCXJldHVybiBm
b2xpb19wdGVfYmF0Y2goZm9saW8sIHB0ZXAsIHB0ZSwgbWF4X25yKTsNCj4gPiArCXJldHVybiBj
YW5fcHRlX2JhdGNoX2NvdW50KHZtYSwgcHRlcCwgJnB0ZSwgbWF4X25yLCAwKTsNCj4gPiAgIH0N
Cj4gPg0KPiA+ICAgc3RhdGljIGludCBtb3ZlX3B0ZXMoc3RydWN0IHBhZ2V0YWJsZV9tb3ZlX2Nv
bnRyb2wgKnBtYywNCj4gPiAgIAkJdW5zaWduZWQgbG9uZyBleHRlbnQsIHBtZF90ICpvbGRfcG1k
LCBwbWRfdCAqbmV3X3BtZCkNCj4gPiAgIHsNCj4gPiBAQCAtMjc4LDExICsyNjgsMTEgQEAgc3Rh
dGljIGludCBtb3ZlX3B0ZXMoc3RydWN0DQo+IHBhZ2V0YWJsZV9tb3ZlX2NvbnRyb2wgKnBtYywN
Cj4gPiAgIAkJICogbWFrZSBzdXJlIHRoZSBwaHlzaWNhbCBwYWdlIHN0YXlzIHZhbGlkIHVudGls
DQo+ID4gICAJCSAqIHRoZSBUTEIgZW50cnkgZm9yIHRoZSBvbGQgbWFwcGluZyBoYXMgYmVlbg0K
PiA+ICAgCQkgKiBmbHVzaGVkLg0KPiA+ICAgCQkgKi8NCj4gPiAgIAkJaWYgKHB0ZV9wcmVzZW50
KG9sZF9wdGUpKSB7DQo+ID4gLQkJCW5yX3B0ZXMgPSBtcmVtYXBfZm9saW9fcHRlX2JhdGNoKHZt
YSwgb2xkX2FkZHIsDQo+IG9sZF9wdGVwLA0KPiA+ICsJCQlucl9wdGVzID0gbXJlbWFwX3B0ZV9i
YXRjaCh2bWEsIG9sZF9hZGRyLCBvbGRfcHRlcCwNCj4gPiAgIAkJCQkJCQkgb2xkX3B0ZSwNCj4g
bWF4X25yX3B0ZXMpOw0KPiA+ICAgCQkJZm9yY2VfZmx1c2ggPSB0cnVlOw0KPiA+ICAgCQl9DQo+
ID4gICAJCXB0ZSA9IGdldF9hbmRfY2xlYXJfcHRlcyhtbSwgb2xkX2FkZHIsIG9sZF9wdGVwLCBu
cl9wdGVzKTsNCj4gDQo+IGdldF9hbmRfY2xlYXJfcHRlcygpIGRvY3VtZW50czogIkNsZWFyIHBy
ZXNlbnQgUFRFcyB0aGF0IG1hcCBjb25zZWN1dGl2ZQ0KPiBwYWdlcyBvZiB0aGUgc2FtZSBmb2xp
bywgY29sbGVjdGluZyBkaXJ0eS9hY2Nlc3NlZCBiaXRzLiINCg0KT2gsIGdvb2QgY2F0Y2guIE15
IGZvY3VzIHdhcyBzb2xlbHkgb24gdGhlIGltcGxlbWVudGF0aW9ucyBvZiBnZXRfYW5kX2NsZWFy
X3B0ZXMoKQ0KYW5kIHNldF9wdGVzKCkgYW5kIHJlZ2FyZGluZyB0aGVpciBtdWx0aS1mb2xpbyBQ
VEVzIGhhbmRsaW5nLCBhbmQgSSBtaXNzZWQgdGhpcyBjb21tZW50Lg0KZ2V0X2FuZF9jbGVhcl9w
dGVzKCkgd2lsbCBjb2xsZWN0IGRpcnR5L2FjY2Vzc2VkIGJpdHMgaW4gYmF0Y2ggcmFuZ2VzLCBh
bmQgc2V0IGluIGxhdGVyLg0KDQo+IA0KPiBBbmQgYXMgY2FuX3B0ZV9iYXRjaF9jb3VudCgpIHdp
bGwgbWVyZ2UgYWNjZXNzL2RpcnR5IGJpdHMsIHlvdSB3b3VsZCBzaWxlbnRseQ0KPiBzZXQgcHRl
cyBkaXJ0eS9hY2Nlc3NlZCB0aGF0IGJlbG9uZyB0byBvdGhlciBmb2xpb3MsIHdoaWNoIHNvdW5k
cyB2ZXJ5IHdyb25nLg0KDQpZZWFyLCB5b3VyIGFuYWx5c2lzIGlzIHZlcnkgdGhvcm91Z2guIFRo
ZSBhY2Nlc3MvZGlydHkgYml0IHdpbGwgYmUgbWVyZ2VkIGJldHdlZW4NCm5laWdoYm9yaW5nIGJh
dGNoZWQgZm9saW9zIGR1ZSB0byBnZXRfYW5kX2NsZWFyX3B0ZXMoKS4NCg0KSWYgY2FsbGVyIGRv
bid0IHdhbnQgdG8gbWVyZ2UgYWNjZXNzL2RpcnR5IGJpdHMgYmV0d2VlbiBmb2xpb3MobWVhbnMg
bm90IGlnbm9yZSBhbnkgYml0cyksIA0KdGhleSBzaG91bGQgY2FsbCBmb2xpb19wdGVfYmF0Y2go
KSBvciB0aGUgbmV3IGludGVyZmFjZSB3aXRoICdmbGFnIHwgRlBCX1JFU1BFQ1RfRElSVFkgJw0K
KGFjY2VzcyBiaXQgaXMgZGVmYXVsdCBiZSByZXNwZWN0ZWQpLg0KDQo+IA0KPiBTdGFyaW5nIGF0
IHRoZSBjb2RlLCBJIHdvbmRlciBpZiB0aGVyZSBpcyBhbHNvIGEgcHJvYmxlbSB3aXRoIHRoZSB3
cml0ZSBiaXQsIGhhdmUNCj4gdG8gZGlnIGludG8gdGhhdC4NCg0KVGhlIHdyaXRlIGJpdCBpcyBo
YW5kbGVkIHNpbWlsYXJseSB0byBkaXJ0eSBiaXQuIElmIGNhbGxlZCBkb24ndCB3YW50IG1lcmdl
IHdyaXRlIGJldHdlZW4gZm9saW9zLCB3ZQ0KY291bGQgY2FsbCB0aGUgbmV3IGludGVyZmFjZSB3
aXRoICdmbGFnIHwgRlBCX1JFU1BFQ1RfV1JJVEUnLCBhbmQgcHRlX3NhbWUoKSB3aWxsIGNvbXBh
cmUgdGhlIHdyaXRlIGJpdA0Kd2l0aCB0aGUgbmV4dCBuZWlnaGJvcmluZyBmb2xpbyBwdGUuICBJ
ZiBpdCdzIGRpZmZlcmVudCwgaXQgd2lsbCBicmVhay4NCg0KVGhhbmtzIGZvciB0aGUgaW4tZGVw
dGggcmV2aWV3Lg0KIA0KPiAtLQ0KPiBDaGVlcnMNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCj4g
DQoNCg==

