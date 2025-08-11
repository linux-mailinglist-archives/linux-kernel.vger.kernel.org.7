Return-Path: <linux-kernel+bounces-763357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE51B213DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E493BEC69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F52D6E66;
	Mon, 11 Aug 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEOB7j2X"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7C29BDA6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935889; cv=none; b=c4KX7R9DSUE7rsxQpKZiH+97JdmeaCzNMcaKg5xr+XtLSDvV+WvSOb5qP1Q6LATdxaPGQ3kJETKA0njdzYcTwu0gsab5MCWcdeWFkgxsYepTa30RlC4sAqB6kmzNh2XZ5Rbxsc+vdGP1XAhjuyEWRSTV3OzJQtV8ANcEaUB7y1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935889; c=relaxed/simple;
	bh=62O+UBIpCiRijKTrR0BihJr6uwaWc5eliD3lbpm91Lo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i5SfFEfmuqipICGDkxSBQX+sIG5BLQV07XVkUuvLshI/tpWCx+pypi4+RkC7GSq8B8K0tfEfigL9nJOEriF433nu1ZGOeXgHpgS1EoXWf4hI6UZgnErvc7I7FDWF0hGm/sYxj6vy81LG7vL9zNR/W0c7BkSTiA1U0NOPDL6LqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEOB7j2X; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754935875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62O+UBIpCiRijKTrR0BihJr6uwaWc5eliD3lbpm91Lo=;
	b=VEOB7j2XMj/HkOQ3JmkWEGtRdK6BNwegf5QuTu9TV6BkyXCQZznus0J93V66rIP9AQrMtO
	4CSHznEQ/yOG01H4stpraqgEbvzTgxrXTZWjvebgQ7YHR/QNlqQ7Fr/+/7evZ1sUO9o1qQ
	GH6Fyu59s/RGrCFU6bWuq1i/l4mr5w8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in
 vkdb_printf()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
Date: Mon, 11 Aug 2025 20:10:58 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
 <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

Hi Doug,

On 11. Aug 2025, at 19:48, Doug Anderson wrote:
> On Mon, Aug 11, 2025 at 10:04=E2=80=AFAM Thorsten Blum wrote:
>>=20
>> strcpy() is deprecated; use strscpy() instead.
>>=20
>> Use the return value of strscpy() instead of calling strlen() again.
>>=20
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>=20
> It made me a little nervous that you're not checking for the fact that
> strscpy() could return an error code. Without the check you're just
> replacing one type of problem (buffer overflow) with another type (the
> code running with a negative length). IMO in cases like this either
> leave the strlen() in there or check the return value for errors.

Yes, I should have checked the return value or left strlen() as is. This
was actually a last minute "improvement" I should have skipped.

> ...so I looked a little deeper here to see if the buffer overflow was
> actually possible to begin with. Looking, I _think_ this is true:
>=20
> * `cp` is a pointer into `kdb_buffer` (location of first '\n')
> * `cphold` and `cp` are equal at this point.
>=20
> ...so you're guaranteed not to overflow because the destination and
> source overlap. ...but that means we shouldn't have been using
> strcpy() either way. Both strcpy() and strscpy() say that their
> behaviors are undefined if the src/dest overlap. This means that
> really the right fix is to use memmove().

Good catch. I read about the undefined behavior in the function comment,
but never encountered it and haven't really been looking out for it.

> The above is based solely on code inspection w/ no testing. If I got
> it wrong, let me know.

Yes, I just compile-tested it as I didn't expect src/dst to overlap. And
then my last-minute change to strlen() made it even worse. Sorry about
that.

Are you going to fix it using memmove() or should I submit a v2?

Thanks,
Thorsten


