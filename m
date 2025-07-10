Return-Path: <linux-kernel+bounces-725776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D76B003D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95D03A1D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501E725A620;
	Thu, 10 Jul 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vm14feyC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5C259C9C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154699; cv=none; b=W1Ku2lfyni8uuhluEQ0n6Ju0ptOqfKFbHzk/0J4i0BOnd7Ed+r8ZJcW4s54CPB+YeeSwGd/Lu892LGe2tIRh+qxRaOB9x2GnrbvlDGRxXJz3b+LSkQADw+dX2sRXI+mcuzonF4Pkw3ZHIrRC/YryFQY+a7USPM4Ohkgyz0kgtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154699; c=relaxed/simple;
	bh=8HdzRL7XwSUmaZJn3OLC1wcMSvNhBJrMNCIW+lLGX3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxIYA9qrvtJ0sYInrSED/nVxfY3pBZNCli5bKVNAXg0XKtasq5QttB3kPX5sY5QwRMwIjFvSFy60lx+alfK7OZsEjuR/2au5Ry4LBCdcvCl5HbBEPPS6lCL9AtousS0yPd7489g8LRx4uG7pzke0XqkeXgiJUBqZGZhhocoz+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vm14feyC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752154696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k74++Gj6mC8jHgJQv0ogxWO3KmAcEfy1icxFrtSNc/Y=;
	b=Vm14feyCP+HmcgpYzZ5K2IJIHVN6HqCeNDrMQ/VUGaq8yk9QxBz6aisjHEhxwpi4r88vyy
	coL28rAIqIGufOzQ6EogjXp1UD0Mh81FBuDIQU1IkgZUKj2JEYDUVah0F/qGPznSVvDF4D
	Z8QaFTIg0CZu5Z7IKnV3mDo3AhdGfSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-f1lvfYHdNiqT6MiEnnhslQ-1; Thu, 10 Jul 2025 09:38:15 -0400
X-MC-Unique: f1lvfYHdNiqT6MiEnnhslQ-1
X-Mimecast-MFC-AGG-ID: f1lvfYHdNiqT6MiEnnhslQ_1752154694
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso549425f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154694; x=1752759494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k74++Gj6mC8jHgJQv0ogxWO3KmAcEfy1icxFrtSNc/Y=;
        b=ewqAOBJR3TF1Rdc61Q2Oilrmuuaf02YJ3pVGMlWILUHUlPoVeOMGhhmBdQojIIwbAG
         WcgKIwaR02PFOTkBG8XfmyGXUtNRpUYmAK30X3rLy+JyfcU2ErHazt6PqP9zR1P0x88Q
         2nRSu6vFbz9VV0GAqDN5CPKcV5n3TNK51Py7TTTKXbKfJLBCSjHoaYppeCzw3J2ic0Qx
         QARZsHAbM1WjmENlE81/AMDdLR7f3cQsmGbBe7/P38/bhoxUrufdyPGfck1SOr4seOgO
         I1n554LDvWMGXlQtJCuXoc9qTszGePEkt+nwD0McKvc4RrOBuVNyeE2ihybXC2c3l2GF
         Ed4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGkjWJ5VRlRFGxlGf4tw++GT05aTWEmE4c6qMgujOpsEZkclOngvLNHVmOHPw6TsotDRd1wErhHGCa2f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6cX6f4/KAr8qz/H9mnO2D6erBky34XH7bw0xF5P/UllZR0Kx
	NHqZjn8M3rwjU/NppaCn5zBeIFZvkQGnE36P5CRmg4hdQQsh8zzvjQRSABvAYjCmwFXmHGVlLoz
	tkYejCnjEhX29xCDOLF8AqNDbql7qhxElE/j7T67W0YZKdqRqiIvBIh8to6cTDSg7eA==
X-Gm-Gg: ASbGncu3/UKfyzKkBlrsyDlqW5mwbIoCNOlg4dv9ICi/cie2hEUE7FcV0t3unqRU8wF
	cFBIAimdz5Jz4cTQNCsL6zfw+ifnUgREQsVXBCWOgCuVY5LZTQe5k3bKsH7NXCgcOgab5kYavZi
	Z5Gj2CpYP18La5P1SHTXnmV5xTvjlnqjvSYnggymKnvL+kNk2n2QjDE1/TwtQ+axhBI3q49+cZp
	bbuGXIKClfjAbMGHXAbcNF2N1YaId531hZiPOceC4ru2qTeP4kg6RF5hLn7W5ud9qXfl9PpCogU
	zK7ifwQ53s371iLglmHBaj3ARMZiVr2sYvfRarURgGnAckpke7nSkksgn4Eu/CBuDpmXqA==
X-Received: by 2002:a05:6000:25c1:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b5e453e795mr6293762f8f.53.1752154694222;
        Thu, 10 Jul 2025 06:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/3w+jgqSIhgVT6bjFgh6I2ptL2zBPyyD880oIC6m2OkrqYySieSotNvQKfZlGVi50FjlirQ==
X-Received: by 2002:a05:6000:25c1:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b5e453e795mr6293734f8f.53.1752154693763;
        Thu, 10 Jul 2025 06:38:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1f4edsm1872432f8f.83.2025.07.10.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:38:13 -0700 (PDT)
Message-ID: <60e77fb5-ef9f-4c89-899d-398cd9eb8f85@redhat.com>
Date: Thu, 10 Jul 2025 15:38:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: micrel: Add callback for restoring
 context
To: Biju Das <biju.das.jz@bp.renesas.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20250707142957.118966-1-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250707142957.118966-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 4:29 PM, Biju Das wrote:
> @@ -374,6 +376,7 @@ static struct kszphy_hw_stat kszphy_hw_stats[] = {
>  };
>  
>  struct kszphy_type {
> +	void (*resume)(struct phy_device *phydev);
>  	u32 led_mode_reg;
>  	u16 interrupt_level_mask;
>  	u16 cable_diag_reg;

Why adding another callback? I think you could avoid it using a
ksz9131-specific phy_driver->resume.

> @@ -444,6 +447,7 @@ struct kszphy_priv {
>  	bool rmii_ref_clk_sel;
>  	bool rmii_ref_clk_sel_val;
>  	bool clk_enable;
> +	bool is_suspended;
>  	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
>  	struct kszphy_phy_stats phy_stats;
>  };
> @@ -491,6 +495,7 @@ static const struct kszphy_type ksz9021_type = {
>  };
>  
>  static const struct kszphy_type ksz9131_type = {
> +	.resume = ksz9131_restore_rgmii_delay,
>  	.interrupt_level_mask	= BIT(14),
>  	.disable_dll_tx_bit	= BIT(12),
>  	.disable_dll_rx_bit	= BIT(12),
> @@ -1387,6 +1392,12 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>  			      txcdll_val);
>  }
>  
> +static void ksz9131_restore_rgmii_delay(struct phy_device *phydev)
> +{
> +	if (phy_interface_is_rgmii(phydev))
> +		ksz9131_config_rgmii_delay(phydev);
> +}
> +
>  /* Silicon Errata DS80000693B
>   *
>   * When LEDs are configured in Individual Mode, LED1 is ON in a no-link
> @@ -2345,6 +2356,11 @@ static int kszphy_generic_suspend(struct phy_device *phydev)
>  
>  static int kszphy_suspend(struct phy_device *phydev)
>  {
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	if (priv)
> +		priv->is_suspended = true;

Under which circumstances `priv` could be NULL? AFAICS it should always
not NULL after probe.

> +
>  	/* Disable PHY Interrupts */
>  	if (phy_interrupt_is_valid(phydev)) {
>  		phydev->interrupts = PHY_INTERRUPT_DISABLED;
> @@ -2381,8 +2397,17 @@ static void kszphy_parse_led_mode(struct phy_device *phydev)
>  
>  static int kszphy_resume(struct phy_device *phydev)
>  {
> +	struct kszphy_priv *priv = phydev->priv;
>  	int ret;
>  
> +	if (priv && priv->is_suspended) {

I think you can use phydev->suspended instead of adding another flag.

Also, can resume be invoked without the phydev being suspended?

/P


