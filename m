Return-Path: <linux-kernel+bounces-768383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BCB2608D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC225828ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1AF2EFD9A;
	Thu, 14 Aug 2025 09:10:02 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1452EBDC7;
	Thu, 14 Aug 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162601; cv=none; b=tgwiOvUcEBIyo4uAFshke2Y65WeSsdcfQEnjV2n1HWrrit1113XQp7Yr7JxHPD1fbYpfOG87WMntB1WipvYLcj9mB0j0ApWN5a88kQuakfh4Fb0c8LyL6J9qtyNlF84zmI7k/DAS7AbrVJfIOGwBK9oQVAqF+fSC0zihC3Zl1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162601; c=relaxed/simple;
	bh=tMY4dvXutGA0Xp78nYkrpfsUKYwF4wzyT2kopCfHWGY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=OBP400x8Mnm4TSBvbTcd9mbapBsLI1E8Xz4KG0+3XQgA0zIlNVNmYQ5sIqAAaNBp/sawccIwq2h6p9qfDg3sr45nTLIPyUVYy5s7g/5dv/gaG8GfX4AAFDc7Hiwzxlld9Ymfb60/lhlGTm4b4x/rAhjX4HIoE4WICSxc0GWqU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c2fZf3wZpz7s3pk;
	Thu, 14 Aug 2025 17:09:46 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 57E99IR4031171;
	Thu, 14 Aug 2025 17:09:18 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 14 Aug 2025 17:09:20 +0800 (CST)
Date: Thu, 14 Aug 2025 17:09:20 +0800 (CST)
X-Zmail-TransId: 2afa689da7c0ffffffff9fc-70ef0
X-Mailer: Zmail v1.0
Message-ID: <202508141709204212p78jkpo53qqgf0IMpdsO@zte.com.cn>
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
        <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0ggMC80IGxpbnV4IG5leHQgUkVTRU5EXSBEb2NzL3poX0NOOiBUcmFuc2xhdGUgbmV0d29ya2luZyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 57E99IR4031171
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 14 Aug 2025 17:09:46 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 689DA7DA.001/4c2fZf3wZpz7s3pk



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
d29ya2luZyBkb2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ0KDQpTdW4geXV4aSAoMik6DQogIERv
Y3MvemhfQ046IFRyYW5zbGF0ZSBtcHRjcC1zeXNjdGwucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVz
ZQ0KICBEb2NzL3poX0NOOiBUcmFuc2xhdGUgZ2VuZXJpYy1oZGxjLnJzdCB0byBTaW1wbGlmaWVk
IENoaW5lc2UNCg0KV2FuZyBZYXhpbiAoMik6DQogIERvY3MvemhfQ046IFRyYW5zbGF0ZSBza2J1
ZmYucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ0KICBEb2NzL3poX0NOOiBUcmFuc2xhdGUgdGlt
ZXN0YW1waW5nLnJzdCB0byBTaW1wbGlmaWVkIENoaW5lc2UNCg0KIC4uLi96aF9DTi9uZXR3b3Jr
aW5nL2dlbmVyaWMtaGRsYy5yc3QgICAgICAgICB8IDE3NiArKysrKw0KIC4uLi90cmFuc2xhdGlv
bnMvemhfQ04vbmV0d29ya2luZy9pbmRleC5yc3QgICB8ICAgOCArLQ0KIC4uLi96aF9DTi9uZXR3
b3JraW5nL21wdGNwLXN5c2N0bC5yc3QgICAgICAgICB8IDEzOSArKysrDQogLi4uL3RyYW5zbGF0
aW9ucy96aF9DTi9uZXR3b3JraW5nL3NrYnVmZi5yc3QgIHwgIDQ0ICsrDQogLi4uL3poX0NOL25l
dHdvcmtpbmcvdGltZXN0YW1waW5nLnJzdCAgICAgICAgIHwgNjc0ICsrKysrKysrKysrKysrKysr
Kw0KIDUgZmlsZXMgY2hhbmdlZCwgMTAzNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9uZXR3
b3JraW5nL2dlbmVyaWMtaGRsYy5yc3QNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi90cmFuc2xhdGlvbnMvemhfQ04vbmV0d29ya2luZy9tcHRjcC1zeXNjdGwucnN0DQogY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL25ldHdvcmtpbmcv
c2tidWZmLnJzdA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9DTi9uZXR3b3JraW5nL3RpbWVzdGFtcGluZy5yc3QNCg0KLS0gDQoyLjI1LjE=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IFdhbmcgWWF4aW4gJmx0O3dhbmcueWF4
aW5AenRlLmNvbS5jbiZndDs8L3A+PHA+PGJyPjwvcD48cD50cmFuc2xhdGUgbmV0d29ya2luZyBk
b2NzIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZTwvcD48cD48YnI+PC9wPjxwPlN1biB5dXhpICgyKTo8
L3A+PHA+Jm5ic3A7IERvY3MvemhfQ046IFRyYW5zbGF0ZSBtcHRjcC1zeXNjdGwucnN0IHRvIFNp
bXBsaWZpZWQgQ2hpbmVzZTwvcD48cD4mbmJzcDsgRG9jcy96aF9DTjogVHJhbnNsYXRlIGdlbmVy
aWMtaGRsYy5yc3QgdG8gU2ltcGxpZmllZCBDaGluZXNlPC9wPjxwPjxicj48L3A+PHA+V2FuZyBZ
YXhpbiAoMik6PC9wPjxwPiZuYnNwOyBEb2NzL3poX0NOOiBUcmFuc2xhdGUgc2tidWZmLnJzdCB0
byBTaW1wbGlmaWVkIENoaW5lc2U8L3A+PHA+Jm5ic3A7IERvY3MvemhfQ046IFRyYW5zbGF0ZSB0
aW1lc3RhbXBpbmcucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZTwvcD48cD48YnI+PC9wPjxwPiZu
YnNwOy4uLi96aF9DTi9uZXR3b3JraW5nL2dlbmVyaWMtaGRsYy5yc3QmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7fCAxNzYgKysrKys8L3A+PHA+Jm5ic3A7Li4uL3RyYW5zbGF0aW9u
cy96aF9DTi9uZXR3b3JraW5nL2luZGV4LnJzdCZuYnNwOyAmbmJzcDt8Jm5ic3A7ICZuYnNwOzgg
Ky08L3A+PHA+Jm5ic3A7Li4uL3poX0NOL25ldHdvcmtpbmcvbXB0Y3Atc3lzY3RsLnJzdCZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDt8IDEzOSArKysrPC9wPjxwPiZuYnNwOy4uLi90
cmFuc2xhdGlvbnMvemhfQ04vbmV0d29ya2luZy9za2J1ZmYucnN0Jm5ic3A7IHwmbmJzcDsgNDQg
Kys8L3A+PHA+Jm5ic3A7Li4uL3poX0NOL25ldHdvcmtpbmcvdGltZXN0YW1waW5nLnJzdCZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDt8IDY3NCArKysrKysrKysrKysrKysrKys8L3A+
PHA+Jm5ic3A7NSBmaWxlcyBjaGFuZ2VkLCAxMDM3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pPC9wPjxwPiZuYnNwO2NyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy96aF9DTi9uZXR3b3JraW5nL2dlbmVyaWMtaGRsYy5yc3Q8L3A+PHA+Jm5ic3A7Y3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL25ldHdvcmtpbmcv
bXB0Y3Atc3lzY3RsLnJzdDwvcD48cD4mbmJzcDtjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbmV0d29ya2luZy9za2J1ZmYucnN0PC9wPjxwPiZuYnNw
O2NyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9uZXR3
b3JraW5nL3RpbWVzdGFtcGluZy5yc3Q8L3A+PHA+PGJyPjwvcD48cD4tLSZuYnNwOzwvcD48cD4y
LjI1LjE8L3A+PHA+PGJyPjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


