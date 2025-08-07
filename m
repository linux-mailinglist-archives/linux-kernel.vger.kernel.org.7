Return-Path: <linux-kernel+bounces-759366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B36B1DCA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553FAA004B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315D20FA81;
	Thu,  7 Aug 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcJ1w67z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563F207A0C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589062; cv=none; b=WlliMGwCAzjEtQ8P9Tu9Z4uJRkVr090z1WEFWrVUwcZACcgjJc1ZrmImcJUYhbECxobH32cRg8Ri6ufGs0ALjdXQ+u3D5EqOe49tBM42YIc99M/iN1R2Kc8IqseCbWeNz6qm8FOQF7G9aBxGMJox52FZA2tl9plngpYK1RTYUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589062; c=relaxed/simple;
	bh=TVtbE9kVJdMS2hhy+Qd4ctRjeI4jf6YH6bnt9QQv+rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzrMWaC7+11jGMfIxebUK1lbf2EAM5l21bh90EcSrx+xmR+IUXPvqBPNUoy8Xmxxpeo08PdIX2ODFAghMV8d6H/ueYW5J96y0nik8BB+WmYbCHj95QI9+wukrrUzVI/jS7WB3EidQHgYh1QB8+vOcfR0j+p/Za3kvf6TcBLkG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcJ1w67z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE72C4CEEB;
	Thu,  7 Aug 2025 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754589061;
	bh=TVtbE9kVJdMS2hhy+Qd4ctRjeI4jf6YH6bnt9QQv+rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcJ1w67zQ3hkBcXpfn9hT64Dv+mNegPMjPBOfjeCZdr97PvQTnC+3hGuaCvttgiS5
	 nvckqJuQE2UfnQIWROUiu9gpH3kzrRymSK0g4reXzzEo3w4Vj9IpDj2skQN7HWIBjm
	 c1GG4oqePnI2Zl2f3gp0h/Lo3gtqaJRn3dJgAIqybANnLVpqpTiiIpMWFX84q2rw+3
	 XgV1zKPcgscXM9dWWA5r7fUmj+l32acTytAaCJJzKd+a6secrHImxk1LqEO+BgKs/a
	 F8I384W5gcl/uz99ywXsx80EM7ROEnDJ0aK/jI1/F+fy6ruYlTpTlsDCz2QOGW/AaO
	 OjMhkP1QII2mg==
Date: Thu, 7 Aug 2025 10:50:59 -0700
From: Drew Fustini <fustini@kernel.org>
To: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
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
Message-ID: <aJTng8R9eJmGR6/W@x1>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-14-james.morse@arm.com>
 <aIIiazUK4S_G6loe@arm.com>
 <6a77726d-1881-4590-8021-623c877bb5d7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a77726d-1881-4590-8021-623c877bb5d7@arm.com>

On Wed, Aug 06, 2025 at 07:04:09PM +0100, James Morse wrote:
> Hi Catalin,
> 
> On 24/07/2025 13:09, Catalin Marinas wrote:
> > On Fri, Jul 11, 2025 at 06:36:25PM +0000, James Morse wrote:
> >> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> >> only be accessible from those CPUs, and they may not be online.
> >> Touching the hardware early is pointless as MPAM can't be used until
> >> the system-wide common values for num_partid and num_pmg have been
> >> discovered.
> >>
> >> Start with driver probe/remove and mapping the MSC.
> 
> >>  arch/arm64/Kconfig                          |   1 +
> >>  drivers/platform/arm64/Kconfig              |   1 +
> >>  drivers/platform/arm64/Makefile             |   1 +
> >>  drivers/platform/arm64/mpam/Kconfig         |  10 +
> >>  drivers/platform/arm64/mpam/Makefile        |   4 +
> >>  drivers/platform/arm64/mpam/mpam_devices.c  | 336 ++++++++++++++++++++
> >>  drivers/platform/arm64/mpam/mpam_internal.h |  62 ++++
> >>  7 files changed, 415 insertions(+)
> >>  create mode 100644 drivers/platform/arm64/mpam/Kconfig
> >>  create mode 100644 drivers/platform/arm64/mpam/Makefile
> >>  create mode 100644 drivers/platform/arm64/mpam/mpam_devices.c
> >>  create mode 100644 drivers/platform/arm64/mpam/mpam_internal.h
> 
> > Bikeshedding: why not drivers/resctrl to match fs/resctrl? We wouldn't
> > need the previous patch either to move the arm64 platform drivers.
> 
> Initially because I don't see any other architecture having an MMIO interface to this
> stuff, and didn't want a 'top level' driver directory for a single driver. But, re-reading
> RISC-Vs CBQRI[0] it turns out that theirs is memory mapped...

Yeah, all the cpus (e.g. harts) can access all the registers of the QoS
controllers per the CBQRI spec [1].

The memory map for the example SoC in the proof-of-concept [2]:

  Base addr  Size
  0x4820000  4KB  Cluster 0 L2 cache controller
  0x4821000  4KB  Cluster 1 L2 cache controller
  0x4828000  4KB  Memory controller 0
  0x4829000  4KB  Memory controller 1
  0X482a000  4KB  Memory controller 2
  0X482b000  4KB  Shared LLC cache controller

> > I'm not an expert on resctrl but the MPAM code looks more like a backend
> > for the resctrl support, so it makes more sense to do as we did for
> > other drivers like irqchip, iommu.
> 
> Only because there are many irqchip or iommu. I'm not a fan of drivers/mpam, but
> drivers/resctrl would suit RISC-V too. (I'll check with Drew)

I think that is reasonable. In the proof-of-concept, I had the following
structure, but I think there is a lot of room for improvement. 

arch/riscv/kernel/qos/qos_resctrl.c
 Implementation of the register interface described in the CBQRI spec
 along with the resctrl implementation. I should probably break this up
 into separate files for the CBQRI operations and the resctrl interface.

drivers/soc/foobar/foobar_cbqri_cache.c
  DT-based driver for SoC cache controller that implements CBQRI

drivers/soc/foobar/foobar_cbqri_memory.c
  DT-based driver for SoC memory controller that implements CBQRI

With all the great upstream progress, I've been meaning to rebase the
RISC-V CBQRI support and post an RFC as its been a really long time.
There is no public silicon yet that implements CBQRI but I think the
possibility is getting closer. I've also been working on integrating
ACPI support [3] using the new RQSC table, and I've been meaning to post
an RFC for that too.

Thanks,
Drew

[1] https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0/riscv-cbqri.pdf
[2] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylibre.com/
[3] https://lf-rise.atlassian.net/wiki/spaces/HOME/pages/433291272/ACPI+RQSC+Proof+of+Concept

