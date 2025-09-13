Return-Path: <linux-kernel+bounces-815201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE214B56128
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B76480B46
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E22F361D;
	Sat, 13 Sep 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l/ps5pxY"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55532EC54F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770242; cv=none; b=sG2g0WLNU9c9g14i2PLXa9zzvi+CCq3VdkOYXT0Ph4bPHj86KhEqx+N0KwTePhhYoUgSFPPQ30YaMrGVmX8N36Wx2L2qOkg3o/ULkH3PoDfTpfrw6gYPwK3uQBPc6n0Yifx1gFPcxoSQe9VdXRH+6/bSxcbFYhiCzK+w+bypL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770242; c=relaxed/simple;
	bh=R+EwJWUL37Dd0XJ17zi8pxpqIyS/lb7ojPwcQ9X/6GY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K54qndYiIS/DD3KHNwjxBR16obAvSsMNEQgK7C/HvFEj/ISjXKQj/LH4WCRAxMNk4Ig2fyzWgKwtMa1+UVfjuYZyAzL0iSnbPCf4ZR/ZYMqvS3Q9Tv75Virf6qNvqjg4GyvgAcx4Q99sLGYMb0say751HlELUpqnWJbC77zv154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l/ps5pxY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757770228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+EwJWUL37Dd0XJ17zi8pxpqIyS/lb7ojPwcQ9X/6GY=;
	b=l/ps5pxYqVJaXQHQrGP0VRKQYuNIAxNGZ4QgWm/WIW8p3BHTkv1aMRjc1cX2FkWAW6Zo53
	LRKEKod2HD6y6WeMMAtIR3Iflf0b1zPaK9yPuRdnBehoxMZpntvbLFX+Yqk7PB6ZVxB9hL
	DwnS3nKDRP7U8eh1JEJ3j58/D6AKVOM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] initrd: Remove unnecessary goto label 'successful_load'
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <o2ijjlbcicrrfflp54o53sj5v6morqedtkkzizhhyvl6cqvezw@yl7hx3naojcn>
Date: Sat, 13 Sep 2025 15:30:15 +0200
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <41D6E945-CB4B-4AE4-9ED7-277B59E9DC32@linux.dev>
References: <20250913121514.1789204-1-thorsten.blum@linux.dev>
 <o2ijjlbcicrrfflp54o53sj5v6morqedtkkzizhhyvl6cqvezw@yl7hx3naojcn>
To: Klara Modin <klarasmodin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 13. Sep 2025, at 15:11, Klara Modin wrote:
> On 2025-09-13 14:15:14 +0200, Thorsten Blum wrote:
>> The goto label 'successful_load' isn't really necessary. Set 'res =3D =
1'
>> immediately and let 'goto done' handle the rest.
>>=20
>> No functional changes.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> ...
>=20
> This is now the only place where res will be set to 1.

Sorry my bad.

> This does not seem correct? After this patch res is not updated to 1 =
anymore
> if execution reaches here without taking another goto, i.e. the return
> value is changed by this patch.

Thanks, I agree that it doesn't make sense. I only intended to delete
the label, not the 'res =3D 1'.

Please ignore this patch (unless someone thinks removing the goto label
is worth a v2) and sorry for the noise.

Thanks,
Thorsten


