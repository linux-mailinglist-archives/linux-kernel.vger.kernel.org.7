Return-Path: <linux-kernel+bounces-854156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3DBDDB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446233B82E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7831A07D;
	Wed, 15 Oct 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NDbgHZhI"
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06E31A81B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519671; cv=none; b=HRmN+/TlItvHlJ/GdRWTQf98WvvXHWMg7u5XsB4LRSYZQrg4iwYNthEuuJ85fo0QtHProYhdoGd0C+v8s2Jv+rNXx2wgB4o6MksTHdKJs+F0n3pmQrfOAAdEQ+q+dzhXycbdJwg4RGSJ1jevy1N77fDf9yLPre1W+Z3jvNXnN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519671; c=relaxed/simple;
	bh=jjw+ePzwis9Z4gVJuHW1idNd+X+pfzQ7ZRaH4bJppx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q8sbrvmlINj/NZuCvya/LydEi6WI05PEL3IVBNY2MA8faiX8pG+Vlms958hMNEOd2yn8fNOiPIEVHxbVpn+mNS7SwLLUfXfGEAWirdFd5b++Pia/NczbyK5J+LfMtliMFY8jWjPrtLtQ8l8N3bA7JuRq3IKqqzM3UN3JiuVK3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NDbgHZhI; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1760519669; x=1792055669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jjw+ePzwis9Z4gVJuHW1idNd+X+pfzQ7ZRaH4bJppx8=;
  b=NDbgHZhIoc+JCxNsLEaO7U4rSZf6alf9/yz+QEtz64ZcFehKM6tzsHJT
   TWrtvKn4Hy+8eR0+xgnkyGAWPLjsEv1g088xAnnVqiBiTAmuC7hcVacP9
   qqlg0o0GSgadcwhrYgheYp/CW8TxLzaMbWhbHI6kE1ta8HMv2YoY87rSU
   ULvfvJ/UV/8ALtz2MEnN3HLJR86xLmw4dvi5NbYBOROwq6E6+4LJP2+6o
   /Xsx3rxPbAuPL1qnennq+IK313ypu7B0Wycs0xrVcamVIrcHGA2vCi5HA
   EGx8hcgdw4bTO/zvSCIK6WT5vwMlbhNtdC81XOT+Ums7HAZCOVDKBH3a6
   Q==;
X-CSE-ConnectionGUID: 8iD7RKVZSR6FkA+lpvNy6Q==
X-CSE-MsgGUID: t27Pb2+CSFaazaVDp2caZg==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4806438"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:14:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:21978]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.171:2525] with esmtp (Farcaster)
 id e1fa3263-022f-4faa-8970-01f1b3b14041; Wed, 15 Oct 2025 09:14:27 +0000 (UTC)
X-Farcaster-Flow-ID: e1fa3263-022f-4faa-8970-01f1b3b14041
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 09:14:26 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 15 Oct 2025
 09:14:23 +0000
Message-ID: <a3af3751-89e2-451d-a20c-07b3857bed9b@amazon.com>
Date: Wed, 15 Oct 2025 11:14:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
To: "Kaplan, David" <David.Kaplan@amd.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H
 . Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <bjgjmijirueqwwmuen5dr6v7yqdcivk6kwa6gbukn3rodfcwko@fb5yxyqycena>
 <LV3PR12MB9265D0A464C2F597219A7B1294EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <LV3PR12MB9265D0A464C2F597219A7B1294EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE0LjEwLjI1IDIwOjA2LCBLYXBsYW4sIERhdmlkIHdyb3RlOgo+IFtBTUQgT2ZmaWNpYWwg
VXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5l
bC5vcmc+Cj4+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTQsIDIwMjUgMTE6MjkgQU0KPj4gVG86
IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPgo+PiBDYzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47
IFBldGVyCj4+IFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFBhd2FuIEd1cHRhCj4+
IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdvIE1vbG5hciA8bWluZ29A
cmVkaGF0LmNvbT47IERhdmUKPj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+
OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluCj4+IDxocGFAenl0b3IuY29tPjsgQWxl
eGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT47IEJvcmlzIE9zdHJvdnNreQo+PiA8Ym9yaXMu
b3N0cm92c2t5QG9yYWNsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+IFN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAwLzU2XSBEeW5hbWljIG1pdGlnYXRpb25zCj4+Cj4+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyIGNhdXRpb24KPj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4KPj4KPj4KPj4gT24gTW9uLCBPY3QgMTMsIDIwMjUgYXQgMDk6
MzM6NDhBTSAtMDUwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOgo+Pj4gRHluYW1pYyBtaXRpZ2F0aW9u
cyBlbmFibGVzIGNoYW5naW5nIHRoZSBrZXJuZWwgQ1BVIHNlY3VyaXR5IG1pdGlnYXRpb25zIGF0
Cj4+PiBydW50aW1lIHdpdGhvdXQgYSByZWJvb3Qva2V4ZWMuCj4+Pgo+Pj4gUHJldmlvdXNseSwg
bWl0aWdhdGlvbiBjaG9pY2VzIGhhZCB0byBiZSBtYWRlIG9uIHRoZSBrZXJuZWwgY21kbGluZS4g
IFdpdGgKPj4+IHRoaXMgZmVhdHVyZSBhbiBhZG1pbmlzdHJhdG9yIGNhbiBzZWxlY3QgbmV3IG1p
dGlnYXRpb24gY2hvaWNlcyBieSB3cml0aW5nCj4+PiBhIHN5c2ZzIGZpbGUsIGFmdGVyIHdoaWNo
IHRoZSBrZXJuZWwgd2lsbCByZS1wYXRjaCBpdHNlbGYgYmFzZWQgb24gdGhlIG5ldwo+Pj4gbWl0
aWdhdGlvbnMuCj4+Pgo+Pj4gQXMgdGhlIHBlcmZvcm1hbmNlIGNvc3Qgb2YgQ1BVIG1pdGlnYXRp
b25zIGNhbiBiZSBzaWduaWZpY2FudCwgc2VsZWN0aW5nCj4+PiB0aGUgcmlnaHQgc2V0IG9mIG1p
dGlnYXRpb25zIGlzIGltcG9ydGFudCB0byBhY2hpZXZlIHRoZSBjb3JyZWN0IGJhbGFuY2Ugb2YK
Pj4+IHBlcmZvcm1hbmNlL3NlY3VyaXR5Lgo+Pj4KPj4+IFVzZQo+Pj4gLS0tCj4+PiBBcyBkZXNj
cmliZWQgaW4gdGhlIHN1cHBsaWVkIGRvY3VtZW50YXRpb24gZmlsZSwgbmV3IG1pdGlnYXRpb25z
IGFyZQo+Pj4gc2VsZWN0ZWQgYnkgd3JpdGluZyBjbWRsaW5lIG9wdGlvbnMgdG8gYSBuZXcgc3lz
ZnMgZmlsZS4gIE9ubHkgY21kbGluZQo+Pj4gb3B0aW9ucyByZWxhdGVkIHRvIG1pdGlnYXRpb25z
IGFyZSByZWNvZ25pemVkIHZpYSB0aGlzIGludGVyZmFjZS4gIEFsbAo+Pj4gcHJldmlvdXMgbWl0
aWdhdGlvbi1yZWxhdGVkIGNtZGxpbmUgb3B0aW9ucyBhcmUgaWdub3JlZCBhbmQgc2VsZWN0aW9u
cyBhcmUKPj4+IGRvbmUgYmFzZWQgb24gdGhlIG5ldyBvcHRpb25zLgo+Pj4KPj4+IEV4YW1wbGVz
Ogo+Pj4gICAgIGVjaG8gIm1pdGlnYXRpb25zPW9mZiIgPiAvc3lzL2RldmljZXMvc3lzdGVtL2Nw
dS9taXRpZ2F0aW9ucwo+Pj4gICAgIGVjaG8gInNwZWN0cmVfdjI9cmV0cG9saW5lIHRzYT1vZmYi
ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvbWl0aWdhdGlvbnMKPj4+Cj4+Pgo+Pj4gVGhlcmUg
YXJlIHNldmVyYWwgdXNlIGNhc2VzIHRoYXQgd2lsbCBiZW5lZml0IGZyb20gZHluYW1pYyBtaXRp
Z2F0aW9uczoKPj4+Cj4+PiBVc2UgQ2FzZXMKPj4+IC0tLS0tLS0tLQo+Pj4gMS4gUnVudGltZSBQ
b2xpY3kKPj4+Cj4+PiBTb21lIHdvcmtmbG93cyByZWx5IG9uIGJvb3RpbmcgYSBnZW5lcmljIGtl
cm5lbCBiZWZvcmUgY3VzdG9taXppbmcgdGhlIHN5c3RlbS4KPj4+IGNsb3VkLWluaXQgaXMgYSBw
b3B1bGFyIGV4YW1wbGUgb2YgdGhpcyB3aGVyZSBhIFZNIGlzIHN0YXJ0ZWQgdHlwaWNhbGx5IHdp
dGgKPj4+IGRlZmF1bHQgc2V0dGluZ3MgYW5kIHRoZW4gaXMgY3VzdG9taXplZCBiYXNlZCBvbiBh
IGN1c3RvbWVyLXByb3ZpZGVkCj4+PiBjb25maWd1cmF0aW9uIGZpbGUuCj4+IEknbSBub3QgcmVh
bGx5IGEgZmFuIG9mIHRoaXMuICBJdCBhZGRzIGNvbXBsZXhpdHkgdG8gc29tZSBhcmVhcyB0aGF0
IGFyZQo+PiBhbHJlYWR5IHN0cnVnZ2xpbmcgd2l0aCB0b28gbXVjaCBjb21wbGV4aXR5Lgo+Pgo+
PiBJTU8gdGhpcyB3b3VsZCBuZWVkIHNvbWUgUkVBTExZIHN0cm9uZyBqdXN0aWZpY2F0aW9uLCBt
b3JlIHRoYW4ganVzdAo+PiAiaGV5LCB0aGlzIG1ha2VzIHRoaW5ncyBtb3JlIGNvbnZlbmllbnQu
Igo+Pgo+PiBUaGUgbWl0aWdhdGlvbnMgc2hvdWxkIGJlIGEgInNldCBpdCBhbmQgZm9yZ2V0IGl0
IiB0aGluZy4gIEkgZG9uJ3Qgc2VlCj4+IGFueXRoaW5nIGhlcmUgd2hpY2gganVzdGlmaWVzIHRo
ZSBjb25zaWRlcmFibGUgbWFpbnRlbmFuY2UgYnVyZGVuIHRoaXMKPj4gd291bGQgYWRkIGZvciBh
bGwgZXhpc3RpbmcgYW5kIGZ1dHVyZSBtaXRpZ2F0aW9ucy4KPj4KPiBUaGUgcHJvYmxlbSBpcyB0
aGVyZSBhcmUgZW52aXJvbm1lbnRzIGxpa2UgdGhlIG9uZSBvdXRsaW5lZCB3aGVyZSB5b3UgY2Fu
J3QganVzdCAnc2V0IGl0IGFuZCBmb3JnZXQgaXQnIGJlY2F1c2UgdGhlIGtlcm5lbCBuZWVkcyBp
dCBzZXQgYXQgYm9vdC10aW1lLCBidXQgaW4gdGhlc2UgZW52aXJvbm1lbnRzIHlvdSBkb24ndCBr
bm93IGhvdyB0byBjb25maWd1cmUgdGhlIHN5c3RlbSB1bnRpbCBtdWNoIGxhdGVyIGluIGJvb3Qu
ICBTbyB5b3UgZW5kIHVwIHJ1bm5pbmcgd2l0aCB0aGUgZGVmYXVsdCBzZXR0aW5ncyBhbGwgdGhl
IHRpbWUsIGV2ZW4gaWYgeW91IGRvbid0IG5lZWQgdGhlbS4gIEFuZCB0aGUgZGVmYXVsdCBzZXR0
aW5ncyBjYW4gaGF2ZSBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBpbXBhY3RzIGluIG1hbnkgY2Fz
ZXMuCj4KPiBUaGUgY2xvdWQgZ3V5cyBvbiB0aGlzIHRocmVhZCBtYXkgYmUgYWJsZSB0byBvZmZl
ciBzb21lIGFkZGl0aW9uYWwgY29sb3IgaGVyZSBzaW5jZSBJIGJlbGlldmUgdGhhdCdzIHdoZXJl
IHlvdSdyZSBtb3N0IGxpa2VseSB0byBoYXZlIHRoaXMgc2l0dWF0aW9uLgoKClRoZSBjcnV4IG9m
IHRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBpcyAKZGlm
ZmljdWx0IHRvIGluZmx1ZW5jZSBpbiBtb3N0IGNsb3VkIGVudmlyb25tZW50cy4KCkluIHRoZSBj
bG91ZCwgeW91IHR5cGljYWxseSBzdGFydCBmcm9tIGEgZ2VuZXJpYyBiYXNlIGltYWdlIHdoaWNo
IHRoZW4gCmJvb3RzLCB0YWxrcyB0byBhIGNvbmZpZ3VyYXRpb24gbWVjaGFuaXNtIChJTURTIGlu
IEVDMikgd2hpY2ggdGhlbiAKY29udGFpbnMgYWxsIG9mIHRoZSBhY3R1YWwgY3VzdG9taXphdGlv
bi4gRm9yIG1vc3QgY3VzdG9taXphdGlvbiwgdGhhdCAKaXMgcGVyZmVjdGx5IGZpbmU6IFlvdSBj
YW4gaW5zdGFsbCBwYWNrYWdlcywgcnVuIHNjcmlwdHMsIGxhdW5jaCAKc2VydmljZXMsIGV0Yy4g
QnV0IHRoZXJlIGlzIG5vIHNpbXBsZSB3YXkgdG8gbW9kaWZ5IHRoZSBrZXJuZWwgY29tbWFuZCAK
bGluZS4gVGhlIHN0b3J5IGdldHMgZXZlbiB3b3JzZSB3aGVuIHlvdSB0cnkgdG8gYWJzdHJhY3Qg
dGhlIGNsb3VkIAplbnZpcm9ubWVudCBpdHNlbGYgYnkgdXNpbmcgY29uZmlndXJhdGlvbiBsYXll
cnMgb24gdG9wIGxpa2UgcHVwcGV0LCAKYW5zaWJsZSwgc2FsdCwgZXRjLiBiZWNhdXNlIHlvdSBj
b3VsZCBub3QgZG8gYSBwcmUtYm9vdCBlbnZpcm9ubWVudCBoYWNrIApldmVuIGlmIHlvdSB3YW50
ZWQgdG8uCgpVc2VycyBjb3VsZCBpbiB0aGVvcnkgaGF2ZSBhIGJvb3R1cCBzY3JpcHQgd2hpY2gg
Y2hlY2tzIHRoZSBjdXJyZW50IApjb21tYW5kIGxpbmUsIG1vZGlmaWVzIHRoZSBib290IGxvYWRl
ciBjb25maWd1cmF0aW9uLCByZWdlbmVyYXRlcyBib290IApsb2FkZXIgY29uZmlnIGZpbGVzIChJ
ZiB0aGV5IGV2ZW4gY2FuLiBTaWduZWQgVUtJcyBtYWtlIHRoYXQgZGlmZmljdWx0KSwgCmFuZCB0
aGVuIHJlYm9vdC9rZXhlYyBpbnRvIHRoZSBuZXcgZW52aXJvbm1lbnQuIFNvIHdlIHdvdWxkIHB1
bnQgYSAqbG90KiAKb2YgY29tcGxleGl0eSBvbnRvIHVzZXJzIGFuZCBzdGlsbCBkZWdyYWRlIHRo
ZWlyIGV4cGVyaWVuY2UgYnkgCnByb2xvbmdpbmcgdGhlIGxhdW5jaCBwaGFzZS4KCkknbSBhbGwg
ZWFycyBmb3IgYWx0ZXJuYXRpdmVzLCBidXQgcnVudGltZSBzZXR0aW5nIHNlZW1zIGxpa2UgdGhl
IG1vc3QgCm5hdHVyYWwgd2F5IHRvIGFsbG93IGJvb3R1cCAvIGNvbmZpZ3VyYXRpb24gc2NyaXB0
cyB0byBhY3R1YWxseSBpbnN0aWxsIApwb2xpY3kuCgoKQWxleAoKCgoKQW1hem9uIFdlYiBTZXJ2
aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMK
MTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlcgpFaW5n
ZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIK
U2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


