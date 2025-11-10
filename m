Return-Path: <linux-kernel+bounces-892275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F685C44BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C20154E40C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206122B5AD;
	Mon, 10 Nov 2025 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RZscf/x9"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CCC133;
	Mon, 10 Nov 2025 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738926; cv=none; b=Raoj/Eo+utzI7VPPUsrav2qPP9+z2qRO6LliUGQ48aJSIHamNoIj8bgyDXV3xcFkHxX8cbhttgbymqvCJn3svi8VeiX+yF9oyUn2pN8UCof1jxYTIbWU7sf2Rp7WTrqXoScdnrZjCNiYZ9Tq/QjTju0LCe5uYDv6RUnvBjfro4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738926; c=relaxed/simple;
	bh=QnfMvaPTMRSHfNakYl6JhID6E7Ylz4P5ZDkx8TBftPg=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=FrrFJlKe8rbRGU0KOZGbwr/Y282oZnjHyfyX4qyRpKU26JCyaiW2zbH7+UEvvjJUfrVOqGv2T2KxovTg+gn+bxasGfqBt91cJDuHFbum9KYFO2BA+SqoJX963ZUG5dPSl5Wnmk8SzxIrfdrAmG7wY2Dj9iSGEst5au8m+HbigDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RZscf/x9; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Mime-Version:Message-ID:
	Content-Type; bh=QnfMvaPTMRSHfNakYl6JhID6E7Ylz4P5ZDkx8TBftPg=;
	b=RZscf/x9G5+VfNxfnp16vHXj90R7gT/gO3R2C8fW8C6OOA5egufnWVBZyZxeyB
	nyN7dFn7OKDcBbC1QZouf5V3dIKUEcw7RGAEc+z4faWzCyENlygHwwLJEaxLLrt3
	xOHXxBTV0s8cDJw6jKDKPCl5snar5yAKcEgU2lsgcVIgs=
Received: from ccc-pc (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXcvHFQhFpJ7ubDQ--.63164S2;
	Mon, 10 Nov 2025 09:41:26 +0800 (CST)
Date: Mon, 10 Nov 2025 09:41:25 +0800
From: "ccc194101@163.com" <ccc194101@163.com>
To: stern <stern@rowland.harvard.edu>, 
	"Benjamin Tissoires" <benjamin.tissoires@redhat.com>, 
	"Alan Swanson" <reiver@improbability.net>
Cc: gregkh <gregkh@linuxfoundation.org>, 
	linux-usb <linux-usb@vger.kernel.org>, 
	usb-storage <usb-storage@lists.one-eyed-alien.net>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] usb: usb-storage: No additional quirks need to be added to the ECD819-SU3 optical drive.
References: <20251107061046.32339-1-ccc194101@163.com>, 
	<c7bf59b5-8078-4b47-b56a-7b5568272d07@rowland.harvard.edu>
X-Priority: 3
X-GUID: 01AFFED0-E363-49A2-9672-038AE8F694B6
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.375[cn]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202511100941253989454@163.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-CM-TRANSID:PigvCgBXcvHFQhFpJ7ubDQ--.63164S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry5XryrJF4UGFW8KFyUWrg_yoWrJFW8pr
	WUta1DCrWkGF1fGwn2yr1UuFyFq3WkAFn5GayUG3y5Xr1Y93WkJr4UAw4UJa4UCrs3ZF1I
	9ayqvr9rKFW8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ua9aPUUUUU=
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiQRgB3mkQG10v6wACs-

Cgo+T24gRnJpLCBOb3YgMDcsIDIwMjUgYXQgMDI6MTA6NDZQTSArMDgwMCwgY2NjMTk0MTAxQDE2
My5jb20gd3JvdGU6Cj4+IEZyb206IENoZW4gQ2hhbmdjaGVuZyA8Y2hlbmNoYW5nY2hlbmdAa3ls
aW5vcy5jbj4KPj4gCj4+IFRoZSBvcHRpY2FsIGRyaXZlIG9mIEVDRDgxOS1TVTMgaGFzIHRoZSBz
YW1lIHZpZCBhbmQgcGlkIGFzIElOSUMtMzA2OSwKPj4gYXMgZm9sbG93czoKPj4gVDo/IEJ1cz0w
MiBMZXY9MDIgUHJudD0wMiBQb3J0PTAxIENudD0wMSBEZXYjPT8gMyBTcGQ9NTAwMCBNeENoPSAw
Cj4+IEQ6PyBWZXI9IDMuMDAgQ2xzPTAwKD5pZmMgKSBTdWI9MDAgUHJvdD0wMCBNeFBTPSA5ICND
ZmdzPT8gMQo+PiBQOj8gVmVuZG9yPTEzZmQgUHJvZElEPTM5NDAgUmV2PSAzLjEwCj4+IFM6PyBN
YW51ZmFjdHVyZXI9SEwtRFQtU1QKPj4gUzo/IFByb2R1Y3Q9IERWRCstUlcgR1Q4ME4KPj4gUzo/
IFNlcmlhbE51bWJlcj00MjMzNDk1MjRFNEUzODMwMzMzODMyMzQzOTIwMjAyMAo+PiBDOiogI0lm
cz0gMSBDZmcjPSAxIEF0cj04MCBNeFB3cj0xNDRtQQo+PiBJOiogSWYjPSAwIEFsdD0gMCAjRVBz
PSAyIENscz0wOChzdG9yLikgU3ViPTAyIFByb3Q9NTAgRHJpdmVyPXVzYi1zdG9yYWdlCj4+IEU6
PyBBZD04MyhJKSBBdHI9MDIoQnVsaykgTXhQUz0xMDI0IEl2bD0wbXMKPj4gRTo/IEFkPTBhKE8p
IEF0cj0wMihCdWxrKSBNeFBTPTEwMjQgSXZsPTBtcwo+PiAKPj4gVGhpcyB3aWxsIHJlc3VsdCBp
biB0aGUgb3B0aWNhbCBkcml2ZSBkZXZpY2UgYWxzbyBhZGRpbmcKPj4gdGhlIHF1aXJrcyBvZiBV
U19GTF9OT19BVEFfMVguIFdoZW4gcGVyZm9ybWluZyBhbiBlcmFzZSBvcGVyYXRpb24sCj4+IGl0
IHdpbGwgZmFpbCwgYW5kIHRoZSByZWFzb24gZm9yIHRoZSBmYWlsdXJlIGlzIGFzIGZvbGxvd3M6
Cj4+IFs/IDM4OC45Njc3NDJdIHNyIDU6MDowOjA6IFtzcjBdIHRhZyMwIFNlbmQ6IHNjbWQgMHgw
MDAwMDAwMGQyMGMzM2E3Cj4+IFs/IDM4OC45Njc3NDJdIHNyIDU6MDowOjA6IFtzcjBdIHRhZyMw
IENEQjogQVRBIGNvbW1hbmQgcGFzcyB0aHJvdWdoKDEyKS9CbGFuayBhMSAxMSAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMAo+PiBbPyAzODguOTY3NzczXSBzciA1OjA6MDowOiBbc3IwXSB0
YWcjMCBEb25lOiBTVUNDRVNTIFJlc3VsdDogaG9zdGJ5dGU9RElEX1RBUkdFVF9GQUlMVVJFIGRy
aXZlcmJ5dGU9RFJJVkVSX09LIGNtZF9hZ2U9MHMKPj4gWz8gMzg4Ljk2Nzc3M10gc3IgNTowOjA6
MDogW3NyMF0gdGFnIzAgQ0RCOiBBVEEgY29tbWFuZCBwYXNzIHRocm91Z2goMTIpL0JsYW5rIGEx
IDExIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCj4+IFs/IDM4OC45Njc4MDNdIHNyIDU6
MDowOjA6IFtzcjBdIHRhZyMwIFNlbnNlIEtleSA6IElsbGVnYWwgUmVxdWVzdCBbY3VycmVudF0K
Pj4gWz8gMzg4Ljk2NzgwM10gc3IgNTowOjA6MDogW3NyMF0gdGFnIzAgQWRkLiBTZW5zZTogSW52
YWxpZCBmaWVsZCBpbiBjZGIKPj4gWz8gMzg4Ljk2NzgwM10gc3IgNTowOjA6MDogW3NyMF0gdGFn
IzAgc2NzaSBob3N0IGJ1c3kgMSBmYWlsZWQgMAo+PiBbPyAzODguOTY3ODAzXSBzciA1OjA6MDow
OiBOb3RpZnlpbmcgdXBwZXIgZHJpdmVyIG9mIGNvbXBsZXRpb24gKHJlc3VsdCA4MTAwMDAyKQo+
PiBbPyAzODguOTY3ODM0XSBzciA1OjA6MDowOiBbc3IwXSB0YWcjMCAwIHNlY3RvcnMgdG90YWws
IDAgYnl0ZXMgZG9uZS4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IENoZW4gQ2hhbmdjaGVuZyA8Y2hl
bmNoYW5nY2hlbmdAa3lsaW5vcy5jbj4KPj4gLS0tCj4+PyBkcml2ZXJzL3VzYi9zdG9yYWdlL3Vu
dXN1YWxfdWFzLmggfCA2ICsrKysrKwo+Pj8gMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3N0b3JhZ2UvdW51c3VhbF91YXMuaCBi
L2RyaXZlcnMvdXNiL3N0b3JhZ2UvdW51c3VhbF91YXMuaAo+PiBpbmRleCAxNDc3ZTMxZDc3NjMu
LjZkMzJiNzg3YmZmOCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy91c2Ivc3RvcmFnZS91bnVzdWFs
X3Vhcy5oCj4+ICsrKyBiL2RyaXZlcnMvdXNiL3N0b3JhZ2UvdW51c3VhbF91YXMuaAo+PiBAQCAt
OTcsNiArOTcsMTIgQEAgVU5VU1VBTF9ERVYoMHgxMjVmLCAweGE5NGEsIDB4MDE2MCwgMHgwMTYw
LAo+Pj8gCQlVU0JfU0NfREVWSUNFLCBVU0JfUFJfREVWSUNFLCBOVUxMLAo+Pj8gCQlVU19GTF9O
T19BVEFfMVgpLAo+Pj8gCj4+ICtVTlVTVUFMX0RFVigweDEzZmQsIDB4Mzk0MCwgMHgwMzEwLCAw
eDAzMTAsCj4+ICsJCSJJbml0aW8gQ29ycG9yYXRpb24iLAo+PiArCQkiZXh0ZXJuYWwgRFZEIGJ1
cm5lciBFQ0Q4MTktU1UzIiwKPj4gKwkJVVNCX1NDX0RFVklDRSwgVVNCX1BSX0RFVklDRSwgTlVM
TCwKPj4gKwkJTlVMTCksCj4+ICsKPj4/IC8qIFJlcG9ydGVkLWJ5OiBCZW5qYW1pbiBUaXNzb2ly
ZXMgPGJlbmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tPiAqLwo+Pj8gVU5VU1VBTF9ERVYoMHgx
M2ZkLCAweDM5NDAsIDB4MDAwMCwgMHg5OTk5LAo+Pj8gCQkiSW5pdGlvIENvcnBvcmF0aW9uIiwK
Pgo+SXQncyB1bnByZWNlZGVudGVkIHRvIGhhdmUgdHdvIHF1aXJrcyB3aXRoIHRoZSBzYW1lIFZJ
RCBhbmQgUElELCB3aGVyZSAKPnRoZSBzZWNvbmQgYXVnbWVudHMgdGhlIGZpcnN0IGJ5IHZpcnR1
ZSBvZiBpdHMgd2lkZXIgcmFuZ2Ugb2YgYmNkRGV2aWNlIAo+dmFsdWVzLgo+Cj5BcyBleHBsYWlu
ZWQgaW4gY29tbWl0IDg5ZjIzZDUxZGVmYyAoInVhczogQWRkIFVTX0ZMX0lHTk9SRV9SRVNJRFVF
IGZvciAKPkluaXRpbyBDb3Jwb3JhdGlvbiBJTklDLTMwNjkiKSwgdGhlIG9yaWdpbmFsIEluaXRp
byBDb3Jwb3JhdGlvbiAKPnF1aXJrIGluIHVudXN1YWxfdWFzLmggd2FzIGFkZGVkIGFzIGEgY29w
eSBvZiB0aGUgY29ycmVzcG9uZGluZyBxdWlyayBpbiAKPnVudXN1YWxfZGV2cy5oLCB3aGljaCBh
cHBsaWVzIG9ubHkgdG8gYmNkRGV2aWNlID0gMHgwMjA5Lj8gU2hvdWxkIHdlIAo+c2ltcGx5IGxp
bWl0IHRoZSBleGlzdGluZyB1bnVzdWFsX3Vhcy5oIHF1aXJrIGluIHRoZSBzYW1lIHdheT8KPgo+
QmVuamFtaW4gYW5kIEFsYW4sIHlvdSB0d28gYXBwZWFyIHRvIGJlIHRoZSBwZW9wbGUgd2hvIG9y
aWdpbmFsbHkKPnJlcG9ydGVkIHRoZSBuZWVkIGZvciB0aGlzIHVhcyBxdWlyay4/IERvIHlvdSBo
YXZlIGFueSBvYmplY3Rpb24gdG8gCj5jaGFuZ2luZyB0aGUgYmNkRGV2aWNlIHJhbmdlIGZyb20g
MHgwMDAwIC0gMHg5OTk5IHRvIDB4MDIwOSAtIDB4MDIwOT8/IAo+T3IgY2FuIHlvdSBzdWdnZXN0
IGEgcmFuZ2UgdGhhdCBkb2VzIG5vdCBpbmNsdWRlIDB4MDMxMD8KPgo+QWxhbiBTdGVybgoKT2Yg
Y291cnNlLCB3ZSBjYW5ub3QgaGF2ZSB0d28gcXVpcmtzIG9uIGRldmljZXMgd2l0aCB0aGUgc2Ft
ZSBQSUQgYW5kIFZJRC4gCkhvd2V2ZXIsIHNpbmNlIHdlIGRvIG5vdCBoYXZlIHRoZSBJTklDLTMw
NjkgVVNCIGRldmljZSBoZXJlLCB3ZSBjYW5ub3QKZGV0ZXJtaW5lIGhvdyB0byBuYXJyb3cgZG93
biB0aGUgc2NvcGUuIEFzIHlvdSBzdWdnZXN0ZWQsCml0IHdvdWxkIGJlIGJlc3QgdG8gbmFycm93
IHRoZSBiY2REZXZpY2UgcmFuZ2UgdG8gMHgwMjA5IC0gMHgwMjA5LgoKQ2hlbiBDaGFuZ2NoZW5n
Cgo=


