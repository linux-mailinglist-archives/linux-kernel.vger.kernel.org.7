Return-Path: <linux-kernel+bounces-714625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3936AF6A59
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC694E3448
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6D298262;
	Thu,  3 Jul 2025 06:30:04 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03187296147
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751524203; cv=none; b=Ru3x3y9rVC4S5wKpVDJr2JoRHg36vk5gS4CoJaPPnggXJXm5RoGjAQbwSijbOH0aT9/LinW53aIoZsa995A7ZbYlH5XYxXSEVvUvCbalgUYRNl4uUhgJ+qPqbksPlmklqK0nsH2+yFqLrRKgqduqb/wvejSQ11LdlgCA0G1Pbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751524203; c=relaxed/simple;
	bh=igRhDsuiSuXQRzp+0eQ1JsrZSJ5AY9mIOhpTpRULOVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Z4dejoZMGRFqkT2GCRCREfVvs6hrEkdCpKm7030ck4dZeRTE4SDz2LlVuCPWbk815IENTSdxklvVDnhWhbYIEazF2bh09w+pOG9dikiPDBPIZQrLKejTmozBIVnoeNkxt+fqFixmUsCuU6LB3DJ9mKc/apaBvrn1yaT8iudoE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wAXEExVI2ZoJKfaAw--.10212S3;
	Thu, 03 Jul 2025 14:29:42 +0800 (CST)
Received: from linma$zju.edu.cn ( [115.197.243.13] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 3 Jul 2025 14:29:40 +0800
 (GMT+08:00)
Date: Thu, 3 Jul 2025 14:29:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: wkang77@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v1 1/2] staging: gdm724x: fix type confusion in
 gdm_lte_event_rcv()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <2025070343-halves-prison-c40f@gregkh>
References: <20250703052723.14616-1-linma@zju.edu.cn>
 <2025070343-halves-prison-c40f@gregkh>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <97e5af3.9183.197cefa02cc.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgAnToVUI2ZowvxZAA--.11651W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwEQEmhlCw4LqQAAsq
X-CM-DELIVERINFO: =?B?9E9y5AXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHlVyJpD759Nt3m89ewvKkHS2l85V1JX4pgBxrPTgKXn82pmPe1xoh9OFE5HRk2gjSVLO
	fm3FMTiIbenwKZIMugowJ7SMZAUJS1HMGBlyRbnUeJ8zLClqYtuHwjweEWzeCw==
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4Dury8GF4fJryxWFWrXrc_yoW8uw4rpa
	y5uayrtrW8XF97Wan5GFW2gF42gr1xK348C3s3ta45Wr1DXay8JFyrKrW5A3s8AF95AryS
	v3WUZ3y3Kw17uagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa
	7IU8CJm5UUUUU==

SGVsbG8gR3JlZywKCj4gPiBAQCAtNTIyLDYgKzUyMiw5IEBAIHN0YXRpYyB2b2lkIGdkbV9sdGVf
ZXZlbnRfcmN2KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHUxNiB0eXBlLAo+ID4gIHsKPiA+ICAJ
c3RydWN0IG5pYyAqbmljID0gbmV0ZGV2X3ByaXYoZGV2KTsKPiA+ICAKPiA+ICsJaWYgKGRldi0+
bmV0ZGV2X29wcy0+bmRvX29wZW4gIT0gZ2RtX2x0ZV9vcGVuKQo+ID4gKwkJcmV0dXJuOwo+IAo+
IFdoeSBzaG91bGQgYSBkcml2ZXIgYmUgcG9raW5nIGFyb3VuZCBpbiBuZXRkZXZfb3BzPyAgVGhh
dCBmZWVscyB3cm9uZywKPiB3aGF0IHdvdWxkIGV2ZXIgY2hhbmdlIHRoaXM/ICBXaHkgbm90IGZp
eCB0aGF0IGluc3RlYWQ/Cj4gCj4gdGhhbmtzLAo+IAo+IGdyZWcgay1oCgpZZXMsIGl0IHNlZW1z
IHRoYXQgY29tcGFyaW5nIG9wcyBpcyBxdWl0ZSBhbWJpZ3VvdXMgYW5kIHdlaXJkLiBIb3dldmVy
LCBpbnZlc3RpZ2F0aW9uIG9uCmNvZGUgc2hvd3MgdmFyaW91cyBjaGVja3MgYWdhaW5zdCBuZXRf
ZGV2aWNlLgoKLSBieSBgZGV2LT5wcml2X2ZsYWdzYC4gU2VlIGlzX3ZsYW5fZGV2KCkKYGBgCnN0
YXRpYyBpbmxpbmUgYm9vbCBpc192bGFuX2Rldihjb25zdCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
KQp7CiAgICAgICAgcmV0dXJuIGRldi0+cHJpdl9mbGFncyAmIElGRl84MDJfMVFfVkxBTjsKfQpg
YGAKCi0gYnkgYGRldi0+cnRubF9saW5rX29wcy0+a2luZGAuIFNlZSBsb29rdXBfaW50ZXJmYWNl
KCkKYGBgCnN0YXRpYyBzdHJ1Y3Qgd2dfZGV2aWNlICpsb29rdXBfaW50ZXJmYWNlKHN0cnVjdCBu
bGF0dHIgKiphdHRycywKICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2Ip
CnsKICAgIGRldiA9IGRldl9nZXRfYnlfaW5kZXgoc29ja19uZXQoc2tiLT5zayksCiAgICAgICAg
ICAgICAgICAgICAgICAgbmxhX2dldF91MzIoYXR0cnNbV0dERVZJQ0VfQV9JRklOREVYXSkpOwog
ICAgLi4uCiAgICBpZiAoIWRldi0+cnRubF9saW5rX29wcyB8fCAhZGV2LT5ydG5sX2xpbmtfb3Bz
LT5raW5kIHx8CiAgICAgICAgc3RyY21wKGRldi0+cnRubF9saW5rX29wcy0+a2luZCwgS0JVSUxE
X01PRE5BTUUpKSB7CiAgICAuLi4KfQpgYGAKCi0gYnkgYGRldi0+dHlwZWAuIFNlZSBheDI1X2Rl
dmljZV9ldmVudCgpCmBgYApzdGF0aWMgaW50IGF4MjVfZGV2aWNlX2V2ZW50KHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqdGhpcywgdW5zaWduZWQgbG9uZyBldmVudCwKICAgICAgICAgICAgICAgICB2
b2lkICpwdHIpCnsKICAgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSBuZXRkZXZfbm90aWZpZXJf
aW5mb190b19kZXYocHRyKTsKCiAgICAuLi4uLi4KCiAgICAvKiBSZWplY3Qgbm9uIEFYLjI1IGRl
dmljZXMgKi8KICAgIGlmIChkZXYtPnR5cGUgIT0gQVJQSFJEX0FYMjUpCiAgICAgICAgcmV0dXJu
IE5PVElGWV9ET05FOwpgYGAKCkFzIGZvciBwb2tpbmcgYXJvdW5kIGluIG5ldGRldl9vcHMsIHdl
IGRpZG4ndCBrbm93IGlmIGl0IGlzIHRoZSBiZXN0IHNvbHV0aW9uLApqdXN0IGJlY2F1c2Ugc29t
ZSBjb2RlIGRpZCBzaW1pbGFyIGNoZWNrcywgZS5nLgoKYGBgCnN0YXRpYyBzdHJ1Y3QgdGVhbSAq
dGVhbV9ubF90ZWFtX2dldChzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKQp7CiAgICBkZXYgPSBkZXZf
Z2V0X2J5X2luZGV4KG5ldCwgaWZpbmRleCk7CiAgICBpZiAoIWRldiB8fCBkZXYtPm5ldGRldl9v
cHMgIT0gJnRlYW1fbmV0ZGV2X29wcykgewogICAgICAgIC4uLiAKICAgIH0KfQpgYGAKCmFuZAoK
YGBgCnN0YXRpYyBpbnQgbWx4NWVfc2V0X3ZmX3R1bm5lbCguLi4pCnsKICAgIHJvdXRlX2RldiA9
IGRldl9nZXRfYnlfaW5kZXgoZGV2X25ldChvdXRfZGV2KSwgcm91dGVfZGV2X2lmaW5kZXgpOwoK
ICAgIGlmICghcm91dGVfZGV2IHx8IHJvdXRlX2Rldi0+bmV0ZGV2X29wcyAhPSAmbWx4NWVfbmV0
ZGV2X29wcyB8fCAuLi4gKSB7CiAgICAgICAgLi4uCiAgICB9Cn0KYGBgCgpGcm9tIG15IHBvaW50
IG9mIHZpZXcsIHVzaW5nIGBkZXYtPnR5cGUvZmxhZ3MvcHJpdl9mbGFnc2AgY291bGQgYmUgYSBi
ZXR0ZXIKY2hvaWNlIGlmIGl0J3Mgb2theSB0byBpbnRyb2R1Y2UgbW9yZSBkZWZpbml0aW9ucy4K
ClVzaW5nIG5ldGRldl9vcHMgaXMgbW9yZSBzdHJhaWdodGZvcndhcmQuIE9yIG1heWJlIEkgc2hv
dWxkIGp1c3QgY29tcGFyZSB0aGUKYC0+bmV0ZGV2X29wc2AgaW5zdGVhZCBvZiB0aGUgYC0+bmV0
ZGV2X29wcy0+bmRvX29wZW5gPwoKCgpUaGFuc2sKTGlu


