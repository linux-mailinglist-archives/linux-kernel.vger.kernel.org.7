Return-Path: <linux-kernel+bounces-824451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E372B8943A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDAE580197
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063DE30CB48;
	Fri, 19 Sep 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyDFhaX0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64406246795
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281243; cv=none; b=nGClM/DmDj9GgA/ldhC/bVxwwca0eyTW+N1+fsNXzX6ROo2fmiuFEEpOggcH49TlNKjKKS+GDxXWy7Qml6czDCSAmhwfLyIERLq8ylXluXfBO3LCOofDQe1ovQwyrv9sIvViwpyQTBg2V2U1WFpJ4qp4xc/xu9W5dccTc9/V1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281243; c=relaxed/simple;
	bh=C7w7HkIT7yX2Ji+TqLNQ8VqWh4vuv3N2kHTkNH+vyH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiOxE/PKc4feljqZywR5Mp/cblxnlAVrl05l+WiJ8J5Omm1z0KyNQ9x6TmwfuR/mJ+PYN7xkIt0ieXDI1mO1CyZbSizBu0HIE3luukWcbXJ/gpR/Pv9U9XPS/wBUZtj6vnoy7HzfHxraFzqTmvaQFdgZkGBc2XiXKfBgIFj1vCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyDFhaX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C01C4CEF1;
	Fri, 19 Sep 2025 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758281243;
	bh=C7w7HkIT7yX2Ji+TqLNQ8VqWh4vuv3N2kHTkNH+vyH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyDFhaX0ckf5/YrwFt0U5X9+9yhz7wuK1xRDrQby4m9loYda/mWYsYv9SY59N4gJ6
	 5d073ME7gJ1z9rA31EIzjFcxe4I3AVQIT/2NSGorRpYNEOtT+F8EhM2AZW46Dw/n0Z
	 vaGYR9Xfm5JfGdqLNtiL2cnXXVqj1BrqYqoU5i4BKvOWzGv2Yd7B4cAICNJ5fC+Vc8
	 uGGjcIe+DLFxmnd3I3SiLsEKP6g/IP4pH72Gg5RuodsraJis5EAIqdG5XWt1P3jcEV
	 Huk4QRaOzR7e3qPnBSCwxW8/GHEjjU+k0tlGpa0pNjQEMA5kAEawmKxX5Pe+HA5fh7
	 knPyNOYNgXPaA==
Date: Fri, 19 Sep 2025 12:27:17 +0100
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
Message-ID: <aM0-FQlepoxxGkRd@willie-the-truck>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
 <fc43aa07-d4ad-47d5-8381-61d4a9b8c467@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc43aa07-d4ad-47d5-8381-61d4a9b8c467@arm.com>

On Fri, Sep 19, 2025 at 11:08:47AM +0100, Ryan Roberts wrote:
> On 18/09/2025 22:10, Will Deacon wrote:
> > On Wed, 17 Sep 2025 12:02:06 -0700, Yang Shi wrote:
> >> On systems with BBML2_NOABORT support, it causes the linear map to be mapped
> >> with large blocks, even when rodata=full, and leads to some nice performance
> >> improvements.
> >>
> >> Ryan tested v7 on an AmpereOne system (a VM with 12G RAM) in all 3 possible
> >> modes by hacking the BBML2 feature detection code:
> >>
> >> [...]
> > 
> > Applied patches 1 and 3 to arm64 (for-next/mm), thanks!
> > 
> > [1/5] arm64: Enable permission change on arm64 kernel block mappings
> >       https://git.kernel.org/arm64/c/a660194dd101
> > [3/5] arm64: mm: support large block mapping when rodata=full
> >       https://git.kernel.org/arm64/c/a166563e7ec3
> > 
> > I also picked up the BBML allow-list addition (second patch) on
> > for-next/cpufeature.
> > 
> > The fourth patch ("arm64: mm: split linear mapping if BBML2 unsupported
> > on secondary CPUs") has some really horrible conflicts. These are partly
> > due to some of the type cleanups on for-next/mm but I think mainly due
> > to Kevin's kpti rework that landed after -rc1.
> 
> Thanks Will, although I'm nervous that without this patch, some platforms might
> not boot; Wikipedia tells me that there are some Google, Mediatek and Qualcomm
> SoCs that pair X4 CPUs (which is on the BBML2_NOABORT allow list) with A720
> and/or A520 (which are not). See previous mail at [1].

I'd be surprised if these SoCs are booting on the X4 but who knows.

Lemme have another look at applying the patch with fresh eyes, but I do
wonder whether having X4 on the allow list really makes any sense. Are
there any SoCs out there that _don't_ pair it with CPUs that aren't on
the allow list? (apologies for the double negative).

Will

