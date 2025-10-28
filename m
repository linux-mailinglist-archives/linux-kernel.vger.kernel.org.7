Return-Path: <linux-kernel+bounces-873668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB2C14621
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5001D18841C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B673081C6;
	Tue, 28 Oct 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oSyA08+J"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E027FB2B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651158; cv=none; b=R4hxt+jD6UMC1g9GCKNEloM1TxLLJtGC4RDGjuFRrYdJwgIRm873TNUse1GlUB2QaUziCQHcT2ILjCLFMpKX6vcSQwaucSS1qyVH3RPefZP2kSStGet8R/n1NT6w2cYty/o8TnRcygdbk7rZjVmEzkFibV4Jdwjfwt8IOl4vq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651158; c=relaxed/simple;
	bh=/79zVvk1KSb/1ysL0Z+zygitKh9g9fDoyZAQOQU3Vq8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pwtG7T+qijNY9g1q1Haa8vV9cP89h677A03rQhjBBPIY1LP+RLrick4rty3CRnwWx0mtrT8d5UkVrr7FIc/F5SNq3bbTiqmNKdYKdFOWA7Eazzjn9SGWlC194FXDcwwtq4w4tP68bjnoAOSxjePAZsfay36d/8dx2e1eTpBgySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oSyA08+J; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/79zVvk1KSb/1ysL0Z+zygitKh9g9fDoyZAQOQU3Vq8=;
	b=oSyA08+J90SDBadgg1pwlhIFpD0CZu5RDDWLekG9xYWktMBBtqTpwbn/a7fyU3PIcD26un8KR
	xEKNLfiqyTyWpHx1IjpOsxke0p6R09t4NHEkSTeESybB+v0rVe4QHlMU5CX0MJCP4TRH3V1z9PM
	EJEl42XK+UtjQtpndVQlfVw=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cwpBC0MWPz1prLt;
	Tue, 28 Oct 2025 19:32:03 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id C18F11401F4;
	Tue, 28 Oct 2025 19:32:31 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (7.185.36.8) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 19:32:31 +0800
Received: from dggpemf500012.china.huawei.com ([7.185.36.8]) by
 dggpemf500012.china.huawei.com ([7.185.36.8]) with mapi id 15.02.1544.011;
 Tue, 28 Oct 2025 19:32:31 +0800
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
Subject: Re: [RFC PATCH 2/3] mm/mincore: Use can_pte_batch_count() in
 mincore_pte_range() for pte batch mincore_pte_range()
Thread-Topic: [RFC PATCH 2/3] mm/mincore: Use can_pte_batch_count() in
 mincore_pte_range() for pte batch mincore_pte_range()
Thread-Index: AdxH/BcTwK17Rhx6T1qkj45y9MTgGg==
Date: Tue, 28 Oct 2025 11:32:31 +0000
Message-ID: <1cd515972cbd4be9ac8b5abb635c052a@huawei.com>
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

PiBPbiAyNy4xMC4yNSAxNTowMywgWmhhbmcgUWlsb25nIHdyb3RlOg0KPiA+IEluIGN1cnJlbnQg
bWluY29yZV9wdGVfcmFuZ2UoKSwgaWYgcHRlX2JhdGNoX2hpbnQoKSByZXR1cm4gb25lIHB0ZSwN
Cj4gPiBpdCdzIG5vdCBlZmZpY2llbnQsIGp1c3QgY2FsbCBuZXcgYWRkZWQgY2FuX3B0ZV9iYXRj
aF9jb3VudCgpLg0KPiA+DQo+ID4gSW4gQVJNNjQgcWVtdSwgd2l0aCA4IENQVXMsIDMyRyBtZW1v
cnksIGEgc2ltcGxlIHRlc3QgZGVtbyBsaWtlOg0KPiA+IDEuIG1tYXAgMUcgYW5vbiBtZW1vcnkN
Cj4gPiAyLiB3cml0ZSAxRyBkYXRhIGJ5IDRrIHN0ZXANCj4gPiAzLiBtaW5jb3JlIHRoZSBtbWFw
ZWQgMUcgbWVtb3J5DQo+ID4gNC4gZ2V0IHRoZSB0aW1lIGNvbnN1bWVkIGJ5IG1pbmNvcmUNCj4g
Pg0KPiA+IFRlc3RlZCB0aGUgZm9sbG93aW5nIGNhc2VzOg0KPiA+ICAgLSA0aywgZGlzYWJsZWQg
YWxsIGh1Z2VwYWdlIHNldHRpbmcuDQo+ID4gICAtIDY0ayBtVEhQLCBvbmx5IGVuYWJsZSA2NGsg
aHVnZXBhZ2Ugc2V0dGluZy4NCj4gPg0KPiA+IEJlZm9yZQ0KPiA+DQo+ID4gQ2FzZSBzdGF0dXMg
fCBDb25zdW1lZCB0aW1lICh1cykgIHwNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tfA0KPiA+IDRrICAgICAgICAgIHwgNzM1NiAgICAgICAgICAgICAgICB8DQo+ID4gNjRr
IG1USFAgICAgfCAzNjcwICAgICAgICAgICAgICAgIHwNCj4gPg0KPiA+IFBhdGhlZDoNCj4gPg0K
PiA+IENhc2Ugc3RhdHVzIHwgQ29uc3VtZWQgdGltZSAodXMpICB8DQo+ID4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gPiA0ayAgICAgICAgICB8IDQ0MTkgICAgICAgICAg
ICAgICAgfA0KPiA+IDY0ayBtVEhQICAgIHwgMzA2MSAgICAgICAgICAgICAgICB8DQo+ID4NCj4g
DQo+IEkgYXNzdW1lIHlvdSdyZSBvbmx5IGx1Y2t5IGluIHRoYXQgYmVuY2htYXJrIGJlY2F1c2Ug
eW91IGdvdCBjb25zZWN1dGl2ZSA0aw0KPiBwYWdlcyAvIDY0ayBtVEhQIGZyb20gdGhlIGJ1ZGR5
LCByaWdodD8NCg0KWWVhciwgdGhlIGRlbW8gY2FzZSBpcyByZWxhdGl2ZWx5IHNpbXBsZSwgd2hp
Y2ggbWF5IHJlc3VsdCBpbiBzdHJvbmdlciBjb250aW51aXR5DQpvZiBhbGxvY2F0ZWQgcGh5c2lj
YWwgcGFnZSBhZGRyZXNzZXMuIA0KVGhpcyBjYXNlIHByaW1hcmlseSBhaW1zIHRvIHZhbGlkYXRl
IG9wdGltaXphdGlvbiBlZmZlY3RpdmVuZXNzIGluIGNvbnRpZ3VvdXMgcGFnZQ0KYWRkcmVzcy4g
TWF5YmUgd2UgYWxzbyBuZWVkIHdhdGNoIHNpZGUgZWZmZWN0aXZlbmVzcyBpbiBub24tY29udGln
dW91cyBwYWdlDQphZGRyZXNzLg0KDQo+IA0KPiBTbyBJIHN1c3BlY3QgdGhhdCB0aGlzIHdpbGwg
bW9zdGx5IGp1c3QgbWFrZSBhIG1pY3JvIGJlbmNobWFyayBoYXBweSwgYmVjYXVzZQ0KPiB0aGUg
cmVhbGl0eSB3aGVyZSB3ZSBhbGxvY2F0ZSByYW5kb21seSBvdmVyIHRpbWUsIGZvciB0aGUgUENQ
LCBldGMgd2lsbCBsb29rDQo+IHF1aXRlIGRpZmZlcmVudC4NCj4gDQo+IC0tDQo+IENoZWVycw0K
PiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KPiANCg0K

