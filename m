Return-Path: <linux-kernel+bounces-832155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDEB9E818
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B964257EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41C2874E9;
	Thu, 25 Sep 2025 09:52:11 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3C27AC59
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793931; cv=none; b=mkzhV+OTN3/jlGnHeOmknsL0pypIi9sjs0g2pnGtcll+rnFrCs0AlbgLWQ4F2CxB9QboW/1qE86+fLI+ALJjjSIrGu4wLfaAccTq5XGTFeK6+SZqWp7TLgvUkOPX4tC+X1J+hZYPqalr/0/nAoMkKqpSNhG91TY3+ZgxnxaaMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793931; c=relaxed/simple;
	bh=mxVFvjYMQ/LgkTSjjfknRSbHInNmM5HGxEEbE+2fbps=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ru0lkdN4nlkyw8pS6xhucCmtMunVT/g2wjDNEYcysh2lP8tHUne3Ha/FT7sZnYEE82w/ffSDpJ4icxd4I+8o1SK6mpuRzbNpMLk4MmEnHr2vOkYSGQEw67vx8+2Dn6WEKDV6Wb9rIqr73AsAW8X1FTR6LbFqIZH9BjLHcLyYyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Valentin Schneider <vschneid@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?UkU6IFvN4rK/08q8/l0gUmU6IFtQQVRDSF0gc2NoZWQvZmFpcjogT3B0aW1p?=
 =?gb2312?B?emUgQ1BVIGl0ZXJhdGlvbiB1c2luZyBmb3JfZWFjaF9jcHVfYW5kW25vdF0=?=
Thread-Topic: =?gb2312?B?W83isr/Tyrz+XSBSZTogW1BBVENIXSBzY2hlZC9mYWlyOiBPcHRpbWl6ZSBD?=
 =?gb2312?B?UFUgaXRlcmF0aW9uIHVzaW5nIGZvcl9lYWNoX2NwdV9hbmRbbm90XQ==?=
Thread-Index: AQHcDYIWd9yglffwUU2pLhYEjK4i07RpXEwAgDqMK5A=
Date: Thu, 25 Sep 2025 09:50:39 +0000
Message-ID: <2db9ef16b64a4e179061339b3a758a2a@baidu.com>
References: <20250815011512.6870-1-lirongqing@baidu.com>
 <xhsmhwm6zh6wr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhwm6zh6wr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
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

PiA+IFJlcGxhY2Ugb3Blbi1jb2RlZCBDUFUgaXRlcmF0aW9uIHBhdHRlcm5zIHdpdGggbW9yZSBl
ZmZpY2llbnQNCj4gPiBmb3JfZWFjaF9jcHVfYW5kKCkgYW5kIGZvcl9lYWNoX2NwdV9hbmRub3Qo
KSBtYWNyb3MgaW4gdGhyZWUgbG9jYXRpb25zLg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgYm90aCBz
aW1wbGlmaWVzIHRoZSBjb2RlIGFuZCBwcm92aWRlcyBtaW5vciBwZXJmb3JtYW5jZQ0KPiA+IGlt
cHJvdmVtZW50cyBieSB1c2luZyB0aGUgbW9yZSBzcGVjaWFsaXplZCBpdGVyYXRpb24gbWFjcm9z
Lg0KPiA+DQo+IA0KPiBUQkYgSSdtIG5vdCBzdXJlIGl0IGRvZXMgaW1wcm92ZSBhbnl0aGluZyBm
b3IgdGhlIFNNVCBjYXNlcyBjb25zaWRlcmluZyB3ZQ0KPiBkb24ndCBzZWUgbXVjaCBtb3JlIHRo
YW4gU01UOC4NCj4gDQo+IFRoZSB0YXNrX251bWFfZmluZF9jcHUoKSBvbmUgSSBkbyBhZ3JlZSBt
YWtlcyB0aGluZ3MgYmV0dGVyLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8
bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogVmFsZW50aW4gU2NobmVp
ZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPg0KDQoNClBpbmcgDQoNClRoYW5rcw0KDQotTGkNCg0K

