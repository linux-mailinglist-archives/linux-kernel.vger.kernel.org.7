Return-Path: <linux-kernel+bounces-798652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95885B420C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B189016DB44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE81A4F12;
	Wed,  3 Sep 2025 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qu4mmDCD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71C8F6F;
	Wed,  3 Sep 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905346; cv=none; b=fJnOdMC2WYR84kNQsRgDvah3RJcc+b+HubuiV8C4tNNn41TTZsKaBUd0Copx+i0oZ9k07K66XIkrmulc5rL50UNWD9JggqQuojGgo+Mr0hewUVEjelf89nNsVQf4e8mHn05FEvCBTJuANJjMd3/QqUusO/trpsUm9B6WKoURJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905346; c=relaxed/simple;
	bh=65Cy4eE/Dbap4x4XSMPP5MYg4UIWlMJAYB2KAsuUEOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhAC7raepKtbgnJ4k6DB+pSUEhkli+OG5oFfaYeWjhOfHWduOFAicYDFKkYlbW7kDpDQ9Rn6s/+2ronlF0+2n3fUlbjjsHcEn9YuF1ApTlaTjW4/X32+Mzi6cb/u8MbJWeRYdVCnAIVXCp6wbaPD7RrtcFzwQnv6ZBgj9HNFWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qu4mmDCD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756904745;
	bh=65Cy4eE/Dbap4x4XSMPP5MYg4UIWlMJAYB2KAsuUEOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qu4mmDCDhFLO5+ELxckT0gE8rs6NIalQ//oyW76Y1Q12bEdUkmyxERmGtl3gd/5Cb
	 ACWOJ8mwcL5RwYv04uIf4VWQx4M8gzjuUMg2xAu7cwent5z5hZHNyCcZJZjdXGZ6B5
	 Glf7D3k2pwuXHnEPWq/avscUiPDC0ExrnhAsli3I/xv52eXqiBTCOJDcDdcT8JUmNX
	 rWu6x3+kIPa0tfE1yG+4hAlLFHNeUQ5c/e8Eabcqnob+JSr+6zO9yVsUOEYVBX5vNy
	 kAb06ow8nOgQFQ+kk2uAPy7wTkRZ7w+YmGZkVGNYPVt+JQRnZ+J5yXIcFCtB3jsrsc
	 0Xv/mjVBORwdw==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FE5517E0FFA;
	Wed,  3 Sep 2025 15:05:44 +0200 (CEST)
Message-ID: <218de818-2063-432d-b61b-4537ea702cd6@collabora.com>
Date: Wed, 3 Sep 2025 16:05:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] drm/rockchip: inno-hdmi: Convert to drm bridge
To: Heiko Stuebner <heiko@sntech.de>, dmitry.baryshkov@oss.qualcomm.com,
 Andy Yan <andyshrk@163.com>
Cc: mripard@kernel.org, neil.armstrong@linaro.org, andrzej.hajda@intel.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, knaerzche@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>
References: <20250903110825.776807-1-andyshrk@163.com>
 <20250903110825.776807-2-andyshrk@163.com> <5255838.1BCLMh4Saa@phil>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <5255838.1BCLMh4Saa@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Heiko,

On 9/3/25 2:59 PM, Heiko Stuebner wrote:
> Hi Andy,
> 
> Am Mittwoch, 3. September 2025, 13:07:38 Mitteleuropäische Sommerzeit schrieb Andy Yan:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> Convert it to drm bridge driver, it will be convenient for us to
>> migrate the connector part to the display driver later.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> more like a general remark, this essentially conflicts with the
> big hiword-cleanup [0] that was merged today, as the inno-hdmi driver
> "lost" its separate HIWORD_UPDATE macro in favor a nicer generic one.
> 
> I'm not sure what the best way to proceed is, apart from waiting for
> 6.18-rc1.

This is actually what I also intended to ask you, as I'm in the process of
rebasing the HDMI CEC series on top of next-20250903.

Would it be possible to have an immutable branch of bitmap-for-next and get
it merged to drm-misc-next?

Regards,
Cristian

