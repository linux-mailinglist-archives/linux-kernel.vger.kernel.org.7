Return-Path: <linux-kernel+bounces-855235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF0BE0928
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F0574E788D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481730149C;
	Wed, 15 Oct 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C74SUiMa"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7F41C71;
	Wed, 15 Oct 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558428; cv=none; b=EBhpAikxVLiFfRnWLjz8TMXZhj0XNj7tK/P4yVEm5RbJuYVM0B0FU71BxNqmN7u/qsRegDB+aVbBHU9mCO/pTzqB67Atj87r0SU8TQaSgNiOFE7b/KQXYaLcSLkFB7K9Es5bd/EZp2RIfG5VQGJwZRSu24vYg2LcLqIbW0+nDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558428; c=relaxed/simple;
	bh=RW+BXgyaoyrPiHLnoC9hh3nXlvBz+fvlgT2L7t106jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZSasY4PThpXcCp5qIh36UBacbdsDTdJc0De+bwJfLliE+EAN9rmKUoI4n87zIBr8e0ibD9ERkup6AoIpg6tBMEURkld9iyCNJZFvGSJlx4a4Qjllx82g/j/c5AGzMZod7b86twtZNXqls8vrkP1emWVxkzXlQayRmRvBOFI+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=C74SUiMa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UyAyBxkXaApDM4KsfpCB8GHoJifPSp90vnbMpVzBWEA=; b=C74SUiMaBsN6Ewv2nuaqrHGEsU
	c1hiR0wYJ8u5oCxQwvULH0b+wZtnM9GjcGti8ITX0XWijY0Bqbeh76Vkl8YbGLqaZRxTHx33RBuCa
	djChBbayFMyi70dLEFMeB9fqbF7zbphGAipQYyd77oIzUIp1Mwfz9xRc012+Nh7M+OK+3q/RrDYSX
	1ba5A17DFmcUFir0f+ojyJ6F0cfaFQ98EJD1Ot95cJEZuOvtr4+NZV4Q2+RPK/zNbD+bY8Un62t4v
	pJqgJMRA6Ptm/eGXQGB0W/6/y24XgaMM0PV1cnHfT/zDCyuoskFQdW2tuuGhR/7BavrLjCCsCbt2t
	yH0kUZJA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47970)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v97fV-000000005Mj-2ToV;
	Wed, 15 Oct 2025 21:00:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v97fT-000000002ZM-3Uh3;
	Wed, 15 Oct 2025 21:00:15 +0100
Date: Wed, 15 Oct 2025 21:00:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/11] ARM: dts: imx6: rename touch-thermal0 to
 touch-0-thermal
Message-ID: <aO_9Tw1s7VcHauNh@shell.armlinux.org.uk>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
 <20251015-imx6_dts_cleanup-v2-2-41a7281b98c6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-imx6_dts_cleanup-v2-2-41a7281b98c6@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 15, 2025 at 12:44:27PM -0400, Frank Li wrote:
> -		touch-thermal0 {
> +		touch0-thermal {
...
> -		touch-thermal1 {
> +		touch1-thermal {
...
> -		touch-thermal0 {
> +		touch-0-thermal {
...
> -		touch-thermal1 {
> +		touch-1-thermal {
...
> -		touch-thermal0 {
> +		touch-0-thermal {
...
> -		touch-thermal1 {
> +		touch-1-thermal {

Is it touch-N-thermal or touchN-thermal?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

