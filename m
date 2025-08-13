Return-Path: <linux-kernel+bounces-766452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E39B246B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B6C162E78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7729BDBE;
	Wed, 13 Aug 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nr4SKB5o"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47707212566;
	Wed, 13 Aug 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079617; cv=none; b=NKoVgrfuy9d/O7ydg6HBgdIJMIHhLI7pIbtm4GawfWl7LQFH4/DtIq+HOOXfqO4B5jNVfqrpS/VLpnOea4j6aQIbQyhYEMxjrVjPhAMyolUpFE1gIo34gFxi8qCUelWJd3At8wXqR2BdM7IFy2Egk9TP1rxtJJdoFf/7r3K/U/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079617; c=relaxed/simple;
	bh=3T4bqvz1oeARCcGXhlgamPKO6Z9VO3tUxk/qagQb9Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W614z7vxXJykiiKPs4kK5d97Mxs40wRIMqa+x1UHDTAvhNIbStQvAcTSDY2L7gbp2G1YoKWFg0onppd4K2/4HdHoAlXXZS2Dkqg+ZkWSy76U6sTXNJv8WIPg2UjXcjrSrgTfwM9K/l5KLhgywOBQdAFMkx85iKpm7xQXhR0OlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nr4SKB5o; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01C1343A12;
	Wed, 13 Aug 2025 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755079613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTWVOZqjyFAtr/GBKcOX8Jr3xVIljMHUBUwZ1pjKP8M=;
	b=nr4SKB5oeTBL2ooKdcDslsDShwPFgObspC7NbWZ+A6nsCiOpWgB26mmdAboLF/A5xUZ55F
	8f5HFUEOoxZFA4aCbcxVCOZFhmPyFqno7CYBzxBV4QM+/fGm1dj7NhBYbvEpQcibMSQW0V
	i0FToWYI8sXt862d9h8tZxf51lojpQ7B66svG/v88kCmjedkqwjRiq8l+Um6IvpzAVl/jF
	NRrI27mDR1MkLFHitp2u6ZGtYKAtU8fXa+7x8kAS2IQ7qSRMG+fPnmHgk8d9Rmwmn8M/qp
	+nzIILtxMnUWHfOWdeEK8JH+Y/HNc9k/cyUL8/oDnVAN611BezzfjsLyvOOH3w==
Date: Wed, 13 Aug 2025 12:06:51 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: fsl: qmc: Only set completion interrupt
 when needed
Message-ID: <20250813120651.27dc8467@bootlin.com>
In-Reply-To: <badb68a85910e5e6f1094ef3b01805209ac21854.1754993232.git.christophe.leroy@csgroup.eu>
References: <cover.1754993232.git.christophe.leroy@csgroup.eu>
 <badb68a85910e5e6f1094ef3b01805209ac21854.1754993232.git.christophe.leroy@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiffefgeeitdelleeigefhjeelueeuveekveetgeffheeltdekgeduiefggfdvnecukfhppedvrgdtudemtggstdekmeelkeeltgemkedttddtmehfugekudemleehgegvmedvudehrgemfeeluddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtkeemleeklegtmeektddttdemfhgukedumeelheegvgemvdduhegrmeefledutddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepqhhirghnghdriihhrghosehngihprdgtohhmpdhrtghpthhtohepshhhvghnghhjihhurdifrghnghesghhmrghilhdrtghomhdprhgtphhtthhop
 egiihhusghordfnvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitgholhgvohhtshhukhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

Hi Christophe,

On Tue, 12 Aug 2025 12:50:55 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> When no post-completion processing is expected, don't waste time
> handling useless interrupts.
> 
> Only set QMC_BD_[R/T]X_I when a completion function is passed in,
> and perform seamless completion on submit for interruptless buffers.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Keep the UB flag to mark not completed buffers and seamlessly flag them as completed during next submit.
> ---
>  drivers/soc/fsl/qe/qmc.c | 44 ++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 36c0ccc06151f..8f76b9a5e385d 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -461,9 +461,16 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
>  
>  	ctrl = qmc_read16(&bd->cbd_sc);
>  	if (ctrl & (QMC_BD_TX_R | QMC_BD_TX_UB)) {
> -		/* We are full ... */
> -		ret = -EBUSY;
> -		goto end;
> +		if (!(ctrl & QMC_BD_TX_I) && bd == chan->txbd_done) {
> +			if (ctrl & QMC_BD_TX_W)
> +				chan->txbd_done = chan->txbds;
> +			else
> +				chan->txbd_done++;
> +		} else {
> +			/* We are full ... */
> +			ret = -EBUSY;
> +			goto end;
> +		}
>  	}
>  
>  	qmc_write16(&bd->cbd_datlen, length);
> @@ -475,6 +482,10 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
>  
>  	/* Activate the descriptor */
>  	ctrl |= (QMC_BD_TX_R | QMC_BD_TX_UB);
> +	if (complete)
> +		ctrl |= QMC_BD_TX_I;
> +	else
> +		ctrl &= ~QMC_BD_TX_I;
>  	wmb(); /* Be sure to flush the descriptor before control update */
>  	qmc_write16(&bd->cbd_sc, ctrl);
>  

You try to purge one descriptor for which the transfer is done but you do that
when you have no more free descriptors.

You end up with all descriptor "used". I think a better way to do that is
to purge all "done" descriptor configured to work without interrupts until a
descriptor with interrupt is found.

What do you think about the following (draft code not compiled and not tested) ?

/* must be called with tx_lock taken */
static void qmc_chan_write_purge(struct qmc_chan *chan)
{
	cbd_t __iomem *bd;
	u16 ctrl;

	/*
         * Purge descriptors configured to work without interrupts
	 * (I bit == 0) those descriptors have no completion
	 * callbacks.
	 *
	 * R bit  UB bit
	 *   0       0  : The BD is free
	 *   1       1  : The BD is in used, waiting for transfer
	 *   0       1  : The BD is in used, waiting for completion
	 *   1       0  : Should not append
	 *
	 * We purge those descriptors which are in the state "waiting for
	 * completion" up to the first one configured to work with an interrupt.
	 * 
	 */
	bd = chan->txbd_done;

	ctrl = qmc_read16(&bd->cbd_sc);
	while (!(ctrl & (QMC_BD_TX_R | QMC_BD_TX_I)) {
		if (!(ctrl & QMC_BD_TX_UB))
			return;

		qmc_write16(&bd->cbd_sc, ctrl & ~QMC_BD_TX_UB);

		if (ctrl & QMC_BD_TX_W)
			chan->txbd_done = chan->txbds;
		else
			chan->txbd_done++;

		bd = chan->txbd_done;
		ctrl = qmc_read16(&bd->cbd_sc);
	}
}

Then, qmc_chan_write_submit() calls the purge function as a first operation.
This will look to something like the following:

int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
			  void (*complete)(void *context), void *context)
{
	struct qmc_xfer_desc *xfer_desc;
	unsigned long flags;
	cbd_t __iomem *bd;
	u16 ctrl;
	int ret;

	/*
	 * R bit  UB bit
	 *   0       0  : The BD is free
	 *   1       1  : The BD is in used, waiting for transfer
	 *   0       1  : The BD is in used, waiting for completion
	 *   1       0  : Should not append
	 */

	spin_lock_irqsave(&chan->tx_lock, flags);

	qmc_chan_write_purge(chan);

	bd = chan->txbd_free;
	...

	if (complete)
		ctrl |= QMC_BD_TX_I;
	else
		ctrl &= ~QMC_BD_TX_I;
	...
}


> @@ -569,9 +580,16 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
> 
...

Exact same comment and proposal for read part.

>  
> @@ -1482,19 +1504,19 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
>  
>  	/* Init Rx BDs and set Wrap bit on last descriptor */
>  	BUILD_BUG_ON(QMC_NB_RXBDS == 0);
> -	val = QMC_BD_RX_I;
>  	for (i = 0; i < QMC_NB_RXBDS; i++) {
>  		bd = chan->rxbds + i;
> -		qmc_write16(&bd->cbd_sc, val);
> +		qmc_write16(&bd->cbd_sc, 0);
>  	}
>  	bd = chan->rxbds + QMC_NB_RXBDS - 1;
> -	qmc_write16(&bd->cbd_sc, val | QMC_BD_RX_W);
> +	qmc_write16(&bd->cbd_sc, QMC_BD_RX_W);
>  
>  	/* Init Tx BDs and set Wrap bit on last descriptor */
>  	BUILD_BUG_ON(QMC_NB_TXBDS == 0);
> -	val = QMC_BD_TX_I;
>  	if (chan->mode == QMC_HDLC)
> -		val |= QMC_BD_TX_L | QMC_BD_TX_TC;
> +		val = QMC_BD_TX_L | QMC_BD_TX_TC;
> +	else
> +		val = 0;
>  	for (i = 0; i < QMC_NB_TXBDS; i++) {
>  		bd = chan->txbds + i;
>  		qmc_write16(&bd->cbd_sc, val);

Ok for modifications in qmc_setup_chan().

Best regards,
Hervé

