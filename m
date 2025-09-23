Return-Path: <linux-kernel+bounces-828249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE9B9441C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4528918A0007
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A530E0D4;
	Tue, 23 Sep 2025 04:52:10 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F030CB36;
	Tue, 23 Sep 2025 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603130; cv=none; b=H9El7cFNfp6Jv4IK4S/dtwxoJN2RyuVhgtHJpf3xAoYtEtYq+3/N2JvnHtppZnKnAKSGUtIQ6F9VqN2Fa9ixKvKi0wD7VXPx06OUANgz0OL4dEzr0lSz4FL//2AGm9BUx7bUsQ4GI6xnMZGChg/3xWFFHZmZWQRE+VFopzAm8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603130; c=relaxed/simple;
	bh=E4V6JByyf/2LFihN7Z5ZEqKJDIcadoIhhJWnlLTJqE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=AuGLI0A2tSvGTj/3TUb6ewHmKLhRjc0WCs5oVXtqpjjNeOBy5PZ8TciLcjDILp1p5zLw1ywf00vil4Ak0DIPmqS0fSNehlHEqkSYdA2lDf9+sdqFvimgNPnp8huUExWjB6hqRnRv3WsjNwXu4DNGa0uRyav5zWBhYUr814oD4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.20.93])
	by mtasvr (Coremail) with SMTP id _____wAHV7BkJ9JofBNjAg--.5441S3;
	Tue, 23 Sep 2025 12:51:49 +0800 (CST)
Received: from duoming$zju.edu.cn ( [218.12.20.93] ) by
 ajax-webmail-mail-app1 (Coremail) ; Tue, 23 Sep 2025 12:51:46 +0800
 (GMT+08:00)
Date: Tue, 23 Sep 2025 12:51:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	YehezkelShB@gmail.com, westeri@kernel.org, michael.jamet@intel.com,
	andreas.noever@gmail.com
Subject: Re: [PATCH] thunderbolt: Fix use-after-free in tb_dp_dprx_work
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <20250922125443.GX2912318@black.igk.intel.com>
References: <20250922051859.16095-1-duoming@zju.edu.cn>
 <20250922125443.GX2912318@black.igk.intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <153e445.ee16.19974e9d7dd.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBn4NljJ9JoqmJXAg--.65152W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwcSAWjRpnsC4QAbsL
X-CM-DELIVERINFO: =?B?Pc8wIAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR13DK2upj5hkPSnGCZlqmT+iCBqeMSn53vgwcKNn1LyHSY/iIuIcPATLxVE1y03DlVke8
	XVG9SRwd4VYf1mAci65r3qNYlOLEYGXu0kgvO8tky5tPWdqmE2QpArFT64ouUg==
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4fZr4UuryDAF15Kw4Dtrc_yoW5CrWkpr
	W5GayUtFW5tas8ArsFqw4DuF13u39Yy3W5Grs8Ka1rAw1Y9w43Ja1UGFyFqF45ArW8JF12
	yr4jq3y7ZFWqkrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwAK
	zVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCEFcxC0VAYjxAxZFUvcSsGvf
	C2KfnxnUUI43ZEXa7IU848BUUUUUU==

T24gTW9uLCAyMiBTZXAgMjAyNSAxNDo1NDo0MyArMDIwMCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6
Cj4gPiBUaGUgb3JpZ2luYWwgY29kZSByZWxpZXMgb24gY2FuY2VsX2RlbGF5ZWRfd29yaygpIGlu
IHRiX2RwX2Rwcnhfc3RvcCgpLAo+ID4gd2hpY2ggZG9lcyBub3QgZW5zdXJlIHRoYXQgdGhlIGRl
bGF5ZWQgd29yayBpdGVtIHR1bm5lbC0+ZHByeF93b3JrIGhhcwo+ID4gZnVsbHkgY29tcGxldGVk
IGlmIGl0IHdhcyBhbHJlYWR5IHJ1bm5pbmcuIFRoaXMgbGVhZHMgdG8gdXNlLWFmdGVyLWZyZWUK
PiA+IHNjZW5hcmlvcyB3aGVyZSB0Yl90dW5uZWwgaXMgZGVhbGxvY2F0ZWQgYnkgdGJfdHVubmVs
X3B1dCgpLCB3aGlsZQo+ID4gdHVubmVsLT5kcHJ4X3dvcmsgcmVtYWlucyBhY3RpdmUgYW5kIGF0
dGVtcHRzIHRvIGRlcmVmZXJlbmNlIHRiX3R1bm5lbAo+ID4gaW4gdGJfZHBfZHByeF93b3JrKCku
Cj4gPiAKPiA+IEEgdHlwaWNhbCByYWNlIGNvbmRpdGlvbiBpcyBpbGx1c3RyYXRlZCBiZWxvdzoK
PiA+IAo+ID4gQ1BVIDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBDUFUgMQo+ID4gdGJf
ZHBfdHVubmVsX2FjdGl2ZSgpICAgICAgICAgICAgfAo+ID4gICB0Yl9kZWFjdGl2YXRlX2FuZF9m
cmVlX3R1bm5lbCgpfCB0Yl9kcF9kcHJ4X3N0YXJ0KCkKPiA+ICAgICB0Yl90dW5uZWxfZGVhY3Rp
dmF0ZSgpICAgICAgIHwgICBxdWV1ZV9kZWxheWVkX3dvcmsoKQo+ID4gICAgICAgdGJfZHBfYWN0
aXZhdGUoKSAgICAgICAgICAgfAo+ID4gICAgICAgICB0Yl9kcF9kcHJ4X3N0b3AoKSAgICAgICAg
fCB0Yl9kcF9kcHJ4X3dvcmsoKSAvL2RlbGF5ZWQgd29ya2VyCj4gPiAgICAgICAgICAgY2FuY2Vs
X2RlbGF5ZWRfd29yaygpICB8Cj4gPiAgICAgdGJfdHVubmVsX3B1dCh0dW5uZWwpOyAgICAgICB8
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgdHVubmVsID0gY29udGFp
bmVyX29mKC4uLik7IC8vVUFGCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgdHVubmVsLT4gLy9VQUYKPiA+IAo+ID4gUmVwbGFjaW5nIGNhbmNlbF9kZWxheWVkX3dvcmso
KSB3aXRoIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIGlzCj4gPiBub3QgZmVhc2libGUgYXMg
aXQgd291bGQgaW50cm9kdWNlIGEgZGVhZGxvY2s6IGJvdGggdGJfZHBfZHByeF93b3JrKCkKPiA+
IGFuZCB0aGUgY2xlYW51cCBwYXRoIGFjcXVpcmUgdGItPmxvY2ssIGFuZCBjYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoKQo+ID4gd291bGQgd2FpdCBpbmRlZmluaXRlbHkgZm9yIHRoZSB3b3JrIGl0
ZW0gdGhhdCBjYW5ub3QgcHJvY2VlZC4KPiA+IAo+ID4gSW5zdGVhZCwgaW1wbGVtZW50IHByb3Bl
ciByZWZlcmVuY2UgY291bnRpbmc6Cj4gPiAtIElmIGNhbmNlbF9kZWxheWVkX3dvcmsoKSByZXR1
cm5zIHRydWUgKHdvcmsgaXMgcGVuZGluZyksIHdlIHJlbGVhc2UKPiA+ICAgdGhlIHJlZmVyZW5j
ZSBpbiB0aGUgc3RvcCBmdW5jdGlvbi4KPiA+IC0gSWYgaXQgcmV0dXJucyBmYWxzZSAod29yayBp
cyBleGVjdXRpbmcgb3IgYWxyZWFkeSBjb21wbGV0ZWQpLCB0aGUKPiA+ICAgcmVmZXJlbmNlIGlz
IHJlbGVhc2VkIGluIGRlbGF5ZWQgd29yayBmdW5jdGlvbiBpdHNlbGYuCj4gPiAKPiA+IFRoaXMg
ZW5zdXJlcyB0aGUgdGJfdHVubmVsIHJlbWFpbnMgdmFsaWQgZHVyaW5nIHdvcmsgaXRlbSBleGVj
dXRpb24KPiA+IHdoaWxlIHByZXZlbnRpbmcgbWVtb3J5IGxlYWtzLgo+ID4gCj4gPiBUaGlzIGJ1
ZyB3YXMgZm91bmQgYnkgc3RhdGljIGFuYWx5c2lzLgo+ID4gCj4gPiBGaXhlczogZDZkNDU4ZDQy
ZTFlICgidGh1bmRlcmJvbHQ6IEhhbmRsZSBEaXNwbGF5UG9ydCB0dW5uZWwgYWN0aXZhdGlvbiBh
c3luY2hyb25vdXNseSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdA
emp1LmVkdS5jbj4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvdGh1bmRlcmJvbHQvdHVubmVsLmMgfCA4
ICsrKysrKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGh1bmRlcmJvbHQvdHVubmVsLmMg
Yi9kcml2ZXJzL3RodW5kZXJib2x0L3R1bm5lbC5jCj4gPiBpbmRleCBkNTJlZmUzZjY1OGMuLjg5
ZmEwYzYyNmQzZSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdGh1bmRlcmJvbHQvdHVubmVsLmMK
PiA+ICsrKyBiL2RyaXZlcnMvdGh1bmRlcmJvbHQvdHVubmVsLmMKPiA+IEBAIC0xMDczLDYgKzEw
NzMsNyBAQCBzdGF0aWMgdm9pZCB0Yl9kcF9kcHJ4X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQo+ID4gIAo+ID4gIAlpZiAodHVubmVsLT5jYWxsYmFjaykKPiA+ICAJCXR1bm5lbC0+Y2Fs
bGJhY2sodHVubmVsLCB0dW5uZWwtPmNhbGxiYWNrX2RhdGEpOwo+ID4gKwl0Yl90dW5uZWxfcHV0
KHR1bm5lbCk7Cj4gPiAgfQo+ID4gIAo+ID4gIHN0YXRpYyBpbnQgdGJfZHBfZHByeF9zdGFydChz
dHJ1Y3QgdGJfdHVubmVsICp0dW5uZWwpCj4gPiBAQCAtMTA5NywxMSArMTA5OCwxNCBAQCBzdGF0
aWMgaW50IHRiX2RwX2Rwcnhfc3RhcnQoc3RydWN0IHRiX3R1bm5lbCAqdHVubmVsKQo+ID4gIAo+
ID4gIHN0YXRpYyB2b2lkIHRiX2RwX2Rwcnhfc3RvcChzdHJ1Y3QgdGJfdHVubmVsICp0dW5uZWwp
Cj4gPiAgewo+ID4gKwlib29sIHJldDsKPiA+ICsKPiAKPiBXaHkgeW91IG5lZWQgdmFyaWFibGUg
aGVyZT8KPiAKPiA+ICAJaWYgKHR1bm5lbC0+ZHByeF9zdGFydGVkKSB7Cj4gPiAgCQl0dW5uZWwt
PmRwcnhfc3RhcnRlZCA9IGZhbHNlOwo+ID4gIAkJdHVubmVsLT5kcHJ4X2NhbmNlbGVkID0gdHJ1
ZTsKPiA+IC0JCWNhbmNlbF9kZWxheWVkX3dvcmsoJnR1bm5lbC0+ZHByeF93b3JrKTsKPiA+IC0J
CXRiX3R1bm5lbF9wdXQodHVubmVsKTsKPiA+ICsJCXJldCA9IGNhbmNlbF9kZWxheWVkX3dvcmso
JnR1bm5lbC0+ZHByeF93b3JrKTsKPiA+ICsJCWlmIChyZXQpCj4gPiArCQkJdGJfdHVubmVsX3B1
dCh0dW5uZWwpOwo+IAo+IEp1c3QgZG86Cj4gCj4gCWlmIChjYW5jZWxfZGVsYXllZF93b3JrKC4u
LikpCj4gCQl0Yl90dW5uZWxfcHV0KHR1bm5lbCk7Cj4gClRoYW5rIHlvdSBmb3IgeW91ciBzdWdn
ZXN0aW9ucywgSSB3aWxsIG1vZGlmeSB0aGUgY29kZQphbmQgc2VuZCB0aGUgcGF0Y2ggdjIuCgpC
ZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQoKCg==


