Return-Path: <linux-kernel+bounces-693738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1342AE02EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 12:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75FB1BC1607
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBC22539D;
	Thu, 19 Jun 2025 10:50:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF822222B4;
	Thu, 19 Jun 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330205; cv=none; b=ObNhp3MG9uwW/KJZmDtfxIJ9d9a3Y1k0OAcEldGbaU0WaNiVDww3TNMzRu3ooVOX9Ja+IvveKE/FeI9eWcaVnajYkMHUbs55As7DvPhovuQ9dzfQ6QVAqrGdiAJB6ZRBPwPzoCBCr0M220Q4KalCcEW6ZENwtXsOc9UaHVxKF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330205; c=relaxed/simple;
	bh=k+42uH4kGEvnIAFTIbY686pIXTye/6Rzuy55dERd+uI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJAk2aWxA3OSW7k3+NNRxBGrejc7gU7oe8I+cYyOKDkAnYj+KA6N60FKx2VqoKbiGxqrzi/Zf5sZ3ckHUL3JsO5Lvntag7dEgXJ+swqR1ZDqGYmprOdOaJgGH97SgUc00J/tf8pK8ufsQq7ACBnzWUNFrAXDmZYlWscmGx8kGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNHPW07zGz6L5dv;
	Thu, 19 Jun 2025 18:47:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 87834140275;
	Thu, 19 Jun 2025 18:49:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Jun
 2025 12:49:57 +0200
Date: Thu, 19 Jun 2025 11:49:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: Neeraj Kumar <s.neeraj@samsung.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tongtiangen@huawei.com>, Yicong Yang <yangyicong@huawei.com>, Niyas Sait
	<niyas.sait@huawei.com>, <ajayjoshi@micron.com>, Vandana Salve
	<vsalve@micron.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Gregory Price"
	<gourry@gourry.net>, Huang Ying <ying.huang@intel.com>, Vishak G
	<vishak.g@samsung.com>, Krishna Kanth Reddy <krish.reddy@samsung.com>, Alok
 Rathore <alok.rathore@samsung.com>, <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Message-ID: <20250619114955.00005e3b@huawei.com>
In-Reply-To: <aFOLIO9JReglmE+3@phytium.com.cn>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
	<20241127163426.00004a65@huawei.com>
	<CGME20250103053521epcas5p30cd4abba59d695664335b03ba806c56d@epcas5p3.samsung.com>
	<1296674576.21735899902648.JavaMail.epsvc@epcpadp1new>
	<20250115134207.00002918@huawei.com>
	<aFOLIO9JReglmE+3@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Jun 2025 11:59:28 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> On Wed, Jan 15, 2025 at 01:42:07PM +0000, Jonathan Cameron wrote:
> > On Fri, 3 Jan 2025 10:57:22 +0530
> > Neeraj Kumar <s.neeraj@samsung.com> wrote:
> >   
> > > On 27/11/24 04:34PM, Jonathan Cameron wrote:  
> > > >On Thu, 21 Nov 2024 10:18:41 +0000
> > > >Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >    
> > > >> The CXL specification release 3.2 is now available under a click through at
> > > >> https://computeexpresslink.org/cxl-specification/ and it brings new
> > > >> shiny toys.    
> > > >
> > > >If anyone wants to play, basic emulation on my CXL QEMU staging tree
> > > >https://gitlab.com/jic23/qemu/-/commit/e89b35d264c1bcc04807e7afab1254f35ffc8cb9
> > > >
> > > >Branch with a few other things on top is:
> > > >https://gitlab.com/jic23/qemu/-/commits/cxl-2024-11-27
> > > >
> > > >Note that this currently doesn't produce real data.  I have a plan
> > > >/ initial PoC / hack to hook that up via an addition to the QEMU cache
> > > >plugin and an external tool to emulate the hotness tracker counting
> > > >hardware. Will be a little while before I get that finished, so in
> > > >a meantime the above exercises the driver.
> > > >
> > > >Jonathan
> > > >    
> > > >>
> > > >> RFC reason
> > > >> - Whilst trace capture with a particular configuration is potentially useful
> > > >>   the intent is that CXL HMU units will be used to drive various forms of
> > > >>   hotpage migration for memory tiering setups. This driver doesn't do this
> > > >>   (yet), but rather provides data capture etc for experimentation and
> > > >>   for working out how to mostly put the allocations in the right place to
> > > >>   start with by tuning applications.
> > > >>
> > > >> CXL r3.2 introduces a CXL Hotness Monitoring Unit definition. The intent
> > > >> of this is to provide a way to establish which units of memory (typically
> > > >> pages or larger) in CXL attached memory are hot. The implementation details
> > > >> and algorithm are all implementation defined. The specification simply
> > > >> describes the 'interface' which takes the form of ring buffer of hotness
> > > >> records in a PCI BAR and defined capability, configuration and status
> > > >> registers.
> > > >>
> > > >> The hardware may have constraints on what it can track, granularity etc
> > > >> and on how accurately it tracks (e.g. counter exhaustion, inaccurate
> > > >> trackers). Some of these constraints are discoverable from the hardware
> > > >> registers, others such as loss of accuracy have no universally accepted
> > > >> measures as they are typically access pattern dependent. Sadly it is
> > > >> very unlikely any hardware will implement a truly precise tracker given
> > > >> the large resource requirements for tracking at a useful granularity.
> > > >>
> > > >> There are two fundamental operation modes:
> > > >>
> > > >> * Epoch based. Counters are checked after a period of time (Epoch) and
> > > >>   if over a threshold added to the hotlist.
> > > >> * Always on. Counters run until a threshold is reached, after that the
> > > >>   hot unit is added to the hotlist and the counter released.
> > > >>
> > > >> Counting can be filtered on:
> > > >>
> > > >> * Region of CXL DPA space (256MiB per bit in a bitmap).
> > > >> * Type of access - Trusted and non trusted or non trusted only, R/W/RW
> > > >>
> > > >> Sampling can be modified by:
> > > >>
> > > >> * Downsampling including potentially randomized downsampling.
> > > >>
> > > >> The driver presented here is intended to be useful in its own right but
> > > >> also to act as the first step of a possible path towards hotness monitoring
> > > >> based hot page migration. Those steps might look like.
> > > >>
> > > >> 1. Gather data - drivers provide telemetry like solutions to get that
> > > >>    data. May be enhanced, for example in this driver by providing the
> > > >>    HPA address rather than DPA Unit Address. Userspace can access enough
> > > >>    information to do this so maybe not.
> > > >> 2. Userspace algorithm development, possibly combined with userspace
> > > >>    triggered migration by PA. Working out how to use different levels
> > > >>    of constrained hardware resources will be challenging.
> > > >> 3. Move those algorithms in kernel. Will require generalization across
> > > >>    different hotpage trackers etc.
> > > >>
> > > >> So far this driver just gives access to the raw data. I will probably kick
> > > >> of a longer discussion on how to do adaptive sampling needed to actually
> > > >> use these units for tiering etc, sometime soon (if no one one else beats
> > > >> me too it).  There is a follow up topic of how to virtualize this stuff
> > > >> for memory stranding cases (VM gets a fixed mixture of fast and slow
> > > >> memory and should do it's own tiering).
> > > >>
> > > >> More details in the Documentation patch but typical commands are:
> > > >>
> > > >> $perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
> > > >>  hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,\
> > > >>  range_size=1024,randomized_downsampling=0,downsampling_factor=32,\
> > > >>  hotness_granual=12    
> > > 
> > > Facing issue while executing perf record on x86 emulation environment using following steps
> > > 
> > > 1. Tried applying CHMU Patch on branch cxl-for-6.13 using b4 utility. As
> > > base commit is not specified, with minor change able to apply patch.
> > > Compiled kernel with CONFIG_CXL_HMU
> > > 
> > > 2. Compiled jic23/cxl-2024-11-27 for x86_64-softmmu
> > > 
> > > 3. Launched Qemu with following CXL topology along with compiled kernel
> > > VM="-object memory-backend-ram,id=vmem1,share=on,size=512M \
> > >      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > >      -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > >      -device cxl-type3,bus=root_port13,volatile-memdev=vmem1,id=cxl-vmem1 \
> > >      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k"
> > > 
> > > 4. Created region and onlined this memory. Also run top utility on the newly created 
> > > numa node using numactl -m<node> top
> > > 
> > > 5. Compiled and installed perf utility in qemu environment, and able to
> > > see cxl_hmu_mem* entries in perf list
> > > 
> > > root@QEMUCXL2030mm:~# perf list
> > > <snip>
> > >   cxl_hmu_mem0.0.0/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
> > >   cxl_hmu_mem0.0.1/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
> > >   cxl_hmu_mem0.0.2/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
> > >   cxl_hmu_mem1.0.0/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
> > >   cxl_hmu_mem1.0.1/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
> > >   cxl_hmu_mem1.0.2/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
> > >   cxl_pmu_mem0.0/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
> > >   cxl_pmu_mem0.1/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
> > >   cxl_pmu_mem1.0/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
> > >   cxl_pmu_mem1.1/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
> > > <snip>
> > > 
> > > 6. Tried running perf command mentioned in Documentation/trace/cxl-hmu.rst
> > > 
> > > root@QEMUCXL2030mm:/home/cxl/cxl-linux-mainline/tools/perf# perf -v
> > > perf version 6.12.rc5.gc198a4f4a356
> > > root@QEMUCXL2030mm:/home/cxl/cxl-linux-mainline/tools/perf# perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,range_size=1024,randomized_downsampling=0,downsampling_factor=32,hotness_granual=12
> > > event syntax error: '..ess_granual=12'
> > >                                   \___ Unrecognized input  
> > 
> > This is probably my mistake when cutting and pasting the example from a terminal.
> > Add a trailing / and something to run.
> > 
> >  perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,range_size=1024,randomized_downsampling=0,downsampling_factor=32,hotness_granual=12/ -- sleep 10  
> 
> Hi Jonathan,
> 
> I tried to use this new command but perf shows error. 
> 
> Based on the change of hmu iomap_block size[1], my steps are like below:
> 
> step1: Create cxl region and online the numa node
> 
> root@ubuntu-jammy-arm64:~/tools# numactl -H
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: 1972 MB
> node 0 free: 1694 MB
> node 1 cpus: 2 3
> node 1 size: 1942 MB
> node 1 free: 1690 MB
> node 2 cpus:
> node 2 size: 256 MB
> node 2 free: 256 MB
> node distances:
> node   0   1   2
>   0:  10  20  20
>   1:  20  10  20
>   2:  20  20  10
> 
> step2: Bind this numa node to run 'ls'
> 
> root@ubuntu-jammy-arm64:~/tools# numactl -m 2 ls
> build   perf.data  ndctl  perf     
> 
> root@ubuntu-jammy-arm64:~/tools# numastat 
>                            node0           node1           node2
> numa_hit                  109323          141170              77
> numa_miss                      0               0               0
> numa_foreign                   0               0               0
> interleave_hit               519             591               0
> local_node                108810          139591               0
> other_node                   513            1579              77
> 
> step3: Use perf tool
> 
> root@ubuntu-jammy-arm64:~/tools# perf -v
> perf version 6.15.rc5.g2c3e6f60f5cf
> 
> root@ubuntu-jammy-arm64:~/tools# perf list | grep -i hmu
>   cxl_hmu_mem0.0.0/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw event descriptor]
> 
> root@ubuntu-jammy-arm64:~/tools# perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,hotness_threshold=1024,epoperf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,range_size=1024,randomized_downsampling=0,downsampling_factor=32,hotness_granual=12/ -- sleep 10
> 
This cut and paste seems to have half of two commands.  

I'll just grab the second one as what I'm guessing you were running. 

perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,range_size=1024,randomized_downsampling=0,downsampling_factor=32,hotness_granual=12/ -- sleep 10

> Error:
> cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,range_size=1024,randomized_downsampling=0,downsampling_factor=32,hotness_granual=12/H: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> 
> [1]:https://lore.kernel.org/linux-cxl/aFNsFI5OKrD0CWR3@phytium.com.cn/T/#u
> 
> Is something wrong on the CHMU interrupts?

That error message is annoyingly meaningless and misleading. I think
the perf core is assuming that any not supported error means that is the problem
rather than something else in the command line might not be supported.

It's failing because we don't support that downsampling_factor.  The format does (hence
I think the stuff above) but the emulation doesn't. 

So for now just don't specify downsampling_factor in the command line. There is
a bug in the emulation around setting it to 1 it seems.  

val = FIELD_DP64(val, CXL_CHMU0_CAP1, DOWN_SAMPLING_FACTORS, BIT(1))
which should have been bit 0 to indicate no downsampling (comment above that is wrong too).


Looking at the spec is rather confusing on how this is supposed to work.
We have a bitmap that has 16 bits, each of which represents a power of 2, but
then we have a CHMU configuration register Down-sampling factor that says
bits 99:96 are the 'one of the 16 possible values'  I assume that means
bit offset.

I'll reply to the qemu thread to point out this bug in the capability.

Jonathan



> 
> > 
> > Jonathan
> >   
> > > 
> > > 
> > > 
> > > Are there any steps i am missing?
> > > 
> > > Regards,
> > > Neeraj	 
> > >   
> > > >>
> > > >> $perf report --dump-raw-traces
> > > >>
> > > >> Example output.  With a counter_width of 16 (0x10) the least significant
> > > >> 4 bytes are the counter value and the unit index is bits 16-63.
> > > >> Here all units are over the threshold and the indexes are 0,1,2 etc.
> > > >>
> > > >> . ... CXL_HMU data: size 33512 bytes
> > > >> Header 0: units: 29c counter_width 10
> > > >> Header 1 : deadbeef
> > > >> 0000000000000283
> > > >> 0000000000010364
> > > >> 0000000000020366
> > > >> 000000000003033c
> > > >> 0000000000040343
> > > >> 00000000000502ff
> > > >> 000000000006030d
> > > >> 000000000007031a
> > > >>
> > > >> Which will produce a list of hotness entries.
> > > >> Bits[N-1:0] counter value
> > > >> Bits[63:N] Unit ID (combine with unit size and DPA base + HDM decoder
> > > >>   config to get to a Host Physical Address)
> > > >>
> > > >> Specific RFC questions.
> > > >> - What should be in the header added to the aux buffer.
> > > >>   Currently just the minimum is provided. Number of records
> > > >>   and the counter width needed to decode them.
> > > >> - Should we reset the counters when doing sampling "-F X"
> > > >>   If the frequency is higher than the epoch we never see any hot units.
> > > >>   If so, when should we reset them?
> > > >>
> > > >> Note testing has been light and on emulation only + as perf tool is
> > > >> a pain to build on a striped back VM,  build testing has all be on
> > > >> arm64 so far.  The driver loads though on both arm64 and x86 so
> > > >> any problems are likely in the perf tool arch specific code
> > > >> which is build tested (on wrong machine)
> > > >>
> > > >> The QEMU emulation needs some cleanup, but I should be able to post
> > > >> that shortly to let people actually play with this.  There are lots
> > > >> of open questions there on how 'right' we want the emulation to be
> > > >> and what counting uarch to emulate.
> > > >>
> > > >> Jonathan Cameron (4):
> > > >>   cxl: Register devices for CXL Hotness Monitoring Units (CHMU)
> > > >>   cxl: Hotness Monitoring Unit via a Perf AUX Buffer.
> > > >>   perf: Add support for CXL Hotness Monitoring Units (CHMU)
> > > >>   hwtrace: Document CXL Hotness Monitoring Unit driver
> > > >>
> > > >>  Documentation/trace/cxl-hmu.rst     | 197 +++++++
> > > >>  Documentation/trace/index.rst       |   1 +
> > > >>  drivers/cxl/Kconfig                 |   6 +
> > > >>  drivers/cxl/Makefile                |   3 +
> > > >>  drivers/cxl/core/Makefile           |   1 +
> > > >>  drivers/cxl/core/core.h             |   1 +
> > > >>  drivers/cxl/core/hmu.c              |  64 ++
> > > >>  drivers/cxl/core/port.c             |   2 +
> > > >>  drivers/cxl/core/regs.c             |  14 +
> > > >>  drivers/cxl/cxl.h                   |   5 +
> > > >>  drivers/cxl/cxlpci.h                |   1 +
> > > >>  drivers/cxl/hmu.c                   | 880 ++++++++++++++++++++++++++++
> > > >>  drivers/cxl/hmu.h                   |  23 +
> > > >>  drivers/cxl/pci.c                   |  26 +-
> > > >>  tools/perf/arch/arm/util/auxtrace.c |  58 ++
> > > >>  tools/perf/arch/x86/util/auxtrace.c |  76 +++
> > > >>  tools/perf/util/Build               |   1 +
> > > >>  tools/perf/util/auxtrace.c          |   4 +
> > > >>  tools/perf/util/auxtrace.h          |   1 +
> > > >>  tools/perf/util/cxl-hmu.c           | 367 ++++++++++++
> > > >>  tools/perf/util/cxl-hmu.h           |  18 +
> > > >>  21 files changed, 1748 insertions(+), 1 deletion(-)
> > > >>  create mode 100644 Documentation/trace/cxl-hmu.rst
> > > >>  create mode 100644 drivers/cxl/core/hmu.c
> > > >>  create mode 100644 drivers/cxl/hmu.c
> > > >>  create mode 100644 drivers/cxl/hmu.h
> > > >>  create mode 100644 tools/perf/util/cxl-hmu.c
> > > >>  create mode 100644 tools/perf/util/cxl-hmu.h
> > > >>    
> > > >    
> > >   
> >   
> 
> 


