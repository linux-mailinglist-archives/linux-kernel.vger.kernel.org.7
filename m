Return-Path: <linux-kernel+bounces-753990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC304B18B6A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EFAAA17C1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB517736;
	Sat,  2 Aug 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="JsW2txtp"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A9F18D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124336; cv=none; b=Q7nNYLgHyPJ+gZQttEeaJT1iYLCnCTT6rjN8keKtZlCWf+HPBcq+gwX++uCnroiFoEM5TNwkiV4yH1s009AKYh5Kms/832JD8+kS72WYai5h751IiDZmZHGXB51sr8FAKwL/Zvf+s6s2ZkCsW6XMdHPSfdiTDfNLO4Kz7FOmp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124336; c=relaxed/simple;
	bh=yQurX7qlpm2RHiXjf3A34wQyMy/544f2GInFbz4FXLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lTRLIt/qnd3Nig7C0H5xYWyPpZ1q289DHiHzGfUBnQF7lY3rHOhZ29eKyZa5W+MIWqD/bYQcWStoFuQuEf1W7yUPr9F0LdBXK1GccxFo71qjFQrRT/J6T/UnsDI2Bl/tcT62nuKntfVdwSK+w8x0CmJawXOaVCRLxstJ+e2ghhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=JsW2txtp reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NJOAT41SB6X70t/KJZ9koLJ37OoQBjoVAxO6XCBzlyM=; b=J
	sW2txtpkhYqlAVvYa8zsJzjrbUMQjOtuosnf45QY9tcwRYtKVPN8Zl6yEsbROqVO
	gge25p0Z5svj59oZNLukMB5OyXcf8qzUmm9oMqggfEbZv+Pype3xMRNvynvDlpp5
	aFw6LvnWdwn7OWVcMMX8cXs02ITZPuuD88rWOR8uD0=
Received: from yangshiguang1011$163.com (
 [2408:8607:1b00:8:9e7b:efff:fe4e:6d16] ) by ajax-webmail-wmsvr-40-140
 (Coremail) ; Sat, 2 Aug 2025 16:44:54 +0800 (CST)
Date: Sat, 2 Aug 2025 16:44:54 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Harry Yoo" <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] mm:slub:avoid wake up kswapd in set_track_prepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aIyJzh2-0YLydvlB@hyeyoo>
References: <20250801065121.876793-1-yangshiguang1011@163.com>
 <aIyJzh2-0YLydvlB@hyeyoo>
X-NTES-SC: AL_Qu2eBv2Zu0oi4iSZYekfmUkbg+k2X8K1u/Uv2IBTOZx+jB/o1A4FT1lMAH/d1/OOORqqkReYVyV8zt5iWadpT74q4HGuYKerygAoA/WlCw8a8Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <366fbd5f.2240.19869f49914.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgDnb5EG0I1opEsRAA--.63399W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/xtbBMQmc5WiMXox4SQANsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA4LTAxIDE3OjMzOjMxLCAiSGFycnkgWW9vIiA8aGFycnkueW9vQG9yYWNsZS5j
b20+IHdyb3RlOgo+bml0OiB0aGUgc3ViamVjdCBuZWVkcyBhIHdoaXRlc3BhY2UgYmV0d2VlbiBz
dWJzeXN0ZW1zIGFuZCB0aGUgaGVhZGVyLgo+Im1tOiBzbHViOiBhdm9pZCB3YWtpbmcgdXAga3N3
YXBkIGluIHNldF90cmFja19wcmVwYXJlKCkiPwo+CgpUaGFua3MgZm9yIHRoZSByZW1pbmRlci4K
Cj5PbiBGcmksIEF1ZyAwMSwgMjAyNSBhdCAwMjo1MToyMVBNICswODAwLCB5YW5nc2hpZ3Vhbmcx
MDExQDE2My5jb20gd3JvdGU6Cj4+IEZyb206IHlhbmdzaGlndWFuZyA8eWFuZ3NoaWd1YW5nMTAx
MUAxNjMuY29tPgo+PiAKPj4gc2V0X3RyYWNrX3ByZXBhcmUoKSBjYW4gaW5jdXIgbG9jayByZWN1
cnNpb24uCj4+IFRoZSBpc3N1ZSBpcyB0aGF0IGl0IGlzIGNhbGxlZCBmcm9tIGhydGltZXJfc3Rh
cnRfcmFuZ2VfbnMKPj4gaG9sZGluZyB0aGUgcGVyX2NwdShocnRpbWVyX2Jhc2VzKVtuXS5sb2Nr
LCBidXQgd2hlbiBlbmFibGVkCj4+IENPTkZJR19ERUJVR19PQkpFQ1RTX1RJTUVSUywgbWF5IHdh
a2UgdXAga3N3YXBkIGluIHNldF90cmFja19wcmVwYXJlLAo+PiBhbmQgdHJ5IHRvIGhvbGQgdGhl
IHBlcl9jcHUoaHJ0aW1lcl9iYXNlcylbbl0ubG9jay4KPj4gCj4+IFNvIGF2b2lkIHdha2luZyB1
cCBrc3dhcGQuVGhlIG9vcHMgbG9va3Mgc29tZXRoaW5nIGxpa2U6Cj4+IAo+PiBCVUc6IHNwaW5s
b2NrIHJlY3Vyc2lvbiBvbiBDUFUjMywgc3dhcHBlci8zLzAKPj4gIGxvY2s6IDB4ZmZmZmZmOGE0
YmYyOWM4MCwgLm1hZ2ljOiBkZWFkNGVhZCwgLm93bmVyOiBzd2FwcGVyLzMvMCwgLm93bmVyX2Nw
dTogMwo+PiBIYXJkd2FyZSBuYW1lOiBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gUG9wc2lj
bGUgYmFzZWQgb24gU004ODUwIChEVCkKPj4gQ2FsbCB0cmFjZToKPj4gc3Bpbl9idWcrMHgwCj4+
IF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHg4MAo+PiBocnRpbWVyX3RyeV90b19jYW5jZWwrMHg5
NAo+PiB0YXNrX2NvbnRlbmRpbmcrMHgxMGMKPj4gZW5xdWV1ZV9kbF9lbnRpdHkrMHgyYTQKPj4g
ZGxfc2VydmVyX3N0YXJ0KzB4NzQKPj4gZW5xdWV1ZV90YXNrX2ZhaXIrMHg1NjgKPj4gZW5xdWV1
ZV90YXNrKzB4YWMKPj4gZG9fYWN0aXZhdGVfdGFzaysweDE0Ywo+PiB0dHd1X2RvX2FjdGl2YXRl
KzB4Y2MKPj4gdHJ5X3RvX3dha2VfdXArMHg2YzgKPj4gZGVmYXVsdF93YWtlX2Z1bmN0aW9uKzB4
MjAKPj4gYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKzB4MWMKPj4gX193YWtlX3VwKzB4YWMKPj4g
d2FrZXVwX2tzd2FwZCsweDE5Ywo+PiB3YWtlX2FsbF9rc3dhcGRzKzB4NzgKPj4gX19hbGxvY19w
YWdlc19zbG93cGF0aCsweDFhYwo+PiBfX2FsbG9jX3BhZ2VzX25vcHJvZisweDI5OAo+PiBzdGFj
a19kZXBvdF9zYXZlX2ZsYWdzKzB4NmIwCj4+IHN0YWNrX2RlcG90X3NhdmUrMHgxNAo+PiBzZXRf
dHJhY2tfcHJlcGFyZSsweDVjCj4+IF9fX3NsYWJfYWxsb2MrMHhjY2MKPj4gX19rbWFsbG9jX2Nh
Y2hlX25vcHJvZisweDQ3MAo+PiBfX3NldF9wYWdlX293bmVyKzB4MmJjCj4+IHBvc3RfYWxsb2Nf
aG9va1tqdF0rMHgxYjgKPj4gcHJlcF9uZXdfcGFnZSsweDI4Cj4+IGdldF9wYWdlX2Zyb21fZnJl
ZWxpc3QrMHgxZWRjCj4+IF9fYWxsb2NfcGFnZXNfbm9wcm9mKzB4MTNjCj4+IGFsbG9jX3NsYWJf
cGFnZSsweDI0NAo+PiBhbGxvY2F0ZV9zbGFiKzB4N2MKPj4gX19fc2xhYl9hbGxvYysweDhlOAo+
PiBrbWVtX2NhY2hlX2FsbG9jX25vcHJvZisweDQ1MAo+PiBkZWJ1Z19vYmplY3RzX2ZpbGxfcG9v
bCsweDIyYwo+PiBkZWJ1Z19vYmplY3RfYWN0aXZhdGUrMHg0MAo+PiBlbnF1ZXVlX2hydGltZXJb
anRdKzB4ZGMKPj4gaHJ0aW1lcl9zdGFydF9yYW5nZV9ucysweDVmOAo+PiAuLi4KPgo+U28gc29t
ZSBhbGxvY2F0aW9ucyBjYW4ndCBldmVuIHVzZSBfX0dGUF9LU1dBUERfUkVDTEFJTSAoZS5nLiwg
ZWI3OTkyNzlmYjEKPigiZGVidWdvYmplY3RzOiBEb24ndCB3YWtlIHVwIGtzd2FwZCBmcm9tIGZp
bGxfcG9vbCgpIikpIGFuZAo+c3RhY2tfZGVwb3Rfc2F2ZSgpIGRvZXMgbm90IHJlc3BlY3QgdGhh
dC4KPgoKeWVzLHlvdSBhcmUgcmlnaHQuCgo+PiBTaWduZWQtb2ZmLWJ5OiB5YW5nc2hpZ3Vhbmcg
PHlhbmdzaGlndWFuZzEwMTFAMTYzLmNvbT4KPj4gLS0tCj4KPkluIGdlbmVyYWwsCj5SZXZpZXdl
ZC1ieTogSGFycnkgWW9vIDxoYXJyeS55b29Ab3JhY2xlLmNvbT4KPgoKVGhhbmtzLgoKPkxldCdz
IGFkZCBGaXhlczogNWNmOTA5YzU1M2U5ICgibW0vc2x1YjogdXNlIHN0YWNrZGVwb3QgdG8gc2F2
ZSBzdGFjawo+dHJhY2UgaW4gb2JqZWN0cyIpIGFuZCBwb3RlbnRpYWxseSBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZyB0b28/Cj4oSXQncyBoYXJkIHRvIGltYWdpbmUgdXNlIGJvdGggY29uZmln
cyBpbiBwcm9kdWN0aW9uLCB0aG91Z2gpCj4KT2ssaXQgaXMgbmVjZXNzYXJ5Lgo+PiAgbW0vc2x1
Yi5jIHwgMiArLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jCj4+IGluZGV4IGNm
N2M2MDMyZDVmZC4uMTRlM2JhYzBjNmFkIDEwMDY0NAo+PiAtLS0gYS9tbS9zbHViLmMKPj4gKysr
IGIvbW0vc2x1Yi5jCj4+IEBAIC05NjksNyArOTY5LDcgQEAgc3RhdGljIG5vaW5saW5lIGRlcG90
X3N0YWNrX2hhbmRsZV90IHNldF90cmFja19wcmVwYXJlKHZvaWQpCj4+ICAJdW5zaWduZWQgaW50
IG5yX2VudHJpZXM7Cj4+ICAKPj4gIAlucl9lbnRyaWVzID0gc3RhY2tfdHJhY2Vfc2F2ZShlbnRy
aWVzLCBBUlJBWV9TSVpFKGVudHJpZXMpLCAzKTsKPj4gLQloYW5kbGUgPSBzdGFja19kZXBvdF9z
YXZlKGVudHJpZXMsIG5yX2VudHJpZXMsIEdGUF9OT1dBSVQpOwo+PiArCWhhbmRsZSA9IHN0YWNr
X2RlcG90X3NhdmUoZW50cmllcywgbnJfZW50cmllcywgX19HRlBfTk9XQVJOKTsKPgo+SW4gdGhl
IGZ1dHVyZSwgcGVyaGFwcyBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gcHJvcGFnYXRlIGdmcCBmbGFn
cyB0bwo+c2V0X3RyYWNrX3ByZXBhcmUoKSBhbmQgcGFzcyBpdCB0byBzdGFja19kZXBvdF9zYXZl
KCk/IFRoYXQncyB3aGF0IEtBU0FOCj5kb2VzLgo+CgpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLlRo
aXMgbWlnaHQgYmUgYSBnb29kIGlkZWEuCklmIG9ubHkgQ09ORklHX0RFQlVHX09CSkVDVFNfVElN
RVJTIGlzIGVuYWJsZWQsIHRoZXJlIGlzIGEKcmlzayBvZiByZWN1cnNpdmUgbG9jay4gQ2FuIF9f
R0ZQX0tTV0FQRF9SRUNMQUlNIGJlIHJlbW92ZWQKaW4gdGhpcyBjYXNlPyBKdXN0IGxpa2U6Cgpk
aWZmIC0tZ2l0IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jCmluZGV4IGNmN2M2MDMyZDVmZC4uM2Iz
NWI2Y2JkZDQwIDEwMDY0NAotLS0gYS9tbS9zbHViLmMKKysrIGIvbW0vc2x1Yi5jCkBAIC05Njcs
OSArOTY3LDE3IEBAIHN0YXRpYyBub2lubGluZSBkZXBvdF9zdGFja19oYW5kbGVfdCBzZXRfdHJh
Y2tfcHJlcGFyZSh2b2lkKQogICAgICAgIGRlcG90X3N0YWNrX2hhbmRsZV90IGhhbmRsZTsKICAg
ICAgICB1bnNpZ25lZCBsb25nIGVudHJpZXNbVFJBQ0tfQUREUlNfQ09VTlRdOwogICAgICAgIHVu
c2lnbmVkIGludCBucl9lbnRyaWVzOworICAgICAgIGdmcF90IGZsYWdzID0gR0ZQX05PV0FJVDsK
KworI2lmZGVmIENPTkZJR19ERUJVR19PQkpFQ1RTX1RJTUVSUworICAgICAgIC8qCisgICAgICAg
ICogRG9uJ3Qgd2FrZSB1cCBrc3dhcGQsIHRvIGF2b2lkIHBvdGVudGlhbCByZWN1cnNpdmUgbG9j
ay4KKyAgICAgICAgKi8KKyAgICAgICBmbGFncyAmPSB+X19HRlBfS1NXQVBEX1JFQ0xBSU07Cisj
ZW5kaWYKIAogICAgICAgIG5yX2VudHJpZXMgPSBzdGFja190cmFjZV9zYXZlKGVudHJpZXMsIEFS
UkFZX1NJWkUoZW50cmllcyksIDMpOwotICAgICAgIGhhbmRsZSA9IHN0YWNrX2RlcG90X3NhdmUo
ZW50cmllcywgbnJfZW50cmllcywgR0ZQX05PV0FJVCk7CisgICAgICAgaGFuZGxlID0gc3RhY2tf
ZGVwb3Rfc2F2ZShlbnRyaWVzLCBucl9lbnRyaWVzLCBmbGFncyk7CiAKICAgICAgICByZXR1cm4g
aGFuZGxlOwogfQoKV2hhdCBkbyB5b3UgdGhpbmsgb2Y/Cgo+LS0gCj5DaGVlcnMsCj5IYXJyeSAv
IEh5ZW9uZ2dvbgo=

