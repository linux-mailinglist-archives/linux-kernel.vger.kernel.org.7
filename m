Return-Path: <linux-kernel+bounces-734596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C9B083AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB141AA37C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64AE19DF4F;
	Thu, 17 Jul 2025 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Lm45qLxx"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336210E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752725913; cv=none; b=JIt3zOXFtcHO0WfggMOsRRkICvbPmBSz/QryDuYgBQi9O4jfYzXlyrblXesijjOYrOMg3swfWZuJBBl9Fq3gx2vzYiwciwr8Hp7YThIcqs313ItcYmO6H2ZkFflpjtxBRXZycuv/Q9TxMDIkXXUS5+7ZTtDWHkoXXQUClBQGeUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752725913; c=relaxed/simple;
	bh=RnJLO/v1fQSiWlcGn39WKLzt5tvswFqH7jj8Pb/YvK8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OkKSBccHVZCh7rz02hsQBPM8SuPL2SoTYwESoqAdFqavYGb3lnVDZxWJytOmSUqvaJYIFguUjpvXQSH4if9TYHPDiPDJHsYiaFEIrwlB1G3hyWiaashOHifs9C5Fv6SQx/UjCtwvQJKAPyfsnv0YP02efMJa1yukwpM17KzKeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Lm45qLxx; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E45F82C0117
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:18:19 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1752725899;
	bh=RnJLO/v1fQSiWlcGn39WKLzt5tvswFqH7jj8Pb/YvK8=;
	h=From:To:Subject:Date:From;
	b=Lm45qLxx8wuYbZoFQiFXm87cUGDxzGINWPs4ReLTv0e1B02XnOTWZMd8k34tqz0XJ
	 Mhkcs80SU5iVGhmXv2JKQHTaZs9W89dEwoGe35HB/8Hj8QIIBEYI12R4SoPGu7mezi
	 FgBo+aUkf8LT+N+Z3MXHTDjsCLobBaoHlC7wwylGjyUfuH9Edi81cqSK611s9ug/D9
	 yHdI/vVdDiq0VFPfRNoG+twgza7csuzc8dPls3My7BYrLUTDlx9JLyw+3Ef3K1fC+L
	 HT1MgYO9M5Rm2x0zxnmTLx03xIJTXqSI+cWI+5MnWEyVBVtR+dmgDQTT5t1dQ3yv4C
	 dJF/8GkmdJzlg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6878798b0001>; Thu, 17 Jul 2025 16:18:19 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Jul 2025 16:18:19 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 17 Jul 2025 16:18:19 +1200
From: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
To: "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Can we backport EEVDF performance fixes to 6.6?
Thread-Topic: Can we backport EEVDF performance fixes to 6.6?
Thread-Index: AQHb9tHT3Q5UjvfP10GbJQSqoSthJQ==
Date: Thu, 17 Jul 2025 04:18:19 +0000
Message-ID: <00d0bd1d13ad2faa3766fd16394f882ff8e286c4.camel@alliedtelesis.co.nz>
Accept-Language: en-GB, en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE3169002DD5D845B2BB1244D5C326DE@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=6878798b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=VjDc-5qXZTcA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=eDvNx5fD_qJSw6CNI3gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0

SGkgQWxsLA0KDQpBZnRlciB1cGdyYWRpbmcgYSBwcm9kdWN0IGZyb20gNS4xNSB0byA2LjYsIHdl
IGZvdW5kIHRoYXQgcGVyZm9ybWFuY2UNCnRvb2sgYSBoaXQgb24gc29tZSB3b3JrbG9hZHMuIE5h
cnJvd2VkIHRoaXMgZG93biB0byB0aGUgc3dpdGNoIHRvDQpFRVZERi4NCg0KSSBiYWNrcG9ydGVk
IGNvbW1pdCA2ZDcxYTljNjE2MDQgInNjaGVkL2ZhaXI6IEZpeCBFRVZERiBlbnRpdHkNCnBsYWNl
bWVudCBidWcgY2F1c2luZyBzY2hlZHVsaW5nIGxhZyIgd2hpY2ggYXBwZWFycyB0byBtb3N0bHkg
cmVzb2x2ZQ0KdGhlIGlzc3VlLg0KDQpJIGFsc28gYXBwbGllZCByZWxhdGVkIGNvbW1pdHMgNDQy
M2FmODRiMjk3ICJzY2hlZC9mYWlyOiBvcHRpbWl6ZSB0aGUNClBMQUNFX0xBRyB3aGVuIHNlLT52
bGFnIGlzIHplcm8iIGFuZCBjNzBmYzMyZjQ0NDMgInNjaGVkL2ZhaXI6IEFkaGVyZQ0KdG8gcGxh
Y2VfZW50aXR5KCkgY29uc3RyYWludHMiIHRvIGF2b2lkIHRoZSB3YXJuaW5ncyByZWZlcmVuY2Vk
IHRoZXJlLg0KDQpDYW4gdGhlc2UgcGF0Y2hlcyBiZSBzYWZlbHkgYmFja3BvcnRlZCB0byA2LjY/
IFdlIHdvdWxkIHByZWZlciB0byB1c2UNCmFuIG9mZmljaWFsIDYuNiByZWxlYXNlIHdpdGggdGhl
IGZpeGVzLg0KT3RoZXJ3aXNlIHdlIGhhdmUgdG8gd2FpdCBmb3IgdGhlIG5leHQgTFRTIHRvIGdl
dCB0aGVzZSBjaGFuZ2VzIHdoaWNoDQp3ZXJlIHB1dCBpbiA2LjEzLg0KDQpSZWdhcmRzLA0KVGhv
bWFzIFdpbnRlcg0K

