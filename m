Return-Path: <linux-kernel+bounces-721323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF86AFC7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991221BC4182
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58190267B74;
	Tue,  8 Jul 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6LkYvGT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D020E033
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969015; cv=none; b=h+mA+3C+skfBAdfsnIG8WKSkSMQrr02nr3pZkfOBUVdtCpQgkVTxz1fuLZR5iKVtHLTeKf7zgtihgPeKzqyJbpD8gY0qSHB7lCKxBRy4xnIvCJ5clNnJh6WW7xwYjkp7/Q5CqeNTEDhnegSJ+fPumS9uaTHUb1xWPGfzSaVW66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969015; c=relaxed/simple;
	bh=J8x/CPUWA0HL/cid4XRRf2yJGc3d9K5BSR2KvtLBWhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/bd73cd3hPam/MxjNg8FYwHx+nufAS027QFho/FMupaKoaQeWfuFhHmZjOlN0xWoaEkeZlCpa719OCFP81R1VDZiRViM1zEikpb13t/jRN4OqfG8R3f3BUKWCAha4BgOwRc1pYRgJSUNm6ItJDnQLyNS25eUrVr/NcqrbCwiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6LkYvGT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751969013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YHab4xqAP2Akdg2G04m0t1Le3rHcVZpLaQPZJUOZ1g=;
	b=V6LkYvGTE6pn07RAvUL5Fx1HtVgO77Fgo8kv8Rm78GVrhQ1PwpBMKi7zNb+f6d+Q4WXarM
	01re35gRccT+vnASoZrum+Hqtbxd8pVS7yDNXvU3HRj8DEYah9Zi87uMc9mJ28wfFpvYTx
	loza9DCppkRwI43MvZze3S/NhmdQXco=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-OCyiKpLGO5yGQy4t60if9Q-1; Tue, 08 Jul 2025 06:03:32 -0400
X-MC-Unique: OCyiKpLGO5yGQy4t60if9Q-1
X-Mimecast-MFC-AGG-ID: OCyiKpLGO5yGQy4t60if9Q_1751969011
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so1775147f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969011; x=1752573811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YHab4xqAP2Akdg2G04m0t1Le3rHcVZpLaQPZJUOZ1g=;
        b=NQ09JfLiWwQ/jdI0WwQBEqM3eLAor1m4QFCkMBi0HnTb9WkSPpA4c7/gp+Nu0Ibexf
         oKWLs8d360KhwSmh+72Pm+en9aHTXh+y+NSFsnh/9cJSrSC/PsNhty6o/BkkJ1+dIR+x
         6gC9BH10rnAVfOE+EFoiF60jk4xn+WKWIw2IiGf9QHEhEdpHpRJ/WPu5chuxvYOikaJT
         ZiZM5Nhtcqyra/3nKbbR6tAqjY5HZMWZ7FKhTnRIVp/5VOq5Qmsr1CgrK/oKVQBnHs4t
         KxA/7g0MtzzWtxsHf7rriZWHhicE9gB95x82Bi4DvFA7ykBwWIEpguBGDlIqXWU4UxKG
         4vbw==
X-Forwarded-Encrypted: i=1; AJvYcCXffOVc8jxMxd9GW1vaZjivJ58lEF0WirNXUrCtaqzgeVCIQu3T91LDGVmHqusZ8CUSXfeO2n5JkHC4e2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJtF10V8YV2JOXSk1fK28zzH/pGbR+RuLGAHvxrHXFb0LldPl
	7ucZekG5kQzerV8cXcwJT/3oizO+7CoGZ1WhRiapIiHV+87+U/FrZsRJEs06iRYBAsTheweEzsS
	xuMC/tzCpcudEIp9hwvcE3yLVyEhVQbw7WIyG1PbwFysAbCv3BSNoDhuDixWHpUKCRg==
X-Gm-Gg: ASbGnctMsdd7Za6E0WSbL2+Tu6Gqw5bttZWEmY+2Hl0eC0KlKSpAy8mjYMuhllV0DS3
	Zf9vSy9UW/SwP7ayV6CetEw/s40Otw6Als8mV243b238LeDGwvJ1K1HP2vLdr4+r0vXcA7pLGT+
	qq8bXWGlaihCkkG301Ds0ctKl/phCfMkKpLdXOyPz8TIzME/YZuwwxMzd1mVqz/c2EIGX+BOdFC
	soggKhWtiEj+2S0sqFVKRGVP7MwI1iFb0NVscATctLbDXPXjXP92BOA4kyNC8Vq3nj/UEk4zKqV
	Gkl7s32wt4m6qdVdytFx15+IBs66ovLdsLt4Dqp6lu4IOUdJxRQ3Hee/hbvyBzKQhV74Eg==
X-Received: by 2002:a05:6000:1787:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3b49701198dmr10216083f8f.8.1751969010540;
        Tue, 08 Jul 2025 03:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1SvwWcO9VGXYTPULjJBC0m6vJeUr2jVKEuOXwryHw29XUGkc++r6gFKLLfQS8l/e7j3Mcpw==
X-Received: by 2002:a05:6000:1787:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3b49701198dmr10216057f8f.8.1751969010016;
        Tue, 08 Jul 2025 03:03:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba48sm12695745f8f.13.2025.07.08.03.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:03:29 -0700 (PDT)
Message-ID: <ea22a546-9381-48c3-8bb6-258fdd784ca3@redhat.com>
Date: Tue, 8 Jul 2025 12:03:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v14 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
References: <20250701114957.2492486-1-lukma@denx.de>
 <20250701114957.2492486-7-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701114957.2492486-7-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> +					struct net_device *dev, int port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	struct cbd_t *bdp;
> +	void *bufaddr;
> +
> +	spin_lock(&fep->hw_lock);

mtip_start_xmit_port() runs with BH disabled. The above lock variant is
inconsistent with what you use in patch 4. Please be sure to run tests
vs the next iteration with CONFIG_PROVE_LOCKING enabled.

/P


