Return-Path: <linux-kernel+bounces-899538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47F7C5831C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F553AA085
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8BE2D63F6;
	Thu, 13 Nov 2025 14:55:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2623E320
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045709; cv=none; b=OSh3vxOhLrv31F4WtOT3WoCooukp7eeBtBFR8r4WGZPUv/puL9RFgsEXMXFhf2O+MpqyVJLnQjDC3vNLfp09n2gmTj2gqw2GNWMw7KFNLzhR7mLyg/qTB+98eKW1kn651/3felRvt302umcxta78q4PgnKVEdpJOfODSRUEVTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045709; c=relaxed/simple;
	bh=O7aZvL35e5gynavjtsmr+wvU2Icvj3ys6L/6Y727Tmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3EJ2YXCEsguIJvfgjegGZYULwcxSsncpuNDKa7mVoWtER58HwQrURbJJatbkygE+kKkgtzDxaK0OJlm2yHyV6+eMUopdAWsHfmkAsVHIYOnRaStXmB1IKdz9yqoVyn2bNXKYQzu5ItM20HjgmQoJcYbeJalgevlVg042sVXLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A81712FC;
	Thu, 13 Nov 2025 06:54:56 -0800 (PST)
Received: from [10.57.88.47] (unknown [10.57.88.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 539B83F66E;
	Thu, 13 Nov 2025 06:55:01 -0800 (PST)
Message-ID: <28d5f45e-dff0-4073-a806-f8cc6f9fd0aa@arm.com>
Date: Thu, 13 Nov 2025 15:54:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
To: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Shubhang Kaushik <sh@gentwo.org>,
 Shijie Huang <Shijie.Huang@amperecomputing.com>,
 Frank Wang <zwang@amperecomputing.com>, Christopher Lameter <cl@gentwo.org>,
 Adam Li <adam.li@amperecomputing.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
 <CAKfTPtB25-M9sxm4vRQVaYvGkZjyoyZUh-NQ0+rZRuv3szSZ0A@mail.gmail.com>
 <MW6PR01MB8368D97F29454BEAB677FF6DF5CDA@MW6PR01MB8368.prod.exchangelabs.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <MW6PR01MB8368D97F29454BEAB677FF6DF5CDA@MW6PR01MB8368.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.11.25 01:26, Shubhang Kaushik OS wrote:
>> From your previous answer on v1, I don't think that you use
>> heterogeneous system so eas will not be enabled in your case and even
>> when used find_energy_efficient_cpu() will be called before
> 
> I agree that the EAS centric approach in the current patch is misplaced for our homogeneous systems.
> 
>> Otherwise you might want to check in wake_affine() where we decide
>> between local cpu and previous cpu which one should be the target.
>> This can have an impact especially if there are not in the same LLC
> 
> While wake_affine() modifications seem logical, I see that they cause performance regressions across the board due to the inherent trade-offs in altering that critical initial decision point.

Which testcases are you running on your Altra box? I assume it's a
single NUMA node (80 CPUs).

For us, 'perf bench sched messaging` w/o CONFIG_SCHED_CLUSTER, so only
PKG SD (i.e. sis() only returns prev or this CPU) gives better results
then w/ CONFIG_SCHED_CLUSTER.

> We might need to solve the non-idle fallback within `select_idle_sibling` to ring fence the impact for preserving locality effectively.

IMHO, the scheduler only cares about shared LLC (and shared L2 with
CONFIG_SCHED_CLUSTER). Can you check:

$ cat /sys/devices/system/cpu/cpu0/cache/index*/{type,shared_cpu_map}
Data
Instruction
Unified
Unified                                                 <-- (1)
00000000,00000000,00000000,00000000,00000001
00000000,00000000,00000000,00000000,00000001
00000000,00000000,00000000,00000000,00000001
CPU mask > 00000000,00000000,00000000,00000000,00000001 <-- (1)

Does (1) exists? IMHO it doesn't.

I assume your machine is quite unique here. IIRC, you configure 2 CPUs
groups in your ACPI pptt which then form a 2 CPUs cluster_cpumask and
since your core_mask (in cpu_coregrop_mask()) has only 1 CPU, it gets
set to the cluster_cpumask so at the end you have a 2 CPU MC SD and no
CLS SD plus an 80 CPU PKG SD.

This CLS->MC propagation is somehow important since only then you get a
valid 'sd = rcu_dereference(per_cpu(sd_llc, target))' in sis() so you
not just return target (prev or this CPU).
But I can imagine that your MC cpumask is way too small for the SIS_UTIL
based selection of an idle CPU.

[...]

