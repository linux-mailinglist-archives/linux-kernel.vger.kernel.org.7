Return-Path: <linux-kernel+bounces-769308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B55BB26CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515731890D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A422E093E;
	Thu, 14 Aug 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="QsnYclyy"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B432143E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189739; cv=none; b=VOTBDruRWznIVtTzKC3Wtdh4fPsriKdZ4ZrQrEFYIAOhLu8XG1a1yo1tQ04E/njIyORcV9aQQC/wHeNspNoONceLlPojPSXuDNbaRjEmkZ6ji6oi2DzwAn7wxIkSJioV8fU4dvBy38zejbdknQJrKRPcfjE5ywT7uL7R46Ivk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189739; c=relaxed/simple;
	bh=wYpyueQHKPzqCdCt0o/J3oLjQKH68YNCumbWnMGtByU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Uqzy7KwlWmWwFw2cdICW1TGpw6yMyzfUupgIwCWyq28KvONmshkkFQx2+ksyVs/wA/rDuqgn3KDmZNuLL9gSis8W0BI6iqwTsyHOLmi85noZwCAdn5HVo59EvZTULNkrO83irMRp2W1pBcJoRiqR9JZhkLPSWPDrpHoNgOYSiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=QsnYclyy; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755189006;
	bh=wYpyueQHKPzqCdCt0o/J3oLjQKH68YNCumbWnMGtByU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QsnYclyyeC99k5HVuVlCPOqjNJUNgn7uWTVqXp7p3NfgLjEy0uPg7TaGgYGyPD9tg
	 U3qNruK9QOXLJO+kt3+kjV9QhlzJWdulKqASjIcFc2YqivNeIQ2SXLls5P4u3A9Bqk
	 LGby9CulARglhzNyO7Ou5fbaJHcEBdO6GuBwxrGw=
Received: by gentwo.org (Postfix, from userid 1003)
	id 75B87401E7; Thu, 14 Aug 2025 09:30:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 736A1401E1;
	Thu, 14 Aug 2025 09:30:06 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:30:06 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Sudeep Holla <sudeep.holla@arm.com>
cc: Jeremy Linton <jeremy.linton@arm.com>, 
    Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com, 
    will@kernel.org, patches@amperecomputing.com, 
    Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org, 
    bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de, 
    nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com, 
    prabhakar.mahadev-lad.rj@bp.renesas.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
In-Reply-To: <aJ20imoeRL_tifky@bogus>
Message-ID: <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com> <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com> <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org> <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com> <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org> <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org> <aJ20imoeRL_tifky@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 14 Aug 2025, Sudeep Holla wrote:

>   |  Different architectures use different terminology to denominate logically
>   |  associated processors, but terms such as package, cluster, module, and
>   |  socket are typical examples.
>
> So how can one use these across architectures ? Package/Socket is quite
> standard. Cluster can be group of processors or it can also be group of
> processor clusters. One of the Arm vendors call it super cluster or something.
> All these makes it super hard for a generic OS to interpret that information.
> Just CONFIG_SCHED_CLUSTER was added with one notion of cluster which was soon
> realised doesn't match with some other notion of it.

What the cluster actually is used for is up to the hardware. The linux
scheduler provides this functionality. How and when this feature is used
by firmware is a vendor issue. There was never a clear definition.

> We can enable it and I am sure someone will report a regression on their
> platform and we need to disable it again. The benchmark doesn't purely
> depend on just the "notion" of cluster but it is often related to the
> private resource and how they are shared in the system. So even if you
> strictly follow the notion of cluster as supported by CONFIG_SCHED_CLUSTER
> it will fail on systems where the private resources are shared across the
> "cluster" boundaries or some variant configuration.

That is not our problem. If the vendor provides clustering information and
the scheduler uses that then the vendor can modify the firmware to not
enable clustering.

As mentioned before: We could create a blacklist to override the ACPI info
from the vendor to ensure that clustering is off.

What we should not do is disabling clustering for all.


> > We could add a blacklist for those platforms to avoid regressions but we
> > should not allow that to hinder us to enable full support for clustering
> > on ARM64.
> >
>
> Sure, but we need to improve the "cluster" definition in the ACPI and Arm
> specification, get an agreement on what it means for other architecture
> first IMO. We don't want to revisit the same topic again without these as
> IIRC this is the second time we are discussion around this topic.

The vendors need flexibility to use this feature when it makes sense.

Having a clear definition would limit the use of clustering feature and
limits innovation. Vendors can control the clustering via ACPI and the
firmware they provide with their system.

We could change definition but that but that would be a decadelong
process which will encounter resistance from vendors that make uses of the
clustering feature that does not fall into the stricter definition.



