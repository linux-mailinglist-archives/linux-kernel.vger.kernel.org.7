Return-Path: <linux-kernel+bounces-804222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F04B46D1F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EDA3A9AA2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC22ED87C;
	Sat,  6 Sep 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XkpDbGiO"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490B27FD48;
	Sat,  6 Sep 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757163480; cv=none; b=NJoiexpI0mt2vnZCvmw+O/ta/0fOTHL7A7YN7BOBzKyxOHhaDW5OXBwrgIGLvb/R4yYswyvuBs5S8i/+mWuHvp9ndxOH1ULe1ZTzcjkgti+r6FXIGNJ+MPKHGoXg7oAKlMI4ksD3v7KVNNDhe38NwTq1vemEx+Mmhyf1LI70fRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757163480; c=relaxed/simple;
	bh=CRBvtOSYXzdy6nOSB7JyFY0zI0ccnfFCwTfe18suORA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WSdb+HrtbQ7Eik53sK9gq2ar3j8TL6OMN1yLxKHM/Ou/qe5/G4/NRloc7nj6mzrbHsWjrgJRRNKijy4rfU+igQA1VLvyVDjU21t/nGxjjAXVMvPzexTdPNFReoCmSSQpY5o9xycFoKucSIHF0ijxPfeFXlBYV26K6C7p7/cICe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XkpDbGiO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757163476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBvknfRADrFTmcYESe6FCG/DDohCJeCBYoa6CBvKIBU=;
	b=XkpDbGiOFHdQgB47WOPXPYIS3DTQy0c5jxkWEfob9EfgzYFSNRP9rSKd1v0AIi9ihAVPdx
	aZjIX4ENRCw9Qb+7f9vDATzWkRvOPjT3RqdIZ9/LYiXqGBX7fl5d4aBQh7ANwssBHKcWkL
	DzZQR3TYyHg0/PgBKf6mgXezWu2W4fPkYZlKZwbecZGYkWZEBi/NMhE8lcE1KAMN0f2M7W
	DK8rTMFX8t0t3ZfY44BlmrlUwtBULe4ON2qDeWalDoKKQj4Hh1Lz2oshs8X0s1jEzHIyZA
	KoMUppZZvNgrdQw9KCVfaqmHItrj6uqcIyPIBCSlTjgStWa0lLx0cKVZGml6kQ==
Date: Sat, 06 Sep 2025 14:57:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
 linux-rockchip@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Make RK3588 GPU OPP table naming
 uniform
In-Reply-To: <3169011.CbtlEUcBR6@diego>
References: <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
 <DCLOTR9Y380M.22GZYL11XXZM2@cknow.org>
 <47cf50f2f497108a923815c12b1f8c9b@manjaro.org> <3169011.CbtlEUcBR6@diego>
Message-ID: <f34b6fad7768dd88b40284fa330af4f2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2025-09-06 14:21, Heiko Stübner wrote:
> Am Samstag, 6. September 2025, 14:10:22 Mitteleuropäische Sommerzeit
> schrieb Dragan Simic:
>> On 2025-09-06 13:40, Diederik de Haas wrote:
>> > On Sat Sep 6, 2025 at 12:01 PM CEST, Dragan Simic wrote:
>> >> Unify the naming of the existing GPU OPP table nodes found in the
>> >> RK3588
>> >> and RK3588J SoC dtsi files with the other SoC's GPU OPP nodes,
>> >> following
>> >> the more "modern" node naming scheme.
>> >
>> > Like we discussed in private (without an agreement), I think it would
>> > be
>> > beneficial if the (gpu) opp naming would be made consistent across SoC
>> > series as right now there are several different naming schemes applied.
>> > They're all valid, but inconsistent. And if consistency is improved,
>> > which I like, then let's go 'all the way'?
>> 
>> As we discussed it already in private, I fully agree about performing
>> the "opp-table-X => opp-table-{clusterX,gpu}" naming cleanup
>> consistently
>> for all Rockchip SoCs, but I'm afraid it would be seen as an 
>> unnecessary
>> "code churn" at this point, especially because my upcoming Rockchip 
>> SoC
>> binning patch series is a good candidate for such a cleanup.
>> 
>> On top of that, I'd be a bit weary about performing at least some of 
>> the
>> testing associated with such a platform-wide cleanup, despite actually
>> performing no functional changes and being a safe change.  On the 
>> other
>> hand, "bundling" such a cleanup with the Rockchip SoC binning patches
>> would get us detailed testing for free, so to speak.
>> 
>> Of course, if the maintainers see this as a good opportunity to 
>> perform
>> a platform-wide cleanup at this point, instead of seeing it as a "code
>> churn", I'll still be happy to extend this small patch into a 
>> platform-
>> wide naming cleanup of the "opp-table-X" nodes.  On the other hand, if
>> this patch remains as-is, it may hit a good balance between resolving
>> the currently present naming ambiguity and the amount of introduced
>> changes.
> 
> Personally I'm always for the "we strive to get there eventually" 
> thing.
> If there is an established goal to reach, steps can be incremental :-) 
> .
> 
> And also short and scope-limited patches are easier to review anyway.

I see.  After thinking a bit more about it, I'll turn this patch into
a small series, in which this patch becomes the 1/2, and the 2/2 is
a new, larger patch that extends the "opp-table-X" naming cleanup to
the entire platform.  That way, the 1/2 kind of fixes something, while
the 2/2 performs a cleanup, which may be helpful in the unlikely case
that some regression is found down the road.

