Return-Path: <linux-kernel+bounces-774504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E2AB2B34C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5583B17FA55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234C025DCE5;
	Mon, 18 Aug 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="qjbhtzNt"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D1223DDF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552021; cv=none; b=P3sckf88nnl74Q6mCz4E/icLv+pmogi1VgcnQeUHMuNo+YwF1kdMWUjZOGrxiyd6LFxafdsqq+rOI3v8hu8Sr5mT1FRg34+0NOxb+5omJ0nVjDs3QDmHgp1/0kWGByFJ6sEy2l6xHPUqpL0+WJ2qyZK9i29WgnwncMugr87YNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552021; c=relaxed/simple;
	bh=jUuKJMSnsAj8yEfULgTwdpau6FZrf5Blw3WxOj0VXTc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZAr8O0gmWgSZFom2OszxEmrDyY6fbSD6qwYDmi5uol7gxseADnBj5Vv9KH6vTRzV9UjpXu/nuxcVJDAY7oIRuRuPFWDttK4F+nESvvxSHmUjP6yGgrZB3YlzLuoaGvHyKYd9tvYq2m8J5485LJnAu0JDpvd5qyPl1nwFXhgq/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=qjbhtzNt; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755552016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS7+GV2RkpfpXQCCQWs19kWJiga7BQll43I9ak8T6ss=;
	b=qjbhtzNtYArFfyLJniwM9+d4q2aGuf7I1GONVIlMYFZ07i8uuP8Uu5IUUc6KbVdcI9NiNz
	nE3no1ZIpnEQew9ebQPcdszgCsNd4cde4EsHkRl9b4v8lVLxKZ3lJjgVx0lphIGrthxx8Q
	UxqE9t3Oyo3C0STZR4RCKBPDIXooXpgcDeSX/dp+cz4Wb18zUUC7M7ptgxcnrYA+paLu5L
	yXGEubmWIIEIhKCOCdGJhtS2bzQODTKhb4qrTgFtk6BXV3DQssXzjBCH4r2dialzksYGT1
	q0qUv0xOG0PGfj4IgTHSXDsauF8aZfQ6wQwY+gGRlmiw/PYYlqshz1mis8lNig==
Content-Type: multipart/signed;
 boundary=f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 18 Aug 2025 23:20:00 +0200
Message-Id: <DC5V8VGBDFQ8.3SZ2OASX2W75E@cknow.org>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Diederik de Haas" <didi.debian@cknow.org>
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Keith Busch" <kbusch@kernel.org>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp> <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
 <aKN30RVeM3p5NJm1@kbusch-mbp> <DC5UKZ9F6CQZ.2NDFY4S322T2G@cknow.org>
In-Reply-To: <DC5UKZ9F6CQZ.2NDFY4S322T2G@cknow.org>
X-Migadu-Flow: FLOW_OUT

--f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Aug 18, 2025 at 10:48 PM CEST, Diederik de Haas wrote:
> On Mon Aug 18, 2025 at 8:58 PM CEST, Keith Busch wrote:
>> On Sat, Aug 16, 2025 at 04:11:00PM +0200, Diederik de Haas wrote:
>>> On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
>>>=20
>>> The other kernel warning is this:
>>>=20
>>>   nvme nvme0: using unchecked data buffer
>>>=20
>>> The SUBNQN message appears every time, this one appears often, but not
>>> always.
>>
>> That one means you've sent a user space passthrough command to a device
>> that doesn't support SGL DMA. Without that, the nvme protocol uses
>> implicitly sized DMA that the driver can't be sure is accurate. The user
>> could theoretically provide a short buffer that can corrupt memory if
>> done by accident, or be used as an attack vector if done by malicious
>> software.
>>
>> This is also not something to worry about unless you run malicious or
>> buggy software.
>
> I would be surprised if I was running malicious software, but pretty
> much all software has bugs, so that's ofc possible.
> ...
>
> Uninstalled the 3 programs from R5S that showed up the most around the
> warning message and it's still there.=20
> Would 'dyndbg' be helpful to determine what program is buggy?
 =20
Looks like I found the 'winner': udisks2 (package)

I uninstalled that and in the 10 boots after that, I did not see the
message. Installed it again (without Recommends) and it was back on the
first (re)boot.

Thanks!

Cheers,
  Diederik

--f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKOZCAAKCRDXblvOeH7b
bvlxAP9OjZ2a9vOVVf9jUCjeLoX2b1h1ZPtA6pVUfgGRKEx2JQEAhzTpzmfiuU85
rMxVDHRZfDaHjgVp1YoYZZLYJEOp9wE=
=EcQA
-----END PGP SIGNATURE-----

--f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345--

