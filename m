Return-Path: <linux-kernel+bounces-739747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ADFB0CA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D46B170C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F82E041F;
	Mon, 21 Jul 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnzcuyCO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FE1A3154
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121610; cv=none; b=a93+xjHEuIuMwSx0z+nRy31JWyXg6vqZhl9qL0IuDc33sZxq4NcU7imjHeXyYh/bb4hFMumgX0WWX+iHJvA8kPyHwP6LZ9Z7TSWMTWV/14+wv9B9kb213Ue6JQnIUJ5W8fcKPdPlt49vSQodNURNfz5/KMRu9+U1WAikXavzvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121610; c=relaxed/simple;
	bh=0k4Ep98AIDWYfjT4YyfcsC89vreGR1g5sBXJkeCCX54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HA3T723i+7EiFcfdVAUor5Ht7A8UzbifnPaTwM7ZaVFFiNAxIKZwcD77KedDXNea5SJSnrPHKEcVWQLJQp2+2tShGgTY+zDjDwOMS2PG9ztKE2JaC0IOKngfnki57e8nqSpzLs5hgsRO6IL/WP7uPVjlXQ4J/IigL5DA9vsNWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnzcuyCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08FAC4CEED;
	Mon, 21 Jul 2025 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753121610;
	bh=0k4Ep98AIDWYfjT4YyfcsC89vreGR1g5sBXJkeCCX54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lnzcuyCOFObuupJKwOhtjIS+S/3A5n+OyF4rHkjfoimOBE/tvPDjA2tcW8S6DzaSM
	 uBoQ50QoM/TBgzAWzKnd9GbzEF1A50fp4BL5djDbFDetVmt+Nddy0S26GWRG5d6yKm
	 tmUuO8c85+R4BecoKAuFss0SYADeUCqkIeAlXATQAGMCadDPB3Rs6NJ5OoR7roosWV
	 H3xcKQi0ec1fe5ah83f3d/lkRqz12rS6ir4EdHL1aUt/Od98RciRhWY4Q9cLOO4nrK
	 nIeOfdpia++vPQ14DxPlKNe6RGta0OI47uj9QR6riQ+dPR3w7Yp9YFigwyyaOfs1iC
	 xU78LGDPhVWWQ==
Message-ID: <c7f895b1-4f48-4d41-91ed-26ca857e3665@kernel.org>
Date: Mon, 21 Jul 2025 13:13:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
 David Arcari <darcari@redhat.com>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250721181155.3536023-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/25 1:11 PM, Yazen Ghannam wrote:
> The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
> commonly used error response from hardware. This may occur due to a real
> hardware issue or when running in a VM.
> 
> The user will see all reset reasons reported in this case.
> 
> Check for an error response value and return early to avoid decoding
> invalid data.
> 
> Also, adjust the data variable type to match the hardware register size.
> 
> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
> Reported-by: Libing He <libhe@redhat.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   arch/x86/kernel/cpu/amd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 50f88fe51816..db0f9e0d181a 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1274,8 +1274,8 @@ static const char * const s5_reset_reason_txt[] = {
>   
>   static __init int print_s5_reset_status_mmio(void)
>   {
> -	unsigned long value;
>   	void __iomem *addr;
> +	u32 value;
>   	int i;
>   
>   	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> @@ -1288,12 +1288,16 @@ static __init int print_s5_reset_status_mmio(void)
>   	value = ioread32(addr);
>   	iounmap(addr);
>   
> +	/* Value with "all bits set" is an error response and should be ignored. */
> +	if (value == U32_MAX)
> +		return 0;
> +
>   	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
>   		if (!(value & BIT(i)))
>   			continue;
>   
>   		if (s5_reset_reason_txt[i]) {
> -			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
> +			pr_info("x86/amd: Previous system reset reason [0x%08x]: %s\n",
>   				value, s5_reset_reason_txt[i]);
>   		}
>   	}
> 
> base-commit: 65f55a30176662ee37fe18b47430ee30b57bfc98


