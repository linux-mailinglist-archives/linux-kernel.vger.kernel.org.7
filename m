Return-Path: <linux-kernel+bounces-744236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DAB109EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A5A1CE64EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAEC2C374E;
	Thu, 24 Jul 2025 12:09:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853602C3277
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358962; cv=none; b=UHN15EZ8EoJWKWg9duX3jd+VHCsy0QJATTfbH8aQZPFUtOgz1Zi1y2tf+YP43V3ThiFmlyjBoh8SaorBfCVO6fSGTeYnBo7/ibNtHv0rdJmZFz+LsQroxrLv9kmMCVTcJR4k1IsJYtSs6mwhBiJGxQUf6VY79aQzUQXydiFZtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358962; c=relaxed/simple;
	bh=HE2kK5fzj528CcXAbgBgt4goN1DFJluDzXmveP79SkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVl+C7ofWJg+tbj/Yx+lpiuypDPbi8aGPmeb25N+jmjhHIduHWhTW7aj5xeduAQp1JqZVonArrHZFR+7jbXiaozp02BeaYzW4nrQkL/8HYiz2o4a+ZGSNuYBK7SZMJPtI21+Ax17N45g0S5XVqrlzuEi4sroR6R04cmlRCnYoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAE3C4CEED;
	Thu, 24 Jul 2025 12:09:17 +0000 (UTC)
Date: Thu, 24 Jul 2025 13:09:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com, bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com, baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
Subject: Re: [RFC PATCH 13/36] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
Message-ID: <aIIiazUK4S_G6loe@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-14-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711183648.30766-14-james.morse@arm.com>

On Fri, Jul 11, 2025 at 06:36:25PM +0000, James Morse wrote:
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> only be accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until
> the system-wide common values for num_partid and num_pmg have been
> discovered.
> 
> Start with driver probe/remove and mapping the MSC.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/Kconfig                          |   1 +
>  drivers/platform/arm64/Kconfig              |   1 +
>  drivers/platform/arm64/Makefile             |   1 +
>  drivers/platform/arm64/mpam/Kconfig         |  10 +
>  drivers/platform/arm64/mpam/Makefile        |   4 +
>  drivers/platform/arm64/mpam/mpam_devices.c  | 336 ++++++++++++++++++++
>  drivers/platform/arm64/mpam/mpam_internal.h |  62 ++++
>  7 files changed, 415 insertions(+)
>  create mode 100644 drivers/platform/arm64/mpam/Kconfig
>  create mode 100644 drivers/platform/arm64/mpam/Makefile
>  create mode 100644 drivers/platform/arm64/mpam/mpam_devices.c
>  create mode 100644 drivers/platform/arm64/mpam/mpam_internal.h

Bikeshedding: why not drivers/resctrl to match fs/resctrl? We wouldn't
need the previous patch either to move the arm64 platform drivers.

I'm not an expert on resctrl but the MPAM code looks more like a backend
for the resctrl support, so it makes more sense to do as we did for
other drivers like irqchip, iommu. You can create drivers/resctrl/arm64
if you want to keep them grouped.

-- 
Catalin

