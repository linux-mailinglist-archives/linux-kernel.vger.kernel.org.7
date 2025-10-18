Return-Path: <linux-kernel+bounces-858903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE43BEC2FC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD881AA5B88
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DE1A0711;
	Sat, 18 Oct 2025 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUdt9f5i"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D8153BE9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748281; cv=none; b=nIdKGlCTZC121r2z6Rlg/zE+thnsytvKEGgbZi8DZYoBzgPmrGZ+QGESQl54JUK5WNKITp9Ru5jsQD5wfceO6ga/tEfMGryrhk1IdDg/iD33+WSriuvQZfbB94hx5YWnlvmj9JcoMnSDyHAJrZU7uU50v8J/iM7b5aQtVSLBb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748281; c=relaxed/simple;
	bh=sHF2/XPZw6H0+JGNQbRl7shSpw7MIUsqz9Xi23Hix74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmulLrYOoSe5h10+1P9gFdg9y9jEaxLOFmwlPy065pIRG9gsQYK5e+sAeu0amls3I1p10HsJGXgMhDXLewmw+7VYnbEZdbXnwHAFjgg6DtB9x63nAFzhMXj8nn/LSDM6up6EBPEBd1xV9rLQgmHMLFu81muXWnlw73G12MbcKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUdt9f5i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269639879c3so23429665ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760748279; x=1761353079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QafKpBA9ev9tZ8RtBiTe7ilN8YrDWJs4uzq+MACIIs=;
        b=fUdt9f5iwA4BDe8irbzVPi1woSuKvNnIqgt3/bItl4hrmKX8YKqg8iqpef24Zd24t4
         3++L/qYWHutF9xvXPYB5kxgAVa+acix6h1n9CgVzDisN0qa6WWZxwdTddtIqCk/7BZEU
         L+oxzQqH/E0d79Mmu+6VJSbPUeqUiSPreDs/sUY6XnVkkX3JkAEVl83F2PsNmp0cPlh6
         ssECQgv4Jj8m5EXR6PLsUGGlCDD+aAQwOJHtufreJjie6RCtuemqhpeiiu1yjk4ICp+h
         cUTZgfjypzzF8DOxJwrnzmTLBz2sOXYC5ausIHMo7rvfAr/CKAftaoSKhhAu3KZcvV+t
         /ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760748279; x=1761353079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QafKpBA9ev9tZ8RtBiTe7ilN8YrDWJs4uzq+MACIIs=;
        b=GJVK3W1qc6N1d46F4ce+sl4Mjs53r8mRS39KxI1XsgIrMz4ngoLilWudMYPB7I7IoZ
         w44qUm23Qh1FcZDv7XLp4X0kYMww8BeoLmJeZUlBlYYqUTnCz4ZaXiKhlh7xiUvxpbWp
         FT4rVnVF0hTGyKjwkOSBygqI+sOObY9IsnsYKHdHiQT5mLRGxrMgVVucN165OjUpbHMv
         bEok9zc6/KsvFCyaucl3x2S6T6bw5ATqJDfqSq/S8vas8kTcjVfUysVRQ/5eT8z3fKk4
         iaslIRwL5AMIx/45sBUx124HCryg2inQAIWEPZqyZTWgAj5q74f4p9LqFo1m1VmVhSf+
         51dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSOKOod2DKYjS4Uu6EsFDiFW/56+MofAPD9Bttix7dTGc94mx8bkoXpBn/cX16Axr2hRwVs33lJ1yY6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ltO1Q38U+sXuZlKLAZFq9P5hmMPQqjWd2pNPb9eodyfXiiSQ
	8Ab4pAhTLPDJKQ7wQebCDS5T6g0Fpi2yHxzicleicPwmbKvzkVnOYnOX
X-Gm-Gg: ASbGncvOEre/9nEkyfsUFr2Cv1UFzYkgXGdd2lf4jZsMqklyP+YjFaQngJA7WntxvIO
	qEPeRgzsUoetNH5Oyt6iFc/Vn47LGqlD1XHTrz+2aM2fbXU1mo9q+6L3909mOVtMHbaZTAdoeq1
	5OvFKMMLSmCdaQHLV9S+8gWYztuDXJmtB04LLN+zt1TPz59YVd0fb0ch3BSCWNl1jTGi20ZxSG/
	/KBo4QIfdqImKiYZRGhtWWNz+kVJBEp13qU5hEEmLPHP6h9keI83jumSIxX86M+ehWPVzwsfdcw
	erVaokvwuArgn8iTp1CKFm7WP1hu2kPYqYos22FWmqYS+km+me4pYe9UWpsEDDjschnQLeVFUIS
	x1PGcChXQkar4pDBwexK2+OIQWia6vIyRflKxhuKxKvFfYjgqlxKODLVk0V1GPkU41yK+BJ0kem
	w=
X-Google-Smtp-Source: AGHT+IEJHzKpBZuNZNa18WS/ADFtdVavA7SE/dNX1ygVUM8SyYneHAxGCurSyYxg3cW6a8KtgONCXg==
X-Received: by 2002:a17:902:ea01:b0:267:d2f9:2327 with SMTP id d9443c01a7336-290c9cf2d88mr81827755ad.27.1760748278692;
        Fri, 17 Oct 2025 17:44:38 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721b6fdsm7874395ad.118.2025.10.17.17.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 17:44:38 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:43:47 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, netdev@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <hmch7csqotxt42snddksce2mpnjeglbgvoxs6r5qlu7v2ayxyk@zctj7xhugeln>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <20251018000548-GYA1481334@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000548-GYA1481334@gentoo.org>

On Sat, Oct 18, 2025 at 08:05:48AM +0800, Yixun Lan wrote:
> Hi Inochi,
> 
> On 09:18 Fri 17 Oct     , Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be remove
>                                                      s/remove/removed/
> > when init the mac, otherwise the phy will be misconfigurated.
> s/init/initialize/
> > 
> > Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <rabenda.cn@gmail.com>
> > ---
> >  .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 25 ++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > index 3b7947a7a7ba..b2dee1399eb0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > @@ -7,6 +7,7 @@
> > 
> >  #include <linux/clk.h>
> >  #include <linux/module.h>
> > +#include <linux/property.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > 
> > @@ -29,8 +30,23 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> >  	return 0;
> >  }
> > 
> > +static int sophgo_sg2042_set_mode(struct plat_stmmacenet_data *plat_dat)
> > +{
> > +	switch (plat_dat->phy_interface) {
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_TXID;
> > +		return 0;
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int sophgo_dwmac_probe(struct platform_device *pdev)
> >  {
> > +	int (*plat_set_mode)(struct plat_stmmacenet_data *plat_dat);
> >  	struct plat_stmmacenet_data *plat_dat;
> >  	struct stmmac_resources stmmac_res;
> >  	struct device *dev = &pdev->dev;
> > @@ -50,11 +66,18 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> > 
> > +	plat_set_mode = device_get_match_data(&pdev->dev);
> > +	if (plat_set_mode) {
> > +		ret = plat_set_mode(plat_dat);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
> >  }
> > 

> >  static const struct of_device_id sophgo_dwmac_match[] = {
> > -	{ .compatible = "sophgo,sg2042-dwmac" },
> > +	{ .compatible = "sophgo,sg2042-dwmac", .data = sophgo_sg2042_set_mode },
> I'd personally prefer to introduce a flag for this, it would be more readable and
> maintainable, something like
> struct sophgo_dwmac_compitable_data {
> 	bool has_internal_rx_delay;
> }
> 
> then.
> 	if (data->has_internal_rx_delay)
> 		sophgo_sg2042_set_mode(..)
> 
> 
> >  	{ .compatible = "sophgo,sg2044-dwmac" },
> >  	{ /* sentinel */ }
> >  };

Yeah, I think this is a good idea, thanks.

Regards,
Inochi


