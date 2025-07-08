Return-Path: <linux-kernel+bounces-722009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BDAFD14B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302465406D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D32E54BC;
	Tue,  8 Jul 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6+0vH5a"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2202E54BA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992360; cv=none; b=WSspYhpZzB7GrhKo57YMJHcO9qMdUGKVchyhcq8xNIT/pKCqRUmyM2VW0MVgrUoFnvgGMJMA/RW1lWyqhbcncMY0uGtbdfGtXPFkvh/kcqT0NwrkdweaYHgv3LBKc6oTC5f68sTVgY1bMaccFniAmwZWbqrnDo3xexIoUz6/2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992360; c=relaxed/simple;
	bh=UkfHBsqdz7N0mB/ok7ci89RDt7SqgAI+lZvYLAOC7To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFFanj17cEAX1X7O+2I45+cH84D/pSPsMiSQsBnD+8Rq6gqVubW5CIkF7/bK5DQscPMw1+pyVCd+TMEhvLrIdQPlQy6Qs3xIO7NtTy5eyxCuQPNfzO7JQT+Qr5Fz1qr2RKkSNQ1qAymDmLpw1jAe22B+imFi4FBj1SykzCs2E88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6+0vH5a; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748d982e92cso2889904b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751992357; x=1752597157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6KkAnrKypw5hoAxJZFriVdg9SAqRfE36aEuojSYIT0=;
        b=z6+0vH5apO/Ea+cNX8vO6EbFe+KzZrwGjUaN4K/SXVWgmXRIPRgKlFcJPNBYeI0mmi
         WaHVIiQyToCvv/PJ93UlafmTwTMf8yunH4b48QACeZ1rrja8XMyRF7QRz+/MKDzx3M7o
         K0NeBybK/HdENWqHuwzzWvO+MLIfgYsWNnRauoOkGpU3Jge579Ox4JKJsU26x+UGO1Kq
         zUJvl8WG3hg8yI2btpgxlhqG7162sXRWxxKUoMiFI9yuD5XIlqZYCPWNQo0P9dzJjSMr
         0S4jsn3Nq4m/8V51A4Tij7GLoerMz17rXgWnbC3tZNueQSgC40kpfR/Jez16UijgxV3B
         YtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992357; x=1752597157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6KkAnrKypw5hoAxJZFriVdg9SAqRfE36aEuojSYIT0=;
        b=Im+G2XlbRe/ErEjbbTK9AVRqC4bWhQK9tIbAEwfxsD0SY+/G7d47Ux56y2s4zjlgcq
         esrjgjtVQgMH/ee/XGg2fHt9b26rJMdReU13Ld7IXsU8QVKC6/Sjw011ceidQ5P2A+Cm
         CTX9vWLSPnPjhCr535KFxiA+zGM+aUpAZ6sgLRGByIZc3GXYOYAO95b5qY2aDgXFUi4+
         8kV3wvxwGrlNd9dM1KUqYO/h7tRpDX9XveQYsALFjmU1bwcI0peXYSAFGpBbVeaTxAW9
         OAYHxgvmZC552A+ezgQOVraeWPY5jZsES+ZaxK1sgvZqxcFXtj2ztHpGqDvJGtbALZUt
         JrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT3BKYXh/m1sauydCsGkfGCT+z7rbHzOSSFNzbqrsBDQFWf870KWu5E6Wl10/ZlMqn9ItDW8NLReiTz8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQdXtVC/pAmrjF200MVEVamJd/RdxKhBVzWiyPmDOCi2I8pOn
	TWnFAUc0owHH+qfrH/CNBc7p+P+ZwPhBWjVarNeKoEofR85EXJDFyo8a2yQxDegw/3Y=
X-Gm-Gg: ASbGncuJG9spapHjJC5ZHmnxFCEj7Q+KhMFG7ejw5LFSggJg/d0jE1ifGzx6f7EReRQ
	C4xEYGpWomfFOyb3K14FgzS1uwTyRvvBNnkXLpWwhPL7HZHbJO4BT8Ov3zbgiQ9wj7lyQD/E/9W
	KrrPkeNovTgGB+KXBdR/O+gpXpgaTgAQMbUi92ncQbmqdyAcJF1/Co2FGF7EnL/3HecNeikv9OB
	amlUKRT8cfyIBBTxsI0QAWmEj2MIzvhyfhZT21hGoPIPgGB0mw96YRMmNaTEUjuuI3fPjFxmpGM
	YD1lvCMkCBYHPUWO+nHUo9w1E6Sn/N7dNyxj8LQc8HLEc391H1Bc3IbHU6eGl+eTzw==
X-Google-Smtp-Source: AGHT+IHMpvanChrXFUM/s7IduMsHOQVHfmC468INl9tzFvFAT0Xze9+3AEYdC5EP2sv3V2bmamfBhA==
X-Received: by 2002:a05:6a00:2ea7:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-74e4abc41e9mr95206b3a.23.1751992357404;
        Tue, 08 Jul 2025 09:32:37 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c5cf:9364:ea5e:99f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359f53fsm12188694b3a.20.2025.07.08.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:32:36 -0700 (PDT)
Date: Tue, 8 Jul 2025 10:32:34 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 2/5] remoteproc: imx_rproc: Add support for System
 Manager API
Message-ID: <aG1IIk42q8OmGsQH@p14s>
References: <20250625-imx95-rproc-1-v3-0-699031f5926d@nxp.com>
 <20250625-imx95-rproc-1-v3-2-699031f5926d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-imx95-rproc-1-v3-2-699031f5926d@nxp.com>

Good day,

On Wed, Jun 25, 2025 at 10:23:28AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 features a Cortex-M33 core, six Cortex-A55 cores, and
> one Cortex-M7 core. The System Control Management Interface(SCMI)
> firmware runs on the M33 core. The i.MX95 SCMI firmware named System
> Manager(SM) includes vendor extension protocols, Logical Machine
> Management(LMM) protocol and CPU protocol and etc.
> 
> There are three cases for M7:
>  (1) M7 in a separate Logical Machine(LM) that Linux can't control it.
>  (2) M7 in a separate Logical Machine that Linux can control it using
>      LMM protocol
>  (3) M7 runs in same Logical Machine as A55, so Linux can control it
>      using CPU protocol
> 
> So extend the driver to using LMM and CPU protocol to manage the M7 core.
>  - Add IMX_RPROC_SM to indicate the remote core runs on a SoC that
>    has System Manager.
>  - Compare linux LM ID(got using scmi_imx_lmm_info) and M7 LM ID(the ID
>    is fixed as 1 in SM firmware if M7 is in a seprate LM),
>    if Linux LM ID equals M7 LM ID(linux and M7 in same LM), use CPU
>    protocol to start/stop. Otherwise, use LMM protocol to start/stop.
>    Whether using CPU or LMM protocol to start/stop, the M7 status
>    detection could use CPU protocol to detect started or not. So
>    in imx_rproc_detect_mode, use scmi_imx_cpu_started to check the
>    status of M7.
>  - For above case 1 and 2, Use SCMI_IMX_LMM_POWER_ON to detect whether
>    the M7 LM is under control of A55 LM.
>

Thanks for the context, it really helps.

 
> Current setup relies on pre-Linux software(U-Boot) to do
> M7 TCM ECC initialization. In future, we could add the support in Linux
> to decouple U-Boot and Linux.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 113 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/remoteproc/imx_rproc.h |   5 ++
>  2 files changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 74299af1d7f10a0db794de494c52304b2323b89f..b1a117ca5e5795554b67eb7092db2a25fc7de13b 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -8,6 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/firmware/imx/sci.h>
> +#include <linux/firmware/imx/sm.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_client.h>
> @@ -21,6 +22,7 @@
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> +#include <linux/scmi_imx_protocol.h>
>  #include <linux/workqueue.h>
>  
>  #include "imx_rproc.h"
> @@ -91,6 +93,11 @@ struct imx_rproc_mem {
>  #define ATT_CORE_MASK   0xffff
>  #define ATT_CORE(I)     BIT((I))
>  
> +/* Logical Machine Operation */
> +#define IMX_RPROC_FLAGS_SM_LMM_OP	BIT(0)
> +/* Linux has permission to handle the Logical Machine of remote cores */
> +#define IMX_RPROC_FLAGS_SM_LMM_AVAIL	BIT(1)
> +
>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block);
>  static void imx_rproc_free_mbox(struct rproc *rproc);
>  
> @@ -115,6 +122,8 @@ struct imx_rproc {
>  	u32				entry;		/* cpu start address */
>  	u32				core_index;
>  	struct dev_pm_domain_list	*pd_list;
> +	/* For i.MX System Manager based systems */
> +	u32				flags;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -393,6 +402,30 @@ static int imx_rproc_start(struct rproc *rproc)
>  	case IMX_RPROC_SCU_API:
>  		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
>  		break;
> +	case IMX_RPROC_SM:
> +		if (priv->flags & IMX_RPROC_FLAGS_SM_LMM_OP) {
> +			if (!(priv->flags & IMX_RPROC_FLAGS_SM_LMM_AVAIL))
> +				return -EACCES;
> +
> +			ret = scmi_imx_lmm_reset_vector_set(dcfg->lmid, dcfg->cpuid, 0, 0);
> +			if (ret) {
> +				dev_err(dev, "Failed to set reset vector lmid(%u), cpuid(%u): %d\n",
> +					dcfg->lmid, dcfg->cpuid, ret);
> +			}
> +
> +			ret = scmi_imx_lmm_operation(dcfg->lmid, SCMI_IMX_LMM_BOOT, 0);
> +			if (ret)
> +				dev_err(dev, "Failed to boot lmm(%d): %d\n", ret, dcfg->lmid);
> +		} else {
> +			ret = scmi_imx_cpu_reset_vector_set(dcfg->cpuid, 0, true, false, false);
> +			if (ret) {
> +				dev_err(dev, "Failed to set reset vector cpuid(%u): %d\n",
> +					dcfg->cpuid, ret);
> +			}
> +
> +			ret = scmi_imx_cpu_start(dcfg->cpuid, true);
> +		}
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -435,6 +468,16 @@ static int imx_rproc_stop(struct rproc *rproc)
>  	case IMX_RPROC_SCU_API:
>  		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
>  		break;
> +	case IMX_RPROC_SM:
> +		if (priv->flags & IMX_RPROC_FLAGS_SM_LMM_OP) {
> +			if (priv->flags & IMX_RPROC_FLAGS_SM_LMM_AVAIL)
> +				ret = scmi_imx_lmm_operation(dcfg->lmid, SCMI_IMX_LMM_SHUTDOWN, 0);
> +			else
> +				ret = -EACCES;
> +		} else {
> +			ret = scmi_imx_cpu_start(dcfg->cpuid, false);
> +		}
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -549,9 +592,11 @@ static int imx_rproc_prepare(struct rproc *rproc)
>  {
>  	struct imx_rproc *priv = rproc->priv;
>  	struct device_node *np = priv->dev->of_node;
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
>  	struct of_phandle_iterator it;
>  	struct rproc_mem_entry *mem;
>  	struct reserved_mem *rmem;
> +	int ret;
>  	u32 da;
>  
>  	/* Register associated reserved memory regions */
> @@ -592,6 +637,38 @@ static int imx_rproc_prepare(struct rproc *rproc)
>  		rproc_add_carveout(rproc, mem);
>  	}
>  
> +	switch (dcfg->method) {
> +	case IMX_RPROC_SM:
> +		if (!(priv->flags & IMX_RPROC_FLAGS_SM_LMM_OP))
> +			break;
> +		/*
> +		 * Power on the Logical Machine to make sure TCM is available.
> +		 * Also serve as permission check. If in different Logical
> +		 * Machine, and linux has permission to handle the Logical
> +		 * Machine, set IMX_RPROC_FLAGS_SM_LMM_AVAIL.
> +		 */
> +		ret = scmi_imx_lmm_operation(dcfg->lmid, SCMI_IMX_LMM_POWER_ON, 0);
> +		if (ret == 0) {
> +			dev_info(priv->dev, "lmm(%d) powered on\n", dcfg->lmid);
> +			priv->flags |= IMX_RPROC_FLAGS_SM_LMM_AVAIL;

This is set all the time imx_rproc_prepare() is called - isn't there a way to
set it once at initialisation time?

> +		} else if (ret == -EACCES) {
> +			dev_info(priv->dev, "lmm(%d) not under Linux Control\n", dcfg->lmid);
> +			/*
> +			 * If remote cores boots up in detached mode, continue;
> +			 * else linux has no permission, return -EACCES.
> +			 */
> +			if (priv->rproc->state != RPROC_DETACHED)
> +				return -EACCES;
> +		} else if (ret) {
> +			dev_err(priv->dev, "Failed to power on lmm(%d): %d\n", ret, dcfg->lmid);
> +			return ret;
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	};
> +

Please put this in a function and get rid of the switch{}.

>  	return  0;
>  }
>  
> @@ -911,13 +988,41 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  	struct regmap_config config = { .name = "imx-rproc" };
>  	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
>  	struct device *dev = priv->dev;
> +	struct scmi_imx_lmm_info info;
>  	struct regmap *regmap;
>  	struct arm_smccc_res res;
> +	bool started = false;
>  	int ret;
>  	u32 val;
>  	u8 pt;
>  
>  	switch (dcfg->method) {
> +	case IMX_RPROC_SM:
> +		/* Get current Linux Logical Machine ID */
> +		ret = scmi_imx_lmm_info(LMM_ID_DISCOVER, &info);
> +		if (ret) {
> +			dev_err(dev, "Failed to get current LMM ID err: %d\n", ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * Check whether remote processor is in same Logical Machine as Linux.
> +		 * If no, need use Logical Machine API to manage remote processor, and
> +		 * set IMX_RPROC_FLAGS_SM_LMM_OP.
> +		 * If yes, use CPU protocol API to manage remote processor.
> +		 */
> +		if (dcfg->lmid != info.lmid) {
> +			priv->flags |= IMX_RPROC_FLAGS_SM_LMM_OP;
> +			dev_info(dev, "Using LMM Protocol OPS\n");
> +		} else {
> +			dev_info(dev, "Using CPU Protocol OPS\n");
> +		}
> +
> +		scmi_imx_cpu_started(dcfg->cpuid, &started);

Function scmi_imx_cpu_started() returns a value that is not taken into account.

> +		if (started)
> +			priv->rproc->state = RPROC_DETACHED;
> +
> +		return 0;
>  	case IMX_RPROC_NONE:
>  		priv->rproc->state = RPROC_DETACHED;
>  		return 0;
> @@ -1029,8 +1134,12 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
>  	struct device *dev = priv->dev;
>  	int ret;
>  
> -	/* Remote core is not under control of Linux */
> -	if (dcfg->method == IMX_RPROC_NONE)
> +	/*
> +	 * IMX_RPROC_NONE indicates not under control of Linux.
> +	 * System Manager(SM) firmware automatically configures clock,
> +	 * so bypass the clk settings for IMX_RPROC_SM.
> +	 */
> +	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SM)
>  		return 0;
>  
>  	priv->clk = devm_clk_get(dev, NULL);
> diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
> index cfd38d37e1467d1d9e6f89be146c0b53262b92a0..6fe8d975ed302967f27b7a4319a899e6f0822976 100644
> --- a/drivers/remoteproc/imx_rproc.h
> +++ b/drivers/remoteproc/imx_rproc.h
> @@ -26,6 +26,8 @@ enum imx_rproc_method {
>  	IMX_RPROC_SCU_API,
>  	/* Through Reset Controller API */
>  	IMX_RPROC_RESET_CONTROLLER,
> +	/* Through System Manager */
> +	IMX_RPROC_SM,
>  };
>  
>  /* dcfg flags */
> @@ -42,6 +44,9 @@ struct imx_rproc_dcfg {
>  	size_t				att_size;
>  	enum imx_rproc_method		method;
>  	u32				flags;
> +	/* For System Manager(SM) based SoCs, the IDs are from SM firmware */
> +	u32				cpuid;
> +	u32				lmid;
>  };
>  
>  #endif /* _IMX_RPROC_H */
> 
> -- 
> 2.37.1
> 

