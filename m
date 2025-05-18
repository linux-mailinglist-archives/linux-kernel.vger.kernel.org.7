Return-Path: <linux-kernel+bounces-652692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB3DABAF21
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 11:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B3174A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3220F07B;
	Sun, 18 May 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="WCQ4o5S5"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48B200130
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747562164; cv=none; b=bbOrVy95HxnPHVW5NPLOAQTiLQhg9eaRxfOJXuI9+RlfZAPwpOQfImMRsom8twNsVUeEeIvY079IizFxPBl4boiXiN88LzSo0oAVl3tdWGVy5x5zqI6ZCPuwaOcg2DSCWsbCNFonNJSruDULJ/UZFT0TmHMWv5rkvQn5q8gCXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747562164; c=relaxed/simple;
	bh=iRZ8Ttj+hapeGKoIKQJGBTf+vzmHheEqsxL3gDysz6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=oelCodB/uYUIk2CK2b9RbGHR8DF5HUnx38E+alwnsR8UH6YGn3VWVu3sSdzAFCXOAlD151bEnl95Vwetovuo+RGyPKbMEPi5UBrPzAvhrKJClOiJSoW42FypLhgnJ2FrlHeJfrmC043mi/hhSoHjvL7Ih2v9epo2VzZd++M3Mdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=WCQ4o5S5 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Dg+z0ThD/G4JBWvCvOWtbJgKtJCKDefo3xSWVf+aKkA=; b=W
	CQ4o5S5BvpCWqvf6chzfyRK2MlMv9R25BXLzbKQTsYwmXLwGpE7FDG/IAKZ4jgGD
	DzX89igQaU21QaxfwAmwfTOObNkpF6dbkqbpZpVTlqWCRd2+o4W7ms4nTQUzX48P
	Yhfc5A3t6kTeELAuK/EKOr79JEY8Nh5aW4s3QZ0Zwg=
Received: from 00107082$163.com ( [111.35.191.17] ) by
 ajax-webmail-wmsvr-40-119 (Coremail) ; Sun, 18 May 2025 17:55:38 +0800
 (CST)
Date: Sun, 18 May 2025 17:55:38 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: BUG: unable to handle page fault for address
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <551cd408.515.196e11108a5.Coremail.00107082@163.com>
References: <20250516131246.6244-1-00107082@163.com>
 <CAJuCfpHZfRhsjmHVMUREOTVafRodMH85hzLdFFunneK=4ir0-w@mail.gmail.com>
 <CAJuCfpEfSr7a911zNiigVVP6Z20gjks7Yyy27UDwL4s=0P4hKw@mail.gmail.com>
 <6646d582.18f8.196dd0d5071.Coremail.00107082@163.com>
 <CAJuCfpF=FpMvGGzVr5E+9R629SfXB8oWm2NbowHg=mksUQ113A@mail.gmail.com>
 <233aab47.38f2.196df28812a.Coremail.00107082@163.com>
 <CAJuCfpEPupOzygXhoYBCzTao4YHzW9ZWG+Y4KDUohhfq=hjwQw@mail.gmail.com>
 <5a1f5612.363e.196df64bd1f.Coremail.00107082@163.com>
 <CAJuCfpEWsN3pxN2EveACvucx7Aip6u_YjJ5u3NxdmU3A3WYOYw@mail.gmail.com>
 <551cd408.515.196e11108a5.Coremail.00107082@163.com>
X-NTES-SC: AL_Qu2fBfmdvUko7iWYZekXn0oTju85XMCzuv8j3YJeN500piTf/wcrZ256M1/H9PmtLhymoQmbWRhMx/hzWqp2VJOFLO78dgPeYXqqqXDnzf8p
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <489a2474.19ea.196e2d20b87.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dygvCgC3n2+brilogP0GAA--.58641W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBhRqmgpq6Y3TQABs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Cj4+Pgo+Pj4gSSBkbyBub3RpY2UgdGhlcmUgYXJlIHBsYWNlcyB3aGVyZSBjb3VudGVycyBhcmUg
cmVmZXJlbmNlZCAiYWZ0ZXIiIGZyZWVfbW9kdWxlLCBidXQgdGhlIGxvZ3MgSSBhdHRhY2hlZAo+
Pj4gaGFwcGVuZWQgImR1cmluZyIgZnJlZV9tb2R1bGUoKToKPj4+Cj4+PiAgW0ZyaSBNYXkgMTYg
MTI6MDU6NDEgMjAyNV0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJl
c3M6IGZmZmY5ZDI4OTg0YzMwMDAKPj4+ICBbRnJpIE1heSAxNiAxMjowNTo0MSAyMDI1XSAjUEY6
IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKPj4+IFtGcmkgTWF5IDE2IDEy
OjA1OjQxIDIwMjVdICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQo+
Pj4gLi4uCj4+PiAgW0ZyaSBNYXkgMTYgMTI6MDU6NDEgMjAyNV0gUklQOiAwMDEwOnJlbGVhc2Vf
bW9kdWxlX3RhZ3MrMHgxMDMvMHgxYjAKPj4+IC4uLgo+Pj4gIFtGcmkgTWF5IDE2IDEyOjA1OjQx
IDIwMjVdIENhbGwgVHJhY2U6Cj4+PiAgW0ZyaSBNYXkgMTYgMTI6MDU6NDEgMjAyNV0gIDxUQVNL
Pgo+Pj4gIFtGcmkgTWF5IDE2IDEyOjA1OjQxIDIwMjVdICBjb2RldGFnX3VubG9hZF9tb2R1bGUr
MHgxMzUvMHgxNjAKPj4+IFtGcmkgTWF5IDE2IDEyOjA1OjQxIDIwMjVdICBmcmVlX21vZHVsZSsw
eDE5LzB4MWEwCj4+Pgo+Pj4gVGhlIGNhbGwgY2hhaW4gaXMgdGhlIHNhbWUgYXMgeW91IG1lbnRp
b25lZCBhYm92ZS4gCj4+Cj4+SXMgdGhpcyBmYWlsdXJlIGhhcHBlbmluZyBiZWZvcmUgb3IgYWZ0
ZXIgbXkgZml4PyBXaXRoIG15IGZpeCwgcGVyY3B1Cj4+ZGF0YSBzaG91bGQgbm90IGJlIGZyZWVk
IGF0IGFsbCBpZiB0YWdzIGFyZSBzdGlsbCB1c2VkLiBQbGVhc2UKPj5jbGFyaWZ5Lgo+Cj5JdCBp
cyBiZWZvcmUgeW91ciBmaXguICBZb3VyIHBhdGNoIGRvZXMgZml4IHRoZSBpc3N1ZS4KPiAgCj5J
biBteSByZXByb2R1Y2UgcHJvY2VkdXJlOgo+MS4gZW50ZXIgcmVjb3ZlcnkgbW9kZQo+Mi4gaW5z
dGFsbCBudmlkaWEgZHJpdmVyIDU3MC4xNDQsIGZhaWxlZCB3aXRoIFVua25vd24gc3ltYm9sIGRy
bV9jbGllbnRfc2V0dXAKPjMuIG1vZHByb2JlIGRybV9jbGllbnRfbGliCj40LiBpbnN0YWxsIG52
aWRpYSBkcml2ZXIgNTcwLjE0NAo+NS4gaW5zdGFsbCBudmlkaWEgZHJpdmVyIDU1MC4xNDQuMDMK
PjYuIHJlYm9vdCBhbmQgcmVwZWF0IGZyb20gc3RlcCAxCj4KPlRoZSBlcnJvciBoYXBwZW5lZCBp
biBzdGVwIDQsICBhbmQgdGhlIGZhaWx1cmUgaW4gc3RlcDIgaXMgY3J1Y2lhbCwgIGlmICdtb2Rw
cm9iZSBkcm1fY2xpZW50X2xpYicgYXQgdGhlIGJlZ2lubmluZywgbm8gZXJyb3IgY291bGQgYmUg
b2JzZXJ2ZWQuCj4KPlRoZXJlIG1heSBiZSBzb21ldGhpbmcgb2ZmIGFib3V0IGhvdyBrZXJuZWwg
aGFuZGxlcyBkYXRhLnBlcmNwdSBzZWN0aW9uLgo+R29vZCB0aGluZyBpcyB0aGF0IEl0IGNhbiBi
ZSByZXByb2R1Y2VkLCAgSSBjYW4gYWRkIGRlYnVnIG1lc3NhZ2VzIHRvIGNsZWFyIG9yIGNvbmZp
cm0gIHN1c3BpY2lvbnMsIAo+QW55IHN1Z2dlc3Rpb24/Cj4KPgo+VGhhbmtzCj5EYXZpZAo+Cj4K
QWZ0ZXIgcG9raW5nIGFyb3VuZCBsb2dnaW5nIG1lbW9yeSBhZGRyZXNzZXMsIEkgdGhpbmsgSSBm
aW5hbGx5IHVuZGVyc3RhbmQgd2hhdCBpcyBoYXBwZW5pbmcgaGVyZS4KCjEuIGNvZGV0YWdfYWxs
b2NfbW9kdWxlX3NlY3Rpb24gYWxsb2MgbWVtb3J5IHdoZW4gbG9hZGluZyBtb2R1bGUKMi4gbW9k
dWxlIGxvYWQgZmFpbGVkLCBkdWUgdG8gdW5kZWZpbmVkIHN5bWJvbAozLiBjb2RldGFnIHNlY3Rp
b24gbWVtb3J5IG5vdCBmcmVlZAo0LiBtb2R1bGUgbG9hZCwgYW5kIG1vZHVsZSdzIGFkZHJlc3Mg
aGFwcGVucyB0byByZXVzZSB0aGUgYWRkcmVzcyBwcmV2aW91cyB1c2VkCjUuIGFub3RoZXIgY29k
ZXRhZ19hbGxvY19tb2R1bGVfc2VjdGlvbgo2LiBwZXJjdXAgc2VjdGlvbiBhbGxvY2F0aW9uIGFu
ZCB0aGVuIHJlbG9jYXRpb24gYWRkcmVzcyBjaGFuZ2VzIG1hZGUgdG8gY29kZXRhZ19hbGxvY19t
b2R1bGVfc2VjdGlvbgo3LiB1bmxvYWQgbW9kdWxlLCB3aGVuIHNlYXJjaGluZyB0aHJvdWdoIG1h
cGxlIHRyZWUsIHRoZSBjb2RlIHRhZyBtZW1vcnkgaW4gc3RlcCAxIGlzIHVzZWQsIAp3aGljaCBo
YXMgbm8gcmVsb2NhdGlvbiBhZGRyZXNzIHBvcHVsYXRlZCBhdCBhbGwuCjguIHBhZ2UgZmF1bHQg
ZXJyb3IsIGJlY2F1c2UgdGFnLT5jb3VudGVycyBpcyAwCgpJIHVzZSBmb2xsb3dpbmcgY2hhbmdl
cyB0byBsb2cgdGhlIGFkZHJlc3MsIAoKClRoZSBvZmZlbmRpbmcgYWRkcmVzcyBpcyAKLS0tIGEv
bGliL2FsbG9jX3RhZy5jCisrKyBiL2xpYi9hbGxvY190YWcuYwpAQCAtNTc1LDYgKzU3NSwxMSBA
QCBzdGF0aWMgdm9pZCByZWxlYXNlX21vZHVsZV90YWdzKHN0cnVjdCBtb2R1bGUgKm1vZCwgYm9v
bCB1c2VkKQogICAgICAgIGlmICghdXNlZCkKICAgICAgICAgICAgICAgIGdvdG8gcmVsZWFzZV9h
cmVhOwogCisgICAgICAgc3RydWN0IGFsbG9jX3RhZyAqcHRhZyA9IChzdHJ1Y3QgYWxsb2NfdGFn
ICopKG1vZHVsZV90YWdzLnN0YXJ0X2FkZHIgKyBtYXMuaW5kZXgpOworICAgICAgIHByX2luZm8o
InBlcmNwdSAwOiAweCVsbHgoMHglbGx4KVxuIiwKKyAgICAgICAgICAgICAgICAgICAgICAgKGxv
bmcgbG9uZylwZXJfY3B1X3B0cihwdGFnLT5jb3VudGVycywgMCksCisgICAgICAgICAgICAgICAg
ICAgICAgIChsb25nIGxvbmcpcHRhZy0+Y291bnRlcnMKKyAgICAgICAgICAgICAgICAgICAgICAg
KTsKCgpBbmQgZ290IGZvbGxvd2luZzoKW1N1biBNYXkgMTggMTY6MjU6NDcgMjAyNV0gcGVyY3B1
IDA6IDB4ZmZmZjhlZGI2ZWU0MTAzMCgweGZmZmZmZmZmYmM1N2UwMzApCltTdW4gTWF5IDE4IDE2
OjI1OjQ3IDIwMjVdIHBlcmNwdSAwOiAweGZmZmY4ZWRiNmVlNDEwZTAoMHhmZmZmZmZmZmJjNTdl
MGUwKQpbU3VuIE1heSAxOCAxNjoyNTo0NyAyMDI1XSBwZXJjcHUgMDogMHhmZmZmOGVkYjZlZTQw
ZmEwKDB4ZmZmZmZmZmZiYzU3ZGZhMCkKW1N1biBNYXkgMTggMTY6MjY6NDMgMjAyNV0gcGVyY3B1
IDA6IDB4ZmZmZjhlZGJiMjhjMzAwMCgweDApICAgPC0tLS0tLQoKCkkgdGhpbmssIHdlIHNwb3Qg
dHdvIGlzc3VlcyBpbiB0aGlzIHRocmVhZDoKCjEuIHdoZW4gbW9kdWxlIGxvYWQgZmFpbGVkIGFm
dGVyIGNvZGV0YWcgc2VjdGlvbiBhbGxvY2VkLCB0aGUgbWVtb3J5IHdvdWxkIGxlYWsuCjIuIGNv
dW50ZXJzIG1heSBuZWVkcyByZWZlcmVuY2UgZXZlbiBhZnRlciBtb2R1bGUgaXMgdW5sb2FkZWQu
CgojMiBoYXMgYWxyZWFkeSBiZWVuIGFkZHJlc3NlZCBieSB5b3VyIHBhdGNoLiBJIHdpbGwgc2Vu
ZCBhIHNpbXBsZSBwYXRjaCB0byBmaXggIzEKCihGZWVsIHNvIHJlbGVhc2VkIHRvIGZpbmFsbHkg
ZHJhdyBhIGNvbmNsdXNpb24sIGhvcGUgbm8gc2lsbHkgbWlzdGFrZXMgaGVyZSAgOikKCgpUaGFu
a3MKRGF2aWQKCg==

