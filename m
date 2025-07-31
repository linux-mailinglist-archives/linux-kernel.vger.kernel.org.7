Return-Path: <linux-kernel+bounces-752123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C68B1717A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16AC5676B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCC2C08D4;
	Thu, 31 Jul 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7aDNN6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658923099F;
	Thu, 31 Jul 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965968; cv=none; b=grOZw71DllufP8mmjBVMNt7Ao8ZM1kXVxfQpoecf3d98fvXj6SJjY6zkHqjxlgsqxdoAkTNGu7YKHFL8uvkn90np8VuGIfBC8A4rAIGNrY8vp32BVE6UHxWA9c5TCSN4zCsIHhDn2pynTDzuwlZtV1MfYAHfzP56/btdNqlrHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965968; c=relaxed/simple;
	bh=DA00UZ8mlsGJ9kOXBHUieLy/xRbrOMW6eEkjVUp/rb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/aipa6h2MJ/8aiA21UbF6+SiX+gF3Ph4SF055pjmmOxBwRJ9i0VEKDbxxEX3GgV5R6ms0aecnpKGTsSX49rAm3faQv30mjRRSZIQdNkpxwIcnv9UXEPzDIh1AWopr05SEbBH6EnreKFUyTP5q9+FnISLmlX2bYL5qAHAmPOx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7aDNN6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD1C4CEEF;
	Thu, 31 Jul 2025 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753965967;
	bh=DA00UZ8mlsGJ9kOXBHUieLy/xRbrOMW6eEkjVUp/rb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7aDNN6dSO6s1cM2yVn0HbsAfV0aIMR5M7xWN4v7dSYD7KDfr8Ildxz+M5Fhpvo8w
	 o9VoCD2wmOzRVFh5vEq0phCdoK9L1LCLJ2yYnvrwBmzjkMRCaaeFyaTNMhMdeU0d2D
	 Pezq+UBK2cmhiAkit9pzG76hT8kLWFZIfSanVxT3O6IMGXKXbrJT2sBo5COGm0Rhus
	 CXwVVCqGfwedGVp6THWH1NDNrdZw+hJ2u0Wuc3xOJdlC/9P/Cg3+wE319fg4hGAjXT
	 H8JpaeDMGC4iab2ynlnfEpfnkDwhnubZYdiJpKkTBNpQKuY5RvqXGBtEEBwaJY70m6
	 0fHShXC2DT7sA==
Message-ID: <45f0995f-17ac-45a3-8bc0-3b276ee91a9d@kernel.org>
Date: Thu, 31 Jul 2025 14:46:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
 corbet@lwn.net, apw@canonical.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
 <53eb0068-008b-48e6-9b92-d92de2ed4fc9@kernel.org>
 <CAMuHMdU2e+5Hf3v=C=sE=+25f_A=2=Zzw5rxvcT=hb75VC=iFQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAMuHMdU2e+5Hf3v=C=sE=+25f_A=2=Zzw5rxvcT=hb75VC=iFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2025 13:55, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, 25 Jul 2025 at 10:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 24/07/2025 09:20, Hendrik Hamerlinck wrote:
>>> Modified the checkpatch script to ensure that commit tags (e.g.,
>>> Signed-off-by, Reviewed-by, Acked-by, Tested-by, etc.) appear in the
>>> correct order according to kernel conventions [1].
>>
>> These are not the conventions I use for my subsystems and ask others to
>> follow, so imposing TIP rules to all maintainers needs broad consensus,
>> not (yet) checkpatch.
>>
>> What's more, I think above TIP rules are contradicting with existing,
>> widely used and approved toolset - b4. So no, if you want universal
>> tool, please use b4 or whatever b4 defines.
> 
> B4 does not follow the proper order:

There is no "proper order" in terms of absolute facts.

>   1. Multiple Reviewed-by tags may be added in a different order
>       than given,

Maybe this could be fixed.

>   2. When applying my own patches, b4 adds the given tags before
>      instead of after my own SoB.

This is working exactly as expected (intentional), explained few times
by Konstantin. Some people of course have different opinion and prefer
different order (I know few subsystems), but majority I think accepted
Konstantin's explanation.

Best regards,
Krzysztof

