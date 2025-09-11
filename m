Return-Path: <linux-kernel+bounces-811882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D80B52F15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0052C189E934
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B130FC3D;
	Thu, 11 Sep 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="athcgJq1"
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773E30BF7B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588598; cv=none; b=QbbKQX6MPwcPUXT0s+QN6kTYJrvpVmpRhd8trhkDO9Qf/0RLQTgX4Ke93OeXeYWuuGEu4bEev4zWNZtSwUdQUnWHlTd06f9du/tkUSV6mdiGFWg6rpSXQTjLN7p8A/za2UAk0eOMoySHIYcex+JJ4UIJxYpMraMPkqqo9iZZCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588598; c=relaxed/simple;
	bh=fxXYfYuEUMWMWEMhXocZjZMMHbOVriKZa63vgGLK6Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mpxo5g2lBUr/kwTljDv2IGWdbdJPVII8U/IWCsERW0X+trv8R4KdTsDFaeAhcZEqeF2SRvleFywlaY5dhzzZIg79Ztdsrr7KGVMjLXkUtFd2OpKJR+19rWl+PGBiemW83tfj4JlZQ3GuezQyjkxi7jYior/5iSo369drhina+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=athcgJq1; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757588596; x=1789124596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fxXYfYuEUMWMWEMhXocZjZMMHbOVriKZa63vgGLK6Mc=;
  b=athcgJq1HtWJgmZv/CQthtzzmnkB1avUYf4Y85A11BuMhExhSysg6L0T
   vANU3Oz1WAN4RoTwpNbhjYVLN3F8lcMKP2udYDXBiSGqXcQTgahdDNEz/
   i1bcfSBC3qdOGAQjviuFd3uLmLZBoseLWO1VKZbec2A3R79H7hp8I69Rz
   /61TKujxvy1jxWdWxlg++mt2iF6XLzd+S3jO0EqDBNzc8+uuyr3CsBr2A
   yaFx7WaHrL89/qEYj7BgRaOSKBcJ8suXG+GkgczlSOEN7ldtF/2/IrjBz
   zHhV7WesUMrGLLSulU5/681OFeWhSPuLPXYkYr3M3AB5pyPJsKsqPm5HP
   A==;
X-CSE-ConnectionGUID: i6PoqEnrQ/uR9L4HzljaBg==
X-CSE-MsgGUID: TLnq8sWnTKCfJrgY/jvb6w==
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="2709033"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:03:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:3171]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.200:2525] with esmtp (Farcaster)
 id e4fef6b6-769c-47bd-ad8d-c6cc963485a5; Thu, 11 Sep 2025 11:03:14 +0000 (UTC)
X-Farcaster-Flow-ID: e4fef6b6-769c-47bd-ad8d-c6cc963485a5
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 11:03:12 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 11 Sep 2025
 11:03:09 +0000
Message-ID: <b988336c-86a3-41b9-9711-7fe215ff66c7@amazon.com>
Date: Thu, 11 Sep 2025 13:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sched/fair: Only increment deadline once on yield
To: Fernand Sieber <sieberf@amazon.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <vincent.guittot@linaro.org>, <juri.lelli@redhat.com>
CC: <dietmar.eggemann@arm.com>, <bsegall@google.com>, <wangtao554@huawei.com>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>
References: <20250911095113.203439-1-sieberf@amazon.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20250911095113.203439-1-sieberf@amazon.com>
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDExLjA5LjI1IDExOjUxLCBGZXJuYW5kIFNpZWJlciB3cm90ZToKPiBJZiBhIHRhc2sgeWll
bGRzLCB0aGUgc2NoZWR1bGVyIG1heSBkZWNpZGUgdG8gcGljayBpdCBhZ2Fpbi4gVGhlIHRhc2sg
aW4KPiB0dXJuIG1heSBkZWNpZGUgdG8geWllbGQgaW1tZWRpYXRlbHkgb3Igc2hvcnRseSBhZnRl
ciwgbGVhZGluZyB0byBhIHRpZ2h0Cj4gbG9vcCBvZiB5aWVsZHMuCj4KPiBJZiB0aGVyZSdzIGFu
b3RoZXIgcnVubmFibGUgdGFzayBhcyB0aGlzIHBvaW50LCB0aGUgZGVhZGxpbmUgd2lsbCBiZQo+
IGluY3JlYXNlZCBieSB0aGUgc2xpY2UgYXQgZWFjaCBsb29wLiBUaGlzIGNhbiBjYXVzZSB0aGUg
ZGVhZGxpbmUgdG8gcnVuYXdheQo+IHByZXR0eSBxdWlja2x5LCBhbmQgc3Vic2VxdWVudCBlbGV2
YXRlZCBydW4gZGVsYXlzIGxhdGVyIG9uIGFzIHRoZSB0YXNrCj4gZG9lc24ndCBnZXQgcGlja2Vk
IGFnYWluLiBUaGUgcmVhc29uIHRoZSBzY2hlZHVsZXIgY2FuIHBpY2sgdGhlIHNhbWUgdGFzawo+
IGFnYWluIGFuZCBhZ2FpbiBkZXNwaXRlIGl0cyBkZWFkbGluZSBpbmNyZWFzaW5nIGlzIGJlY2F1
c2UgaXQgbWF5IGJlIHRoZQo+IG9ubHkgZWxpZ2libGUgdGFzayBhdCB0aGF0IHBvaW50Lgo+Cj4g
Rml4IHRoaXMgYnkgdXBkYXRpbmcgdGhlIGRlYWRsaW5lIG9ubHkgdG8gb25lIHNsaWNlIGFoZWFk
Lgo+Cj4gTm90ZSwgd2UgbWlnaHQgd2FudCB0byBjb25zaWRlciBpdGVyYXRpbmcgb24gdGhlIGlt
cGxlbWVudGF0aW9uIG9mIHlpZWxkIGFzCj4gZm9sbG93IHVwOgo+ICogdGhlIHlpZWxkaW5nIHRh
c2sgY291bGQgYmUgZm9yZmVpdGluZyBpdHMgcmVtYWluaW5nIHNsaWNlIGJ5Cj4gICAgaW5jcmVt
ZW50aW5nIGl0cyB2cnVudGltZSBjb3JyZXNwb25kaW5nbHkKPiAqIGluIGNhc2Ugb2YgeWllbGRf
dG8gdGhlIHlpZWxkaW5nIHRhc2sgY291bGQgYmUgZG9uYXRpbmcgaXRzIHJlbWFpbmluZwo+ICAg
IHNsaWNlIHRvIHRoZSB0YXJnZXQgdGFzawo+Cj4gRml4ZXM6IDE0N2YzZWZhYTI0MTgyICgic2No
ZWQvZmFpcjogSW1wbGVtZW50IGFuIEVFVkRGLWxpa2Ugc2NoZWR1bGluZyAgcG9saWN5IikKPiBS
ZXZpZXdlZC1ieTogTWFkYWRpIFZpbmVldGggUmVkZHkgPHZpbmVldGhyQGxpbnV4LmlibS5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogRmVybmFuZCBTaWViZXIgPHNpZWJlcmZAYW1hem9uLmNvbT4KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNDAxMTIzNjIyLjU4NDAxOC0xLXNp
ZWJlcmZAYW1hem9uLmNvbQo+IC0tLQo+IFJlc2VuZGluZyBpdCB3aXRoIG5vIGNvZGUgY2hhbmdl
cy4KPiBBZGRpbmcgImZpeGVzIiB0YWcgYXMgcGVyIEFsZXgncyBzdWdnZXN0aW9uIG9uIHRocmVh
ZC4KPiBBZGRpbmcgYSBmZXcgbW9yZSBzY2hlZHVsZXIgZm9sa3MuCj4gLS0tCj4gICBrZXJuZWwv
c2NoZWQvZmFpci5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5l
bC9zY2hlZC9mYWlyLmMKPiBpbmRleCBiMTczYTA1OTMxNWMuLmQ2YTBkMjJkMDhkNyAxMDA2NDQK
PiAtLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jCj4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYwo+
IEBAIC04OTIxLDcgKzg5MjEsNyBAQCBzdGF0aWMgdm9pZCB5aWVsZF90YXNrX2ZhaXIoc3RydWN0
IHJxICpycSkKPiAgIAkgKi8KPiAgIAlycV9jbG9ja19za2lwX3VwZGF0ZShycSk7Cj4KPiAtCXNl
LT5kZWFkbGluZSArPSBjYWxjX2RlbHRhX2ZhaXIoc2UtPnNsaWNlLCBzZSk7Cj4gKwlzZS0+ZGVh
ZGxpbmUgPSBzZS0+dnJ1bnRpbWUgKyBjYWxjX2RlbHRhX2ZhaXIoc2UtPnNsaWNlLCBzZSk7CgoK
UmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+CgoKQWxleAoKCgoK
QW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFy
YS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFu
IFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hh
cmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2
NSA1MzggNTk3Cg==


