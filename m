Return-Path: <linux-kernel+bounces-788107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93DDB37FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C823E1B685ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240B4337683;
	Wed, 27 Aug 2025 10:19:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F44F2F1FE6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289973; cv=none; b=uZBxkZYE/91JA5wPa9fZUGqzMQQ56osERaZinLAu8tJ8jwkNo6O8Z7SA7f/n1XYhgT487Kcp9Eaz9+VVg+ls2QnykktuKlM28rf+MiHv1x4wadE7nCuWXx0ca1KeVcS2dk9Kazypi+ZtXoU9YsjYoEWRZmwiTrttbStrqNdvnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289973; c=relaxed/simple;
	bh=l8icMveQ0TFtZyFnl67j/FQ9dMtBjO0VTK+3/J5OuVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocanp4a6FiU5+xuOgut4j/OtX6yrUva+KOgOOs4Wfe6plrIwgsbRm8abzf5O9EO74bDiuwTPj+sPiOanxSQpm45Ksfd/E50tpLlSnw0J54mZ8i5zIxErDIng/PNQiB6yt/l7LeFue6i3wxJlxO5Q5RiRtBrthoGJjXylUw8cmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE98214BF;
	Wed, 27 Aug 2025 03:19:22 -0700 (PDT)
Received: from bogus (unknown [10.57.57.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCC4D3F738;
	Wed, 27 Aug 2025 03:19:27 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:19:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	catalin.marinas@arm.com, will@kernel.org,
	patches@amperecomputing.com, Shubhang@os.amperecomputing.com,
	krzysztof.kozlowski@linaro.org, bjorn.andersson@oss.qualcomm.com,
	geert+renesas@glider.be, arnd@arndb.de, nm@ti.com,
	ebiggers@kernel.org, nfraprado@collabora.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
Message-ID: <20250827-mushroom-of-heavenly-efficiency-f0ebbc@sudeepholla>
References: <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
 <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org>
 <aJ20imoeRL_tifky@bogus>
 <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org>
 <20250815-pheasant-of-eternal-tact-6f9bbc@sudeepholla>
 <1097a1d1-483d-44b3-b473-4350b5a4b04d@arm.com>
 <20250818-mysterious-aromatic-wasp-cdbaae@sudeepholla>
 <bdfdc220-63d8-45ff-a475-41a6a63e61ff@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdfdc220-63d8-45ff-a475-41a6a63e61ff@amperemail.onmicrosoft.com>

On Wed, Aug 27, 2025 at 10:33:17AM +0800, Shijie Huang wrote:
> 
> On 18/08/2025 17:33, Sudeep Holla wrote:
> > >  From a distro perspective it makes more sense to me to change it from a
> > > compile time option to a runtime kernel command line option with the default
> > > on/off set by this SCHED_CLUSTER flag rather than try to maintain a
> > > blocklist.
> > > 
> > Right, that makes complete sense to me.
> 
> Anyway, Peter is also try to make the SCHED_CLUSTER as default for arm64
> platform, please see the email link:
> 
> https://patchew.org/linux/20250826041319.1284-1-kprateek.nayak@amd.com/20250826041319.1284-5-kprateek.nayak@amd.com/
> 

Yes, I was cc-ed and I am following the discussions.

-- 
Regards,
Sudeep

