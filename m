Return-Path: <linux-kernel+bounces-793164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D4B3CF7B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 23:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94D8201C90
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B1246BA5;
	Sat, 30 Aug 2025 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="j/gdM1r0"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E113774D;
	Sat, 30 Aug 2025 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756588680; cv=none; b=cw4kV0i8mIrYVOEvlgrOrl7M4oZHLQNCrpShfMxCBRSEZIsmIHWDzEYeu+7zJLThwAVC32RclwrmCo2x0sO/dP8+q3LhJUuWIV5NOL4DMq8C/LYfEhLBLCTGxOZ0iUbDm54tsnPerWlpFyMHKLbr2wGYKzh4bl7ddiDZuD4X6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756588680; c=relaxed/simple;
	bh=w7AeKGA0VAqXrgbfJI3DCCFlApUNfQrCz+BcOLxH0gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fke747jywrMTln6HSIfxe3q3ZoefJHTAegzhaqf1supRALVmhJUzzzkRJa9rjBcy6CpXBc28+436YmkeWNQKpsmj4P2JqMea9OOY13+9BmM/jXKsZCl7tTCmPS1hTOYYaEwJ2T0LnlwDsmZZZqNiTsmhexQt7kot2Q/5RW0QS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=j/gdM1r0; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756588262;
	bh=w7AeKGA0VAqXrgbfJI3DCCFlApUNfQrCz+BcOLxH0gQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/gdM1r0EA03OeVXNxKphWjHsyz+IaNTwplDXwMdBbu2/hCGR7ujHbAnmvglk+ZbF
	 eL1BWrkxk32VoU+qvjm0ZgqiWBOqfOEPfwh1w2wiqV4Dn9YUknPgbzdjic32exC3Hu
	 czBkqWQqz0KAXuf8JyC/nshKq+/LkIHlUfvxfElIbJH4w97ojPdKJfMOFT/p/88yA1
	 QG0iV98PuoZ3+5y0pqkiuOKECjVwi0wSO6IotVtDtnuJJrdeRtkcvg5AiDHBU6dfKx
	 bq+bf/5jfL0Xm8FEzjOuPIiwtlaST8hj4rVXO/M3drNy1gRxdOMqaksEdJxEedoDGF
	 1v4W3aGcjXkDA==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50be:5a04:7b87:89ea:8410:bae3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id A7E9D27E467;
	Sat, 30 Aug 2025 21:11:02 +0000 (UTC)
Date: Sat, 30 Aug 2025 17:11:01 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: Add HINLINK H66K/H68K
Message-ID: <20250830171101.410bd954.xunil@tahomasoft.com>
In-Reply-To: <175603280227.3445205.12980590537074643035.b4-ty@sntech.de>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
	<175603280227.3445205.12980590537074643035.b4-ty@sntech.de>
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

On Sun, 24 Aug 2025 12:54:40 +0200
Heiko Stuebner <heiko@sntech.de> wrote:

> On Mon, 18 Aug 2025 18:00:05 +0800, Chukun Pan wrote:
> > The HINLINK H66K and H68K are development boards with the Rockchip
> > RK3568 SoC. These boards are all SoM plus expansion board structures.
> > 
> > Both boards can be booted from eMMC or SD-card using the
> > U-Boot 2025.07 generic-rk3568 target.
> > 
> > The SoM board has CPU, RAM, eMMC and RK809 PMIC.
> > There is no schematic for this part.
> > 
> > [...]  
> 
> Applied, thanks!

Hi, apologies in advance if I'm going against protocol, but I'm still really
new at the techniques for Linux patch development.

As you may recall, I've been working on a similar patch for the nearly
identical SeeedStudio LinkStar H68K (v1). I found this recent work from
Chukun earlier today; my work, in part, relied on an offshoot of Chukun's
work from circa 2022 and other inspirations from other rk3568 boards. 
(See
https://lore.kernel.org/linux-devicetree/20250723135008.1077970-1-amadeus@jmu.edu.cn/
for example.)

Chukun's work from 18 August 2025 is better and more complete than where my
code currently is, with one exception: the gmac0/1 phy-modes.

As I worked on my dts, I discovered that the 1Gb ethernet ports, using an
RTL8211, don't support rgmii-id mode; only rgmii.
(https://www.realtek.com/Product/Index?id=3976&cate_id=786). 

Changing this makes a huge difference in the ethernet throughput speed. With
rgmii-id mode specified, throughput is about 6.5 Mbs. Changing this to rgmii
mode increases throughput to about 960 Mbs. 

I tested this on Chukun's code by making that change, and essentially
backporting to my OpenWRT testing profile, using kernel 6.12 and U-Boot 25.04
(also backporting the Hinlink dts to U-Boot).

I saw this over 100x speed difference both with my tree and Chukun's. 

I'll make a note of this in Chukun's patch email for the dts shortly.

I'd like to help support further development of the HinLink/Linkstar patches,
and am happy to base whatever assistance I can provide off Chukun's work. 

Please advise on how I can best contribute.

Regards,

Erik

> 
> [1/4] dt-bindings: vendor-prefixes: Add HINLINK
>       commit: 7d11b8c260ea68ce8f420ad467b04b21ea34b011
> [2/4] dt-bindings: arm: rockchip: Add HINLINK H66K / H68K
>       commit: 4bef07b79ab1ef7d963eaa2c37948030e418d538
> [3/4] arm64: dts: rockchip: Add HINLINK H68K
>       commit: 86a504b82f8d0e34f99ab9607712e7942c919fa3
> [4/4] arm64: dts: rockchip: Add HINLINK H66K
>       commit: bb9ef44f05c9558d58e3c9da141e93af1aa11c1f
> 
> Best regards,


