Return-Path: <linux-kernel+bounces-882048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B1C29808
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6E714E5C5E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFE21B191;
	Sun,  2 Nov 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="A212CoPs"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15B1E9B3D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762120912; cv=none; b=cRT+PUP2pNCKK3jZqsJUNYHEvsQOd9okUgh2IarZbUdELralS7VB+EgsLV1D71DwY61XmErNaIoeTxSwsmAwhWlIE1DVShNBEO148Ns9cjF8N8BFwLKefp4Q+vi8gMozYUGdk1wOL62+NBDgsbEyXcu6jNDINYNota8gq5ANnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762120912; c=relaxed/simple;
	bh=fwI4Uz1dEpekCxgjP9+8d/MXbZ+zSRXywbMk9z2OhVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I8ige9wcO0FJKAKE2CXbz6PVioQMPhPMt4ZkxWYAv+H9LXt95ODh2ALrBik6r0ytgrn6uCJP60Bf2GHdHxXK5niHkereyfVOQmfXwEzBZE/08Lfrqc62j3al8zuRFPKziN0XMkFNSY9EKZuzkcS4FmscFsAV5nxJ3duOhSw8pcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=A212CoPs; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EF5432C0992;
	Mon,  3 Nov 2025 11:01:44 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1762120904;
	bh=fwI4Uz1dEpekCxgjP9+8d/MXbZ+zSRXywbMk9z2OhVI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=A212CoPs+JJOFqBUImbq+24mACwzoVRw+40KFOuQ+ALRWJsWgn8R3Hg/15WSmQ5dC
	 sph3C+Ok1AJjSgUcSn2jbNgWFap/4zR38SYiQcUvnU1y+WxKMRDiuFgNezNEgMMfmh
	 tAR+H36yRcj8w/qgZcUSRFMiEeV78v5NzsBxv6FUEYbCt1PYx5tB0WaTp5yfJ2g2PG
	 rGIRXTt7hSBqZAHGlZ+PcOnfUJVO8jzo2517Se7I3KUv0PHo9yhathWor5Lpg7h11o
	 euPGtzcMIql57v8CxFn3VeF9oXDy97yIyvIboz3rzaSpGAPsvRvxlQVXbkvhdzfnX8
	 pdLdBdRw5TZeg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6907d4c80001>; Mon, 03 Nov 2025 11:01:44 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 3 Nov 2025 11:01:44 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 3 Nov 2025 11:01:44 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>
CC: "OCP-ONIE@OCP-All.groups.io" <OCP-ONIE@OCP-All.groups.io>
Subject: Re: vmlinux.o: warning: objtool: elf_update: invalid section
 alignment
Thread-Topic: vmlinux.o: warning: objtool: elf_update: invalid section
 alignment
Thread-Index: AQHcTDQMd9kEIf9faEqFI8ZJY4aLc7TfFjcA
Date: Sun, 2 Nov 2025 22:01:44 +0000
Message-ID: <8e5d1a33-ff5f-41ec-86a7-b93d44aed287@alliedtelesis.co.nz>
References: <9024a693-d300-4428-ae11-b5a852113e25@alliedtelesis.co.nz>
In-Reply-To: <9024a693-d300-4428-ae11-b5a852113e25@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EC717864901A142A2C380EA8BCC671C@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=HOlgFZtv c=1 sm=1 tr=0 ts=6907d4c8 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=xNf9USuDAAAA:8 a=nFlqbC9Y3rml_YqO7y8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAwMy8xMS8yMDI1IDA5OjA1LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBIaSwNCj4NCj4g
SSdtIGludmVzdGlnYXRpbmcgYnJpbmdpbmcgT05JRVsxXSB1cCB0byBkYXRlIHdpdGggcmVzcGVj
dCB0byBrZXJuZWwgDQo+IGFuZCB0b29sY2hhaW4gdmVyc2lvbnMuDQo+DQo+IEkndmUgdXBkYXRl
ZCB0aGUgdG9vbGNoYWluIGFuZCB0aGluZ3Mgc2VlbSBoYXBweSB3aXRoIGxpbnV4LTUuNC44Ni4g
DQo+IEJ1dCB3aGVuIEkgdHJ5IGxpbnV4LTYuMTIuNTUgSSBoaXQgdGhlIGZvbGxvd2luZyBlcnJv
ciBmcm9tIG9ianRvb2wNCj4NCj4gdm1saW51eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBlbGZfdXBk
YXRlOiBpbnZhbGlkIHNlY3Rpb24gYWxpZ25tZW50DQo+IG1ha2VbM106ICoqKiBbc2NyaXB0cy9N
YWtlZmlsZS52bWxpbnV4X286NjU6IHZtbGludXgub10gRXJyb3IgMjU1DQo+IG1ha2VbM106ICoq
KiBEZWxldGluZyBmaWxlICd2bWxpbnV4Lm8nDQo+IG1ha2VbMl06ICoqKiANCj4gWy9ob21lL2No
cmlzcC9zcmMvb25pZS9idWlsZC9hbGxpZWR0ZWxlc2lzX3g5ODBfMzJjcS1yMC9rZXJuZWwvbGlu
dXgtNi4xMi41NS9NYWtlZmlsZToxMTYxOiANCj4gdm1saW51eF9vXSBFcnJvciAyDQo+IG1ha2Vb
MV06ICoqKiBbTWFrZWZpbGU6MjI0OiBfX3N1Yi1tYWtlXSBFcnJvciAyDQo+IG1ha2VbMV06IExl
YXZpbmcgZGlyZWN0b3J5IA0KPiAnL2hvbWUvY2hyaXNwL3NyYy9vbmllL2J1aWxkL2FsbGllZHRl
bGVzaXNfeDk4MF8zMmNxLXIwL2tlcm5lbC9saW51eC02LjEyLjU1Jw0KPiBtYWtlOiAqKiogW21h
a2Uva2VybmVsLm1ha2U6MTIwOiANCj4gL2hvbWUvY2hyaXNwL3NyYy9vbmllL2J1aWxkL2FsbGll
ZHRlbGVzaXNfeDk4MF8zMmNxLXIwL3N0YW1wL2tlcm5lbC1idWlsZF0gDQo+IEVycm9yIDINCj4N
Cj4gSSBhbHNvIHRyaWVkIDYuNi4xMTUgYW5kIGdldCB0aGUgc2FtZSBlcnJvcg0KPg0KPiBEb2Vz
IHRoaXMgcmluZyBhbnkgYmVsbHM/DQo+DQo+IEknbSBidWlsZGluZyBpbnNpZGUgYSBkb2NrZXIg
Y29udGFpbmVyIGJhc2VkIG9uIGRlYmlhbiAxMS4NCj4NCj4gUFJFVFRZX05BTUU9IkRlYmlhbiBH
TlUvTGludXggMTEgKGJ1bGxzZXllKSINCj4gTkFNRT0iRGViaWFuIEdOVS9MaW51eCINCj4gVkVS
U0lPTl9JRD0iMTEiDQo+IFZFUlNJT049IjExIChidWxsc2V5ZSkiDQo+IFZFUlNJT05fQ09ERU5B
TUU9YnVsbHNleWUNCj4gSUQ9ZGViaWFuDQo+IEhPTUVfVVJMPSJodHRwczovL3d3dy5kZWJpYW4u
b3JnLyINCj4gU1VQUE9SVF9VUkw9Imh0dHBzOi8vd3d3LmRlYmlhbi5vcmcvc3VwcG9ydCINCj4g
QlVHX1JFUE9SVF9VUkw9Imh0dHBzOi8vYnVncy5kZWJpYW4ub3JnLyINCj4NCj4gSSdtIGFibGUg
dG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBidWlsZGluZyB0aGUga2VybmVsIHVzaW5nIHRoZSBPTklF
IA0KPiBidWlsdCBjcm9zcy1jb21waWxlciAodXNpbmcgY3Jvc3N0b29sLW5nIHVuZGVyIHRoZSBo
b29kKSBidXQgbm90IHdpdGggDQo+IHRoZSBuYXRpdmUgb25lLiBIb3dldmVyIEkgZG9uJ3Qgc2Vl
IGFuIGlzc3VlIGluIGFub3RoZXIgY3Jvc3N0b29sLW5nIA0KPiBlbnZpcm9ubWVudCBidWlsZGlu
ZyB0aGUgc2FtZSB0b29scyAoYmFzZWQgb24gZGViaWFuIDEyIHNvIGl0IG1pZ2h0IA0KPiBub3Qg
YmUgYSBmYWlyIGNvbXBhcmlzb24pLg0KDQpCaXQgb2YgYW4gdXBkYXRlLiBJIGNyZWF0ZWQgYSBm
cmVzaCBkZWJpYW4gMTEgYmFzZWQgY29udGFpbmVyIGFuZCBhbSANCmFibGUgdG8gcmVwcm9kdWNl
IHRoZSBwcm9ibGVtIHdpdGggdGhlIG9uaWUgdG9vbGNoYWluIGNvbmZpZywgdGhlIA0KZGVmYXVs
dCBjcm9zc3Rvb2wtbmcgeDg2XzY0LXVua25vd24tbGludXgtdWNsaWJjIHNhbXBsZSBhbmQgdGhl
IGRlZmF1bHQgDQpjcm9zc3Rvb2wtbmcgeDg2XzY0LXVua25vd24tbGludXgtZ251IHNhbXBsZS4=

