Return-Path: <linux-kernel+bounces-621792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE4A9DE71
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 03:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B97B164832
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622B1FFC55;
	Sun, 27 Apr 2025 01:43:48 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438C1F941
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745718228; cv=none; b=kJ7jn8U4rR9kDyWf6/KhBEOkx3l5xUhtVe+PrL7DeDKO2FpY3XI4q03wYgd6sGjUKUW5koMLZZsVb2lBfp27Y9xwyaLo01hooyjDYnxlnFMnuCoAYI+/HyJfTnzPrxkyr8O34QQonLojXZhQUOzQnWMuCyjf36CIUGP4O8xXS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745718228; c=relaxed/simple;
	bh=Xut8Y/8Fhyiz4+sKHVce8xjgNyyJkS2OAZCwqvVgLk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TGQyBNUbkU+LD/2guYTYM6XCZCrjRwhrtw9f1ze6sGyISEAbeboxXgzCM134X8Jw+7RmvT2iNtw7RYyHSputk5088D6cznGid6onJWR9ODeyZ9sYSR7u4In2h7Bbg0vv3yzF/5NenQi8L6pdG/l7hA0fnJZ6d00cAVCSp+kYPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnQ3TiQ1o9o03GQ--.58310S2;
	Sun, 27 Apr 2025 09:35:15 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [192.69.92.114] ) by
 ajax-webmail-mail (Coremail) ; Sun, 27 Apr 2025 09:35:13 +0800 (GMT+08:00)
Date: Sun, 27 Apr 2025 09:35:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Huacai Chen" <chenhuacai@kernel.org>, rppt@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] LoongArch: Introduce the numa_memblks conversion
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250327(ab59d9cc) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <CAAhV-H65jh29ccYzcaJf1=QpDuV5xZfBd-1Kr0=in_nk-Z4h7Q@mail.gmail.com>
References: <20250415072118.3774454-1-chenhuacai@loongson.cn>
 <aANVMaepni3KeABI@kernel.org>
 <CAAhV-H65jh29ccYzcaJf1=QpDuV5xZfBd-1Kr0=in_nk-Z4h7Q@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: 4ggUJmZvb3Rlcl90eHQ9MzA2MDozODM=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4687ce6c.9c7.19674e259ef.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwBn_CXRiQ1o8pIDAA--.925W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWgNN+cAm
	AAAsg
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3JrWktFW3Zw47Ar1xKw1ftFb_yoW3AFWrpa
	1xJa4UAw1UG3W7K3ySkw18AryUC3yUGr17Jw17t3yqvwnrJr4DWwnxKFWxJ3Wjga4Ygrs8
	tw17Z398Xr1UArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

PiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiSHVhY2FpIENoZW4iIDxjaGVu
aHVhY2FpQGtlcm5lbC5vcmc+Cj4g5Y+R6YCB5pe26Ze0OjIwMjUtMDQtMTkgMTU6NTc6MTYgKOaY
n+acn+WFrSkKPiDmlLbku7bkuro6ICJNaWtlIFJhcG9wb3J0IiA8cnBwdEBrZXJuZWwub3JnPgo+
IOaKhOmAgTogIkh1YWNhaSBDaGVuIiA8Y2hlbmh1YWNhaUBsb29uZ3Nvbi5jbj4sIGxvb25nYXJj
aEBsaXN0cy5saW51eC5kZXYsICJYdWVmZW5nIExpIiA8bGl4dWVmZW5nQGxvb25nc29uLmNuPiwg
Ikd1byBSZW4iIDxndW9yZW5Aa2VybmVsLm9yZz4sICJYdWVydWkgV2FuZyIgPGtlcm5lbEB4ZW4w
bi5uYW1lPiwgIkppYXh1biBZYW5nIiA8amlheHVuLnlhbmdAZmx5Z29hdC5jb20+LCBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnLCAiQmluYmluIFpob3UiIDx6aG91YmluYmluQGxvb25nc29u
LmNuPiwgIll1cXVhbiBXYW5nIiA8d2FuZ3l1cXVhbjEyMzZAcGh5dGl1bS5jb20uY24+Cj4g5Li7
6aKYOiBSZTogW1BBVENIIFYyXSBMb29uZ0FyY2g6IEludHJvZHVjZSB0aGUgbnVtYV9tZW1ibGtz
IGNvbnZlcnNpb24KPiAKPiBIaSwgTWlrZSwKPiAKPiBPbiBTYXQsIEFwciAxOSwgMjAyNSBhdCAz
OjQ44oCvUE0gTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBI
aSBIdWFjYWksCj4gPgo+ID4gT24gVHVlLCBBcHIgMTUsIDIwMjUgYXQgMDM6MjE6MThQTSArMDgw
MCwgSHVhY2FpIENoZW4gd3JvdGU6Cj4gPiA+IENvbW1pdCA4NzQ4MjcwODIxMGZmMzMzM2EgKCJt
bTogaW50cm9kdWNlIG51bWFfbWVtYmxrcyIpIGhhcyBtb3ZlZAo+ID4gPiBudW1hX21lbWJsa3Mg
ZnJvbSB4ODYgdG8gdGhlIGdlbmVyaWMgY29kZSwgYnV0IExvb25nQXJjaCB3YXMgbGVmdCBvdXQK
PiA+ID4gb2YgdGhpcyBjb252ZXJzaW9uLgo+ID4gPgo+ID4gPiBUaGlzIHBhdGNoIGludHJvZHVj
ZXMgdGhlIGdlbmVyaWMgbnVtYV9tZW1ibGtzIGZvciBMb29uZ0FyY2guCj4gPiA+Cj4gPiA+IElu
IGRldGFpbDoKPiA+ID4gMS4gRW5hYmxlIE5VTUFfTUVNQkxLUyAoYnV0IGRpc2FibGUgTlVNQV9F
TVUpIGluIEtjb25maWc7Cj4gPiA+IDIuIFVzZSBnZW5lcmljIGRlZmluaXRpb24gZm9yIG51bWFf
bWVtYmxrIGFuZCBudW1hX21lbWluZm87Cj4gPiA+IDMuIFVzZSBnZW5lcmljIGltcGxlbWVudGF0
aW9uIGZvciBudW1hX2FkZF9tZW1ibGsoKSBhbmQgaXRzIGZyaWVuZHM7Cj4gPiA+IDQuIFVzZSBn
ZW5lcmljIGltcGxlbWVudGF0aW9uIGZvciBudW1hX3NldF9kaXN0YW5jZSgpIGFuZCBpdHMgZnJp
ZW5kczsKPiA+ID4gNS4gVXNlIGdlbmVyaWMgaW1wbGVtZW50YXRpb24gZm9yIG1lbW9yeV9hZGRf
cGh5c2FkZHJfdG9fbmlkKCkgYW5kIGl0cwo+ID4gPiAgICBmcmllbmRzLgo+ID4gPgo+ID4gPiBO
b3RlOiBEaXNhYmxlIE5VTUFfRU1VIGJlY2F1c2UgaXQgbmVlZHMgbW9yZSBlZmZvcnRzIGFuZCBu
byBvYnZpb3VzCj4gPiA+IGRlbWFuZCBub3cuCj4gPiA+Cj4gPiA+IFRlc3RlZC1ieTogQmluYmlu
IFpob3UgPHpob3ViaW5iaW5AbG9vbmdzb24uY24+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFl1cXVh
biBXYW5nIDx3YW5neXVxdWFuMTIzNkBwaHl0aXVtLmNvbS5jbj4KPiA+ID4gU2lnbmVkLW9mZi1i
eTogSHVhY2FpIENoZW4gPGNoZW5odWFjYWlAbG9vbmdzb24uY24+Cj4gPiA+IC0tLQo+ID4gPiAg
YXJjaC9sb29uZ2FyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4gPiAgYXJj
aC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vbnVtYS5oICAgICAgfCAgMTQgLS0tLQo+ID4gPiAgYXJj
aC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vc3BhcnNlbWVtLmggfCAgIDUgLS0KPiA+ID4gIGFyY2gv
bG9vbmdhcmNoL2luY2x1ZGUvYXNtL3RvcG9sb2d5LmggIHwgICA3ICstCj4gPiA+ICBhcmNoL2xv
b25nYXJjaC9rZXJuZWwvYWNwaS5jICAgICAgICAgICB8ICAxMSAtLS0KPiA+ID4gIGFyY2gvbG9v
bmdhcmNoL2tlcm5lbC9udW1hLmMgICAgICAgICAgIHwgMTA4ICsrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiA+ID4gIGFyY2gvbG9vbmdhcmNoL21tL2luaXQuYyAgICAgICAgICAgICAgIHwgICA4
IC0tCj4gPiA+ICBtbS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
Cj4gPiA+ICA4IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEzOSBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBUaGlzIGlzIHJlYWxseSBjb29sIHNpbXBsaWZpY2F0aW9uIQo+ID4KPiA+IEkg
d29uZGVyIGlmIG1heWJlIHdlIGNhbiB0YWtlIGEgc3RlcCBvciB0d28gZnVydGhlciBhbmQgbWFr
ZSBsb29uZ2FyY2ggdG8KPiA+IHNoYXJlIG1vcmUgY29kZSB3aXRoIG90aGVyIGFyY2hpdGVjdHVy
ZXMuCj4gPgo+ID4gSXMgdGhlcmUgYSBzdHJvbmcgcmVhc29uIG5vdCB0byBjYWxsIG51bWFfbWVt
Ymxrc19pbml0KCkgZnJvbQo+ID4gaW5pdF9udW1hX21lbW9yeSgpPwo+ID4gQW5kIG1vcmUgYnJv
YWRseSwgbWF5YmUgbG9vbmdhcmNoIGNhbiBiZSBldmVuIHN3aXRjaGVkIHRvIGFyY2hfbnVtYT8K
PiBUaGlzIGlzIGEgbWluaW1hbCBjaGFuZ2UgZm9yIFl1cXVhbiwgSSB3aWxsIG1ha2UgaXQgaW4g
bGludXgtbmV4dCBhcwo+IHNvb24gYXMgcG9zc2libGUgc28gWXVxdWFuIGNhbiBjb250aW51ZSBo
aXMgd29yay4KPiAKSGksIEh1YWNhaSAmIE1pa2UKCldoZXJlIGNvdWxkIEkga25vdyB0aGlzIGhh
cyBiZWVuIG1lcmdlZCBpbiBsaW51eC1uZXh0PyBBZnRlciB0aGF0LCBzaG91bGQgSQpyZS1wdXNo
IHRoZSBjb21taXQgImludHJvZHVjZSBudW1hX2FkZF9yZXNlcnZlZF9tZW1ibGsiID8KClNvcnJ5
IGZvciBteSB1bmZhbWlsaWFyaXR5IHdpdGggdGhlIGNvbW11bml0eSBydWxlcy4KCll1cXVhbgoK
PiBTd2l0Y2hpbmcgdG8gbnVtYV9tZW1ibGtzX2luaXQoKSBvciBhcmNoX251bWEgd2lsbCBiZSBk
b25lIGluIGZ1dHVyZSwKPiBidXQgbmVlZCBzb21lIHRpbWUgYmVjYXVzZSBzb21lIG1hY2hpbmVz
IHNlZW0gdG8gbmVlZCBzb21lIGhhY2tzLgo+IAo+IEh1YWNhaQo+IAo+ID4KPiA+IC0tCj4gPiBT
aW5jZXJlbHkgeW91cnMsCj4gPiBNaWtlLgoNCg0K5L+h5oGv5a6J5YWo5aOw5piO77ya5pys6YKu
5Lu25YyF5ZCr5L+h5oGv5b2S5Y+R5Lu25Lq65omA5Zyo57uE57uH5omA5pyJLOWPkeS7tuS6uuaJ
gOWcqOe7hOe7h+WvueivpemCruS7tuaLpeacieaJgOacieadg+WIqeOAguivt+aOpeaUtuiAheaz
qOaEj+S/neWvhizmnKrnu4/lj5Hku7bkurrkuabpnaLorrjlj68s5LiN5b6X5ZCR5Lu75L2V56ys
5LiJ5pa557uE57uH5ZKM5Liq5Lq66YCP6Zyy5pys6YKu5Lu25omA5ZCr5L+h5oGv44CCDQpJbmZv
cm1hdGlvbiBTZWN1cml0eSBOb3RpY2U6IFRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhp
cyBtYWlsIGlzIHNvbGVseSBwcm9wZXJ0eSBvZiB0aGUgc2VuZGVyJ3Mgb3JnYW5pemF0aW9uLlRo
aXMgbWFpbCBjb21tdW5pY2F0aW9uIGlzIGNvbmZpZGVudGlhbC5SZWNpcGllbnRzIG5hbWVkIGFi
b3ZlIGFyZSBvYmxpZ2F0ZWQgdG8gbWFpbnRhaW4gc2VjcmVjeSBhbmQgYXJlIG5vdCBwZXJtaXR0
ZWQgdG8gZGlzY2xvc2UgdGhlIGNvbnRlbnRzIG9mIHRoaXMgY29tbXVuaWNhdGlvbiB0byBvdGhl
cnMu


