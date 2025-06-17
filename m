Return-Path: <linux-kernel+bounces-689927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AECADC87D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 12:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B618A3B81C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894732C15A0;
	Tue, 17 Jun 2025 10:35:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C78296151
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156526; cv=none; b=ob6Gk/JQvuj3yuRN3Wi/fjwp4DSqCFlzYhxwt769SJsiZxVz3+wL2boIqkT/KU66k+YAIaIm1eYVRMCHSkftDpf8onHyutYVouNJQQs455XQf9ZvsYlkY0KMaqYoUZiZXJeQX93uY2IXDtir+m4YdOHeefhWFTdqLyUEppJMfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156526; c=relaxed/simple;
	bh=47EQzd74pZCnBFOdjDmbd4KFae4M2fHyvZpbUhjPhSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=olmPuTClqZzHO086BepyCezawx1X1EY4CahjHqpEAjlN5vHvH8NUXZglFlL00Uak+vhXxPmzcBTgD+qV18iMEo5mAprpb9KjrwH9iSZDRjN5kQShrkwDaBf8da/K7uJrLkGGuHl4uaI05swBRtJaByqyGNBhr0+U2aACGo5b0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0810C1596;
	Tue, 17 Jun 2025 03:35:01 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62CF73F58B;
	Tue, 17 Jun 2025 03:35:19 -0700 (PDT)
Message-ID: <f9cf869a-7f86-4600-a2d1-b9092551105f@arm.com>
Date: Tue, 17 Jun 2025 11:35:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, yang@os.amperecomputing.com, catalin.marinas@arm.com,
 will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
 joro@8bytes.org, maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 james.morse@arm.com, broonie@kernel.org, ardb@kernel.org, baohua@kernel.org,
 david@redhat.com, jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
 mshavit@google.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-3-miko.lenczewski@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250617095104.6772-3-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/06/2025 10:51, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for.
> 
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> 
> This feature builds on the previous ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
> as all early cpus must support BBML2 for us to enable it (and any later
> cpus must also support it to be onlined).
> 
> Not onlining late cpus that do not support BBML2 is unavoidable, as we
> might currently be using BBML2 semantics for kernel memory regions. This
> could cause faults in the late cpus, and would be difficult to unwind,
> so let us avoid the case altogether.
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


