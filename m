Return-Path: <linux-kernel+bounces-864912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00ECBFBD50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886E71A04080
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17623431F6;
	Wed, 22 Oct 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DL8vOTwA"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53833EB10
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135800; cv=none; b=to/IP3tP/W/gW870Pbw5psR/JkR0ILtPynPvTye1yjYB9pbFV4ajapPEFZssJOnlGLYXKI5f9rH8EE2aaig8BYY3/omnSk7FzLTufVGY67fmkjY1WxjZPlW3kYwh8B0H4q2CJT6l43MU7y3tKiQwjSJOiCNvCoblgw5QWV0l4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135800; c=relaxed/simple;
	bh=JktCQkI6ynd7sl6DFIF72HeqeQ7e4o9Q2QQ2jWvW24k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IW6IaCGHD0gR/hubQhiehjKJBzvF+ETXhsUkwbyvPERshyfVXyzSIrM5aMPMT8UElz286ASFNkMwyORT7f/GopqrM1pmwQtgSh9ocoP4GR7pdo1jXzG1va1g+NOvLArVOITcPj5C29nL9J7OaDhtkub4unYJr3W2na26Bz33+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DL8vOTwA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761135786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXBQTo0YxNH0AV9Ylz3QmVWC6p5HiT23uJ/brCIeGUs=;
	b=DL8vOTwA6JGAsocBBgFYuTlHJ1nULMgtmBemuRIogJmHoIGvl1xHJefWWth3GrnzYuDkdg
	imI+9m0fOBjUNVHKbHntErgui7/2DOr1DvLHoLDVtEwZ2whCjxv23Jh+NoQCqLlvUFYhM2
	Apy/yIhb5R9ecdIRRbu10t86/0qW9GA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] crypto: asymmetric_keys - prevent overflow in
 asymmetric_key_generate_id
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aO0dJeqb9E99xVvD@wunner.de>
Date: Wed, 22 Oct 2025 14:23:02 +0200
Cc: David Howells <dhowells@redhat.com>,
 Ignat Korchagin <ignat@cloudflare.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Vivek Goyal <vgoyal@redhat.com>,
 keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <73423731-F3C2-483A-BDAB-3FEF5471B8EA@linux.dev>
References: <20251013114010.28983-2-thorsten.blum@linux.dev>
 <aO0dJeqb9E99xVvD@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Migadu-Flow: FLOW_OUT

Hi Lukas,

On 13. Oct 2025, at 17:39, Lukas Wunner wrote:
> On Mon, Oct 13, 2025 at 01:40:10PM +0200, Thorsten Blum wrote:
>> Use check_add_overflow() to guard against potential integer overflows
>> when adding the binary blob lengths and the size of an asymmetric_key_id
>> structure and return ERR_PTR(-EOVERFLOW) accordingly. This prevents a
>> possible buffer overflow when copying data from potentially malicious
>> X.509 certificate fields that can be arbitrarily large, such as ASN.1
>> INTEGER serial numbers, issuer names, etc.
>> 
>> Fixes: 7901c1a8effb ("KEYS: Implement binary asymmetric key ID handling")
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thank you for your review.

I removed stable@ after your feedback to v2, but shouldn't v3 be applied
to stable as well?

Best,
Thorsten


