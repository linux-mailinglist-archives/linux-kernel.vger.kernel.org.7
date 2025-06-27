Return-Path: <linux-kernel+bounces-707242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63381AEC1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DF1C25FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A02ED17E;
	Fri, 27 Jun 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfI1AITn"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C67283FE5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057950; cv=none; b=FtYte7R53t6w2X61SkXOsMSyIXOTYEjcrZdJJtrlfoHgC2mNl+6iupaXAB6/iZbyU16YORpmOO9Z+0xvGm2F8pBjkW/GyM3C4SE9Sn1XkaDn8su+Dc74/Oz6d1AXC3eJud74S6u9nX0oVd4yJzMUczVIuk0zKzjBXRnMZ7QeOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057950; c=relaxed/simple;
	bh=BJHMEo9leoyZcQsWcz07yan36ZR+YCCT0eJNiuD+11U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX+dNhJgjdTCsdTRleDR7aoA77qGweratnk36/kgK3kUpCio/1tDHMy6Y7gV/i6wTzrMt8BUCi96prlys3trXWlZmplQ/Daqk4On+JabNi3inaOBuazpdVV89xmNZOG3gB69wf7Wdg6zApi/vIX5Db4Sx/ZZ6wTuXhzb9hKLZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tfI1AITn; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c14138668so713484a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751057947; x=1751662747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wV6kmtjaXoJhYH43GcjyzCRIzSzOgOl5IbM4yLkCiQ=;
        b=tfI1AITn00FRyP6eqYASVODFEgtCUkF1415ETEW6fimhbj2qq0vgYODkHy1NW2tkzI
         t1OIXN8+L8/2Lz4TA5om/mbxjjRlg1DlZiqE+tReo5wlswRfJbYsMPR0yWdX7A9ibDOb
         jun2jHygrgsm5R8uxOIFrDRniounyzqNSX9r/dX+6mkMODMqniItZQp26SJhZ9BcdAdl
         P6prqWHzVppV9fisSCq2Dwvq028dTfQKw1eu7W6+WNDxjZJ81GpYq9GaDoFp3q8/kaKE
         uZka3GY77nPCqnVOyS5VQUkNpzjZ2MHm3E7PtYaW++eZN/heyEytZx03eBYt4ZcvOuwq
         hHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751057947; x=1751662747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wV6kmtjaXoJhYH43GcjyzCRIzSzOgOl5IbM4yLkCiQ=;
        b=ld3Hfkw3DRb7+Hm/JlzX4yHHsQm0ECYpGySv0jTrj7uOhBAjfOiOgbvr4nmg5LWbqI
         wRElP+XdG4j3i1RPx45HugE1Wm7Gchl8TU+AW9vpwTotxgXPaP0SYl7fUMgONs3jkvLS
         1WL54+WKvlx9HAuCfM+j/k7B103SzA27akPFAq+HuReYrLq8QMW/4bd8pIHSp9Rl0Mnj
         pmZDgk3WQrqx9qu8RtONYarNDiq7xQoo+TOJh0a9qcEdrilVuc5yRi1Egx/Wif7cMdiu
         WYtnys+viafwIzojxiF29AB6JptzzVElbGYAy4gcC++0o8xenSoW+t+T5XGKwguNVdW4
         DcnA==
X-Forwarded-Encrypted: i=1; AJvYcCWoHULk7VzDl13QvtbPdL4ORmtUXT+2iqQ9BoXIYBmWjZX7mYoa1zGQP0m6l6X1I+SeUI94eWZ3iPFOJmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzSESmy60KPyEWMyGpFxvunNXQYxMSujEqNH8P6RIg8WqyV8j
	y20VH00zrKGMQUT4fPVF4/LRzcD+yHt575XKZLxEReyy8+R+2erLMJtMM/ytInJq2f0=
X-Gm-Gg: ASbGnctloeW5m7Y3dd3uLifywSoMqcC939iWKAIvBn28K4GW2ltfgjhrAlIVkiYNS7a
	bb9gLv3hQw+gHzTaHu7GBPjYHAh7DZ8pAAx0re7l8CJOlmiafYhOG+Vk41nHwwi2xpUM1GTHtaO
	uMCU6RZBzhDsJM7nVT4Kf7OeSQnRoH9QJ1Otx/BgDkc1r9+UCf5lfMb5EZH6YoWmbkKeSAx65Es
	RKKzTV49AmN1w5qrCSoLH0fiHYhoJ4nYoO3kFKFKWuuca25h+VOe6vYX9vW8ycROwrEREZrgsyk
	I2Gsq5Z38OWZ06pZDF39+OaKVunta4cKTylxtf1pURfxtPsf2OR1pjD1XXV7hycCABX+vA==
X-Google-Smtp-Source: AGHT+IFHR7FVCi4j2zuoxohq1OuOeC2nyMBtdZkWi9Jmi1XSgKOeA4M9F6VWgzqg+UxjB1URtdOZSQ==
X-Received: by 2002:a05:6830:448c:b0:72c:3235:3b97 with SMTP id 46e09a7af769-73afc68a44cmr3352887a34.22.1751057946759;
        Fri, 27 Jun 2025 13:59:06 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e9c1:9891:4bfd:dadf])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73afb0e3d75sm513992a34.39.2025.06.27.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 13:59:06 -0700 (PDT)
Date: Fri, 27 Jun 2025 15:59:04 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_pkumpatl@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH v6 3/4] soundwire: qcom: Add set_channel_map api support
Message-ID: <33fe8fe7-719a-405a-9ed2-d9f816ce1d57@sabinyo.mountain>
References: <20250206112225.3270400-1-quic_mohs@quicinc.com>
 <20250206112225.3270400-4-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206112225.3270400-4-quic_mohs@quicinc.com>

On Thu, Feb 06, 2025 at 04:52:24PM +0530, Mohammad Rafi Shaik wrote:
> Added qcom_swrm_set_channel_map api to set the master channel mask for
> TX and RX paths based on the provided slots.
> 
> Added a new field ch_mask to the qcom_swrm_port_config structure.
> This field is used to store the master channel mask, which allows more
> flexible to configure channel mask in runtime for specific active
> soundwire ports.
> 
> Modified the qcom_swrm_port_enable function to configure master
> channel mask. If the ch_mask is set to SWR_INVALID_PARAM or is zero,
> the function will use the default channel mask.
> 
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soundwire/qcom.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 0f45e3404756..295a46dc2be7 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -156,6 +156,7 @@ struct qcom_swrm_port_config {
>  	u8 word_length;
>  	u8 blk_group_count;
>  	u8 lane_control;
> +	u8 ch_mask;
>  };
>  
>  /*
> @@ -1048,9 +1049,13 @@ static int qcom_swrm_port_enable(struct sdw_bus *bus,
>  {
>  	u32 reg = SWRM_DP_PORT_CTRL_BANK(enable_ch->port_num, bank);
>  	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +	struct qcom_swrm_port_config *pcfg;
>  	u32 val;
>  
> +	pcfg = &ctrl->pconfig[enable_ch->port_num];
>  	ctrl->reg_read(ctrl, reg, &val);
> +	if (pcfg->ch_mask != SWR_INVALID_PARAM && pcfg->ch_mask != 0)
> +		enable_ch->ch_mask = pcfg->ch_mask;
>  
>  	if (enable_ch->enable)
>  		val |= (enable_ch->ch_mask << SWRM_DP_PORT_CTRL_EN_CHAN_SHFT);
> @@ -1270,6 +1275,26 @@ static void *qcom_swrm_get_sdw_stream(struct snd_soc_dai *dai, int direction)
>  	return ctrl->sruntime[dai->id];
>  }
>  
> +static int qcom_swrm_set_channel_map(struct snd_soc_dai *dai,
> +				     unsigned int tx_num, const unsigned int *tx_slot,
> +				     unsigned int rx_num, const unsigned int *rx_slot)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
> +	int i;
> +
> +	if (tx_slot) {
> +		for (i = 0; i < tx_num; i++)
> +			ctrl->pconfig[i].ch_mask = tx_slot[i];
> +	}
> +
> +	if (rx_slot) {
> +		for (i = 0; i < rx_num; i++)
> +			ctrl->pconfig[i].ch_mask = rx_slot[i];
> +	}
> +
> +	return 0;
> +}
> +

Could we fix or revert this patch?  It's called like this from
sdm845_dai_init():

sound/soc/qcom/sdm845.c
   247          /*
   248           * Codec SLIMBUS configuration
   249           * RX1, RX2, RX3, RX4, RX5, RX6, RX7, RX8, RX9, RX10, RX11, RX12, RX13
   250           * TX1, TX2, TX3, TX4, TX5, TX6, TX7, TX8, TX9, TX10, TX11, TX12, TX13
   251           * TX14, TX15, TX16
   252           */
   253          unsigned int rx_ch[SLIM_MAX_RX_PORTS] = {144, 145, 146, 147, 148, 149,
   254                                          150, 151, 152, 153, 154, 155, 156};
   255          unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
   256                                              134, 135, 136, 137, 138, 139,
   257                                              140, 141, 142, 143};

[ snip ]

   304                  for_each_rtd_codec_dais(rtd, i, codec_dai) {
   305                          rval = snd_soc_dai_set_channel_map(codec_dai,
   306                                                            ARRAY_SIZE(tx_ch),
   307                                                            tx_ch,
   308                                                            ARRAY_SIZE(rx_ch),
   309                                                            rx_ch);
   310                          if (rval != 0 && rval != -ENOTSUPP)
   311                                  return rval;

There are 3 bugs:

Bug #1:
The zeroeth element of ctrl->pconfig[] is supposed to be unused.  We
start counting at 1.  However this code sets ctrl->pconfig[0].ch_mask = 128.

Bug #2:
There are SLIM_MAX_TX_PORTS (16) elements in tx_ch[] array but only
QCOM_SDW_MAX_PORTS + 1 (15) in the ctrl->pconfig[] array so it corrupts
memory like Yongqin Liu pointed out.

Bug 3:
Like Jie Gan pointed out, it erases all the tx information with the rx
information.

regards,
dan carpenter


