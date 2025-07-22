Return-Path: <linux-kernel+bounces-740086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70933B0CF91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07CD5423BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1871DF246;
	Tue, 22 Jul 2025 02:10:28 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E22F5B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753150228; cv=none; b=U3DeF2LtMcl5vG1SoakOXa8OxhAVazLz3QwnEvKb6w7o3bQ2ww9ShgmBKZMzmeEZubFwgWKzCabOLISFCggHbzragnYtPHF8sf92xENXSqud6SlealSE+WyZ4jn+DxeZd/FtqR6OAUodenwKKxjBqnzoqfgcrapg08qZDq84IY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753150228; c=relaxed/simple;
	bh=uBMvOx9T53q/N2fAhI92IUWur0DAJwWYgrQfkF3e28I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oIKt11xG2fu1vPQFM/PB3lkPcJzUJ3tpiACJNWTHuk9g+o5LhtdiWZZHy8ZHyPLIqS22hehjdi33IRex8EWimGi/gY1dZ0EnDRpGMztHgLXk66pde7obkX0J3P+cuVV+Yoy09UKqIFMx1FB4EKf5SwacI6OlctP45+Vhtcwi8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: David Laight <david.laight.linux@gmail.com>, Oleg Nesterov
	<oleg@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: =?gb2312?B?tPC4tDogW1NQQU1dIFs/Pz8/XSBSZTogW1BBVENIXSB4ODYvbWF0aDY0OiBo?=
 =?gb2312?B?YW5kbGUgI0RFIGluIG11bF91NjRfdTY0X2Rpdl91NjQoKQ==?=
Thread-Topic: [SPAM] [????] Re: [PATCH] x86/math64: handle #DE in
 mul_u64_u64_div_u64()
Thread-Index: AQHb+mw3wwaUns+Trk69tsGNRy9TYrQ9YwEA
Date: Tue, 22 Jul 2025 02:09:04 +0000
Message-ID: <d171fbe778f046b296618f21219078b0@baidu.com>
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
X-FEAS-Client-IP: 172.31.3.11
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBFdmVuIGZvciB0aGUgc2NoZWR1bGVyIHRoYXQgcmVjZW50bHkgdHJhcHBlZCBoZXJlLCB0aGUg
NjRiaXQgc3VtIHdhcyBhYm91dCB0aGUNCj4gd3JhcCBhbmQgdGhlIHZlcnkgc21hbGwgdmFsdWUg
cmV0dXJuZWQgdGhlbiBhbG1vc3QgY2VydGFpbmx5IHdvdWxkbid0IGhhdmUNCj4gYmVlbiBoYW5k
bGVkIGNvcnJlY3RseS4NCj4gKFNvIHRoYXQgY29kZSBuZWVkcyBmaXhpbmcgYW55d2F5IHRvIGF2
b2lkIHRoZSBvdmVyZmxvdy4pDQoNClRoZXJlIGFyZSBjdXJyZW50bHkgdHdvIGJ1Z3MuIFRoZSBv
bmUgT2xlZyBpcyBmaXhpbmcgaXMgYSBjcmFzaCBidWcgaW4gdGhlIHg4Ni02NCBtdWxfdTY0X3U2
NF9kaXZfdTY0KCkgZnVuY3Rpb24gY2F1c2VkIGJ5IHBvdGVudGlhbCBvdmVyZmxvdy4gVGhlIG11
bF91NjRfdTY0X2Rpdl91NjQoKSBmdW5jdGlvbiBpcyB1c2VkIG5vdCBvbmx5IGluIGNwdXRpbWUu
YyAsYnV0IGFsc28gd2lkZWx5IHVzZWQgd2l0aGluIGRyaXZlcnMuDQpUaGUgb3RoZXIgb25lIGlz
IGEgdGhyZWFkIGdyb3VwIHN0YXRpc3RpY3MgdGltZSBvdmVyZmxvdyBidWcuIElmIHRoZSBvdmVy
ZmxvdyBvZiBtdWxfdTY0X3U2NF9kaXZfdTY0KCkgY2FuIGJlIGZpeGVkLCBpdCBhdCBsZWFzdCBk
b2Vzbid0IGNyYXNoIHRoZSBzeXN0ZW0gYW55bW9yZS4gSG93ZXZlciwgcmVnYXJkaW5nIHRoZSBh
Y2N1cmFjeSBvZiB0aGUgdGltaW5nIHN0YXRpc3RpY3MsIHRoaXMgYnVnIG1pZ2h0IGJlIG1vcmUg
aGFyZGVyIHRvIGZpeC4NCg0KLUxpDQo=

