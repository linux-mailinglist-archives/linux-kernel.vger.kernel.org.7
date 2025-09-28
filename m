Return-Path: <linux-kernel+bounces-835413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4ABA7054
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87D63B266A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282B2D24B3;
	Sun, 28 Sep 2025 12:10:28 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8C34BA4D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759061428; cv=none; b=ljtZH+fao00lY+IwNP7ZdbUevelDG7AEYAV9C9CoacHLKB6iTXoezeKekeS2Hkpz8Zcy5/ydcDzzDZ2OQwN+vnbcBUyh1iU5h3OTbh785Er0BPa1IYWzMHzRk0OMgm790xDrnJ7pSsg7QtJFj6G+m80Pd+cKQer8iUq4ajw80Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759061428; c=relaxed/simple;
	bh=uLgygVJb0ACRIgq2y+gZx0g+OvINEx9PGU3DUq4hAi8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UA4FdQiHE17xZkyA7ZshiHL2FaH/xB8jIGgR2nQll01dFJemHqWUJwNSI+L6GPj97YLgg+uyX9sYoQHi751SuruhEuuGuJoSbbLBTe8gg16IR339fRt07wOiWSb9TzgrIMiZx0kC71sEWNKOePyBu6oULp4nwPkm9ney2ujcPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201623.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202509282010093563;
        Sun, 28 Sep 2025 20:10:09 +0800
Received: from jtjnmail201621.home.langchao.com (10.100.2.21) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 28 Sep 2025 20:10:09 +0800
Received: from jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a])
 by jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a%7]) with mapi
 id 15.01.2507.058; Sun, 28 Sep 2025 20:10:09 +0800
From: =?gb2312?B?SGFycmlzIFNvbmejqMvOv62jqQ==?= <songkai01@inspur.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"richard@nod.at" <richard@nod.at>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>
Subject: fs/jffs2/read.c: When a data CRC error is detected, why not mark the
 node obsolete?
Thread-Topic: fs/jffs2/read.c: When a data CRC error is detected, why not mark
 the node obsolete?
Thread-Index: AdwwcDY6j0QDKI6WQpmneibx12Rfxg==
Date: Sun, 28 Sep 2025 12:10:09 +0000
Message-ID: <f3ed0f6d27dc45088c4aad862dc05941@inspur.com>
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
tUid: 2025928201009fa0e8f26662b185ca6c731fadd015f61
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

SGkgYWxsLCANCg0KSW4gZnMvamZmczIvcmVhZC5jLCB3aGVuIGpmZnMyX3JlYWRfZG5vZGUgZGV0
ZWN0cyBhIGRhdGEtQ1JDIGZhaWx1cmUgaXQgaW1tZWRpYXRlbHkgcmV0dXJucyAtRUlPIHRvIHVz
ZXIgc3BhY2UuIEFueSByZWFkIGF0dGVtcHQgdGhhdCB0aGUgYXBwbGljYXRpb24gbWFrZXMgc2hv
cnRseSBhZnRlcndhcmRzIHdpbGwgZmFpbCB3aXRoIHRoZSBzYW1lIGVycm9yLg0KDQppbnQgamZm
czJfcmVhZF9kbm9kZSgpDQp7ICAgIA0KICAgIC4uLi4uLg0KICAgICAgY3JjID0gY3JjMzIoMCwg
cmVhZGJ1ZiwgamUzMl90b19jcHUocmktPmNzaXplKSk7DQogICAgICBpZiAoY3JjICE9IGplMzJf
dG9fY3B1KHJpLT5kYXRhX2NyYykpIHsNCiAgICAgICAgICAgIHByX3dhcm4oIkRhdGEgQ1JDICUw
OHggIT0gY2FsY3VsYXRlZCBDUkMgJTA4eCBmb3Igbm9kZSBhdCAlMDh4XG4iLA0KICAgICAgICAg
ICAgICAgICAgamUzMl90b19jcHUocmktPmRhdGFfY3JjKSwgY3JjLCByZWZfb2Zmc2V0KGZkLT5y
YXcpKTsNCiAgICAgICAgICAgIHJldCA9IC1FSU87DQogICAgICAgICAgICBnb3RvIG91dF9kZWNv
bXByYnVmOw0KICAgICAgfQ0KICAgIC4uLi4uLg0KICAgICAgcmV0dXJuIHJldDsNCn0NCg0KVGhl
IHN5c3RlbSBtdXN0IHdhaXQgZm9yIHRoZSBnYXJiYWdlIGNvbGxlY3Rpb24gbWVjaGFuaXNtIHRv
IGhhbmRsZSB0aGUgaXNzdWUuIEFmdGVyIHByb2Nlc3NpbmcsIHRoZSBub2RlIG1heSBoYXZlIGJl
ZW4gcm9sbGVkIGJhY2sgdG8gYW4gZWFybGllciAodmFsaWQpIHZlcnNpb24sIGFuZCBvbmx5IHRo
ZW4gY2FuIHRoZSBhcHBsaWNhdGlvbiByZWFkIHRoZSBkYXRhIHN1Y2Nlc3NmdWxseS4NCg0KSW4g
c3VjaCBhIHNjZW5hcmlvLCBzaW5jZSB0aGUgbm9kZSBpcyBhbHJlYWR5IGNvcnJ1cHRlZCwgd291
bGQgaXQgYmUgcG9zc2libGUgdG8gZGlyZWN0bHkgbWFyayB0aGUgbm9kZSB3aXRoIHRoZSBDUkMg
ZXJyb3IgYXMgb2Jzb2xldGUoamZmczJfbWFya19ub2RlX29ic29sZXRlIG9yIGEgc2ltaWxhciBo
ZWxwZXIpPyBUaGlzIHdheSwgd2hlbiB0aGUgYXBwbGljYXRpb24gcmVhZHMgYWdhaW4sIGl0IGNv
dWxkIGltbWVkaWF0ZWx5IGFjY2VzcyB0aGUgY29ycmVjdCBkYXRhIHdpdGhvdXQgIHdhaXRpbmcg
Zm9yIGJhY2tncm91bmQgZ2FyYmFnZSBjb2xsZWN0aW9uLg0KDQpsaWtlIHRoaXM6IA0KDQppbnQg
amZmczJfcmVhZF9kbm9kZSgpDQp7ICAgIA0KICAgIC4uLi4uLg0KICAgICAgY3JjID0gY3JjMzIo
MCwgcmVhZGJ1ZiwgamUzMl90b19jcHUocmktPmNzaXplKSk7DQogICAgICBpZiAoY3JjICE9IGpl
MzJfdG9fY3B1KHJpLT5kYXRhX2NyYykpIHsNCiAgICAgICAgICAgIHByX3dhcm4oIkRhdGEgQ1JD
ICUwOHggIT0gY2FsY3VsYXRlZCBDUkMgJTA4eCBmb3Igbm9kZSBhdCAlMDh4XG4iLA0KICAgICAg
ICAgICAgICAgICAgamUzMl90b19jcHUocmktPmRhdGFfY3JjKSwgY3JjLCByZWZfb2Zmc2V0KGZk
LT5yYXcpKTsNCiAgICAgICAgICAgIGpmZnMyX21hcmtfbm9kZV9vYnNvbGV0ZSgpDQogICAgICAg
ICAgICByZXQgPSAtRUlPOw0KICAgICAgICAgICAgZ290byBvdXRfZGVjb21wcmJ1ZjsNCiAgICAg
IH0NCiAgICAuLi4uLi4NCiAgICAgIHJldHVybiByZXQ7DQp9DQoNClRoYW5rcw0K

