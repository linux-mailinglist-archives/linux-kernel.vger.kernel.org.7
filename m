Return-Path: <linux-kernel+bounces-768393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541BB260A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6C11CC0843
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00822EBBB6;
	Thu, 14 Aug 2025 09:13:19 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16D280018
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162799; cv=none; b=jHDUcOM+37kihV9nFg3WdVAVG/BTJlpLR5RJZoW6VnuoDFMMdH2/SJ6SiHXvLCIKh4n/vg6IvR9WHkO+TpMXM9T5IhsUTEfFvtFd6Vs0u6c3Gw5wjqnFwAnwoeA+as18u4N0uSV2pk3shJ6eBGIHh74PdoSatYXNcRUtftutz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162799; c=relaxed/simple;
	bh=Cdh0zTD/t86eAaBCB5KBD/LSSP761qDBJYGWKjhobFA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0UzJjxXy6kGDLdj9p9R2vO0BtAZqCj65/7NCso+qZD2Q5IZur6EdnZfkcMItypb3FNKx6f2Ehc8W9FeG2YNHQLgVgeBq6qQkedNwpnR+R4bcKuiAqA2FYsdDcRmLqQWCRYtq96e0gX2RM37nfvpcZyq/yX4DPpQzX/8IxYrxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: David Hildenbrand <david@redhat.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "osalvador@suse.de" <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIG1tL2h1Z2V0bGI6IGVh?=
 =?utf-8?B?cmx5IGV4aXQgZnJvbSBodWdldGxiX3BhZ2VzX2FsbG9jX2Jvb3QoKSB3aGVu?=
 =?utf-8?B?IG1heF9odWdlX3BhZ2VzPTA=?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gbW0vaHVnZXRsYjogZWFybHkg?=
 =?utf-8?B?ZXhpdCBmcm9tIGh1Z2V0bGJfcGFnZXNfYWxsb2NfYm9vdCgpIHdoZW4gbWF4?=
 =?utf-8?B?X2h1Z2VfcGFnZXM9MA==?=
Thread-Index: AQHcDPWdEVeaWFKf20iTJyL51FqmTLRhVBAAgACIHxA=
Date: Thu, 14 Aug 2025 09:12:06 +0000
Message-ID: <8db5f7f3b66a40af8abf921290db42ab@baidu.com>
References: <20250814082950.2888-1-lirongqing@baidu.com>
 <7e88d01a-10bb-4edb-9010-f9c0bca31a46@redhat.com>
In-Reply-To: <7e88d01a-10bb-4edb-9010-f9c0bca31a46@redhat.com>
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
X-FEAS-Client-IP: 172.31.3.13
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBPbiAxNC4wOC4yNSAxMDoyOSwgbGlyb25ncWluZyB3cm90ZToNCj4gPiBGcm9tOiBMaSBSb25n
UWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4NCj4gPiBPcHRpbWl6ZSBodWdldGxiX3Bh
Z2VzX2FsbG9jX2Jvb3QoKSB0byByZXR1cm4gaW1tZWRpYXRlbHkgd2hlbg0KPiA+IG1heF9odWdl
X3BhZ2VzIGlzIDAsIHNhdmluZyBjeWNsZXMgd2hlbiBodWdlcGFnZXMgYXJlbid0IGNvbmZpZ3Vy
ZWQgaW4NCj4gPiB0aGUga2VybmVsIGNvbW1hbmQgbGluZS4NCj4gDQo+IERvIHdlIHJlYWxseSBj
YXJlPw0KPiANCg0KSSBmaW5kIHRoaXMgd2hlbiBJIHNlZSB0aGUgYm9vdCBsb2csIEkgdGhpbmsg
dGhpcyBsb2cgaXMgdW5uZWNlc3NhcnkgaWYgdXNlciBkaWQgbm90IGNvbmZpZ3VyZSBodWdldGxi
ZnMgaW4ga2VybmVsIGNtZGxpbmUNCg0Ka2VybmVsOiBIdWdlVExCOiBhbGxvY2F0aW9uIHRvb2sg
MG1zIHdpdGggaHVnZXBhZ2VfYWxsb2NhdGlvbl90aHJlYWRzPTMyDQoNCg0KQnINCi1MaQ0KDQo+
IC0tDQo+IENoZWVycw0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=

