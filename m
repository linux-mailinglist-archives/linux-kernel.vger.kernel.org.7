Return-Path: <linux-kernel+bounces-850925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09985BD4C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9FD406829
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443B30C62A;
	Mon, 13 Oct 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGCxTKF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BFE21D596
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369827; cv=none; b=AG39k3vYCtwfb3B/vh11LrLhxsULfXoleD1JtAPXXnxcwW7CE78c0w5qvP2QHMphsKDEkexsdEQRa0siFQveDNMaCNhqKhu9L7JwpjaSj6o2Jzq1G4vFCs2LD2NDDIaMGSIvxVZwm9Bs9GIHTmQZgWnPyY5VQ6NIz9pmQoqPzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369827; c=relaxed/simple;
	bh=8MuQzutAvgwfH6ItFe+rC1moIpLkDvivEcHg0hxd8z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZvrqbu+CWVEB+619YqJOqiozTAWNOnnd0xgzDZXV8TV5KyjVwB+gfQLzXWnJNM4dpfAVUfe1T29BMLW8TozNZ4WRbYYHyCy9udNrlDq55lYAl9c5jqkVEh+oC5m570GWZctl7oG7UeEprnxlMlXe7xmWEBO2X/ZXXWvQvPgxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGCxTKF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C0CC4CEE7;
	Mon, 13 Oct 2025 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369826;
	bh=8MuQzutAvgwfH6ItFe+rC1moIpLkDvivEcHg0hxd8z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TGCxTKF9sRtyTYYBDlS0XIbddg6xnMMPTRb/3nG9ACaZKKHbDb+M9KnqM/sAJT+je
	 ANrj3aWMUXXw/uggCf1NEIYLKMwqfLXqjna/vtIMRwdUkOUHBNdd1mSdKrjJvMerGw
	 e7Z1989tuhKSTkipcQpb/vuIZK2WOwlWIGOUdcq2CuYDcc+OLzUJe/lN5twOpSBuNP
	 LUgy1F6O2CXZASfyHpZ6ttsinDIJUHPK4SaSo/y/F9slapi/XDv81VID9+bwfWWcDg
	 h4VTRBGXqaxBHRh6K8SvuQ1kikLEU2NxCwxJptsE/f+GGw5QqgN0rLL3A/UM2J/pz1
	 mUjFbxi27xovw==
Message-ID: <35819fb2-637a-4ba9-8652-0ca05951c5bb@kernel.org>
Date: Mon, 13 Oct 2025 10:37:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/CPU/AMD: Prevent reset reasons from being retained
 among boots
To: Rong Zhang <i@rong.moe>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 linux-kernel@vger.kernel.org
References: <20251010165959.49737-1-i@rong.moe>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251010165959.49737-1-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 11:59 AM, Rong Zhang wrote:
> The S5_RESET_STATUS register is parsed on boot and printed to kmsg.
> However, this could sometimes be misleading and lead to users wasting a
> lot of time on meaningless debugging for two reasons:
> 
> * Some bits are never cleared by hardware. It's the software's
> responsibility to clear them as per the Processor Programming Reference
> (see Link:).
> 
> * Some rare hardware-initiated platform resets do not update the
> register at all.
> 
> In both cases, a previous reboot could leave its trace in the register,
> resulting in users seeing unrelated reboot reasons while debugging
> random reboots afterward.
> 
> Clearing all reason bits solves the issue. Since all reason bits are
> write-1-to-clear and we must preserve all other bits, this is done by
> writing the read value back to the register.
> 
> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537#attach_303991
> Signed-off-by: Rong Zhang <i@rong.moe>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
> Changes in v2:
> - Remove a debug message (suggested by Borislav Petkov)
> - No longer mention this behavior in the documentation
> - Link to v1: https://lore.kernel.org/r/20250913144245.23237-1-i@rong.moe/
> ---
>   arch/x86/kernel/cpu/amd.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 5398db4dedb4a..ccaa51ce63f6e 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1355,11 +1355,23 @@ static __init int print_s5_reset_status_mmio(void)
>   		return 0;
>   
>   	value = ioread32(addr);
> -	iounmap(addr);
>   
>   	/* Value with "all bits set" is an error response and should be ignored. */
> -	if (value == U32_MAX)
> +	if (value == U32_MAX) {
> +		iounmap(addr);
>   		return 0;
> +	}
> +
> +	/*
> +	 * Clear all reason bits so they won't be retained if the next reset
> +	 * does not update the register. Besides, some bits are never cleared by
> +	 * hardware so it's software's responsibility to clear them.
> +	 *
> +	 * Writing the value back effectively clears all reason bits as they are
> +	 * write-1-to-clear.
> +	 */
> +	iowrite32(value, addr);
> +	iounmap(addr);
>   
>   	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
>   		if (!(value & BIT(i)))
> 
> base-commit: 7d24c651ce163bc04e7683ec75bf976b6ff042e2


