Return-Path: <linux-kernel+bounces-624976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA2AA0AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 13:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68953176415
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E922C1787;
	Tue, 29 Apr 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HwF8svZP"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC526FDA7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927782; cv=none; b=VpoL6bhKfz/4quyf7E/Xcg4bIuaA5Kxa2mFTpslFED6oztwDdZqwEfENQLJqWKcMGDJMww12SAUOU20Ic5c02G9+Q5v0ZzoAm1pk6Hy9Y7fsQntkO8KgLoB1baow5lBTCbjM2VQZVgwe0+sGfnXQ42cPqhWZuMPbSRmQzFP1ZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927782; c=relaxed/simple;
	bh=/DLXevGhyfap/70SzhKIg9RjdZhXXFEs1UB6viXtLRE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B1ngtHa7wx6LJTZqv7ZMhfCkElcrJyiPTtX6Dx7VhXLA/vTPlP8JLhg8oJoLpzAhdkyZq2+hVej5NuazwsUjCiCPlyGCPW5befET41Qzu+dM367uu652AFuu/Z28zgrjRrtz8ce+7mYwC2LXANE24wL6tY1qydQns4T3xvU+kkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HwF8svZP; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745927767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdVSQ9hJnUiFysWlOa0SsVj55N45zfI2LhyhuRAbyMA=;
	b=HwF8svZPZ+JdV/OZsXJ1Em5ZU+7hUzwNJpym+yQzK7vY24zFPzeLzy4/2R2eAJAVlgC4kQ
	NLPQgEHQetzjXlR2LSOIZKP2EYarCDvr1ABsUIaQPuQykDvf83t00EOKI2KiFkV3mm+hX/
	E8MIBuolHV5IvX8lAi+ozaJ6A7O3tcs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <A6D52C12-29BF-4A51-B677-584EFC4F3823@linux.dev>
Date: Tue, 29 Apr 2025 13:55:53 +0200
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF33DB16-407A-4A09-8FF8-E216A2B231C4@linux.dev>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
 <785391F0-C381-47FE-89E7-6265F7761208@linux.dev>
 <202504071119.DB9497A510@keescook>
 <A6D52C12-29BF-4A51-B677-584EFC4F3823@linux.dev>
To: Peter Rosin <peda@axentia.se>
X-Migadu-Flow: FLOW_OUT

Peter?

On 13. Apr 2025, at 14:42, Thorsten Blum wrote:
> On 7. Apr 2025, at 20:20, Kees Cook wrote:
>> On Fri, Mar 07, 2025 at 12:32:07PM +0100, Thorsten Blum wrote:
>>> On 3. Mar 2025, at 19:44, Kees Cook wrote:
>>>> On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
>>>>> Convert mux_control_ops to a flexible array member at the end of =
the
>>>>> mux_chip struct and add the __counted_by() compiler attribute to
>>>>> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>>>> CONFIG_FORTIFY_SOURCE.
>>>>>=20
>>>>> Use struct_size() to calculate the number of bytes to allocate for =
a new
>>>>> mux chip and to remove the following Coccinelle/coccicheck =
warning:
>>>>>=20
>>>>> WARNING: Use struct_size
>>>>>=20
>>>>> Use size_add() to safely add any extra bytes.
>>>>>=20
>>>>> Compile-tested only.
>>>>=20
>>>> I believe this will fail at runtime. Note that sizeof_priv follows =
the
>>>> allocation, so at the very least, you'd need to update:
>>>>=20
>>>> static inline void *mux_chip_priv(struct mux_chip *mux_chip)
>>>> {
>>>>      return &mux_chip->mux[mux_chip->controllers];
>>>> }
>>>>=20
>>>> to not use the mux array itself as a location reference because it =
will
>>>> be seen as out of bounds.
>>>>=20
>>>> To deal with this, the location will need to be calculated using
>>>> mux_chip as the base, not mux_chip->mux as the base. For example, =
see
>>>> commit 838ae9f45c4e ("nouveau/gsp: Avoid addressing beyond end of =
rpc->entries")
>>>=20
>>> Since this should work and is well-defined C code according to =
[1][2],
>>> could you give this patch another look or should I still change it =
and
>>> submit a v2?
>>=20
>> I think C is wrong here, but it seems it will continue to =
accidentally
>> work. I personally would like a v3 that fixes this, but I leave it to
>> Peter who is the MUX maintainer...
>=20
> What's your take on this?


