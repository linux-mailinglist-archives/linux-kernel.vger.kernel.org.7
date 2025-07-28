Return-Path: <linux-kernel+bounces-747864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6BB13941
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6F6189968B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937A24A06D;
	Mon, 28 Jul 2025 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYYvaVnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C9C245000;
	Mon, 28 Jul 2025 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699928; cv=none; b=UfVrXSO7IgUD9XKA1DWe7O32f4Y5I6n6pe1wAq6FEdnCAylhvBuThPBC6jzeS8cpDClb7Q/+6NUfCNCLlS+tDfS7VYHmJIbfnkUUAq3rqTv5CStZxDqTcOeYDMDA+V+ZYfm3wQH8XV0tr9jmUdpv16ZuYqORp41bpCzf9R7IiSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699928; c=relaxed/simple;
	bh=5xhS0LgHPXnMNMu7zQCvjpXnRD5j9EtWrqFbAN3k2r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amuLWmO/+pT5e+6OEJZsn80cVz6VyD4rUpcUpIpNfXrABRwxUJRXzGTjdNAiizh1HMzCI/EBwJtDzWXN8YMfoetQ9ePTIXfbc5q4R4nJRe6cLH1HslKhK6xn4b+g4EYjqfNDEZbPNgFbgRT6afqEoF8vyQpec1fCgFH/lCz5jEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hYYvaVnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C0C4CEE7;
	Mon, 28 Jul 2025 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753699927;
	bh=5xhS0LgHPXnMNMu7zQCvjpXnRD5j9EtWrqFbAN3k2r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYYvaVnw4+raQUimNXSJFUZKhQwO2aCBoJjZvCo7LhOivn7qRo0OXO0PyU9d/Bt2E
	 OT/JJLVvMYyhKFzkjB7oK1EPkPWdu3uQn9ufqK2+aSteVooWHiaq1xO5vBUF62iX5M
	 1IgaBC9oM7nBL4RWDNmSRMdAplhFbo7BwC/e7n7w=
Date: Mon, 28 Jul 2025 12:52:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Adjust pdm dmic gain using module
 parameter
Message-ID: <2025072814-stardom-anointer-0a62@gregkh>
References: <20250728094243.3824450-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728094243.3824450-1-venkataprasad.potturu@amd.com>

On Mon, Jul 28, 2025 at 03:12:27PM +0530, Venkata Prasad Potturu wrote:
> Adjust pdm dimc gain value using module param.
> In case of regressions for any users that the new pdm_gain value is
> too high and for additional debugging, introduce a module parameter
> that would let them configure it.
> 
> This parameter should be removed in the future:
>  * If it's determined that the parameter is not needed, just hardcode
>    the correct value as before
>  * If users do end up using it to debug and report different values
>    we should introduce a config knob that can have policy set by ucm.
> 
> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
> ---
>  sound/soc/amd/acp/acp-legacy-common.c | 3 ++-
>  sound/soc/amd/acp/acp-pdm.c           | 3 ++-
>  sound/soc/amd/acp/amd.h               | 6 +++++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
> index 57982d057c3a..dd804fb95790 100644
> --- a/sound/soc/amd/acp/acp-legacy-common.c
> +++ b/sound/soc/amd/acp/acp-legacy-common.c
> @@ -173,7 +173,8 @@ static void set_acp_pdm_clk(struct snd_pcm_substream *substream,
>  	/* Enable default ACP PDM clk */
>  	writel(PDM_CLK_FREQ_MASK, chip->base + ACP_WOV_CLK_CTRL);
>  	pdm_ctrl = readl(chip->base + ACP_WOV_MISC_CTRL);
> -	pdm_ctrl |= PDM_MISC_CTRL_MASK;
> +	pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL;
> +	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
>  	writel(pdm_ctrl, chip->base + ACP_WOV_MISC_CTRL);
>  	set_acp_pdm_ring_buffer(substream, dai);
>  }
> diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
> index 1bfc34c2aa53..ffb622a7a69a 100644
> --- a/sound/soc/amd/acp/acp-pdm.c
> +++ b/sound/soc/amd/acp/acp-pdm.c
> @@ -38,7 +38,8 @@ static int acp_dmic_prepare(struct snd_pcm_substream *substream,
>  	/* Enable default DMIC clk */
>  	writel(PDM_CLK_FREQ_MASK, chip->base + ACP_WOV_CLK_CTRL);
>  	dmic_ctrl = readl(chip->base + ACP_WOV_MISC_CTRL);
> -	dmic_ctrl |= PDM_MISC_CTRL_MASK;
> +	dmic_ctrl &= ~ACP_WOV_GAIN_CONTROL;
> +	dmic_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
>  	writel(dmic_ctrl, chip->base + ACP_WOV_MISC_CTRL);
>  
>  	period_bytes = frames_to_bytes(substream->runtime,
> diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
> index cb8d97122f95..f2567e06ccd3 100644
> --- a/sound/soc/amd/acp/amd.h
> +++ b/sound/soc/amd/acp/amd.h
> @@ -130,7 +130,7 @@
>  #define PDM_DMA_INTR_MASK       0x10000
>  #define PDM_DEC_64              0x2
>  #define PDM_CLK_FREQ_MASK       0x07
> -#define PDM_MISC_CTRL_MASK      0x10
> +#define ACP_WOV_GAIN_CONTROL	GENMASK(4, 3)
>  #define PDM_ENABLE              0x01
>  #define PDM_DISABLE             0x00
>  #define DMA_EN_MASK             0x02
> @@ -138,6 +138,10 @@
>  #define PDM_TIMEOUT             1000
>  #define ACP_REGION2_OFFSET      0x02000000
>  
> +static int pdm_gain = 3;
> +module_param(pdm_gain, int, 0644);
> +MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");

This is not the 1990's, please do not add new module parameters, it will
not work for modern systems and is a horrible thing to attempt to
support over time :(

Please do this properly, with a per-device setting.

thanks,

greg k-h

