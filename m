Return-Path: <linux-kernel+bounces-751620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A45B16B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C8016646B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCA242D63;
	Thu, 31 Jul 2025 05:32:14 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0DDA94A;
	Thu, 31 Jul 2025 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753939934; cv=none; b=c5uJ9/EFzUHW/uK0WFCPrEu9iImTd0XEzecJ56NJCxZZrI2KIVZ9/VtfN+BqZIgJVwbuXQAJL4Nu2Vu2ShvoqV0Ph5usXQBUqLSmo5V4ZQkHm3+kN6p+kGyy+j/mgWhRYzurUadzfKYygna+3ytN8HLn5pk+wq4EuC7i94ZP8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753939934; c=relaxed/simple;
	bh=S8fE8csNzXTLlrCW1M853t6niS2JJvEuUJQqdUqbuHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=CzkWCw62ByAzCJ0FsugHqofbAPfQ1qFxrtC0vleEjGd6+CioEC2uc6YVFEmpg7sjsGzdmvz4XVIWEyl5fdyvhQ9PKLfB7WmyW/N8YVHteM6+DiSF/ta9URjcP8fbQ2faCYySntK35+sPWaNCZ8QP7yjcN4ycHlFkRh/B04Lb01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 31 Jul 2025 13:31:49 +0800 (GMT+08:00)
Date: Thu, 31 Jul 2025 13:31:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	yangwei1@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v2 1/2] dt-bindings: usb: Add Eswin EIC7700 USB
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <51648c0f-dd30-4a07-83c0-533a57c29e63@kernel.org>
References: <20250730073953.1623-1-zhangsenchuan@eswincomputing.com>
 <20250730074058.2004-1-zhangsenchuan@eswincomputing.com>
 <51648c0f-dd30-4a07-83c0-533a57c29e63@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1f9a715d.3bb7.1985ef71b54.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpXF_4poaze5AA--.20997W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQEABmiKS
	PEVfwAAs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiS3J6eXN6dG9mIEtvemxv
d3NraSIgPGtyemtAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6MjAyNS0wNy0zMCAxNTo0Njow
MiAo5pif5pyf5LiJKQo+IOaUtuS7tuS6ujogemhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5j
b20sIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnLCByb2JoQGtlcm5lbC5vcmcsIGtyemsrZHRA
a2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbGludXgtdXNiQHZnZXIua2VybmVsLm9y
ZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcsIFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20sIHAuemFiZWxAcGVuZ3V0cm9uaXguZGUKPiDm
ioTpgIE6IG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBlc3dpbmNvbXB1dGluZy5j
b20sIHlhbmd3ZWkxQGVzd2luY29tcHV0aW5nLmNvbSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hp
cHMuY29tCj4g5Li76aKYOiBSZTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IHVzYjogQWRk
IEVzd2luIEVJQzc3MDAgVVNCIGNvbnRyb2xsZXIKPiAKPiBPbiAzMC8wNy8yMDI1IDA5OjQwLCB6
aGFuZ3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPiA+ICsKPiA+ICtleGFtcGxl
czoKPiA+ICsgIC0gfAo+ID4gKyAgICBzb2Mgewo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8Mj47Cj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsKPiAKPiBUaGlzIHdhc24ndCBo
ZXJlLiBEcm9wLgo+IAo+ID4gKwo+ID4gKyAgICAgICAgdXNiIHsKPiA+ICsgICAgICAgICAgICBj
b21wYXRpYmxlID0gImVzd2luLGVpYzc3MDAtZHdjMyI7Cj4gPiArICAgICAgICAgICAgY2xvY2tz
ID0gPCZmaXhlZF9mYWN0b3JfdV9jbGtfMW1fZGl2MjQ+LAo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIDwmZ2F0ZV9jbGtfaHNwX2FjbGs+LAo+ID4gKyAgICAgICAgICAgICAgICAgICAgIDwmZ2F0
ZV9jbGtfaHNwX2NmZ2Nsaz47Cj4gPiArICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAic3VzcGVu
ZCIsImFjbGsiLCAiY2ZnIjsKPiA+ICsgICAgICAgICAgICBlc3dpbixoc3Atc3AtY3NyID0gPCZo
c3Bfc3BfY3NyIDB4ODAwIDB4ODA4IDB4ODNjIDB4ODQwPjsKPiA+ICsgICAgICAgICAgICByZXNl
dHMgPSA8JnJlc2V0IDg0PjsKPiA+ICsgICAgICAgICAgICByZXNldC1uYW1lcyA9ICJ2YXV4IjsK
PiA+ICsgICAgICAgICAgICByYW5nZXM7Cj4gCj4gU2FtZSBjb21tZW50OiBmb2xsb3cgRFRTIGNv
ZGluZyBzdHlsZS4gV2hlcmUgc2hvdWxkIHJhbmdlcyBvciByZWcgYmUgcGxhY2VkPwoKQWNjb3Jk
aW5nIHRvIHRoZSAiZHRzLWNvZGluZy1zdHlsZS5odG1sIiwgdGhlIG9yZGVyIHNob3VsZCBiZSBs
aWtlIGJlbG93LCBpcyB0aGlzIGNvcnJlY3Q/Cgpjb21wYXRpYmxlID0gImVzd2luLGVpYzc3MDAt
ZHdjMyI7CnJhbmdlczsKI2FkZHJlc3MtY2VsbHMgPSA8MT47CiNzaXplLWNlbGxzID0gPDE+OwoK
PiAKPiA+ICsgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsKPiA+ICsgICAgICAgICAg
ICAjc2l6ZS1jZWxscyA9IDwyPjsKPiA+ICsKPiA+ICsgICAgICAgICAgICB1c2JANTA0ODAwMDAg
ewo+ID4gKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNucHMsZHdjMyI7Cj4gPiArICAg
ICAgICAgICAgICAgIHJlZyA9IDwweDAgMHg1MDQ4MDAwMCAweDAgMHgxMDAwMD47Cj4gCj4gTm90
aGluZyBpbXByb3ZlZCBhbmQgeW91IGRpZCBub3QgcmVzcG9uZCB0byB0aGUgZmVlZGJhY2suCgpJ
J20gdmVyeSBzb3JyeSB0aGF0IEkgaGF2ZW4ndCBnaXZlbiB5b3UgYW55IGZlZWRiYWNrIGhlcmUu
IEknbSBub3QgcXVpdGUgY2xlYXIgYWJvdXQgd2hhdCB5b3UgbWVhbiBieSBmZWVkYmFjay4KSW4g
djEgcGF0Y2gsIHlvdSBtZW50aW9uZWQgIkZvbGQgdGhlIGNoaWxkIG5vZGUgaW50byB0aGUgcGFy
ZW50Iu+8jGNvdWxkIHlvdSBwbGVhc2UgdGVsbCBtZSB3aGF0J3MgdGhlIGV4YWN0Cm1lYW5pbmcg
b2YgdGhpcyBjb21tZW50Pwo+IAo+IAo+IEJlc3QgcmVnYXJkcywKPiBTZW5jaHVhbiBaaGFuZw==


