Return-Path: <linux-kernel+bounces-831947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A5B9DF61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054DA17266D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033B25DD0B;
	Thu, 25 Sep 2025 08:03:17 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA0242D9F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787396; cv=none; b=TEisvElijQd6RtuN40gN5n9yaeqMGP9Ps+CSYzJcYB1jFQq1oIIJB13xxhdRPXGXNvkFrGEMzmLbqJXhXl1Q2DiCdfObnG8kKeWaOYnvdFFEF5r9sCyRaTZ5ddCPZL6yaujIXLyY2vjxbbtN21p8sPBZaHyr0vINOeewGwqt6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787396; c=relaxed/simple;
	bh=UYA2N0OlkqZn2tS6CSo9OKze06/ECOORsuaofy36ck0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDbja8cEZLNKrV4tKwS7oTqlCyQwJ7zTbp8yPICa4zGNdPNbf6QoJrs8ShnrBp5aLxGWd/t49HHDEj69aoxk7Sn3n10whHskXthjynyi5UifLQBlAg1FaaMONMKc1yZRtQqaBVYVJb3iIq6eBE4oHZi4VKlKDg1QMsF0MleZq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Hillf Danton <hdanton@sina.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?UkU6IFvN4rK/08q8/l0gUmU6IFtQQVRDSF0gaHVuZ190YXNrOiBQYW5pYyBh?=
 =?gb2312?Q?fter_fixed_number_of_hung_tasks?=
Thread-Topic: =?gb2312?B?W83isr/Tyrz+XSBSZTogW1BBVENIXSBodW5nX3Rhc2s6IFBhbmljIGFmdGVy?=
 =?gb2312?Q?_fixed_number_of_hung_tasks?=
Thread-Index: AQHcLeKBbjlGoIEXG0G0MLy1vpHO47Si/I0AgACL7VA=
Date: Thu, 25 Sep 2025 08:03:04 +0000
Message-ID: <efdd0d42567e4e7a94c8e5340ed4b35a@baidu.com>
References: <20250925060605.2659-1-lirongqing@baidu.com>
 <20250925073717.7636-1-hdanton@sina.com>
In-Reply-To: <20250925073717.7636-1-hdanton@sina.com>
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
X-FEAS-Client-IP: 172.31.3.12
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGlsbGYgRGFudG9uIDxo
ZGFudG9uQHNpbmEuY29tPg0KPiBTZW50OiAyMDI1xOo51MIyNcjVIDE1OjM3DQo+IFRvOiBMaSxS
b25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IENjOiBMS01MIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbzeKyv9PKvP5dIFJlOiBbUEFUQ0hdIGh1bmdf
dGFzazogUGFuaWMgYWZ0ZXIgZml4ZWQgbnVtYmVyIG9mIGh1bmcNCj4gdGFza3MNCj4gDQo+IE9u
IFRodSwgMjUgU2VwIDIwMjUgMTQ6MDY6MDUgKzA4MDANCj4gPiBGcm9tOiBMaSBSb25nUWluZyA8
bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHksIHdoZW4gaHVuZ190YXNr
X3BhbmljIGlzIGVuYWJsZWQsIGtlcm5lbCB3aWxsIHBhbmljDQo+ID4gaW1tZWRpYXRlbHkgdXBv
biBkZXRlY3RpbmcgdGhlIGZpcnN0IGh1bmcgdGFzay4gSG93ZXZlciwgc29tZSBodW5nDQo+ID4g
dGFza3MgYXJlIHRyYW5zaWVudCBhbmQgdGhlIHN5c3RlbSBjYW4gcmVjb3ZlciBmdWxseSwgd2hp
bGUgb3RoZXJzIGFyZQ0KPiA+IHVucmVjb3ZlcmFibGUgYW5kIHRyaWdnZXIgY29uc2VjdXRpdmUg
aHVuZyB0YXNrIHJlcG9ydHMsIGFuZCBhIHBhbmljIGlzDQo+IGV4cGVjdGVkLg0KPiA+DQo+ID4g
VGhpcyBjb21taXQgYWRkcyBhIG5ldyBzeXNjdGwgcGFyYW1ldGVyIGh1bmdfdGFza19jb3VudF90
b19wYW5pYyB0bw0KPiA+IGFsbG93cyBzcGVjaWZ5aW5nIHRoZSBudW1iZXIgb2YgY29uc2VjdXRp
dmUgaHVuZyB0YXNrcyB0aGF0IG11c3QgYmUNCj4gPiBkZXRlY3RlZCBiZWZvcmUgdHJpZ2dlcmlu
ZyBhIGtlcm5lbCBwYW5pYy4gVGhpcyBwcm92aWRlcyBmaW5lciBjb250cm9sDQo+ID4gZm9yIGVu
dmlyb25tZW50cyB3aGVyZSB0cmFuc2llbnQgaGFuZ3MgbWF5YmUgaGFwcGVuIGJ1dCBwZXJzaXN0
ZW50DQo+ID4gaGFuZ3Mgc2hvdWxkIHN0aWxsIGJlIGZhdGFsLg0KPiA+DQo+IEdpdmVuIHRyYW5z
aWVudCwgYnVtcGluZyBzeXNjdGxfaHVuZ190YXNrX3RpbWVvdXRfc2VjcyB1cCBhbG9uZSBoZWxw
cy4NCg0KSG93ZXZlciwgdGhpcyB3aWxsIHByZXZlbnQgdGhlIHByaW50aW5nIG9mIGh1bmcgdGFz
ayB3YXJuaW5ncy4gSHVuZyB0YXNrIHdhcm5pbmdzIGFyZSANCnZlcnkgdXNlZnVsIGZvciBpZGVu
dGlmeWluZyB3aGljaCB0YXNrcyBhcmUgaGFuZ2luZyBhbmQgd2hlcmUgdGhleSBhcmUgc3R1Y2su
DQoNCklmIHRoZXJlIGlzIGh1bmdfdGFza19jb3VudF90b19wYW5pYywgSSBob3BlIHRvIHNob3J0
ZW4gc3lzY3RsX2h1bmdfdGFza190aW1lb3V0X3NlY3MgdG8gZ2l2ZSBtb3JlIGluZm9ybWF0aW9u
Lg0KDQpUaGFua3MNCg==

