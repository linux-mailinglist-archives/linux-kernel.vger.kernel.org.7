Return-Path: <linux-kernel+bounces-768830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5494B2660A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5734416EB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF2F2FDC23;
	Thu, 14 Aug 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="EmQ8YcoI"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F312FB987;
	Thu, 14 Aug 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176189; cv=none; b=jRzgvY7fE3zty1PG9314+2UEVZ4VGmJxTLkBcAvxOplTZP56lzXfhwSH/Kir0SRyh6v3b8vg6UO8z1+kYuAIMNQvCYEz316qGi0FP2gsHTyOr3UBkua/gevaC5Cb43gbSB+ky7gb5QJvZOsfqqae1KUUtdcV8PDcE4yIESesylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176189; c=relaxed/simple;
	bh=bvLIns6kAaFW/coEFPU1VptQ/yhBs2dZmHbbXI7EHg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEMd7EpMUszFp0NjR9Xzh0kd7X+S+RBUwPCRSkkq9Ll4uecwgHH/ywU5yRz+pPH3HXxVvB3yoXR2Z3yWlSLH8ERMGvM/Qi+s4dlDo7XCXKsGoqkS7GyK33ZCfj7WnsaoHXTIV4RTNY3GUglMr9RDWeVZ8HQ5vBQH9B2BzuWcarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=EmQ8YcoI; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755176168;
	bh=CjtoWhdgfdevioOzjHH4EUUUH9uWoD93N4KhylunA44=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=EmQ8YcoIQfZbAVe+vY8apktId+rebB47Y3uBOr4TxYAmP4hrg7NxW85zSxSHkORjl
	 yA0lEhPfJk+RlS/XIHz0cOQcjJX7j5ivggiPd0rdAjqNzUvatSR6FZPXqGjYyizWgE
	 BLRgEU19erzX4LfQ3xSwI+SFa1uogkAznmiI++CY=
X-QQ-mid: zesmtpip4t1755176162t001a8636
X-QQ-Originating-IP: ft3DEdIShiaa2Pbj2KfMxFeuKw9DKtlEl9tdgLJOFt0=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 20:56:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15176067644090953445
EX-QQ-RecipientCnt: 16
Date: Thu, 14 Aug 2025 20:55:58 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH 2/2] ASoC: spacemit: i2s: add support for K1 SoC
Message-ID: <7352191F0DCAFF7E+aJ3c3tGKdcM3G-Uc@troy-wujie14pro-arch>
References: <20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com>
 <20250814-k1-i2s-v1-2-c31149b29041@linux.spacemit.com>
 <851f1c3d96988920a28412a26d5cd951b684c020.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851f1c3d96988920a28412a26d5cd951b684c020.camel@pengutronix.de>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NojR6Ao/DkEDi8pbjY7B1/JGJqh2G5CTYEzUnA9nL4ILgS5Ok3FS8sJe
	/njlggfOQO1qeuOMHO2i/XkIqvIRYy+z91Yv/xWqOrxDNwL6e56/dvcOwfkKh6P59MomwXl
	iMJpytvDBVyb5KQJZnTtzPAMSh5jANY7QbTb9xcFQQK27wAmFo+VEe4Uums8ZJ9QKXoDuiV
	BbQtJUN4ljGTrG5FnI81A5nDexpdFd91e/8qH0kqGCk0Er0ooVmaGRsxIYfzIEjTmXmkv1f
	14XlDne8tb4x5+LF4SHBXre75yu+GvQ5RnT30sb/mFUk2vfE558/xk7sWjZYU5JUnffT/f2
	fzDJ1fWiam8mj/CJnBU8kTbYnZbGwo5E64+E7f9f2GFz3r1BWK34VlsvDTkoE0VI4x2COFd
	lILJy6WjHORCr2XG3m7jwiTeuy0cGa8+56T2IWvLaHVbPTw1TOIE27jVzZXXYga6d7efQBR
	BRW6pjgclHB+SkG9jJOjCC5OVEAG26USLMGFEtJBjpx9YmyGqEUbPdkvx1VoFK7WUlgkDq6
	jKSGmdW64iaVWGLUz8QwRw34/gCxaRT6v9tL1FGSG5YroOqev4FUOBIbzBLdng5e2J3eDSw
	1GFuiWoO726k1uq4Lggr/xGjyAtXBi/lUByNdWdPL31kYCQbCuyh6OmHAhtZUP/9FpPPxRz
	Zwcsr6SB7NgB0ILE3pXLNBQH4XSUH5Z46Igc/WTRASv1bTtHUHx0qEJ+Z2h9JPYICguvpF1
	rPK4vmiFE/CQFsed211+WRbfSgNjfq0soaPeNHNfgN7WoeneEilJV5+NEWvKa2vE02dujRl
	TyczSj+kfMB4h5hH06i6ylfO0pgjh8crrWGNl3LqtPnKp+pcVIxBqher8TnuZ/0uI0DM5lz
	0PpX+NmMxpchjDv7tInhUF4TWwL28j0bVetiArqKSq+UN0MzpMj/Gg7Ro5RjJ/SFMkPg1+Y
	SqAY+zuvmHuFd9FYYS77TOluXr142tjWRL6m5wM9qL514J56srPH5ACD6SND7ERdzcBmB4H
	QFQNf9Ms39he9YfxXvJwSnhNnH2RSunMcPxCNMp2KGkXNyzNKh
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Thu, Aug 14, 2025 at 12:36:45PM +0200, Philipp Zabel wrote:
> On Do, 2025-08-14 at 16:54 +0800, Troy Mitchell wrote:
> > Add ASoC platform driver for the SpacemiT K1 SoC full-duplex I2S
> > controller.
> > 
> > Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
> > Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  sound/soc/Kconfig           |   1 +
> >  sound/soc/Makefile          |   1 +
> >  sound/soc/spacemit/Kconfig  |  14 ++
> >  sound/soc/spacemit/Makefile |   5 +
> >  sound/soc/spacemit/k1_i2s.c | 444 ++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 465 insertions(+)
> > 
> [...]
> > diff --git a/sound/soc/spacemit/k1_i2s.c b/sound/soc/spacemit/k1_i2s.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9e41525afbf3f08ab9a26b562772861d86f39cd7
> > --- /dev/null
> > +++ b/sound/soc/spacemit/k1_i2s.c
> > @@ -0,0 +1,444 @@
> [...]
> 
> > +static int spacemit_i2s_probe(struct platform_device *pdev)
> > +{
> > +	struct snd_soc_dai_driver *dai;
> > +	struct spacemit_i2s_dev *i2s;
> > +	struct resource *res;
> > +	struct clk *clk;
> > +	int ret;
> > +
> > +	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
> > +	if (!i2s)
> > +		return -ENOMEM;
> > +
> > +	i2s->dev = &pdev->dev;
> > +
> > +	i2s->sysclk = devm_clk_get_enabled(i2s->dev, "sysclk");
> > +	if (IS_ERR(i2s->sysclk))
> > +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->sysclk),
> > +				     "failed to enable sysbase clock\n");
> > +
> > +	i2s->bclk = devm_clk_get_enabled(i2s->dev, "bclk");
> > +	if (IS_ERR(i2s->bclk))
> > +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->bclk), "failed to enable bit clock\n");
> > +
> > +	clk = devm_clk_get_enabled(i2s->dev, "sspa_bus");
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(i2s->dev, PTR_ERR(clk), "failed to enable sspa_bus clock\n");
> > +
> > +	i2s->sspa_clk = devm_clk_get_enabled(i2s->dev, "sspa");
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(i2s->dev, PTR_ERR(clk), "failed to enable sspa clock\n");
> > +
> > +	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > +	if (IS_ERR(i2s->base))
> > +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->base), "failed to map registers\n");
> > +
> > +	i2s->reset =  devm_reset_control_get(&pdev->dev, NULL);
> 
> Please use devm_reset_control_get_exclusive() directly.
Tnx. I will use in the next version.

> 
> > +	if (IS_ERR(i2s->reset))
> > +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->reset),
> > +				     "failed to get reset control");
> > +
> > +	dev_set_drvdata(i2s->dev, i2s);
> > +
> > +	spacemit_i2s_init_dai(i2s, &dai, res->start + SSDATR);
> > +
> > +	ret = devm_snd_soc_register_component(i2s->dev,
> > +					      &spacemit_i2s_component,
> > +					      dai, 1);
> > +	if (ret)
> > +		return dev_err_probe(i2s->dev, ret, "failed to register component");
> > +
> > +	return devm_snd_dmaengine_pcm_register(&pdev->dev, &spacemit_dmaengine_pcm_config, 0);
> > +}
> > +
> > +static void spacemit_i2s_remove(struct platform_device *pdev)
> > +{
> > +	struct spacemit_i2s_dev *i2s = dev_get_drvdata(&pdev->dev);
> > +
> > +	reset_control_assert(i2s->reset);
> 
> I'd move the reset_control_assert() be moved to snd_soc_dai_ops::remove
> for symmetry.
>
It makes sense.

deassert in ops::probe and assert in ops::remove.

                - Troy
> 
> regards
> Philipp
> 

