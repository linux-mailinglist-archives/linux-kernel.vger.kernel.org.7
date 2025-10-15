Return-Path: <linux-kernel+bounces-855305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCBBE0D06
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 384614E42E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132162F7457;
	Wed, 15 Oct 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uokyPi/p"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BD2D6625;
	Wed, 15 Oct 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563632; cv=none; b=HjQ1Kqg7BnwUPFLGMkJ4YWsMHRzxH6fi8c4e5hZPsIoOBvNE6np6fcJ3fPdjvLJkC+z/6F+2xvdEgwLnkPf2kSLREcypxHotDwPDellkZGnymWfZ5q99NcVi36egQ4gycWLfHMPkcFKY/mIPnr3+7OgNZcA3nnJdjPLCndE4VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563632; c=relaxed/simple;
	bh=X/H1t5+R0D/4CKNJ6lqhJeQh+HFF3vdvHT/iEgn1t/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1hSIDbqtnYMKCgBbBUMKqsdGdPZ0+KYGLLgmUMtED1ZsW+ruZu8H4myN/rK3RbgeV8KqrZ37UT9xrpt5I1NIL7BpFT3SSiSeHfirXOs8gfvncZ3la2ElWF1xbxF/crQ/W8Nu9d9o/4SgF8+qKgqO0NiK0gmEU4bDl9CzvLM5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uokyPi/p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AGNZ6BnW7rDeS6xIFWWg/LtSXEvcJ9kKWvp8uKo+oqA=; b=uokyPi/pdGzl7esJWjMXLznKWD
	Xh8ANLAQ3j/YYuKO/QDwcdjjA5LzS2ydgQlncrmo6rg2+3/3owLO+lQT6+w2PKicRlxWRA08L5hB3
	flhkYz0tYu8t8pkzqzpbW+aY6ULd4DfeIKTtX/OmtTBtIlcqN4rd0LSS27wtWlDzwEdR0lkFOSgLD
	dJ2Gzg49La+Q730WbMPlUeFL1sXF5IME+Uu8UlPh5t4H5E+4EKNaYXg+SUkkej2VjHfzwMhpkgGpO
	IzoIpUEIoiBbL2FqIqB8+W9q/XpbQbbxdiPQrh3UGALGAmh7cHr6dZmyu2DUyejo2ap+XnQ0amvES
	66vxG8dQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47068)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v991M-000000005So-2bPW;
	Wed, 15 Oct 2025 22:26:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v991K-000000002cN-3eca;
	Wed, 15 Oct 2025 22:26:54 +0100
Date: Wed, 15 Oct 2025 22:26:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/11] ARM: dts: imx6: rename touch-thermal0 to
 touch-0-thermal
Message-ID: <aPARnldAwAYvT0YQ@shell.armlinux.org.uk>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
 <20251015-imx6_dts_cleanup-v2-2-41a7281b98c6@nxp.com>
 <aO_9Tw1s7VcHauNh@shell.armlinux.org.uk>
 <aPAFWuJCfvTcK8hz@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPAFWuJCfvTcK8hz@lizhi-Precision-Tower-5810>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 15, 2025 at 04:34:34PM -0400, Frank Li wrote:
> On Wed, Oct 15, 2025 at 09:00:15PM +0100, Russell King (Oracle) wrote:
> > On Wed, Oct 15, 2025 at 12:44:27PM -0400, Frank Li wrote:
> > > -		touch-thermal0 {
> > > +		touch0-thermal {
> > ...
> > > -		touch-thermal1 {
> > > +		touch1-thermal {
> > ...
> > > -		touch-thermal0 {
> > > +		touch-0-thermal {
> > ...
> > > -		touch-thermal1 {
> > > +		touch-1-thermal {
> > ...
> > > -		touch-thermal0 {
> > > +		touch-0-thermal {
> > ...
> > > -		touch-thermal1 {
> > > +		touch-1-thermal {
> >
> > Is it touch-N-thermal or touchN-thermal?
> 
> What's difference? I suppose both naming should be okay.

Surely you'd want to be consistent with the node naming? Otherwise
state in the commit message why you're using two different names
where the originals had the same name.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

