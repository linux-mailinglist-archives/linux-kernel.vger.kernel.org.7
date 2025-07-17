Return-Path: <linux-kernel+bounces-734603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15278B083C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279B97B8349
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240371E25E1;
	Thu, 17 Jul 2025 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="WbZceeLZ"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6610E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726455; cv=none; b=PXlrFHVapqQgW9e542kpEMf/wPON4wREzE40jllp5LKW9uCNK9iVQj5BP9mDPzfwv6Z+YU+teBfh7GYg/bNCAmPG3GwRdY1v5O7cOKlq7yuA3OTemOIb60yfq0s5tjj5T2gpAAjC/QeWc+QqoXKTjN2EmSYlvOSNNxVV9GDujIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726455; c=relaxed/simple;
	bh=QrT92ps0v7Bt0aQjZ7hJc+9L1bDeOv4oR9epCLRynGM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q6nGq5ged3ZKrkONRCDij3KUPuIWCczawSjC6Qi5BEmDdJfWeKVPCIvSEkONMhkg7b3sGUhCsKvb4aXvd56hURyhLiGaBno/TKYKR8yViy7sqacjG77rpjjbBZ3wzWqClEkskxPfNdqKGmAcplfbHY227XzScnqqynuCZqt0zEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=WbZceeLZ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 836C22C0117
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:27:29 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1752726449;
	bh=QrT92ps0v7Bt0aQjZ7hJc+9L1bDeOv4oR9epCLRynGM=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=WbZceeLZi/I1lTkTXpceBoOgGR8xmzoS7ADLS1vUJjIHdUrYUWcVh6Xr6TB9ciaRl
	 CmH3EdpLUkCEoWjYQItk4biAuQNQ5NC/uB2CZl5QUB6ITRjQy8kJn+ad4sZ2glpbKQ
	 SEfoSrF2CMnX9Xew6fP4hr31YmAxsDlrsTGpGRxHpNSxqWaESdSLJy+tDiLhi+X60m
	 yHwuwUAcmC4WzXEVCsszN64cY5xCbQauN9l6KakrqTPSmc+JekWw4urQ/WseP71BNL
	 eLaDFpfvYVPQ2EDFaa1xa6jX1jjAM7rGitU+cnA5gLkqQWgB1PdV7SUDLzIHtsC4Xd
	 jzirZu7cQXI+A==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68787bb10001>; Thu, 17 Jul 2025 16:27:29 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Jul 2025 16:27:29 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 17 Jul 2025 16:27:29 +1200
From: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: Can we backport EEVDF performance fixes to 6.6?
Thread-Topic: Can we backport EEVDF performance fixes to 6.6?
Thread-Index: AQHb9tHT3Q5UjvfP10GbJQSqoSthJbQ072YA
Date: Thu, 17 Jul 2025 04:27:29 +0000
Message-ID: <7f37262c1b6ffc0cc6689fef451f170a5e005f08.camel@alliedtelesis.co.nz>
References: <00d0bd1d13ad2faa3766fd16394f882ff8e286c4.camel@alliedtelesis.co.nz>
In-Reply-To: <00d0bd1d13ad2faa3766fd16394f882ff8e286c4.camel@alliedtelesis.co.nz>
Accept-Language: en-GB, en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF26E91A79D8854293D1C73FA8EB243F@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=68787bb1 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=VjDc-5qXZTcA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=u8ai2bCKtXQp6k1WG5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0

T24gVGh1LCAyMDI1LTA3LTE3IGF0IDE2OjE4ICsxMjAwLCBUaG9tYXMgV2ludGVyIHdyb3RlOg0K
PiBIaSBBbGwsDQo+IA0KPiBBZnRlciB1cGdyYWRpbmcgYSBwcm9kdWN0IGZyb20gNS4xNSB0byA2
LjYsIHdlIGZvdW5kIHRoYXQgcGVyZm9ybWFuY2UNCj4gdG9vayBhIGhpdCBvbiBzb21lIHdvcmts
b2Fkcy4gTmFycm93ZWQgdGhpcyBkb3duIHRvIHRoZSBzd2l0Y2ggdG8NCj4gRUVWREYuDQo+IA0K
PiBJIGJhY2twb3J0ZWQgY29tbWl0IDZkNzFhOWM2MTYwNCAic2NoZWQvZmFpcjogRml4IEVFVkRG
IGVudGl0eQ0KPiBwbGFjZW1lbnQgYnVnIGNhdXNpbmcgc2NoZWR1bGluZyBsYWciIHdoaWNoIGFw
cGVhcnMgdG8gbW9zdGx5IHJlc29sdmUNCj4gdGhlIGlzc3VlLg0KPiANCj4gSSBhbHNvIGFwcGxp
ZWQgcmVsYXRlZCBjb21taXRzIDQ0MjNhZjg0YjI5NyAic2NoZWQvZmFpcjogb3B0aW1pemUgdGhl
DQo+IFBMQUNFX0xBRyB3aGVuIHNlLT52bGFnIGlzIHplcm8iIGFuZCBjNzBmYzMyZjQ0NDMgInNj
aGVkL2ZhaXI6IEFkaGVyZQ0KPiB0byBwbGFjZV9lbnRpdHkoKSBjb25zdHJhaW50cyIgdG8gYXZv
aWQgdGhlIHdhcm5pbmdzIHJlZmVyZW5jZWQNCj4gdGhlcmUuDQo+IA0KPiBDYW4gdGhlc2UgcGF0
Y2hlcyBiZSBzYWZlbHkgYmFja3BvcnRlZCB0byA2LjY/IFdlIHdvdWxkIHByZWZlciB0byB1c2UN
Cj4gYW4gb2ZmaWNpYWwgNi42IHJlbGVhc2Ugd2l0aCB0aGUgZml4ZXMuDQo+IE90aGVyd2lzZSB3
ZSBoYXZlIHRvIHdhaXQgZm9yIHRoZSBuZXh0IExUUyB0byBnZXQgdGhlc2UgY2hhbmdlcyB3aGlj
aA0KPiB3ZXJlIHB1dCBpbiA2LjEzLg0KPiANCj4gUmVnYXJkcywNCj4gVGhvbWFzIFdpbnRlcg0K
DQpTb3JyeSBmb3IgcmVzZW5kaW5nLCBidXQgbXkgZW1haWwgZGVjaWRlZCBub3QgdG8gc2VuZCB0
byBJbmdvIG9yIFBldGVyLg0K

