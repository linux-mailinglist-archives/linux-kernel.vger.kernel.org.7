Return-Path: <linux-kernel+bounces-794328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A732B3E00E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581E417EBD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2B30E82D;
	Mon,  1 Sep 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="MEkLwsit"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A32F5484;
	Mon,  1 Sep 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722288; cv=none; b=I2xmjTa+2yoO/olSl5AMUKTrkPqjvHrEuQdZ9693AY2hKYORSBPjhy1rDXbtKzyk0zPRk9A4R9S5B/fv8iZiD9y5GsDUa+UG2gt/jR4Cad8ZIPBixRjij3R9Z0pULcyftaNhoesSnQxgEDTLe3fHLJgpdkaHbU+s8m3wpSD+pvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722288; c=relaxed/simple;
	bh=u7YCD9fr0ldbGVoQNxWglQgoPoPk6uWhscfR4YAgSE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoYPJBMMLUSfkVR3a29ilEbsba7/pZVULyya2BqI1Z1qHlf3GGSgLL+gu83O5ZpWmFRAXL0tJZw5eupFzvpYGTJqTHIDINLvuobsXgMOikKTqRURprpBau0+4NKk0IxDPrTa6M8FFZt0MHcbbEmCxisoXiqJzaIqc4bAbiphnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=MEkLwsit; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756722278;
	bh=u7YCD9fr0ldbGVoQNxWglQgoPoPk6uWhscfR4YAgSE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MEkLwsitD11xl2cD3/PnCGFmrbkuPWWYg4uyCHww4j27rrZgEcRG4VFMr+pv2ypYA
	 VSRMs4cWKiZhYipgzNh+khUe1OTde+q8WVLOTwD+ZANLp53bn7pyUpt6JuWozpiCIo
	 vD1TmzSPwLH9QsS3oJAGZh5EDylfAZuEVDFYobhliLoTJ0jbMUSi9BG3LBaYOOhbLZ
	 sjPu1leMqMcNo5Y3NsHUMs2OoVDlB5SlhozYqdP0vxsT6wEtyDMON2R+sm8kqq3mlR
	 1HOEdvMUQbNwqq10W2tLiLDfCt62c/pWcRnocMNwU++Fzmqsov5d1zLYHnEmMYv/BE
	 WRqoXtBZ9waRQ==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50be:5a04:19eb:3ff6:89a2:9ef0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id A49DF27E468;
	Mon,  1 Sep 2025 10:24:38 +0000 (UTC)
Date: Mon, 1 Sep 2025 06:24:37 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Andrew
 Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <20250901062437.780cc71a.xunil@tahomasoft.com>
In-Reply-To: <20250901070008.68662-1-amadeus@jmu.edu.cn>
References: <20250830171409.592c1f63.xunil@tahomasoft.com>
	<20250901070008.68662-1-amadeus@jmu.edu.cn>
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

On Mon,  1 Sep 2025 15:00:08 +0800
Chukun Pan <amadeus@jmu.edu.cn> wrote:

> Hi,
> 
> > Please change phy-mode here to "rgmii". This change will yield an
> > ethernet speed throughput change of a factor of 100+.   
> 
> > Same as above: Please change phy-mode here to "rgmii". This change
> > will yield an ethernet speed throughput change of a factor of 100+.   
> 
> This doesn't make sense. When I first submitted it to coolsnowwolf/lede
> in 2022, I used "rgmii-id" as the phy-mode, and it worked:
> https://github.com/coolsnowwolf/lede/blob/master/target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3568-opc-h68k.dts#L24
> 
> Are you experiencing issues with both eth0 and eth1 or just one of them?
> Are you using the generic-rk3568 target for U-Boot?
> 

Hi Chukun, thanks for your response. 

At Andrew Lunn's suggestion, I'm doing
more granular and rigorous testing, now using iperf3. I'll post more details
of results here after I retest a couple of scenarios. 

However, I will report now that so far, I'm getting better (faster) and more
consistent results using iperf3.

~Erik

> I can't reproduce your problem in my test.
> 
> eth0/gmac1 (as lan):
> root@OpenWrt:~# iperf3 -c 192.168.1.100
> Connecting to host 192.168.1.100, port 5201
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  1.10 GBytes   942 Mbits/sec   29            sender
> [  5]   0.00-10.04  sec  1.10 GBytes   936 Mbits/sec
> receiver
> 
> root@OpenWrt:~# iperf3 -c 192.168.1.100 -R
> Connecting to host 192.168.1.100, port 5201
> Reverse mode, remote host 192.168.1.100 is sending
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.04  sec  1.10 GBytes   939 Mbits/sec    1            sender
> [  5]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec
> receiver
> 
> eth1/gmac0 (as wan):
> root@OpenWrt:~# iperf3 -c 192.168.0.2 -P 4
> Connecting to host 192.168.0.2, port 5201
> [ ID] Interval           Transfer     Bitrate         Retr
> [SUM]   0.00-10.00  sec  1.10 GBytes   945 Mbits/sec  1191
> sender [SUM]   0.00-10.05  sec  1.09 GBytes   935 Mbits/sec
>  receiver
> 
> root@OpenWrt:~# iperf3 -c 192.168.0.2 -R
> Connecting to host 192.168.0.2, port 5201
> Reverse mode, remote host 192.168.0.2 is sending
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.06  sec  1.10 GBytes   939 Mbits/sec    6            sender
> [  5]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec
> receiver
> 
> --
> 2.25.1
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


