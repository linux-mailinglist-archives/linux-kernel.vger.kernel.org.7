Return-Path: <linux-kernel+bounces-880241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B1C252E2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DDE403A06
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F734AAFF;
	Fri, 31 Oct 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/yAYcSt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC12D8767;
	Fri, 31 Oct 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916052; cv=none; b=IE/gwPiC/YlLwYvqW1fo6il65JPAG9DPfa/BPYex+IPL1XSaZV6HxWUq5YT4v4Di1vcNlMf8zdlmP9ZhKfyyAiGaxu5LqQRzg1TJsKxS8RNth7VTIGZ9FowbpuoOvZQ2PTOyTbmUxH63WUfAoPOiAxTNXsmt56cZrBEy8DQXGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916052; c=relaxed/simple;
	bh=06kPK6O8+pY6eTtIgnf8SHfeVOZ6dBU9DlqOfS2xtHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3UNk+UzxzTx4VPveIp0sm1rfobr9Rreh1zI+9j+Fb0BXu3i0XDDND604j9aBx+NqbCpYkwI1a4Yb+m+qBY/QePy/4eE78prnpm/be7m9mGsxMFxupjnZjg//XtTOrfPP6kNNJCyBJyKMQYuTGXg0Zi0zdUMkoPrBgiqERJwKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/yAYcSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C69C4CEE7;
	Fri, 31 Oct 2025 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916052;
	bh=06kPK6O8+pY6eTtIgnf8SHfeVOZ6dBU9DlqOfS2xtHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l/yAYcStyOPXSV3HM9T49oOl8X9TZw9W5esTdaAnCRYEOmQ1hKdHKN12U/gdasw4C
	 j5xXmFnGKD9HiyUIP90alSb8/PgduVYCZ4Ve6SgHRSCxoVlQAmZUUh/SBA0SeqZv/O
	 95b7ttAe4PFHStRAHajwD7t/htvNBrBpxPN75XTPtVTtqdFvCFzgq/GMnDuvbwhhrx
	 /LoGBaH4SICKcChvqbA/wkBnKbJ53IQ0+e+azMTr8OZ9QA82bpz4b7ne98dk53b2ke
	 EGmyWhbDZox6tkeZIbM8sjZfw4o9gv4fK8dlCJKOmw7I1z/IOtkt2bCKfziIOEjJDA
	 vKiulGtlyjApw==
Message-ID: <2f4d2e6e-3bc3-4f44-b474-1617536c9710@kernel.org>
Date: Fri, 31 Oct 2025 08:07:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] platform/x86/amd: Add S0ix support to the Xbox
 Ally
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Antheas Kapenekakis <lkml@antheas.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Perry Yuan <perry.yuan@amd.com>
References: <20251024152152.3981721-1-lkml@antheas.dev>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251024152152.3981721-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> The Xbox Ally features a Van Gogh SoC that on the Steam Deck uses S3.
> Therefore, kernel support for S0ix was previously absent. Introduce
> this support in three patches:
> 
> 1) Add Van Gogh to AMD PMC driver
> 2) Enable spurious_8042 quirk, as it is common in those generations
> 3) Adjust the Van Gogh init logic to avoid powering down the rlc
>     and tweak post init
> 
> This allows the Xbox Ally to properly enter and exit S0ix suspend.
> Perhaps it also allows the Steam Deck to use s2idle without crashing,
> note it is not currently possible [1].
> 
> Currently, around 1/10 times the SoC misses the PMC hint and does not
> enter S0ix, so perhaps 1 or 3 need tweaking further. It wakes up always,
> however.
> 
> @Alex: I tweaked the text on patch 3 a bit. You can resend it separately
> after the issue with 1/10 failures is fixed.
> 
> [1]: https://github.com/evlaV/linux-integration/commit/5ab73e9069017aa1b5351f91513ba540ce5905fb
> 
> Alex Deucher (1):
>    drm/amdgpu: only send the SMU RLC notification on S3
> 
> Antheas Kapenekakis (2):
>    platform/x86/amd/pmc: Add support for Van Gogh SoC
>    platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
>   drivers/platform/x86/amd/pmc/pmc-quirks.c        | 8 ++++++++
>   drivers/platform/x86/amd/pmc/pmc.c               | 3 +++
>   drivers/platform/x86/amd/pmc/pmc.h               | 1 +
>   6 files changed, 26 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5

Ilpo,

Patches 1 and 2 are good for platform-x86.  Since this fixes the 
platform-x86 side of a hang at suspend I think these should go 6.18-rc 
if you're open to it.

We're doing something different with the other patches in 
amd-staging-drm-next.  You can ignore the ones in this series.

