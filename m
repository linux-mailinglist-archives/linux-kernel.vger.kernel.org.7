Return-Path: <linux-kernel+bounces-752787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8156B17ADB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B571C80CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B35335BA;
	Fri,  1 Aug 2025 01:32:22 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251C78F26
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011941; cv=none; b=IT3vS6a8D4ri3bfitQLy0IFTbenRgQECCwUkpRRea99mItfS+EUIvhyraGyvTqh6ytiV3gom0b91Pz8PREe03oPUWANvHCeU+NtImR1aLm7uzZdXWDk1AwbE8crI7Mjug+zzQdM9466afpsZ548WuKt04YuMv96HR0imjWc7uOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011941; c=relaxed/simple;
	bh=Vcgk6RSteVt4E5NCe9hHGOfjh7ffiwKHBcnW9JsSckM=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=mvJs33KtV5ZRk55Z3SgHru9yZ9TTaNUlOE8UqNYIwa0dh18QTRyBnbXKs7n68mssdmVZ53dN+cP9z/iuFnPSqKlmRXb/P4R7xWQD6oeG8LFPVhf2mQDIoZBk4aosvrz2CXCef21Yob39JyghSnDeJm2zt8o1DsbqeKmd2MC0a6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4btT2j2Wwwz5B13W;
	Fri, 01 Aug 2025 09:32:13 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 5711W0P2067624;
	Fri, 1 Aug 2025 09:32:00 +0800 (+08)
	(envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 1 Aug 2025 09:32:01 +0800 (CST)
Date: Fri, 1 Aug 2025 09:32:01 +0800 (CST)
X-Zmail-TransId: 2afb688c1911130-7b1d2
X-Mailer: Zmail v1.0
Message-ID: <20250801093201232CYacRrFIHaDJWsjc3rbNz@zte.com.cn>
In-Reply-To: <d339833a-5784-407b-816d-ab95d35fbe4e@ghiti.fr>
References: 20250725104425229ArF_W-F7CmscLJKs0yoiQ@zte.com.cn,d339833a-5784-407b-816d-ab95d35fbe4e@ghiti.fr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <alex@ghiti.fr>, <paul.walmsley@sifive.com>
Cc: <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <spersvold@gmail.com>,
        <sudeep.holla@arm.com>, <mikisabate@gmail.com>, <robh@kernel.org>,
        <liu.xuemei1@zte.com.cn>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gcmlzY3Y6IGNhY2hlaW5mbzogaW5pdCBjYWNoZSBsZXZlbHMgdmlhIGZldGNoX2NhY2hlX2luZm8gd2hlbiBTTVAgZGlzYWJsZWQ=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 5711W0P2067624
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 01 Aug 2025 09:32:13 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688C191D.003/4btT2j2Wwwz5B13W



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

T24gNy8zMS8yNSAyMToyOSwgYWxleEBnaGl0aS5mciB3cm90ZToNCj4gPiBGcm9tOiBKZXNzaWNh
IExpdSA8bGl1Lnh1ZW1laTFAenRlLmNvbS5jbj4NCj4gPg0KPiA+IEFzIGRlc2NyaWJlZCBpbiBj
b21taXQgMTg0NWQzODFmMjgwICgicmlzY3Y6IGNhY2hlaW5mbzogQWRkIGJhY2sNCj4gPiBpbml0
X2NhY2hlX2xldmVsKCkgZnVuY3Rpb24iKSwgd2hlbiBDT05GSUdfU01QIGlzIHVuZGVmaW5lZCwg
dGhlIGNhY2hlDQo+ID4gaGllcmFyY2h5IGRldGVjdGlvbiBuZWVkcyB0byBiZSBwZXJmb3JtZWQg
dGhyb3VnaCB0aGUgaW5pdF9jYWNoZV9sZXZlbCgpLA0KPiA+IHdoZXJlYXMgd2hlbiBDT05GSUdf
U01QIGlzIGRlZmluZWQsIHRoaXMgZGV0ZWN0aW9uIGlzIGhhbmRsZWQgZHVyaW5nIHRoZQ0KPiA+
IGluaXRfY3B1X3RvcG9sb2d5KCkgcHJvY2Vzcy4NCj4gPg0KPiA+IEZ1cnRoZXJtb3JlLCB3aGls
ZSBjb21taXQgNjYzODFkMzY3NzFlICgiUklTQy1WOiBTZWxlY3QgQUNQSSBQUFRUIGRyaXZlcnMi
KQ0KPiA+IGVuYWJsZXMgY2FjaGUgaW5mb3JtYXRpb24gcmV0cmlldmFsIHRocm91Z2ggdGhlIEFD
UEkgUFBUVCB0YWJsZSwgdGhlDQo+ID4gaW5pdF9vZl9jYWNoZV9sZXZlbCgpIGNhbGxlZCB3aXRo
aW4gaW5pdF9jYWNoZV9sZXZlbCgpIGNhbm5vdCBzdXBwb3J0IGNhY2hlDQo+ID4gaGllcmFyY2h5
IGRldGVjdGlvbiB0aHJvdWdoIEFDUEkgUFBUVC4gVGhlcmVmb3JlLCB3aGVuIENPTkZJR19TTVAg
aXMNCj4gPiB1bmRlZmluZWQsIHdlIGRpcmVjdGx5IGludm9rZSB0aGUgZmV0Y2hfY2FjaGVfaW5m
byBmdW5jdGlvbiB0byBpbml0aWFsaXplDQo+ID4gdGhlIGNhY2hlIGxldmVscy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEplc3NpY2EgTGl1IDxsaXUueHVlbWVpMUB6dGUuY29tLmNuPg0KPiA+
IC0tLQ0KPiA+ICAgYXJjaC9yaXNjdi9rZXJuZWwvY2FjaGVpbmZvLmMgfCA2ICsrKysrLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NhY2hlaW5mby5jIGIvYXJjaC9yaXNj
di9rZXJuZWwvY2FjaGVpbmZvLmMNCj4gPiBpbmRleCAyNmIwODVkYmRkMDcuLmY4MWNhOTYzZDE3
NyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9jYWNoZWluZm8uYw0KPiA+ICsr
KyBiL2FyY2gvcmlzY3Yva2VybmVsL2NhY2hlaW5mby5jDQo+ID4gQEAgLTczLDcgKzczLDExIEBA
IHN0YXRpYyB2b2lkIGNpX2xlYWZfaW5pdChzdHJ1Y3QgY2FjaGVpbmZvICp0aGlzX2xlYWYsDQo+
ID4NCj4gPiAgIGludCBpbml0X2NhY2hlX2xldmVsKHVuc2lnbmVkIGludCBjcHUpDQo+ID4gICB7
DQo+ID4gLSAgICByZXR1cm4gaW5pdF9vZl9jYWNoZV9sZXZlbChjcHUpOw0KPiA+ICsjaWZkZWYg
Q09ORklHX1NNUA0KPiA+ICsgICAgcmV0dXJuIDA7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAr
ICAgIHJldHVybiBmZXRjaF9jYWNoZV9pbmZvKGNwdSk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIGlu
dCBwb3B1bGF0ZV9jYWNoZV9sZWF2ZXModW5zaWduZWQgaW50IGNwdSkNCj4gDQo+IA0KPiBJcyB0
aGUgY3VycmVudCBiZWhhdmlvdXIgd3Jvbmcgb3IganVzdCByZWR1bmRhbnQ/IElmIHdyb25nLCBJ
J2xsIGFkZCBhIA0KPiBGaXhlcyB0YWcgdG8gYmFja3BvcnQsIG90aGVyd2lzZSBJIHdvbid0Lg0K
PiANCj4gVGhhbmtzLA0KPiANCj4gQWxleA0KDQpIaSBBbGV4LA0KDQpUaGUgY3VycmVudCBiZWhh
dmlvciBpcyBhY3R1YWxseSB3cm9uZyB3aGVuIHVzaW5nIEFDUEkgb24gIUNPTkZJR19TTVANCnN5
c3RlbXMuIFRoZSBvcmlnaW5hbCBpbml0X29mX2NhY2hlX2xldmVsKCkgY2Fubm90IGRldGVjdCBj
YWNoZSBoaWVyYXJjaHkNCnRocm91Z2ggQUNQSSBQUFRUIHRhYmxlLCB3aGljaCBtZWFucyBjYWNo
ZSBpbmZvcm1hdGlvbiB3b3VsZCBiZSBtaXNzaW5nDQppbiB0aGlzIGNvbmZpZ3VyYXRpb24uDQoN
ClRoZSBwYXRjaCBmaXhlcyB0aGlzIGJ5IGRpcmVjdGx5IGNhbGxpbmcgZmV0Y2hfY2FjaGVfaW5m
bygpIHdoZW4NCkNPTkZJR19TTVAgaXMgdW5kZWZpbmVkLCB3aGljaCBwcm9wZXJseSBoYW5kbGVz
IGJvdGggRFQgYW5kIEFDUEkgY2FzZXMuDQoNClNvIHllcywgaXQgd291bGQgYmUgYXBwcm9wcmlh
dGUgdG8gYWRkIGEgRml4ZXMgdGFnLiBUaGUgY29tbWl0IGJlaW5nDQpmaXhlZCBpcyAxODQ1ZDM4
MWYyODAgKCJyaXNjdjogY2FjaGVpbmZvOiBBZGQgYmFjayBpbml0X2NhY2hlX2xldmVsKCkgZnVu
Y3Rpb24iKS4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBhZGRpdGlvbmFs
IGluZm9ybWF0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpKZXNzaWNh


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPk9uIDcvMzEvMjUgMjE6MjksIGFsZXhAZ2hpdGku
ZnIgd3JvdGU6PC9wPjxwPiZndDsgJmd0OyBGcm9tOiBKZXNzaWNhIExpdSAmbHQ7bGl1Lnh1ZW1l
aTFAenRlLmNvbS5jbiZndDs8L3A+PHA+Jmd0OyAmZ3Q7PC9wPjxwPiZndDsgJmd0OyBBcyBkZXNj
cmliZWQgaW4gY29tbWl0IDE4NDVkMzgxZjI4MCAoInJpc2N2OiBjYWNoZWluZm86IEFkZCBiYWNr
PC9wPjxwPiZndDsgJmd0OyBpbml0X2NhY2hlX2xldmVsKCkgZnVuY3Rpb24iKSwgd2hlbiBDT05G
SUdfU01QIGlzIHVuZGVmaW5lZCwgdGhlIGNhY2hlPC9wPjxwPiZndDsgJmd0OyBoaWVyYXJjaHkg
ZGV0ZWN0aW9uIG5lZWRzIHRvIGJlIHBlcmZvcm1lZCB0aHJvdWdoIHRoZSBpbml0X2NhY2hlX2xl
dmVsKCksPC9wPjxwPiZndDsgJmd0OyB3aGVyZWFzIHdoZW4gQ09ORklHX1NNUCBpcyBkZWZpbmVk
LCB0aGlzIGRldGVjdGlvbiBpcyBoYW5kbGVkIGR1cmluZyB0aGU8L3A+PHA+Jmd0OyAmZ3Q7IGlu
aXRfY3B1X3RvcG9sb2d5KCkgcHJvY2Vzcy48L3A+PHA+Jmd0OyAmZ3Q7PC9wPjxwPiZndDsgJmd0
OyBGdXJ0aGVybW9yZSwgd2hpbGUgY29tbWl0IDY2MzgxZDM2NzcxZSAoIlJJU0MtVjogU2VsZWN0
IEFDUEkgUFBUVCBkcml2ZXJzIik8L3A+PHA+Jmd0OyAmZ3Q7IGVuYWJsZXMgY2FjaGUgaW5mb3Jt
YXRpb24gcmV0cmlldmFsIHRocm91Z2ggdGhlIEFDUEkgUFBUVCB0YWJsZSwgdGhlPC9wPjxwPiZn
dDsgJmd0OyBpbml0X29mX2NhY2hlX2xldmVsKCkgY2FsbGVkIHdpdGhpbiBpbml0X2NhY2hlX2xl
dmVsKCkgY2Fubm90IHN1cHBvcnQgY2FjaGU8L3A+PHA+Jmd0OyAmZ3Q7IGhpZXJhcmNoeSBkZXRl
Y3Rpb24gdGhyb3VnaCBBQ1BJIFBQVFQuIFRoZXJlZm9yZSwgd2hlbiBDT05GSUdfU01QIGlzPC9w
PjxwPiZndDsgJmd0OyB1bmRlZmluZWQsIHdlIGRpcmVjdGx5IGludm9rZSB0aGUgZmV0Y2hfY2Fj
aGVfaW5mbyBmdW5jdGlvbiB0byBpbml0aWFsaXplPC9wPjxwPiZndDsgJmd0OyB0aGUgY2FjaGUg
bGV2ZWxzLjwvcD48cD4mZ3Q7ICZndDs8L3A+PHA+Jmd0OyAmZ3Q7IFNpZ25lZC1vZmYtYnk6IEpl
c3NpY2EgTGl1ICZsdDtsaXUueHVlbWVpMUB6dGUuY29tLmNuJmd0OzwvcD48cD4mZ3Q7ICZndDsg
LS0tPC9wPjxwPiZndDsgJmd0OyZuYnNwOyAmbmJzcDthcmNoL3Jpc2N2L2tlcm5lbC9jYWNoZWlu
Zm8uYyB8IDYgKysrKystPC9wPjxwPiZndDsgJmd0OyZuYnNwOyAmbmJzcDsxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pPC9wPjxwPiZndDsgJmd0OzwvcD48cD4m
Z3Q7ICZndDsgZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NhY2hlaW5mby5jIGIvYXJj
aC9yaXNjdi9rZXJuZWwvY2FjaGVpbmZvLmM8L3A+PHA+Jmd0OyAmZ3Q7IGluZGV4IDI2YjA4NWRi
ZGQwNy4uZjgxY2E5NjNkMTc3IDEwMDY0NDwvcD48cD4mZ3Q7ICZndDsgLS0tIGEvYXJjaC9yaXNj
di9rZXJuZWwvY2FjaGVpbmZvLmM8L3A+PHA+Jmd0OyAmZ3Q7ICsrKyBiL2FyY2gvcmlzY3Yva2Vy
bmVsL2NhY2hlaW5mby5jPC9wPjxwPiZndDsgJmd0OyBAQCAtNzMsNyArNzMsMTEgQEAgc3RhdGlj
IHZvaWQgY2lfbGVhZl9pbml0KHN0cnVjdCBjYWNoZWluZm8gKnRoaXNfbGVhZiw8L3A+PHA+Jmd0
OyAmZ3Q7PC9wPjxwPiZndDsgJmd0OyZuYnNwOyAmbmJzcDtpbnQgaW5pdF9jYWNoZV9sZXZlbCh1
bnNpZ25lZCBpbnQgY3B1KTwvcD48cD4mZ3Q7ICZndDsmbmJzcDsgJm5ic3A7ezwvcD48cD4mZ3Q7
ICZndDsgLSZuYnNwOyAmbmJzcDsgcmV0dXJuIGluaXRfb2ZfY2FjaGVfbGV2ZWwoY3B1KTs8L3A+
PHA+Jmd0OyAmZ3Q7ICsjaWZkZWYgQ09ORklHX1NNUDwvcD48cD4mZ3Q7ICZndDsgKyZuYnNwOyAm
bmJzcDsgcmV0dXJuIDA7PC9wPjxwPiZndDsgJmd0OyArI2VuZGlmPC9wPjxwPiZndDsgJmd0OyAr
PC9wPjxwPiZndDsgJmd0OyArJm5ic3A7ICZuYnNwOyByZXR1cm4gZmV0Y2hfY2FjaGVfaW5mbyhj
cHUpOzwvcD48cD4mZ3Q7ICZndDsmbmJzcDsgJm5ic3A7fTwvcD48cD4mZ3Q7ICZndDs8L3A+PHA+
Jmd0OyAmZ3Q7Jm5ic3A7ICZuYnNwO2ludCBwb3B1bGF0ZV9jYWNoZV9sZWF2ZXModW5zaWduZWQg
aW50IGNwdSk8L3A+PHA+Jmd0OyZuYnNwOzwvcD48cD4mZ3Q7Jm5ic3A7PC9wPjxwPiZndDsgSXMg
dGhlIGN1cnJlbnQgYmVoYXZpb3VyIHdyb25nIG9yIGp1c3QgcmVkdW5kYW50PyBJZiB3cm9uZywg
SSdsbCBhZGQgYSZuYnNwOzwvcD48cD4mZ3Q7IEZpeGVzIHRhZyB0byBiYWNrcG9ydCwgb3RoZXJ3
aXNlIEkgd29uJ3QuPC9wPjxwPiZndDsmbmJzcDs8L3A+PHA+Jmd0OyBUaGFua3MsPC9wPjxwPiZn
dDsmbmJzcDs8L3A+PHA+Jmd0OyBBbGV4PC9wPjxwPjxicj48L3A+PHA+SGkgQWxleCw8L3A+PHA+
PGJyPjwvcD48cD5UaGUgY3VycmVudCBiZWhhdmlvciBpcyBhY3R1YWxseSB3cm9uZyB3aGVuIHVz
aW5nIEFDUEkgb24gIUNPTkZJR19TTVA8L3A+PHA+c3lzdGVtcy4gVGhlIG9yaWdpbmFsIGluaXRf
b2ZfY2FjaGVfbGV2ZWwoKSBjYW5ub3QgZGV0ZWN0IGNhY2hlIGhpZXJhcmNoeTwvcD48cD50aHJv
dWdoIEFDUEkgUFBUVCB0YWJsZSwgd2hpY2ggbWVhbnMgY2FjaGUgaW5mb3JtYXRpb24gd291bGQg
YmUgbWlzc2luZzwvcD48cD5pbiB0aGlzIGNvbmZpZ3VyYXRpb24uPC9wPjxwPjxicj48L3A+PHA+
VGhlIHBhdGNoIGZpeGVzIHRoaXMgYnkgZGlyZWN0bHkgY2FsbGluZyBmZXRjaF9jYWNoZV9pbmZv
KCkgd2hlbjwvcD48cD5DT05GSUdfU01QIGlzIHVuZGVmaW5lZCwgd2hpY2ggcHJvcGVybHkgaGFu
ZGxlcyBib3RoIERUIGFuZCBBQ1BJIGNhc2VzLjwvcD48cD48YnI+PC9wPjxwPlNvIHllcywgaXQg
d291bGQgYmUgYXBwcm9wcmlhdGUgdG8gYWRkIGEgRml4ZXMgdGFnLiBUaGUgY29tbWl0IGJlaW5n
PC9wPjxwPmZpeGVkIGlzIDE4NDVkMzgxZjI4MCAoInJpc2N2OiBjYWNoZWluZm86IEFkZCBiYWNr
IGluaXRfY2FjaGVfbGV2ZWwoKSBmdW5jdGlvbiIpLjwvcD48cD48YnI+PC9wPjxwPlBsZWFzZSBs
ZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnkgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi48L3A+PHA+
PGJyPjwvcD48cD5CZXN0IHJlZ2FyZHMsPC9wPjxwPkplc3NpY2E8L3A+PHAgc3R5bGU9ImZvbnQt
c2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+
PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWlj
cm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1p
bHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQt
c2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+
PC9wPjxwPjxicj48L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


