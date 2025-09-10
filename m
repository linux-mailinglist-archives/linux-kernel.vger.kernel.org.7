Return-Path: <linux-kernel+bounces-810346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9896CB51912
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E591B20C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22BB322C6C;
	Wed, 10 Sep 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTxWaaHT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC7322A13
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513670; cv=none; b=R1KebngEUjbb50tQJl7BZSqy07t9681XkACZ+rdlWbJz3V9yA2skwtwV0X3MBU/RboaJGdWHQqG7bJaKawE9qcnkor+MFvkwXiI1rFUvNTmrVXq7xxgN1tmzfjv5n4jLO6UOBMHIiamO41bUPZGM8zADXUD36wgdUt1Gb0zzXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513670; c=relaxed/simple;
	bh=r+AaCInzdkxBbx9W02sgOISt/s07Hcu0+abKHIJ1GWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6C6Bmv8ydi/g8Tdk93fKGpvDe9of+bDVnuFMLiz0p9iyfYgTIghAgICbofawLnW0FHxQRqs+SqSs0WR0jdZAd3riIQLeljKmnNT4Risu7mAjs74rcgkxWuHFSRG8uUuXvtjA2+nwt4MPWS9+HegHPCcBe8DzeGECiY2o3Mh9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTxWaaHT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757513667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AKBrsHYyZy6NVWerxVC8iAlV9/6fvAVIrP6ESd120U=;
	b=BTxWaaHTtOtGwDywzanXaVXZxJdaVxryrkLrnQ4nhGLAgnTTwY3Q9tNVf3ENMSRMrSTIZ0
	bSR3yWws/GO+q7PDyXpBN4UNskvGRVV3vsPhIgcPJ4fcM9EQeHzdOfOxqhTphP01qIz+78
	K8MmIXLWbpmTIuOnQbY0Q0ku5vJONMA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-fZmhRWODNjCkuj4yaylHpg-1; Wed, 10 Sep 2025 10:14:25 -0400
X-MC-Unique: fZmhRWODNjCkuj4yaylHpg-1
X-Mimecast-MFC-AGG-ID: fZmhRWODNjCkuj4yaylHpg_1757513665
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8153161a93eso1350636285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513665; x=1758118465;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AKBrsHYyZy6NVWerxVC8iAlV9/6fvAVIrP6ESd120U=;
        b=YM4BRXnkXI8/nEamS3MUhVPtvTMulw9l+MnEebpPVUKYpK6Ttfz4bMTQWbQdkeTHWW
         zXF6S436Ns6ESijOb4xnZYRNC4sbVeNGHnFhvejCyGzakwxhwyos9zPJfljTURyY5oml
         orTsoAMTKeTp8bpJQkGjMuhakb3geE6ITlNK8a2JAa7YsXa+QTBGIYFPQ8hzFRPxL/cj
         y5jfFoxgp60zwt4ohuXIvOEk5tI7vo95cj1tANqT3b+0yBmLa95lQWb+wZjIRy6YLuuM
         W1bhzE9NLFQsDDsdUhMW+GffXj8/GohBd/hq3pAWt3CpSsp03Nxymu7sNORWSYvb/GsY
         ZpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv+MgI1H31vvT0aVCJqY3CcpDOTMJeyfDfMi0nOogsuxVKcFUbhF7uiBn0qaCKgj/xC90WX7iAueN6x+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7JNzqK7Wx3QObgfLbPKkdGTZvtz1hI+ZyQ6wFjkfpkxs8Qnef
	eEoNcyv3EOf+c5KOR7k8uBuuSnGgA2MNkrWC0q3KACrWZsGb8/DMO7MJmsQ/ot1yy3ZkokmUncV
	WMju+2VoIj5x6xCDr0Pasrt96RT11K1uutzW6F9PfRUu4KjbJi5bNjjctYBAgdlaMXg==
X-Gm-Gg: ASbGncuKkxE7HIc4V+zTqy8GcuHlXe+wDPSAUPVe0a2734JJ3A7/eaRZfXDovwUvfUl
	x/T7Iy4y5ky3j4mo0dgba3Gg6L0gzjIYboKTIPhHsLFsBEPwW+W9gJ7HVW6B7m5na+LqDBJ1VYC
	unD+NckzBKPb2VSJWDLlGCNUfXRuQXp0Xr9lVtv0/RhnFZU+i4nf2pIRDGlVQiEigVjeAZiV5Zu
	DhLIqdKpzlSsccX+kvF5slceV315dRnmZLhBhFZDKeBr352GOTiCBRevmQZiW1R+ldwFIOxUyZA
	XjysnIWEJYXsLfQtXHf+ZPm5D0ATbqE0jzxIjNBQc+z6GewPXJ+HyRlqAEaBwzGtDZviGDuDl/m
	ohV8RUooctYjRaewokWA=
X-Received: by 2002:a05:620a:1997:b0:7e8:922:f02b with SMTP id af79cd13be357-813bed042c0mr1615331785a.25.1757513664995;
        Wed, 10 Sep 2025 07:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkFeL3wPJOKIe3shUG9pzAQKQjdBD+pGyVy/83wrA05r4tPdXbaw2hUPMEXQ3KZIEvXGTTLQ==
X-Received: by 2002:a05:620a:1997:b0:7e8:922:f02b with SMTP id af79cd13be357-813bed042c0mr1615324385a.25.1757513664239;
        Wed, 10 Sep 2025 07:14:24 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58b5d7fesm299937185a.8.2025.09.10.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:14:23 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:14:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mo Elbadry <elbadrym@google.com>,
	Rom Lemarchand <romlem@google.com>,
	William Kennington <wak@google.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>, wthai@nvidia.com,
	leohu@nvidia.com, dkodihalli@nvidia.com, spuranik@nvidia.com
Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <aMGHvHf6BPrJD1pC@x1>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Ryan,

On Tue, Jul 08, 2025 at 01:29:09PM +0800, Ryan Chen wrote:
> Add AST2700 clock controller driver and also use axiliary
> device framework register the reset controller driver.
> Due to clock and reset using the same register region.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

I just have a few very minor style comments below. Otherwise the driver
looks good to me.

> +static struct clk_hw *ast2700_clk_hw_register_hpll(void __iomem *reg,
> +						   const char *name, const char *parent_name,
> +						   struct ast2700_clk_ctrl *clk_ctrl)
> +{
> +	unsigned int mult, div;
> +	u32 val;
> +
> +	val = readl(clk_ctrl->base + SCU0_HWSTRAP1);
> +	if ((readl(clk_ctrl->base) & REVISION_ID) && (val & BIT(3))) {
> +		switch ((val & GENMASK(4, 2)) >> 2) {
> +		case 2:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1800 * HZ_PER_MHZ);
> +		case 3:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1700 * HZ_PER_MHZ);
> +		case 6:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1200 * HZ_PER_MHZ);
> +		case 7:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 800 * HZ_PER_MHZ);
> +		default:
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else if ((val & GENMASK(3, 2)) != 0) {
> +		switch ((val & GENMASK(3, 2)) >> 2) {
> +		case 1:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1900 * HZ_PER_MHZ);
> +		case 2:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1800 * HZ_PER_MHZ);
> +		case 3:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1700 * HZ_PER_MHZ);
> +		default:
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else {
> +		val = readl(reg);
> +
> +		if (val & BIT(24)) {
> +			/* Pass through mode */
> +			mult = 1;
> +			div = 1;
> +		} else {
> +			u32 m = val & 0x1fff;
> +			u32 n = (val >> 13) & 0x3f;
> +			u32 p = (val >> 19) & 0xf;
> +
> +			mult = (m + 1) / (2 * (n + 1));
> +			div = (p + 1);

The ( ) is unnecessary here.

> +		}
> +	}
> +
> +	return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name, parent_name, 0, mult, div);
> +}
> +
> +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void __iomem *reg,
> +						  const char *name, const char *parent_name,
> +						  struct ast2700_clk_ctrl *clk_ctrl)
> +{
> +	int scu = clk_ctrl->clk_data->scu;
> +	unsigned int mult, div;
> +	u32 val = readl(reg);
> +
> +	if (val & BIT(24)) {
> +		/* Pass through mode */
> +		mult = 1;
> +		div = 1;
> +	} else {
> +		u32 m = val & 0x1fff;
> +		u32 n = (val >> 13) & 0x3f;
> +		u32 p = (val >> 19) & 0xf;
> +
> +		if (scu) {
> +			mult = (m + 1) / (n + 1);
> +			div = (p + 1);
> +		} else {
> +			if (clk_idx == SCU0_CLK_MPLL) {
> +				mult = m / (n + 1);
> +				div = (p + 1);
> +			} else {
> +				mult = (m + 1) / (2 * (n + 1));
> +				div = (p + 1);

The ( ) is unnecessary on div on the three places above.

> +static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl *clk_ctrl)
> +{
> +	if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID)
> +		/* I3C 250MHz = HPLL/4 */
> +		writel((readl(clk_ctrl->base + SCU1_CLK_SEL2) &
> +			~SCU1_CLK_I3C_DIV_MASK) |
> +			       FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
> +					  SCU1_CLK_I3C_DIV(4)),
> +		       clk_ctrl->base + SCU1_CLK_SEL2);

This block is hard to read. What do you think about this instead?

        if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID) {
        	u32 val;

                /* I3C 250MHz = HPLL/4 */
                val = readl(clk_ctrl->base + SCU1_CLK_SEL2) & ~SCU1_CLK_I3C_DIV_MASK;
                val |= FIELD_PREP(SCU1_CLK_I3C_DIV_MASK, SCU1_CLK_I3C_DIV(4));
                writel(val, clk_ctrl->base + SCU1_CLK_SEL2);
        }

With those addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>


