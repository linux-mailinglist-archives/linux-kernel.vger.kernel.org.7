Return-Path: <linux-kernel+bounces-828325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B0B94654
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26C03B5334
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAB422127B;
	Tue, 23 Sep 2025 05:24:07 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF612B94;
	Tue, 23 Sep 2025 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605047; cv=none; b=l7E8tbKQoiId51R/Qe+zsqxTNkptmdFTpyk9RznGcM03xsMs5Y3VfGn9RzGkFbVErOt63/SzpnmaIU3hv3FXAONe3MkP23DCQdWTo6DO/fWRLFk1D562sf9PVcVc/Ez7H3GqbnsuDUV6b24oNKl7yFNaU5+i+pXtmskRV40ZAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605047; c=relaxed/simple;
	bh=qEzlyB/M0Z+ObK6m9xMEn0iiJcBKWhuxCTfs3ZrVWLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYJVSpv8pTv6LYzAc88N4MEnzuvCxr7qtYy4NuTsIFaxogNsbLyG9ew7XxpuJFyYWMx5GpXt2xOLesqyZTt0Blbbf8jJr60GhX0bAbU231YQjb6uNKA7mc5Rp+KHw1dMBwJHCQfK0B0pgkE393N+CJWCkAYa4YpmDM/fKvE1y3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
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
Thread-Index: AQHcLD6SwU5buVCi00+LlNrVaU6G67SgOukw
Date: Tue, 23 Sep 2025 05:22:23 +0000
Message-ID: <bbdc2b5c2b374ed1801113148a72d83c@baidu.com>
References: <20250923033740.2696-1-lirongqing@baidu.com>
 <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
 <9067a88d-f5df-4d6e-b3b3-2e266ebcf3d0@linux.dev>
In-Reply-To: <9067a88d-f5df-4d6e-b3b3-2e266ebcf3d0@linux.dev>
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
X-FEAS-Client-IP: 172.31.50.46
X-FE-Policy-ID: 52:10:53:SYSTEM

PiA+IEkgYXNzdW1lIHRoZSBzYW1lIGFyZ3VtZW50IGFwcGxpZXMgdG8gdGhlIE5NSSB3YXRjaGRv
ZywgdG8gdGhlDQo+ID4gc29mdGxvY2t1cCBkZXRlY3RvciBhbmQgdG8gdGhlIFJDVSBzdGFsbCBk
ZXRlY3Rvcj8NCj4gPg0KPiA+IEEgZ2VuZXJhbCBmcmFtZXdvcmsgdG8gaGFuZGxlIGFsbCBvZiB0
aGVzZSBtaWdodCBiZSBiZXR0ZXIuICBCdXQgd2h5DQo+ID4gZG8gaXQgaW4ga2VybmVsIGF0IGFs
bD8gIFdoYXQgYWJvdXQgYSB1c2Vyc3BhY2UgZGV0ZWN0b3Igd2hpY2ggcGFyc2VzDQo+ID4ga2Vy
bmVsIGxvZ3MgKG9yIG5ldyBwcm9jZnMgY291bnRlcnMpIGFuZCBtYWtlcyBzdWNoIGRlY2lzaW9u
cz8NCj4gDQo+ICsxLiBJIGFncmVlIHRoYXQgYSB1c2Vyc3BhY2UgZGV0ZWN0b3Igc2VlbXMgbW9y
ZSBhcHByb3ByaWF0ZSBmb3IgdGhpcy4NCj4gDQoNCkkgdGhpbmsgdGhlIHVzZXItc3BhY2UgbWF5
YmUgZmxleGliaWxpdHksIGJ1dCBpbmN1cnMgcmVsYXRpdmVseSBoaWdoZXIgb3ZlcmhlYWQgYW5k
IGlzIGxlc3MgcmVsaWFibGUuIFdoZW4gdGhlIHN5c3RlbSBoYW5ncywgdGhpcyB0YXNrIG1heSBo
YXZlIGFscmVhZHkgaHVuZyBhcyB3ZWxsLg0KDQoNCj4gV2UgYWxyZWFkeSBoYXZlIHRoZSBodW5n
X3Rhc2tfZGV0ZWN0X2NvdW50IGNvdW50ZXIsIHNvIGEgdXNlcnNwYWNlIGRldGVjdG9yDQo+IGNv
dWxkIGVhc2lseSB1c2UgdGhhdCB0byBpbXBsZW1lbnQgY3VzdG9tIHBvbGljaWVzIDspDQo=

