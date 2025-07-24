Return-Path: <linux-kernel+bounces-743899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0EB1051B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8156D1CE2EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D251275AFA;
	Thu, 24 Jul 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="AgP4/RVw"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E11E272815
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347448; cv=none; b=DqqflxAqBFMU/sPW3IINFny+tnd4KLUCLsgMI9mBVQQhRNoc57HsbnLvkxvo51SHlW883XWdVMGsCCwf1VR8aY19ZNrqi6UzXYdfjHigTbfFhexBsuVdaDK6nk8PJLUn6T2YEo9aspLp7HxnUoO/c7uWOTXCBRzS+3NUpedWA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347448; c=relaxed/simple;
	bh=6u3CSxrnsWVQvMzUV9TdCx9nkULsCxHzDLKbe4h1+1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=p8cZy+m5MVvAKV2LrFaCOSeuNs4ldCu213/S5maF6l2cL1UMb7HCJrylJfmG61Yw7RPtfS4RdUcMnZee20ry3PZqVeRvvo/1FFamIqFCaby+u5EATqf6kGRvZmVEoIP3pYeZ3UydylN0elx89TtwldHk9MpTlVXkP3f2u2IPEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=AgP4/RVw reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=nCG64cX9962fVXtWrqseUeJN5t771PUmctZXWGwW0fQ=; b=A
	gP4/RVw0Wodqj+KinddiH+K/vwgs5YF1oYfcj/gw+lNvxAwT7+mz32P64fleF8nP
	EbWU1zyQvI4Crb47woiuVPgtThVFtOe2KuW7W5kkU+kB6jtD7SLtP0VfbBdaijMV
	L681GCzIHH8J7Z+koE2ldizGPURzVbNCLC0mm458KA=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Thu, 24 Jul 2025 16:56:01 +0800
 (CST)
Date: Thu, 24 Jul 2025 16:56:01 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: "Sandy Huang" <hjc@rock-chips.com>,
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	"Andy Yan" <andy.yan@rock-chips.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Algea Cao" <algea.cao@rock-chips.com>,
	"David Airlie" <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Andrzej Hajda" <andrzej.hajda@intel.com>,
	"Neil Armstrong" <neil.armstrong@linaro.org>,
	"Robert Foss" <rfoss@kernel.org>,
	"Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
	"Jonas Karlman" <jonas@kwiboo.se>,
	"Jernej Skrabec" <jernej.skrabec@gmail.com>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH 1/5] drm/rockchip: vop2: Add high color depth support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <c5624dad-93cb-4cc3-88ad-808dcc43274d@collabora.com>
References: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
 <20250721-rk3588-10bpc-v1-1-e95a4abcf482@collabora.com>
 <3ceb2c70.2145.1982ff28b9c.Coremail.andyshrk@163.com>
 <c5624dad-93cb-4cc3-88ad-808dcc43274d@collabora.com>
X-NTES-SC: AL_Qu2eAf+fuEst5yKdYekfmUkTh+o2Xca5uf0j3YBWOZh+jCDp+QI/WUd7PHfV+c6FAj2WqyCvXhFv2v9ITLdpdJIwP0TpJ4VuXt6YuO4Pafn32g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <12451b41.7627.1983ba589ec.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgD351Ah9YFoRs8FAA--.51988W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwKUXmiB844lyQAEsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKSGVsbG8gQ3Jpc3RpYW7vvIwK5ZyoIDIwMjUtMDctMjIgMTQ6MTY6MjbvvIwiQ3Jpc3RpYW4g
Q2lvY2FsdGVhIiA8Y3Jpc3RpYW4uY2lvY2FsdGVhQGNvbGxhYm9yYS5jb20+IOWGmemBk++8mgo+
SGkgQW5keSwKPgo+T24gNy8yMi8yNSA1OjI0IEFNLCBBbmR5IFlhbiB3cm90ZToKPj4gCj4+IEhl
bGxvIENyaXN0aWFu77yMCj4+IAo+PiBBdCAyMDI1LTA3LTIyIDAxOjM5OjA0LCAiQ3Jpc3RpYW4g
Q2lvY2FsdGVhIiA8Y3Jpc3RpYW4uY2lvY2FsdGVhQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+Pj4g
VGFrZSB0aGUgYml0cyBwZXIgY29sb3IgY2hhbm5lbCBpbnRvIGNvbnNpZGVyYXRpb24gd2hlbiBj
b21wdXRpbmcgRENMSwo+Pj4gcmF0ZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDcmlzdGlhbiBD
aW9jYWx0ZWEgPGNyaXN0aWFuLmNpb2NhbHRlYUBjb2xsYWJvcmEuY29tPgo+Pj4gLS0tCj4+PiBk
cml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYyB8IDMgKysrCj4+PiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5jIGIvZHJpdmVycy9ncHUvZHJt
L3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmMKPj4+IGluZGV4IDE4NmY2NDUyYTdkMzU5ZjA3
OTY2MmJjNTgwODUwOTI5NjMyZWE4ZmUuLmE3MTRiY2JiMDJkZTE2MjY3ZTdmZWJiYWViMWViMjcw
YzcwYWFlZjIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2No
aXBfZHJtX3ZvcDIuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlw
X2RybV92b3AyLmMKPj4+IEBAIC0xNzMxLDYgKzE3MzEsOSBAQCBzdGF0aWMgdm9pZCB2b3AyX2Ny
dGNfYXRvbWljX2VuYWJsZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsCj4+PiAJCWNsb2NrICo9IDI7
Cj4+PiAJfQo+Pj4KPj4+ICsJaWYgKHZjc3RhdGUtPm91dHB1dF9icGMgPiA4KQo+Pj4gKwkJY2xv
Y2sgPSBESVZfUk9VTkRfQ0xPU0VTVChjbG9jayAqIHZjc3RhdGUtPm91dHB1dF9icGMsIDgpOwo+
PiAKPj4gCj4+IFRoaXMgc2VlbXMgbm90IHJpZ2h0LCAgcmVnYXJkbGVzcyBvZiB0aGUgdmFsdWUg
b2YgYnBjLCB0aGUgZGNsayBvZiBWT1AgbXVzdCBiZQo+PiBjb25zaXN0ZW50IHdpdGggbW9kZS0+
Y3J0Y19jbG9jay4KPj4gSWYgdGhlIGRjbGsgb2YgVk9QIGlzIGluY3JlYXNlZCBpbiBhY2NvcmRh
bmNlIHdpdGggdGhlIEJQQyByYXRpbyBoZXJlLCB0aGVuIHRoZSByZWZyZXNoIHJhdGUgb2YgVk9Q
IHdpbGwgYWxzbyBpbmNyZWFzZSBwcm9wb3J0aW9uYWxseS4KPj4gVGhpcyB3b3VsZCBiZSBpbmNv
bnNpc3RlbnQgd2l0aCB0aGUgdGltaW5nIGRlc2NyaWJlZCBpbiB0aGUgbW9kZS4KPj4gRm9yIGEg
aGlnaHQgY29sb3IgZGVwdGgsICB0aGUgZnJlcXVlbmN5IG5lZWRzIHRvIGJlIGluY3JlYXNlZCBm
b3IgdGhlIEhETUkgUEhZJ3MgY2xvY2suCj4KPlRoZSBIRE1JIFBIWSdzIGNsb2NrIGlzIGFjdHVh
bGx5IGNvbXB1dGVkIGF0IEhETUkgY29ubmVjdG9yIGZyYW1ld29yayBsZXZlbAo+WzFdLCB0YWtp
bmcgaW50byBhY2NvdW50IHRoZSBjdXJyZW50IGJwYyB2YWx1ZSwgd2hpY2ggaXMgZGV0ZXJtaW5l
ZCBhcyBwYXJ0Cj5vZiBoZG1pX2NvbXB1dGVfY29uZmlnKCkgWzJdLgo+Cj5UaGF0IG1lYW5zIGNv
bm5fc3RhdGUtPmhkbWkudG1kc19jaGFyX3JhdGUgaW4KPmR3X2hkbWlfcXBfcm9ja2NoaXBfZW5j
b2Rlcl9hdG9taWNfY2hlY2soKSBkb2VzIGFscmVhZHkgaW5jbHVkZSB0aGUgYnBjCj5yZWxhdGVk
IGFkanVzdG1lbnQsIGFuZCB3ZSBwYXNzIHRoYXQgZGlyZWN0bHkgdG8gdGhlIFBIWSB2aWEKPnBo
eV9jb25maWd1cmUoKS4gIE5vdGUgdGhlcmUncyBzdGlsbCB0aGUgbmVlZCB0byBoYW5kbGUgYnBj
IHNlcGFyYXRlbHkgdmlhCj5waHlfY29uZmlndXJlX29wdHMgaW4gb3JkZXIgdG8gc2V0dXAgQ01O
X1JFRygwMDg2KSBbM10uCj4KPlNpbmNlIFZPUDIgc3dpdGNoZXMgdG8gUEhZIFBMTCBhcyBEQ0xL
IHNvdXJjZSBmb3IgbW9kZXMgdXAgdG8gNEtANjBIeiwgaXQKPm5lZWRzIHRvIHRha2UgY29sb3Ig
ZGVwdGggaW50byBhY2NvdW50LCB0byBrZWVwIHRoZW0gaW4gc3luYy4gIEFzIGEgbWF0dGVyCj5v
ZiBmYWN0LCB0aGUgY2xvY2sgYWRqdXN0bWVudCBpbiBWT1AyIGlzIG1haW5seSBuZWNlc3Nhcnkg
Zm9yIGxlZ2FjeQoKClRoZXJlIG1pZ2h0IGJlIGEgbWlzdW5kZXJzdGFuZGluZyBoZXJlLiBUaGUg
dmFsdWVzIG9mIGhkbWkudG1kc19jaGFyX3JhdGUgYW5kIHZvcCBkY2xrIGFyZSBub3QgYWx3YXlz
IGVxdWFsIGluIGFsbCBjYXNlcy4KRm9yIHZvcCBkY2xrIGFsd2F5cyBtYXRjaCBtb2RlLT5jbG9j
aywgIGhkbWkudG1kc19jaGFyX3JhdGUgd2lsbCBhZGp1c3Qgd2l0aCBicGMuCkZvciBleGFtcGxl
LCAgZm9yIGEgNEtQMzAgWVVWNDQ0IDggYml0LCAgIHZvcC0+ZGNsayA9IGhkbWkudG1kc19jaGFy
X3JhdGUgPSAyOTdNSFosCmZvciA0S1AzMCBZVVY0NDQgMTAgYml0LCAgaGRtaS50bWRzX2NoYXJf
cmF0ZSA9IDEuMjUgKiB2b3AtPmRjbGsuCgpJbiBmYWN0LCBmb3IgdGhlIEhETUkgUEhZLCB0aGVy
ZSBhcmUgdHdvIGNsb2Nrcy4gT25lIGlzIGEgY2xvY2sgd2l0aCB0aGUgc2FtZSBmcmVxdWVuY3kg
YXMgdGhlIEhETUkgUExMLCBuYW1lbHkudG1kc19jaGFyX3JhdGUsCiBhbmQgdGhlIG90aGVyIGlz
IGEgY2xvY2sgb2J0YWluZWQgYnkgZnVydGhlciBmcmVxdWVuY3kgZGl2aXNpb24gb2YgdGhlIEhE
TUkgUExMLCB3aGljaCBjYW4gYmUgc3VwcGxpZWQgdG8gdGhlIHZvcCBkY2xrLgoKICAgICAgICAg
ICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tID50bWRzX2NoYXJfcmF0ZSAKICAg
ICAgICAgICAgICAgICAgICAgIHwKUEhZIFBMTC0tLS0tLXwKCiAgICAgICAgICAgICAgICAgICAg
ICB8CiAgICAgICAgICAgICAgICAgICAgICAtLS0tLS1ESVYoUkVHMDA4NlszLTFdKS0tPnZvcCBk
Y2xrLgoKU28gaW4gdGhpcyBjYXNlLCBteSBzdWdnZXN0aW9uIGlzIHN0aWxsIHRvIGZvbGxvdyB0
aGUgaW1wbGVtZW50YXRpb24gb2Ygb3VyIEJTUCBrZXJuZWw6Ck9uIHRoZSBjcnRjIHNpZGUsIGl0
IHNob3VkIHNldCBkY2xrIGFzIHRoZSBtb2RlLT5jbG9jay4KQXQgdGhlIFBIWSBzaWRlKHJrX2hk
cHR4X3BoeV9jbGtfc2V0X3JhdGUpIHdoZW4gc2V0IHRoZSB2b3AgZGNsaywgaXQgc2hvdWxkIGFk
anVzdCB0aGUgUExMIGNsb2NrIGFjY29yZGluZyB0byB0aGUgYnBjOgppZiAoYnBjID4gOCkKICAg
ICAgICAgICAgICAgIGJpdF9yYXRlID0gY2xvY2sgKiAxMCAvIDg7CgoKCj5yZWFzb25zLCBzaW5j
ZSBIRFBUWCBQSFkgYWxsb3dlZCBjaGFuZ2luZyBUTURTIGNoYXIgcmF0ZSB2aWEgdGhlIENvbW1v
bgo+Q2xvY2sgRnJhbWV3b3JrIEFQSS4gIFdlIGxhbmRlZCBhIHByb3BlciBzb2x1dGlvbiBmb3Ig
dGhhdCB2aWEgdGhlIEhETUkgUEhZCj5BUEksIGhlbmNlIHRoZSBwbGFuIHdvdWxkIGJlIHRvIG1h
a2UgQ0NGIEFQSSByZWFkb25seSBhZnRlciB0aGUgc3dpdGNoIHRvCj5QSFkgQVBJIGlzIGNvbXBs
ZXRlZCwgd2hpY2ggbWVhbnMgVk9QMiBzaG91bGRuJ3QgZGVhbCBhbnltb3JlIHdpdGggY2xvY2sK
PmNhbGN1bGF0aW9ucyB3aGVuIHVzaW5nIHRoZSBQSFkgUExMIGFzIERDTEsgc291cmNlLgo+Cj5S
ZWdhcmRsZXNzLCBJIHNob3VsZCBwcm9iYWJseSBtb3ZlIHRoaXMgY2xvY2sgYWRqdXN0bWVudCB0
byB0aGUgY29uZGl0aW9uYWwKPmJsb2NrIGhhbmRsaW5nIERDTEsgc291cmNlIHN3aXRjaC4KPgo+
WzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvZ3B1L2RybS9kaXNwbGF5L2RybV9oZG1pX3N0YXRl
X2hlbHBlci5jP2g9djYuMTYtcmM3I241MjUKPlsyXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2dw
dS9kcm0vZGlzcGxheS9kcm1faGRtaV9zdGF0ZV9oZWxwZXIuYz9oPXY2LjE2LXJjNyNuNjA4Cj5b
M10gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFs
ZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9waHkvcm9ja2NoaXAvcGh5LXJvY2tjaGlwLXNhbXN1
bmctaGRwdHguYz9oPXY2LjE2LXJjNyNuMTAzNAo=

