Return-Path: <linux-kernel+bounces-704271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1BAE9B98
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788705A1900
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E720E031;
	Thu, 26 Jun 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5AGOYYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F924A049;
	Thu, 26 Jun 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933836; cv=none; b=a+zqRojV7YOWEp1iRn0AvaEcilFLY+8Xl1KNainA5aUoCwSaSfyCEBIpOSzI51mUPLJ7ajgHW/5Jc4gvFyjgEAgzGFFXzY+UcULDGNFFFIIGQwPUEX/JD7OuPjhOMRxaDKaKRXgPQTeqi6GtoaHYKUNUsNMqlbZDONhjuagFQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933836; c=relaxed/simple;
	bh=8kyXYKJiS/ce5WIua8WcuOSLKA7ody3HqT7dIqUof0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr+SoF8yUcwwFyYKqCrJ19SabrnQPGJbSWXi6xFkrjFoDfR+3ayJhk4vgHLtjDVkOsjW95SILG3GJJGMozNj18ZBZPsOCZlqQADW0jY1I0egitGwO7aN+QuZUo7T+4JzgdoogkrAx5B3DE+GXLNv2z+GXb+BGLN6XcS5qeqGbxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5AGOYYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E67C4CEEB;
	Thu, 26 Jun 2025 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933835;
	bh=8kyXYKJiS/ce5WIua8WcuOSLKA7ody3HqT7dIqUof0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5AGOYYLv6GPhxjKe8Sl7aiwp4/lGEjmq+6mJqvH02Nf0fG/xD29v8eIC2T0+bfBy
	 Rl0nzLtY1PN+AzmGPa/f1ge6I6l0bPjaIP2S7KGEUEI+XMDFHck8t92TErpW1Pt0ax
	 QV2kb8N991mtVtm61s4m0WdzvMpwBGJwl7mcV60nJX7S0KaEJZGX3QLdOR47LH0BJM
	 LBq0Xw6+xRZ+Sg7zmacqsqa2UZ8e8b87keZ/Eg0Ql0zlT04x0W9XBiFp92DzuOWD9Z
	 8cJraH0Q0kODrFOhd2F8X2rGx6TtIEk4YP+WHXFYBOl7G4g+NYby8aiHqL2zSh6xgr
	 u9/rl3A0uWV1w==
Date: Thu, 26 Jun 2025 11:30:30 +0100
From: Lee Jones <lee@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
Message-ID: <20250626103030.GA10134@google.com>
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
 <20250619025138.2854-4-zhaoqunqin@loongson.cn>
 <aFs2RDOeOKvWUN2L@kernel.org>
 <20250625080527.GN795775@google.com>
 <aFvhorr3kZSuzVpv@kernel.org>
 <20250625134047.GX795775@google.com>
 <aFwsIs6ri3HZictC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFwsIs6ri3HZictC@kernel.org>

On Wed, 25 Jun 2025, Jarkko Sakkinen wrote:

> On Wed, Jun 25, 2025 at 02:40:47PM +0100, Lee Jones wrote:
> > On Wed, 25 Jun 2025, Jarkko Sakkinen wrote:
> > 
> > > On Wed, Jun 25, 2025 at 09:05:27AM +0100, Lee Jones wrote:
> > > > On Wed, 25 Jun 2025, Jarkko Sakkinen wrote:
> > > > 
> > > > > On Thu, Jun 19, 2025 at 10:51:37AM +0800, Qunqin Zhao wrote:
> > > > > > Loongson Security Engine supports random number generation, hash,
> > > > > > symmetric encryption and asymmetric encryption. Based on these
> > > > > > encryption functions, TPM2 have been implemented in the Loongson
> > > > > > Security Engine firmware. This driver is responsible for copying data
> > > > > > into the memory visible to the firmware and receiving data from the
> > > > > > firmware.
> > > > > > 
> > > > > > Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > > > Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> > > > > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > ---
> > > > > >  drivers/char/tpm/Kconfig        |  9 ++++
> > > > > >  drivers/char/tpm/Makefile       |  1 +
> > > > > >  drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 94 insertions(+)
> > > > > >  create mode 100644 drivers/char/tpm/tpm_loongson.c
> > > > > > 
> > > > > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > > > > index dddd702b2..ba3924eb1 100644
> > > > > > --- a/drivers/char/tpm/Kconfig
> > > > > > +++ b/drivers/char/tpm/Kconfig
> > > > > > @@ -189,6 +189,15 @@ config TCG_IBMVTPM
> > > > > >  	  will be accessible from within Linux.  To compile this driver
> > > > > >  	  as a module, choose M here; the module will be called tpm_ibmvtpm.
> > > > > >  
> > > > > > +config TCG_LOONGSON
> > > > > > +	tristate "Loongson TPM Interface"
> > > > > > +	depends on MFD_LOONGSON_SE
> > > > > > +	help
> > > > > > +	  If you want to make Loongson TPM support available, say Yes and
> > > > > > +	  it will be accessible from within Linux. To compile this
> > > > > > +	  driver as a module, choose M here; the module will be called
> > > > > > +	  tpm_loongson.
> > > > > > +
> > > > > >  config TCG_XEN
> > > > > >  	tristate "XEN TPM Interface"
> > > > > >  	depends on TCG_TPM && XEN
> > > > > > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > > > > > index 9de1b3ea3..5b5cdc0d3 100644
> > > > > > --- a/drivers/char/tpm/Makefile
> > > > > > +++ b/drivers/char/tpm/Makefile
> > > > > > @@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
> > > > > >  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> > > > > >  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> > > > > >  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
> > > > > > +obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> > > > > > diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> > > > > > new file mode 100644
> > > > > > index 000000000..5cbdb37f8
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/char/tpm/tpm_loongson.c
> > > > > > @@ -0,0 +1,84 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> > > > > > +
> > > > > > +#include <linux/device.h>
> > > > > > +#include <linux/mfd/loongson-se.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/wait.h>
> > > > > > +
> > > > > > +#include "tpm.h"
> > > > > > +
> > > > > > +struct tpm_loongson_cmd {
> > > > > > +	u32 cmd_id;
> > > > > > +	u32 data_off;
> > > > > > +	u32 data_len;
> > > > > > +	u32 pad[5];
> > > > > > +};
> > > > > > +
> > > > > > +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > > > > > +{
> > > > > > +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> > > > > > +	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
> > > > > > +
> > > > > > +	if (cmd_ret->data_len > count)
> > > > > > +		return -EIO;
> > > > > > +
> > > > > > +	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> > > > > > +
> > > > > > +	return cmd_ret->data_len;
> > > > > > +}
> > > > > > +
> > > > > > +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> > > > > > +{
> > > > > > +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> > > > > > +	struct tpm_loongson_cmd *cmd = tpm_engine->command;
> > > > > > +
> > > > > > +	if (count > tpm_engine->buffer_size)
> > > > > > +		return -E2BIG;
> > > > > > +
> > > > > > +	cmd->data_len = count;
> > > > > > +	memcpy(tpm_engine->data_buffer, buf, count);
> > > > > > +
> > > > > > +	return loongson_se_send_engine_cmd(tpm_engine);
> > > > > > +}
> > > > > > +
> > > > > > +static const struct tpm_class_ops tpm_loongson_ops = {
> > > > > > +	.flags = TPM_OPS_AUTO_STARTUP,
> > > > > > +	.recv = tpm_loongson_recv,
> > > > > > +	.send = tpm_loongson_send,
> > > > > > +};
> > > > > > +
> > > > > > +static int tpm_loongson_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct loongson_se_engine *tpm_engine;
> > > > > > +	struct device *dev = &pdev->dev;
> > > > > > +	struct tpm_loongson_cmd *cmd;
> > > > > > +	struct tpm_chip *chip;
> > > > > > +
> > > > > > +	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
> > > > > > +	if (!tpm_engine)
> > > > > > +		return -ENODEV;
> > > > > > +	cmd = tpm_engine->command;
> > > > > > +	cmd->cmd_id = SE_CMD_TPM;
> > > > > > +	cmd->data_off = tpm_engine->buffer_off;
> > > > > > +
> > > > > > +	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
> > > > > > +	if (IS_ERR(chip))
> > > > > > +		return PTR_ERR(chip);
> > > > > > +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> > > > > > +	dev_set_drvdata(&chip->dev, tpm_engine);
> > > > > > +
> > > > > > +	return tpm_chip_register(chip);
> > > > > > +}
> > > > > > +
> > > > > > +static struct platform_driver tpm_loongson = {
> > > > > > +	.probe   = tpm_loongson_probe,
> > > > > > +	.driver  = {
> > > > > > +		.name  = "loongson-tpm",
> > > > > 
> > > > > This patch looks otherwise great but I'd prefer here tho use
> > > > > "tpm_loongson_probe" for the value of the name field.
> > > > 
> > > > Where does this stipulation come from?  No other driver does this [0].
> > > > driver.name should be a nicely formatted, human readable string
> > > > describing the name of the device.  Not a function name.
> > > 
> > > What defines "human-readable" here? I see both as somewhat the
> > > same level of "readability" ;-)
> > > 
> > > > 
> > > > [0] git grep -A15 "static struct platform_driver" | grep ".name = .*probe"
> > > 
> > > What I'm getting:
> > > 
> > > $ git grep -l -e platform_driver_register --or -e module_platform_driver
> > > drivers/char/tpm | xargs git grep "\.name"
> > > drivers/char/tpm/tpm_atmel.c:           .name = "tpm_atmel",
> > > drivers/char/tpm/tpm_ftpm_tee.c:                .name = "ftpm-tee",
> > > drivers/char/tpm/tpm_ftpm_tee.c:                .name           =
> > > "optee-ftpm",
> > > drivers/char/tpm/tpm_nsc.c:             .name    = "tpm_nsc",
> > > drivers/char/tpm/tpm_svsm.c:            .name = "tpm-svsm",
> > > drivers/char/tpm/tpm_tis.c:     .name = "tpm_tis",
> > > drivers/char/tpm/tpm_tis.c:             .name           = "tpm_tis",
> > > drivers/char/tpm/tpm_tis_synquacer.c:           .name           =
> > > "tpm_tis_synquacer",
> > > 
> > > Do you consider e.g, "tpm_tis" as "less human-readable".
> > > 
> > > I don't necessarily fight against the name chosen. Your arguments
> > > just plain no make sense, so I just merely want to understand this.
> > > That's all.
> > 
> > In 64% of cases '-' is preferred to '_' for device names.
> > 
> > Human readable is probably a bit of a stretch in this context, so I'll
> > retract that part of the statement.  However, we should be using device
> > names, not names of functions which remain meaningless (which is what I
> > really meant by 'readable') to the user.  Where else do you see the
> > .probe() function name being used as a device name?
> 
> Oops now I see what you mean. I meant to write "tpm_loongson", i.e.
> matching tpm_tis, tpm_crb etc. Sorry my bad.

Ah, gotcha.  No worries.

"tpm_loongson" wouldn't be my preference, but is acceptable.

-- 
Lee Jones [李琼斯]

