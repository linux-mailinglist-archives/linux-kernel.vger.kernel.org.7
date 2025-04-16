Return-Path: <linux-kernel+bounces-607516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13284A9075E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C99188B205
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35976202C31;
	Wed, 16 Apr 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="GhfIPeRv"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4296A7E110
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816165; cv=none; b=dl5RxK4BEOBmioDVrJc3X36wEAin5IbNNf94i13JZaHgeU3ZmuwcRShJ8YEbOT027qcaZD0FC06mRXDwapSTfkuCRenxtqhZNJvEHY25Xc+YdUOuRdkiQG6LJ50DP2/PGazEdVzq/928zsflTPqGso8M0YNIkNBzwfJzDYtEQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816165; c=relaxed/simple;
	bh=THyLcDlGIXVV8cn86M/Ck0fScGcZPZupKk8vOmy/1uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bMPrNju6xiksDNNVBtjV/Y6RvyiWGj5JOPn2ej9hBOy38dBK46H7d5gpMePnl7RiX/FkDAS6Mk+YJuQXBuYSpJNxWh9XmYSPrqhzd2rdNJNJKu0pKxNJpWJwVo4IbS4euTnQGX5e69owt9W+DHjS18H1XM2N3afgD625vEcl16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=GhfIPeRv reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ssEC1GiSg5E0V6UFXRVMRch6ex2sT+s23sGhhuDgibc=; b=G
	hfIPeRva5WKmL/AszJf3SuA6X21obMR5uUwMDboCnsU8sO+qLZyzLjRYWgRD2Izk
	WAardEww6pb5LeRHVK7pdcGKfCirNaffVvGgpQOSVYYukz5n0pXJhO9yBlnf7Ybz
	9M/YrPw2qd/Y7HbGQ9zvUdx+65CeWwyKcQFWdBT8uk=
Received: from xavier_qy$163.com ( [2408:820c:3408:68f0:2136:e7d4:a861:aae3]
 ) by ajax-webmail-wmsvr-40-102 (Coremail) ; Wed, 16 Apr 2025 23:08:33 +0800
 (CST)
Date: Wed, 16 Apr 2025 23:08:33 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Catalin Marinas" <catalin.marinas@arm.com>
Cc: ryan.roberts@arm.com, dev.jain@arm.com, ioworker0@gmail.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
	gshan@redhat.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, will@kernel.org, willy@infradead.org,
	ziy@nvidia.com
Subject: Re:Re: [mm/contpte v3 0/1] mm/contpte: Optimize loop to reduce
 redundant operations
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <Z_-m8s5EUrL4DAME@arm.com>
References: <f0e109c7-6bb2-4218-bc76-c5de39184064@arm.com>
 <20250415082205.2249918-1-xavier_qy@163.com> <Z_-m8s5EUrL4DAME@arm.com>
X-NTES-SC: AL_Qu2fBvSauUkq5SmfYukfmk4QgeY+WMW1vP4m34NSN5FwjCzp0ysiZlJTIXjNyvCDLzqKkAiHVTRiy9ZZf7hifrkol9Qpfs70rnBJOhES8Z4itQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d50fc6f.b19a.1963f250940.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgD3XIfyx_9n1OGXAA--.44848W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiwhExEGf-pJJ9EwAGs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBDYXRhbGluLAoKCkF0IDIwMjUtMDQtMTYgMjA6NDc6NDYsICJDYXRhbGluIE1hcmluYXMi
IDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4gd3JvdGU6Cj5PbiBUdWUsIEFwciAxNSwgMjAyNSBh
dCAwNDoyMjowNFBNICswODAwLCBYYXZpZXIgd3JvdGU6Cj4+IFBhdGNoIFYzIGhhcyBjaGFuZ2Vk
IHRoZSB3aGlsZSBsb29wIHRvIGEgZm9yIGxvb3AgYWNjb3JkaW5nIHRvIHRoZSBzdWdnZXN0aW9u
cwo+PiBvZiBEZXYuCj4KPkZvciBzb21lIHJlYXNvbiwgbXkgZW1haWwgKG9mZmljZTM2NSkgcmVq
ZWN0ZWQgYWxsIHRoZXNlIHBhdGNoZXMgKG5vdAo+ZXZlbiBxdWFyYW50aW5lZCksIEkgb25seSBn
b3QgdGhlIHJlcGxpZXMuIEFueXdheSwgSSBjYW4gZ2V0IHRoZW0gZnJvbQo+dGhlIGxvcmUgYXJj
aGl2ZS4KPgo+PiBNZWFud2hpbGUsIHRvIGltcHJvdmUgZWZmaWNpZW5jeSwgdGhlIGRlZmluaXRp
b24gb2YgbG9jYWwgdmFyaWFibGVzIGhhcwo+PiBiZWVuIHJlbW92ZWQuIFRoaXMgbWFjcm8gaXMg
b25seSB1c2VkIHdpdGhpbiB0aGUgY3VycmVudCBmdW5jdGlvbiBhbmQgdGhlcmUKPj4gd2lsbCBi
ZSBubyBhZGRpdGlvbmFsIHJpc2tzLiBJbiBvcmRlciB0byB2ZXJpZnkgdGhlIG9wdGltaXphdGlv
biBwZXJmb3JtYW5jZSBvZgo+PiBQYXRjaCBWMywgYSB0ZXN0IGZ1bmN0aW9uIGhhcyBiZWVuIGRl
c2lnbmVkLiBCeSByZXBlYXRlZGx5IGNhbGxpbmcgbWxvY2sgaW4gYQo+PiBsb29wLCB0aGUga2Vy
bmVsIGlzIG1hZGUgdG8gY2FsbCBjb250cHRlX3B0ZXBfZ2V0IGV4dGVuc2l2ZWx5IHRvIHRlc3Qg
dGhlCj4+IG9wdGltaXphdGlvbiBlZmZlY3Qgb2YgdGhpcyBmdW5jdGlvbi4KPj4gVGhlIGZ1bmN0
aW9uJ3MgZXhlY3V0aW9uIHRpbWUgYW5kIGluc3RydWN0aW9uIHN0YXRpc3RpY3MgaGF2ZSBiZWVu
IHRyYWNlZCB1c2luZwo+PiBwZXJmLCBhbmQgdGhlIGZvbGxvd2luZyBhcmUgdGhlIG9wZXJhdGlv
biByZXN1bHRzIG9uIGEgY2VydGFpbiBRdWFsY29tbSBtb2JpbGUKPj4gcGhvbmUgY2hpcDoKPj4g
Cj4+IEluc3RydWN0aW9uIFN0YXRpc3RpY3MgLSBCZWZvcmUgT3B0aW1pemF0aW9uCj4+ICMgICAg
ICAgICAgY291bnQgIGV2ZW50X25hbWUgICAgICAgICAgICAgICMgY291bnQgLyBydW50aW1lCj4+
ICAgICAgIDIwLDgxNCwzNTIgIGJyYW5jaC1sb2FkLW1pc3NlcyAgICAgICMgNjYyLjI0NCBLL3Nl
Ywo+PiAgIDQxLDg5NCw5ODYsMzIzICBicmFuY2gtbG9hZHMgICAgICAgICAgICAjIDEuMzMzIEcv
c2VjCj4+ICAgICAgICAxLDk1Nyw0MTUgIGlUTEItbG9hZC1taXNzZXMgICAgICAgICMgNjIuMjc4
IEsvc2VjCj4+ICAgNDksODcyLDI4MiwxMDAgIGlUTEItbG9hZHMgICAgICAgICAgICAgICMgMS41
ODcgRy9zZWMKPj4gICAgICAzMDIsODA4LDA5NiAgTDEtaWNhY2hlLWxvYWQtbWlzc2VzICAgIyA5
LjYzNCBNL3NlYwo+PiAgIDQ5LDg3MiwyODIsMTAwICBMMS1pY2FjaGUtbG9hZHMgICAgICAgICAj
IDEuNTg3IEcvc2VjCj4+IAo+PiBUb3RhbCB0ZXN0IHRpbWU6IDMxLjQ4NTIzNyBzZWNvbmRzLgo+
PiAKPj4gSW5zdHJ1Y3Rpb24gU3RhdGlzdGljcyAtIEFmdGVyIE9wdGltaXphdGlvbgo+PiAjICAg
ICAgICAgIGNvdW50ICBldmVudF9uYW1lICAgICAgICAgICAgICAjIGNvdW50IC8gcnVudGltZQo+
PiAgICAgICAxOSwzNDAsNTI0ICBicmFuY2gtbG9hZC1taXNzZXMgICAgICAjIDY4OC43NTMgSy9z
ZWMKPj4gICAzOCw1MTAsMTg1LDE4MyAgYnJhbmNoLWxvYWRzICAgICAgICAgICAgIyAxLjM3MSBH
L3NlYwo+PiAgICAgICAgMSw4MTIsNzE2ICBpVExCLWxvYWQtbWlzc2VzICAgICAgICAjIDY0LjU1
NCBLL3NlYwo+PiAgIDQ3LDY3Myw5MjMsMTUxICBpVExCLWxvYWRzICAgICAgICAgICAgICAjIDEu
Njk4IEcvc2VjCj4+ICAgICAgNjc1LDg1Myw2NjEgIEwxLWljYWNoZS1sb2FkLW1pc3NlcyAgICMg
MjQuMDY4IE0vc2VjCj4+ICAgNDcsNjczLDkyMywxNTEgIEwxLWljYWNoZS1sb2FkcyAgICAgICAg
ICMgMS42OTggRy9zZWMKPj4gCj4+IFRvdGFsIHRlc3QgdGltZTogMjguMTA4MDQ4IHNlY29uZHMu
Cj4KPldlJ2QgbmVlZCB0byByZXByb2R1Y2UgdGhlc2UgbnVtYmVycyBvbiBvdGhlciBwbGF0Zm9y
bXMgYXMgd2VsbCBhbmQgd2l0aAo+ZGlmZmVyZW50IHBhZ2Ugc2l6ZXMuIEkgaG9wZSBSeWFuIGNh
biBkbyBzb21lIHRlc3RzIG5leHQgd2Vlay4KCk9mIGNvdXJzZSwgaXQgd291bGQgYmUgZXZlbiBi
ZXR0ZXIgaWYgYW55IHJldmlld2VycyBjb3VsZCB2ZXJpZnkgaXQgd2l0aCBzb21lCnJlYWwtd29y
bGQgc2NlbmFyaW9zLgoKPgo+UHVyZWx5IGxvb2tpbmcgYXQgdGhlIHBhdGNoLCBJIGRvbid0IGxp
a2UgdGhlIGNvbXBsZXhpdHkuIEknZCByYXRoZXIgZ28KPndpdGggeW91ciB2MSBpZiB0aGUgbnVt
YmVycyBhcmUgZmFpcmx5IHNpbWlsYXIgKGV2ZW4gaWYgc2xpZ2h0bHkgc2xvd2VyKS4KClRoZSBp
bXBsZW1lbnRhdGlvbiBvZiB0aGlzIG1hY3JvIGlzIGluZGVlZCBhIGJpdCBjb21wbGljYXRlZC4g
SWYgaXQKZG9lc24ndCBhZmZlY3QgdGhlIHBlcmZvcm1hbmNlLCBJIHdpbGwgdHJ5IHRvIG1ha2Ug
aXQgc2ltcGxlci4KCj4KPkhvd2V2ZXIsIEkgZG9uJ3QgdHJ1c3QgbWljcm9iZW5jaG1hcmtzIGxp
a2UgY2FsbGluZyBtbG9jaygpIGluIGEgbG9vcC4KPkl0IHdhcyBoYW5kLWNyYWZ0ZWQgdG8gZGly
dHkgdGhlIHdob2xlIGJ1ZmZlciAobWFraW5nIHB0ZXMgeW91bmcrZGlydHkpCj5iZWZvcmUgbWxv
Y2soKSB0byBtYWtlIHRoZSBiZXN0IG91dCBvZiB0aGUgcmV3cml0dGVuIGNvbnRwdGVfcHRlcF9n
ZXQoKS4KPkFyZSB0aGVyZSBhbnkgcmVhbCB3b3JsZCB3b3JrbG9hZHMgdGhhdCB3b3VsZCBiZW5l
Zml0IGZyb20gc3VjaCBjaGFuZ2U/Cj4KPkFzIGl0IHN0YW5kcywgSSB0aGluayB0aGlzIHBhdGNo
IG5lZWRzIGJldHRlciBqdXN0aWZpY2F0aW9uLgo+CgpJbmRlZWQsIEkgdXNlZCBtbG9jaygpIGJl
Y2F1c2UgaXQgaXMgYW4gZXhhbXBsZSB0aGF0IGNhbiBzaW1wbHkgYWNoaWV2ZQphIGxhcmdlIG51
bWJlciBvZiBjYWxscyB0byBjb250cHRlX3B0ZXBfZ2V0KCkgaW4gdGhlIHVzZXIgc3BhY2UuIE9m
IGNvdXJzZSwKdGhlcmUgYXJlIG1hbnkgb3RoZXIgc2NlbmFyaW9zIHdoZXJlIHRoaXMgZnVuY3Rp
b24gd2lsbCBiZSBjYWxsZWQsIHN1Y2ggYXMKbWFkdmlzZSBhbmQgbXByb3RlY3QsIGFuZCBzbyBv
bi4gQnV0IGVzc2VudGlhbGx5LCB0aGVyZSBpcyBubyBkaWZmZXJlbmNlLAphbmQgYWxsIG9mIHRo
ZW0gYXJlIGFpbWVkIGF0IHZlcmlmeWluZyB0aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQKYnJv
dWdodCBieSB0aGUgY29udHB0ZV9wdGVwX2dldCgpIGZ1bmN0aW9uLiBJdCdzIHRydWUgdGhhdCB0
aGUgcHJldmlvdXMKdGVzdCBjYXNlcyBvbmx5IHRlc3RlZCB0aGUgYmVzdC1jYXNlIHNjZW5hcmlv
IGJ5IGRpcnR5aW5nIHRoZSBkYXRhLgpOZXh0LCBJIHdpbGwgY29udGludWUgdG8gdGVzdCB0aGUg
aW1wYWN0IG9mIHRoZSBuZXcgcGF0Y2ggb24gcGVyZm9ybWFuY2UKaW4gc2NlbmFyaW9zIHdoZXJl
IHRoZXJlIGFyZSBubyAieW91bmciIGFuZCAiZGlydHkiIGZsYWdzLCBvciB3aGVyZSB0aGVyZQpp
cyBvbmx5IGEgInlvdW5nIiBmbGFnLgoKLS0KVGhhbmtzLApYYXZpZXIK

