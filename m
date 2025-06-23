Return-Path: <linux-kernel+bounces-697783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5FAE389D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993933B5802
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EBD22DF9A;
	Mon, 23 Jun 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="N2o1DUUN"
Received: from mail-m15566.qiye.163.com (mail-m15566.qiye.163.com [101.71.155.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE122DA0A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667896; cv=none; b=fJeacMcBdw+WvicKLBNaMUfgyzfzXJoz2aFEWEXnmaWqcc4VVXOXoQrMqod30n9yp8IqlbOe816HNm3DwviMpyrO6zbkBwjLOUuXE4YRvnltt2mrLCxaaryUQ4A7vKCq1eVeJIyj0UY3hihUM9d8zdQGnq1zuYkZhhJbAlJDdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667896; c=relaxed/simple;
	bh=GEGAcyCqUXkwXqEOUaiQZ782N2IguRzssxIsxDn790c=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=Wk4FvBc8rdMgSRXlHGxcc8C/8nLQSMVcOgXFF6pWqjpomHE9xoCXsgyTSrPuiiZyOt0mteouRvFG5Z4azutJDMR+byuHPRir8FXmOkSO11f72pS46x4zXkwnGWM2ldXlvebsFo4Pgj4Co/AGTy8B0yKLZYRl6HevhJNimQdQDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=N2o1DUUN; arc=none smtp.client-ip=101.71.155.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from DESKTOP-SN9UGS1 (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1987adbf8;
	Mon, 23 Jun 2025 08:41:44 +0800 (GMT+08:00)
Date: Mon, 23 Jun 2025 08:41:44 +0800
From: "xxm@rock-chips.com" <xxm@rock-chips.com>
To: robin.murphy <robin.murphy@arm.com>, 
	joro <joro@8bytes.org>, 
	will <will@kernel.org>, 
	heiko <heiko@sntech.de>
Cc: iommu <iommu@lists.linux.dev>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBpb21tdS9yb2NrY2hpcDogcHJldmVudCBpb21tdXMgZGVhZCBsb29wIHdoZW4gdHdvIG1hc3RlcnMgc2hhcmUgb25lIElPTU1V?=
References: <20250620073945.572523-1-xxm@rock-chips.com>, 
	<340d76b8-c3a6-4116-ae51-ac4e4ee6a994@arm.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.301[cn]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202506230841445347043@rock-chips.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNJHlYYTRpLTRpNGE5LTUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a979a3bddab03ackunma08b86cd1b6046a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06KTo5DDEzCi4ITxUaIj8w
	TREKFC1VSlVKTE5LTUhCSEtOSkpNVTMWGhIXVQMDFjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lBWU5D
	VUlJVUxVSkpPWVdZCAFZQU9LSEM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=N2o1DUUNJO2OZFiwUvHWww+EiZsX+VCs5xwPWdyLGqmb85zvdLqcAyX3wORnh97ayVcJS8XqvgdxHGsTMvo/LyW3xVIfCYFaL2K562aV7T8kfOQOAcngWGBBxdoduI4KKC0AwwBExjvatfGbxKbnEPYBCXDj00RlYD0jS4CU4a8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=GEGAcyCqUXkwXqEOUaiQZ782N2IguRzssxIsxDn790c=;
	h=date:mime-version:subject:message-id:from;

SGkgUm9iaW4sCgoKPk9uIDIwMjUtMDYtMjAgODozOSBhbSwgU2ltb24gWHVlIHdyb3RlOgoKCgo+
PiBXaGVuIHR3byBtYXN0ZXJzIHNoYXJlIGFuIElPTU1VLCBjYWxsaW5nIG9wcy0+b2ZfeGxhdGUg
ZHVyaW5nCgoKCj4+IHRoZSBzZWNvbmQgbWFzdGVyJ3MgZHJpdmVyIGluaXQgbWF5IG92ZXJ3cml0
ZSBpb21tdS0+ZG9tYWluIHNldAoKCgo+PiBieSB0aGUgZmlyc3QuIFRoaXMgY2F1c2VzIHRoZSBj
aGVjayBpZiAoaW9tbXUtPmRvbWFpbiA9PSBkb21haW4pCgoKCj4+IGluIHJrX2lvbW11X2F0dGFj
aF9kZXZpY2UoKSB0byBmYWlsLCByZXN1bHRpbmcgaW4gdGhlIHNhbWUKCgoKPj4gaW9tbXUtPm5v
ZGUgYmVpbmcgYWRkZWQgdHdpY2UgdG8gJnJrX2RvbWFpbi0+aW9tbXVzLCB3aGljaCBjYW4KCgoK
Pj4gbGVhZCB0byBhbiBpbmZpbml0ZSBsb29wIGluIHN1YnNlcXVlbnQgJnJrX2RvbWFpbi0+aW9t
bXVzIG9wZXJhdGlvbnMuCgoKCj4KCgoKPkluZGVlZCB0aGlzIGlzIGEgcHJvcGVydHkgb2YgdGhl
IElPTU1VIGluc3RhbmNlIGl0c2VsZiBzbyBpdCByZWFsbHkgCgoKCj5zaG91bGQgYmUgaW5pdGlh
bGlzZWQgYmVmb3JlIHJlZ2lzdHJhdGlvbiwgaXJyZXNwZWN0aXZlIG9mIGNsaWVudCAKCgoKPmRl
dmljZXMuIEZXSVcsIGlmIGl0J3MgcG9zc2libGUgdG8gdGFrZSBhbiB1bmV4cGVjdGVkIAoKCgo+
UktfTU1VX0lSUV9QQUdFX0ZBVUxUIGltbWVkaWF0ZWx5IGFmdGVyIHJlcXVlc3RpbmcgdGhlIElS
USAoZS5nLiBpbiBhIAoKCgo+a2R1bXAga2VybmVsIGFmdGVyIGEgY3Jhc2ggd2l0aCB0aGUgaGFy
ZHdhcmUgc3RpbGwgcnVubmluZykgdGhlbiBJIHRoaW5rIAoKCgo+dGhlIGN1cnJlbnQgY29kZSBj
b3VsZCBwcm9iYWJseSBlbmQgdXAgZGVyZWZlcmVuY2luZyBOVUxMIGluIAoKCgo+cmVwb3J0X2lv
bW11X2ZhdWx0KCkgYXMgd2VsbC4KCgpUaGFua3MgIGZvciB5b3VyIHJldmlldyBhbmQgY2xlYXIg
ZXhwbGFuYXRpb24sIEkgd2lsbCBhZGQgdGhlIGluZm9ybWF0aW9uIGFzIHlvdSBzdWdnZXN0ZWQu
CgpTaW1vbiBYdWUKCj4KCgoKPlJldmlld2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBo
eUBhcm0uY29tPgoKCgo+CgoKCj5BbmQgcHJvYmFibHkgYWxzbzoKCgoKPgoKCgo+Q2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKCgoKPkZpeGVzOiAyNWMyMzI1NTc1Y2MgKCJpb21tdS9yb2NrY2hp
cDogQWRkIG1pc3Npbmcgc2V0X3BsYXRmb3JtX2RtYV9vcHMgCgoKCj5jYWxsYmFjayIpCgoKCj4K
CgoKPlRoYW5rcywKCgoKPlJvYmluLgoKCgo+CgoKCj4+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIFh1
ZSA8eHhtQHJvY2stY2hpcHMuY29tPgoKCgo+PiAtLS0KCgoKPj7CoMKgIGRyaXZlcnMvaW9tbXUv
cm9ja2NoaXAtaW9tbXUuYyB8IDMgKystCgoKCj4+wqDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgoKCj4+IAoKCgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9yb2NrY2hpcC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5j
CgoKCj4+IGluZGV4IDIyZjc0YmEzM2EwZS4uZTZiYjNjNzg0MDE3IDEwMDY0NAoKCgo+PiAtLS0g
YS9kcml2ZXJzL2lvbW11L3JvY2tjaGlwLWlvbW11LmMKCgoKPj4gKysrIGIvZHJpdmVycy9pb21t
dS9yb2NrY2hpcC1pb21tdS5jCgoKCj4+IEBAIC0xMTU3LDcgKzExNTcsNiBAQCBzdGF0aWMgaW50
IHJrX2lvbW11X29mX3hsYXRlKHN0cnVjdCBkZXZpY2UgKmRldiwKCgoKPj7CoMKgIAkJcmV0dXJu
IC1FTk9NRU07CgoKCj4+wqDCoCAKCgoKPj7CoMKgIAlkYXRhLT5pb21tdSA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKGlvbW11X2Rldik7CgoKCj4+IC0JZGF0YS0+aW9tbXUtPmRvbWFpbiA9ICZya19p
ZGVudGl0eV9kb21haW47CgoKCj4+wqDCoCAJZGV2X2lvbW11X3ByaXZfc2V0KGRldiwgZGF0YSk7
CgoKCj4+wqDCoCAKCgoKPj7CoMKgIAlwbGF0Zm9ybV9kZXZpY2VfcHV0KGlvbW11X2Rldik7CgoK
Cj4+IEBAIC0xMTk1LDYgKzExOTQsOCBAQCBzdGF0aWMgaW50IHJrX2lvbW11X3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCgoKCj4+wqDCoCAJaWYgKCFpb21tdSkKCgoKPj7CoMKg
IAkJcmV0dXJuIC1FTk9NRU07CgoKCj4+wqDCoCAKCgoKPj4gKwlpb21tdS0+ZG9tYWluID0gJnJr
X2lkZW50aXR5X2RvbWFpbjsKCgoKPj4gKwoKCgo+PsKgwqAgCXBsYXRmb3JtX3NldF9kcnZkYXRh
KHBkZXYsIGlvbW11KTsKCgoKPj7CoMKgIAlpb21tdS0+ZGV2ID0gZGV2OwoKCgo+PsKgwqAgCWlv
bW11LT5udW1fbW11ID0gMDsKCgoKPgoKCgo+CgoK


