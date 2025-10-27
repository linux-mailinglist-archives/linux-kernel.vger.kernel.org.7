Return-Path: <linux-kernel+bounces-872096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5DC0F3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBF9234DC82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20030EF81;
	Mon, 27 Oct 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kB8jEMs4"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D72F744A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582195; cv=none; b=OYshKPeviqTSPuzcsUxv1Ja1qpJHmqfMRlewcDLu/fuEgcxlX1+Q1ZdBE72yYPcGyJnbTA3S/HH4PST94/WjCZxDktU8+CeKjRkivJuvEaLJyiw+mXRWOxNg6AqOpSPkb9ac8/Omx+KMs7wgKG31xmSZOVB3Bq6+wleujeZSLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582195; c=relaxed/simple;
	bh=Jelz6I4WuPxrY/RAWSkqZ9oeGLuIlocAzAleSI9eqKk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GhuIfPkeh11UXHEsac4Yt+83KIgvdSKv+GMn8ZsoIrt6qFaWCOjz4kNcsws7p1MZ9TJSF1sVzCkOG/3nZp+r9iJYe+lBxWHAiMXus63ctYhvI+SY+8OXzmIvyc40MCcz5U2zjmZB2kWKy4tKI1njnow2jwDRhsSfWQ3aFErb39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kB8jEMs4; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761582191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoyyB79oRMCcpGut9Qsij+6WxAVhCrAZdlg/NT9G6oY=;
	b=kB8jEMs47CnmCJnxfeHdeQBzEyeTI4zRgkelmRGItw+UaYUH5UpEXamft8s+e5mO3MyS7U
	vF8OMR2fcDJaPHwQ9W+RjLny21e4SVZTwWIvfl/Y1c3SS6JpYlHtsR/gVGqjRu0UbcKYil
	3qCkkH9CJ705pimCYM+eFQSk77GPUxw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: x86/smpboot: Question regarding native_play_dead() __noreturn
 warning
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <4be37a6a-0a04-48f8-9399-25ecb4638cdc@redhat.com>
Date: Mon, 27 Oct 2025 17:23:02 +0100
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org,
 x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <58486755-0AA7-47DC-B914-1DF92483F69E@linux.dev>
References: <47A8B84B-2685-4DA2-B39B-E55812374426@linux.dev>
 <20251027125045.GX4067720@noisy.programming.kicks-ass.net>
 <4be37a6a-0a04-48f8-9399-25ecb4638cdc@redhat.com>
To: Waiman Long <llong@redhat.com>
X-Migadu-Flow: FLOW_OUT

On 27. Oct 2025, at 16:48, Waiman Long wrote:
> On 10/27/25 8:50 AM, Peter Zijlstra wrote:
>> On Mon, Oct 27, 2025 at 01:23:02PM +0100, Thorsten Blum wrote:
>>> [...]
>> I'm not sure either, it wasn't there in v2 but appeared in v3.
>>=20
>> v2: 20230620140625.1001886-3-longman@redhat.com
>> v3: 20230622003603.1188364-2-longman@redhat.com
>>=20
>> The difference is that v2 tried to restore the msr after 'play_dead'
>> which is silly, since it would never reach that code. v3 removed that
>> dead restore code and added the confusing comment.
>>=20
>> There is a clue here though:
>>=20
>>  20230622054053.uy577qezu5a65buc@treble
>>=20
>> Josh suggests play_dead() should be marked noreturn (which it is in
>> current kernels).
>>=20
>> Waiman then replies:
>>=20
>>  921e1b98-af36-1f51-5abe-dea36425b706@redhat.com
>>=20
>> which is utterly confused again.
>=20
> I don't remember exactly how I got the warning when __noreturn is =
added to native_play_dead(). It may be a limitation of the objtool or =
gcc that I was using at that time. If Thorsten doesn't have problem =
adding __noreturn, I won't mind him doing that and taking out the the =
comment. We can see if there is other issue coming up in the future.

Thanks for the quick replies!

I submitted the patch adding __noreturn here:

=
https://lore.kernel.org/lkml/20251027155107.183136-1-thorsten.blum@linux.d=
ev/


