Return-Path: <linux-kernel+bounces-793502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC704B3D45F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB017AD95C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4A267B89;
	Sun, 31 Aug 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="NZWuSW8I"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215722561C2;
	Sun, 31 Aug 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756657684; cv=none; b=qEo8Yq6jb34eNaS1JKZgbZ5VkEEPnV1xyQIdciGrMeqnQ5yawjIfBN52W3gzYZ/5ZTyifSbs7EmCcs57G96ILTVv+jwZCoxv3fpVEUsZ7arTJprNvJ9AhtRwhl7OYdQkgfbtp8lz7FNXYnQned38oM2ry30lMtq2TXF/IJg75ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756657684; c=relaxed/simple;
	bh=km3tbpN//K2LqZ5w/q8z3aHPduBCDAIAHCWXQX8jtQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL0tx9GfKmB+QpZ/+paWzwsI9f/FKR1j/+ozdsGbjwXRNQXWipryPe6RdmAyuAWWmkyyBkjxUD8Kg/HOKdoQzms6Tw5fF8Z39/qDU9sIKuUZYOzcwhsNdsN2eAqvKFlv+Zr0oesLhklIsheAFUYjWUvU/9D/SgcMtIWrvNdwwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=NZWuSW8I; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756657681;
	bh=km3tbpN//K2LqZ5w/q8z3aHPduBCDAIAHCWXQX8jtQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZWuSW8IZr6ng9kOG5DGqmjxkcdybPU1UzTTsUIAyaUM2Ty7JHpqg/9tbea/rZN8J
	 zeGyLf9PP9jQAF+JTnXsdus9o+l5xx9CYB4OI5vATSDgFCoSDs9HwwUXR9h2g/gsIR
	 JNdg5AeNHF2V6K3n5Ar/s73PBKYijWpE9TQIKOXNpCg8JT9Co6LnMmBq0bwkobBiqA
	 jpEbCyFls+s7IGN6RBf50ugjibhncSu/UiKWhg2l0uB175MiKKF9eeKLyG97B/jOLw
	 hpmPWNOnjmOCPHyYRsSP6kjzDctS3eiuouRltP/zxtZiWg7b8pUY7lbmOPw2zBKMXX
	 3ofup6Ir6O0pg==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50be:5a04:7b87:89ea:8410:bae3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id D8FBD27E468;
	Sun, 31 Aug 2025 16:28:00 +0000 (UTC)
Date: Sun, 31 Aug 2025 12:28:00 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <20250831122800.330c9ab3.xunil@tahomasoft.com>
In-Reply-To: <6238650e-7a3c-4dd9-adad-cd2a5e925500@lunn.ch>
References: <021c2e76-cbde-4a2e-a165-a61223cdff93@lunn.ch>
	<5285B176-5178-4F6F-8FB6-B898AC0EC939@tahomasoft.com>
	<20250831104839.7b71f2fc.xunil@tahomasoft.com>
	<6238650e-7a3c-4dd9-adad-cd2a5e925500@lunn.ch>
Organization: Tahoma Soft
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 17:53:19 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > > > Rockchip by default do bad things with RGMII delays.
> > > > 
> > > >  tx_delay:
> > > >    description: Delay value for TXD timing.
> > > >    $ref: /schemas/types.yaml#/definitions/uint32
> > > >    minimum: 0
> > > >    maximum: 0x7F
> > > >    default: 0x30
> > > > 
> > > >  rx_delay:
> > > >    description: Delay value for RXD timing.
> > > >    $ref: /schemas/types.yaml#/definitions/uint32
> > > >    minimum: 0
> > > >    maximum: 0x7F
> > > >    default: 0x10
> > > > 
> > > > Try setting both of these to 0. And then use 'rgmii-id'.
> > > > 
> > > >    Andrew    
> > Setting both gmac0 and gmac1 to phy-mode=rgmii-id with tx/rx delay set to
> > <0x0> yields about a 7x improvement from ~6 Mbs (with phy-mode=rgmii-id
> > and tx/rx delay unset) to about 43 Mbps, which is still well below the
> > ~950 Mbs with phy-mode=rgmii and tx/rx delay unset.  
> 
> You need to split the problem into two. Rx delays and Tx delays. Use
> something like iperf in UDP mode, to send a stream of UDP packets, or
> receive a stream of UDP packets. TCP is bad for this sort of testing
> because Rx and Tx are interconnected due to flow control and
> retransmissions.
> 
> Try small values of rx_delay to see if you can improve the Rx
> performance. Try small values to tx_delay, to see if you can improve
> the Tx performance.
> 
OK, thanks. 

Just so I am clear, the units are tenths of nanoseconds? So <0x02> is .2
nanoseconds?



> One problem we have with rx_delay and tx_delay is that they are
> magic. We have no idea what they mean. The RGMII standard says there
> should be a 2ns delay between data and clock. A poorly designed board
> could mean the MAC/PHY pair needs to insert say 1.8ns or 2.2ns, not
> 2ns as defined by the RGMiI standard. Rockchip also seem to encourage
> using rx_delay and tx_delay, so i would not be surprised to find
> Rockchip boards are often poorly designed and don't follow the RGMII
> standard.
> 
> rx_delay/tx_delay can probably insert 0.2ns of delay, but it probably
> cannot insert -0.2ns of delay. So it could be, you cannot improve
> it. If that is the case, we need to consider another solution.
> 
>    Andrew
> 


