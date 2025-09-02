Return-Path: <linux-kernel+bounces-797199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30EB40D43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5AD2070C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8234AB0E;
	Tue,  2 Sep 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqmchAm8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRT4StSM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E5285C82
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838220; cv=none; b=obZxCQGnzqRaTMP8zuzBq9idojwM1Zkh4hcYLNn4vszsCHSZHBnuzWuUb8yP6Q2vzhmWJG9a7MCLAJUMCMr2+sj+hwguzGK6O1L8sJAtJ4/wSJz4xyyhRPsxr4+xuhM3hS5yn0Tynu/XPFS/EHhY+ZEtEnwJqnLXxI8K0ktmjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838220; c=relaxed/simple;
	bh=rCK0XmdfirdTjBzYP6rjoHXY9+FRkmLuEnUZBr+vqXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BbKgv1c5nlHa/hzpRdj2XI7qgIVEosKH0mOHd3iwgew3is7zvIY3OJrCBm9qLFORu0Gb7TrO7ttN2+B3Tt4eQ8Lc0TxtxPK0MK53RQ01scVdIzTxf9KEylhQSwa4qkSDzQ6GRBLQmUNm08Wo7w4AD8J/7whSvNvOYSl7JxI2/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqmchAm8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRT4StSM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756838216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCK0XmdfirdTjBzYP6rjoHXY9+FRkmLuEnUZBr+vqXk=;
	b=iqmchAm8KnDwQOOjAfyHMSNgR2/bqyjy9UVQaKrwBHG81Wz8Fmf9y3xDsJvAPExOtZ96Pr
	+leETdBLFiRhoc8uKOHJqFfwODJ9mc9i62FtiwJnuo2cxOrpNi1XO8QBJ8fRiI2FalXyCT
	sxLWWnzSxMW2nuL3OgP/6tqa/okk53SM3bN9rJx0XPPq1mYkgVar9itt1x1dub+MNhI9cW
	6cWowCzXktnYuy93yJh1vQYXuCalNGyjZoFhoC7QvlaTJTZ05zRX9e4IAyhr5ZlZHoUzYA
	oV2uZbGnvZnd+7xzGrTHCsKPVoA4wpVPy1yZXx6WnUSitHPXjb8+fxiX31V6Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756838216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCK0XmdfirdTjBzYP6rjoHXY9+FRkmLuEnUZBr+vqXk=;
	b=PRT4StSMELZKwpYRKmGWd12NxutTM7OL4rcGtSEJMUZYUAdmbLwZDRiJ5t5xATKPP5NKD3
	OO0jzBFuv9Dlq3Ag==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 28/37] rseq: Switch to fast path processing on exit
 to user
In-Reply-To: <02e74cef-f2fe-4590-8921-ef4df2b24786@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.063205235@linutronix.de>
 <bf216d3c-9d9a-45e4-b7a6-64c0c3cbe6ed@efficios.com>
 <02e74cef-f2fe-4590-8921-ef4df2b24786@efficios.com>
Date: Tue, 02 Sep 2025 20:36:55 +0200
Message-ID: <87iki0zooo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCBBdWcgMjcgMjAyNSBhdCAwOTo0NSwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+
IE9uIDIwMjUtMDgtMjYgMTE6NDAsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPj4+IMKgwqAg
UlNFUSBzZWxmdGVzdHPCoMKgwqDCoMKgIEJlZm9yZcKgwqDCoMKgwqDCoMKgwqDCoCBBZnRlcsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJlZHVjdGlvbg0KPj4+DQo+Pj4gwqDCoCBleGl0IHRv
IHVzZXI6wqDCoMKgwqDCoMKgIDM4NjI4MTc3OMKgwqDCoMKgwqDCoMKgwqDCoCAzODczNzM3NTAN
Cj4+PiDCoMKgIHNpZ25hbCBjaGVja3M6wqDCoMKgwqDCoMKgIDM1NjYxMjAzwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTAwJQ0KPj4+IMKg
wqAgc2xvd3BhdGggcnVuczrCoMKgwqDCoMKgIDE0MDU0MjM5NiAzNi4zOCXCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDEwMMKgIDAuMDAlwqDCoMKgIDEwMCUNCj4+PiDCoMKgIGZhc3RwYXRoIHJ1bnM6
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDk1MDk3ODnC
oCAyLjUxJcKgwqDCoMKgIE4vQQ0KPj4+IMKgwqAgaWQgdXBkYXRlczrCoMKgwqDCoMKgwqDCoMKg
IDE3NjIwMzU5OSA0NS42MiXCoMKgwqDCoMKgwqDCoCA5MDg3OTk0wqAgMi4zNSXCoMKgwqDCoCA5
NSUNCj4+PiDCoMKgIGNzIGNoZWNrczrCoMKgwqDCoMKgwqDCoMKgwqAgMTc1NTg3ODU2IDQ1LjQ2
JcKgwqDCoMKgwqDCoMKgIDQ3MjgzOTTCoCAxLjIyJcKgwqDCoMKgIDk4JQ0KPj4+IMKgwqDCoMKg
IGNzIGNsZWFyZWQ6wqDCoMKgwqDCoMKgIDE3MjM1OTU0NMKgwqAgOTguMTYlwqDCoMKgIDEzMTkz
MDfCoMKgIDI3LjkwJcKgwqAgOTklDQo+Pj4gwqDCoMKgwqAgY3MgZml4dXA6wqDCoMKgwqDCoMKg
wqDCoMKgwqAgMzIyODMxMsKgwqDCoCAxLjg0JcKgwqDCoCAzNDA5MDg3wqDCoCA3Mi4xMCUNCj4N
Cj4gQnkgdGhlIHdheSwgeW91IHNob3VsZCByZWFsbHkgbm90IGJlIHVzaW5nIHRoZSBlbnRpcmUg
cnNlcSBzZWxmdGVzdHMNCj4gYXMgYSByZXByZXNlbnRhdGl2ZSB3b3JrbG9hZCBmb3IgcHJvZmls
aW5nIHRoZSBrZXJuZWwgcnNlcSBpbXBsZW1lbnRhdGlvbi4NCj4NCj4gVGhvc2Ugc2VsZnRlc3Rz
IGluY2x1ZGUgImxvb3AgaW5qZWN0aW9uIiwgInlpZWxkIGluamVjdGlvbiIsICJraWxsDQo+IGlu
amVjdGlvbiIgYW5kICJzbGVlcCBpbmplY3Rpb24iIHdpdGhpbiB0aGUgcmVsZXZhbnQgdXNlcnNw
YWNlIGNvZGUNCj4gcGF0aHMsIHdoaWNoIHJlYWxseSBpbmNyZWFzZSB0aGUgbGlrZWxpaG9vZCBv
ZiBoaXR0aW5nIHN0dWZmIGxpa2UNCj4gImNzIGZpeHVwIiBjb21wYXJlZCB0byBhbnl0aGluZyB0
aGF0IGNvbWVzIGNsb3NlIHRvIGEgcmVhbGlzdGljDQo+IHVzZS1jYXNlLiBUaGlzIGlzIHJlYWxs
eSB1c2VmdWwgZm9yIHRlc3RpbmcgY29ycmVjdG5lc3MsIGJ1dCBub3QNCj4gZm9yIHByb2ZpbGlu
Zy4gRm9yIGluc3RhbmNlLCB0aGUgImxvb3AgaW5qZWN0aW9uIiBpbnRyb2R1Y2VzIGJ1c3kNCj4g
bG9vcHMgd2l0aGluIHJzZXEgY3JpdGljYWwgc2VjdGlvbnMgdG8gc2lnbmlmaWNhbnRseSBpbmNy
ZWFzZSB0aGUNCj4gbGlrZWxpaG9vZCBvZiBoaXR0aW5nIGEgY3MgZml4dXAuDQo+DQo+IFRob3Nl
IHNwZWNpZmljIHNlbGZ0ZXN0cyBhcmUgcmVhbGx5IGp1c3QgInN0cmVzcy10ZXN0cyIgdGhhdCBk
b24ndA0KPiByZXByZXNlbnQgYW55IHJlbGV2YW50IHdvcmtsb2FkLg0KDQpUcnVlLCB0aGV5IHN0
aWxsIHRlbGwgaG93IG11Y2ggdXNlbGVzcyB3b3JrIHRoZSBrZXJuZWwgd2FzIGRvaW5nLCBubz8N
Cg0K

