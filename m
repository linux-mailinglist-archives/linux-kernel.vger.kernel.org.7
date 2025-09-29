Return-Path: <linux-kernel+bounces-835930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24377BA85FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0C1888FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50426D4DE;
	Mon, 29 Sep 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="flc3dMm+"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953D24468C;
	Mon, 29 Sep 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134020; cv=none; b=NzuQiLXcgSBksU22ht2bApi2nRoT1j1NETdrlbtjyyXodI37CrexLsdpF7Pcuuv05FOoSSxK+fq3af3u5PeUkBAuZPJgMzep30cXudTl9TJ+8OLAcJ6iPPihjF7vrz4ntD28/P4zAELUu6ztdXEUwo/HnmsHs0eQpsMDNUdmnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134020; c=relaxed/simple;
	bh=qNLm2n6TxpqtORbxwKgeIq8WwvMifAPn0b2QeQKg51Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Og3n1eGtQ/dOQ4tIE/gPZZryYSSSZd/gpvayUr54M+pUIqpx1HN9435J00rPimkqMVnxD+KdBc5JJMt93dtTwGP2ZL0F8wmYuOgxGxUkRPm1H9EKSfQwVDayF6UlyA7vBS7Q/wA8BBPgmFtZjDpQ8ied3Bd9/NEOyM+oeQpxrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=flc3dMm+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1759134009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oK+T6aZibp3zhTv/GFM9GWZmrGwuRk6vAxJAm8TV4s=;
	b=flc3dMm+P5PsO95Okxw565JshEKi7HR7mV9UIcwtd3ug/gnEuAInUznF+Usr5YaEtqgBbH
	Mx/60trvF0rlUiIOsmWVDrkwCjF275k0aXYDvUMjbTdNXQuD6LMXkM0cgNo9y4jOTVvRTT
	Eul+yDHIUPtuKuvVQEzvGRprKXbN23o5AOMMJHBr5CbOi2RQZRqcZm2XYjF6qpEsMDJKZ3
	s3njOrU34zvhxJjjrQBqLFEHNQYYf32uY1PuF1hA4lxzmVO/SSPnFYXQCUBqwjVASYiTB9
	1dkBS32XzwpBCdUZ5d2F6bnWEJ0u0bJZLQxAj90QOx+9eJBsiG7sO6WxKq9PyQ==
Date: Mon, 29 Sep 2025 10:20:08 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Ondrej
 Jirman <megi@xff.cz>, "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
Subject: Re: [PATCH v3 0/5] Upstreaming Pinephone Pro Patches
In-Reply-To: <b01ed528-8b29-4a6a-bdff-88f2e3b5dd2e@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
 <53eabe34a310ea9c74315fa09a604e4a@manjaro.org>
 <b01ed528-8b29-4a6a-bdff-88f2e3b5dd2e@gmail.com>
Message-ID: <115da845d9161e6ecfa67cf189b84aa8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Rudraksha,

On 2025-09-29 09:44, Rudraksha Gupta wrote:
>> Thanks for submitting these patches.  However, please expand the patch
>> descriptions, because their current forms are too terse and, as such,
>> simply not acceptable.  This applies to all patches in this series.
> 
> Gotcha, will do! I've added the testing that I did. From
> https://docs.kernel.org/process/submitting-patches.html
> 
>> The text should be written in such detail so that when read weeks,
>> months or even years later, it can give the reader the needed details
>> to grasp the reasoning for why the patch was created.
> 
> It felt like saying more than "adding x sensor" seemed like adding
> fluff to me, so that is why I kept it short. Let me know if there is
> something else I should add beside the tests I have done.

Thanks for improving the patch descriptions in the v4 of this series.
I just went quickly through the v4 and it looks much better.

It could be said that the new patch descriptions are now a bit too
verbose, in the sense that the test procedures and their results could
be summed up a bit better in prose, instead of providing the "raw"
inputs and outputs.  However, it's still better to have those, than
not to have anything.  Writing good prose is a skill that usually
requires learning and practice.

>> I'm also under impression that you're submitting these patches 
>> upstream
>> blindly and without researching the rules that apply well enough, 
>> which
>> may not be the best possible approach.
> 
> Sorry! I've read
> https://docs.kernel.org/process/submitting-patches.html a bunch of
> times during the years I have contributed to the Linux kernel and
> inevitably forget something. Please feel free to tell me what I've
> done wrong! I've corrected my mistakes in v4 (and undoubtedly probably
> introduced more, but feel free to tell me that ;) )

You haven't done anything technically wrong, but the way you submitted
the v2 and v3 made them feel a bit like you picked those patches from
some random place and submitted them to the mailing list without really
understanding the subject matter.  In other words, it's the 
contributor's
job to convince everyone else that the submitted patches are fine to
become accepted, and the v2 and v3 simply lacked that.

>> Finally, please refrain yourself from sending multiple versions of the
>> same patch series in the same day.  Doing so makes reviewing the 
>> patches
>> unnecessarily hard.
> 
> Sorry about that once again! I'm mostly a hobbyist that loves working
> on Linux over the weekend. I wanted to get correct my mistakes so that
> I can get reviews over the week. I wish lkml used a forge, so I didn't
> have to spam you, but I digress. I will keep this in mind moving
> forward.

I wonder how would some forge prevent "spamming"?  It isn't about the
possible "spamming", but about the act of submitting different versions,
which would be present regardless of the way they'd be submitted, and
the reviewers would need to be aware (i.e. "spammed") of them anyway.

