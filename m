Return-Path: <linux-kernel+bounces-895048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C844C4CCDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9365B422196
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EC02E888A;
	Tue, 11 Nov 2025 09:48:26 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5521C9E5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854506; cv=none; b=f3H+IfnIvzp4om+7bLp2AAULel6lNoZbDCFgu+uL6awmB4cllHoV8aKxQvC42QAPb73F29LciJLqi08UD2ig6WkJ9nSbgSXv59zMwUS+JBSdLJ7/MN65UZWkN+/wLDBC8R4NQz2GIauVuFOD71/txQCH4trxs/LMWjpSdp0lEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854506; c=relaxed/simple;
	bh=Y5mce2XBTRfvstbXNqv/4rBThrjhi2ytbI8G363Kv4M=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=Wy5FfDsNS5Bz6sBkT9v9CAmVUG14uRR3eoepf6kHqSJhdf7o+8jpgiXV3u8509aVCTAjx+GffHGLKdTV1pomkvUeWH+cQflzUV6r6CHPbfO2qWUyGJ7aVIkEyDL6RyHNJ6+eG3LNrsH50S7bIyn7xyfKLfzXYcgDArqWzIA4CYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csu.edu.cn; spf=pass smtp.mailfrom=csu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csu.edu.cn
Received: from 254501007$csu.edu.cn ( [38.180.249.229] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 11 Nov 2025 17:47:48 +0800 (GMT+08:00)
Date: Tue, 11 Nov 2025 17:47:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5YiY5piM5YGl?= <254501007@csu.edu.cn>
To: linux-kernel@vger.kernel.org
Subject: Inquiry about Automating Access to Syzbot Vulnerability Repository
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220420(bbe86039)
 Copyright (c) 2002-2025 www.mailtech.cn csu
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6fd6d82.de8.19a72507c66.Coremail.254501007@csu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:FEDFygC399tEBhNp5VYnAA--.2216W
X-CM-SenderInfo: isvukiirqqlqxfvxhvlgxou0/1tbiAggDBGkSxWQbgQABsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

4oCLRGVhciBTeXprYWxsZXIgTWFpbnRhaW5lcnMsCgpJIGhvcGUgdGhpcyBlbWFpbCBmaW5kcyB5
b3Ugd2VsbC4KCkkgYW0gY3VycmVudGx5IHdvcmtpbmcgb24gYSBwcm9qZWN0IHRoYXQgcmVxdWly
ZXMgcHJvZ3JhbW1hdGljYWxseSBhY2Nlc3NpbmcgdGhlIHZ1bG5lcmFiaWxpdHkgZGF0YSByZXBv
cnRlZCBieSBTeXpib3QsIHdoaWNoIGlzIGF2YWlsYWJsZSBhdCBzeXprYWxsZXIgYXBwc3BvdOKA
iy4gU3BlY2lmaWNhbGx5LCBJIGFtIGludGVyZXN0ZWQgaW4gYXV0b21hdGluZyB0aGUgcHJvY2Vz
cyBvZiByZXRyaWV2aW5nIHRoZSBsaXN0IG9mIHZ1bG5lcmFiaWxpdGllcyBhbmQgdGhlaXIgZGV0
YWlscywgd2hpY2ggYXJlIGRpc3BsYXllZCBvbiB0aGUgU3l6a2FsbGVyIGRhc2hib2FyZC4KCkNv
dWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBndWlkYW5jZSBvbiBob3cgSSBjYW4gYXV0b21hdGUgdGhl
IHJldHJpZXZhbCBvZiB0aGlzIGRhdGE/IEkgd291bGQgbGlrZSB0byBrbm93IGlmIHRoZXJlIGlz
IGFuIG9mZmljaWFsIEFQSSBvciBpZiB0aGVyZSBhcmUgYW55IG90aGVyIG1ldGhvZHMgYXZhaWxh
YmxlIHRvIGFjaGlldmUgdGhpcy4gCklmIHN1Y2ggYSBzb2x1dGlvbiBpcyBub3QgY3VycmVudGx5
IGF2YWlsYWJsZSwgd291bGQgaXQgYmUgcG9zc2libGUgdG8gZXhwbG9yZSBwb3RlbnRpYWwgb3B0
aW9ucyBmb3IgYXV0b21hdGluZyB0aGlzIHByb2Nlc3M/Ckkgd291bGQgZ3JlYXRseSBhcHByZWNp
YXRlIGFueSBhc3Npc3RhbmNlIG9yIHBvaW50ZXJzIHlvdSBjb3VsZCBwcm92aWRlIHJlZ2FyZGlu
ZyB0aGlzLgoKVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIHN1cHBvcnQuCgoKQmVzdCByZWdh
cmRzLApDaGFuZ2ppYW4gTGl1Cg==

