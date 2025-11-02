Return-Path: <linux-kernel+bounces-881987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA51C29613
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 193D44E390A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9DA136658;
	Sun,  2 Nov 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ys6iFT68"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFC208AD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114351; cv=none; b=fXM/GAkmFUg5FjdWe2g3trZ8ElJft0i3XzaEmRFL4GidZixPWKt2i1hmoqyvI6i/B7shiGDpjWdCiI7+N254mC3wtzR7MOer0/4RFh04NDROIc5fpYWTsdI++g2TMIbJxaiP9YSOSb1k7CERjCHQYVrm4KNZrhH/E6o+sPsZnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114351; c=relaxed/simple;
	bh=NZMTtMYRe9Kq/ywWt/Kr6+E+er/gdiX8awljfJ6QaII=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n2wsJrExVtnChK/TtSV+mINvyyM+qnOgr626auqqfKD7OJ5T65vghduvET/ekqr3Pn2KYHBvg+GiPKh38pBo5a9KIPC+Wlv8ycqVoEkeeMjZBtXv/nw5h4/Z+KUVE+VBKBEamNGAMpSoa3dLeanL49P4YpvW46NIS+kXY9TeOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ys6iFT68; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AA1232C0288;
	Mon,  3 Nov 2025 09:05:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1762113935;
	bh=NZMTtMYRe9Kq/ywWt/Kr6+E+er/gdiX8awljfJ6QaII=;
	h=From:To:CC:Subject:Date:From;
	b=ys6iFT68UNbDkMYS5K31z8wG/aJt5oeiUptsBjrxJ1jUbuTQmtCWcoNvEgItAjv6u
	 ogOTNJH5RWxocsNs2Uj1yl45YZVWmn6G6Eb7DNuQptkCWklR9wzmT9g5IeV7p6fk2v
	 bebs20EAfceum7wPkwHj4dfpj4VFmK5Qz/oadLwbvuR4e5qN6wGzfDCucMzzVrSKeo
	 AsmrmpscbUk6px7sELAO5+ixSVHwP3ioc8IeOgM0hnh5Xl/Ov6RxChPlDOeKbtxwWG
	 YEajLWfIVtZHsqIQld2VFkZ1Ugza4u+NQLN0i4IorafqZPOWhLc18iLlicHxwrCYLC
	 5h8R00zAv+H7g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6907b98f0001>; Mon, 03 Nov 2025 09:05:35 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 3 Nov 2025 09:05:35 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 3 Nov 2025 09:05:35 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>
CC: "OCP-ONIE@OCP-All.groups.io" <OCP-ONIE@OCP-All.groups.io>
Subject: vmlinux.o: warning: objtool: elf_update: invalid section alignment
Thread-Topic: vmlinux.o: warning: objtool: elf_update: invalid section
 alignment
Thread-Index: AQHcTDQMd9kEIf9faEqFI8ZJY4aLcw==
Date: Sun, 2 Nov 2025 20:05:35 +0000
Message-ID: <9024a693-d300-4428-ae11-b5a852113e25@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <24651EBC1B169E43A6E022323ACB6D3B@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=HOlgFZtv c=1 sm=1 tr=0 ts=6907b98f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=xNf9USuDAAAA:8 a=NEAV23lmAAAA:8 a=OwRkfR5kdEYImu0SQr8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGksDQoNCkknbSBpbnZlc3RpZ2F0aW5nIGJyaW5naW5nIE9OSUVbMV0gdXAgdG8gZGF0ZSB3aXRo
IHJlc3BlY3QgdG8ga2VybmVsIGFuZCANCnRvb2xjaGFpbiB2ZXJzaW9ucy4NCg0KSSd2ZSB1cGRh
dGVkIHRoZSB0b29sY2hhaW4gYW5kIHRoaW5ncyBzZWVtIGhhcHB5IHdpdGggbGludXgtNS40Ljg2
LiBCdXQgDQp3aGVuIEkgdHJ5IGxpbnV4LTYuMTIuNTUgSSBoaXQgdGhlIGZvbGxvd2luZyBlcnJv
ciBmcm9tIG9ianRvb2wNCg0Kdm1saW51eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBlbGZfdXBkYXRl
OiBpbnZhbGlkIHNlY3Rpb24gYWxpZ25tZW50DQptYWtlWzNdOiAqKiogW3NjcmlwdHMvTWFrZWZp
bGUudm1saW51eF9vOjY1OiB2bWxpbnV4Lm9dIEVycm9yIDI1NQ0KbWFrZVszXTogKioqIERlbGV0
aW5nIGZpbGUgJ3ZtbGludXgubycNCm1ha2VbMl06ICoqKiANClsvaG9tZS9jaHJpc3Avc3JjL29u
aWUvYnVpbGQvYWxsaWVkdGVsZXNpc194OTgwXzMyY3EtcjAva2VybmVsL2xpbnV4LTYuMTIuNTUv
TWFrZWZpbGU6MTE2MTogDQp2bWxpbnV4X29dIEVycm9yIDINCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6MjI0OiBfX3N1Yi1tYWtlXSBFcnJvciAyDQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAN
CicvaG9tZS9jaHJpc3Avc3JjL29uaWUvYnVpbGQvYWxsaWVkdGVsZXNpc194OTgwXzMyY3EtcjAv
a2VybmVsL2xpbnV4LTYuMTIuNTUnDQptYWtlOiAqKiogW21ha2Uva2VybmVsLm1ha2U6MTIwOiAN
Ci9ob21lL2NocmlzcC9zcmMvb25pZS9idWlsZC9hbGxpZWR0ZWxlc2lzX3g5ODBfMzJjcS1yMC9z
dGFtcC9rZXJuZWwtYnVpbGRdIA0KRXJyb3IgMg0KDQpJIGFsc28gdHJpZWQgNi42LjExNSBhbmQg
Z2V0IHRoZSBzYW1lIGVycm9yDQoNCkRvZXMgdGhpcyByaW5nIGFueSBiZWxscz8NCg0KSSdtIGJ1
aWxkaW5nIGluc2lkZSBhIGRvY2tlciBjb250YWluZXIgYmFzZWQgb24gZGViaWFuIDExLg0KDQpQ
UkVUVFlfTkFNRT0iRGViaWFuIEdOVS9MaW51eCAxMSAoYnVsbHNleWUpIg0KTkFNRT0iRGViaWFu
IEdOVS9MaW51eCINClZFUlNJT05fSUQ9IjExIg0KVkVSU0lPTj0iMTEgKGJ1bGxzZXllKSINClZF
UlNJT05fQ09ERU5BTUU9YnVsbHNleWUNCklEPWRlYmlhbg0KSE9NRV9VUkw9Imh0dHBzOi8vd3d3
LmRlYmlhbi5vcmcvIg0KU1VQUE9SVF9VUkw9Imh0dHBzOi8vd3d3LmRlYmlhbi5vcmcvc3VwcG9y
dCINCkJVR19SRVBPUlRfVVJMPSJodHRwczovL2J1Z3MuZGViaWFuLm9yZy8iDQoNCkknbSBhYmxl
IHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgYnVpbGRpbmcgdGhlIGtlcm5lbCB1c2luZyB0aGUgT05J
RSBidWlsdCANCmNyb3NzLWNvbXBpbGVyICh1c2luZyBjcm9zc3Rvb2wtbmcgdW5kZXIgdGhlIGhv
b2QpIGJ1dCBub3Qgd2l0aCB0aGUgDQpuYXRpdmUgb25lLiBIb3dldmVyIEkgZG9uJ3Qgc2VlIGFu
IGlzc3VlIGluIGFub3RoZXIgY3Jvc3N0b29sLW5nIA0KZW52aXJvbm1lbnQgYnVpbGRpbmcgdGhl
IHNhbWUgdG9vbHMgKGJhc2VkIG9uIGRlYmlhbiAxMiBzbyBpdCBtaWdodCBub3QgDQpiZSBhIGZh
aXIgY29tcGFyaXNvbikuDQoNClRoYW5rcywNCkNocmlzDQoNCi0tDQoNClsxXSAtIGh0dHBzOi8v
Z2l0aHViLmNvbS9vcGVuY29tcHV0ZXByb2plY3Qvb25pZS8NCg==

