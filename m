Return-Path: <linux-kernel+bounces-783889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9263B333E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDACB1B21DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A952253FB;
	Mon, 25 Aug 2025 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jzHPeM6M"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109D28F1;
	Mon, 25 Aug 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756088425; cv=none; b=aZjxcqdOyEd8p0fgQs+PEQj8vIu4E+GSFoyiFe9xQCDS5Prk407gy12BX8ZJ9xOuGnfsjttCtS9VQvwyI6PHECmKNlMVeRGu9gHdvHepIyIUIg7+biqE8S9OASAQYs6dlWltWO4jyu4jVCz9E6rpnm5xv8ggDXs8DrFjcEPJkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756088425; c=relaxed/simple;
	bh=NLBXpdkTGR1++BuR1EyUUOZbQMMlZib74w2PqrVBLkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=eIhi6dj2cYxFmYc4IKxpJ/VOM9PsRc2I4rfBX1xX//8QnTJ/DeAAbpwMmZMU4CpNT8hoF2/VqRNWxGtHAOtprp6rwGtALrg/w7Nl5GUqWdRwsj8MfUx3IJ3qIpyqi/biRKhuaW1WBvmQ9T7IAh49OTR/PESKp9B1wPpm+cgkmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=jzHPeM6M reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=V5sRSh7yg1UXMP+4s0+Wv0rYRYfuN+Dpb8VZccuYtLc=; b=j
	zHPeM6MLD/tM85GUIbq9Ph73R3Fevwc/n96YW9ug+L8wdttYDn0SrBe3fico8xcJ
	Rd5bbbhwl6024CO2TB0mzA23GAaKH0WZWwcA4oAuFm/3fBoMoUaFRXd03y/hJaJ0
	G4bG+CPyfvZU4SniiSLfQZORwp3vy2fwCpw7ZUL0B4=
Received: from ccc194101$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Mon, 25 Aug 2025 10:19:56 +0800
 (CST)
Date: Mon, 25 Aug 2025 10:19:56 +0800 (CST)
From: =?GBK?B?19S8ug==?= <ccc194101@163.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, jannh@google.com, rex.nie@jaguarmicro.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re:Re: Re: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <379c80f7-aa01-4575-aa0b-d64ef01c1346@rowland.harvard.edu>
References: <20250822024602.42894-1-ccc194101@163.com>
 <f159e37f-3b27-4977-9712-345e8902eb48@rowland.harvard.edu>
 <4cdaecd1.131d.198dedeefe2.Coremail.ccc194101@163.com>
 <379c80f7-aa01-4575-aa0b-d64ef01c1346@rowland.harvard.edu>
X-NTES-SC: AL_Qu2eBPyTt0si4CiZZukfmkYVh+06W8K2vvwh24JUOJ94jA3p/B8sUHRSAkXw0O60MD68mgmGXhVg5uN+dJB/UoABr4Ed7vVd5bnQhyiaW/9Tlg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23f1c6c2.2011.198df066c15.Coremail.ccc194101@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:figvCgD33+BMyKtoanYgAA--.571W
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiYw603mirw3EYngACsy
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0wOC0yNSAxMDowMTo0NCwgIkFsYW4gU3Rlcm4iIDxzdGVybkByb3dsYW5kLmhhcnZh
cmQuZWR1PiB3cm90ZToKPk9uIE1vbiwgQXVnIDI1LCAyMDI1IGF0IDA5OjM2OjQ5QU0gKzA4MDAs
INfUvLogd3JvdGU6Cj4+IEF0IDIwMjUtMDgtMjMgMDQ6MzA6MTgsICJBbGFuIFN0ZXJuIiA8c3Rl
cm5Acm93bGFuZC5oYXJ2YXJkLmVkdT4gd3JvdGU6Cj4+ID5PbiBGcmksIEF1ZyAyMiwgMjAyNSBh
dCAxMDo0NjowMkFNICswODAwLCBjY2MxOTQxMDFAMTYzLmNvbSB3cm90ZToKPj4gPj4gRnJvbTog
Y2hlbmNoYW5nY2hlbmcgPGNoZW5jaGFuZ2NoZW5nQGt5bGlub3MuY24+Cj4+ID4+IAo+PiA+PiBX
aGVuIGFuIEFwcGxlIGRldmljZSBpcyBpbnNlcnRlZCBpbnRvIHRoZSBob3N0LCBhbmQgdGhlIGhv
c3QKPj4gPj4gd2FrZXMgdXAgZnJvbSBTMy9TNCBwb3dlciBzdGF0ZXMsIGlmIHRoZSByZXNldF9y
ZXN1bWUgcHJvY2Vzcwo+PiA+PiBpcyB0cmlnZ2VyZWQsIHRoZSBhYnNlbmNlIG9mIGEgcmVzZXRf
cmVzdW1lIGNhbGxiYWNrIGluIHVzYmZzIHdpbGwKPj4gPj4gY2F1c2UgdGhlIGRldmljZSB0byB1
bmJpbmQuCj4+ID4+IEJ5IGFkZGluZyBhIHJlc2V0X3Jlc3VtZSBjYWxsYmFjayB0byB1c2JmcyBh
bmQgcmVwb3J0aW5nIFJFTU9WRSBhbmQgQURECj4+ID4+IHVldmVudHMgaW4gcmVzZXRfcmVzdW1l
LCB0aGUgdXNlcnNwYWNlIGlzIHByb21wdGVkIHRvIHJlaXNzdWUgY29tbWFuZHMKPj4gPj4gdG8g
cmUtZXN0YWJsaXNoIHRoZSBiaW5kaW5nIHdpdGggdXNiZnMuCj4+ID4KPj4gPnVzYmZzIGhhcyBu
byB3YXkgdG8gaW5mb3JtIHVzZXJzcGFjZSB3aGVuIHRoZSBkZXZpY2UgaXMgcmVzZXQuICBUaGlz
IGlzIAo+PiA+dHJ1ZSBmb3Igbm9ybWFsIHJlc2V0cyBhcyB3ZWxsIGFzIGZvciByZXNldC1yZXN1
bWVzIChubyBwcmVfcmVzZXQsIAo+PiA+cG9zdF9yZXNldCwgb3IgcmVzZXRfcmVzdW1lIGNhbGxi
YWNrcykuICBJIGRvbid0IHNlZSBhbnkgcG9pbnQgaW4gdHJ5aW5nIAo+PiA+dG8gYWRkIHN1cHBv
cnQgZm9yIHRoZSBsYXR0ZXIgYnV0IG5vdCB0aGUgZm9ybWVyLgo+PiA+Cj4+ID5VbmJpbmRpbmcg
dGhlIGRldmljZSBmb3JjZXMgdXNlcnNwYWNlIHRvIHJlLW9wZW4gdGhlIGRldmljZSBmaWxlIGFu
ZCAKPj4gPmVzdGFibGlzaCBhIG5ldyBiaW5kaW5nLiAgSG93IGRvZXMgYWRkaW5nIFJFTU9WRSBh
bmQgQUREIHVldmVudHMgbWFrZSAKPj4gPnRoZSBzaXR1YXRpb24gYW55IGJldHRlciB0aGFuIGl0
IGFscmVhZHkgaXM/Cj4+ID4KPj4gCj4+ID5BbGFuIFN0ZXJuCj4+IAo+PiBIZXJlIGlzIG15IHJl
YXNvbmluZzogCj4+IEN1cnJlbnRseSwgZm9yIEFwcGxlIGRldmljZXMgYWZ0ZXIgUzMvUzQgc3Rh
dGVzLCBzaW5jZSB0aGUgVVNCIGh1YiBsb3NlcyBwb3dlciwgCj4+IHRoZSByZXNldC1yZXN1bWUg
cHJvY2VzcyBpcyB0cmlnZ2VyZWQgZHVyaW5nIHJlc3VtZS4gSWYgdGhlIG9yaWdpbmFsIAo+PiBy
ZXNldF9yZXN1bWUgcHJvY2VzcyBpcyBmb2xsb3dlZCwgdGhlIGRldmljZSB3b3VsZCBiZSBmb3Jj
aWJseSB1bmJvdW5kLAo+PiBhbmQgdGhlIGRldmljZV9hdHRhY2ggZnVuY3Rpb24gd291bGQgYmUg
dXNlZCB0byByZWJpbmQgdGhlIGRyaXZlci4KPj4gSG93ZXZlciwgdXNiZnMgaXMgZGlmZmVyZW50
IGluIHRoYXQgaXQgY2Fubm90IGF1dG9tYXRpY2FsbHkgcmViaW5kCj4+IGFmdGVyIHVuYmluZGlu
ZyBhbmQgcmVxdWlyZXMgYSB1c2Vyc3BhY2UgaW9jdGwgdG8gcmUtZXN0YWJsaXNoIHRoZSBiaW5k
aW5nLgo+PiAKPj4gSWYgd2UgYXNzdW1lIHRoYXQgdGhlIHJlc2V0X3Jlc3VtZSBjYWxsYmFjayBv
ZiB1c2JmcyBkb2VzIG5vdGhpbmcKPj4gYW5kIHNpbXBseSByZXR1cm5zIDAsIHRoZSBVU0IgZGV2
aWNlIHdvdWxkIHN0aWxsIGJlIHJlc2V0LiBXaGVuIHVzZXJzcGFjZQo+PiB1c2VzIHRoZSBwcmV2
aW91cyBmaWxlIGRlc2NyaXB0b3IgaGFuZGxlIHRvIGlzc3VlIGEgY29tbWFuZCwgaXQgd291bGQg
cmVzdWx0Cj4+IGluIGFuIGVycm9yOiAiUFRQX09DIDB4MTAwNyByZWNlaXZpbmcgcmVzcCBmYWls
ZWQ6IFBUUCBTZXNzaW9uIE5vdCBPcGVuICgweDIwMDMpLiIKPj4gCj4+IFRoZXJlZm9yZSwgYnkg
YWRkaW5nIFJFTU9WRSBhbmQgQUREIHVldmVudHMgaW4gdGhlIHJlc2V0X3Jlc3VtZSBwcm9jZXNz
LAo+PiB1c2Vyc3BhY2UgaXMgbm90aWZpZWQgdG8gZmlyc3QgdW5iaW5kIGFuZCB0aGVuIHJlYmlu
ZC4gVGhpcyBhcHByb2FjaCBhdm9pZHMgdGhlIGFmb3JlbWVudGlvbmVkIGlzc3VlLgo+Cj5Eb2Vz
bid0IHRoZSAiUFRQIFNlc3Npb24gTm90IE9wZW4iIGVycm9yIG5vdGlmeSB1c2Vyc3BhY2UgdG8g
dW5iaW5kIGFuZCAKPnJlYmluZD8gIFdoeSBpcyBhZGRpbmcgUkVNT1ZFIGFuZCBBREQgdWV2ZW50
cyBhbnkgYmV0dGVyPwo+Cj5JbiB0aGUgY3VycmVudCBrZXJuZWwgdGhlcmUgaXMgbm8gcmVzZXRf
cmVzdW1lIGNhbGxiYWNrIGZvciB1c2Jmcy4gIAo+Q29uc2VxdWVudGx5LCB3aGVuIHVzZXJzcGFj
ZSB1c2VzIHRoZSBwcmV2aW91cyBmaWxlIGRlc2NyaXB0b3IgaGFuZGxlIHRvIAo+aXNzdWUgYW4g
aW9jdGwgY29tbWFuZCBhZnRlciBhIHJlc3VtZSwgaXQgZ2V0cyBhIC1FTk9ERVYgZXJyb3IuICBE
b2Vzbid0IAo+dGhpcyBhbHNvIG5vdGlmeSB1c2Vyc3BhY2UgdGhhdCBpdCBzaG91bGQgdW5iaW5k
IGFuZCByZWJpbmQ/ICBXaHkgaXMgCj5hZGRpbmcgYSByZXNldF9yZXN1bWUgY2FsbGJhY2sgYW55
IGJldHRlcj8KPgo+QWxhbiBTdGVybgoKQWNjb3JkaW5nIHRvIHRoZSBjdXJyZW50IGV4cGVyaW1l
bnRhbCBmaW5kaW5ncywgd2hlbiB1c2Vyc3BhY2UgZW5jb3VudGVycwphbiBlcnJvciB3aGlsZSB1
c2luZyB0aGUgcHJldmlvdXMgZmlsZSBkZXNjcmlwdG9yIChmZCksIGl0IGRvZXMgbm90IHByb2Nl
ZWQgdG8gdW5iaW5kCmFuZCByZWJpbmQgYXV0b21hdGljYWxseS4gVGhlcmVmb3JlLCB0aGUgdHdv
IHVldmVudHMgd2VyZSBhZGRlZCBpbiB0aGUga2VybmVsIHRvIGV4cGxpY2l0bHkKbm90aWZ5IHVz
ZXJzcGFjZSB0byB1bmJpbmQgYW5kIHJlYmluZC4KCkNoZW4gQ2hhbmdjaGVuZwo=

