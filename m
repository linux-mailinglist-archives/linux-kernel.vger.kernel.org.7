Return-Path: <linux-kernel+bounces-711467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35EEAEFB2E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC4D446795
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC22749CF;
	Tue,  1 Jul 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LSLLYyNu"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C34148FE6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377974; cv=none; b=V2kb37BjdWk/PzuYR3ansk7XdfxxyPq+r0jSbhmnqXW8+u6zOmzxKoyeB0BrdM/1hT9uE2pLO+dVtqO9Gn9ovOEYzEEQjvRVogf7Cy6cWIjykOfLttsIQsaYF7sGfIsLW3ZD9M1sGNWcJ/AT0OpO3OxxoCd0MV2TFhysYkL0iTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377974; c=relaxed/simple;
	bh=xOqytmxf6YBdT5xb94xf+MyiTuVkQdFOd5VE4UTac+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eEVpeqfbaKvRvtdWd3k0lmxl6CBNro3L/nf2TDaTeBhCKq/1ciDd7yZiBJ0pJrZmMbpRdb3i+9wnpIcIY7KkSfjlDK9A+davxj78YWTnbIuc4/VGxzljmQMbiNhEvchu8F7+YGWCXmAcFFN1J/p1OlRX4xE0ZAHduCFns7ZFGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LSLLYyNu; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 561DqRDe3641037;
	Tue, 1 Jul 2025 08:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751377947;
	bh=FTF/AEIXXqhNtk5GjBm/k+4avWMMlLyOk1QXMjnzEzw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LSLLYyNuy85WTCdydaSVQob0q35nEjejDPwacsHg1QZYspq75ShyOIWbxaCZB77gp
	 vdZBNkkkYyn4B2dKah4I68tzykGmxL8wrzsXuWoYcBZ1ytAQHfF87zDjlXUnj2jXRz
	 vHvkcBtjJ4EBBUOna4COPqqL3fVvXPC9dDXzhfKc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 561DqQUW274646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 1 Jul 2025 08:52:26 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 1
 Jul 2025 08:52:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 1 Jul 2025 08:52:26 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 561DqLhA1660820;
	Tue, 1 Jul 2025 08:52:23 -0500
Message-ID: <5ed30153-53e0-4f1f-9c45-2f2530b9034e@ti.com>
Date: Tue, 1 Jul 2025 19:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/tidss: oldi: Add atomic_check hook for oldi
 bridge
To: Jayesh Choudhary <j-choudhary@ti.com>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ideasonboard.com>, <mwalle@kernel.org>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>
References: <20250701095541.190422-1-j-choudhary@ti.com>
 <20250701095541.190422-4-j-choudhary@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250701095541.190422-4-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 01/07/25 15:25, Jayesh Choudhary wrote:
> Since OLDI consumes DSS VP clock directly as serial clock, certain
> checks cannot be performed in tidss driver which should be checked
> in oldi driver. Add check for mode clock and set the curr_max_pclk
> field for tidss in case the VP is OLDI.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_oldi.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 63e07c8edeaa..a1f5fb39b32c 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -309,6 +309,29 @@ static u32 *tidss_oldi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>   	return input_fmts;
>   }
>   
> +static int tidss_oldi_bridge_atomic_check(struct drm_bridge *bridge,
> +					  struct drm_bridge_state *bridge_state,
> +					  struct drm_crtc_state *crtc_state,
> +					  struct drm_connector_state *conn_state)
> +{
> +	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
> +	struct drm_display_mode *adjusted_mode;
> +	unsigned long round_clock;
> +
> +	adjusted_mode = &crtc_state->adjusted_mode;
> +
> +	if (adjusted_mode->clock > oldi->tidss->curr_max_pclk[oldi->parent_vp]) {
> +		round_clock = clk_round_rate(oldi->serial, adjusted_mode->clock * 7 * 1000);
> +
> +		if (dispc_pclk_diff(adjusted_mode->clock * 7 * 1000, round_clock) > 5)
> +			return -EINVAL;
> +
> +		oldi->tidss->curr_max_pclk[oldi->parent_vp] = round_clock;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
>   	.attach	= tidss_oldi_bridge_attach,
>   	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
> @@ -317,6 +340,7 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>   	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_check = tidss_oldi_bridge_atomic_check,


Nitpick: looks like some mismatch in naming convention.
We don't use bridge for other atomic calls for e.g. 
tidss_oldi_atomic_pre_enable, tidss_oldi_atomic_post_disable so maybe 
change those too ?

With suggested change,

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

>   };
>   
>   static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)

