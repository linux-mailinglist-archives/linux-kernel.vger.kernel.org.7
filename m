Return-Path: <linux-kernel+bounces-768514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9A3B261D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9953BA59A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3BD2F0672;
	Thu, 14 Aug 2025 10:04:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D181367
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165844; cv=none; b=T340b0UvBF01vfQ1Nd5LZwrJ5k2U0oab2wqUuIUfPUDZkq9a/VZ1CBF6mHbBC4SbDHOSAXvpTXTQbgZf3Ys1mPZ5+P6ZERfNVLw7TN7cp0Pck8I2za9oE6/hMm+ohVCxFKgcaYFBz/HCmyWyvXy4h+uYPt1NiYYves9vlisNYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165844; c=relaxed/simple;
	bh=PMFCUIRYOnYiELsSiupXTQHwuyKl59PvnQhyq7XEssI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFwEGK2AIQ7mvEqyvyOoTXfXO3tSE+N8won0jITl2Ay0Kk/yFkm34oJhgMtRMuFTEE3picPlIXvL1UUwhObxIA83MmN2rJR29ycEtbPFgKg5D08XUi4lnEc1i04fdHXR17vmCf1yFiZ7wgX/Z+94OTeHM9Kn/BHMlH1bodiX9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C011691;
	Thu, 14 Aug 2025 03:03:52 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3243F738;
	Thu, 14 Aug 2025 03:03:57 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:03:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	catalin.marinas@arm.com, will@kernel.org,
	patches@amperecomputing.com, Shubhang@os.amperecomputing.com,
	krzysztof.kozlowski@linaro.org, bjorn.andersson@oss.qualcomm.com,
	geert+renesas@glider.be, arnd@arndb.de, nm@ti.com,
	ebiggers@kernel.org, nfraprado@collabora.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
Message-ID: <aJ20imoeRL_tifky@bogus>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com>
 <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
 <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
 <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
 <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org>

On Wed, Aug 13, 2025 at 03:56:47PM -0700, Christoph Lameter (Ampere) wrote:
> On Wed, 13 Aug 2025, Christoph Lameter (Ampere) wrote:
> 
> > Can we figure out which platforms benchmarks were affected and why?
> >
> > It seems the notion of a "cluster" on ARM64 is derived (I guess a better
> > word than "invented" hehe)  from sibling information instead of PPTT. But
> > using that information should work fine right?
> 
> Sorry no that is not correct. The cluster information is correctly read
> from the ACPI tables and the cluster ids are avaialble in
> 
> 	/sys/devices/system/cpu/cpuXX/topology/cluster_id
> 

Agreed, the parts of ACPI specification has added notion of cluster sprinkle
across various chapters(mostly added by Arm in the earlier days though the
Arm architecture specification itself doesn't have any standard definition
for the cluster). Also note it nicely adds a disclaimer:

  |  Different architectures use different terminology to denominate logically
  |  associated processors, but terms such as package, cluster, module, and
  |  socket are typical examples.

So how can one use these across architectures ? Package/Socket is quite
standard. Cluster can be group of processors or it can also be group of
processor clusters. One of the Arm vendors call it super cluster or something.
All these makes it super hard for a generic OS to interpret that information.
Just CONFIG_SCHED_CLUSTER was added with one notion of cluster which was soon
realised doesn't match with some other notion of it.

We can enable it and I am sure someone will report a regression on their
platform and we need to disable it again. The benchmark doesn't purely
depend on just the "notion" of cluster but it is often related to the
private resource and how they are shared in the system. So even if you
strictly follow the notion of cluster as supported by CONFIG_SCHED_CLUSTER
it will fail on systems where the private resources are shared across the
"cluster" boundaries or some variant configuration.

> if CONFIG_SCHED_CLUSTER is enabled.
> 
> If there is an issue then it is a problem with the vendor firmware
> providing cluster id configurations via ACPI that cause regressions.
> 

As mentioned, it is not strictly just the cluster id but other shared
resources that contribute to the issues/regressions.

> We could add a blacklist for those platforms to avoid regressions but we
> should not allow that to hinder us to enable full support for clustering
> on ARM64.
> 

Sure, but we need to improve the "cluster" definition in the ACPI and Arm
specification, get an agreement on what it means for other architecture
first IMO. We don't want to revisit the same topic again without these as
IIRC this is the second time we are discussion around this topic.

-- 
Regards,
Sudeep

