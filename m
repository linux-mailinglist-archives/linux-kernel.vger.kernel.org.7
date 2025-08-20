Return-Path: <linux-kernel+bounces-777724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64AB2DD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47967586265
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CB308F11;
	Wed, 20 Aug 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="uqd944ju"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3F2EBDCB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694690; cv=none; b=mWGzylPahzLyNEo1A0T6jEBhA+LUP8dCSHVIUVCWaYQerNTFFP1fSR75aFSZqZuQSz3lP/QtEizZGuPn4GjCeHEpPZK/7/Dw/ZhvhwmesKk7O4HKQx0UIZf7jMPfGCo1p+zKaWCE3K7T+vXM7jidfDarX5N3TuKbnr9vWLRbf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694690; c=relaxed/simple;
	bh=FL1qdsJdYlTPhxXhO1xYRX1SdNE4oOgS41cv9EJcUJk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I/FfsaihrFEUWs7OnmW9C7xoXoVZsubWuwhtWrfvKmUgwcGKGrSbVopL0av8MpeofXKlqSWOKwPX6BsJYhW0JxwyQXJ/gOKtODCu+LSGL7oBrA0e9YT+XQiP+EwJLPeprBI8rWX9D1E59jh9WK7puMHeJ3//ZHyTdn/NmRkzSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=uqd944ju; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755694683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FL1qdsJdYlTPhxXhO1xYRX1SdNE4oOgS41cv9EJcUJk=;
	b=uqd944jumwt/OqCvrVikg2k18gKD+hcC10wE87TN4ey5hS2uK8bgYIg3dpnF6NIMrNcmc7
	Q3G5w+hq+EgOo0wO5XkHwJ/vsZS16lmFs0aB/ILxGoLeBqQPLP6c2qW8H1GrWgA6rTYPU6
	Eu5Bsi3EVMgzCRqC5FVUoV2+l9dcW1KWE37xCSFvHiMkWMEcSFx7EsobzETUGxvrJHSdM/
	/Y2Ne0v8pKyuEJhokVgbYlPk+KpAF4rMKJTNSk8B21YB0PmFRr5bb8wViwpAWOj/JdyhZ0
	nyiC+P+5A5pB4dAlwYgA4KYBwCN90mgm4I2kHk6t/v0jzB8ydbQOZF4QZDfXbg==
Content-Type: multipart/signed;
 boundary=f312b39eb8656774e4bd11dce79ebb120775cc336f024edd6bee753f42fc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 14:57:51 +0200
Message-Id: <DC79THC2NMDM.1BHGJPJHTYPTV@cknow.org>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Dietmar Eggemann"
 <dietmar.eggemann@arm.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Ben
 Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "jstultz" <jstultz@google.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-rockchip@lists.infradead.org>
Subject: Re: [RFC PATCH 1/1] sched/deadline: Fix RT task potential
 starvation when expiry time passed
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Kuyo Chang"
 <kuyo.chang@mediatek.com>
References: <20250615131129.954975-1-kuyo.chang@mediatek.com>
 <CAMuHMdWZHwr_nmMbVREKC9nQCYigT_gvKH3M9v+oyYqk6FLONw@mail.gmail.com>
In-Reply-To: <CAMuHMdWZHwr_nmMbVREKC9nQCYigT_gvKH3M9v+oyYqk6FLONw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--f312b39eb8656774e4bd11dce79ebb120775cc336f024edd6bee753f42fc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jul 30, 2025 at 12:06 PM CEST, Geert Uytterhoeven wrote:
> On Mon, 16 Jun 2025 at 14:39, Kuyo Chang <kuyo.chang@mediatek.com> wrote:
>> From: kuyo chang <kuyo.chang@mediatek.com>
>>
>> [Analysis]
>> ---------
>> The log "sched: DL replenish lagged too much" triggered.
>>
>> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
>
> Thanks, this fixes the issue I was seeing!
>
> Closes: https://lore.kernel.org/CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpo=
LxWYoGa82w@mail.gmail.com
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

I was seeing this warning as well on several of my Rockchip based
devices, but that is gone after applying this patch. Thanks!

Tested-by: Diederik de Haas <didi.debian@cknow.org>

--f312b39eb8656774e4bd11dce79ebb120775cc336f024edd6bee753f42fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKXGVQAKCRDXblvOeH7b
brWcAQCUmEK2dQiUw8567AElKttA2Xw1XSBJji4KjZ0aIcOkqgD+KJh6ivSpDeo0
sE85VdYRU6hAT+Uh8u65OcOlnN6feQ4=
=riNm
-----END PGP SIGNATURE-----

--f312b39eb8656774e4bd11dce79ebb120775cc336f024edd6bee753f42fc--

