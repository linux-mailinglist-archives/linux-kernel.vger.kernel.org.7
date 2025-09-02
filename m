Return-Path: <linux-kernel+bounces-797020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9AB40ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446FB2080CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978FF338F22;
	Tue,  2 Sep 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwaqhQ3q"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468433EAF9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831135; cv=none; b=gRyNbz0JxjSbZo2+57MVH655/mj4OBWrBpI/M5xL86RmoLKry8fvQad/x1sYNoozlNDpn4bz0PLszulkO6x1UV2cL2EGk0Y/ghXwQ/3rNDaIFJB7/2jJsM0aNuPGse1TEWc+EhIMhoZckyBaTCiPRFJm4pUB2vsso4Xk0fmzW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831135; c=relaxed/simple;
	bh=2hiLXTYOUv7ZT+8Xe0OHkx15c5hqbSE6YBNNLMdNdyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQgEmkYf637fZ38mj6ABn4hUmeqXJSvUS1W+KBz+E8u6Iyn6Sbm5R9wSTfYR4dzZFmiy6mTIK37+07VpGr8sJ69GqV2uj6IVaqSitdWiPicrdTNLMVOu65Kao3kGfqRQnRMrlU46RT3WmFfIEhbGUYhuU9DyRmjpa00L/VZ4WkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwaqhQ3q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-772627dd50aso66206b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756831133; x=1757435933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXBUwB6riv6anGuWowZRcLSzUYer/ZJs0DMzJRXqBAA=;
        b=nwaqhQ3qQNtjCuYu7Cz6PCbC5E5VimZj07JI7C1V7qAfpR8RC0q5gcuilmid2OYuRJ
         uOTGBffv/Qw5tpphfUFIkrKTP3x6DFrLZFH6ZOh/+MD8fM6A9fNxut6QkQtzEQ/oFLZ9
         x/TO+6smqPiUhqpFsIwvi6b4UrxcjY3QsPZosxmlzTsAUrtyjnsW+9Qche5aNmVo+UM6
         7CEzHp8nhzqPjJzPisL+xyG5rTrRjutlMxXm50eCUhnSO1L3uUhHkas9aQOYmRY98D2m
         0lF2+KJBnbk3JMoa2PT8S6xygtdw4ulX2md7JivV3+2Bpsz4OYd26aO5bQIbI4dCvWui
         PI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831133; x=1757435933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXBUwB6riv6anGuWowZRcLSzUYer/ZJs0DMzJRXqBAA=;
        b=Q7ByzFziMBBbdjN+rPekiFo4c0Bx/XMj2D9GXmnSwE2Zk2GiCCjku/ijIX1dRLxxR3
         oIh0nTy7ZFEFTbjULuQyJ+u46N9tV+mpjtLO0bxHghYfNHuuxdYTp8JzTmVJxAE7gdFN
         wZkq+ni88hPlfoOlESc2r+SQF6fJBLefC3VeQdKFXO8mxvKycOTAOMb21MrkD/we0yoD
         yzkdSd4z18O8hmudYewCU3EtUv1I5xj9yNC9r8AX6ljoe87ew9rz1kuLTT257zbI1v2V
         BxadHUT+dWK2iGcfAc+leTVgWgHEfdPH205/NXtAT6CI9NCC4OR4QV/btMm2I1OW8zy/
         kXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKIi+GAt9ot/TI42iMj6AvYrwZ6cOjk5cqkGkhpcu8wmlgdBLv3nruOiVk71odVrQQE1YZeb2Ku92KMog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwecKEKbBOaNWO/BQaY/iK4B9EtUVBM0y5R9HQt7aWkPucXfktk
	gzQXr/DV1jCsz5QraLdz2ZqCTM5Rd4fROr5Abw7aOC1djM2YQk31xMGYCSdgfFXXh4A=
X-Gm-Gg: ASbGncuQ4UbykGwM3aWT2rbvc0Ac/toOw4KzInHSrdS1PhZcTCkkZ30t5muHPPbO5ZY
	Ec80E/vArjlgAnWPh/13OV47qZuVfuOfEFbCh8GjEabmYSqwhDZgVVpjRMFK88NIzpVsv1Hrwk5
	b7HNIOv/Ooz8U8ArX8XATO1oMgq2+oPT7F93CRcTDmsk6JNDW1gdrcBccDiI3MINp1ewAsM2XKH
	jbSTRsnMv3rYFKLrxdmBK6mRcxg9NBM0ly+FRKLBXLn1vWGkTOpRTlab15oD6rfaKFesEaG2GlL
	Qz1IbHiGpyRllZgnvu350+jPTxwnqwQtg06UFRp58Onbc+/TPNbiehuc14RF2tH1AV+A9Im7Ilf
	gw3/tyH2jsvCsIRiwx4Vt5pNYsMf0AhpEwk7iG6OPMaCxExgI3gd7ucOeKFIHWKNi4q2jM4HPmS
	PZqhKwxMHl1UYGGRjK6OC2aVYRuILvbnzs14o=
X-Google-Smtp-Source: AGHT+IEeDLgFOBjXxbJ/YLJ/SF9khStqJW4YrZ8PIFvkVTEmJPvZRH8PlrIDW8LLNusvSklsV66ErA==
X-Received: by 2002:a05:6a20:244c:b0:243:6f68:a2f6 with SMTP id adf61e73a8af0-243d51b0c03mr14553396637.20.1756831132641;
        Tue, 02 Sep 2025 09:38:52 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9b21:5c26:1409:23e9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28aecd0sm12394758a12.30.2025.09.02.09.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:38:51 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:38:49 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] remoteproc: imx_rproc: Add support for System
 Manager API
Message-ID: <aLcdmY-gqd5cFOYc@p14s>
References: <20250821-imx95-rproc-1-v5-0-e93191dfac51@nxp.com>
 <20250821-imx95-rproc-1-v5-2-e93191dfac51@nxp.com>
 <aLHOhKpAQbVCC76-@p14s>
 <20250830125208.GA22718@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830125208.GA22718@nxa18884-linux.ap.freescale.net>

On Sat, Aug 30, 2025 at 08:52:09PM +0800, Peng Fan wrote:
> On Fri, Aug 29, 2025 at 10:00:04AM -0600, Mathieu Poirier wrote:
> >Good day,
> >
> >On Thu, Aug 21, 2025 at 05:05:05PM +0800, Peng Fan wrote:
> >> i.MX95 features a Cortex-M33 core, six Cortex-A55 cores, and
> >> one Cortex-M7 core. The System Control Management Interface(SCMI)
> >> firmware runs on the M33 core. The i.MX95 SCMI firmware named System
> >> Manager(SM) includes vendor extension protocols, Logical Machine
> >> Management(LMM) protocol and CPU protocol and etc.
> >> 
> >> There are three cases for M7:
> >>  (1) M7 in a separate Logical Machine(LM) that Linux can't control it.
> >>  (2) M7 in a separate Logical Machine that Linux can control it using
> >>      LMM protocol
> >>  (3) M7 runs in same Logical Machine as A55, so Linux can control it
> >>      using CPU protocol
> >> 
> >> So extend the driver to using LMM and CPU protocol to manage the M7 core.
> >>  - Add IMX_RPROC_SM to indicate the remote core runs on a SoC that
> >>    has System Manager.
> >>  - Compare linux LM ID(got using scmi_imx_lmm_info) and M7 LM ID(the ID
> >>    is fixed as 1 in SM firmware if M7 is in a seprate LM),
> >>    if Linux LM ID equals M7 LM ID(linux and M7 in same LM), use CPU
> >>    protocol to start/stop. Otherwise, use LMM protocol to start/stop.
> >>    Whether using CPU or LMM protocol to start/stop, the M7 status
> >>    detection could use CPU protocol to detect started or not. So
> >>    in imx_rproc_detect_mode, use scmi_imx_cpu_started to check the
> >>    status of M7.
> >>  - For above case 1 and 2, Use SCMI_IMX_LMM_POWER_ON to detect whether
> >>    the M7 LM is under control of A55 LM.
> >> 
> >> Current setup relies on pre-Linux software(U-Boot) to do
> >> M7 TCM ECC initialization. In future, we could add the support in Linux
> >> to decouple U-Boot and Linux.
> >> 
> >> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  drivers/remoteproc/Kconfig     |   2 +
> >>  drivers/remoteproc/imx_rproc.c | 123 ++++++++++++++++++++++++++++++++++++++++-
> >>  drivers/remoteproc/imx_rproc.h |   5 ++
> >>  3 files changed, 127 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index 48a0d3a69ed08057716f1e7ea950899f60bbe0cf..ee54436fea5ad08a9c198ce74d44ce7a9aa206de 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -27,6 +27,8 @@ config IMX_REMOTEPROC
> >>  	tristate "i.MX remoteproc support"
> >>  	depends on ARCH_MXC
> >>  	depends on HAVE_ARM_SMCCC
> >> +	depends on IMX_SCMI_CPU_DRV || !IMX_SCMI_CPU_DRV
> >> +	depends on IMX_SCMI_LMM_DRV || !IMX_SCMI_LMM_DRV
> >>  	select MAILBOX
> >>  	help
> >>  	  Say y here to support iMX's remote processors via the remote
> >> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> >> index a6eef0080ca9e46efe60dcb3878b9efdbdc0f08e..151b9ca34bac2dac9df0ed873f493791f2d1466e 100644
> >> --- a/drivers/remoteproc/imx_rproc.c
> >> +++ b/drivers/remoteproc/imx_rproc.c
> >> @@ -8,6 +8,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/err.h>
> >>  #include <linux/firmware/imx/sci.h>
> >> +#include <linux/firmware/imx/sm.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/mailbox_client.h>
> >> @@ -22,6 +23,7 @@
> >>  #include <linux/reboot.h>
> >>  #include <linux/regmap.h>
> >>  #include <linux/remoteproc.h>
> >> +#include <linux/scmi_imx_protocol.h>
> >>  #include <linux/workqueue.h>
> >>  
> >>  #include "imx_rproc.h"
> >> @@ -92,6 +94,11 @@ struct imx_rproc_mem {
> >>  #define ATT_CORE_MASK   0xffff
> >>  #define ATT_CORE(I)     BIT((I))
> >>  
> >> +/* Logical Machine Operation */
> >> +#define IMX_RPROC_FLAGS_SM_LMM_OP	BIT(0)
> >> +/* Linux has permission to handle the Logical Machine of remote cores */
> >> +#define IMX_RPROC_FLAGS_SM_LMM_AVAIL	BIT(1)
> >> +
> >>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block);
> >>  static void imx_rproc_free_mbox(struct rproc *rproc);
> >>  
> >> @@ -116,6 +123,8 @@ struct imx_rproc {
> >>  	u32				entry;		/* cpu start address */
> >>  	u32				core_index;
> >>  	struct dev_pm_domain_list	*pd_list;
> >> +	/* For i.MX System Manager based systems */
> >> +	u32				flags;
> >>  };
> >>  
> >>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> >> @@ -394,6 +403,30 @@ static int imx_rproc_start(struct rproc *rproc)
> >>  	case IMX_RPROC_SCU_API:
> >>  		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
> >>  		break;
> >> +	case IMX_RPROC_SM:
> >> +		if (priv->flags & IMX_RPROC_FLAGS_SM_LMM_OP) {
> >> +			if (!(priv->flags & IMX_RPROC_FLAGS_SM_LMM_AVAIL))
> >> +				return -EACCES;
> >> +
> >> +			ret = scmi_imx_lmm_reset_vector_set(dcfg->lmid, dcfg->cpuid, 0, 0);
> >> +			if (ret) {
> >> +				dev_err(dev, "Failed to set reset vector lmid(%u), cpuid(%u): %d\n",
> >> +					dcfg->lmid, dcfg->cpuid, ret);
> >> +			}
> >> +
> >> +			ret = scmi_imx_lmm_operation(dcfg->lmid, SCMI_IMX_LMM_BOOT, 0);
> >> +			if (ret)
> >> +				dev_err(dev, "Failed to boot lmm(%d): %d\n", ret, dcfg->lmid);
> >> +		} else {
> >> +			ret = scmi_imx_cpu_reset_vector_set(dcfg->cpuid, 0, true, false, false);
> >> +			if (ret) {
> >> +				dev_err(dev, "Failed to set reset vector cpuid(%u): %d\n",
> >> +					dcfg->cpuid, ret);
> >> +			}
> >> +
> >> +			ret = scmi_imx_cpu_start(dcfg->cpuid, true);
> >> +		}
> >> +		break;
> >>  	default:
> >>  		return -EOPNOTSUPP;
> >>  	}
> >> @@ -436,6 +469,16 @@ static int imx_rproc_stop(struct rproc *rproc)
> >>  	case IMX_RPROC_SCU_API:
> >>  		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
> >>  		break;
> >> +	case IMX_RPROC_SM:
> >> +		if (priv->flags & IMX_RPROC_FLAGS_SM_LMM_OP) {
> >> +			if (priv->flags & IMX_RPROC_FLAGS_SM_LMM_AVAIL)
> >> +				ret = scmi_imx_lmm_operation(dcfg->lmid, SCMI_IMX_LMM_SHUTDOWN, 0);
> >> +			else
> >> +				ret = -EACCES;
> >> +		} else {
> >> +			ret = scmi_imx_cpu_start(dcfg->cpuid, false);
> >> +		}
> >> +		break;
> >>  	default:
> >>  		return -EOPNOTSUPP;
> >>  	}
> >> @@ -546,10 +589,48 @@ static int imx_rproc_mem_release(struct rproc *rproc,
> >>  	return 0;
> >>  }
> >>  
> >> +static int imx_rproc_sm_lmm_prepare(struct rproc *rproc)
> >> +{
> >> +	struct imx_rproc *priv = rproc->priv;
> >> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> >> +	int ret;
> >> +
> >> +	if (!(priv->flags & IMX_RPROC_FLAGS_SM_LMM_OP))
> >> +		return 0;
> >> +
> >> +	/*
> >> +	 * Power on the Logical Machine to make sure TCM is available.
> >> +	 * Also serve as permission check. If in different Logical
> >> +	 * Machine, and linux has permission to handle the Logical
> >> +	 * Machine, set IMX_RPROC_FLAGS_SM_LMM_AVAIL.
> >> +	 */
> >> +	ret = scmi_imx_lmm_operation(dcfg->lmid, SCMI_IMX_LMM_POWER_ON, 0);
> >> +	if (ret == 0) {
> >> +		dev_info(priv->dev, "lmm(%d) powered on\n", dcfg->lmid);
> >> +		priv->flags |= IMX_RPROC_FLAGS_SM_LMM_AVAIL;
> >
> >Why is setting this flag needed?  The check that is done on it in
> >imx_rproc_{start|stop} should be done here.  If there is an error then we don't
> >move forward.
> 
> The flag is to indicate M7 LM could be controlled by Linux LM(to save SCMI
> calls. without this flag, heavy SCMI calls will be runs into). The reason
> on why set it here:
> The prepare function will be invoked in two path: rproc_attach and rproc_fw_boot.
> When M7 LM works in detached state and not under control of Linux LM, rproc_stop
> could still be invoked, so we need to avoid Linux runs into scmi calls to
> stop M7 LM(even if scmi firmware will return -EACCESS, but with a flag, we could
> save a SCMI call), so there is a check in imx_rproc_stop and this is why
> we need a flag there.
> 
> The flag check in start might be redundant, but to keep safe, I still keep
> it there.

One of the (many) problem I see with this patch is that there is no
IMX_RPROC_FLAGS_SM_CPU_OP to complement IMX_RPROC_FLAGS_SM_LMM_OP in
imx_rproc_detect_mode(), leading to if/else statements that are hard to follow.

In imx_rproc_sm_lmm_prepare(), if scmi_imx_lmm_operation() is successful, return
0 immediately.  If -EACCESS the LMM method is unavailable in both normal and
detached mode, so priv->flags &= ~IMX_RPROC_FLAGS_SM_LMM_OP.

The main takeaway here is that the code introduced by this patch is difficult to
understand and maintain.  I suggest you find a way to make things simpler.

> 
> >
> >> +	} else if (ret == -EACCES) {
> >> +		dev_info(priv->dev, "lmm(%d) not under Linux Control\n", dcfg->lmid);
> >> +		/*
> >> +		 * If remote cores boots up in detached mode, continue;
> >> +		 * else linux has no permission, return -EACCES.
> >> +		 */
> >> +		if (priv->rproc->state != RPROC_DETACHED)
> >> +			return -EACCES;
> >
> >The comment above scmi_imx_lmm_operation() mentions that calling
> >scmi_imx_lmm_operation() is done to make sure TCMs are available.  Is there a
> >point in calling scmi_imx_lmm_operation() if ->state == RPROC_DETACHED?  If not,
> >can't that check be move to the beginning of imx_rproc_sm_lmm_prepare()?  
> 
> scmi_imx_lmm_operation also serves as permission check.
> 
> If ->state is RPROC_DETACHED, we still need to know M7 LM is or is not
> under control of Linux LM.
> 
> 
> >
> >> +
> >> +		/* work in state RPROC_DETACHED */
> >> +		ret = 0;
> >> +	} else if (ret) {
> >> +		dev_err(priv->dev, "Failed to power on lmm(%d): %d\n", ret, dcfg->lmid);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static int imx_rproc_prepare(struct rproc *rproc)
> >>  {
> >>  	struct imx_rproc *priv = rproc->priv;
> >>  	struct device_node *np = priv->dev->of_node;
> >> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> >>  	struct of_phandle_iterator it;
> >>  	struct rproc_mem_entry *mem;
> >>  	struct reserved_mem *rmem;
> >> @@ -593,7 +674,10 @@ static int imx_rproc_prepare(struct rproc *rproc)
> >>  		rproc_add_carveout(rproc, mem);
> >>  	}
> >>  
> >> -	return  0;
> >> +	if (dcfg->method == IMX_RPROC_SM)
> >> +		return imx_rproc_sm_lmm_prepare(rproc);
> >> +
> >> +	return 0;
> >>  }
> >>  
> >>  static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> >> @@ -927,13 +1011,41 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >>  	struct regmap_config config = { .name = "imx-rproc" };
> >>  	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> >>  	struct device *dev = priv->dev;
> >> +	struct scmi_imx_lmm_info info;
> >>  	struct regmap *regmap;
> >>  	struct arm_smccc_res res;
> >> +	bool started = false;
> >>  	int ret;
> >>  	u32 val;
> >>  	u8 pt;
> >>  
> >>  	switch (dcfg->method) {
> >> +	case IMX_RPROC_SM:
> >> +		/* Get current Linux Logical Machine ID */
> >> +		ret = scmi_imx_lmm_info(LMM_ID_DISCOVER, &info);
> >> +		if (ret) {
> >> +			dev_err(dev, "Failed to get current LMM ID err: %d\n", ret);
> >> +			return ret;
> >> +		}
> >> +
> >> +		/*
> >> +		 * Check whether remote processor is in same Logical Machine as Linux.
> >> +		 * If no, need use Logical Machine API to manage remote processor, and
> >> +		 * set IMX_RPROC_FLAGS_SM_LMM_OP.
> >> +		 * If yes, use CPU protocol API to manage remote processor.
> >> +		 */
> >> +		if (dcfg->lmid != info.lmid) {
> >> +			priv->flags |= IMX_RPROC_FLAGS_SM_LMM_OP;
> >> +			dev_info(dev, "Using LMM Protocol OPS\n");
> >> +		} else {
> >> +			dev_info(dev, "Using CPU Protocol OPS\n");
> >> +		}
> >> +
> >> +		ret = scmi_imx_cpu_started(dcfg->cpuid, &started);
> >> +		if (ret || started)
> >> +			priv->rproc->state = RPROC_DETACHED;
> >
> >An error should be reported and the initialization process aborted if an error
> >occurs rather than defaulting to the default mode.  This will lead to additional
> >error conditions that will have to be handled elsewhere.
> 
> ok. I could update to
> if (ret)
> 	return ret;
> if (started)
> 	priv->rproc->state = RPROC_DETACHED;
> 
> 
> 
> Thanks,
> Peng
> 

