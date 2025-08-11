Return-Path: <linux-kernel+bounces-762310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CFDB204E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A7C3A83A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9502153F1;
	Mon, 11 Aug 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Njg9IMiu"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC21D8DFB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906288; cv=none; b=ALz3Pf5Mz3RnB5Tzgu9K4EPVjxAXrnRfc/+DMRcWCwBzo3fbTH7708uBFywUJnll09em2mN1ms32vJmX99RYK8Ha3jyHEvH+AJbljbfSeWwoWjIAY7yyqHfPDYaAHC/qF2LtQeM2CSqjFhbfMITZrt19ipp4QPsZT0dJAbDBi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906288; c=relaxed/simple;
	bh=owUx36sFQdfrwcgqsHOKfaL+gmeeLe3P4XTe6826VzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DjmCiDUrH81cBaYMfKocCLcEYmYCxgNj8aZJZA1ilIdeCDo3TZ9KGXzjs6Yn4/KfgyZQ2yS7g8/op0YbH775WZqx/WSVeL3BzJPNA419MCGTQXBifKa4csMdEgVOTx+gV1mJyxluYfPmuDVBibSmGWNkD3LXKDvSxowJsLNcjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Njg9IMiu reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=axFqqKjFyzO6OFlw3DpMgxsX7YxlZlAXL6gBJ6lZ8Kc=; b=N
	jg9IMiu1wRvVSUCqtNG4SCZqS0z25XYU1+v2GaNc3ydbNQVZspUlL3AOCzOo+JIT
	OirBpdEYC35F9SY7byd8lRO12piCfV0hCYsumHd6cmi81r1YnkzIPc4WOGbLjY0r
	/35kd2K+bnWRs9KioAd5kfdr5Wihv3Z0PXGi1W0BxQ=
Received: from fanqincui$163.com ( [124.127.58.139] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Mon, 11 Aug 2025 17:57:44 +0800
 (CST)
Date: Mon, 11 Aug 2025 17:57:44 +0800 (CST)
From: fanqincui  <fanqincui@163.com>
To: "Marc Zyngier" <maz@kernel.org>
Cc: "Will Deacon" <will@kernel.org>, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Fanqin Cui" <cuifq1@chinatelecom.cn>, hanht2@chinatelecom.cn
Subject: Re:Re: [PATCH] arm64/module: Support for patching modules during
 runtime
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <86y0rq8cf8.wl-maz@kernel.org>
References: <20250807072700.348514-1-fanqincui@163.com>
 <aJXlegQfZTdimS3k@willie-the-truck>
 <3d4011c0.6aaa.198981027d7.Coremail.fanqincui@163.com>
 <86zfc68exk.wl-maz@kernel.org>
 <587b3c08.7e85.19898424fdb.Coremail.fanqincui@163.com>
 <86y0rq8cf8.wl-maz@kernel.org>
X-NTES-SC: AL_Qu2eBvWbuUot4iSdYukXk0wWhOw8Xcexv/0h1IBfPZ00qSTB2TA5dm57NHfH3PmCFgymoQmxeTRT5MtCc5tocb/Va24IOkWgsyfdbruvUtXG
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <56b98f57.954f.1989890838d.Coremail.fanqincui@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eigvCgD3V5CYvploBJwXAA--.6776W
X-CM-SenderInfo: 5idq1xpqfxxqqrwthudrp/1tbiQxGmpWiZpAP03wAFsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Cgo+V2VsbCwgeW91IGNhbid0IGtub3cgYWJvdXQgdGhhdC4gV2UgcGF0Y2ggYmFzaWMgcHJpbWl0
aXZlcyBzdWNoIGFzCj5hdG9taWNzLCBzeXN0ZW0gcmVnaXN0ZXIgYWNjZXNzLCBhbmQgcGxlbnR5
IG9mIG90aGVyIHRoaW5ncy4gVGhlc2UKPnRoaW5ncyBuZWVkIHRvIGludGVyb3BlcmF0ZSB3aXRo
IHRoZSByZXN0IG9mIHRoZSBrZXJuZWwuCj4KPkl0J3MgYWxyZWFkeSBkaWZmaWN1bHQgdG8gZ3Vh
cmFudGVlIGluc2lkZSB0aGUga2VybmVsIGl0c2VsZi4gSGF2aW5nCj5pdCBpbiByYW5kb20gbW9k
dWxlcyB3aWxsIGJlIGV2ZW4gaGFyZGVyLgo+CgoKT2theSwgc28gdGhlIGtlcm5lbCBwYXRjaGVz
IHlvdSBtZW50aW9uZWQsIGFyZSB0aGV5IGFscmVhZHkgcGF0Y2hlZAp3aGVuIHRoZSBtb2R1bGUg
aXMgaW5zdGFsbGVkPyBUaGlzIGRvZXNuJ3QgY29uZmxpY3Qgd2l0aCB0aGUga2VybmVsIHBhdGNo
aW5nLgpJIG1lYW4sIHRoZSBzcGVjaWZpYyBwYXRjaGluZyB3aXRoaW4gdGhlIG1vZHVsZSBpcyB1
cCB0byBtZS4gSWYgdGhlCmNoaWNrZW4tYW5kLWVnZyBwcm9ibGVtIHlvdSBtZW50aW9uZWQgZXhp
c3QsIG1vZHVsZSBkZXZlbG9wZXJzCnNob3VsZCBhdm9pZCBpdCBpbiB0aGVpciBvd24gY29kZS7C
oAoKCkkgdGhpbmsgdGhlIGtlcm5lbCBzaG91bGQgcHJvdmlkZSBtb2R1bGVzIHdpdGggdGhlIGFi
aWxpdHkgdG8gcGF0Y2gKdGhlbXNlbHZlcywgcmlnaHQ/CgoKRmFucWluCgoKCgoKQXQgMjAyNS0w
OC0xMSAxNjo1NTo1NSwgIk1hcmMgWnluZ2llciIgPG1hekBrZXJuZWwub3JnPiB3cm90ZToKPk9u
IE1vbiwgMTEgQXVnIDIwMjUgMDk6MzI6MTkgKzAxMDAsCj5mYW5xaW5jdWkgPGZhbnFpbmN1aUAx
NjMuY29tPiB3cm90ZToKPj4gCj4+IAo+PiBIaSBtYXJjLAo+PiBUaGUgY2FsbGJhY2sgZnVuY3Rp
b24gaXMgZGVzaWduZWQgYnkgdGhlIGRldmVsb3Blci4gRGV2ZWxvcGVycyBuZWVkCj4+IHRvIHVz
ZSB0aGUgY2FsbGJhY2sgZnVuY3Rpb24gdG8gcGF0Y2ggdGhlaXIgb3duIG1vZHVsZSBjb2RlLiBV
bmRlcgo+PiB0aGlzIHByZW1pc2UsIGRldmVsb3BlcnMgYXJlIHJlc3BvbnNpYmxlIGZvciBwcm92
aWRpbmcgdGhlIGNvcnJlY3QKPj4gY2FsbGJhY2sgZnVuY3Rpb24uCj4+IEEgY29ycmVjdCBjYWxs
YmFjayBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCByZXF1aXJlIGZ1cnRoZXIKPj4g
cGF0Y2hpbmcuCj4KPldlbGwsIHlvdSBjYW4ndCBrbm93IGFib3V0IHRoYXQuIFdlIHBhdGNoIGJh
c2ljIHByaW1pdGl2ZXMgc3VjaCBhcwo+YXRvbWljcywgc3lzdGVtIHJlZ2lzdGVyIGFjY2Vzcywg
YW5kIHBsZW50eSBvZiBvdGhlciB0aGluZ3MuIFRoZXNlCj50aGluZ3MgbmVlZCB0byBpbnRlcm9w
ZXJhdGUgd2l0aCB0aGUgcmVzdCBvZiB0aGUga2VybmVsLgo+Cj5JdCdzIGFscmVhZHkgZGlmZmlj
dWx0IHRvIGd1YXJhbnRlZSBpbnNpZGUgdGhlIGtlcm5lbCBpdHNlbGYuIEhhdmluZwo+aXQgaW4g
cmFuZG9tIG1vZHVsZXMgd2lsbCBiZSBldmVuIGhhcmRlci4KPgo+PiBGdXJ0aGVybW9yZSwgdGhl
IGNhbGxiYWNrIGl0c2VsZiBtdXN0IGJlIGV4ZWN1dGFibGUuIElmIHRoZSBjYWxsYmFjawo+PiBm
dW5jdGlvbiBoYXMgcHJvYmxlbXMsIHRoZSBtb2R1bGUncyBmdW5jdGlvbmFsaXR5IHdpbGwgYmUg
YWZmZWN0ZWQuCj4KPkV4YWN0bHkuIEhlbmNlIG15IHF1ZXN0aW9uLgo+Cj4JTS4KPgo+LS0gCj5X
aXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUu
Cg==

