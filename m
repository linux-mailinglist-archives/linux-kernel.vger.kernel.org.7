Return-Path: <linux-kernel+bounces-753626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8615AB18570
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBEA58460F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9828C5D5;
	Fri,  1 Aug 2025 16:09:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3428C034
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064577; cv=none; b=igjOoDoR5tD5fhw8/P3RDNWilZtznsuxu0pzMxJNGJCHx9NVRFB3JAo0evkLZ0Bd8FpM/OPeEZ94yNxRSW8MxMB+xaYrSipvkamBykgbnXuZL9myFSHF5PvOoPXMWvMC7AEWRvR/sTz3m9Kj7wF2uy9/JfhC32LT0hdR7wUsv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064577; c=relaxed/simple;
	bh=nomBDu1of4B5QpjDNgqXKAwUb8fdoh2SChFEJflAXJE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJ/1CC4A7/ixlAhSSumUk4M9ILWn6cz0MiOmRYZ5jsxa/1hitIGh1HwzMvug5OSC4WtSGklm0E2yEzPetVJja3XTOF1HMmKCyy9EWeWvpmVBHXb9C4d7deF6CQ6c4Wt8+/Us2arHGTASw/Mdedsqgr6wZKT2U8upKCL2O3KoRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btrSd6Jmqz6L5CV;
	Sat,  2 Aug 2025 00:07:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C8971402F3;
	Sat,  2 Aug 2025 00:09:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Aug
 2025 18:09:31 +0200
Date: Fri, 1 Aug 2025 17:09:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"Zeng Heng" <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
	"Carl Worth" <carl@os.amperecomputing.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>
Subject: Re: [RFC PATCH 00/36] arm_mpam: Add basic mpam driver
Message-ID: <20250801170930.000051fe@huawei.com>
In-Reply-To: <20250711183648.30766-1-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 18:36:12 +0000
James Morse <james.morse@arm.com> wrote:

> Hello,
> 
> This is just enough MPAM driver for the ACPI and DT pre-requisites.
> It doesn't contain any of the resctrl code, meaning you can't actually drive it
> from user-space yet.
> 
> This is the initial group of patches that allows the resctrl code to be built
> on top. Including that will increase the number of trees that may need to
> coordinate, so breaking it up make sense.
> 
> The locking looks very strange - but is influenced by the 'mpam-fb' firmware
> interface specification that is still alpha. That thing needs to wait for an
> interrupt after every system register write, which significantly impacts the
> driver. Some features just won't work, e.g. reading the monitor registers via
> perf.
> The aim is to not have to make invasive changes to the locking to support the
> firmware interface, hence it looks strange from day-1.
> 
> I've not found a platform that can test all the behaviours around the monitors,
> so this is where I'd expect the most bugs.
> 
> It's unclear where in the tree this should be put. It affects memory bandwidth
> and cache allocation, but doesn't (yet) interact with perf. The main interaction
> is with resctrl in fs/resctrl - but there will be no filesystem code in here.
> Its also likely there will be other in-kernel users. (in-kernel MSC emulation by
> KVM being an obvious example).
> (I'm not a fan of drivers/resctrl or drivers/mpam - its not the sort of thing
>  that justifies being a 'subsystem'.)
> 
> For now, I've put this under drivers/platform/arm64. Other ideas welcome.
> 
> The first three patches are currently a series on the list, the PPTT stuff
> has previously been posted - this is where the users of those helpers appear.
> 
Hi James,

Whilst I get that this is minimal, I was a bit surprised that it doesn't
contain enough to have the driver actually bind to the platform devices
I think that needs the CPU hotplug handler to register a requester.
So about another 4 arch patches from your tree.  Maybe you can shuffle
things around to help with that.

That makes this a pain to test in isolation.

Given desire to poke the corners, I'm rebasing the old QEMU emulation and
will poke it some more.  Now we are getting close to upstream kernel support
maybe I'll even clean that up for potential upstream QEMU.

For bonus points I 'could' hook it up to the cache simulator and actually
generate real 'counts' but that's probably more for fun than because it's
useful. Fake numbers are a lot cheaper to get.

Jonathan
> 
> The MPAM spec that describes all the system and MMIO registers can be found
> here:
> https://developer.arm.com/documentation/ddi0598/db/?lang=en
> (Ignored the 'RETIRED' warning - that is just arm moving the documentation
>  around. This document has the best overview)
> 
> This series is based on v6.16-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/rfc
> 
> The rest of the driver can be found here:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.16-rc4
> 
> What is MPAM? Set your time-machine to 2020:
> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> 
> Bugs welcome,
> Thanks,
> 
> James Morse (31):
>   cacheinfo: Add arch hook to compress CPU h/w id into 32 bits for
>     cache-id
>   arm64: cacheinfo: Provide helper to compress MPIDR value into u32
>   cacheinfo: Expose the code to generate a cache-id from a device_node
>   ACPI / PPTT: Add a helper to fill a cpumask from a processor container
>   ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear
>     levels
>   ACPI / PPTT: Find cache level by cache-id
>   ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
>   arm64: kconfig: Add Kconfig entry for MPAM
>   ACPI / MPAM: Parse the MPAM table
>   platform: arm64: Move ec devices to an ec subdirectory
>   arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
>   arm_mpam: Add the class and component structures for ris firmware
>     described
>   arm_mpam: Add MPAM MSC register layout definitions
>   arm_mpam: Add cpuhp callbacks to probe MSC hardware
>   arm_mpam: Probe MSCs to find the supported partid/pmg values
>   arm_mpam: Add helpers for managing the locking around the mon_sel
>     registers
>   arm_mpam: Probe the hardware features resctrl supports
>   arm_mpam: Merge supported features during mpam_enable() into
>     mpam_class
>   arm_mpam: Reset MSC controls from cpu hp callbacks
>   arm_mpam: Add a helper to touch an MSC from any CPU
>   arm_mpam: Extend reset logic to allow devices to be reset any time
>   arm_mpam: Register and enable IRQs
>   arm_mpam: Use a static key to indicate when mpam is enabled
>   arm_mpam: Allow configuration to be applied and restored during cpu
>     online
>   arm_mpam: Probe and reset the rest of the features
>   arm_mpam: Add helpers to allocate monitors
>   arm_mpam: Add mpam_msmon_read() to read monitor value
>   arm_mpam: Track bandwidth counter state for overflow and power
>     management
>   arm_mpam: Add helper to reset saved mbwu state
>   arm_mpam: Add kunit test for bitmap reset
>   arm_mpam: Add kunit tests for props_mismatch()
> 
> Rob Herring (2):
>   cacheinfo: Set cache 'id' based on DT data
>   dt-bindings: arm: Add MPAM MSC binding
> 
> Rohit Mathew (2):
>   arm_mpam: Probe for long/lwd mbwu counters
>   arm_mpam: Use long MBWU counters if supported
> 
> Shanker Donthineni (1):
>   arm_mpam: Add support for memory controller MSC on DT platforms
> 
>  .../devicetree/bindings/arm/arm,mpam-msc.yaml |  227 ++
>  MAINTAINERS                                   |    6 +-
>  arch/arm64/Kconfig                            |   19 +
>  arch/arm64/include/asm/cache.h                |   17 +
>  drivers/acpi/arm64/Kconfig                    |    3 +
>  drivers/acpi/arm64/Makefile                   |    1 +
>  drivers/acpi/arm64/mpam.c                     |  365 +++
>  drivers/acpi/pptt.c                           |  240 +-
>  drivers/acpi/tables.c                         |    2 +-
>  drivers/base/cacheinfo.c                      |   57 +
>  drivers/platform/arm64/Kconfig                |   73 +-
>  drivers/platform/arm64/Makefile               |   10 +-
>  drivers/platform/arm64/ec/Kconfig             |   73 +
>  drivers/platform/arm64/ec/Makefile            |   10 +
>  .../platform/arm64/{ => ec}/acer-aspire1-ec.c |    0
>  .../arm64/{ => ec}/huawei-gaokun-ec.c         |    0
>  .../arm64/{ => ec}/lenovo-yoga-c630.c         |    0
>  drivers/platform/arm64/mpam/Kconfig           |   23 +
>  drivers/platform/arm64/mpam/Makefile          |    4 +
>  drivers/platform/arm64/mpam/mpam_devices.c    | 2910 +++++++++++++++++
>  drivers/platform/arm64/mpam/mpam_internal.h   |  697 ++++
>  .../platform/arm64/mpam/test_mpam_devices.c   |  390 +++
>  include/linux/acpi.h                          |   17 +
>  include/linux/arm_mpam.h                      |   56 +
>  include/linux/cacheinfo.h                     |    1 +
>  25 files changed, 5117 insertions(+), 84 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml
>  create mode 100644 drivers/acpi/arm64/mpam.c
>  create mode 100644 drivers/platform/arm64/ec/Kconfig
>  create mode 100644 drivers/platform/arm64/ec/Makefile
>  rename drivers/platform/arm64/{ => ec}/acer-aspire1-ec.c (100%)
>  rename drivers/platform/arm64/{ => ec}/huawei-gaokun-ec.c (100%)
>  rename drivers/platform/arm64/{ => ec}/lenovo-yoga-c630.c (100%)
>  create mode 100644 drivers/platform/arm64/mpam/Kconfig
>  create mode 100644 drivers/platform/arm64/mpam/Makefile
>  create mode 100644 drivers/platform/arm64/mpam/mpam_devices.c
>  create mode 100644 drivers/platform/arm64/mpam/mpam_internal.h
>  create mode 100644 drivers/platform/arm64/mpam/test_mpam_devices.c
>  create mode 100644 include/linux/arm_mpam.h
> 


