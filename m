Return-Path: <linux-kernel+bounces-793490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC407B3D43D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6688C1894E42
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E326F2B2;
	Sun, 31 Aug 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y9NpNLkI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2A26F298;
	Sun, 31 Aug 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756655612; cv=none; b=stg6mvsnFr80ULJ3LN55K5BQ6fA7eHlIzMO/7qGBRcNj/P25OfsMfXOXCjVHSGk7JaRRQ3KGwiM5mlVdkCFNcd3iydQLjG+257ERtcuvj4sTcGT3HJ1SYSRxj5fKw3h8CSfNUPn2731GT0hnIK/Pq1G9uPqsdZ8UxZuOFTW7MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756655612; c=relaxed/simple;
	bh=UMiAYj94TvsyXbEXZVYVLRN7AJoy6Ce6uqWaDHYWmPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4KFiRRao1t169UHLYGkDNF5EoUH1c8Z1MUCtKBi8LYoFIdIEPSZHgIk+0t5VwNDUOPI8r2bR0nv88mzGwvRXF0QZT5qIErXFbpjeY5XDbGlhwSOla8t/fgRMQB29RG/Te1iJCjzT9Sb/hqbkrGYv/z4DTfqo0PrcKcDmOKZKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y9NpNLkI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F52FsdXBtjVD7gBDMsOQu9CZMDE9RzgfYGXIBbgXfvw=; b=Y9NpNLkIpY/JJnerFJzA02cAzP
	fEpCaFismg3ukiozQIpKbzpCW1R9TD9vxapeQzD+6vO1pgLjjEnWSwtqvI2OkHw0xwCFOvV1HgGUI
	wSVzK0m/4FXrAtZiyw4WOF3pY9FJMzTlQAvb18Nj4BoFpFA8fSlLFbS865K2sbyDhZsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uskMp-006erF-6O; Sun, 31 Aug 2025 17:53:19 +0200
Date: Sun, 31 Aug 2025 17:53:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <6238650e-7a3c-4dd9-adad-cd2a5e925500@lunn.ch>
References: <021c2e76-cbde-4a2e-a165-a61223cdff93@lunn.ch>
 <5285B176-5178-4F6F-8FB6-B898AC0EC939@tahomasoft.com>
 <20250831104839.7b71f2fc.xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831104839.7b71f2fc.xunil@tahomasoft.com>

> > > Rockchip by default do bad things with RGMII delays.
> > > 
> > >  tx_delay:
> > >    description: Delay value for TXD timing.
> > >    $ref: /schemas/types.yaml#/definitions/uint32
> > >    minimum: 0
> > >    maximum: 0x7F
> > >    default: 0x30
> > > 
> > >  rx_delay:
> > >    description: Delay value for RXD timing.
> > >    $ref: /schemas/types.yaml#/definitions/uint32
> > >    minimum: 0
> > >    maximum: 0x7F
> > >    default: 0x10
> > > 
> > > Try setting both of these to 0. And then use 'rgmii-id'.
> > > 
> > >    Andrew  
> Setting both gmac0 and gmac1 to phy-mode=rgmii-id with tx/rx delay set to
> <0x0> yields about a 7x improvement from ~6 Mbs (with phy-mode=rgmii-id and
> tx/rx delay unset) to about 43 Mbps, which is still well below the ~950 Mbs
> with phy-mode=rgmii and tx/rx delay unset.

You need to split the problem into two. Rx delays and Tx delays. Use
something like iperf in UDP mode, to send a stream of UDP packets, or
receive a stream of UDP packets. TCP is bad for this sort of testing
because Rx and Tx are interconnected due to flow control and
retransmissions.

Try small values of rx_delay to see if you can improve the Rx
performance. Try small values to tx_delay, to see if you can improve
the Tx performance.

One problem we have with rx_delay and tx_delay is that they are
magic. We have no idea what they mean. The RGMII standard says there
should be a 2ns delay between data and clock. A poorly designed board
could mean the MAC/PHY pair needs to insert say 1.8ns or 2.2ns, not
2ns as defined by the RGMiI standard. Rockchip also seem to encourage
using rx_delay and tx_delay, so i would not be surprised to find
Rockchip boards are often poorly designed and don't follow the RGMII
standard.

rx_delay/tx_delay can probably insert 0.2ns of delay, but it probably
cannot insert -0.2ns of delay. So it could be, you cannot improve
it. If that is the case, we need to consider another solution.

   Andrew

