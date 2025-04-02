Return-Path: <linux-kernel+bounces-585380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1CA792EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1769016F660
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDF18E76F;
	Wed,  2 Apr 2025 16:18:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8D815CD46
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610706; cv=none; b=my6hHdwrj2hkYsPyNiTMiRU8KgfL2Ws3yMe8vRw+P2z83NMq9W6QBJRqRGZIv11zSF9EotgGMzkDh7tLMTCs+9e/TCKAcS3vCEn/c8vh3P2MZTTtRDqTLFJRRlcEi6c1qzOL8YSMUmdN1KbjlMouxrzFaSd+NAWuwkXX3qGTZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610706; c=relaxed/simple;
	bh=tS+IzDNKu40Z7hFEn98fk1QcSnK1zvMQ3u4/JUoR5as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrh7ronqL8+oqzRoacjaIDYt85JIj84cWmaoukKBHqQ5hZiVxG9JjHRtqKAuDxJNWdEkyg8DXlwNSRK3BOBFtKRGj66kdoJyv8zXanrHSBExYvVaqBZgGZDGbsqnWcIJBsiPPRG1ZEAkHG5q6EoasXVXp7ja8pgOfJQWI+Lu9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F215A106F;
	Wed,  2 Apr 2025 09:18:27 -0700 (PDT)
Received: from bogus (unknown [10.57.41.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3EAF3F63F;
	Wed,  2 Apr 2025 09:18:22 -0700 (PDT)
Date: Wed, 2 Apr 2025 17:18:19 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Sudeep Holla <sudeep.holla@arm.com>, iommu@lists.linux.dev,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: juno-r2: SSD detect failed on mainline and next
Message-ID: <20250402-thistle-oxpecker-of-fragrance-d2ebb5@sudeepholla>
References: <CA+G9fYt0F_vR-zOV4P8m4HTv6AecT-eEnrL+t5wgAaKPodi0mQ@mail.gmail.com>
 <6e0ef5cc-b692-4d39-bec4-a75c1af3f0aa@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0ef5cc-b692-4d39-bec4-a75c1af3f0aa@arm.com>

On Wed, Apr 02, 2025 at 04:34:08PM +0100, Robin Murphy wrote:
> On 31/03/2025 5:03 am, Naresh Kamboju wrote:
> > Regressions on arm64 Juno-r2 devices detect SSD tests failed on the
> > Linux next and Linux mainline.
> > 
> > First seen on the v6.14-7245-g5c2a430e8599
> >   Good: v6.14
> >   Bad: v6.14-7422-gacb4f33713b9
> 
> Sorry, I can't seem to reproduce this on my end, both today's mainline and
> acb4f33713b9 with my config, and even acb4f33713b9 with the linked LKFT
> config, all work OK on my Juno r2 (using a SATA SSD and PCIe networking).
> The only thing which stands out in your log is that PCI seems to give up
> probing and assigning resources beyond the switch downstream ports (so SATA
> and ethernet are never discovered), whereas on mine it does[2]. However that
> all happens before the first IOMMU instance probes (which conveniently is
> the PCIe one), so it's hard to imagine how that could have an effect
> anyway...
> 
> The only obvious difference is that I'm using EDK2 rather than U-Boot, so
> that's done all the PCIe configuration once already, but it doesn't seem
> like that's significant - looking back at a random older log[1], the
> on-board endpoints were still being picked up right after reconfiguring the
> switch, well before the IOMMU comes into the picture.
> 

Highly unlikely it is related to this issue, but I do see you are using
the default DTB files and not juno-*-scmi.dtb which aligns with the SCP
firmware you might be running. Just noticed SCPI timeout in the log, so
none of the power management calls will work. By default all the required
power domains must be on though.

-- 
Regards,
Sudeep

