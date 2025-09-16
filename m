Return-Path: <linux-kernel+bounces-818544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C82BB5931C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B4A188F159
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B02F8BD0;
	Tue, 16 Sep 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ZapZ3uEp"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B82773E9;
	Tue, 16 Sep 2025 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017685; cv=none; b=jjjNZ+PEKQvxXxyUmI4W2cphuG7nbKIMW9oEaIWgjk1YdjzRdYvB8V3v4vySRnRhPYKdgLb/mqfnD6NeGlsYHryuMev4GFk9JwnX4NsKKo9FqWyOk+b3X2rgvViR5vnCmuKJa1pHUnKsS/SNMY0eN/LdgvqYkbWXLma9voZX898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017685; c=relaxed/simple;
	bh=kU4fC88JBHAp0zYfJSbS98oDp1yi1/hICgQxsaUH6hM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EIlVgnQWgkuH1Kz+yQHlxYXPd2Qpcti/pBrNJrj8XhNq/YEwLrh2qss61+d6yc53G4LaENZ81FmsEdWUfSiNy66fUR/92f2ZwH+talHkjmdjx6L/MahPIEDUVIenNTzN+eVcrG6pOXH5WmGukt9dggbpIvdrikR82vxH5sMU89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=ZapZ3uEp reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9r47YpNtLDGnmu9MOq0uHzZ3Aq3g0W9pPUXAi/LnBFQ=; b=Z
	apZ3uEpnncAPLxsqchcfOGWIxhpZD/lRTziSBpcEoAogYTKT1p4CpRdqmkq50FYO
	9ov7c5xIGkypEoEH4is0KRWQBK9u38fZPIBQFKWwJBobTBbi7nk/OE+XpCsCXiW0
	aR+3m7IYGqaqEm1N+VaqCnRb/vnDdeLSJ+VHY1GQe8=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-132 (Coremail) ; Tue, 16 Sep 2025 18:13:14 +0800
 (CST)
Date: Tue, 16 Sep 2025 18:13:14 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>
Cc: "Quentin Schulz" <quentin.schulz@cherry.de>,
	"Chaoyi Chen" <kernel@airkyi.com>,
	"Heiko Stuebner" <heiko@sntech.de>,
	"Andy Yan" <andy.yan@rock-chips.com>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Dragan Simic" <dsimic@manjaro.org>,
	"FUKAUMI Naoki" <naoki@radxa.com>, "Jonas Karlman" <jonas@kwiboo.se>,
	"Peter Robinson" <pbrobinson@gmail.com>,
	"chaoyi.chen@rock-chips.com" <chaoyi.chen@rock-chips.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>,
	"Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>,
	"Sebastian Reichel" <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] arm64: dts: rockchip: Enable DisplayPort for
 rk3588-evb2
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <0884990e-f349-49d5-804a-932125aca1cf@rock-chips.com>
References: <20250916080802.125-1-kernel@airkyi.com>
 <50379c05-c8b7-4858-98ff-da7ebdc06863@cherry.de>
 <352856bb-76b6-4861-8a3f-80f94f7c7375@rock-chips.com>
 <72ddffd6-bd8f-418e-996d-70267d3ca7e4@cherry.de>
 <0884990e-f349-49d5-804a-932125aca1cf@rock-chips.com>
X-NTES-SC: AL_Qu2eCvyauE0i4iSabekfmUgWjuw/WsG1v/Ul1YBSP556jAPoxxw8QE5yE3nd79OjGy6SgCG5YAlI2Nlmf4dhWoA56gnBH63NZzQMYzV9RE1SfA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5e94042f.9278.1995203a448.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgDXr1Y6OMloJJALAA--.2564W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwDKXmjJMDLeaAADsx
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIZWxsbyBRdWVudGlu77yMCgrlnKggMjAyNS0wOS0xNiAxNzo0ODo0Me+8jCJDaGFveWkgQ2hl
biIgPGNoYW95aS5jaGVuQHJvY2stY2hpcHMuY29tPiDlhpnpgZPvvJoKPk9uIDkvMTYvMjAyNSA1
OjI0IFBNLCBRdWVudGluIFNjaHVseiB3cm90ZToKPgo+PiBPbiA5LzE2LzI1IDExOjE4IEFNLCBD
aGFveWkgQ2hlbiB3cm90ZToKPj4+IEhpIFF1ZW50aW4sCj4+Pgo+Pj4gT24gOS8xNi8yMDI1IDQ6
NDEgUE0sIFF1ZW50aW4gU2NodWx6IHdyb3RlOgo+Pj4+IEhpIENoYW95aSBDaGVuLAo+Pj4+Cj4+
Pj4gT24gOS8xNi8yNSAxMDowOCBBTSwgQ2hhb3lpIENoZW4gd3JvdGU6Cj4+Pj4+IEZyb206IENo
YW95aSBDaGVuIDxjaGFveWkuY2hlbkByb2NrLWNoaXBzLmNvbT4KPj4+Pj4KPj4+Pj4gVGhlIHJr
MzU4OCBldmIyIGJvYXJkIGhhcyBhIGZ1bGwgc2l6ZSBEaXNwbGF5UG9ydCBjb25uZWN0b3IsIGVu
YWJsZQo+Pj4+PiBmb3IgaXQuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENoYW95aSBDaGVu
IDxjaGFveWkuY2hlbkByb2NrLWNoaXBzLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IMKgIC4uLi9ib290
L2R0cy9yb2NrY2hpcC9yazM1ODgtZXZiMi12MTAuZHRzwqDCoMKgwqAgfCAzOSArKysrKysrKysr
KysrKysrKysrCj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCj4+Pj4+
Cj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1l
dmIyLXYxMC5kdHMgYi9hcmNoLyBhcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtZXZiMi12
MTAuZHRzCj4+Pj4+IGluZGV4IDkxZmU4MTBkMzhkOC4uMGU1YWY2MWY2NmZlIDEwMDY0NAo+Pj4+
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1ldmIyLXYxMC5kdHMK
Pj4+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtZXZiMi12MTAu
ZHRzCj4+Pj4+IEBAIC0yNSw2ICsyNSwxOCBAQCBjaG9zZW4gewo+Pj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgc3Rkb3V0LXBhdGggPSAic2VyaWFsMjoxNTAwMDAwbjgiOwo+Pj4+PiDCoMKgwqDCoMKg
IH07Cj4+Pj4+IMKgICvCoMKgwqAgZHAtY29uIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbXBh
dGlibGUgPSAiZHAtY29ubmVjdG9yIjsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGxhYmVsID0gIkRQ
IE9VVCI7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB0eXBlID0gImZ1bGwgc2l6ZSI7Cj4+Pj4KPj4+
PiBUaGlzIGlzbid0IHZhbGlkIGFjY29yZGluZyB0byB0aGUgZHQgYmluZGluZy4gSXQgc2hvdWxk
IGJlICJmdWxsLXNpemUiIGluc3RlYWQuCj4+Pgo+Pj4gV2lsbCBmaXggaW4gdjIuCj4+Pgo+Pj4K
Pj4+Pgo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBwb3J0IHsKPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZHBfY29uX2luOiBlbmRwb2ludCB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmVtb3RlLWVuZHBvaW50ID0gPCZkcDBfb3V0X2Nvbj47Cj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9Owo+Pj4+
PiArwqDCoMKgIH07Cj4+Pj4+ICsKPj4+Pj4gwqDCoMKgwqDCoCBoZG1pLWNvbiB7Cj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImhkbWktY29ubmVjdG9yIjsKPj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHR5cGUgPSAiYSI7Cj4+Pj4+IEBAIC0xMDYsNiArMTE4LDI0IEBAIHZj
YzV2MF91c2JkY2luOiByZWd1bGF0b3ItdmNjNXYwLXVzYmRjaW4gewo+Pj4+PiDCoMKgwqDCoMKg
IH07Cj4+Pj4+IMKgIH07Cj4+Pj4+IMKgICsmZHAwIHsKPj4+Pj4gK8KgwqDCoCBwaW5jdHJsLTAg
PSA8JmRwMG0wX3BpbnM+Owo+Pj4+PiArwqDCoMKgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7
Cj4+Pj4+ICvCoMKgwqAgc3RhdHVzID0gIm9rYXkiOwo+Pj4+PiArfTsKPj4+Pj4gKwo+Pj4+PiAr
JmRwMF9pbiB7Cj4+Pj4+ICvCoMKgwqAgZHAwX2luX3ZwMjogZW5kcG9pbnQgewo+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgcmVtb3RlLWVuZHBvaW50ID0gPCZ2cDJfb3V0X2RwMD47Cj4+Pj4+ICvCoMKg
wqAgfTsKPj4+Pj4gK307Cj4+Pj4+ICsKPj4+Pj4gKyZkcDBfb3V0IHsKPj4+Pj4gK8KgwqDCoCBk
cDBfb3V0X2NvbjogZW5kcG9pbnQgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmVtb3RlLWVuZHBv
aW50ID0gPCZkcF9jb25faW4+Owo+Pj4+PiArwqDCoMKgIH07Cj4+Pj4+ICt9Owo+Pj4+PiArCj4+
Pj4+IMKgICZncHUgewo+Pj4+PiDCoMKgwqDCoMKgIG1hbGktc3VwcGx5ID0gPCZ2ZGRfZ3B1X3Mw
PjsKPj4+Pj4gwqDCoMKgwqDCoCBzcmFtLXN1cHBseSA9IDwmdmRkX2dwdV9tZW1fczA+Owo+Pj4+
PiBAQCAtOTE2LDYgKzk0Niw4IEBAICZ1c2JfaG9zdDFfeGhjaSB7Cj4+Pj4+IMKgIH07Cj4+Pj4+
IMKgIMKgICZ2b3Agewo+Pj4+PiArwqDCoMKgIGFzc2lnbmVkLWNsb2NrcyA9IDwmY3J1IERDTEtf
Vk9QMl9TUkM+Owo+Pj4+PiArwqDCoMKgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNydSBQ
TExfVjBQTEw+Owo+Pj4+Cj4+Pj4gVGhpcyBpcyBzdXJwcmlzaW5nLCB0aGUgb25seSBvdGhlciBi
b2FyZCB3aGljaCBoYXMgdGhlIERQMCBlbmFibGVkICh0aGUgQ29vbFBpIDRCKSBkb2Vzbid0IHNl
dCB0aGVzZSB0d28uCj4+Pj4KPj4+PiBEb2VzIEhETUkgc3RpbGwgd29yayBhcyB3ZWxsIGFzIGl0
IHVzZWQgdG8gd2l0aCB0aGVzZSBuZXcgcHJvcGVydGllcz8gV2h5IGFyZSB0aG9zZSBuZWVkZWQ/
IFNvbWUgY29udGV4dCBpbiB0aGUgY29tbWl0IGxvZyBvciBhcyBhIGNvbW1lbnQgaW4gdGhlIERU
IHdvdWxkIGJlIG1vc3Qgd2VsY29tZSEKPj4+Cj4+PiBZZXMsIEhETUkgYW5kIERQIGNhbiB3b3Jr
IG5vcm1hbGx5IHdoZXRoZXIgdGhlc2UgbmV3wqBwcm9wZXJ0aWVzIHJlbW92ZWQgb3Igbm90Lgo+
Pj4KPj4+IFRoZSBrZXkgcG9pbnQgaXMgdGhhdCB3aGVuIHVzaW5nIFYwUExMLCB3ZSBjYW4gZ2V0
IG1vcmUgdXNhYmxlIHJlc29sdXRpb24gYmVjYXVzZSBEUCByZXF1aXJlcyBhIHByZWNpc2UgY2xv
Y2suIElmIFYwUExMIGlzIG5vdCBleHBsaWNpdGx5IHNwZWNpZmllZCBoZXJlLCB0aGVuIGRjbGtf
dm9wMiAoVlAyKSBtYXkgYmUgZGl2aWRlZCBkb3duIG9uIEdQTEwsIENQTEwsIGV0Yy4gSW4gdGhp
cyBjYXNlLCBvbmx5IGEgZmV3IGZyZXF1ZW5jeSBwb2ludHMgYXJlIGF2YWlsYWJsZS4gSW4gbXkg
Y2FzZSwgd2hlbiBWMFBMTCBpcyBub3QgdXNlZCwgb25seSByZXNvbHV0aW9ucyBzdWNoIGFzIDEw
MjR4NzY4IGFuZCA2NDB4NDgwIGFyZSBhdmFpbGFibGUuCj4KPk9oISBUaGlzIGlzIGJlY2F1c2Ug
R1BMTCB3YXMgbm90IGluaXRpYWxpemVkIHRvIHRoZSBjb3JyZWN0IGZyZXF1ZW5jeSBkdXJpbmcg
dGhlIFUtQm9vdCBzdGFnZS4gSXQgc2hvdWxkIHN1cHBvcnQgdHlwaWNhbCBmcmVxdWVuY2llcyBz
dWNoIGFzIDEwODBQICgxNDguNU0pLCA0SyAoNTk0TSkgLgo+Cj4KPj4+Cj4+PiBGb3IgSERNSSwg
SSB0aGluayBpdCB3aWxsIHVzZSBjbGtfaGRtaXBoeV9waXhlbDAvMSBhcyBjbG9jayBwYXJlbnQg
d2hpY2ggaXMgcHJvdmlkZWQgYnkgdGhlIEhETUkgUEhZIHdoZW4gaXQgd29yayBvbiBUTURTIG1v
ZGUgc28gdGhhdCB3ZSBkb24ndCBuZWVkIHRvIHNldCBpdCAuCj4+Pgo+Pgo+PiBDb25zaWRlcmlu
ZyB0aGUgY2xvY2tzIGFyZSBhbGwgaW50ZXJuYWwgdG8gdGhlIFNvQywgc2hvdWxkbid0IGFsbCB5
b3UgaGF2ZSBleHBsYWluZWQgYmUgYXBwbGljYWJsZSB0byB0aGUgQ29vbFBpIDRCIHRvbyAoYW5k
IG90aGVyIGJvYXJkcyB3aXRoIERQKT8gSSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIGlmIHdlIHNo
b3VsZCBhZGQgc29tZXRoaW5nIHNpbWlsYXIgdG8gQ29vbFBpIDRCIERUUyBhcyB3ZWxsPwo+Cj5Z
ZXMsIEkgdGhpbmsgdGhpcyBtb2RpZmljYXRpb24gaXMgbmVjZXNzYXJ5IGJlY2F1c2Ugc29tZSBy
ZXNvbHV0aW9ucyB1c2Ugc3BlY2lhbCBmcmVxdWVuY2llcy4KPgo+Cj4+Cj4+IEBBbmR5LCB5b3Un
cmUgdGhlIG9uZSB3aG8gYWRkZWQgc3VwcG9ydCBmb3IgRFAgdG8gQ29vbFBpIDRCLCB3aXRob3V0
IHRoZXNlIHByb3BlcnRpZXMsIGlzIHRoZXJlIHNvbWV0aGluZyB3ZSBuZWVkIHRvIGRvIHRoZXJl
IGFzIHdlbGw/CgpPbiB0aGUgQ29vbFBJIDRCLCBzaW5jZSBubyBkZWRpY2F0ZWQgUExMIHdhcyBz
cGVjaWZpZWQsIHRoZSBHUExMIHdvdWxkIGJlIGF1dG9tYXRpY2FsbHkgYXNzaWduZWQgYXMgdGhl
IFBMTCBzb3VyY2UgZm9yIGRjbGtfdm9wMi4gCkFzIHRoZSBmcmVxdWVuY3kgb2YgR1BMTCBpcyAx
MTg4IE1Ieiwgd2UgY2FuIG9ubHkgZ2V0IHR5cGljYWwgY2xvY2sgZnJlcXVlbmNpZXMgc3VjaCBh
cyA3NC4yNSwgMTQ4LjUsIDI5NywgNTk0TUh6LCB3aGljaCBjb3JyZXNwb25kCnRvIHR5cGljYWwg
cmVzb2x1dGlvbnMgb2YgNzIwUCwgMTA4MFAsIDRLMzAvNjAuIElmIHRoZXJlIGFyZSBzb21lIG1v
cmUgc3BlY2lhbCByZXNvbHV0aW9ucywgc3VjaCBhcyBhIDM4NDB4MjE2MCA1OS45NEh6IERQIHJl
c29sdXRpb24KdGhhdCByZXF1aXJlcyBhIGRjbGsgY2xvY2sgb2YgNTkzLjQwNyBNSHosIHRoZW4g
aXQgY2Fubm90IGJlIHN1cHBvcnRlZC4KIEkgd2lsbCBjb25kdWN0IG1vcmUgdGVzdHMgbGF0ZXIg
YW5kIHRoZW4gc3VibWl0IGEgcGF0Y2ggdG8gc3BlY2lmeSBWMFBMTCBmb3IgQ29vbFBpIDRCJ3Mg
VlAyLiAKCkFuZCBDaGFveWkncyAgcGF0Y2ggaXMgY29ycmVjdC4KCgo+Pgo+PiBUaGFua3MhCj4+
IFF1ZW50aW4KPj4KPj4K

