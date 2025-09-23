Return-Path: <linux-kernel+bounces-828398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99817B9489F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50191443779
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5633730F7E2;
	Tue, 23 Sep 2025 06:21:04 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B807E105;
	Tue, 23 Sep 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608464; cv=none; b=H6Ccy5tx9offn/WMwuik0ZPlQWaA1GH4l43tdGnaa90GMQbBZsyoY1BdSLsR12EmC9LFVufxzynE0jEMXG7U2OTPTvCIiBntsCks4KUpTgBNfwn9wk7puNHeGvAVDaZlhSjzuExpQAe4LNs2BtF5Olcp0az+zZRMyhINdKzoiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608464; c=relaxed/simple;
	bh=t2UgzLVFmZCwXaKwdxBZY5QQbU7YoHvc7ZF/NcPi84M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sc2d1d6m73MfqpwRbXUw/fqvFAmTAkb0X4LwYNYw7k7pz6PLJu+bco9TKxz2jUTrlS1U+EnRubXcRUd89qB+mmnOGKt2FzZNpAk1V77rWqakEY7PwQfa0OLjYFAEAHlYyKnRd13gaKtDmgnpQaX58mfrVgYO176Ez2+eyh4UYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Lance Yang <lance.yang@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"kees@kernel.org" <kees@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
	"pauld@redhat.com" <pauld@redhat.com>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW1JGQ10gaHVuZ190YXNr?=
 =?utf-8?B?OiBTdXBwb3J0IHRvIHBhbmljIHdoZW4gdGhlIG1heGltdW0gbnVtYmVyIG9m?=
 =?utf-8?Q?_hung_task_warnings_is_reached?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bUkZDXSBodW5nX3Rhc2s6IFN1?=
 =?utf-8?B?cHBvcnQgdG8gcGFuaWMgd2hlbiB0aGUgbWF4aW11bSBudW1iZXIgb2YgaHVu?=
 =?utf-8?Q?g_task_warnings_is_reached?=
Thread-Index: AQHcLD6SwU5buVCi00+LlNrVaU6G67SgOukw//+DxwCAAIyp0A==
Date: Tue, 23 Sep 2025 06:19:44 +0000
Message-ID: <dfab5a3cc8984b56bf2d0d49ff06b47f@baidu.com>
References: <20250923033740.2696-1-lirongqing@baidu.com>
 <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
 <9067a88d-f5df-4d6e-b3b3-2e266ebcf3d0@linux.dev>
 <bbdc2b5c2b374ed1801113148a72d83c@baidu.com>
 <06facb7b-7d1b-44fd-b530-9a5300db7d4c@linux.dev>
In-Reply-To: <06facb7b-7d1b-44fd-b530-9a5300db7d4c@linux.dev>
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

DQo+ID4+ICsxLiBJIGFncmVlIHRoYXQgYSB1c2Vyc3BhY2UgZGV0ZWN0b3Igc2VlbXMgbW9yZSBh
cHByb3ByaWF0ZSBmb3IgdGhpcy4NCj4gPj4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIHVzZXItc3Bh
Y2UgbWF5YmUgZmxleGliaWxpdHksIGJ1dCBpbmN1cnMgcmVsYXRpdmVseSBoaWdoZXIgb3Zlcmhl
YWQNCj4gYW5kIGlzIGxlc3MgcmVsaWFibGUuIFdoZW4gdGhlIHN5c3RlbSBoYW5ncywgdGhpcyB0
YXNrIG1heSBoYXZlIGFscmVhZHkgaHVuZyBhcw0KPiB3ZWxsLg0KPiANCj4gRW1tbS4uLiBpZiB0
aGUgc3lzdGVtIGlzIHNvIGRlZ3JhZGVkIHRoYXQgYSB1c2Vyc3BhY2UgbW9uaXRvciBjYW5ub3Qg
Z2V0DQo+IHNjaGVkdWxlZCwgaXQncyB2ZXJ5IGxpa2VseSB0aGF0IGtodW5ndGFza2QgaXRzZWxm
IGlzIGFsc28gc3RydWdnbGluZyB0byBydW4sIHJpZ2h0Pw0KPiANCg0KWWVzDQoNCi1MaQ0KDQo+
ID4NCj4gPg0KPiA+PiBXZSBhbHJlYWR5IGhhdmUgdGhlIGh1bmdfdGFza19kZXRlY3RfY291bnQg
Y291bnRlciwgc28gYSB1c2Vyc3BhY2UNCj4gPj4gZGV0ZWN0b3IgY291bGQgZWFzaWx5IHVzZSB0
aGF0IHRvIGltcGxlbWVudCBjdXN0b20gcG9saWNpZXMgOykNCg0K

