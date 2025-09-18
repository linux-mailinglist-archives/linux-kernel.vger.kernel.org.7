Return-Path: <linux-kernel+bounces-771072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E817B2827F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 987F57A6BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975F25A357;
	Fri, 15 Aug 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rhedae3z"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E872627
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269795; cv=none; b=W26ymzVGdhvQ9C+hpxZzexepi39rzQ0U+yHtjvGqxyl+hmxqbyBdV+jY2qw7RSebt9ltHHa4xeWy5zxcGU2PQK1BOTV1CdC+8g6hbbacKQRgFG+Iu2jWNZoT4nzx51LDpo36WEBPebsRWINfk7itXskOWbYsCWmz3hH2maMrYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269795; c=relaxed/simple;
	bh=Z0IxvlccnND+KQN19QU2Hgz+az1DiQsWroDVaRn2z3U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dVoAOysvbttUdVGu98VcCA+XRqGN9BxF7t0lCYGFB9HTDIZpnzCnIDmZV9ZVBULmU7VI/EqHSPmy5P6OW2dMhM6KiK/7p7AjN4QbJFNcuwltN7QP1uguDQnyaT+sLf4Dd9tD/M1D5PYwIOSKHqYqvyRgTlmNfwyHB0Pkcomy7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rhedae3z; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755269789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO/NMrOOJsCUxzXi4PFLCqafJKvLz1U8/IZO86D4VWc=;
	b=Rhedae3zw3544LC+J6FpREy9XeHoWhWna2YV0J9kxTrjztx/L77Dm1kANMw1l5BhGOGQHu
	5uwwi18hP81//5cpGQTp7zib26vEhLeHUX2yOEKOEkUBvEyc2zw0YV8wxmqOiC6K5NDYRQ
	hE8OoPQoN0jF7RNQYI6XvIs9MS8aUr4=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] kdb: Replace deprecated strcpy() with memmove() in
 vkdb_printf()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aJ9E_W4Z0n7EzjUw@aspen.lan>
Date: Fri, 15 Aug 2025 16:56:14 +0200
Cc: Doug Anderson <dianders@chromium.org>,
 Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <46710CF0-8AAA-464F-931D-BE809D0DDBE6@linux.dev>
References: <20250812132621.119641-3-thorsten.blum@linux.dev>
 <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>
 <aJ9E_W4Z0n7EzjUw@aspen.lan>
To: Daniel Thompson <daniel@riscstar.com>
X-Migadu-Flow: FLOW_OUT

On 15. Aug 2025, at 16:32, Daniel Thompson wrote:
> On Tue, Aug 12, 2025 at 09:24:55AM -0700, Doug Anderson wrote:
>>=20
>> On Tue, Aug 12, 2025 at 6:27=E2=80=AFAM Thorsten Blum wrote:
>>>=20
>>> strcpy() is deprecated and its behavior is undefined when the source =
and
>>> destination buffers overlap. Use memmove() instead to avoid any
>>> undefined behavior.
>>>=20
>>> Adjust comments for clarity.
>>>=20
>>> Link: https://github.com/KSPP/linux/issues/88
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>> Changes in v2:
>>> - Use memmove() because of strcpy()'s undefined behavior with
>>>  overlapping buffers as suggested by Doug Anderson
>>> - Compile-tested only
>>> - Link to v1: =
https://lore.kernel.org/lkml/20250811170351.68985-1-thorsten.blum@linux.de=
v/
>>> ---
>>> kernel/debug/kdb/kdb_io.c | 14 ++++++++------
>>> 1 file changed, 8 insertions(+), 6 deletions(-)
>>=20
>> Much nicer, thank you!
>>=20
>> Given that the old code was officially relying on undefined behavior
>> of strcpy() before, I'd personally even add:
>>=20
>> Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
>>=20
>> In any case:
>>=20
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>=20
> LGTM... and I agree that this is bug rather than a clean up so am
> waiting to hear back on the Fixes: .

Yes, the Fixes: tag is fine, of course. Thanks!

How about backporting this to stable?

Best,
Thorsten


