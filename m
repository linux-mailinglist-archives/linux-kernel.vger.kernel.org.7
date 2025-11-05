Return-Path: <linux-kernel+bounces-886450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F5C35A58
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D50D4E8A29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578C314B94;
	Wed,  5 Nov 2025 12:28:17 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3234311973;
	Wed,  5 Nov 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345697; cv=none; b=IQ1eoGeYJIG6DHGgIRIU2ufak8TDnAGdrVYMyX1qvx/O4UcXu+ETCW+HaSJMX9/XNK562v1yHIJJYwOYfdqM2Ju5kCVO9mabo7P9zRUi6o6YQHjMtK0RQHCJBl102ekXK/7GaqXlocyHeKBifcPruJryBE6rCwoVUivy7OBO5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345697; c=relaxed/simple;
	bh=Qf5CgmG7ZPRyVEAKwk6zM9m0tOrb33Q0+BoB1g2wOb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=o5Mg4FNPwSK/DsRG9tHdjSiXGIcHshJMS6hjdZJEs29Vgd3ztb9hCTczuzYW7YX4spqkkeRMO976Ig/H7e8MsCtZKliEHzxf77mfEv+MZezbozV5Dm7yJzv7pwSYvcyLxgoRaInO/oihcY9Majv088nn+Y73DcCAgXiyykF8bxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from caohang$eswincomputing.com ( [10.127.112.153] ) by
 ajax-webmail-app1 (Coremail) ; Wed, 5 Nov 2025 20:27:50 +0800 (GMT+08:00)
Date: Wed, 5 Nov 2025 20:27:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Hang Cao" <caohang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	"Senchuan Zhang" <zhangsenchuan@eswincomputing.com>
Subject: Re: Re: [PATCH v5 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <76ec3e26-a38c-4643-aaab-7806cc39bd89@kernel.org>
References: <20251104065045.1464-1-caohang@eswincomputing.com>
 <20251104065226.1513-1-caohang@eswincomputing.com>
 <76ec3e26-a38c-4643-aaab-7806cc39bd89@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <9e50dfa.f63.19a53fcd7ec.Coremail.caohang@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgAXH2zHQgtpDpAuAA--.1301W
X-CM-SenderInfo: xfdrxt1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQEREGkKKoAeZAAA
	sy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGksIEtyenlzenRvZiBhbmQgVGhpbmg6Cj4gCj4gPiArCj4gPiAgc3RhdGljIGludCBkd2MzX2dl
bmVyaWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+ICB7Cj4gPiAgCWNv
bnN0IHN0cnVjdCBkd2MzX3Byb3BlcnRpZXMgKnByb3BlcnRpZXM7Cj4gPiBAQCAtODMsNiArMTE5
LDEyIEBAIHN0YXRpYyBpbnQgZHdjM19nZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpCj4gPiAgCWVsc2UKPiA+ICAJCXByb2JlX2RhdGEucHJvcGVydGllcyA9IERXQzNf
REVGQVVMVF9QUk9QRVJUSUVTOwo+ID4gIAo+ID4gKwlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGli
bGUoZGV2LT5vZl9ub2RlLCAiZXN3aW4sZWljNzcwMC1kd2MzIikpIHsKPiAKPiBObywgeW91IGhh
dmUgZHJpdmVyIG1hdGNoIGRhdGEgZm9yIHRoYXQuCj4gCldlIGltcGxlbWVudGVkIGl0IHdpdGgg
ZHJpdmVyIG1hdGNoIGRhdGEgaW4gdjQgcGF0Y2guCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI1MTAxNjIyMjcxMy5kMnN1dGM3dHlmMmlkYmt2QHN5bm9wc3lzLmNvbS8KCkhvd2V2ZXIs
IFRoaW5oIHN1Z2dlc3RlZCB1c2luZyBkaXJlY3QgZnVuY3Rpb24gY2FsbHMgaW5zdGVhZCwgbm90
aW5nwqAKdGhhdCB0aGlzIGlzIGEgZnVuY3Rpb24gY2FsbCByYXRoZXIgdGhhbiBkYXRhLsKgCldl
IGFyZSBub3Qgc3VyZSBpZiB3ZeKAmXZlIGZ1bGx5IHVuZGVyc3Rvb2QgaGlzIGZlZWRiYWNrIGNv
cnJlY3RseS4KCk91ciBkcml2ZXIgcmVxdWlyZXMgc3BlY2lhbCBoYW5kbGluZyBmb3IgVVNCIGJ1
cyBpbml0aWFsaXphdGlvbiwgd2hpY2ggZG9lcyAKaW52b2x2ZSBmdW5jdGlvbiBjYWxscy4KClNv
IHdl4oCZZCByZWFsbHkgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgYW5kIFRoaW5oIGNvdWxkIHNoYXJl
IGZ1cnRoZXIgdGhvdWdodHPCoApvbiB3aGljaCBhcHByb2FjaCB3b3VsZCBiZSBtb3JlIHN1aXRh
YmxlIGZvciBvdXIgZHJpdmVy4oCZcyBuZWVkcy4KCgpCZXN0IHJlZ2FyZHMsCkhhbmcgQ2FvCg==


