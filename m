Return-Path: <linux-kernel+bounces-791198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7AB3B34C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1EC1C82755
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708923BD1B;
	Fri, 29 Aug 2025 06:22:41 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086C239E8B;
	Fri, 29 Aug 2025 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448560; cv=none; b=u0dZdMhVSYK+60loNLKo2u/nrxE4Xl0wn7tiREnIpxtlBs9rirHJbZ7fAJsCrUUgfAWATDyBTQ6hOOU2K/kvvX8pSrd5UCYUkkncJwYsnvLRPwWQBoh/O5zi/c95lqYWYMRrZEE9xPx6Qxozv9zJ8mJm477Gr3WPfUbDN5lCTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448560; c=relaxed/simple;
	bh=lWKeDfUs6UcJqhbuIh8nb+LFfX5MhFTkvtJkcRl9h9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Gwm71nGIOO1ErURK1pyJQlFe8Tn5va6soY1HKxUNSgw63L5O9p9w42GeAfqdH1QSGv2uTbQVeXB9i4c+19crDtvY3X8brE6/kMZDHKz2zxElDz1S6hLvxQWo93ojs4wZSCwN1diy2nhwDn5mt4rK9I2xIcBOyRnx7+jBFN4bwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from luyulin$eswincomputing.com ( [10.12.96.77] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 29 Aug 2025 14:22:11 +0800 (GMT+08:00)
Date: Fri, 29 Aug 2025 14:22:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: luyulin@eswincomputing.com
To: "Niklas Cassel" <cassel@kernel.org>
Cc: "Rob Herring" <robh@kernel.org>, dlemoal@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: Re: Re: [PATCH v2 1/3] dt-bindings: ata: eswin: Document for
 EIC7700 SoC ahci
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aLBUC116MdJqDGIJ@flawful.org>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
 <20250819135413.386-1-luyulin@eswincomputing.com>
 <CAL_JsqKFotNLZZXwiy7S6K8qXLdGRAnsa-1zvZRDQBE39Gf5kg@mail.gmail.com>
 <692e11ca.843.198f0337528.Coremail.luyulin@eswincomputing.com>
 <aLBUC116MdJqDGIJ@flawful.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4ab70c6a.8be.198f47da494.Coremail.luyulin@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpUTR7Foff_EAA--.23769W
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/1tbiAgEJA2iwhNAS7QAA
	s6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gT24gVGh1LCBBdWcgMjgsIDIwMjUgYXQgMDY6MjI6NDBQTSArMDgwMCwgbHV5dWxpbkBlc3dp
bmNvbXB1dGluZy5jb20gd3JvdGU6Cj4gPiAKPiA+IERvIHlvdSBtZWFuIHRoYXQgcG9ydHMtaW1w
bGVtZW50ZWQgc2hvdWxkIGJlIHJlbW92ZWQgZnJvbSB0aGUgZHRzLAo+ID4gYW5kIHRoZSBjb3Jy
ZXNwb25kaW5nIHJlZ2lzdGVyIHNob3VsZCBiZSBjb25maWd1cmVkIGJ5IHRoZSBmaXJtd2FyZQo+
ID4gKHdoaWNoIGlzIFUtQm9vdCBvbiB0aGUgSGlGaXZlIFByZW1pZXIgUDU1MCBib2FyZCk/IElz
IHRoaXMgdW5kZXJzdGFuZGluZyBjb3JyZWN0Pwo+ID4gSWYgc28sIHdoZW4gdGhlIGRyaXZlciBp
cyByZW1vdmVkLCBhIHJlc2V0IHdpbGwgYmUgdHJpZ2dlcmVkLAo+ID4gY2F1c2luZyB0aGUgY29u
ZmlndXJhdGlvbiBvZiB0aGlzIHJlZ2lzdGVyIHRvIGJlIGxvc3QsCj4gPiB3aGljaCB3aWxsIHJl
c3VsdCBpbiBhbiBlcnJvciB3aGVuIGluc21vZCB0aGUgZHJpdmVyIGFnYWluLgo+IAo+IE15IDUw
IGNlbnRzLAo+IAo+IGlmIHRoZSBwb3J0cyBpbXBsZW1lbnRlZCByZWdpc3RlciBnZXRzIHJlc2V0
IGZyb20gdGhlIHJlc2V0X2NvbnRyb2xfcmVzZXQoKQo+IGluIGFoY2lfcGxhdGZvcm1fYXNzZXJ0
X3JzdHMoKSwgdGhlbiBpdCBzZWVtcyBsaWtlIGhhdmluZyBwb3J0cy1pbXBsZW1lbnRlZAo+IGlu
IGRldmljZSB0cmVlIGlzIGFjY2VwdGFibGUuCj4gCgpJbiBvdXIgZGVzaWduLCB0aGUgcG9ydHMg
aW1wbGVtZW50ZWQgcmVnaXN0ZXIgZ2V0cyByZXNldCBmcm9tIHRoZSBhaGNpX3BsYXRmb3JtX2Fz
c2VydF9yc3RzKCkuCgo+IFRoZXJlIGFyZSBhIGJ1bmNoIG9mIGRldmljZSB0cmVlcyB0aGF0IGhh
dmUgdGhpcyBhbHJlYWR5Ogo+IGFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20vcWNvbS1hcHE4MDY0LmR0
c2k6ICAgICAgICAgICAgICAgICAgICAgICBwb3J0cy1pbXBsZW1lbnRlZCA9IDwweDE+Owo+IGFy
Y2gvYXJtL2Jvb3QvZHRzL3Fjb20vcWNvbS1pcHE4MDY0LXYxLjAuZHRzaTogICAgICAgICAgICAg
ICAgICBwb3J0cy1pbXBsZW1lbnRlZCA9IDwweDE+Owo+IGFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20v
cWNvbS1pcHE4MDY0LXYyLjAuZHRzaTogIHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4gYXJj
aC9hcm0vYm9vdC9kdHMvc2Ftc3VuZy9leHlub3M1MjUwLmR0c2k6ICAgICAgICAgICAgICAgICAg
ICAgIHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4gYXJjaC9hcm0vYm9vdC9kdHMvc29jaW9u
ZXh0L3VuaXBoaWVyLXBybzQuZHRzaTogICAgICAgICAgICAgICAgIHBvcnRzLWltcGxlbWVudGVk
ID0gPDE+Owo+IGFyY2gvYXJtL2Jvb3QvZHRzL3NvY2lvbmV4dC91bmlwaGllci1wcm80LmR0c2k6
ICAgICAgICAgICAgICAgICBwb3J0cy1pbXBsZW1lbnRlZCA9IDwxPjsKPiBhcmNoL2FybS9ib290
L2R0cy9zb2Npb25leHQvdW5pcGhpZXItcHhzMi5kdHNpOiAgICAgICAgICAgICAgICAgcG9ydHMt
aW1wbGVtZW50ZWQgPSA8MT47Cj4gYXJjaC9hcm0vYm9vdC9kdHMvc3Qvc3RpaDQwNy1mYW1pbHku
ZHRzaTogICAgICAgICAgICAgICAgICAgICAgIHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4g
YXJjaC9hcm0vYm9vdC9kdHMvc3Qvc3RpaDQwNy1mYW1pbHkuZHRzaTogICAgICAgICAgICAgICAg
ICAgICAgIHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4gYXJjaC9hcm0vYm9vdC9kdHMvdGkv
b21hcC9kcmE3LWw0LmR0c2k6ICAgICAgICAgICAgICAgICAgICAgICAgIHBvcnRzLWltcGxlbWVu
dGVkID0gPDB4MT47Cj4gYXJjaC9hcm0vYm9vdC9kdHMvdGkvb21hcC9vbWFwNS1sNC5kdHNpOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9ydHMtaW1wbGVtZW50ZWQgPSA8MHgxPjsK
PiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5kdHNpOiAgICAgICAgICAgICAg
IHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4gYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hp
cC9yazM1NjguZHRzaTogICAgICAgICAgICAgICBwb3J0cy1pbXBsZW1lbnRlZCA9IDwweDE+Owo+
IGFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTZ4LWJhc2UuZHRzaTogICAgICAgICAg
cG9ydHMtaW1wbGVtZW50ZWQgPSA8MHgxPjsKPiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlw
L3JrMzU2eC1iYXNlLmR0c2k6ICAgICAgICAgIHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4g
YXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1NzYuZHRzaTogICAgICAgICAgICAgICAg
ICAgICAgIHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4gYXJjaC9hcm02NC9ib290L2R0cy9y
b2NrY2hpcC9yazM1NzYuZHRzaTogICAgICAgICAgICAgICAgICAgICAgIHBvcnRzLWltcGxlbWVu
dGVkID0gPDB4MT47Cj4gYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtYmFzZS5k
dHNpOiAgICAgICAgICBwb3J0cy1pbXBsZW1lbnRlZCA9IDwweDE+Owo+IGFyY2gvYXJtNjQvYm9v
dC9kdHMvcm9ja2NoaXAvcmszNTg4LWJhc2UuZHRzaTogICAgICAgICAgcG9ydHMtaW1wbGVtZW50
ZWQgPSA8MHgxPjsKPiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1leHRyYS5k
dHNpOiAgICAgICAgIHBvcnRzLWltcGxlbWVudGVkID0gPDB4MT47Cj4gYXJjaC9hcm02NC9ib290
L2R0cy9zb2Npb25leHQvdW5pcGhpZXItcHhzMy5kdHNpOiAgICAgICAgICAgICAgICAgICAgICAg
cG9ydHMtaW1wbGVtZW50ZWQgPSA8MT47Cj4gYXJjaC9hcm02NC9ib290L2R0cy9zb2Npb25leHQv
dW5pcGhpZXItcHhzMy5kdHNpOiAgICAgICAgICAgICAgICAgICAgICAgcG9ydHMtaW1wbGVtZW50
ZWQgPSA8MT47Cj4gCj4gCj4gU3VyZSwgaWYgdGhlIHBvcnRzIGltcGxlbWVudGVkIHJlZ2lzdGVy
IHdhcyBzdGlja3kgKGtlcHQgaXRzIHZhbHVlIGFmdGVyIGEKPiByZXNldCksIHRoZW4gSSB0aGlu
ayBSb2IncyBzdWdnZXN0aW9uIHdvdWxkIG1ha2Ugc2Vuc2UuCj4gCj4gCgpUaGFuayB5b3UgdmVy
eSBtdWNoIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KCj4gCj4gS2luZCByZWdhcmRzLAo+IE5pa2xh
cwoKQmVzdCByZWdhcmRzLApZdWxpbgo=

