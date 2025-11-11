Return-Path: <linux-kernel+bounces-894905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A7DC4C6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73AD64F7145
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8E29BDB0;
	Tue, 11 Nov 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BOh2+jq1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238A7261D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849851; cv=none; b=sRQbKNrbD3Es3dtidWvaS/5EpD7BWqu1YoHUJoM43BS8WuklJAl7333Go5TN6LbF58cQ3UKYXEghvLZjaQ5UOVumm186o2y1ITRaaiY7UeqbjsTsICypo+nhTv37YHNrmpXZRY0N2zNLE1bhW6YGN/6tM9lrM0Q9vDpagIC6t2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849851; c=relaxed/simple;
	bh=d6hbMkfnrqZV3eqYEQrTninyADS9Axe0rTNBA1LAauM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L12zvjfypm5EnfCK6rC/HsduD6u+t45XGBv8r4yekVNgyQoF74pW5/DhbjnFDYIIf0OFwg+csB7+XaPoyGCyJfu1JP87TG0kiYxt5y5c/B4/1/A8ir+/zRvYKQ2sGbwS/tmlSTJ8pmaCChGObtzdJeFoB+XXX0aUPzEYQ9ZwO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BOh2+jq1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762849840;
	bh=d6hbMkfnrqZV3eqYEQrTninyADS9Axe0rTNBA1LAauM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BOh2+jq15IgCBzgothKOYnuAhsJMpfnUeGLlpiXL1BdcQfwtEPYTbJ37791r5/Nlr
	 jWY+6AA/opWdHkVLEZ/RiDfayNNeB/R6QzozNq2IybvmDzmqLgmIjTpWwYfJ0LZoCM
	 ErHgT2j4JLN47umS3CFBCqXFeEJBnr0DGEIbmWeZvqr5RUxIdt/ZbjoDotyNF7lfOm
	 V620by1hc67TqdVdtVhj61JfdweoPLzJ1mgYDnxP8okD9ZYnDN5AlHx/AHecia75H0
	 QOYrPzU0UYwhHl+QSNJ06cLBca7j+Fx7DCjIVDHLBvPcKfsQMddJ8tCXfDSNnRdr39
	 gJM4zdOkWLK9g==
Received: from [192.168.1.90] (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6633017E00A6;
	Tue, 11 Nov 2025 09:30:40 +0100 (CET)
Message-ID: <2fb8b8cc-c393-4b2b-a501-667e7a8c4dd4@collabora.com>
Date: Tue, 11 Nov 2025 10:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Add HDMI 2.1 FRL support to
 phy-rockchip-samsung-hdptx
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
Content-Language: en-US
In-Reply-To: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/2/25 11:44 PM, Cristian Ciocaltea wrote:
> The Samsung HDMI/eDP Transmitter Combo PHY is capable of handling four
> HDMI 2.1 Fixed Rate Link (FRL) lanes, while each lane can operate at
> 3Gbps, 6Gbps, 8Gbps, 10Gbps or 12Gbps.
> 
> This patchset extends the HDMI PHY configuration API to manage the FRL
> mode and provides all the required HDMI driver changes to enable FRL in
> addition to the already supported TMDS mode.

Just a kind reminder if this fell through the cracks.

Thanks,
Cristian

