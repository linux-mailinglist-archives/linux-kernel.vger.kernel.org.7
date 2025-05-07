Return-Path: <linux-kernel+bounces-636976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE826AAD297
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 03:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E54505A31
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837915689A;
	Wed,  7 May 2025 01:18:06 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E329F78F5D;
	Wed,  7 May 2025 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580686; cv=none; b=Hv4RNUTJQDmbOVXqhP5LEWXJeCTOzjsWSO1z1vG4F7aIz9vL8+kfjvLuWROLFpJtyz0dz5+cbx1W3m6i04jdgBL1og4D7FNWxox8Ag+Rdp2TWDghe3K2ZkuSP+3b33GncHTnns0IxQ43A9bwzLfypZHnQP0CIvLAvkLh8TjUXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580686; c=relaxed/simple;
	bh=rFhOLa7secTqn+P4t7t8+f2ee5Kpo7+MvTrFGIUwZ6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TWrGqYNerzs0ShtVYzzEF0W1vjd7O+HWpxtP+jzlTpQ3EtqcPNAj3ht5aBRLK7WuPU/zCUE8hq7oa6ZV1VZ1rxe/jmqg5uEX1JeMs5sEXgRR8Rjmcz/Sj+Tiqh0v6Klj9+jbO252FINjhgyfuPkCjxH8QXG7I2TsvFShyL3SqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8AxWXHGtBpoxYrXAA--.26169S3;
	Wed, 07 May 2025 09:17:58 +0800 (CST)
Received: from chenhuacai$loongson.cn ( [223.64.68.186] ) by
 ajax-webmail-front1 (Coremail) ; Wed, 7 May 2025 09:17:39 +0800 (GMT+08:00)
Date: Wed, 7 May 2025 09:17:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	"Bibo Mao" <maobibo@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 12/15] loongarch/perf: Remove driver-specific
 throttle support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240729(6d2960c6) Copyright (c) 2002-2025 www.mailtech.cn loongson
In-Reply-To: <20250506164740.1317237-13-kan.liang@linux.intel.com>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
 <20250506164740.1317237-13-kan.liang@linux.intel.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: ZTMfMGZvb3Rlcl90eHQ9MTg1MTo2MTg=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6777794d.1b9e4.196a851ddc0.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qMiowMDxTseztBpo+7m4AA--.14982W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAgEPBmgal+cBAAABsI
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4DuryUKF15uFykXw1rZrc_yoW8ur1kpr
	WDCr98KrWrKFn7XwsxCr15ua4UXwn7WrZag3WDt3WrArZxZ3ykXF1kXwn8WF90qw1rGFW0
	qw4vqF4Iga4UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUl0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2vj6VCEFcxC0VAYjxAxZF0EFcxC0VAYjxAxZF0Ew4CEw7
	xC0VCjxxvEa2IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xAC
	xx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFcxC0VAY
	jxAxZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07MxkF7I0En4kS14v26r1q6r43MxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k04243AbIY
	CTnIWIevJa73UjIFyTuYvjxUeqXHDUUUU

SGksIExpYW5nLAoKU2luY2Ugd2hpY2ggdmVyc2lvbiB3ZSBuZWVkIHRoaXMgcGF0Y2g/IEkgbWVh
biB3aGljaCB2ZXJzaW9ucyB0aGlzIHBhdGNoIHNob3VsZCBiZSBiYWNrcG9ydGVkLgpBbmQgeW91
IG5lZWQgdG8gQ0MgbG9vbmdhcmNoQGxpc3RzLmxpbnV4LmRldi4KCkh1YWNhaQoKCj4gLS0tLS3l
jp/lp4vpgq7ku7YtLS0tLQo+IOWPkeS7tuS6ujoga2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbQo+
IOWPkemAgeaXtumXtDoyMDI1LTA1LTA3IDAwOjQ3OjM3ICjmmJ/mnJ/kuIkpCj4g5pS25Lu25Lq6
OiBwZXRlcnpAaW5mcmFkZWFkLm9yZywgbWluZ29AcmVkaGF0LmNvbSwgbmFtaHl1bmdAa2VybmVs
Lm9yZywgaXJvZ2Vyc0Bnb29nbGUuY29tLCBtYXJrLnJ1dGxhbmRAYXJtLmNvbSwgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZywgbGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5vcmcKPiDm
ioTpgIE6IGVyYW5pYW5AZ29vZ2xlLmNvbSwgY3RzaGFvQGdvb2dsZS5jb20sIHRtcmljaHRAbGlu
dXguaWJtLmNvbSwgIkthbiBMaWFuZyIgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+LCAiQmli
byBNYW8iIDxtYW9iaWJvQGxvb25nc29uLmNuPiwgIkh1YWNhaSBDaGVuIiA8Y2hlbmh1YWNhaUBs
b29uZ3Nvbi5jbj4KPiDkuLvpopg6IFtSRkMgUEFUQ0ggMTIvMTVdIGxvb25nYXJjaC9wZXJmOiBS
ZW1vdmUgZHJpdmVyLXNwZWNpZmljIHRocm90dGxlIHN1cHBvcnQKPiAKPiBGcm9tOiBLYW4gTGlh
bmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Cj4gCj4gVGhlIHRocm90dGxlIHN1cHBvcnQg
aGFzIGJlZW4gYWRkZWQgaW4gdGhlIGdlbmVyaWMgY29kZS4gUmVtb3ZlCj4gdGhlIGRyaXZlci1z
cGVjaWZpYyB0aHJvdHRsZSBzdXBwb3J0Lgo+IAo+IEJlc2lkZXMgdGhlIHRocm90dGxlLCBwZXJm
X2V2ZW50X292ZXJmbG93IG1heSByZXR1cm4gdHJ1ZSBiZWNhdXNlIG9mCj4gZXZlbnRfbGltaXQu
IEl0IGFscmVhZHkgZG9lcyBhbiBpbmF0b21pYyBldmVudCBkaXNhYmxlLiBUaGUgcG11LT5zdG9w
Cj4gaXMgbm90IHJlcXVpcmVkIGVpdGhlci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBLYW4gTGlhbmcg
PGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Cj4gQ2M6IEJpYm8gTWFvIDxtYW9iaWJvQGxvb25n
c29uLmNuPgo+IENjOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBsb29uZ3Nvbi5jbj4KPiAtLS0K
PiAgYXJjaC9sb29uZ2FyY2gva2VybmVsL3BlcmZfZXZlbnQuYyB8IDMgKy0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
YXJjaC9sb29uZ2FyY2gva2VybmVsL3BlcmZfZXZlbnQuYyBiL2FyY2gvbG9vbmdhcmNoL2tlcm5l
bC9wZXJmX2V2ZW50LmMKPiBpbmRleCBmODZhNGI4MzhkZDcuLjhhZDA5ODcwMzQ4OCAxMDA2NDQK
PiAtLS0gYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvcGVyZl9ldmVudC5jCj4gKysrIGIvYXJjaC9s
b29uZ2FyY2gva2VybmVsL3BlcmZfZXZlbnQuYwo+IEBAIC00NzksOCArNDc5LDcgQEAgc3RhdGlj
IHZvaWQgaGFuZGxlX2Fzc29jaWF0ZWRfZXZlbnQoc3RydWN0IGNwdV9od19ldmVudHMgKmNwdWMs
IGludCBpZHgsCj4gIAlpZiAoIWxvb25nYXJjaF9wbXVfZXZlbnRfc2V0X3BlcmlvZChldmVudCwg
aHdjLCBpZHgpKQo+ICAJCXJldHVybjsKPiAgCj4gLQlpZiAocGVyZl9ldmVudF9vdmVyZmxvdyhl
dmVudCwgZGF0YSwgcmVncykpCj4gLQkJbG9vbmdhcmNoX3BtdV9kaXNhYmxlX2V2ZW50KGlkeCk7
Cj4gKwlwZXJmX2V2ZW50X292ZXJmbG93KGV2ZW50LCBkYXRhLCByZWdzKTsKPiAgfQo+ICAKPiAg
c3RhdGljIGlycXJldHVybl90IHBtdV9oYW5kbGVfaXJxKGludCBpcnEsIHZvaWQgKmRldikKPiAt
LSAKPiAyLjM4LjEKDQoNCuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+aciem+meiKr+S4reenkeea
hOWVhuS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWI
l+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9
ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOA
geWkjeWItuaIluaVo+WPke+8ieacrOmCruS7tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OAguWm
guaenOaCqOmUmeaUtuacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuef
peWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuOAgiANClRoaXMgZW1haWwgYW5kIGl0cyBhdHRh
Y2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIExvb25nc29uIFRl
Y2hub2xvZ3kgLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0
eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRp
b24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRl
ZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24gb3IgZGlzc2Vt
aW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykg
aXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxl
dGUgaXQuIA0KDQoNCg==


