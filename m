Return-Path: <linux-kernel+bounces-845564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A6BC5617
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0728934EE41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37128CF66;
	Wed,  8 Oct 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2zrPpkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74722874E0;
	Wed,  8 Oct 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932394; cv=none; b=ULZCAV2oPRbhwsj48SyLXjRgiN+t8mAh8cSFP+29L4gsBlwpeNdPCfemN89JRgjzGRUeeN6x7yuxTQwvvbMtOgtzrmU6DgbMB6i9WyfK/Hm1SBQUDA4zNjOk4kT18Gd4ipZ96psFURSKz2+Tn1kV+v02vC4sgy713xUru1059YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932394; c=relaxed/simple;
	bh=BuwQI0ywp1QTrfR2PtbUc2upP5PnlKtENsOpFyFhISE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oURG4Zw1Ao+lMZDUrdWv6DkxRqUavswSMAl8zKscgpzTk4tc21TuqdC2odQ2dsNhJHz1Og2e2m+mUpsVYfX94IGuDXPP1Z3XqJhQSuC+z/VGAvJoMdLMgrtcHgSGbEikidbfBy01xeo/Z8ZWZv1UBwZmgvvCps0O9j8WYhcnNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2zrPpkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F64C4CEE7;
	Wed,  8 Oct 2025 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932393;
	bh=BuwQI0ywp1QTrfR2PtbUc2upP5PnlKtENsOpFyFhISE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q2zrPpkgOWoOQJrVrNbEQKUzRJ2io4s8pRUZGfmmj5zYZCF4Pt0TWLWf36IZ7eKii
	 aVwBqsb5B4VoD3Q9NDgKSBpM0J29A9mAB/7PltfhZUbxAIMeNsKbPGohqNWI0B8nor
	 7ubN0WtAMrOoUo/Su9QMmEFU/dBLBLchl1B/dS3CoEqCmOL2+FiipvccyMLgLLaFrH
	 I9G4ZUwmI7kftqojDsgR1idpL3h2djmCahxdYn8Bu4PaMEdIT8lY7CU3+0mNUmQ6jt
	 6AB8oCPx/q/prmLsRIUYODU4JNtotuT+SyP45MGOy5GpND+8AWLcuafswlamNKHkAi
	 O95eMlomOH+9Q==
Message-ID: <f6d4145b-3295-4a98-9074-d4d1b7b466ae@kernel.org>
Date: Wed, 8 Oct 2025 09:06:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc
 quirk list
To: Antheas Kapenekakis <lkml@antheas.dev>, Shyam-sundar.S-k@amd.com,
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20251008135057.731928-1-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251008135057.731928-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/25 8:50 AM, Antheas Kapenekakis wrote:
> The Lenovo Legion Go 2 takes a long time to resume from suspend.
> This is due to it having an nvme resume handler that interferes
> with IOMMU mappings. It is a common issue with older Lenovo
> laptops. Adding it to that quirk list fixes this issue.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4618
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

This makes sense for BIOS in the field.
If this is fixed in the BIOS later I'd like to narrow the quirk at a 
later time.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> index d63aaad7ef59..0fadcf5f288a 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -204,6 +204,23 @@ static const struct dmi_system_id fwbug_list[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "82ND"),
>   		}
>   	},
> +	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4618 */
> +	{
> +		.ident = "Lenovo Legion Go 2",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83N0"),
> +		}
> +	},
> +	{
> +		.ident = "Lenovo Legion Go 2",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83N1"),
> +		}
> +	},
>   	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
>   	{
>   		.ident = "HP Laptop 15s-eq2xxx",
> 
> base-commit: a8cdf51cda30f7461a98af821e8a28c5cb5f8878


