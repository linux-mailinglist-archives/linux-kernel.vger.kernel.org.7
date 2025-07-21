Return-Path: <linux-kernel+bounces-739920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CCB0CD20
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D406B17E396
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B519E7E2;
	Mon, 21 Jul 2025 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ROTKAWBk"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE713C81B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135294; cv=none; b=mxYIIQsjo2WjeJeRIvdBSToDa794atmZw89TVEMmxZQ/LMXNlocqYythDL9pmqjQSWQcrT5oT+GotmyuzPjdBU+e/1AMKiiyx+sevm+/SrvW/5VA8msJD8AlHnBLV0c5gyQWZpwGLDAnV/nQ5zCHkgA5fByuYlhiRwkwPpXUYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135294; c=relaxed/simple;
	bh=zy2QMMai1zG6JVHlBzttv5g5/f3YFmHNjDX53ITTHLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eBTozoM3UuVtTCob9VFbcsAj+JwJuoiSB4FxaPPFjUTxAjGns832sCayfMh31ZpY6ERBr670v5Tx/v0c3ty19SnVuDy5nMMah7+PvR5YQUiSqlqYSX3SeQYruuzykKid2DAlzE0ob76GkC3zAs5fUz8DlBM7x1sSfkk0cfKtD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ROTKAWBk; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1753135294; x=1784671294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zy2QMMai1zG6JVHlBzttv5g5/f3YFmHNjDX53ITTHLw=;
  b=ROTKAWBkAj4c/l6ylzNd5Fftn3YxzBMqsARFpQyQLJoiPQAhhYcHJ5Ne
   0Z5e3uFwRHO+nN8MYNyYVUUfDWDJq7C/TPKzHs3wCzApftnC56SnUbc2w
   4yuKldsVANwAX8nnBDsZnhdf69UTq1pvl6zrUnabUfuju7qJlgxTe03tE
   dcslhZAeIxxdcVsOBmAEAoaUyueWWkUXI9VTCV2iFBaeVYHwtjKozG1B8
   H9G/QTqWggLmQ7bj1MT+3Ivqu0fYyZZXjcxGeq80Gizc4vA27rF7jBkSm
   JIIllVAwKJn3F1DC4nEtaRJtvN9RSTnYRynpk/+SYUKnUpfJhERuuXKRt
   g==;
X-IronPort-AV: E=Sophos;i="6.16,330,1744070400"; 
   d="scan'208";a="70263022"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 22:01:31 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:36072]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.50:2525] with esmtp (Farcaster)
 id 4d3b2f01-b0fc-4356-ba57-4fe2df437c7a; Mon, 21 Jul 2025 22:01:30 +0000 (UTC)
X-Farcaster-Flow-ID: 4d3b2f01-b0fc-4356-ba57-4fe2df437c7a
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 21 Jul 2025 22:01:29 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 21 Jul 2025
 22:01:27 +0000
Message-ID: <07b21458-832f-4b15-9bc8-43f21f902e34@amazon.com>
Date: Tue, 22 Jul 2025 00:01:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] kexec: Enable CMA based contiguous allocation
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, Baoquan He <bhe@redhat.com>, Zhongkun He
	<hezhongkun.hzk@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20250610085327.51817-1-graf@amazon.com>
 <CA+CK2bBhUdEjD=-gM3=D6mKBYctbXh74_hq-bMf1fa8mfS2Edg@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CA+CK2bBhUdEjD=-gM3=D6mKBYctbXh74_hq-bMf1fa8mfS2Edg@mail.gmail.com>
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDEwLjA2LjI1IDEzOjMxLCBQYXNoYSBUYXRhc2hpbiB3cm90ZToKPiBPbiBUdWUsIEp1biAx
MCwgMjAyNSBhdCA0OjUz4oCvQU0gQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4gd3Jv
dGU6Cj4+IFdoZW4gYm9vdGluZyBhIG5ldyBrZXJuZWwgd2l0aCBrZXhlY19maWxlLCB0aGUga2Vy
bmVsIHBpY2tzIGEgdGFyZ2V0Cj4+IGxvY2F0aW9uIHRoYXQgdGhlIGtlcm5lbCBzaG91bGQgbGl2
ZSBhdCwgdGhlbiBhbGxvY2F0ZXMgcmFuZG9tIHBhZ2VzLAo+PiBjaGVja3Mgd2hldGhlciBhbnkg
b2YgdGhvc2UgcGF0Y2hlcyBtYWdpY2FsbHkgaGFwcGVucyB0byBjb2luY2lkZSB3aXRoCj4+IGEg
dGFyZ2V0IGFkZHJlc3MgcmFuZ2UgYW5kIGlmIHNvLCB1c2VzIHRoZW0gZm9yIHRoYXQgcmFuZ2Uu
Cj4+Cj4+IEZvciBldmVyeSBwYWdlIGFsbG9jYXRlZCB0aGlzIHdheSwgaXQgdGhlbiBjcmVhdGVz
IGEgcGFnZSBsaXN0IHRoYXQgdGhlCj4+IHJlbG9jYXRpb24gY29kZSAtIGNvZGUgdGhhdCBleGVj
dXRlcyB3aGlsZSBhbGwgQ1BVcyBhcmUgb2ZmIGFuZCB3ZSBhcmUKPj4ganVzdCBhYm91dCB0byBq
dW1wIGludG8gdGhlIG5ldyBrZXJuZWwgLSBjb3BpZXMgdG8gdGhlaXIgZmluYWwgbWVtb3J5Cj4+
IGxvY2F0aW9uLiBXZSBjYW4gbm90IHB1dCB0aGVtIHRoZXJlIGJlZm9yZSwgYmVjYXVzZSBjaGFu
Y2VzIGFyZSBwcmV0dHkKPj4gZ29vZCB0aGF0IGF0IGxlYXN0IHNvbWUgcGFnZSBpbiB0aGUgdGFy
Z2V0IHJhbmdlIGlzIGFscmVhZHkgaW4gdXNlIGJ5Cj4+IHRoZSBjdXJyZW50bHkgcnVubmluZyBM
aW51eCBlbnZpcm9ubWVudC4gQ29weWluZyBpcyBoYXBwZW5pbmcgZnJvbSBhCj4+IHNpbmdsZSBD
UFUgYXQgUkFNIHJhdGUsIHdoaWNoIHRha2VzIGFyb3VuZCA0LTUwIG1zIHBlciAxMDAgTWlCLgo+
Pgo+PiBBbGwgb2YgdGhpcyBpcyBpbmVmZmljaWVudCBhbmQgZXJyb3IgcHJvbmUuCj4+Cj4+IFRv
IHN1Y2Nlc3NmdWxseSBrZXhlYywgd2UgbmVlZCB0byBxdWllc2NlIGFsbCBkZXZpY2VzIG9mIHRo
ZSBvdXRnb2luZwo+PiBrZXJuZWwgc28gdGhleSBkb24ndCBzY3JpYmJsZSBvdmVyIHRoZSBuZXcg
a2VybmVsJ3MgbWVtb3J5LiBXZSBoYXZlIHNlZW4KPj4gY2FzZXMgd2hlcmUgdGhhdCBkb2VzIG5v
dCBoYXBwZW4gcHJvcGVybHkgKCpjb3VnaCogR0lDICpjb3VnaCopIGFuZCBoZW5jZQo+PiB0aGUg
bmV3IGtlcm5lbCB3YXMgY29ycnVwdGVkLiBUaGlzIHN0YXJ0ZWQgYSBtb250aCBsb25nIGpvdXJu
ZXkgdG8gcm9vdAo+PiBjYXVzZSBmYWlsaW5nIGtleGVjcyB0byBldmVudHVhbGx5IHNlZSBtZW1v
cnkgY29ycnVwdGlvbiwgYmVjYXVzZSB0aGUgbmV3Cj4+IGtlcm5lbCB3YXMgY29ycnVwdGVkIHNl
dmVyZWx5IGVub3VnaCB0aGF0IGl0IGNvdWxkIG5vdCBlbWl0IG91dHB1dCB0bwo+PiB0ZWxsIHVz
IGFib3V0IHRoZSBmYWN0IHRoYXQgaXQgd2FzIGNvcnJ1cHRlZC4gQnkgYWxsb2NhdGluZyBtZW1v
cnkgZm9yIHRoZQo+PiBuZXh0IGtlcm5lbCBmcm9tIGEgbWVtb3J5IHJhbmdlIHRoYXQgaXMgZ3Vh
cmFudGVlZCBzY3JpYmJsaW5nIGZyZWUsIHdlIGNhbgo+PiBib290IHRoZSBuZXh0IGtlcm5lbCB1
cCB0byBhIHBvaW50IHdoZXJlIGl0IGlzIGF0IGxlYXN0IGFibGUgdG8gZGV0ZWN0Cj4+IGNvcnJ1
cHRpb24gYW5kIG1heWJlIGV2ZW4gc3RvcCBpdCBiZWZvcmUgaXQgYmVjb21lcyBzZXZlcmUuIFRo
aXMgaW5jcmVhc2VzCj4+IHRoZSBjaGFuY2UgZm9yIHN1Y2Nlc3NmdWwga2V4ZWNzLgo+Pgo+PiBT
aW5jZSBrZXhlYyBnb3QgaW50cm9kdWNlZCwgTGludXggaGFzIGdhaW5lZCB0aGUgQ01BIGZyYW1l
d29yayB3aGljaAo+PiBjYW4gcGVyZm9ybSBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgbWVtb3J5IG1h
cHBpbmdzLCB3aGlsZSBrZWVwaW5nIHRoYXQKPj4gbWVtb3J5IGF2YWlsYWJsZSBmb3IgbW92YWJs
ZSBtZW1vcnkgd2hlbiBpdCBpcyBub3QgbmVlZGVkIGZvciBjb250aWd1b3VzCj4+IGFsbG9jYXRp
b25zLiBUaGUgZGVmYXVsdCBDTUEgYWxsb2NhdG9yIGlzIGZvciBETUEgYWxsb2NhdGlvbnMuCj4+
Cj4+IFRoaXMgcGF0Y2ggYWRkcyBsb2dpYyB0byB0aGUga2V4ZWMgZmlsZSBsb2FkZXIgdG8gYXR0
ZW1wdCB0byBwbGFjZSB0aGUKPj4gdGFyZ2V0IHBheWxvYWQgYXQgYSBsb2NhdGlvbiBhbGxvY2F0
ZWQgZnJvbSBDTUEuIElmIHN1Y2Nlc3NmdWwsIGl0IHVzZXMKPj4gdGhhdCBtZW1vcnkgcmFuZ2Ug
ZGlyZWN0bHkgaW5zdGVhZCBvZiBjcmVhdGluZyBjb3B5IGluc3RydWN0aW9ucyBkdXJpbmcKPj4g
dGhlIGhvdCBwaGFzZS4gVG8gZW5zdXJlIHRoYXQgdGhlcmUgaXMgYSBzYWZldHkgbmV0IGluIGNh
c2UgYW55dGhpbmcgZ29lcwo+PiB3cm9uZyB3aXRoIHRoZSBDTUEgYWxsb2NhdGlvbiwgaXQgYWxz
byBhZGRzIGEgZmxhZyBmb3IgdXNlciBzcGFjZSB0byBmb3JjZQo+PiBkaXNhYmxlIENNQSBhbGxv
Y2F0aW9ucy4KPj4KPj4gVXNpbmcgQ01BIGFsbG9jYXRpb25zIGhhcyB0d28gYWR2YW50YWdlczoK
Pj4KPj4gICAgMSkgRmFzdGVyIGJ5IDQtNTAgbXMgcGVyIDEwMCBNaUIuIFRoZXJlIGlzIG5vIG1v
cmUgbmVlZCB0byBjb3B5IGluIHRoZQo+PiAgICAgICBob3QgcGhhc2UuCj4+ICAgIDIpIE1vcmUg
cm9idXN0LiBFdmVuIGlmIGJ5IGFjY2lkZW50IHNvbWUgcGFnZSBpcyBzdGlsbCBpbiB1c2UgZm9y
IERNQSwKPj4gICAgICAgdGhlIG5ldyBrZXJuZWwgaW1hZ2Ugd2lsbCBiZSBzYWZlIGZyb20gdGhh
dCBhY2Nlc3MgYmVjYXVzZSBpdCByZXNpZGVzCj4+ICAgICAgIGluIGEgbWVtb3J5IHJlZ2lvbiB0
aGF0IGlzIGNvbnNpZGVyZWQgYWxsb2NhdGVkIGluIHRoZSBvbGQga2VybmVsIGFuZAo+PiAgICAg
ICBoYXMgYSBjaGFuY2UgdG8gcmVpbml0aWFsaXplIHRoYXQgY29tcG9uZW50Lgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+PiBBY2tlZC1ieTog
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gUmV2aWV3ZWQtYnk6IFBhc2hhIFRhdGFzaGlu
IDxwYXNoYS50YXRhc2hpbkBzb2xlZW4uY29tPgoKCkFuZHJldywgSSBkb24ndCBzZWUgdGhpcyBw
YXRjaCBpbiBsaW51cy9tYXN0ZXIuIElzIGl0IHN0aWxsIGluIHlvdXIgCnF1ZXVlPyA6KQoKQWxl
eAoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
ClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hy
aXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDM2NSA1MzggNTk3Cg==


