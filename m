Return-Path: <linux-kernel+bounces-824471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB0B89539
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF75674B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925030CB4A;
	Fri, 19 Sep 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfC2hGf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE230748E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758282981; cv=none; b=gob5+RwotCY+Ovb9UPrN+ePFZKbH2Xqpok/q4sxHykbe+IXI0ONcaWz9Apnqst3VOj5Xtmgzv9U+qEJctglqIA7y0CmWvQ+Daf0JKVCpIz00IPA5xnFujOQF/018wP13ow8s+kMqOmEK7iFjally3LkcXz7hsLNljvxrVoZaHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758282981; c=relaxed/simple;
	bh=2g66+OQbOGAUuogUvn9+t6VAr2aTSHBay+sw1hDooc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daoZ4r9xCDir+3JYIC5w1l/CK+cKqhTlk8MPRWf7maA2l9E1K9gnq2VSjYiuu3myoa8MGrBeGKHnxlmM8MJSHHFGUSYT/4QwVwcHXOXPwTnaqBNDIs5bbdi4a5lJmErxdzF5q+7bSCQsenidkpVNsKEq7k0xffD1bdn2zWYraoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfC2hGf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB7AC4CEF0;
	Fri, 19 Sep 2025 11:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758282981;
	bh=2g66+OQbOGAUuogUvn9+t6VAr2aTSHBay+sw1hDooc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfC2hGf5WfHc9ZZKlDUiYPPOv1IgyTIvSrw11oXeh/kxHhhEK0c5dF5I5xZirlvZb
	 ohqfOhKt64jBwm8dPvrzIAchNQC76cXfOIgD270EA6XSVTp/j3xmZgT9PciA9fZOqG
	 T4OhFZ8a+knvgc/mM3bboHb5xP4N2LeZ9Yvr0w2hs6v4sbApfVNJZPy4hIcVLTYG37
	 3wUhwEptEpHllSdJXG4HAJgCM/ZPF3ZuTlvS1gY8AlGph3f1cuxsm+lpQuHwkL5htm
	 47bH0mcPQ3HIFSVkndmkYTLTOWcohN4N1FVTrv1BBGhUr7NQRGaHabTY3pMgPeR3/v
	 tz44Xirfuel1Q==
Date: Fri, 19 Sep 2025 12:56:15 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org,
	Yang Shi <yang@os.amperecomputing.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 0/5] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Message-ID: <aM1E34lRjKg7nlRu@willie-the-truck>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
 <fc43aa07-d4ad-47d5-8381-61d4a9b8c467@arm.com>
 <aM0-FQlepoxxGkRd@willie-the-truck>
 <ceaf604f-8ad7-4e19-812e-7eeace10d835@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceaf604f-8ad7-4e19-812e-7eeace10d835@arm.com>

On Fri, Sep 19, 2025 at 12:49:22PM +0100, Ryan Roberts wrote:
> On 19/09/2025 12:27, Will Deacon wrote:
> > On Fri, Sep 19, 2025 at 11:08:47AM +0100, Ryan Roberts wrote:
> >> On 18/09/2025 22:10, Will Deacon wrote:
> >>> On Wed, 17 Sep 2025 12:02:06 -0700, Yang Shi wrote:
> >>>> On systems with BBML2_NOABORT support, it causes the linear map to be mapped
> >>>> with large blocks, even when rodata=full, and leads to some nice performance
> >>>> improvements.
> >>>>
> >>>> Ryan tested v7 on an AmpereOne system (a VM with 12G RAM) in all 3 possible
> >>>> modes by hacking the BBML2 feature detection code:
> >>>>
> >>>> [...]
> >>>
> >>> Applied patches 1 and 3 to arm64 (for-next/mm), thanks!
> >>>
> >>> [1/5] arm64: Enable permission change on arm64 kernel block mappings
> >>>       https://git.kernel.org/arm64/c/a660194dd101
> >>> [3/5] arm64: mm: support large block mapping when rodata=full
> >>>       https://git.kernel.org/arm64/c/a166563e7ec3
> >>>
> >>> I also picked up the BBML allow-list addition (second patch) on
> >>> for-next/cpufeature.
> >>>
> >>> The fourth patch ("arm64: mm: split linear mapping if BBML2 unsupported
> >>> on secondary CPUs") has some really horrible conflicts. These are partly
> >>> due to some of the type cleanups on for-next/mm but I think mainly due
> >>> to Kevin's kpti rework that landed after -rc1.
> >>
> >> Thanks Will, although I'm nervous that without this patch, some platforms might
> >> not boot; Wikipedia tells me that there are some Google, Mediatek and Qualcomm
> >> SoCs that pair X4 CPUs (which is on the BBML2_NOABORT allow list) with A720
> >> and/or A520 (which are not). See previous mail at [1].
> > 
> > I'd be surprised if these SoCs are booting on the X4 but who knows.
> 
> Ahh. You can probably tell I'm a bit naive to some of this system level stuff...
> I had assumed they would want to boot on the big CPU to reduce boot time.

One of the problems is that the boot CPU becomes CPU0 and that inevitably
means it ends up being responsible for a tonne of extra stuff (interrupts,
TZ, etc) and in many cases can't be offlined. So it's all a trade-off.

> > Lemme have another look at applying the patch with fresh eyes, but I do
> > wonder whether having X4 on the allow list really makes any sense. Are
> > there any SoCs out there that _don't_ pair it with CPUs that aren't on
> > the allow list? (apologies for the double negative).
> 
> Hmm, that's a fair question. I'm not aware of any. So I guess the simplest
> solution is to remove X4 from the allow list and ditch fourth patch.

That's probably a good idea but I have a horrible feeling we _are_ going
to need your patch once the errata start flying about :)

So how about we:

  - Remove X4 from the list
  - I try harder to apply your patch for secondary CPUs...
  - ... if I fail, we can apply it next time around

Sound reasonable?

Will

