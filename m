Return-Path: <linux-kernel+bounces-833734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40234BA2E57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876E5189B640
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F528D8D0;
	Fri, 26 Sep 2025 08:15:27 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA91E503D;
	Fri, 26 Sep 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758874526; cv=none; b=OU+W4fhDAAYrw6M0Juifh2HBp2OReuli1TEvlaw/r2LkoD/wUOBhWnn5LLy6onEkZvkdBuBS0uY18smdSogm0S/c7FKbjns/QHvpPFdQTfJl2N1rRv/KdlZ5zkjJwQ01xK+3p8n5070GsbKejTOidr2gASGX8Uu5Qz957yVRnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758874526; c=relaxed/simple;
	bh=01qg0zQGxHg/uzySYOyUQDpGHKB8R+Urato8yjG+11A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aj2IuKrstLxG+qRNRbnChf9+qcfpvlm78+LODeVi0ZOTTgPzDO76ROwzxZMrrYnw46BKs4IEsY0fBYyDtC7CMVe6DqBe2O6J6yZV+NVUSsWOoQb0jsI/nlnor/OdBvuRE4B9dkWmVCN+dSKfnDVEhgqCxKD2X1UBTO57hv1MC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from caohang$eswincomputing.com ( [10.127.112.153] ) by
 ajax-webmail-app1 (Coremail) ; Fri, 26 Sep 2025 16:15:03 +0800 (GMT+08:00)
Date: Fri, 26 Sep 2025 16:15:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Hang Cao" <caohang@eswincomputing.com>
To: "Conor Dooley" <conor@kernel.org>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	"Senchuan Zhang" <zhangsenchuan@eswincomputing.com>
Subject: Re: Re: Re: [PATCH v3 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20250924-shimmer-sphinx-1a12caeab401@spud>
References: <20250915085329.2058-1-caohang@eswincomputing.com>
 <20250915091024.2128-1-caohang@eswincomputing.com>
 <20250915-affair-halves-4f881f6c7cdb@spud>
 <17731a13.1cce.19974dfc64d.Coremail.caohang@eswincomputing.com>
 <20250924-shimmer-sphinx-1a12caeab401@spud>
Content-Type: multipart/mixed; 
	boundary="----=_Part_28961_865295059.1758874503643"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d546ce3.1ff1.199851709e0.Coremail.caohang@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgCXuxGHS9ZoPSDhAA--.18376W
X-CM-SenderInfo: xfdrxt1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQEREGjVbnoYWAAA
	so
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWDJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

------=_Part_28961_865295059.1758874503643
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGksIENvbm9yIERvb2xleQogICAgV2UgZ290IHlvdXIgcG9pbnQsIGFuZCB5b3VyIHN1Z2dlc3Rp
b25zIHNvdW5kIHZlcnkgcmVhc29uYWJsZS4gSSdsbCBjb29yZGluYXRlIHdpdGggY29sbGVhZ3Vl
cyAKcmVzcG9uc2libGUgZm9yIGNsb2NrIGFuZCByZXNldCBmdW5jdGlvbnMgdG8gdHJ5IGFuZCBp
bXBsZW1lbnQgZGVkaWNhdGVkIGRyaXZlcnMgYXMgc29vbiBhcyBwb3NzaWJsZSwgCnNlcGFyYXRp
bmcgdGhpcyBwYXJ0IGZyb20gaHNwLWNzci4KCkJlc3QgcmVnYXJkcywKSGFuZyBDYW8KCj4gT24g
VHVlLCBTZXAgMjMsIDIwMjUgYXQgMTI6NDA6NDZQTSArMDgwMCwgSGFuZyBDYW8gd3JvdGU6Cj4g
PiA+ID4gRnJvbTogSGFuZyBDYW8gPGNhb2hhbmdAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gPiA+
ICsgIGVzd2luLGhzcC1zcC1jc3I6Cj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjoKPiA+ID4gPiAr
ICAgICAgSFNQIENTUiBpcyB0byBjb250cm9sIGFuZCBnZXQgc3RhdHVzIG9mIGRpZmZlcmVudCBo
aWdoLXNwZWVkIHBlcmlwaGVyYWxzCj4gPiA+ID4gKyAgICAgIChzdWNoIGFzIEV0aGVybmV0LCBV
U0IsIFNBVEEsIGV0Yy4pIHZpYSByZWdpc3Rlciwgd2hpY2ggY2FuIGNsb3NlCj4gPiA+ID4gKyAg
ICAgIG1vZHVsZSdzIGNsb2NrLHJlc2V0IG1vZHVsZSBpbmRlcGVuZGVudGx5IGFuZCB0dW5lIGJv
YXJkLWxldmVsJ3MKPiA+ID4gPiArICAgICAgcGFyYW1ldGVycyBvZiBQSFksIGV0Yy4KPiA+ID4g
PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUtYXJy
YXkKPiA+ID4gPiArICAgIGl0ZW1zOgo+ID4gPiA+ICsgICAgICAtIGl0ZW1zOgo+ID4gPiA+ICsg
ICAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhhbmRsZSB0byBIU1AgUmVnaXN0ZXIgQ29udHJvbGxl
ciBoc3Bfc3BfY3NyIG5vZGUuCj4gPiA+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiB1c2Ig
YnVzIHJlZ2lzdGVyIG9mZnNldC4KPiA+ID4gPiArICAgICAgICAgIC0gZGVzY3JpcHRpb246IGF4
aSBsb3cgcG93ZXIgcmVnaXN0ZXIgb2Zmc2V0Lgo+ID4gPiA+ICsgICAgICAgICAgLSBkZXNjcmlw
dGlvbjogdmJ1cyBmcmVxdWVuY3kgcmVnaXN0ZXIgb2Zmc2V0Lgo+ID4gPiA+ICsgICAgICAgICAg
LSBkZXNjcmlwdGlvbjogbXBsbCByZWdpc3RlciBvZmZzZXQuCj4gPiA+IAo+ID4gPiBBcyBJIG1l
bnRpb25lZCBvbiB0aGUgc2hkY2kgYmluZGluZyBwYXRjaCwgSSdtIG5vdCBoYXBweSB3aXRoIHRo
ZQo+ID4gPiBqdXN0aWZpY2F0aW9uIGZvciB0aGlzIHBoYW5kbGUuIFdoYXQgZXhhY3RseSBpcyB0
aGUgY2xvY2sgdGhhdCB0aGlzCj4gPiA+IGNvbnRyb2xzIGFuZCB3aHkgZG9lcyBpdCBub3QgaGF2
ZSBhIGRlZGljYXRlZCBjbG9jay1jb250cm9sbGVyIGRyaXZlcgo+ID4gPiBhbmQgcmVzZXQtY29u
dHJvbGxlciBkcml2ZXI/Cj4gPiA+IAo+ID4gSW4gdGhlIGN1cnJlbnQgZGVzaWduIGZyYW1ld29y
aywgdGhlIGNsb2NrIGNhbiBiZSBkaXZpZGVkIGludG8gdHdvIHBhcnRzOsKgCj4gPiAxLiBUaGUg
dG9wLWNsb2NrLCB3aGljaCBpcyB1c2VkIHRvIG1hbmFnZSBhbmQgY29udHJvbCB0aGUgY2xvY2tz
IG9mIHZhcmlvdXMgc3Vic3lzdGVtcyAoc3VjaCBhcyBIU1AsIEdQVSwgTlBVLCBldGMuKTvCoAo+
ID4gMi4gVGhlIHN1YnN5c3RlbSBjbG9ja3MgbWFuYWdlZCBpbmRlcGVuZGVudGx5IGJ5IGVhY2gg
c3Vic3lzdGVtLgo+ID4gVGhlIHRvcC1jbG9jayBpcyBhIHN0YW5kYXJkIGNsb2NrIGRlc2lnbihm
ZWF0dXJpbmcgZ2F0ZSwgZGl2aWRlciwgYW5kIG11eCBmdW5jdGlvbnMpIHRoYXQgaGFzIGJlZW4g
cmVnaXN0ZXJlZCBpbiB0aGXCoAo+ID4gY29tbW9uIGNsb2NrIGZyYW1ld29yayx3aXRoIGEgZGVk
aWNhdGVkIGNsb2NrIGNvbnRyb2xsZXIgZHJpdmVyLgo+ID4gCj4gPiBUaGUgc3Vic3lzdGVtIGNs
b2NrcyBtYW5hZ2VkIGJ5IHN1YnN5c3RlbXMgYXJlIGNvbnRyb2xsZWQgYW5kIGNvbmZpZ3VyZWQg
dGhyb3VnaCB0aGUgQ1NSIChDb250cm9sIGFuZCBTdGF0dXMgUmVnaXN0ZXIpwqAKPiA+IG9mIGVh
Y2ggcmVzcGVjdGl2ZSBzdWJzeXN0ZW0uIEZvciBleGFtcGxlLCB0aGUgSFNQIHN1YnN5c3RlbSB1
c2VzIHRoZSBlc3dpbixoc3Atc3AtY3NyLiBBZGRpdGlvbmFsbHksIHRoaXMgQ1NSIGlzCj4gPiDC
oHJlc3BvbnNpYmxlIGZvciBtYW5hZ2luZyBzdGFydHVwIGZ1bmN0aW9ucywgcGVyZm9ybWluZyBp
bmRlcGVuZGVudCByZXNldCBvZiBzcGVjaWZpYyBtb2R1bGVzLCBhbmQgYWRqdXN0aW5nwqAKPiA+
IFBIWSBwYXJhbWV0ZXJzIHRvIGFjaGlldmUgYm9hcmQtbGV2ZWwgdHVuaW5nIChmb3IgVVNCL1NB
VEEgaW50ZXJmYWNlcywgZXRjLikuCj4gCj4gVW5saWtlIHRoZSB1c2Ugb2YgdGhlIEhTUCBpbiB0
aGUgc2RoY2kgZHJpdmVyLCB3aGVyZSBpdCBhcHBlYXJzIHRvIGJlCj4gc2V0dGluZyBiaXRzIHRo
YXQgaW5kaWNhdGUgc3RhYmlsaXR5IChhY2NvcmRpbmcgdG8geW91ciBjb2xsZWFndWUpIHdoYXQK
PiB5b3Ugc2F5IGhlcmUgKGFuZCB3aGF0IGlzIGRvbmUgaW4gdGhlIGRyaXZlciBvbiB0aGUgcmVz
ZXQgc2lkZSBpbgo+IHBhcnRpY3VsYXIpIHNlZW1zIGxpa2Ugc29tZXRoaW5nIHRoYXQgc2hvdWxk
IGJlIGhhbmRsZWQgYnkgYSBkZWRpY2F0ZWQKPiBkcml2ZXIuICJpbmRlcGVuZGVudCByZXNldCBv
ZiBzcGVjaWZpYyBtb2R1bGVzIiBpcyB0aGUgZG9tYWluIG9mCj4gcmVzZXQtY29udHJvbGxlciBk
cml2ZXJzLiBXaGF0IGFyZSB0aGUgb3RoZXIgbW9kdWxlcyBmb3Igd2hpY2ggdGhlIEhTUAo+IGhh
cyByZXNldHM/IERvZXMgaXQgaGF2ZSBjbG9ja3MgZm9yIG90aGVyIG1vZHVsZXMgdG9vPwo+IAo+
ID4gVGhlIHRvcC1jbG9jayBtYW5hZ2VzIHRoZSBnbG9iYWwgY2xvY2tzIG9mIHN1YnN5c3RlbXMu
IFRha2luZyB0aGUgSFNQIHN1YnN5c3RlbSBhcyBhbiBleGFtcGxlLCB0aGUgdG9wLWNsb2NrCj4g
PiDCoGNvbmZpZ3VyZXMgdGhlIGhzcF9hY2xrX2N0cmwgYW5kIGhzcF9jZmdfY3RybCBvZiBIU1Ag
c3Vic3lzdGVtIG9ubHkuCj4gCj4gPiBJbiBjb250cmFzdCwgdGhlIHN1YnN5c3RlbSBjbG9ja3Mg
YXJlIG1hbmFnZWQgdmlhIHRoZWlyIG93biBDU1JzLiBGb3IgaW5zdGFuY2UsIHRoZSBVU0IgcmVm
IGNsb2NrIHVzZWQgaW4gdGhlIFVTQiBtb2R1bGUgb2bCoAo+ID4gdGhlIEhTUCBzdWJzeXN0ZW0g
Y2FuIG9ubHkgYmUgY29uZmlndXJlZCB0aHJvdWdoIHRoZSBoc3AtY3NyLCBhbmQgY2Fubm90IGJl
IHNldCB2aWEgdGhlIHRvcC1jbG9jayBjb250cm9sbGVyIGRyaXZlci4KPiA+IEFzIGZvciB0aGUg
cmVzZXQgZnVuY3Rpb24sIGl0IGlzIG5vdCBpbnRlZ3JhdGVkIGludG8gYSBkZWRpY2F0ZWQgY29u
dHJvbGxlciBkcml2ZXIgZWl0aGVyLCBmb3IgcmVhc29ucyBzaW1pbGFyIHRvIHRob3NlIG9mIHRo
ZcKgCj4gPiBjbG9jayBtYW5hZ2VtZW50IG1lbnRpb25lZCBhYm92ZS4KPiAKPiBUaGF0IGp1c3Qg
c291bmRzIHRvIG1lIGxpa2UgdGhlIGhzcC1jc3IgbmVlZHMgdG8gYmVjb21lIGJvdGggYQo+IHJl
c2V0LWNvbnRyb2xsZXIgYW5kIGEgY2xvY2stY29udHJvbGxlciEgSXQncyBub3QgdW51c3VhbCB0
byBoYXZlIG1vcmUKPiB0aGFuIG9uZSBjbG9jay1jb250cm9sbGVyIGluIGFuIGRldmljZSwgdGhl
IHRvcC1jbG9jayBiZWluZyBhCj4gY2xvY2stY29udHJvbGxlciBkb2VzIG5vdCBtZWFuIHRoYXQg
dGhlIEhTUCBhbHNvIGNhbm5vdCBiZSBvbmUuCj4gCg==
------=_Part_28961_865295059.1758874503643
Content-Type: application/pgp-signature; name=signature.asc
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaUhVRUFCWUtBQjBXSVFSaDI0NkVHcS84
UkxoRGpPMTR0REdIb0lKaTBnVUNhTlJNcVFBS0NSQjR0REdIb0lKaQ0KMHRXakFQOXJuajZMQkJ0
MlJ2a1pacHlXZGpqdHJMNTdQTmxlYktPMkh6UlFpQ2NpTVFFQW9iWldENlFoWTlVcw0KdCtCWEQx
UUFJNzlNcmYyWEEzUVpPRlIyQWpKMENnaz0NCj1jTzUyDQotLS0tLUVORCBQR1AgU0lHTkFUVVJF
LS0tLS0NCg==
------=_Part_28961_865295059.1758874503643--


