Return-Path: <linux-kernel+bounces-873698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89089C14789
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C579198404B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B630EF77;
	Tue, 28 Oct 2025 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="nlSmsc6o"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2B30CD87
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652261; cv=none; b=mej7TTEwiC3ZgnuWMmjSm2l3cfPSL5e8qvkZnL/J8pJjNaj1c6A+nYSN4j9DTFDs6gTyOHS9ejMesjKmCp2/kSULgy4M3RdBqC5u2JAiEBxbhuEBKc2AwlQuBuLiAenaObTLGymBqi/GqLBjDoIzBY0thjgv1hlPufFUB470a8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652261; c=relaxed/simple;
	bh=NkLd5UYTzj9lW+l5AT+cU07zAyt4nK8Xq/BHvjkBUzg=;
	h=To:Cc:From:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID:MIME-Version; b=AYBGWDC5Pc1nwcTkG+YrIW7CKVfFuqrjkCxpr68kBezhNAYMqqCLk9l73kljynOkBuDWhMrx6je9lincCLyb1nadOo7XETfrsy/pIS9NB2Oq+vfds5dApvnGFHmW/oQnHRv3UTxUitV1or274fQxE9smyuXqNiikHaTY6wyd9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=nlSmsc6o; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [10.199.9.117] (unknown [93.183.52.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id B438A68F61F;
	Tue, 28 Oct 2025 12:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761652256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NkLd5UYTzj9lW+l5AT+cU07zAyt4nK8Xq/BHvjkBUzg=;
	b=nlSmsc6oyrI1i574woIW8XFc6lcPKHbdvOCOKSAtXBokqW8Q1TNQXeExMFx8ZO04Wldk0b
	VmKlJGMTOaNFSyv05Ld5CTJLxYmeu7iKxyeAG/Tb4M9e+MqETz9JaEqkbExM6oc+u1zrud
	c8Fjo8T2OynCMqw3vBjlgku8LwYggKb8214TZaNKf/iD+QtSWFCJYqW9PgI+XmqvJKs3lp
	ogLXOdB1si30dm33QBncRGKLfmcM/zQu2S8O9dVKoI5hsacX1DgXKEDabEKW6gDT9GC4cl
	kBXWJZLzpKL/c1nQyvHIu1jrVh6vpzT9l5vZ0CAjn6EgF7wABVyOD3Pi7OYFXQ==
X-Priority: 3
To: broonie@kernel.org
Cc: gregkh@linuxfoundation.org,rafael@kernel.org,dakr@kernel.org,
 linux-kernel@vger.kernel.org
From: Sander Vanheule <sander@svanheule.net>
Subject: Re: [PATCH v5 1/2] regmap: add flat cache with sparse validity
In-Reply-To: <86d8d275-2552-49f1-b6b1-3fdb543d70f3@sirena.org.uk>
References: <20251023135032.229511-1-sander@svanheule.net>
 <20251023135032.229511-2-sander@svanheule.net>
 <86d8d275-2552-49f1-b6b1-3fdb543d70f3@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Date: Tue, 28 Oct 2025 11:50:55 +0000
Message-ID: <vi1wqm.t4ubkw.2zniph-qmf@polaris.svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTWFyaywNCg0KT24gVHVlc2RheSwgMjggT2N0b2JlciAyMDI1LCBNYXJrIEJyb3duIHdyb3Rl
Og0KPiBPbiBUaHUsIE9jdCAyMywgMjAyNSBhdCAwMzo1MDozMVBNICswMjAwLCBTYW5kZXIgVmFu
aGV1bGUgd3JvdGU6DQo+IA0KPiA+IC0JbWFwLT5jYWNoZSA9IGtjYWxsb2MocmVnY2FjaGVfZmxh
dF9nZXRfaW5kZXgobWFwLCBtYXAtPm1heF9yZWdpc3RlcikNCj4gPiAtCQkJICAgICArIDEsIHNp
emVvZih1bnNpZ25lZCBpbnQpLCBtYXAtPmFsbG9jX2ZsYWdzKTsNCj4gDQo+ID4gKwljYWNoZSA9
IGttYWxsb2MoY2FjaGVfZGF0YV9zaXplLCBtYXAtPmFsbG9jX2ZsYWdzKTsNCj4gDQo+IGtjYWxs
b2MoKSBkb2VzIGEgemVybyBpbml0aWFsaXNhdGlvbiBzbyBzaG91bGQgYmUgcmVwbGFjZSBieSBr
emFsbG9jKCkNCj4gcmF0aGVyIHRoYW4ga21hbGxvYygpLCBvdGhlcndpc2Ugd2UgYnJlYWsgZXhp
c3RpbmcgdXNlcnMgd2hvIHJlbHkgb24gdGhlDQo+IHplcm8gaW5pdGlhbGlzYXRpb24uDQoNCk9m
IGNvdXJzZS4gVGhlIGludGVudGlvbiBpcyB0byBtYWludGFpbiBiYWNrd2FyZCBjb21wYXRpYmls
aXR5IHdpdGggdGhlIGN1cnJlbnQgZmxhdCBjYWNoZSwgc28gSSdsbCBzZW5kIGEgcmVzcGluIGFt
ZW5kaW5nIHRoaXMuDQoNCkJlc3QsDQpTYW5kZXI=

