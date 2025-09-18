Return-Path: <linux-kernel+bounces-796531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913B7B401F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7431883C17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30F2D7398;
	Tue,  2 Sep 2025 13:04:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F52D4801
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818297; cv=none; b=Lh1YuCs+P+J4DqTLsksoe67AZ9qZmUFsMLfZmYoH4CSNFfGjyqIdS7YnsE40q6+mfVW1mOHdBzAbvRWbNcHzILJGiM/9ojp+xkwLA6G6yLPpGczD28xY0kC6vRcsnLp6/YhemFDVKRu/QnYJVoN6QSWvYXSD1wHLKERT5/pvm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818297; c=relaxed/simple;
	bh=9S5ggAris22eza8Vgn21ReT2ZYzJGB8tbqQzEXCN4Pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Te/Xdn5aDgeLNBgiZXop0flEjgJB/3A2Y9R/mDCZtC5EsODxtH0CeKo76w1U5XqeoYztmSaHBsKXN0Hnx7PjPtZg5SiuPQSY0gJCQ38ndXrqYvGYBXLiIT3Iu6LRB8Vla+AdV6zVum4QfVVipzW3YAslBwUydkewKnVxcuRmW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cGQpj3BfPz13NTJ;
	Tue,  2 Sep 2025 21:01:01 +0800 (CST)
Received: from kwepemj200002.china.huawei.com (unknown [7.202.194.14])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E7C1140202;
	Tue,  2 Sep 2025 21:04:51 +0800 (CST)
Received: from kwepemj100003.china.huawei.com (7.202.195.248) by
 kwepemj200002.china.huawei.com (7.202.194.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Sep 2025 21:04:51 +0800
Received: from kwepemj100003.china.huawei.com ([7.202.195.248]) by
 kwepemj100003.china.huawei.com ([7.202.195.248]) with mapi id 15.02.1544.011;
 Tue, 2 Sep 2025 21:04:51 +0800
From: Zhangyuhao <yuhao.zhang@huawei.com>
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard
	<jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: Issues with Pinning User Pages for SVA on IOMMUs Lacking IOPF
Thread-Topic: Issues with Pinning User Pages for SVA on IOMMUs Lacking IOPF
Thread-Index: AdwbQ8jtyLdUfE4eSeWgQaAe9dULRf//jTWA//4BcbA=
Date: Tue, 2 Sep 2025 13:04:51 +0000
Message-ID: <54be598d93404e7185ecfbe49f7fe93c@huawei.com>
References: <08c869037c6d4bd2bd9bc5e2bcfb7e7c@huawei.com>
 <fc37388a-dc09-4a71-bd79-c0d09e482c21@redhat.com>
In-Reply-To: <fc37388a-dc09-4a71-bd79-c0d09e482c21@redhat.com>
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

W0FkZGluZyBsaW51eC1rZXJuZWwgbWFpbGluZyBsaXN0IGZvciB2aXNpYmlsaXR5XQ0KDQpCZXN0
LA0KWXVoYW8NCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYXZpZCBIaWxkZW5i
cmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gDQpTZW50OiBNb25kYXksIFNlcHRlbWJlciAxLCAyMDI1
IDEwOjM0IFBNDQpUbzogWmhhbmd5dWhhbyA8eXVoYW8uemhhbmdAaHVhd2VpLmNvbT47IEFuZHJl
dyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBKYXNvbiBHdW50aG9ycGUgPGpn
Z0B6aWVwZS5jYT47IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT47IFBldGVyIFh1
IDxwZXRlcnhAcmVkaGF0LmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgV2ls
bCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFy
bS5jb20+DQpTdWJqZWN0OiBSZTogSXNzdWVzIHdpdGggUGlubmluZyBVc2VyIFBhZ2VzIGZvciBT
VkEgb24gSU9NTVVzIExhY2tpbmcgSU9QRg0KDQpPbiAwMS4wOS4yNSAxNTo0MywgWmhhbmd5dWhh
byB3cm90ZToNCj4gSGVsbG8gTGludXgga2VybmVsIGNvbW11bml0eSwNCg0KSGksDQoNCj4gDQo+
IEN1cnJlbnQgSU9NTVUgU1ZBIHN1cHBvcnQgcmVsaWVzIG9uIGhhcmR3YXJlIElPUEYgKElPIFBh
Z2UgRmF1bHQpLiBXZSBoYXZlIG9ic2VydmVkIHRoYXQgY2VydGFpbiBJT01NVSBkZXZpY2VzIGRv
IG5vdCBzdXBwb3J0IElPUEYuDQo+IEJ1dCBXZSBhcmUgc3RpbGwgZXhwbG9yaW5nIGhvdyB0byBl
bmFibGUgU1ZBIGluIHN1Y2ggc2NlbmFyaW9zLg0KPiANCj4gVG8gYWRkcmVzcyB0aGlzLCB3ZSBh
dHRlbXB0ZWQgdG8gcGluIG1lbW9yeSB0byBwcmV2ZW50IGRldmljZSBhY2Nlc3NlcyBmcm9tIHRy
aWdnZXJpbmcgSU8gcGFnZSBmYXVsdHMuDQo+IA0KPiBTb2x1dGlvbiAxOiBVc2VyLXNwYWNlIG1s
b2NrICsgbWFkdmlzZShNQURWX1BPUFVMQVRFX1dSSVRFKQ0KPiANCj4gaWYgKG1hZHZpc2UoYnVm
LCBzaXplLCBNQURWX1BPUFVMQVRFX1dSSVRFKSAhPSAwKSB7DQo+ICAgICAgZnJlZShidWYpOw0K
PiAgICAgIHJldHVybiAxOw0KPiB9DQo+IGlmIChtbG9jayhidWYsIHNpemUpICE9IDApIHsNCj4g
ICAgICBmcmVlKGJ1Zik7DQo+ICAgICAgcmV0dXJuIDE7DQo+IH0NCj4gUmVzdWx0OiBQYWdlIGZh
dWx0cyBzdGlsbCBvY2N1cnJlZCBkdWUgdG8gcGFnZSBtaWdyYXRpb24uDQoNClllcywgTlVNQS1o
aW50aW5nIG1pZ2h0IHNpbWlsYXJseSBhZmZlY3QgdGhpcyAoZXZlbiB3aGVuIHBhZ2Ugbm90IG1p
Z3JhdGVkKS4NCg0KPiANCj4gU29sdXRpb24gMjogS2VybmVsLXNwYWNlIHBpbiB2aWEgSU9DVEwN
Cj4gDQo+IHJldCA9IHBpbl91c2VyX3BhZ2VzX2Zhc3QoY3VyX2Jhc2UsIG5wYWdlcywgRk9MTF9M
T05HVEVSTSwgcGFnZV9saXN0KTsNCj4gDQo+IFJlc3VsdDogUGFnZSBmYXVsdHMgb2NjdXJyZWQg
b2NjYXNpb25hbGx5LCB0cmFjZWQgdG8gTlVNQSBiYWxhbmNpbmcgbWFya2luZyBwYWdlcyBhcyBp
bnZhbGlkLg0KDQpBaCwgdGhlcmUgeW91IHRhbGsgYWJvdXQgTlVNQSBiYWxhbmNpbmcuDQoNCj4g
DQo+IFRvIHNvbHZlIHRoZSBwcm9ibGVtLCB3ZSB1c2VkIEZPTExfTE9OR1RFUk0gfCBGT0xMX0hP
Tk9SX05VTUFfRkFVTFQgdG8gcGluIHVzZXIgcGFnZXMuDQo+IA0KDQpTZWUgcHJvdF9udW1hX3Nr
aXAoKTogd2Ugc2tpcCBETUEtcGlubmVkIGZvbGlvcyBpbiBDT1cgbWFwcGluZ3Mgb25seS4gU28g
SWYgeW91IHdvdWxkIGhhdmUgYSAhQ09XIG1hcHBpbmcgKGUuZy4sIE1BUF9TSEFSRUQgc2htZW0p
LCB0aGF0IHdvdWxkbid0IHdvcmsgcmVsaWFibHkgSSB0aGluay4NCg0KSSB0aGluayB3ZSBjb3Vs
ZCBjaGFuZ2UgdGhhdCB3aXRob3V0IGNhdXNpbmcgdG9vIG11Y2ggaGFybS4NCg0KZGlmZiAtLWdp
dCBhL21tL21wcm90ZWN0LmMgYi9tbS9tcHJvdGVjdC5jIGluZGV4IDExM2I0ODk4NTgzNDEuLjE3
ODA5Yzg2MDRmMjUgMTAwNjQ0DQotLS0gYS9tbS9tcHJvdGVjdC5jDQorKysgYi9tbS9tcHJvdGVj
dC5jDQpAQCAtMTM3LDggKzEzNywxMSBAQCBzdGF0aWMgYm9vbCBwcm90X251bWFfc2tpcChzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBhZGRyLA0KICAgICAgICAgICAg
ICAgICBnb3RvIHNraXA7DQogIA0KICAgICAgICAgLyogQWxzbyBza2lwIHNoYXJlZCBjb3B5LW9u
LXdyaXRlIHBhZ2VzICovDQotICAgICAgIGlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdz
KSAmJg0KLSAgICAgICAgICAgKGZvbGlvX21heWJlX2RtYV9waW5uZWQoZm9saW8pIHx8IGZvbGlv
X21heWJlX21hcHBlZF9zaGFyZWQoZm9saW8pKSkNCisgICAgICAgaWYgKGlzX2Nvd19tYXBwaW5n
KHZtYS0+dm1fZmxhZ3MpICYmIGZvbGlvX21heWJlX21hcHBlZF9zaGFyZWQoZm9saW8pKQ0KKyAg
ICAgICAgICAgICAgIGdvdG8gc2tpcDsNCisNCisgICAgICAgLyogRm9saW9zIHRoYXQgYXJlIHBp
bm5lZCBhbmQgY2Fubm90IGJlIG1pZ3JhdGVkIGVpdGhlciB3YXkuICovDQorICAgICAgIGlmIChm
b2xpb19tYXliZV9kbWFfcGlubmVkKGZvbGlvKSkNCiAgICAgICAgICAgICAgICAgZ290byBza2lw
Ow0KICANCiAgICAgICAgIC8qDQoNCg0KPiBUaGlzIGFwcHJvYWNoIGhhcyBiZWVuIHRlc3RlZCBh
bmQgc3VjY2Vzc2Z1bGx5IHByZXZlbnRzIElPIHBhZ2UgZmF1bHRzIHNvIGZhci4NCj4gDQo+IFdl
IHdvdWxkIGxpa2UgZ3VpZGFuY2UgZnJvbSB0aGUgY29tbXVuaXR5Og0KPiANCj4gQ2FuIHRoaXMg
YXBwcm9hY2ggcmVsaWFibHkgcHJldmVudCBhbGwgSU8gcGFnZSBmYXVsdHM/DQoNClNlZSB0aGUg
Y2FzZSBhYm92ZSByZWdhcmRpbmcgbm9uLWNvdyBtYXBwaW5ncy4NCg0KV2UgZXNzZW50aWFsbHkg
bmVlZCB0byBtYWtlIHN1cmUgdGhhdCB3ZSBkb24ndCAodGVtcG9yYXJpbHkpIHVubWFwIGZvciBt
aWdyYXRpb24vcmVjbGFpbS9zcGxpdC93aGF0ZXZlciBpZiBhIGZvbGlvIG1heWJlIHBpbm5lZC4N
Cg0KV2UgYmFjayBvdXQgaW4gYWxsIGNhc2VzICh1bmV4cGVjdGVkIHJlZmVyZW5jZSksIGJ1dCB3
ZSdsbCBoYXZlIHRvIHNhbml0eS1jaGVjayB3aGV0aGVyIHdlIHJlamVjdCBtYXliZV9waW5uZWQg
Zm9saW9zIGVhcmx5IHRvIG5vdCB0ZW1wb3JhcmlseSB1bm1hcC4NCg0KPiANCj4gSXMgdGhlcmUg
YSBiZXR0ZXIgb3IgcmVjb21tZW5kZWQgbWV0aG9kIHRvIHBpbiB1c2VyIHBhZ2VzIGZvciBTVkE/
DQoNCk1vc3QgdXNlIGNhc2VzIHVzZSBsb25ndGVybSBwaW5uaW5ncyB0byB0aGVuIGNvbmZpZ3Vy
ZSB0aGUgaW9tbXUgbWFudWFsbHkuIFRoZW4sIGl0IGRvZXMgbm90IHJlYWxseSBtYXR0ZXIgd2hh
dCBoYXBwZW5zIHRvIHlvdXIgcHJvY2VzcyBwYWdlIHRhYmxlcy4NCg0KU28geW91ciB1c2UgY2Fz
ZSBpcyByYXRoZXIgbmV3IDopDQoNCkJ1dCB5ZXMsIGEgbG9uZ2VybSBwaW5uaW5nIHdoaWxlIHJl
c29sdmluZyBOVU1BLWhpdG5pbmcgZmF1bHRzIHNob3VsZCBpbiB0aGVvcnkgd29yay4NCg0KV2Ug
anVzdCBoYXZlIHRvIG1ha2Ugc3VyZSB0aGF0IGV2ZXJ5Ym9keSBlbHNlIHBsYXlzIG5pY2UgZWFy
bHkgd2l0aCBkbWEtcGlubmVkIGZvbGlvcy4NCg0KLS0NCkNoZWVycw0KDQpEYXZpZCAvIGRoaWxk
ZW5iDQoNCg0K

