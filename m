Return-Path: <linux-kernel+bounces-653897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37934ABC04E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74EA188B959
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCBD280A39;
	Mon, 19 May 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luVc22gJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA02272E51;
	Mon, 19 May 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663741; cv=none; b=QpMdyXG8eVKF2eU42WU+ayHQIKRVOD0ixbsIZGopomNG4trYVjOLzV2f62kBk4ET9aRlWMRJ9vkEwkbduTSehMdXDHkAKDV92xrkrddZlKTt2U51bRvsvGyE2zYc9A8qqyp3/MByayqcnbNTK8lpJEjuSgivlAGLC7KiW85HKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663741; c=relaxed/simple;
	bh=XdmqhIOgyWrpqvPrXuD5sGuSVFBd8VTkIvjeyIdrYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPf+C9ag9NKJ5MrQGeQa/uRLi8XmDh8Sda0XF5FMQkEc49jNABtkF93/3NsTl012RDgKHgTx8QU3HQZTqCa3N9tjpIeJdHVSwmzJkKsCnPfd4oSa1B2j5GniDwNyl6hWAQha0Ew3iOei5nUxkWQxYUoY9KVJFCEWmFkjYRM/G6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luVc22gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E1CC4CEEF;
	Mon, 19 May 2025 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747663740;
	bh=XdmqhIOgyWrpqvPrXuD5sGuSVFBd8VTkIvjeyIdrYEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luVc22gJlJH+x7jQc5VnMH8Mm+HofKOpjX+5dOE7qm+sNjKW4mfOAPApZPdfB+5oN
	 L5WkCCqZcZjsiWMjWi8Y65lgd43FG8l8/yQ6uXJf4t/4XHw6H2BOTuGQMmwOGrIleq
	 ShGb01ty8Y1jqBgpk40uqMem0porz7lyt5mfsJgU42FrdJCy92MaifwR1DMR48REes
	 e1aPhcRzdx2qZfiLn98KEXOL3Kh46lK/S1sGv8vssY/JrpXI8VlkXfhj4pdKBQNmFt
	 rfS1w2E8nQRUsWQkvDKDzSSfc4BCpTM/Vj78vpjFToRCV6B6Lt3e314T4t0e+NgP7H
	 35EBm7kF+RA5Q==
Date: Mon, 19 May 2025 15:08:54 +0100
From: Will Deacon <will@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Leo Yan <leo.yan@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v21 1/4] arm64/sysreg: Add BRBE registers and fields
Message-ID: <20250519140852.GB16991@willie-the-truck>
References: <20250407-arm-brbe-v19-v21-0-ff187ff6c928@kernel.org>
 <20250407-arm-brbe-v19-v21-1-ff187ff6c928@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-arm-brbe-v19-v21-1-ff187ff6c928@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 07, 2025 at 12:41:30PM -0500, Rob Herring (Arm) wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> This patch adds definitions related to the Branch Record Buffer Extension
> (BRBE) as per ARM DDI 0487K.a. These will be used by KVM and a BRBE driver
> in subsequent patches.
> 
> Some existing BRBE definitions in asm/sysreg.h are replaced with equivalent
> generated definitions.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
> Tested-by: James Clark <james.clark@linaro.org>
> ---
> v19:
> - split BRBINF.CC field into mantissa and exponent
> ---
>  arch/arm64/include/asm/sysreg.h |  17 ++----
>  arch/arm64/tools/sysreg         | 132 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+), 11 deletions(-)

Some of the field names here are made up, but overall they seem to
correspond to the architecture, so:

Acked-by: Will Deacon <will@kernel.org>

Will

