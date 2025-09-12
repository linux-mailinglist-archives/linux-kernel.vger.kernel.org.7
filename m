Return-Path: <linux-kernel+bounces-813796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA192B54ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852E53B919D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741B3009E8;
	Fri, 12 Sep 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mwmWvLNi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A92EB5BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675715; cv=none; b=kgVaz7veLzcUDyh3Ny6y1DF0wSRYuA53weOOwS2FJ4M+KTzAi8noK/E+JG9VAGUqH8rR2kCd+QAIeTdNOfOWC1G5ahNgwybvuQEZoS9TyRy/JjUf0403RiPXLyKPXomKe21d84c0aK1AL5PntWkuuEs68RDuYxs1k9VuklT/oX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675715; c=relaxed/simple;
	bh=e5L+tVWzscZr4jLHDRbnNlvC5wSer04cc3J4F0Re2yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFnPEUF7ZJ85g7XSLB4BPnxGNlM0SUKLKHxVO9+iolLOFIzptQe8zUpOz0b+d20nFHsGsfS8kVR8xLgK4DS8vomTjSmqRwqV5vmJdDN6OibWXUR/TlG17fC5m5C7VY/RK9/g+2hHdR+lQRf5YaXK6e07c3VkK/SpkWLXwIp0nZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mwmWvLNi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so1781588e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757675711; x=1758280511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y79xIpnC424FlOC64ZAsCAV+HYrgKwpFVZghrIQKO/0=;
        b=mwmWvLNiXML6exy4SRXlTldwGg6pMxhlr2TDF/7r2m8nA1D5kLFX2CLPLNmcVh60OI
         ucX3z7bq1gtD8cUHmFrkIL+HugwnqzuTCzdrZuGz3DY8pcQBtDIr9ICTVxIJvsiBzIOt
         KBmjJWxNuXi/c75xo5pqh2SEtQlmUlmNM2GzbbaIBSyBq9ttp5aZYOgu07pu5JzBsPwe
         4akkqM2jiK8Zxp7eROQ09tSc2SNqLn2lqdqn+UHrMoBEi/EvveY78lK33EascoHarWRQ
         zYi/35xeuoYzX2FTi98CcXYbwh+3TROE3VWxymt1ivvcfdP9E2pXN09smovEYPVrJt23
         Ossg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675711; x=1758280511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y79xIpnC424FlOC64ZAsCAV+HYrgKwpFVZghrIQKO/0=;
        b=ja9nu2zxlLJKNTwa1hPVURaTkzcOeCo4wCZBsdBbVQC1Sz5Rp01k7jMjB7so28r1Ve
         TK0oXfXgXP8Z3x2eycfC4PMW48/7RyRyuaZXVYhnpYdTw3RtA9Lo/jf+871CZffPvY5d
         CC9gqVpFLA1cQ62z6cGl3i4rrxR7NrALc/vKXKUc6qaTE/o88VRDS+xGzpGLK6ICm3Ev
         9GLHijQA+bJkc0M6+BxDmLr7KNIslVkhiwX44+M7867qCQUlI4W7s+34n3jQYBqdJVcN
         RgAds5NoGJ6+eHmPaT+Fl/FNnBCDiQ8UITFxMwDnGyrUr90MOTHX6gILTwv80+XCQcbu
         ga8w==
X-Forwarded-Encrypted: i=1; AJvYcCVkfyFISlJmtisXozJdqc62w8sySfYCPJg7D99DyDUt1VTZ5QNy8CXEqwHhFJFrrtDsX+4MDw8znKy8xcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UGG2e+kv3jSiLaH2TI6wjdYRrM7vJdegahV7tI7smfmHzz/B
	d4dU7OdL1/MB5fgKwNHoaB+6NjYxv6rJqJwOZHtgB1OePvZYDB7NMNbcRm1u9tVJM3o=
X-Gm-Gg: ASbGncuYwYgk5PdmRb6U54IWjuPUizFbzPNa8QjpyxBlllDuuz3bFm1ajVdjB52wa4y
	XEAu25/FzWp0AzXEWZn0wC3d6d7onDg3UGkXhsScFeqFz/9msTdofC3zPo5POVQ1/2DVDP62vcs
	LFVI+B/FlRhI02qQstX7u6kUCqKRE5O0GPLVAFZTbAFN4NSF7mE8Lld0AtdpE89iMcdCkR7Fx9Z
	vUUc8rs08xRcea7nEpU6cfcvXrlo6HfplJn3cDGMwhdoOM6XHcvqfvgXZk4dds+VDTf/BmY01hS
	8nuj6d35iaYXWx9EgqSHhCCaATbtaGK6DlHaEf4NXlFIk6Sqzm12dyJmzVQ+ybrHdaiQA6HXVq9
	mTjBHqJtHyK79EoFGBJHDg6ZLoAqOEPbrMCWWxzgX1tqV5/qiJqWe2l9dtzoU98udDFxuLUiliP
	ivDw==
X-Google-Smtp-Source: AGHT+IEX8lJuZL1YVpyfdl9mCWUkwiQ29IuRWpeUaJuKHQ4wANXuzKH9Gz1hogCk60GadYXtZCSGpA==
X-Received: by 2002:ac2:4e99:0:b0:55f:65f2:8740 with SMTP id 2adb3069b0e04-5704e34edd5mr666546e87.42.1757675711175;
        Fri, 12 Sep 2025 04:15:11 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460f138sm1063220e87.111.2025.09.12.04.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:15:10 -0700 (PDT)
Message-ID: <4daaaa7e-7a02-4e4c-be3e-c390d7f6e612@blackwall.org>
Date: Fri, 12 Sep 2025 14:15:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net 1/1] net/bonding: add 0 to the range of
 arp_missed_max
To: Pradyumn Rahar <pradyumn.rahar@oracle.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Cc: anand.a.khoje@oracle.com, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com, rajesh.sivaramasubramaniom@oracle.com
References: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 12:16, Pradyumn Rahar wrote:
> NetworkManager uses 0 to indicate that the option `arp_missed_max`
> is in unset state as this option is not compatible with 802.3AD,
> balance-tlb and balance-alb modes.
> 
> This causes kernel to report errors like this:
> 
> kernel: backend0: option arp_missed_max: invalid value (0)
> kernel: backend0: option arp_missed_max: allowed values 1 - 255
> NetworkManager[1766]: <error> [1757489103.9525] platform-linux: sysctl: failed to set 'bonding/arp_missed_max' to '0': (22) Invalid argument
> NetworkManager[1766]: <warn>  [1757489103.9525] device (backend0): failed to set bonding attribute 'arp_missed_max' to '0'
> 
> when NetworkManager tries to set this value to 0
> 
> Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
> ---
>   drivers/net/bonding/bond_options.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 3b6f815c55ff..243fde3caecd 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -230,7 +230,7 @@ static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
>   };
>   
>   static const struct bond_opt_value bond_missed_max_tbl[] = {
> -	{ "minval",	1,	BOND_VALFLAG_MIN},
> +	{ "minval",	0,	BOND_VALFLAG_MIN},
>   	{ "maxval",	255,	BOND_VALFLAG_MAX},
>   	{ "default",	2,	BOND_VALFLAG_DEFAULT},
>   	{ NULL,		-1,	0},

This sounds like a problem in NetworkManager, why not fix it?
The kernel code is correct and there are many other options which don't make sense in these
modes, we're not going to add new states to them just to accommodate broken user-space code.

The option's definition clearly states:
                .unsuppmodes = BIT(BOND_MODE_8023AD) | BIT(BOND_MODE_TLB) |
                                BIT(BOND_MODE_ALB)

Cheers,
  Nik

