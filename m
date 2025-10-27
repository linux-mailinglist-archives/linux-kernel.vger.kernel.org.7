Return-Path: <linux-kernel+bounces-872729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E515C11E51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E6494FA651
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE92532D0CD;
	Mon, 27 Oct 2025 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGAz02J7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286028466F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605250; cv=none; b=kvEcUgktXSgnrVRG2Khif3aAinRRLgeoo9nHnepEjUFBIJW7FyfEaPo7Z9TxsiMdmrjAcixhbzWXkprW9FAx1w6wPsg2Shgfy6zRGJq92XAFMa46OTn1EXrCQe64GZQZJ5HhlU1isI8VZrVEPohW2NvJrj0YpfHgf+1GOxYrTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605250; c=relaxed/simple;
	bh=m88xe+CFu7eQlOKAj62e4b+NZw6EJaqpxFhk3oJIzNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQH0frSS828O0ABBo6wKc+uag0N3OojRsGnep1hI95d1+MYkp6OFxpCCj5+qpU8PUICPQieml0UXpmmVaJ4uj41G38QdF86xJkQthdHQ7GT4ohvAhSZn3yiTjJ6MncTfWOnAp6EpPYUUO2msITDJeV4IY/qXarsRb87WOUQibqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGAz02J7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d5a2523a2so96263966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761605246; x=1762210046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xICsdCX2OPVmE7J35So75daqsj8TFidqC709lELfyCQ=;
        b=SGAz02J7aTOTspclcWYv2+ALIRXQh7s2rFsxFAw7jlEi5Sz8KJj6Y0lmeqDVmy6Yyj
         Hdq9dcakoaQDmakSZAuR7M0vxZr8vvo/FtzTJ0m6U74m5piDxv+BmU0Eb2TXo+pXuhp1
         SO/Z0EjBEOM8s/Cx40SUGS944XqM5dA+pf5iEyw2tHmWYYetH1qEaTs+IfwSGnIfccxL
         NKDlnq3aapj2cMG5eyemSJmnGvFJ9sOQDqdsFq8rzGV7ByrpUh8B3fzIm3stk0NiBtzS
         F6YiH+T9/r1LaB+/CksMNev1mBERFSTu9mkURw3qc8BCpsFEVCUe06ettl4WYn//tvkn
         7pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605246; x=1762210046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xICsdCX2OPVmE7J35So75daqsj8TFidqC709lELfyCQ=;
        b=TPw3B4DtOtj/tYT0xyStck4hn8mMx8lCe+jWxsLR1J0QcELKlfsBrjGiL4VfH7HIGg
         0CzfzM0Nj6WlI6iEzPWuSB/k23n1QE65U0k5Q4CaagQ6n+6AL5OrlCLO+o9enXSU7CED
         SD/R8xZF6WPCxYZ8dJWKAfiC0yl4ajpUIGVmlAvFAjXiBlCe1YoRuLfsB5B9Q2lxX1J7
         pYbv//aRywJVCt2e6jH3u07aVcUhcnAJ39ocph4ysyN01xJ6OECIQLID8VnI8kS69eQ8
         xIq6l3AIb3B+zqsL5YBSbxJgX4X9nWHYsGVteOtXe0eh+fnLwClbkqzXFe9nPQ75cZOa
         T2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUyuD7FrGrN7iFe7gX1y7R45QXNYGuqZw2KwgUCSRjZocQm8ana/p7SFkblvLeNUWl9aiMvg3vAd9UvszE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbvdnEE+s93R03cNphq5o0ORIXjux9YHtFZFNG3iyfVmZh3h7
	EmLVUGIikXwKiSXebRYseCOc3RrJPF+8+04vBXbeJLc/Uree9LhNjvOW
X-Gm-Gg: ASbGncuTrfIEVkUPSUPmaLijrYcJX+GKvEGsnBxMKhctYkudw31JQ2Jo6+t4AJFUczl
	39jjAAMUAW8opcVEumr1EBenQZ3fEarJz7VLMWM6NOGPdTZ0OonDhQ/Dif8BObpxWRno6keRYKS
	ZAyNbwPx9186D8AgET7/lkQt+BwiGM+mA2cRo1xC1wk7etHd7rtzcpz6wU9dwU5wyo0ZoGFGFHT
	lBBiAgGELAGrABPpLd7coQhOTfalHSehLePoEHz8zrkEajP+ETMk/LnUXKGycK1CS8ru4u3VaLc
	966Nmw20okbTHaQgv/kUnsW3uiXnArPpsIfA1sfRcdFp7gUOvNTowGopy/0uPdJ4A7e4VEag3EK
	moDHgEXdxp7v2XkpNf9XYQLjn1FmVSCDYkqzD0KIOq4h38kpKjISHD7Ecfl7iH/OeZcCHu1+dbn
	eNkDEW/QuJ8JoAvg==
X-Google-Smtp-Source: AGHT+IHsT6znAJ/IU5WiN+lCitGKC0rENZLS+TtfXHEris+/Fh6vEEJWdxGjs849S6TJtLzLEjWn5w==
X-Received: by 2002:a17:907:3f24:b0:b57:1fd6:5528 with SMTP id a640c23a62f3a-b6dba5d558amr90605566b.10.1761605245829;
        Mon, 27 Oct 2025 15:47:25 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85359687sm891347566b.23.2025.10.27.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:47:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:47:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 05/12] net: dsa: lantiq_gswip: define and use
 GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
Message-ID: <20251027224722.akxniuim6yvfuq6d@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>
 <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>
 <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:44:50PM +0000, Daniel Golle wrote:
> When adding FDB entries to the MAC bridge table it is needed to set an
> (undocumented) bit to mark the entry as valid. If this bit isn't set for
> entries in the MAC bridge table, then those entries won't be considered as
> valid MAC addresses.

Irrespective of GSWIP version? Does this issue have a user visible
impact that would justify targeting stable kernels? My reading of the
commit description is that the driver can never program static FDB entries?

> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/lantiq/lantiq_gswip.h        | 1 +
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 56de869fc472..42000954d842 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -224,6 +224,7 @@
>  #define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
>  #define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
>  #define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
> +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */
>  
>  #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
>  
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 0ac87eb23bb5..94b187899db6 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -1149,7 +1149,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
>  	mac_bridge.key[2] = addr[1] | (addr[0] << 8);
>  	mac_bridge.key[3] = FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_KEY3_FID, fid);
>  	mac_bridge.val[0] = add ? BIT(port) : 0; /* port map */
> -	mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC;
> +	mac_bridge.val[1] = add ? (GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC |
> +				   GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID) : 0;
>  	mac_bridge.valid = add;
>  
>  	err = gswip_pce_table_entry_write(priv, &mac_bridge);
> -- 
> 2.51.1

There is a second change, which is that GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC
no longer gets set when "add=false". If it was deliberate according to
the commit message (for example if it appears to not matter, the FDB
entry is deleted anyway), it would have been fine, but nothing is said
about it, so I have to wonder.

