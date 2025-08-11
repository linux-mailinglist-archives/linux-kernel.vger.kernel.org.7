Return-Path: <linux-kernel+bounces-762076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC339B201E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E970116850C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BF2D9EC2;
	Mon, 11 Aug 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="GtL+qPC+"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1E1684AC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901162; cv=none; b=rFCIVml/Tcrd6IKvLYyORN2G6Ac590ACeERUWZrJCVRBgnncBDBBcJ1Tgf6X2XzjuizzZK1mnnpeFOWBsppIhD0Tdr85H5cajninDn55xuphEUKWI4D0V6pr7ffBndN8DdVvN4lT3Vm6k78ywWV+SsJaBfYrUkjqQ4oe0XS2Y9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901162; c=relaxed/simple;
	bh=pcrRTFRj7cbA3cpW+akyQcrb2vmEVONwi8WALRjHB+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cuF9KTy5P+F7feHONafMxBo3bN9a9b+a8QNebD8xo8CETTW4QzBsBoSbP8ORNsos9WjkYXrEg2nAHBukzT82cJLrjURiK/EdFbhYD1uvoUIcYNb2EkjbMugVvfJtTz8tQ9h9N8L3zhAqkYl3Zr+Rh03QfYiv5IMdYIn9Dq7WKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=GtL+qPC+ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=l1urE0nBnDldGpR9OuYBitZPOtsyzKvkEwXiA4ekwMM=; b=G
	tL+qPC+Kg8n+h86joVxD5ZB6slCWg485ACImQ9z5pGDNZYK/M0EQRUdlWmcYIXMI
	C8GcJD5Wj3NqgR0hi2UQ9ekhpbUQ+thsQ8m33IT0jo7OspJESkbZNmAJ3wSlyK+Y
	btjwar6go+J71wJeDHfXbd+hLj/y8O+/9U2NRhGFss=
Received: from fanqincui$163.com ( [124.127.58.139] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Mon, 11 Aug 2025 16:32:19 +0800
 (CST)
Date: Mon, 11 Aug 2025 16:32:19 +0800 (CST)
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
In-Reply-To: <86zfc68exk.wl-maz@kernel.org>
References: <20250807072700.348514-1-fanqincui@163.com>
 <aJXlegQfZTdimS3k@willie-the-truck>
 <3d4011c0.6aaa.198981027d7.Coremail.fanqincui@163.com>
 <86zfc68exk.wl-maz@kernel.org>
X-NTES-SC: AL_Qu2eBvWbvkko7ySZYekXk0wWhOw8Xcexv/0h1IBfPZ00qSTB2TA5dm57NHfH3PmCFgymoQmxeTRT5MtCc5tocb9SQY8C8S+4PR1z5JAFrE/O
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <587b3c08.7e85.19898424fdb.Coremail.fanqincui@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eigvCgD3n5+TqploqnoXAA--.18653W
X-CM-SenderInfo: 5idq1xpqfxxqqrwthudrp/1tbiOhWmpWiZnRfSwwAEsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIG1hcmMsClRoZSBjYWxsYmFjayBmdW5jdGlvbiBpcyBkZXNpZ25lZCBieSB0aGUgZGV2ZWxv
cGVyLiBEZXZlbG9wZXJzIG5lZWQKdG8gdXNlIHRoZSBjYWxsYmFjayBmdW5jdGlvbiB0byBwYXRj
aCB0aGVpciBvd24gbW9kdWxlIGNvZGUuIFVuZGVyCnRoaXMgcHJlbWlzZSwgZGV2ZWxvcGVycyBh
cmUgcmVzcG9uc2libGUgZm9yIHByb3ZpZGluZyB0aGUgY29ycmVjdApjYWxsYmFjayBmdW5jdGlv
bi4KQSBjb3JyZWN0IGNhbGxiYWNrIGZ1bmN0aW9uIGltcGxlbWVudGF0aW9uIGRvZXMgbm90IHJl
cXVpcmUgZnVydGhlcgpwYXRjaGluZy4gRnVydGhlcm1vcmUsIHRoZSBjYWxsYmFjayBpdHNlbGYg
bXVzdCBiZSBleGVjdXRhYmxlLiBJZiB0aGUKY2FsbGJhY2sgZnVuY3Rpb24gaGFzIHByb2JsZW1z
LCB0aGUgbW9kdWxlJ3MgZnVuY3Rpb25hbGl0eSB3aWxsIGJlIGFmZmVjdGVkLgoKRmFucWluCgoK
CgoKCgoKCgoKCkF0wqAyMDI1LTA4LTExwqAxNjowMTo0MyzCoCJNYXJjwqBaeW5naWVyIsKgPG1h
ekBrZXJuZWwub3JnPsKgd3JvdGU6Cj5PbsKgTW9uLMKgMTHCoEF1Z8KgMjAyNcKgMDg6Mzc6MzLC
oCswMTAwLAo+ZmFucWluY3VpwqA8ZmFucWluY3VpQDE2My5jb20+wqB3cm90ZToKPj7CoAo+PsKg
SGnCoHdpbGwsCj4+wqBZZXMswqB5b3XCoGFyZcKgcmlnaHQuwqBUaGXCoGFsdGVybmF0aXZlwqBj
YWxsYmFja8KgZnVuY3Rpb27CoGxpdmVzwqBpbnNpZGXCoHRoZcKgbW9kdWxlLgo+PsKgVGhpc8Kg
Y2FsbGJhY2vCoGZ1bmN0aW9uwqBpc8KgYWN0dWFsbHnCoHNpbWlsYXLCoHRvwqBrdm1fdXBkYXRl
X3ZhX21hc2vCoGluwqBLVk07Cj4+wqAKPj7CoFRoZcKgbW9kdWxlJ3PCoGNhbGxiYWNrwqBmdW5j
dGlvbsKgY2FsY3VsYXRlc8Kgc29tZcKgdmFsdWVzwqBiYXNlZMKgb24KPj7CoHRoZcKgY3VycmVu
dMKgQ1BVwqBmZWF0dXJlc8KgYW5kwqB0aGVuwqBwZXJmb3Jtc8KgdGhlwqByZXBsYWNlbWVudC4K
Pj7CoAo+PsKgVGhlwqAudGV4dC5hbHRlcm5hdGl2ZV9jYsKgc2VjdGlvbsKgaXPCoGFjdHVhbGx5
wqBtYXJrZWTCoGFzwqBTSEZfRVhFQ0lOU1RSwqB8wqBTSEZfQUxMT0MKPj7CoGR1cmluZ8KgY29t
cGlsYXRpb24swqBzb8KgaW50ZXJzZWN0aW9ucygpwqBpbmNsdWRlc8KgdGhpc8Kgc2VjdGlvbsKg
YW5kwqBzZXRzwqBpdMKgYXPCoGV4ZWN1dGFibGXCoGxhdGVyLgo+Cj5JJ23CoHdvcnJpZWTCoHRo
ZXJlwqBpc8KgYcKgY2hpY2tlbi1hbmQtZWdnwqBwcm9ibGVtwqBoZXJlLsKgV2hhdMKgaWbCoHRo
ZQo+Y2FsbGJhY2vCoGl0c2VsZsKgcmVxdWlyZXPCoHBhdGNoaW5nwqB2aWHCoHNvbWXCoG90aGVy
wqBhbHRlcm5hdGl2ZT/CoElzwqB0aGVyZQo+YcKgZ3VhcmFudGVlwqB0aGF0wqB0aGlzwqBhbHdh
eXPCoHBlcmZvcm1lZMKgaW7CoHRoZcKgY29ycmVjdMKgb3JkZXI/Cj4KPglNLgo+Cj4tLcKgCj5X
aXRob3V0wqBkZXZpYXRpb27CoGZyb23CoHRoZcKgbm9ybSzCoHByb2dyZXNzwqBpc8Kgbm90wqBw
b3NzaWJsZS4K

