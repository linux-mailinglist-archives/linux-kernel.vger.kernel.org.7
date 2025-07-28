Return-Path: <linux-kernel+bounces-748557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D0B142A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6174D7ADDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF122A4F6;
	Mon, 28 Jul 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qJ9qEawZ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2D1FC0E2;
	Mon, 28 Jul 2025 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732354; cv=none; b=UlIoigw/+F7SZGurUPL65/Mu4SNFlFgpUbNNwBm7oS7KCWAHyn8VwqM4SX0q3y2twdoTS1WRtc/TDwElycFXMKyXJ+XR1kr/A08KmMtlHwT2iWSU+N/P80aZfSA88rEFauvDgifCzxkFWMtkEHPA9svU6iwpw6EVBcRe464QmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732354; c=relaxed/simple;
	bh=09P3yCEpacc3WDalIzSbr2UF8KnwRKgzIsPGtlWljfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=li5Et5KUIUkfuvaKGq7LC0b9ZYUVyOs7r6vxexsVDlEURaO2SqYRmX4l4x3tNptWKsURB8Ms739sllntef4TKh5qK4S/odWWlXHXhmSVnaIzDtp3AAiUeVwgyopE3W56uuQqSoowwSjeNtq319//lGCxPPIx/U5TC/SMOXt/nvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qJ9qEawZ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0B62340AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753732352; bh=p0Qxnvd1AgjyaWlP/R22ncSoW42OkFWOvQkgj5NJMv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qJ9qEawZZl39PWLPwAjoqnBTl8ibX/X2wi6gu4iuLKbkzJMiVfEsunBondL7uNh0X
	 Ff6t6VqrKa5eYWMDF+wRDxsL8TXldb26QRXIiFGIrL4RW6mvXqKuz4Qp9gBShfXd8X
	 AdE1bLJoRRXD4UYBSy7iO44bViJ+r3sKP5VPAZopXSwtfa2XjhL+5DK/tKqxscIYsC
	 pq9eW9BW+8e5GoKssObR+rcRHzSxSP5mC4g4gFnqvhDZOSKvSAda21VLZdYgfYpT2h
	 OHBrAkq+Pu9ULsFS/Clc/vLp/YbD+H8Mc2Iw+k/ngeLinslnGlYsFwvoIiUW2zZ53o
	 eTRj8VaQUtTnQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0B62340AD0;
	Mon, 28 Jul 2025 19:52:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: update to current minimum pipe size
 default
In-Reply-To: <20250728193030Z.1636311400-stepnem@smrk.net>
References: <20250728-pipedoc-v1-1-2dae082a56f5@smrk.net>
 <87seigxhf5.fsf@trenco.lwn.net>
 <20250728193030Z.1636311400-stepnem@smrk.net>
Date: Mon, 28 Jul 2025 13:52:31 -0600
Message-ID: <87fregxfcw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> On Mon, 28 Jul 2025 13:07:58 -0600
> Jonathan Corbet wrote:
>
>> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:
>>
>>> Fixes: 46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 pag=
es")
>>> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
>>> ---
>
> [...]
>
>> This seems like a reasonable change, but can I ask you to resubmit it
>> with a proper changelog, please?
>
> Do you mean a better/longer commit message?
>
> I felt that the Subject: and Fixes: says it all and didn't
> want to duplicate information (contained in its commit
> message and comments added by that change, as well as the
> very paragraph we're updating here).
>
> Would adding something like
>
>   The pipe size limit used when the fs.pipe-user-pages-soft
>   sysctl value is reached was increased from one to two
>   pages in commit 46c4c9d1beb7; update the documentation to
>   match the new reality.
>=20=20=20
> work?

Yes, that is what I had in mind.  Patches should always explain
themselves without making people chase down Fixes tags and such.

Thanks,

jon

