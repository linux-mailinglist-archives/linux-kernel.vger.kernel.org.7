Return-Path: <linux-kernel+bounces-864606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196EBFB2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A11A0635D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2D315772;
	Wed, 22 Oct 2025 09:30:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0C2F90DE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125404; cv=none; b=SblqCrqhixK1+FD1E61jAYilNHbqU88cCPnai5c2CtPaEfeeN6vSpjbsHBcjFBu/XdN7n4OG64m7w+FB0q41nuvExz7A+rUS5wcAH9bLrXCHVBzw4qE4H6enVE4NfvupJKdf1caYEk07B/SUW6+FWVhTHNG4YA0wYFDj47KgG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125404; c=relaxed/simple;
	bh=cG7IABea57DG0DtgXpflswuwevPog+6mo7iVYtSI/qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxHTLaEqpcxXDiiOQNz1JZEP3nMoQqon5RRbVUppfaU6XlzOI0wc2GEfBxSFCssYUvyOjSB6frZtzt0/TTTJ5U3sD+gt4XS1zu5vox4k/ETRJ2SWmntAdEHKjHUjGu5W3BPrc2yDic3iVz36BPb1mADTdZSJTPl0Zzha9rAlOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC5A1063;
	Wed, 22 Oct 2025 02:29:52 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 555603F59E;
	Wed, 22 Oct 2025 02:30:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:29:58 +0100
From: Leo Yan <leo.yan@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
	james.clark@linaro.org
Subject: Re: [PATCH 1/1] coresight: fix issue where coresight component has
 no claimtags
Message-ID: <20251022092958.GQ281971@e132581.arm.com>
References: <20251021234520.3355-1-mike.leach@linaro.org>
 <20251021234520.3355-2-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021234520.3355-2-mike.leach@linaro.org>

On Wed, Oct 22, 2025 at 12:45:20AM +0100, Mike Leach wrote:

[...]

> +/*
> + * Reading CLIAMSET returns  a bitfield representing the number of claim tags
> + * implemented from bit 0 to bit nTag-1, valid bits set to 1.
> + *
> + * Claim protocol requires 2 bits so test for highest bit required,
> + * bit 1 -  CORESIGHT_CLAIM_SELF_HOSTED_BIT
> + *
> + * return true if sufficient claim tags implemented for protocol
> + */
> +static bool coresight_claim_tags_implemented_unlocked(struct csdev_access *csa)
> +{
> +	u32 claim_bits_impl = FIELD_GET(CORESIGHT_CLAIM_BITS_MAX_MASK,
> +			 csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMSET));
> +	return ((claim_bits_impl & CORESIGHT_CLAIM_SELF_HOSTED_BIT) != 0);
> +}
> +

The logic looks good to me.

Can we improve a bit with a cached flag to avoid every time checking the
CLAIMSET, we can read it only once at init time instead.

- We can add a new flag ("bool claim_impl" in the struct csdev_access),
  by default the field will be zero.

- The drivers support claim tags call coresight_clear_self_claim_tag()
  in probe (see __catu_probe() as an example), we can call a new
  function coresight_init_claim_tag() to replace it, this function sets
  "claim_impl" properly and clear the tag if supported.

- Afterwards, simply check the "claim_impl" flag.

[...]

> +/*
> + * Coresight specification defines a maximum of 8 claim tag bits.
> + * The precise number is implementation defined, and may be obtained by
> + * reading the CLAIMSET register.
> + */
> +#define CORESIGHT_CLAIM_BITS_MAX_MASK	GENMASK(7, 0)
> +#define CORESIGHT_CLAIM_SELF_HOSTED_BIT	BIT(1)

Now we only care about the self-host bit. Can reuse existed macros ?

  CORESIGHT_CLAIM_MASK
  CORESIGHT_CLAIM_SELF_HOSTED

I don't mind if extend CORESIGHT_CLAIM_MASK to 8 bits and even remove
CORESIGHT_CLAIM_INVALID (as it cannot cover other invalid values). Or we
can defer the extension as needed later.

Thanks,
Leo

