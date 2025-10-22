Return-Path: <linux-kernel+bounces-865172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C36EBFC604
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BD5E4FCCA8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0FE34AAF2;
	Wed, 22 Oct 2025 14:04:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D313431F6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141854; cv=none; b=rzRXEen1NsVDKcccCmOihe8w/aA5XV6ekaER/YI9peK2XxKklQ0kL1fA7mm5INel63RlflY0p0mo8UTa2XtPhBqGm2cjJ+K7xov/tg72N34AH1ocNxDSRGJL/BX9hoYW/9xjc/rGiOoh23SRPGusdhn0jKhWetoWvfYFdifd52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141854; c=relaxed/simple;
	bh=YzBpX1Rsl4XSQwmf9N1iBG77ffs5D0DzM3KdMidVw7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di+GOed2PICHN3FSp5MdaboCGFMQfrulGT96E0BqxMDAy7JSrfymro2gW1QWMxdTlB7OPNZKJX8+mVfa1JPGoo5kyYBiE/9NwRi0rr0wia2C9sGgtAQeDDqdbTWNrtbZ49n6yngSB9I2fdbHmY4KZ4uXXUOiz+Psbx/En2AjaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6B61063;
	Wed, 22 Oct 2025 07:04:03 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF2633F59E;
	Wed, 22 Oct 2025 07:04:10 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:04:09 +0100
From: Leo Yan <leo.yan@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
	james.clark@linaro.org
Subject: Re: [PATCH 1/1] coresight: fix issue where coresight component has
 no claimtags
Message-ID: <20251022140409.GR281971@e132581.arm.com>
References: <20251021234520.3355-1-mike.leach@linaro.org>
 <20251021234520.3355-2-mike.leach@linaro.org>
 <20251022092958.GQ281971@e132581.arm.com>
 <CAJ9a7Vi+Oq3Zma0Cs+w8m0kRE0pG6ax3=26EQK=u7d=vQfNFQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vi+Oq3Zma0Cs+w8m0kRE0pG6ax3=26EQK=u7d=vQfNFQw@mail.gmail.com>

Hi Mike,

On Wed, Oct 22, 2025 at 01:35:46PM +0100, Mike Leach wrote:

[...]

> > - We can add a new flag ("bool claim_impl" in the struct csdev_access),
> >   by default the field will be zero.
> >
> 
> I considered a bool - but the correct place for this would be
> coresight_device - where we keep all the information about the
> hardware features.

Maybe coresight_device is suitable. But this might require to update
furthermore for claim function arguments (e.g., need to pass "csdev"
rather than "csdev_access").

> > - The drivers support claim tags call coresight_clear_self_claim_tag()
> >   in probe (see __catu_probe() as an example), we can call a new
> >   function coresight_init_claim_tag() to replace it, this function sets
> >   "claim_impl" properly and clear the tag if supported.
> >
> 
> I considered moving this initialisation to the common coresight code
> where we create the coresight_device.

Seems to me, this is dangerous. If a module is not CoreSight compliant
and claim registers are absent, when access we will get unknown values
or even cause serious result (external abort or bus lockup).

[...]

> > > +/*
> > > + * Coresight specification defines a maximum of 8 claim tag bits.
> > > + * The precise number is implementation defined, and may be obtained by
> > > + * reading the CLAIMSET register.
> > > + */
> > > +#define CORESIGHT_CLAIM_BITS_MAX_MASK        GENMASK(7, 0)
> > > +#define CORESIGHT_CLAIM_SELF_HOSTED_BIT      BIT(1)
> >
> > Now we only care about the self-host bit. Can reuse existed macros ?
> >
> 
> I feel that drivers should be written to match the specification - the
> macros above are a correct mask value per specification and the
> correct bitfield comparison for the MSBit of the protocol.
> 
> The ones below are a protocol masks field, and a specific protocol
> value that is used in value rather than bit comparisons in the
> claimtag code. I felt it clearer to differentiate between the uses
> when reading the code.

How about change CORESIGHT_CLAIM_EXTERNAL and
CORESIGHT_CLAIM_SELF_HOSTED to MSBit ?

Thanks,
Leo

