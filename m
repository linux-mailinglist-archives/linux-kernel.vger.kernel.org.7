Return-Path: <linux-kernel+bounces-797038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F83B40AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20294E313F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94C33A005;
	Tue,  2 Sep 2025 16:48:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E031AF2E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831680; cv=none; b=C150QhMR2+H9Hu8WmuYTVFsfHiNDZ9FFWk38IfjQpNmU5KeLICoSJS+G9rI+6T8If4M+w3AwvKQwiSVNuvayncWheLVZMh5R0xJbCoJ334l/pSrcHRg3VDon+D6Kwpjep33GQrFEN2JhTdDSWaP290tRtVuIZ4x7Bf5EbnTOpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831680; c=relaxed/simple;
	bh=EnVKlMRafytN10jYFr1GMVuLeSqEtWAXCSyGwJGvRvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv63+k/hwuklMcXUkF4HbyhDvQWMIoAupGsUHKPW4XCMqQ8TDOsjzrHF0x8FzAAvmgGKHLZD5xacPPFWYD3SRd9286ldwtccfXy2tV4yunreWf7HeUVUiWSVeMamzrhELkslr7e20+Sf12T0070jSeccYCS2Nmf6KFsZwksK2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A091AC4CEED;
	Tue,  2 Sep 2025 16:47:58 +0000 (UTC)
Date: Tue, 2 Sep 2025 17:47:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active on
 local CPU
Message-ID: <aLcfvIfFb6xD-NXp@arm.com>
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829153510.2401161-1-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 04:35:06PM +0100, Ryan Roberts wrote:
> Beyond that, the next question is; does it actually improve performance?
> stress-ng's --tlb-shootdown stressor suggests yes; as concurrency increases, we
> do a much better job of sustaining the overall number of "tlb shootdowns per
> second" after the change:
> 
> +------------+--------------------------+--------------------------+--------------------------+
> |            |     Baseline (v6.15)     |        tlbi local        |        Improvement       |
> +------------+-------------+------------+-------------+------------+-------------+------------+
> | nr_threads |     ops/sec |    ops/sec |     ops/sec |    ops/sec |     ops/sec |    ops/sec |
> |            | (real time) | (cpu time) | (real time) | (cpu time) | (real time) | (cpu time) |
> +------------+-------------+------------+-------------+------------+-------------+------------+
> |          1 |        9109 |       2573 |        8903 |       3653 |         -2% |        42% |
> |          4 |        8115 |       1299 |        9892 |       1059 |         22% |       -18% |
> |          8 |        5119 |        477 |       11854 |       1265 |        132% |       165% |
> |         16 |        4796 |        286 |       14176 |        821 |        196% |       187% |
> |         32 |        1593 |         38 |       15328 |        474 |        862% |      1147% |
> |         64 |        1486 |         19 |        8096 |        131 |        445% |       589% |
> |        128 |        1315 |         16 |        8257 |        145 |        528% |       806% |
> +------------+-------------+------------+-------------+------------+-------------+------------+
> 
> But looking at real-world benchmarks, I haven't yet found anything where it
> makes a huge difference; When compiling the kernel, it reduces kernel time by
> ~2.2%, but overall wall time remains the same. I'd be interested in any
> suggestions for workloads where this might prove valuable.

I suspect it's highly dependent on hardware and how it handles the DVM
messages. There were some old proposals from Fujitsu:

https://lore.kernel.org/linux-arm-kernel/20190617143255.10462-1-indou.takao@jp.fujitsu.com/

Christoph Lameter (Ampere) also followed with some refactoring in this
area to allow a boot-configurable way to do TLBI via IS ops or IPI:

https://lore.kernel.org/linux-arm-kernel/20231207035703.158053467@gentwo.org/

(for some reason, the patches did not make it to the list, I have them
in my inbox if you are interested)

I don't remember any real-world workload, more like hand-crafted
mprotect() loops.

Anyway, I think the approach in your series doesn't have downsides, it's
fairly clean and addresses some low-hanging fruits. For multi-threaded
workloads where a flush_tlb_mm() is cheaper than a series of per-page
TLBIs, I think we can wait for that hardware to be phased out. The TLBI
range operations should significantly reduce the DVM messages between
CPUs.

-- 
Catalin

