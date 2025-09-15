Return-Path: <linux-kernel+bounces-817726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709EB585B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A57F4805CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947627A11E;
	Mon, 15 Sep 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrxmUom6"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46B320F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966826; cv=none; b=ECNhxW00/6ywx20bZ6MSrsT9syr+ETmTeMUXaAWtND/N0A2PPAKjqAQiC1JvcaQL1bFaHO5/cMYl5xRZkkX573mUh1hiH1r9zdOYLW5EsVjwCaT84Gi/8ZRsSVNsgrDlfhZunxklJXEB21Pg0/PRJY0hPvOhWBab4fKUlq5Oq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966826; c=relaxed/simple;
	bh=MlO8XpuRqu+xdT6S1F7FE/ZbynWBh9SlhI1PGdRcZgk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RwxQHf8yj+nuEv0OSIQdzgo/C1RUYrhDj2aYBeWVX8XLxhXNLdfgoU6PeZ/4BWbexNcgLz9dVp2VhgH8QtLkiBOi+ginTJzqyDDE7Hue3FYPqDWiaGlr+VWwz39KtH8EW5rWKAYd1w4pbi2yPLyctURg82uueIIWa/uUJX3QfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrxmUom6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757966812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlO8XpuRqu+xdT6S1F7FE/ZbynWBh9SlhI1PGdRcZgk=;
	b=SrxmUom6O69ga5DTCLyoveYtB5J+6yWfRoFCq4Oq2qfpruWErlX7qFLVH362QFFDObOrhA
	6g3IQ3yGV8h8TVDcVLkLiiLUYnmOIUYRJf50SkHLDwbxrrYqF9+AXPGyZXuJIzIyI03j7g
	tQHEYHAkfVu+70bynGX7MsBHLitiMRc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] docs: maintainer: Fix capitalization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <8a9b2f36-963a-4d10-9aa1-10f8dcb4bc31@infradead.org>
Date: Mon, 15 Sep 2025 22:06:36 +0200
Cc: Jonathan Corbet <corbet@lwn.net>,
 workflows@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DBCAF005-F4C6-44D2-8DB3-71B002501770@linux.dev>
References: <20250915192235.2414746-2-thorsten.blum@linux.dev>
 <c85881bd-a159-4bb3-9615-b87ce4ab0575@infradead.org>
 <E32E7460-02E4-4E85-8482-E91D3FD12253@linux.dev>
 <8a9b2f36-963a-4d10-9aa1-10f8dcb4bc31@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
X-Migadu-Flow: FLOW_OUT

On 15. Sep 2025, at 21:43, Randy Dunlap wrote:
> On 9/15/25 12:35 PM, Thorsten Blum wrote:
>>=20
>> On 15. Sep 2025, at 21:29, Randy Dunlap wrote:
>>> On 9/15/25 12:22 PM, Thorsten Blum wrote:
>>>> The sentence starts at the previous line: s/Indicate/indicate/
>>>=20
>>> Are you sure?
>>> ISTM that the entire line is a "sub-heading".
>=20
> After I sent this I saw that I should have added that it's ambiguous
> and needs some formatting help, so I'm not surprised to see this:
>=20
>> Hm maybe, but then the layout/rendering on the web is very confusing:
>>=20
>> =
https://docs.kernel.org/maintainer/maintainer-entry-profile.html#key-cycle=
-dates

I think the entire line is meant to be a sub-heading. If it were a
single sentence, it should be either "Deadline ... indicates" or
"Deadlines ... indicate", but not "Deadline ... indicate".

Maybe the author of 4699c504e603 (cc Dan Williams) can confirm this?

Thanks,
Thorsten


