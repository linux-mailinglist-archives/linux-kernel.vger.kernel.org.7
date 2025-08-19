Return-Path: <linux-kernel+bounces-775174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBCB2BC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01C36218A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130B31159E;
	Tue, 19 Aug 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="JCB96BB3"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A32356D9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593266; cv=none; b=HveP2RZH7sdsrR9jjMpgR3Z0DlJxJdjcll0p4JDUaKv+WX7dJIU5oAzoY0b55Qqz10B0f0VXjXTlpPS5lD7mYDVXntvb/Xb6jsfcr0ZmGMWg8m9L4/lrjodxtEXJRMlRG9sjz6hrZVEZG3Kqtn2arXd058Sopu7FWpyudeZ9EcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593266; c=relaxed/simple;
	bh=c8TLVCf/XaiGANPAEjKQcZnNaYJfBs0hRcqL6Bzwktc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f210+VVXB1atpfl6wT2R1vMaYQad735AnMLWV+09fZbmeVq8ir5Iv4YL0G7fBi+EVMN2ZYi7RHBVJ0/aZEMqO7Gq+WjhKHH3oOEJO7/odUejL89BCy2CKUybeiTjMqosntoNzHxaaNVN6DUm00INr4YSLPWX/EOItKSBQqQUEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=JCB96BB3; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=c8TLVCf/XaiGANPAEjKQcZnNaYJfBs0hRcqL6Bzwktc=;
	b=JCB96BB3toIHFw4m8v85oXICffxYrX6C7HKrUQMP8M99n+jBUAMDv9V61Y0sPg1TKCpv+gU2D
	8yHyiBObj2RpmscXUrWTE1BcakSsHZOXAdKw6TOnFx3xiwW+58S1vSWFJceUIb/X2T8UcgCqV6N
	8rHxOpCuT0Hu3qi9q87A9bs=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c5jrf3h9rzYl0Ts;
	Tue, 19 Aug 2025 16:47:30 +0800 (CST)
Received: from a002.hihonor.com (10.68.31.193) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 16:47:38 +0800
Received: from a008.hihonor.com (10.68.30.56) by a002.hihonor.com
 (10.68.31.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 16:47:38 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Tue, 19 Aug 2025 16:47:38 +0800
From: liuwenfang <liuwenfang@honor.com>
To: 'Peter Zijlstra' <peterz@infradead.org>
CC: 'Tejun Heo' <tj@kernel.org>, 'David Vernet' <void@manifault.com>, "'Andrea
 Righi'" <arighi@nvidia.com>, 'Changwoo Min' <changwoo@igalia.com>, "'Ingo
 Molnar'" <mingo@redhat.com>, 'Juri Lelli' <juri.lelli@redhat.com>, "'Vincent
 Guittot'" <vincent.guittot@linaro.org>, 'Dietmar Eggemann'
	<dietmar.eggemann@arm.com>, 'Steven Rostedt' <rostedt@goodmis.org>, "'Ben
 Segall'" <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>, "'Valentin
 Schneider'" <vschneid@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHY0IDIvM10gc2NoZWRfZXh0OiBGaXggY3B1X3JlbGVh?=
 =?gb2312?B?c2VkIHdoaWxlIFJUIHRhc2sgYW5kIFNDWCB0YXNrIGFyZSBzY2hlZHVsZWQg?=
 =?gb2312?Q?concurrently?=
Thread-Topic: [PATCH v4 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Thread-Index: AQHcENZFVI9sGoAmCEa/zVuJHh+AELRpE0YAgACMy4A=
Date: Tue, 19 Aug 2025 08:47:38 +0000
Message-ID: <55d707b1f4e1478ea19b022e60805b98@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
	<aFmwHzO2AKFXO_YS@slm.duckdns.org>
	<ced96acd54644325b77c2d8f9fcda658@honor.com>
	<aHltRzhQjwPsGovj@slm.duckdns.org>
	<0144ab66963248cf8587c47bf900aabb@honor.com>
	<814bebd2ad844b08993836fd8e7274b8@honor.com>
	<228ebd9e6ed3437996dffe15735a9caa@honor.com>
	<8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
 <20250819074736.GD3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250819074736.GD3245006@noisy.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
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

SGVsbG8sDQo+IENvdWxkIHlvdSBwbGVhc2Ugbm90IHRocmVhZCB5b3VyIG5ldyBwYXRjaGVzIG9u
dG8gdGhlIG9sZCB0aHJlYWQ/IFRoYXQgbWFrZXMNCj4gdGhlbSBuZWFyIGltcG9zc2libGUgdG8g
ZmluZC4NCkkgd2lsbCB0cnkgdG8gZml4IGl0IGxhdGVyLg0KPiANCj4gT24gVHVlLCBBdWcgMTks
IDIwMjUgYXQgMDY6NTU6MzhBTSArMDAwMCwgbGl1d2VuZmFuZyB3cm90ZToNCj4gPiBTdXBwb3Nl
ZCBSVCB0YXNrKFJUMSkgaXMgcnVubmluZyBvbiBDUFUwIGFuZCBSVCB0YXNrKFJUMikgaXMgYXdh
a2VuZWQNCj4gPiBvbiBDUFUxLA0KPiA+IFJUMSBiZWNvbWVzIHNsZWVwIGFuZCBTQ1ggdGFzayhT
Q1gxKSB3aWxsIGJlIGRpc3BhdGNoZWQgdG8gQ1BVMCwgUlQyDQo+ID4gd2lsbCBiZSBwbGFjZWQg
b24gQ1BVMDoNCj4gPg0KPiA+IENQVTAoc2NoZWR1bGUpDQo+IENQVTEodHJ5X3RvX3dha2VfdXAp
DQo+ID4gc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19JTlRFUlJVUFRJQkxFKSAgICAgICAgICAgICAg
dHJ5X3RvX3dha2VfdXAgIw0KPiBSVDINCj4gPiBfX3NjaGVkdWxlDQo+IHNlbGVjdF90YXNrX3Jx
ICMgQ1BVMCBpcyBzZWxlY3RlZA0KPiA+IExPQ0sgcnEoMCktPmxvY2sgIyBsb2NrIENQVTAgcnEg
ICAgICAgICAgICAgICAgICAgICAgICB0dHd1X3F1ZXVlDQo+ID4gICBkZWFjdGl2YXRlX3Rhc2sg
IyBSVDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTE9DSw0KPiBycSgwKS0+bG9j
ayAjIGJ1c3kgd2FpdGluZw0KPiA+ICAgICBwaWNrX25leHRfdGFzayAjIG5vIG1vcmUgUlQgdGFz
a3Mgb24gcnEgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICBwcmV2X2JhbGFuY2UgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICBiYWxhbmNl
X3NjeCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAg
ICAgICBiYWxhbmNlX29uZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwN
Cj4gPiAgICAgICAgICAgICBycS0+c2N4LmNwdV9yZWxlYXNlZCA9IGZhbHNlOyAgICAgICAgICAg
ICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICBjb25zdW1lX2dsb2JhbF9kc3EgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICBjb25zdW1lX2Rpc3BhdGNo
X3EgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICBjb25z
dW1lX3JlbW90ZV90YXNrICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAg
ICAgICAgICBVTkxPQ0sgcnEoMCktPmxvY2sgICAgICAgICAgICAgICAgICAgICAgVg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIExP
Q0sNCj4gcnEoMCktPmxvY2sgIyBzdWNjDQo+ID4gICAgICAgICAgICAgICAgICAgICBkZWFjdGl2
YXRlX3Rhc2sgIyBTQ1gxDQo+IHR0d3VfZG9fYWN0aXZhdGUNCj4gPiAgICAgICAgICAgICAgICAg
ICAgIExPQ0sgcnEoMCktPmxvY2sgIyBidXN5IHdhaXRpbmcgICAgICBhY3RpdmF0ZV90YXNrDQo+
ICMgUlQyIGVxdWV1ZWQNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gVU5MT0NLIHJx
KDApLT5sb2NrDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBWDQo+ID4gICAgICAgICAgICAg
ICAgICAgICBMT0NLIHJxKDApLT5sb2NrICMgc3VjYw0KPiA+ICAgICAgICAgICAgICAgICAgICAg
YWN0aXZhdGVfdGFzayAjIFNDWDENCj4gPiAgICAgICBwaWNrX3Rhc2sgIyBSVDIgaXMgcGlja2Vk
DQo+ID4gICAgICAgcHV0X3ByZXZfc2V0X25leHRfdGFzayAjIHByZXYgaXMgUlQxLCBuZXh0IGlz
IFJUMiwNCj4gPiBycS0+c2N4LmNwdV9yZWxlYXNlZCA9IGZhbHNlOyBVTkxPQ0sgcnEoMCktPmxv
Y2sNCj4gPg0KPiA+IEF0IGxhc3QsIFJUMiB3aWxsIGJlIHJ1bm5pbmcgb24gQ1BVMCB3aXRoIHJx
LT5zY3guY3B1X3JlbGVhc2VkIGJlaW5nDQo+ID4gZmFsc2UsIHdoaWNoIHdvdWxkIGxlYWQgdGhl
IEJQRiBzY2hlZHVsZXIgdG8gbWFrZSBkZWNpc2lvbnMgaW1wcm9wZXJseS4NCj4gPg0KPiA+IFNv
LCBjaGVjayB0aGUgc2NoZWQgY2xhc3MgaW4gX19wdXRfcHJldl9zZXRfbmV4dF9zY3goKSB0byBm
aXggdGhlDQo+ID4gdmFsdWUgb2YNCj4gPiBycS0+c2N4LmNwdV9yZWxlYXNlZC4NCj4gDQo+IE9o
IGdhd2QsIHRoaXMgaXMgdGVycmlibGUuDQo+IA0KPiBXaHkgd291bGQgeW91IHN0YXJ0IHRoZSBw
aWNrIGluIGJhbGFuY2UgYW5kIHRoZW4gY3J5IHdoZW4geW91IGZhaWwgdGhlIHBpY2sgaW4NCj4g
cGljayA/IT8NCj4gDQo+IFRoaXMgaXMgYWxzbyB0aGUgcmVhc29uIHlvdSBuZWVkIHRoYXQgd2Vp
cmQgQ0xBU1NfRVhUIGV4Y2VwdGlvbiBpbg0KPiBwcmV2X2JhbGFuY2UoKSwgaXNuJ3QgaXQ/DQpZ
ZWFoLCB5b3UgYXJlIHJpZ2h0LCBiZWNhdXNlIHRoZXJlIGlzIHRhc2sgbWlncmF0aW9uIGluIG91
ciBleGNlcHRpb24gcHJvY2Vzcy4NCj4gDQo+IFlvdSdyZSBub3cgYXNraW5nIGZvciBhIDNyZCBj
YWxsIG91dCB0byBkbyBzb21ldGhpbmcgbGlrZToNCj4gDQo+ICAgLT5iYWxhbmNlKCkgLS0gcmVh
ZHkgYSB0YXNrIGZvciBwaWNrDQpXZSBtdXN0IGNsYXJpZnkgdGhhdCB0aGUgdGFyZ2V0IFNDWCB0
YXNrIGlzIGN1cnJlbnRseSBsb2NhdGVkIGluIHRoZSBnbG9iYWwgcXVldWUsIGFuZCBpdCdzIENQ
VSBzZWxlY3Rpb24gbWF5YmUgQ1BVMiwNCndoZW4gdGhlIGN1cnJlbnQgQ1BVMCB3aWxsIGJlIGlk
bGUsIHRoaXMgU0NYIHRhc2sgc2hvdWxkIGJlIG1pZ3JhdGVkIHRvIENQVTAuDQo+ICAgLT5waWNr
KCkgLS0gcGlja3MgYSByYW5kb20gb3RoZXIgdGFzaw0KVGhlIHJxIGxvY2sgb2YgQ1BVMCB3aWxs
IGJlIHJlbGVhc2VkIGR1cmluZyB0YXNrIG1pZ3JhdGlvbiwgYW5kIGhpZ2hlciBwcmlvcml0eSB0
YXNrIHdpbGwgYmUgcGxhY2VkIG9uIENQVTAgcnEsDQpTbyB0aGUgQ1BVMCB3aWxsIG5vdCBhbHdh
eXMgcGljayB0aGUgdGFyZ2V0IFNDWCB0YXNrIHRpbWVseS4NCj4gICAtPnB1dF9wcmV2KCkgLS0g
b29wcywgb3VyIHRhc2sgZGlkbid0IGdldCBwaWNrZWQsIHN0aWNrIGl0IGJhY2sNClRoZSBoaWdo
ZXIgcHJpb3JpdHkgdGFzayBtYXkgY29zdCBhIGxvbmcgdGltZSBvbiBDUFUwLCBzbyB3ZSBuZWVk
IHRvIGdldCB0aGUgU0NYIHRhc2sgYmFjayBmb3IgaXRzIGxvdyBsYXRlbmN5IGRlbWFuZC4gDQo+
IA0KPiBXaGljaCBpcyBibG9vZHkgbHVkaWNyb3VzLiBTbyBuby4gV2UncmUgbm90IGRvaW5nIHRo
aXMuDQo+IA0KPiBXaHkgY2FuJ3QgcGljayBEVFJUID8NClRoaXMncyB3aHkgdGhlIENQVTAgY2Fu
bm90IHBpY2sgb25lIFNDWCB0YXNrIGRpcmVjdGx5IHdoaWNoIHRhc2tfY3B1KCkgaXMgbm90IENQ
VTAuDQo=

