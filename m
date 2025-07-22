Return-Path: <linux-kernel+bounces-740534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC4B0D55E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2944D1896D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9F2DAFD5;
	Tue, 22 Jul 2025 09:11:27 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D2270EA5;
	Tue, 22 Jul 2025 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175486; cv=none; b=elPmJtISfaDrVEwjrmWazBsWP4HE9//veNF+BzElNgb1T5jhHFZqGghIVouEXIspguukhhuqX9z4swo4Kj0HixGzlYBpHr8Nffe9I1Cc2HkmoHfXR1S4NvFys95OxDx6VlSIy8iojbqmnH/OgTPT80wDCBUjqwUC+7IH1J43tRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175486; c=relaxed/simple;
	bh=V3XzBkGhsHgFumMqo+6Q5lo1lKhko6FY90AOtBRNUww=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=LQ0mGEPyKgvp01a0w1H6DZ7Slb82ejQ/yU3U3zv4KvrktBfQRKC0Bb7FSwatMN1wpY8Ptdxaw2AGKjZJ88s2DmtTgWOve8AfZTna2+oDIGB57uNG7dCAtf0hZ0Nd2a9sojcF9FN4SFjRMpV+RZcG59vG/cInZC7AursxcWSMspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bmWj40ZwCz6FyCJ;
	Tue, 22 Jul 2025 17:11:20 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 56M9B3LG038560;
	Tue, 22 Jul 2025 17:11:03 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 22 Jul 2025 17:11:05 +0800 (CST)
Date: Tue, 22 Jul 2025 17:11:05 +0800 (CST)
X-Zmail-TransId: 2afa687f55a9ffffffffab2-230a8
X-Mailer: Zmail v1.0
Message-ID: <20250722171105251YZi7zdexFaeEVQIj2iYZq@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <sun.yuxi@zte.com.cn>,
        <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?RG9jcy96aF9DTjogVHJhbnNsYXRlCgogbmV0d29ya2luZyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 56M9B3LG038560
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 22 Jul 2025 17:11:20 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687F55B8.000/4bmWj40ZwCz6FyCJ



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogV2FuZyBZYXhpbiA8d2FuZy55YXhpbkB6dGUuY29tLmNuPg0KDQp0cmFuc2xhdGUgbmV0
d29ya2luZyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ0KDQpXYW5nIFlheGluICgyKToNCiAg
RG9jcy96aF9DTjogVHJhbnNsYXRlIHRpbWVzdGFtcGluZy5yc3QgdG8gU2ltcGxpZmllZCAgQ2hp
bmVzZQ0KICBEb2NzL3poX0NOOiBUcmFuc2xhdGUgc2tidWZmLnJzdCB0byBTaW1wbGlmaWVkICBD
aGluZXNlDQpTdW4geXV4aSAoMik6DQogIERvY3MvemhfQ046IFRyYW5zbGF0ZSBnZW5lcmljLWhk
bGMucnN0IHRvIFNpbXBsaWZpZWQgIENoaW5lc2UNCiAgRG9jcy96aF9DTjogVHJhbnNsYXRlIG1w
dGNwLXN5c2N0bC5yc3QgdG8gU2ltcGxpZmllZCAgQ2hpbmVzZQ0KDQogLi4uL3poX0NOL25ldHdv
cmtpbmcvZ2VuZXJpYy1oZGxjLnJzdCAgICAgICAgIHwgMTc2ICsrKysrDQogLi4uL3RyYW5zbGF0
aW9ucy96aF9DTi9uZXR3b3JraW5nL2luZGV4LnJzdCAgIHwgICA4ICstDQogLi4uL3poX0NOL25l
dHdvcmtpbmcvbXB0Y3Atc3lzY3RsLnJzdCAgICAgICAgIHwgMTM5ICsrKysNCiAuLi4vdHJhbnNs
YXRpb25zL3poX0NOL25ldHdvcmtpbmcvc2tidWZmLnJzdCAgfCAgNDQgKysNCiAuLi4vemhfQ04v
bmV0d29ya2luZy90aW1lc3RhbXBpbmcucnN0ICAgICAgICAgfCA2NzQgKysrKysrKysrKysrKysr
KysrDQogNSBmaWxlcyBjaGFuZ2VkLCAxMDM3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL25l
dHdvcmtpbmcvZ2VuZXJpYy1oZGxjLnJzdA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9uZXR3b3JraW5nL21wdGNwLXN5c2N0bC5yc3QNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbmV0d29ya2lu
Zy9za2J1ZmYucnN0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX0NOL25ldHdvcmtpbmcvdGltZXN0YW1waW5nLnJzdA0KDQotLSANCjIuMjUuMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IFdhbmcgWWF4aW4gJmx0O3dhbmcueWF4
aW5AenRlLmNvbS5jbiZndDs8L3A+PHA+PGJyPjwvcD48cD50cmFuc2xhdGUgbmV0d29ya2luZyBk
b2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZTwvcD48cD48YnI+PC9wPjxwPldhbmcgWWF4aW4gKDIp
OjwvcD48cD4mbmJzcDsgRG9jcy96aF9DTjogVHJhbnNsYXRlIHRpbWVzdGFtcGluZy5yc3QgdG8g
U2ltcGxpZmllZCZuYnNwOyBDaGluZXNlPC9wPjxwPiZuYnNwOyBEb2NzL3poX0NOOiBUcmFuc2xh
dGUgc2tidWZmLnJzdCB0byBTaW1wbGlmaWVkJm5ic3A7IENoaW5lc2U8L3A+PHA+U3VuIHl1eGkg
KDIpOjwvcD48cD4mbmJzcDsgRG9jcy96aF9DTjogVHJhbnNsYXRlIGdlbmVyaWMtaGRsYy5yc3Qg
dG8gU2ltcGxpZmllZCZuYnNwOyBDaGluZXNlPC9wPjxwPiZuYnNwOyBEb2NzL3poX0NOOiBUcmFu
c2xhdGUgbXB0Y3Atc3lzY3RsLnJzdCB0byBTaW1wbGlmaWVkJm5ic3A7IENoaW5lc2U8L3A+PHA+
PGJyPjwvcD48cD4mbmJzcDsuLi4vemhfQ04vbmV0d29ya2luZy9nZW5lcmljLWhkbGMucnN0Jm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO3wgMTc2ICsrKysrPC9wPjxwPiZuYnNwOy4u
Li90cmFuc2xhdGlvbnMvemhfQ04vbmV0d29ya2luZy9pbmRleC5yc3QmbmJzcDsgJm5ic3A7fCZu
YnNwOyAmbmJzcDs4ICstPC9wPjxwPiZuYnNwOy4uLi96aF9DTi9uZXR3b3JraW5nL21wdGNwLXN5
c2N0bC5yc3QmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7fCAxMzkgKysrKzwvcD48
cD4mbmJzcDsuLi4vdHJhbnNsYXRpb25zL3poX0NOL25ldHdvcmtpbmcvc2tidWZmLnJzdCZuYnNw
OyB8Jm5ic3A7IDQ0ICsrPC9wPjxwPiZuYnNwOy4uLi96aF9DTi9uZXR3b3JraW5nL3RpbWVzdGFt
cGluZy5yc3QmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7fCA2NzQgKysrKysrKysr
KysrKysrKysrPC9wPjxwPiZuYnNwOzUgZmlsZXMgY2hhbmdlZCwgMTAzNyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKTwvcD48cD4mbmJzcDtjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbmV0d29ya2luZy9nZW5lcmljLWhkbGMucnN0PC9wPjxw
PiZuYnNwO2NyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9uZXR3b3JraW5nL21wdGNwLXN5c2N0bC5yc3Q8L3A+PHA+Jm5ic3A7Y3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL25ldHdvcmtpbmcvc2tidWZmLnJz
dDwvcD48cD4mbmJzcDtjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vbmV0d29ya2luZy90aW1lc3RhbXBpbmcucnN0PC9wPjxwPjxicj48L3A+PHA+LS0m
bmJzcDs8L3A+PHA+Mi4yNS4xPC9wPjwvZGl2Pg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


