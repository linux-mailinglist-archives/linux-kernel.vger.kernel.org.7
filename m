Return-Path: <linux-kernel+bounces-748548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2FB14282
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E9B5409AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20802277CB2;
	Mon, 28 Jul 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b="BQI/1+4f"
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEC21E082;
	Mon, 28 Jul 2025 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.76.87.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731035; cv=none; b=hZEvyUUoZdtyKmNtCPyDEiSQnRKL6L7hBPua6gYnVIkFxbjZS/Z13Z60dSDSc/4/a6qDA3ZMetkWZn2FxQGPgFZblxXBrDMPOePRfEFc5Q3B/hLGfcR16eAKwD4YRWRYOHwAQx+fExDkZ7H2PUGGyE80VzS+3zqkEd1C+lnIDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731035; c=relaxed/simple;
	bh=TiJPq5YAuwOBd1sIH9fTNHv5Pl4m1TEYm9KiqXXVkc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ah1xNFzFPAGxOFxzJC4ib8vEPmJq+aVBuYoDXKiE7PlYO9XE6pCCd3LDko/qJ2OqM+a5IgjwEjLLBGx8bCrhlOokx88nicj4brZOP1kpfMVeU25bBsRnFyHg6stxL5k5KyY9KP0TBi15FJ+mbDutvxC3iI+5GeF48ZYZGvONVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net; spf=pass smtp.mailfrom=smrk.net; dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b=BQI/1+4f; arc=none smtp.client-ip=45.76.87.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smrk.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
	t=1753731030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb9KxMZk40QrKk0rHsnrgfpn71b5H69Kmuqeh2pV3+c=;
	b=BQI/1+4fgfSnGNKcMXCC05RKrozJlRmta5K/pt9Bff6tQuMVDhTAk0Q+INzULf0Rhnwz/M
	lvhLbuEqZwpsHTPamYZRUedYl6GFVX5ITTwYc6jTBlcJnVMGBOtm/MlPR4DnygIulCJLog
	wjuDzapBwsbj5WOIL4gDxAj1BBOU7atFCG+GNXv9WSI4DJ1DpeBsa1PGq440ofm/DZKXvB
	AHIJ3tVsdiDBG6N7knJ0MOziLGlzDQyoCOMcR8xazlJQMWLGIFymno1HDXmHLo2+kzn49T
	5bEPvQj8SWcnsO/wXt98WJwvOgK5+Z4drwBIU17rit8mFleweW3NpKN0+AZE3w==
Received: from localhost (<unknown> [192.168.5.2])
	by smrk (OpenSMTPD) with ESMTPSA id a6e7bb0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Jul 2025 21:30:30 +0200 (CEST)
From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: update to current minimum pipe size
 default
In-Reply-To: <87seigxhf5.fsf@trenco.lwn.net>
References: <20250728-pipedoc-v1-1-2dae082a56f5@smrk.net>
 <87seigxhf5.fsf@trenco.lwn.net>
User-Agent: Notmuch/0.39 (https://notmuchmail.org) Emacs/31.0.50
 (x86_64-pc-linux-gnu)
Date: Mon, 28 Jul 2025 21:30:30 +0200
Message-ID: <20250728193030Z.1636311400-stepnem@smrk.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2025 13:07:58 -0600
Jonathan Corbet wrote:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:
>
>> Fixes: 46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 page=
s")
>> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
>> ---

[...]

> This seems like a reasonable change, but can I ask you to resubmit it
> with a proper changelog, please?

Do you mean a better/longer commit message?

I felt that the Subject: and Fixes: says it all and didn't
want to duplicate information (contained in its commit
message and comments added by that change, as well as the
very paragraph we're updating here).

Would adding something like

  The pipe size limit used when the fs.pipe-user-pages-soft
  sysctl value is reached was increased from one to two
  pages in commit 46c4c9d1beb7; update the documentation to
  match the new reality.
=20=20
work?

Thank you,

  =C5=A0t=C4=9Bp=C3=A1n

