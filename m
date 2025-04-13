Return-Path: <linux-kernel+bounces-601754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EE5A871F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCC7A4016
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601A1B0406;
	Sun, 13 Apr 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpL7bDRa"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C74F1A314F
	for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744548187; cv=none; b=gU1vHkq8yChPgVZEvdQ7f4e8NZSVp29uAbuYU5fW6AWt/HrcDm2CPetx6wLwbx6bq8wmKnBYg9P5OJgzgO3T2M/t3Ha1OBjHvqbUhcPgqdBvWBYQg48BAc0Z8pX2ilu/Od8xjqVYmh4guNMK410qpgBBwV3SnYyFMov1NVfvNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744548187; c=relaxed/simple;
	bh=YBVrP0ioAfqFi7HGGInQPXg0PMtVOG28MGA1HhQi8zU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bfYIWG64NxUiSUDSATqHNDF7dTz0YTfV0qD3/mj85/qVkFD3BzVhknnWy5FOAYIMU8454h1wyzJZtKJHnYKeagPTP+t+d/cGh7/wUHj/uVyw2ejdT4w1FN00eOndhvx9SVzXCwHYj53thJ6A3sDrFpxiEAV9Oh3I1AuxRbb/8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpL7bDRa; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744548181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+g3tIT1J01F3PNxqjXfPswRzwcT32eu6uks0bITlMTA=;
	b=cpL7bDRajhjTosoM/A/fZJh05HWg4SwWQJXrUDdpyQJcFJsGx6U0DrUQz/CglF16Z2pEIy
	OcnHAUecAcd1vH7w5NRQW9GqqXSPOGhidBrIJwF/WuxptPTZGtPC6xTvqnOCXvNRQrYh64
	y7k/djtKeN+CJbTOXaMomUe0ajizRGY=
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
In-Reply-To: <202504071119.DB9497A510@keescook>
Date: Sun, 13 Apr 2025 14:42:49 +0200
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6D52C12-29BF-4A51-B677-584EFC4F3823@linux.dev>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
 <785391F0-C381-47FE-89E7-6265F7761208@linux.dev>
 <202504071119.DB9497A510@keescook>
To: Peter Rosin <peda@axentia.se>
X-Migadu-Flow: FLOW_OUT

Hi Peter,

On 7. Apr 2025, at 20:20, Kees Cook wrote:
> On Fri, Mar 07, 2025 at 12:32:07PM +0100, Thorsten Blum wrote:
>> On 3. Mar 2025, at 19:44, Kees Cook wrote:
>>> On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
>>>> Convert mux_control_ops to a flexible array member at the end of =
the
>>>> mux_chip struct and add the __counted_by() compiler attribute to
>>>> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>>> CONFIG_FORTIFY_SOURCE.
>>>>=20
>>>> Use struct_size() to calculate the number of bytes to allocate for =
a new
>>>> mux chip and to remove the following Coccinelle/coccicheck warning:
>>>>=20
>>>> WARNING: Use struct_size
>>>>=20
>>>> Use size_add() to safely add any extra bytes.
>>>>=20
>>>> Compile-tested only.
>>>=20
>>> I believe this will fail at runtime. Note that sizeof_priv follows =
the
>>> allocation, so at the very least, you'd need to update:
>>>=20
>>> static inline void *mux_chip_priv(struct mux_chip *mux_chip)
>>> {
>>>       return &mux_chip->mux[mux_chip->controllers];
>>> }
>>>=20
>>> to not use the mux array itself as a location reference because it =
will
>>> be seen as out of bounds.
>>>=20
>>> To deal with this, the location will need to be calculated using
>>> mux_chip as the base, not mux_chip->mux as the base. For example, =
see
>>> commit 838ae9f45c4e ("nouveau/gsp: Avoid addressing beyond end of =
rpc->entries")
>>=20
>> Since this should work and is well-defined C code according to =
[1][2],
>> could you give this patch another look or should I still change it =
and
>> submit a v2?
>=20
> I think C is wrong here, but it seems it will continue to accidentally
> work. I personally would like a v3 that fixes this, but I leave it to
> Peter who is the MUX maintainer...

What's your take on this?

Thanks,
Thorsten


