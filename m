Return-Path: <linux-kernel+bounces-846837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB30BC92D5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB0504EAD38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154022E6CB3;
	Thu,  9 Oct 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XNZ807W2"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE632C326E;
	Thu,  9 Oct 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015097; cv=none; b=V3CA0ermajTd6aasljjumqoUA+FJf9rJrDOpLgcfTI98UbdqYsi9yq7wE2G1vu2NsKO7ZfG2xwxz/x1ldAXtHRCFhR028tP2rSue5Lqj3JqFjn4+EMwnegtRgwZ/7gGyaWrd1XKlFiPK48EkaX7WFnPYuUCZGIwf1ScX6q86Nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015097; c=relaxed/simple;
	bh=wvqq7tR7f83Tv+zqnX7Q690qQC13UtUOPDDpjH8yirU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th8fCPQu4Za8F4QUt49sxxlAKfORQ3gl/kL486hWKsQpDslO3mFwTyWYoUqtXEVRpiUzbiipNbIx2R3itletTw5e8cX0kQybY20NSAvK6e6iaqvtsc73PQvmgKY3ftY6REV5ahCNVMLjWPPwan25Q0UYr9Djwy1hdEww3fK3Oo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XNZ807W2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cvmxYvqaBcP5LiWtUkLVMauMKmxLzw2JcaPTHvugUts=; b=XNZ807W26VyEL+XLmIZBp1oN2f
	SCM0sM4795CNZhlYNS4pn8NPVB4JME68APBYg0Z0fum+60AkTRvlRrNB67yRUq1u3xRTKorkJrtBY
	TqDeXE3WYGsHTvRruTKRznhe70yTIGUFXbPq9mWw22FR/47Hycf56RgJTRRWPS5DxfRg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v6qJn-00AWt2-22; Thu, 09 Oct 2025 15:04:27 +0200
Date: Thu, 9 Oct 2025 15:04:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexey Charkov <alchark@gmail.com>
Cc: jjm2473 <jjm2473@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, didi.debian@cknow.org, jbx6244@gmail.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <d4628648-8f21-4b57-8ca9-f08d89f5e399@lunn.ch>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
 <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
 <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>
 <a0501abe-d86d-4f3a-9d55-c842bfafc190@lunn.ch>
 <CABjd4YyqL1YouMt97MA=CLWJmcFMMr+=xpOKOd6YtAC6jQAO=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABjd4YyqL1YouMt97MA=CLWJmcFMMr+=xpOKOd6YtAC6jQAO=Q@mail.gmail.com>

> FWIW, the TRM for Rockchip RK3576 specifies that the values in
> tx|rx-delay control the number of delay elements in the internal
> delayline on the transmit and receive clocks, respectively (up to 200
> each).

200 is interesting:

  tx_delay:
    description: Delay value for TXD timing.
    $ref: /schemas/types.yaml#/definitions/uint32
    minimum: 0
    maximum: 0x7F


200 != 0x7f

But i don't think the driver does any validation, so its not too
important.

    Andrew

