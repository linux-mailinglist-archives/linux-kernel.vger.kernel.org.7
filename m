Return-Path: <linux-kernel+bounces-894243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1DC4992C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFAD18866A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93275337BAE;
	Mon, 10 Nov 2025 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmA3EBBH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B13302747
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813619; cv=none; b=Gu+NEaWJef144SE3m1jwirZb76cbbLt8m153eITJya+vDDwoYf2cGMwLQZeHyRikgAinGEFXm8Qn0DAF7Lp8e++cfjiqqfcx84IQfsgQRe8qMzjVmY2B6D9ko1vZ+43D/DcpLFTuudhSxCe9uIM+4LHmbQ2+fKQUM9HwZqLVwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813619; c=relaxed/simple;
	bh=ga02Licy+YKpNgCmYN1YVytkG6Mk2o7Q83NArawwZFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOh8Hxi4fsxOoat0zexcwOJDl9IutJpQCMrVNftUy/3In+bwvgJOlWeWmqpMplErSowkFWu8c7drzB9zvQZn2q906LzfVdNrKHZL/IwYnQSE3Rf1pFJ0ayjCEAIr1RjCYGFM3RCV7f/h1WoCYK5yPigohnFSfop92NxT6hAtebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmA3EBBH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aace33b75bso3654626b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762813616; x=1763418416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLyXGRaLm6sEsE+EXjhF05M8r/IYZLjTnBThGk29/Q8=;
        b=HmA3EBBH2/+SlWRWgh3hYU2/fabIlEA8gbXOB53Z+AZeLZgpxpkEJOYXF9/XnHMPqS
         j0MZJF606Z/NQdg+iVgPDXOx7R40y0tnpgdDgO0pcI9/JglG/09tMCO1tY52imkChHLa
         D1DkPMKorBNdgxUY8A1F7fPRzdeHB/7oSpPOmgjR1BRKba2890IrcTKkhRAwH1vLFPTy
         EsZPEcNzulrNpKSu6nI0n9NfHZkaZHxpmGW5HiuwsDUSiZ/op00pOxFQ2OYT3d0T7O5h
         1KPF3AhYYf+f6jAL6Gs548yEWJ5IFcgCYarchv2ZjO+Zca6+TVLKLBEk1UXaEirwMLYX
         O+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762813616; x=1763418416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLyXGRaLm6sEsE+EXjhF05M8r/IYZLjTnBThGk29/Q8=;
        b=VKZy39S4HWFkJ+DfCNH6uNlmbPTGIfUNHLyfGM14atyRanwZy3YpLWvtQIyirB1VIF
         HI03kVhPSnBiZL0WeJRz6d2XZNy2F7Qj+7tB1aZdXAy64g/JbDPwxByVNUN/f/N6MJqY
         mxfR+KudKW/vM4KIGU7CYrcsz3GOcTuEf9OtrUUMTxa4Tfzu1Ct4YJyxf+YlE8/sGnSH
         jZcr4F2pBQDCnmHBmHYZB967znSicJO9EXEws4IefrF8KRHmX/nFXrgrYZmnLCZu1Uiq
         l8kC2D1IdclNlE+HeXy4Fb9D/ODKHUlUNR6xAYpo8ZOiu8Wtb90oKIcgB3fm/KFrD/E/
         E2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU0OWaYWIYSIoJAWFuVafptCmqBSukxW2HF2qMyHCRO889Nvt7+fNrHhjyfoPvVDVhARUfZof1YOoKcGoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygW03PBzm3g1c+YRuSlwCtV3KM9Ib5ngZrXZ7AmUig3kRziiSD
	fps79skvIfNMcftA9oN7/hMtFjs+P0RwIYgCPSV1dKLRubHvQfu6NAw/
X-Gm-Gg: ASbGncsplk50CeoZA+Hp13H7KkhjSA6FtHlGvkkBZbZGK5Coo4HPeqT8Gav0HMSz27w
	IZx4+AW/edvXJkeRY+L/1BGYCUiTYr0s922ANhmiVy/yW+bh08jnMmWxSrIrJukOMeSkmOy75Eg
	BAIMtDTUjMPKQWIdTknykpXUfvYli83mrFBnTjYqElT9vZ2c8rr0uixumofDMZLSaEJzp3QoT7P
	N5SlaBWsLFr3Xfnm1tH01xvn0ZjQDACKK6V/u0Ouxh4GRydCGPFxS+20GVyE4X1X8QsZMTSjCy9
	3jqrkBPmxE5SDkTjc0HMO7q/HdDAwNXZ/cUrMOd1QvOrx0iXswgNcG7YW484BUkMsQ14WLw5zIr
	dXWuzU2Q+DQeZpnyTV9kD67Gzq90EAkvoQ9eW6PVVfaySH6ekt2gHskBy7M5MT+xxliNgVX8GLu
	CihWZcMoTgKw==
X-Google-Smtp-Source: AGHT+IEk3kYn28lJz/C+AXXcRWMVZ9b5FI05N3tJpVXS4fy3dE0avtehbQZNj/cOBXS8KtnzWEvWzw==
X-Received: by 2002:a05:6a20:e605:b0:357:be83:d026 with SMTP id adf61e73a8af0-357be83d02fmr681099637.35.1762813616432;
        Mon, 10 Nov 2025 14:26:56 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8c880c5sm13710401a12.6.2025.11.10.14.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:26:56 -0800 (PST)
Date: Tue, 11 Nov 2025 06:26:32 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Simon Horman <horms@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 3/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
Message-ID: <g2tqvcw7ocewzbqy7txz6sumdxeelhl4jk2s3btnnijyt572di@nrfcac6grpvn>
References: <20251107111715.3196746-1-inochiama@gmail.com>
 <20251107111715.3196746-4-inochiama@gmail.com>
 <aRJGZjgTgcjZgIqe@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRJGZjgTgcjZgIqe@horms.kernel.org>

On Mon, Nov 10, 2025 at 08:09:10PM +0000, Simon Horman wrote:
> On Fri, Nov 07, 2025 at 07:17:15PM +0800, Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be removed
> > when initializing the mac, otherwise the phy will be misconfigurated.
> > 
> > Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <rabenda.cn@gmail.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> 
> ...
> 
> > @@ -50,11 +56,23 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	data = device_get_match_data(&pdev->dev);
> > +	if (data && data->has_internal_rx_delay) {
> > +		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
> > +									  false, true);
> > +		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
> > +			return -EINVAL;
> 
> I'm sorry if this is a false positive. Because, more so than Russell [1], I
> confused about how about the treatment of phy_interface. But it seems that
> there is a miss match between the use of phy_fix_phy_mode_for_mac_delays()
> above and the binding.
> 
> The call to phy_fix_phy_mode_for_mac_delays() above will return
> PHY_INTERFACE_MODE_NA unless phy_interface is PHY_INTERFACE_MODE_RGMII_ID
> or PHY_INTERFACE_MODE_RGMII_RXID.
> 
>   phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
> 						bool mac_txid, bool mac_rxid)
>   ...
> 	if (mac_rxid) {
> 		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
> 			return PHY_INTERFACE_MODE_RGMII_TXID;
> 		if (interface == PHY_INTERFACE_MODE_RGMII_RXID)
> 			return PHY_INTERFACE_MODE_RGMII;
> 		return PHY_INTERFACE_MODE_NA;
> 	}
>   ...
> 
> Looking at phy_modes(), unsurprisingly, the following mappings occur:
> * "rgmii" -> PHY_INTERFACE_MODE_RGMII
> * "rgmii-id" -> PHY_INTERFACE_MODE_RGMII_ID
> * "rgmii-rxid" -> PHY_INTERFACE_MODE_RGMII_RXID
> * "rgmii-txid" -> PHY_INTERFACE_MODE_RGMII_TXID
> 
> And in the binding, patch 1/3 of this series, only phy-mode rgmii-txid or
> rgmii-id is allowed.
> 

rgmii-txid is a mistake and should be rgmii-rxid. This is because
the mac of SG2042 add rx delay, and the phy can only add tx delay or
no delay. So the phy-mode can only be rgmii-id or rgmii-rxid. I will
fix it in the next version.

> But if rgmii-txid is used, PHY_INTERFACE_MODE_RGMII_TXID will be passed to
> phy_fix_phy_mode_for_mac_delays(), which will return PHY_INTERFACE_MODE_NA.
> 
> Again, I'm confused about the mapping in phy_fix_phy_mode_for_mac_delays().
> But there does seem to be some inconsistency between the binding and
> the driver implementation here.
> 

I think this inconsistency begin with the change for ethernet-controller
binding.
https://lore.kernel.org/all/20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch/

And this function serves as an helper so the driver can only add
the delay once.

> Flagged by Claude Code with https://github.com/masoncl/review-prompts/ 
> 
> [1] https://lore.kernel.org/all/aPSubO4tJjN_ns-t@shell.armlinux.org.uk/
> 
> ...

Regards,
Inochi

