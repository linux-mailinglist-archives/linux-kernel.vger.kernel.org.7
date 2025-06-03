Return-Path: <linux-kernel+bounces-671475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D0ACC205
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A521891088
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605F280A20;
	Tue,  3 Jun 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LDTMi3HH"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E1615573F;
	Tue,  3 Jun 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938600; cv=none; b=QNd+wBUIBZa4xJG+AI1HhVMWSRV0bEjU4te4CVbSzOiWTg/XD+3IBM7LaB4h+ctyRIDObmq+6q+UHTPzh3BcMj9MRi9vxchnvOfG41C2e1NmLP3PM/96rS0a1zYkYDU6g5yx/UO7hUAoTPVuVbugB8o8a05v/2GRhU+Hb6rZ5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938600; c=relaxed/simple;
	bh=apP4JuWMnTE8xXBQVIvrLXzv40DxoMkYsEQa/dTKZRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Vv+mygVyhOaVIY98rTpV7NX3S5NY9burksZlAbcHS1t3QCxjZAzyvt0UsfFp/M5pWU282Zyinb3sW7ZCnVC8aOqOjHBgRwo2rkK6/7KxvVEvXm/cZAciCmr8lxVBQTMQ5akCRsSZB+0uK4QabUy6OVSK31jNsRmxsVP4yR7LwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LDTMi3HH reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OZVDyHYh0KlKWsp8NTWcA027/CB5TLukQZgz0P8Dac4=; b=L
	DTMi3HHZLUEVkA5EW2cTZegh1E22S9OWZ1mqqrC2s1dbi+brZcWR0fWPII/wMbpz
	lGgDXCFbl76zbs1UMstxgy7U11Iz6LZ9jN/NQ0MiM909rq52i92auTKJZQvyZxYY
	/bxMS6koRDIVF5MqtYYD7aeOl4YkeIMxpO/Hio2Krs=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Tue, 3 Jun 2025 16:15:58 +0800 (CST)
Date: Tue, 3 Jun 2025 16:15:58 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aD6hVAuHGNZjrKpr@e129823.arm.com>
References: <aD6hVAuHGNZjrKpr@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvWYt00u7iGcZukZnEYQheY4XMKyuPkg1YJXOp80iCXQ3wodeXBxJkTkwcOOJiWSvxe8aSZS7+RTe4BFYbCjYNOAPiFOkq1hPMFt4hnK
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <641140e5.84ac.19734dc8ac2.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgD3v9g_rz5oT9cSAA--.26955W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gBhqmg+n-RC7QAIsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMTU6MTY6MzYsICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+SGkgRGF2aWQsCj4KPj4gPgo+PiA+ID4KPj4gPiA+IEFsc28sIHlvdXIgcGF0
Y2ggY291bGRuJ3Qgc29sdmUgYSBwcm9ibGVtIGRlc2NyaWJlIGluCj4+ID4gPiBjb21taXQgYTNj
M2M2NjY3KCJwZXJmL2NvcmU6IEZpeCBjaGlsZF90b3RhbF90aW1lX2VuYWJsZWQgYWNjb3VudGlu
ZyBidWcgYXQgdGFzayBleGl0IikKPj4gPiA+IGZvciBJTkNBVElWRSBldmVudCdzIHRvdGFsX2Vu
YWJsZV90aW1lLgo+PiA+Cj4+ID4gSSBkbyBub3QgdGhpbmsgc28uCj4+ID4gQ29ycmVjdCBtZSBp
ZiBJIGFtIG1ha2luZyBzaWxseSAgbWlzdGFrZXMsCj4+ID4gVGhlIHBhdGNoLCBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjUwNjAzMDMyNjUxLjM5ODgtMS0wMDEwNzA4MkAxNjMuY29t
Lwo+PiA+IGNhbGxzIHBlcmZfZXZlbnRfc2V0X3N0YXRlKCkgYmFzZWQgb24gREVUQUNIX0VYSVQg
ZmxhZywgd2hpY2ggY292ZXIgdGhlIElOQUNUSVZFIHN0YXRlLCByaWdodD8KPj4gPiBJZiBERVRB
Q0hfRVhJVCBpcyBub3QgdXNlZCBmb3IgdGhpcyBwdXJwb3NlPyBUaGVuIHdoeSBzaG91bGQgaXQg
ZXhpc3QgYXQgdGhlIGZpcnN0IHBsYWNlPwo+PiA+IEkgdGhpbmsgSSBkb2VzIG5vdCByZXZlcnQg
dGhlIHB1cnBvc2Ugb2YgY29tbWl0IGEzYzNjNjY2Ny4uLi4uQnV0IEkgY291bGQgYmUgd3JvbmcK
Pj4gPiBXb3VsZCB5b3Ugc2hvdyBhIGNhbGwgcGF0aCB3aGVyZSBERVRBQ0hfRVhJVCBpcyBub3Qg
c2V0LCBidXQgdGhlIGNoYW5nZXMgaW4gY29tbWl0IGEzYzNjNjY2NyBpcyBzdGlsbCBuZWVkZWQ/
Cj4+ID4KPj4gPiBTb3JyeSBmb3IgbXkgYmFkIGV4cGxhaW5hdGlvbiB3aXRob3V0IGRldGFpbC4K
Pj4gPiBUaGluayBhYm91dCBjcHUgc3BlY2lmaWMgZXZlbnQgYW5kIGNsb3NlZCBieSB0YXNrLgo+
PiA+IElmIHRoZXJlIGlzIHNwZWNpZmljIGNoaWxkIGNwdSBldmVudCBzcGVjaWZpZWQgaW4gY3B1
IDAuCj4+ID4gMS4gY3B1IDAgLT4gYWN0aXZlCj4+ID4gMi4gc2NoZXVsZGVkIHRvIGNwdTEgLT4g
aW5hY3RpdmUKPj4gPiAzLiBjbG9zZSB0aGUgY3B1IGV2ZW50IGZyb20gcGFyZW50IC0+IGluYWN0
aXZlIGNsb3NlCj4+ID4KPj4gPiBDYW4gYmUgZmFpbGVkIHRvIGNvdW50IHRvdGFsX2VuYWJsZV90
aW1lLgo+Pgo+PiBJcyB0aGlzIGV4cGxhaW5pbmcgdGhlIHB1cnBvc2Ugb2YgY29tbWl0IGEzYzNj
NjY2NyA/Cj4+IEkgYW0gbm90IGFyZ3Vpbmcgd2l0aCBpdC4gQW5kIEkgYWxzbyBub3Qgc3VnZ2Vz
dCByZXZlcnRpbmcgaXQuIChpdCBpcyBqdXN0IHRoYXQgcmV2ZXJ0aW5nIGl0IGNhbiBmaXggdGhl
IGtlcm5lbCBwYW5pYy4pCj4KPkluIGNvbW1pdCBhM2MzYzY2NjcsIEkgZXhwbGFpbiB0aGUgc3Bl
Y2lmaWMgY2FzZSBidXQgbm90IHdpdGggYWJvdmUKPmNhc2UuIEJ1dCB0aGUgY29tbWl0J3MgcHVy
cG9zZSBpcyAiYWNjb3VudCB0b3RhbF9lbmFibGVfdGltZSIgcHJvcGVybHkuCj4KPj4gPiBBbmQg
YWxzbywgY29uc2lkZXJpbmcgdGhlIHlvdXIgcGF0Y2gsIGZvciBERVRBQ0hfRVhJVCBjYXNlLAo+
PiA+IElmIGl0IGNoYW5nZXMgdGhlIHN0YXRlIGJlZm9yZSBsaXN0X2RlbF9ldmVudCgpIHRoYXQg
d291bGRuJ3QgZGlzYWJsZQo+PiA+IHJlbGF0ZWQgdG8gdGhlIGNncm91cC4gU28gaXQgd291bGQg
bWFrZSBjcHVjdHgtPmNncnAgcG9pbnRlciBjb3VsZCBiZSBkYW5nbGVkCj4+ID4gYXMgcGF0Y2gg
ZGVzY3JpYmUuLi4KPj4gTm8sIEkgZG9uJ3QgdGhpbmsgc28uCj4+IGNoYW5nZSBzdGF0ZSBiZWZv
cmUgbGlzdF9kZWxfZXZlbnQoKSwgdGhpcyBpcyB0aGUgc2FtZSBiZWhhdmlvciBiZWZvcmUgY29t
bWl0IGEzYzNjNjY2NywgcmlnaHQ/Cj4+IEFuZCBubyBzdWNoIGtlcm5lbCBwYW5pYyBoYXBwZW5l
ZCAgYmVmb3JlIGNvbW1pdCBhM2MzYzY2NjcuCgpPaCEgSSB3YXMgd3JvbmcsIGJlZm9yZSBjb21t
aXQgYTNjM2M2NjY3LCAiY2hhbmdlIHN0YXRlIiBoYXBwZW5lZCAqYWZ0ZXIqIGxpc3RfZGVsX2V2
ZW50KCkKPgo+VGhhdCdzIHdoeSBsaXN0X2RlbF9ldmVudCgpIGhhbmRsZSB0aGUgcGVyZl9jZ3Jv
dXBfZGlzYWJsZSgpIGJlZm9yZSB0aGUKPmNvbW1pdCBhM2MzYzY2NjcuIEhvd2V2ZXIgYmVjYXVz
ZSBvZiAqbXkgbWlzdGFrZSosIEkndmUgZm9yZ2V0IHRvCj5wZXJmX2Nncm91cF9kaXNhYmxlKCkg
cHJvcGVybHkgYmVmb3JlIGNoYW5nZSB0aGUgZXZlbnQgc3RhdGUuCj5ZZXMsIHlvdXIgcGF0Y2gg
Y2FuIG1ha2UgYXZvaWQgdGhlIHBhbmljIHNpbmNlIGFzIHNvb24gYXMgZXhpdCwKPnRoZSBldmVu
dC0+Y2dycCBzd2l0Y2hlZC4KCiBJIGNhbm5vdCBhZ3JlZSB3aXRoIHRoZSByZWFzb25pbmcsIApU
aGUgcGFuaWMgZG9zZSBub3QgaGFwcGVuZWQgd2hlbiBleGl0LCBpdCBoYXBwZW5lZCB3aGVuIHJl
Ym9vdC9zaHV0ZG93bi4KKEkgY2xvc2UgcGVyZl9ldmVudF9vcGVuIGJlZm9yZSByZWJvb3QpCgoK
CgoKPgo+SG93ZXZlciwgYXMgSSBzYWlkLCB0aGUgSU5BQ1RJVkUgZXZlbnQgY291bGQgYmUgZmFp
bGVkIHRvIGNvdW50Cj50b3RhbF9lbmFibGVfdGltZS4KPgo+U28sIHNldCBldmVudCBzaG91bGQg
YmUgb2NjdXJlZCBiZWZvcmUgbGlzdF9kZWxfZXZlbnQoKS4KPkFuZCBzaW5jZSBpdCdzIGV2ZW50
LT5zdGF0ZSBjaGFuZ2Ugb24gcmVtb3ZlLgo+SXQgc2hvdWxkbid0IGhhdmUgYW55IHNpZGUgZWZm
ZWN0IHRoZSBzdGF0ZSBjaGFuZ2UgaXNuJ3QgY2F1c2Ugb2YgeW91cgo+cGFuaWMuIEJ1dCBtaXNz
ZWQgcGVyZl9jZ3JvdXBfZGlzYWJsZSgpLgoKQW55IHByb2NlZHVyZSB0byBicmluZyBvdXQgdGhl
IGltcGFjdCBvZiB0aGlzIG1pc3NlZCBwZXJmX2Nncm91cF9kaXNhYmxlKCk/Ck15IHN5c3RlbSBz
ZWVtcyBhbGwgbm9ybWFsLCB3aGVyZSBzaG91bGQgSSBjaGVjayBpdD8KCkJ1dCB0byBmaXggaXQs
ICBpc24ndCBmb2xsb3dpbmcgY2hhbmdlIGxlc3MgYWdncmVzc2l2ZT8KICAgICAgICBldmVudF9z
Y2hlZF9vdXQoZXZlbnQsIGN0eCk7Ci0gICAgICAgcGVyZl9ldmVudF9zZXRfc3RhdGUoZXZlbnQs
IG1pbihldmVudC0+c3RhdGUsIHN0YXRlKSk7CiAgICAgICAgaWYgKGZsYWdzICYgREVUQUNIX0dS
T1VQKQogICAgICAgICAgICAgICAgcGVyZl9ncm91cF9kZXRhY2goZXZlbnQpOwogICAgICAgIGlm
IChmbGFncyAmIERFVEFDSF9DSElMRCkKICAgICAgICAgICAgICAgIHBlcmZfY2hpbGRfZGV0YWNo
KGV2ZW50KTsKICAgICAgICBsaXN0X2RlbF9ldmVudChldmVudCwgY3R4KTsKKyAgICAgICBwZXJm
X2V2ZW50X3NldF9zdGF0ZShldmVudCwgbWluKGV2ZW50LT5zdGF0ZSwgc3RhdGUpKTsKIAoKRGF2
aWQKCgo+Cj5UaGFua3MuCj4tLQo+U2luY2VyZWx5LAo+WWVvcmV1bSBZdW4K

