Return-Path: <linux-kernel+bounces-859194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B2BECFC4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B6B19C61A9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC6B27B4FA;
	Sat, 18 Oct 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoGC6DwV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5827877D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791614; cv=none; b=gFWulZ8r5H+rOzsKJn0X9d0HA5BRkWvfZ/3120hlebNCONUA/Pl3ryZBQPxqLU/CTvcOzgfMPNiqcMHC3K/Jz/CvK7VCz2M8uFQl6pKyWAGGIKBHayV0FLM1970y5NE/nQwT3AosXrh1t7INIu1zXnW5f9EiQIYVZVrT6paRXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791614; c=relaxed/simple;
	bh=Gs8DaJlPwpW15lfb/H5juDARFqslXLd1KCuuHPo2maA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b41m0DxoGIuj1sKWfG0EKfrFvFXF5D4BUI/NKqns57n4bWxku3juilatksurmhOhOVuqF7Zudr0c7pkY/JaKaIMbGdPsFeyCB7HhbosnpvXRU4WuEX7oINkee0ly+8cV+1YhI9VrmZIMr1Rh9cQgh/F8V8PlYgWGPlDd000NMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoGC6DwV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so2189205f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791611; x=1761396411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwINcystRjoGvSWPk32ya6bCmX4nJsdTWZ/ZarypZXM=;
        b=EoGC6DwVZWKxPW+81u6Nh9XEqcpLNKmh0tIMXXaKKBXyyWWQQaocmPU3u52otrVIII
         GmkU5bW9xjSwqrLJI76JJUbecZ0eIgWF8N2iPEAHpdYNsht17hQa8VYQ0hiwcsz3CfyO
         dhcFQzxSN6yUYznEHHn11YwhkQNzr3kpSghv6oIb3Ux993jYc8JJGHySQYLktXRs3ODT
         WV4I2dv1Yjz4tF7lz3HPN1WtZ6MZ+ITmdPtXdX7FI/l7v6lktcLpHzBwDmSj8noY/xAf
         1PyC3A2YkWdcsWZkAoePxewG7NKoKg2brEc8jzIhzV1a0J1nxHoB4+MdaEvpDGHNLpH+
         1jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791611; x=1761396411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwINcystRjoGvSWPk32ya6bCmX4nJsdTWZ/ZarypZXM=;
        b=ASVDn7kgOndvPxcSnp2v0esNqz0Fk813lwbokbKK/UUJMX8U7eui7ik6Vnv28P/iuC
         h3oOn5mhHcmq4GTxsxoBHdcAGU1WpB7KAnpmbsQ5yJjeu8DYVch74JxSomuosCyIgHCL
         GNLEDkFz9xoGg6vylgm6I3xmfQhFqIlDofoWWzjqVJLxD3jEAQ8kTpUzePJsMOBrV1jU
         JZrVvIe3QYKd4MorJTX+aSFNGn+lGDrckxam1DImSpgqMKHoGCVswrBP6JiwHdhLxcMV
         ErXJinCcmdxILpm2WEGV1jdyqXcz9r3RTEkY/zeKFsJMfo87DKCJdsF5odWAnkeVqVp9
         ZRaw==
X-Forwarded-Encrypted: i=1; AJvYcCX+bBFRrm0axgSPeEIlp6Bqz0ZJm7k3yeqEI+NTaO3EOD+MHVQqZtfbNDVjlLfgWurdLNqVizKlEoiF0fU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/D609jGGp6JBH3WT0nFlZhOXlaBo+eVJwYQKXUIqrhL4531Ur
	NTgkkfkw2ok7V4W6qqjHo8Zp5TnUD4Y9BrLFO0qTbOti1JPp855wm9YW
X-Gm-Gg: ASbGnctDiU6w4WNoq6Awoc4M401V9k7v0w1STRVnnrusqpB0leRtMkwkDs7zk/mjEOG
	CuQtZdlYIw0SxdIKiWdMoUecqYgccoHQDB4nfZ428IwcaLWkJsmRwj5VNpQnvuu15sSrnK1K8pi
	AAXlb0J0jzJliJI+z0QzmBYbhTa7whn1p18P0JFhk2tfZqnMJBrps9fyF6MdR9ORFMBv9Xl60EK
	UASrwBSqArML5wCzAGt/ddjyVAv21C6HyLH2L/zbqFPcfxYu/aTdeh6JUk0PdbkE0AjORZtsBS2
	oSNl+U4g8nNmTJDbtaJDowxzm8aGFFsqdc6qX8fBlOR+3cgQuWBKNH5Zuv7j1T1wrB0v1SXtnp/
	yX+PnxyrrkvADfixl4f5ZUQBu5uszG8thN6QvrVC2lF3VR3M7E7fTt4pdf/GWF5xr6Xd2OU64cS
	yRCMUe7QouYXIyzsmbdI/R7UaacocI+gJN2XvOP28pbQ1k/1gqvQedNGzSSJs=
X-Google-Smtp-Source: AGHT+IF5RJYLSmA+oH07tnmvmsNyWmRsGcHhrDvL8wpjhULq8NfGc4GpnDL/KGS4NnlMtDmLKBwXmw==
X-Received: by 2002:a05:6000:4586:b0:425:6fb5:2add with SMTP id ffacd0b85a97d-426fb7bba0dmr5569895f8f.19.1760791611546;
        Sat, 18 Oct 2025 05:46:51 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:2acd:89a8:83d9:4be5? ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f71sm4781988f8f.37.2025.10.18.05.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 05:46:51 -0700 (PDT)
Message-ID: <a822d284-f2a2-40f8-987a-6e2f70a22fcf@gmail.com>
Date: Sat, 18 Oct 2025 14:46:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/bridge: add warning for bridges attached without
 being added
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
 <20251003-b4-drm-bridge-alloc-add-before-attach-v1-4-92fb40d27704@bootlin.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-4-92fb40d27704@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/10/2025 à 10:59, Luca Ceresoli a écrit :
> DRM bridges must be added before they are attached. Add a warning to catch
> violations.
> 
> The warning is based on the bridge not being part of any list, so it will
> trigger if the bridge is being attached without ever having been added.
> 
> It won't catch cases of bridges attached after having been added and then
> removed, because in that case the bridge will be in
> bridge_lingering_list. However such a case is both more demanding to detect
> and less likely to happen, so it can be left unchecked, at least for now.
> 
> Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Reviewed-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raphaël>


