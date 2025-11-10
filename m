Return-Path: <linux-kernel+bounces-892237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA192C44AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26CC8345AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A91F12E9;
	Mon, 10 Nov 2025 00:52:26 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376117B425;
	Mon, 10 Nov 2025 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735946; cv=none; b=enXrdW3WI3zMgi2/msWFpr4ScmGrdEqzvDy2N9IBD/o0KkbsjQtvBjl3O5awGIBABL0F/I4377XTdrM+Mw+lGYcTcWGP/CxtSdHpUzRBPORM7Hh3seDSozjl/qpAI7umVTEuZrJNgjbKISceNoNBRYI0qIr/OA3Nf8rWG3QCXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735946; c=relaxed/simple;
	bh=zZRwUozaRUCWUZ0v/GY/IyfyzQ3GnP7Wcag8gu7TjFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib/jofpkvy2ko/PeER5F07dJzmrzLZvDL6UMTmRG4pzHoW/dvJGpCzlefryPg7T/SsbuFfaYRe7v8wmqW98TSKp6/m4CCAT5/voGRaMwKltkZWP7nOn9vfVF1HPOECn3I98EB9wFHrhNv8zGmeNG2wWye3TYfnSwqV7pooi2bYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D9DAC340FD9;
	Mon, 10 Nov 2025 00:52:23 +0000 (UTC)
Date: Mon, 10 Nov 2025 08:52:13 +0800
From: Yixun Lan <dlan@gentoo.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: dts: spacemit: add Gigabit Ethernet and PDMA
 to OrangePi R2S
Message-ID: <20251110005213-GYA1651402@gentoo.org>
References: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
 <20251109222858.3085488-4-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109222858.3085488-4-michael.opdenacker@rootcommit.com>

Hi Michael,

Please squash patch 2-4, see previous discussion here [1]
Once you've done this, you could put additional info inside cover letter

Link: https://lore.kernel.org/all/20251010-confider-raven-0ad7a810e5de@spud/ [1]

On 22:30 Sun 09 Nov     , michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> The OrangePi R2S board includes two RGMII ethernet ports
> supporting Gigabit Ethernet operation.
> 
> They have an external Motorcomm YT8531C PHY attached,
> the PHY uses GPIO for reset pin control. 
..
> Their description
> was reused from the DTS from the OrangePi RV2 board.
Suggest to drop this, useless and even make people confused.

> 
> Enable PDMA for the SpacemiT K1-based SoC.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> ---
> 
> tests on eth0
> -------------
> 
> root@orangepi-rv2-mainline:~# iperf3 -c 172.24.0.1
> Connecting to host 172.24.0.1, port 5201
> [ 5] local 172.24.0.2 port 51354 connected to 172.24.0.1 port 5201
> [ ID] Interval Transfer Bitrate Retr Cwnd
> [ 5] 0.00-1.00 sec 113 MBytes 947 Mbits/sec 0 395 KBytes
> [ 5] 1.00-2.00 sec 113 MBytes 945 Mbits/sec 0 395 KBytes
> [ 5] 2.00-3.00 sec 112 MBytes 936 Mbits/sec 0 395 KBytes
> [ 5] 3.00-4.00 sec 112 MBytes 942 Mbits/sec 0 395 KBytes
> [ 5] 4.00-5.00 sec 112 MBytes 941 Mbits/sec 0 395 KBytes
> [ 5] 5.00-6.00 sec 112 MBytes 940 Mbits/sec 0 409 KBytes
> [ 5] 6.00-7.00 sec 113 MBytes 948 Mbits/sec 0 409 KBytes
> [ 5] 7.00-8.00 sec 112 MBytes 940 Mbits/sec 0 409 KBytes
> [ 5] 8.00-9.00 sec 112 MBytes 941 Mbits/sec 0 414 KBytes
> [ 5] 9.00-10.03 sec 113 MBytes 919 Mbits/sec 0 414 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval Transfer Bitrate Retr
> [ 5] 0.00-10.03 sec 1.10 GBytes 940 Mbits/sec 0 sender
> [ 5] 0.00-10.04 sec 1.10 GBytes 939 Mbits/sec receiver
> 
> iperf Done.
..

-- 
Yixun Lan (dlan)

