Return-Path: <linux-kernel+bounces-763301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A5B212ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440231A20111
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E522C21E0;
	Mon, 11 Aug 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="a2v3cXFy"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094E482FF;
	Mon, 11 Aug 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932291; cv=none; b=nAY7nKt7ClbGtU2qJkpeGSFp+rIKUuZ+EbzrYT0JQAUrzNpfhGJn8GsfNZPN9JFa6HuWDIojHTbcdCo7L15s4wTLTrs/970neaDXBp7fcrlYN9sfj72Y7d92ZBAJEHaHFs61716qTpZlVjlIVRI7guErMEAs3UnXPj80m6nJ9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932291; c=relaxed/simple;
	bh=hTVD6Yv5gSxHlWI+k67kNRMRhKhkFPSUU4Vf0xaHB+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSEFo50Gx3veAcyDPr4q+rlKdvbyxx9bJOzY0g4LIqnlRYXGqedzRHnncpBAN3e8T2vpzty/FsvfZfjZ8Ztu0mr1sB9tCb4snC8sjkCUUuInoylHeINPBSsmmexz1IdT5u3dsvEEq7RKjeR4C+tNJn4q+HGWWTNZLzAsy3wzgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=a2v3cXFy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 45F8740AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754932289; bh=YFNo1xyto9wdOJgULlvM7UE/tRTC5mQFaKXpD4FSQ8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a2v3cXFyUgCSVkeaI/GWh46qt+vos0CEqyd6um61eydLHIN3wC4jOy8b4h0/2oRtF
	 aJbDyWqk0TBxFuh2FHfWK1EwxDPYI1f04Y2MHEUOWxrFwSbVwKrgQL+keBtlntEN6w
	 i98F/m5vgRDt8A43koEEldW4o76CLlwkQhIhuzSBFS/xdRZrFsL/C1d61L2a5MhD8q
	 dPKaa/OaPi8h0ayWCd7JEQ4SYbJrwUAwn2QeXXBehE9MUl/ZbPmj/B/dPHQRj8ouDJ
	 nxii2tebuRH9uYVw1NtD5KpFPNEE3wQNGIZadTMDwP+GG9e4iloH5Q3BMgun7A9CfE
	 2GOoYIQBBUuhg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 45F8740AD2;
	Mon, 11 Aug 2025 17:11:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?=
 <stepnem@smrk.net>
Subject: Re: [PATCH v2] docs: admin-guide: update to current minimum pipe
 size default
In-Reply-To: <20250729-pipedoc-v2-1-18b8e735a9c6@smrk.net>
References: <20250729-pipedoc-v2-1-18b8e735a9c6@smrk.net>
Date: Mon, 11 Aug 2025 11:11:28 -0600
Message-ID: <878qjpeqbj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> The pipe size limit used when the fs.pipe-user-pages-soft sysctl value
> is reached was increased from one to two pages in commit 46c4c9d1beb7;
> update the documentation to match the new reality.
>
> Fixes: 46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 pages=
")
> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
> ---
> The relevant man page was updated in
> 7543e84442d7 ("pipe.7: Document change to default pipe size when soft lim=
it is exceeded")
> https://lore.kernel.org/linux-man/20240829204448.2027276-2-kstewart@effic=
ios.com/
> ---
> Changes in v2:
> - Better commit message (addressing Jonathan's feedback)
> - Link to v1: https://lore.kernel.org/r/20250728-pipedoc-v1-1-2dae082a56f=
5@smrk.net
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
Applied, thanks.

jon

