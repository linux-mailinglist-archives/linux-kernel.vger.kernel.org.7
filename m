Return-Path: <linux-kernel+bounces-766349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35805B24573
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5D916DBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2642D46BB;
	Wed, 13 Aug 2025 09:28:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A128A2C3252
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077335; cv=none; b=JUB4fkMoEotzEav71qJl3TWgDk2Q5gEBYEdU4V1rRUGTHA9xy8GYcscB67XUGKqGl1dTbtwQ0QOYehSkceFOM87zoK+GTENWS/60UvdXyMIGgCNWPNLqdW6Gtjp+SHjaPc4+CAoAMLxQREWy0g4vfSJP8I5nXk6L7pHKJqYRzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077335; c=relaxed/simple;
	bh=UUMLBeo3qM2it9jnlPo1mfGYGZn4XaHHNWE6Vc4FRm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqIkfNv8Wt/OrbgbvJXO1bQ0Dp86M7M0S6AepbuKRhlz7qNv7ggBcCC1lBoiPyaI0pBq5Mw6mqWJIQC45wKbB3dBrIXJnxkXZBG9CMcqKom08Ef3WdW+BTr60wqcAXaVWK0lHhwSeWzGKNwgiJBWulrenEBXpwukJWU+/ZctBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A614312FC;
	Wed, 13 Aug 2025 02:28:44 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C003F63F;
	Wed, 13 Aug 2025 02:28:49 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:28:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
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
Message-ID: <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com>
 <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
 <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
 <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>

On Tue, Aug 12, 2025 at 12:32:36PM -0500, Jeremy Linton wrote:
> On 8/12/25 11:33 AM, Christoph Lameter (Ampere) wrote:
> > On Mon, 11 Aug 2025, Jeremy Linton wrote:
> > 
> > >  From what I've seen, SCHED_CLUSTER seems to be a bit of give and take
> > > depending on benchmark and machine. I'm not sure if it should be default
> > > enabled or not, but it would really be nice to have at least a larger sweep of
> > > benchmarks/machines in order to be sure of the decision.
> > 
> > If the hardware provides a clusterid then I think this clusterid should be
> > used for the sched domains. CONFIG_SCHED_CLUSTER does that. So it should
> > be the default.
> 
> Hi,
> 
> The problem is that this information is being sourced from the ACPI PPTT.
> The ACPI specification (AFAIK) doesn't define a cluster, so the linux
> cluster information is being 'invented' based on however the firmware vendor
> choose to group CPU nodes in the PPTT. Which means its possible for them to
> unknowingly create clusters, or also fail to create them when they make
> sense.

+1, completely agree. As Jeremy mentioned, it is hit or miss and cluster
is loosely defined and IIRC Huawei pushed this based on their platform at
the time and it did break some benchmarks on few other platforms. So it
is not a good idea to make it default config IMO.

-- 
Regards,
Sudeep

