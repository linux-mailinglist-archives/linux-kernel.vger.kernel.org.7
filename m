Return-Path: <linux-kernel+bounces-649293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D707AB82A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 11:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EB74C73B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D731E9B28;
	Thu, 15 May 2025 09:30:46 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029728F95B;
	Thu, 15 May 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301446; cv=none; b=dllvTGE7dmw/CjDBi1KFXvBF61na3BDg2kfJ8n+mytyvs+5fKZ+VWLkYudbELQ9vyzOGC5JUgkWHloJjKs6LF5FetKjU+vwZWfpyr17AYexnrzBSUoV638PGxNPNy8j05i2i8PZslpY13NczulMDcqSWDALQlftGZAS555Mb40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301446; c=relaxed/simple;
	bh=iKj4q91gS84iRtXfCHT5Q0YUZfIUid7N3CpwCLzvvAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=uyN9246jQ801Diebq6Wou0FjFfxeKhI1+AXfJzEVHdUhJOG4p1EiX+Bj+/mFzU6UbR4Qie7FViwvl9BVBrqJ0MWhbvpnb0EbKIeeW35liws/kUaqi0Dm/LS/TASxtOyKv8jIcg6w/mDCDn36FmJvKu5Q4L2fY/SrJThyCIqdtXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 15 May 2025 17:30:28 +0800 (GMT+08:00)
Date: Thu, 15 May 2025 17:30:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6JGj57uq5rSL?= <dongxuyang@eswincomputing.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linmin@eswincomputing.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, ningyu@eswincomputing.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	huangyifeng@eswincomputing.com
Subject: Re: Re: [PATCH 1/2] dt-bindings: clock: eswin: Documentation for
 eic7700 SoC
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <174718561404.161129.10398945158829194944.robh@kernel.org>
References: <20250514002233.187-1-dongxuyang@eswincomputing.com>
 <20250514002516.290-1-dongxuyang@eswincomputing.com>
 <174718561404.161129.10398945158829194944.robh@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2fce3667.aaf.196d347ecb7.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAXt5U0tCVotEN8AA--.13446W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQEDAmgkxWUdX
	wAAsv
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGksIEkgdXNlICJwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlIiB0byB1cGdyYWRlIHRo
ZSBkdHNjaGVtYS4gVGhlIGR0c2NoZW1hIGlzIDIwMjUuMDIgYW5kIHlhbWxsaW50IGlzIDEuMzcu
MS4gVXNlICJtYWtlIGR0X2JpbmRpbmdfY2hlY2sgRFRfU0NIRU1BX0ZJTEVTPURvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9lc3dpbixlaWM3NzAwLWNsb2NrLnlhbWwiIHRv
IGNoZWNrLCBidXQgdGhlcmUgaXMgbm90IGZvdW5kIHdhcm5pbmdzL2Vycm9ycy4gVGhlIGVudmly
b25tZW50IGlzIFVidW50dSAxOC4wNCwgYW5kIHRoZSBMaW51eCBrZXJuZWwgdmVyc2lvbiBpcyB2
Ni4xNS1yYzYuIFRoZXJlZm9yZSwgSSB3b3VsZCBsaWtlIHRvIG9idGFpbiB0aGUgdmVyc2lvbnMg
b2YgZHRzY2hlbWEgYW5kIHlhbWxsaW50IHRoYXQgZGV0ZWN0IHdhcm5pbmdzL2Vycm9ycy4KClRo
YW5rIHlvdSBmb3IgdGVsbGluZyBtZSB0aGUgbWVzc2FnZS4KCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2
LS0tLS0KPiDlj5Hku7bkuro6ICJSb2IgSGVycmluZyAoQXJtKSIgPHJvYmhAa2VybmVsLm9yZz4K
PiDlj5HpgIHml7bpl7Q6MjAyNS0wNS0xNCAwOToyMDoxNCAo5pif5pyf5LiJKQo+IOaUtuS7tuS6
ujogZG9uZ3h1eWFuZ0Blc3dpbmNvbXB1dGluZy5jb20KPiDmioTpgIE6IGxpbm1pbkBlc3dpbmNv
bXB1dGluZy5jb20sIGtyemsrZHRAa2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZywgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZywgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20s
IHNib3lkQGtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGNvbm9yK2R0QGtl
cm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBodWFuZ3lpZmVuZ0Blc3dpbmNv
bXB1dGluZy5jb20KPiDkuLvpopg6IFJlOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogY2xvY2s6
IGVzd2luOiBEb2N1bWVudGF0aW9uIGZvciBlaWM3NzAwIFNvQwo+IAo+IAo+IE9uIFdlZCwgMTQg
TWF5IDIwMjUgMDg6MjU6MTYgKzA4MDAsIGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tIHdy
b3RlOgo+ID4gRnJvbTogWHV5YW5nIERvbmcgPGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29t
Pgo+ID4gCj4gPiBBZGQgZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIGFuZCBoZWFk
ZXIgZmlsZSBmb3IKPiA+IHRoZSBFU1dJTiBFSUM3NzAwIGNsb2NrIGNvbnRyb2xsZXIgbW9kdWxl
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaWZlbmcgSHVhbmcgPGh1YW5neWlmZW5nQGVzd2lu
Y29tcHV0aW5nLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1eWFuZyBEb25nIDxkb25neHV5YW5n
QGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IC0tLQo+ID4gIC4uLi9iaW5kaW5ncy9jbG9jay9lc3dp
bixlaWM3NzAwLWNsb2NrLnlhbWwgICB8ICA0MyArKwo+ID4gIC4uLi9kdC1iaW5kaW5ncy9jbG9j
ay9lc3dpbixlaWM3NzAwLWNsb2NrLmggICB8IDU4OCArKysrKysrKysrKysrKysrKysKPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDY0MSBpbnNlcnRpb25zKCspCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9lc3dpbixlaWM3NzAwLWNs
b2NrLnlhbWwKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9j
ay9lc3dpbixlaWM3NzAwLWNsb2NrLmgKPiA+IAo+IAo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVu
bmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOgo+IAo+IHlhbWxsaW50
IHdhcm5pbmdzL2Vycm9yczoKPiAKPiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOgo+IC9i
dWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kvbGludXgvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Nsb2NrL2Vzd2luLGVpYzc3MDAtY2xvY2suZXhhbXBsZS5kdGI6IHN5cy1j
cmdANTE4MjgwMDAgKHN5c2Nvbik6IGNvbXBhdGlibGU6IFsnc3lzY29uJywgJ3NpbXBsZS1tZmQn
XSBpcyB0b28gc2hvcnQKPiAJZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9tZmQvc3lzY29uLWNvbW1vbi55YW1sIwo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1y
ZXZpZXctY2kvbGludXgvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Vz
d2luLGVpYzc3MDAtY2xvY2suZXhhbXBsZS5kdGI6IHN5cy1jcmdANTE4MjgwMDAgKHN5c2Nvbik6
IHJlZzogW1swLCAxMzY3NTA2OTQ0XSwgWzAsIDUyNDI4OF1dIGlzIHRvbyBsb25nCj4gCWZyb20g
c2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWZkL3N5c2Nvbi1jb21t
b24ueWFtbCMKPiAKPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3MpOgo+
IAo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvZGV2aWNldHJlZS1i
aW5kaW5ncy9wYXRjaC8yMDI1MDUxNDAwMjUxNi4yOTAtMS1kb25neHV5YW5nQGVzd2luY29tcHV0
aW5nLmNvbQo+IAo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUgbGF0
ZXN0IHJjMS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5jeQo+IHNob3VsZCBiZSBub3RlZCBpbiAqdGhp
cyogcGF0Y2guCj4gCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2sn
IGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFt
bGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvCj4gZGF0ZToKPiAKPiBw
aXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlCj4gCj4gUGxlYXNlIGNoZWNrIGFuZCByZS1z
dWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUgYWJvdmUgY29tbWFuZCB5b3Vyc2VsZi4gTm90ZQo+IHRo
YXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVl
ZCB1cCBjaGVja2luZwo+IHlvdXIgc2NoZW1hLiBIb3dldmVyLCBpdCBtdXN0IGJlIHVuc2V0IHRv
IHRlc3QgYWxsIGV4YW1wbGVzIHdpdGggeW91ciBzY2hlbWEuCg==

