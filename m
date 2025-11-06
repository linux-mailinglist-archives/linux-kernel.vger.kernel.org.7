Return-Path: <linux-kernel+bounces-889350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56266C3D598
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B03AF6B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30CE23D297;
	Thu,  6 Nov 2025 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3Cblq2R"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2B2FB0B7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460879; cv=none; b=Q1i6jM2C1gBDC4uHzgaADkrQ2UjOsrvjmaQgOrgkV0nTUYotZdfHAsuNM1Se0x/yqC8L1AZGt5uTjT5sY9bNzc1zUGMGyPH0z7xUggkTY8WHQ0ojM+9uoAVZ0RnSt3MlKoSRvJ+S0M58vzXaVxuJECa9o59vTT2QgtjGTFRPurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460879; c=relaxed/simple;
	bh=0t6MlGhVM0XL2fZZuOAF1ghwnWWRlF6HQII+byj8QnE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2SQek6L17cyJOthYIdTLD8hyCopMchp0aFnzYrhPJEg+THrK/x/cDZKG02LiE2sU7eNXEbx7gCFLeyrdVJz4mwiv9WzbV+gM+o8Agyi0fZ505quUNoH0lnDaBT/bSIeO8M7NHNR515o59f+Pxbc0O6GvvfYNW2HV2N1R9H42YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3Cblq2R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47114a40161so253685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762460876; x=1763065676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1z2wjiHhvsejiQn/+tOEpXB/N3K2BinmsJSUyaKjfEc=;
        b=R3Cblq2Rgj4Z5SJ5m5pLvvpB01wYiiu1oGpnbvR1GiSq7p0R3aa9+bkVF0b5p+aIfn
         kEa7Bw59OcJ0+2rXR+rNywOL9rgkb2gsJQlOv0cRMzb2pD0QXZeGL2va+wjAGDwOS4e7
         Mb54PQeZjRsNbs2H8CdKGEOyaj6b4eKPa+kiNUfdrd7d/CCuRTFbP5S+I1mBw0Eyhnzx
         6jFmGs/SMDPPOtzH0c+6GbSdD0YokzbEJVUx3ZX/23ErKK5CfmxToQi1hrFqU5jySmfq
         /rh/sOS++A8xI1MymlGzAb0s/GNe5Mw9U3VEY/uEfUZh22WRFYxlFhqz2OfQXmAMLT4Y
         0IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762460876; x=1763065676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1z2wjiHhvsejiQn/+tOEpXB/N3K2BinmsJSUyaKjfEc=;
        b=pLiStZXf1JIZAaxhZPT9mzNM5e89jQm3dRcyOqQv9vpA4EUb4QuVLhlPMxmSHPW1yk
         w5LLWMjtNIzcH6Q2WU7Quw3w7nylMG9/T84AnXkxDjU475wvZmVp3UWqApjMaAsUT8q0
         fTPF0cBYC/O8RUXAV9RXFewkW6O3rifOIbNWROch+0Wvj1msRfF8c10F2CCRFrk7JSt5
         Ud1hahcLOjKiI5SL1fhxdCTzXkY6EJEY3/M3VfQQMlIcs7Y/1bEPYCHtodzbqMKvFWmr
         WSPG+cmLJSnqBNtdBE6p4WgInzyPi0FpQC1/vkMjyOphf7fmGuJwriZX+3rCdsscstUr
         h5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCULA9Bv79Zq1EgzFrh9yirx8DCL/2Xc15NAe2gjqGJjLx5Wk1Yfrrrbme+ZAzZpfJakAv2wvRJNMh4SMLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4X2/FDmp9rGhr+PldPs0oWCwqEoIYWqcZbMKzhTIc6/fPh8Zx
	gAngkWUyMGsMYWK1ORCmbDHDR2jtLFsZYcG5zuhlpdVcVfgCWNyxrUYm
X-Gm-Gg: ASbGncv5ZsFVrK+uvIclJAOc+nMokadYYAwbjg6jQmejKhbUbLQWOCErHx57CMsdTL+
	JlpNK3DyX8M2udAo7kQIzAizzm+CV4WDhtdkvaktaGmvjpp17DMDOpIVCQoVz5YSDS8nnJK0cja
	Imzaw4bOM/nkH/Amdlps7hiKKeYkP4PN6KEYitgsvjEvZUkXLApT5gYM4EcWdKNBKWC0LKMT+DQ
	B32HFli5KAxlQKE9vcsBUGnBsSz+64YnRWCAnEKw6er42Zs5Ixb4gLW0qFuZtsH8JUtZx0VGSll
	wbUSFIvUo0EGTlIIMwUVcfnGzh74/o6bHNL8lqs6j5FWziCRvoEBY0WcD9isw/PT5FwWHj9em+d
	t9bE9ft8Ak9/wKxI3NWlXU96zvSRVR+AxtRGVCM6jWWYr9dS5Ojn4eDRBTXRFJEpKHAvK1C7xRf
	uInO/lb+cabPmPrh/RM4etjGOCEXb5
X-Google-Smtp-Source: AGHT+IHdBsgSQPK7gktxEdVBPh+hNOGF+tzMsBrl2JJsqB6qaGdVHc6sEdU0SVSxEKKOa2H7wzBBRg==
X-Received: by 2002:a05:600c:4e88:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-4776bcc34d8mr5465515e9.31.1762460875637;
        Thu, 06 Nov 2025 12:27:55 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm125100735e9.13.2025.11.06.12.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 12:27:55 -0800 (PST)
Message-ID: <690d04cb.050a0220.1f914.57e6@mx.google.com>
X-Google-Original-Message-ID: <aQ0EyPS8NmP2gehc@Ansuel-XPS.>
Date: Thu, 6 Nov 2025 21:27:52 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] clk: en7523: generalize register clocks function
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
 <20251106195935.1767696-3-ansuelsmth@gmail.com>
 <bc9074b9-27b5-4a31-ab85-ef7fcc309523@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc9074b9-27b5-4a31-ab85-ef7fcc309523@wanadoo.fr>

On Thu, Nov 06, 2025 at 09:25:23PM +0100, Christophe JAILLET wrote:
> Le 06/11/2025 à 20:59, Christian Marangi a écrit :
> > Generalize register clocks function for Airoha EN7523 and EN7581 clocks
> > driver. The same logic is applied for both clock hence code can be
> > reduced and simplified by putting the base_clocks struct in the soc_data
> > and passing that to a generic register clocks function.
> > 
> > While at it rework some function to return error and use devm variant
> > for clk_hw_regiser.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   drivers/clk/clk-en7523.c | 148 +++++++++++++++++----------------------
> >   1 file changed, 66 insertions(+), 82 deletions(-)
> 
> ...
> 
> > +static int en75xx_register_clocks(struct device *dev,
> > +				  const struct en_clk_soc_data *soc_data,
> > +				  struct clk_hw_onecell_data *clk_data,
> > +				  struct regmap *map, struct regmap *clk_map)
> > +{
> > +	struct clk_hw *hw;
> > +	u32 rate;
> > +	int i;
> > +
> > +	for (i = 0; i < soc_data->num_clocks - 1; i++) {
> > +		const struct en_clk_desc *desc = &soc_data->base_clks[i];
> > +		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
> > +		int err;
> > +
> > +		err = regmap_read(map, desc->base_reg, &val);
> > +		if (err) {
> > +			pr_err("Failed reading fixed clk rate %s: %d\n",
> 
> Would it be better to use dev_err()? (here and in other places)
>

Yes but I wanted to limit the changes. Is it possible to do it later?

> > +			       desc->name, err);
> > +			return err;
> > +		}
> > +		rate = en7523_get_base_rate(desc, val);
> > +
> > +		err = regmap_read(map, reg, &val);
> > +		if (err) {
> > +			pr_err("Failed reading fixed clk div %s: %d\n",
> > +			       desc->name, err);
> > +			return err;
> > +		}
> > +		rate /= en7523_get_div(desc, val);
> > +
> > +		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
> 
> I think that the issue was already there before, but should we have a
> corresponding clk_hw_unregister_fixed_rate() somewhere in this driver?
> 
> I've not seen any.
> 
> Or use devm_clk_hw_register_fixed_rate()?
> 

Well yes, I didn't move to devm as it's already planned to move to full
clk with .set_rate and realtime .get_rate. Is it possible to also delay
this in a later series?

(thanks for the review)

> > +		if (IS_ERR(hw)) {
> > +			pr_err("Failed to register clk %s: %ld\n",
> > +			       desc->name, PTR_ERR(hw));
> > +			return PTR_ERR(hw);
> > +		}
> > +
> > +		clk_data->hws[desc->id] = hw;
> > +	}
> > +
> > +	hw = en7523_register_pcie_clk(dev, clk_map);
> > +	if (IS_ERR(hw))
> > +		return PTR_ERR(hw);
> > +
> > +	clk_data->hws[EN7523_CLK_PCIE] = hw;
> > +
> > +	return 0;
> > +}
> > +
> >   static int en7581_pci_is_enabled(struct clk_hw *hw)
> >   {
> >   	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
> 
> ...
> 
> CJ

-- 
	Ansuel

