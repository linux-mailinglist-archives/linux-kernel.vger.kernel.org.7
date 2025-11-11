Return-Path: <linux-kernel+bounces-895690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D460CC4EAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A713B96B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D283246F1;
	Tue, 11 Nov 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YROBioLA"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AE2F8BFC;
	Tue, 11 Nov 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873148; cv=none; b=KnxOiZOI2oL0loShCSET2/S506+zgCVlqGB+Hspa97fx1bdZjGP+AD03VdYqGOUgsN5WPaN0Zeld2g4Y4Nlsm3I5YmaNN4PvQRDgw7XdRfq2i/aHmIT/RyXSW2yF1eNQIgvAQdnOAF88EhFmJVE9qlBydyVHtmZWKobKXdEW+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873148; c=relaxed/simple;
	bh=6UZChHAC0qxXYjOew77+2kNmv0s0bBFbiBPtdUIsNUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BoR7vLWDJeXzw+mzd7bSK5nT3ihLighuuvH6JsDrgE86xhXoE4J5rZd0AogW0RcvdmmYhkHkLngib04EyUg3UmrVtsFVI/abhmoL60voUdAurhL1rZ/laFfdFXIgrk27mkWsPE6viaO4V2/jlxDz9CKjmskNuYQZoehQ645oEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YROBioLA; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d5V6Z4kw3z9tSc;
	Tue, 11 Nov 2025 15:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762873142; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UZChHAC0qxXYjOew77+2kNmv0s0bBFbiBPtdUIsNUE=;
	b=YROBioLAwsRGqqvjrbVm3WmN5azGCc/jpJj02OYWEtcnT8E2OxeAaINt8hQJmPqk9YyR/7
	5Acigf/k3shy17VSKS1J0OSu2bnkUKQxAYYs3ws59pGPTEqr9Q5iQAn4EryC5p84vd3Kmq
	X2why6B+Syjae8kZL8/9ljKDnxXm0HE28HlDmgnYITHzhTPRA6oNf3QRq6/2tGj4S44O+2
	eXivIEtxmHijtiDykVFYJ2YusNg3pKTJJf6UWcUMhtEF5aunFWzDtTZXEznbIqp62Ygad2
	9BK+igSOpjSRQ1XFq7sW5jNj3ym+9axdZHQN8s5jlW1GdExyN/TfbLNo2JnWbQ==
Message-ID: <ba5b52e1f0b9460df0e976f21e4e34113f560694.camel@mailbox.org>
Subject: Re: [PATCH v1 1/2] devres: Remove unused devm_free_percpu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	 <phasta@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>
Date: Tue, 11 Nov 2025 15:58:59 +0100
In-Reply-To: <20251111144104.910241-2-andriy.shevchenko@linux.intel.com>
References: <20251111144104.910241-1-andriy.shevchenko@linux.intel.com>
	 <20251111144104.910241-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: yi6bxtibds8qziy8a9c4oqd7q13uut7z
X-MBO-RS-ID: ca91ffdfe3d225047f5

T24gVHVlLCAyMDI1LTExLTExIGF0IDE1OjM5ICswMTAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gUmVtb3ZlIHVudXNlZCBkZXZtX2ZyZWVfcGVyY3B1KCkuCj4gCj4gQnkgdGhlIHdheSwgaXQg
d2FzIG5ldmVyIHVzZWQgaW4gdGhlIGRyaXZlcnMvIGZyb20gZGF5IDEuCgpJIG1lYW4sIG1vc3Qg
ZGlzaGVzIG9uIGEgcmVzdGF1cmFudCdzIG1lbnUgYXJlIGFsc28gbmV2ZXIgYWN0dWFsbHkKb3Jk
ZXJlZCEKCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gwqAuLi4vZHJpdmVyLWFwaS9kcml2ZXItbW9k
ZWwvZGV2cmVzLnJzdMKgwqDCoMKgwqDCoMKgIHzCoCAxIC0KPiDCoGRyaXZlcnMvYmFzZS9kZXZy
ZXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI1
IC0tLS0tLS0tLS0tLS0tLS0tLS0KPiDCoGluY2x1ZGUvbGludXgvZGV2aWNlLmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxIC0KCkkgdGhpbmsgeW91
IGZvcmdvdCBEb2N1bWVudGF0aW9uLwoKZGV2bV9mcmVlX3BlcmNwdSgpIGlzIG1lbnRpb25lZCB0
aGVyZS4KCgpQLgoK


