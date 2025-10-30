Return-Path: <linux-kernel+bounces-878280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5506C202B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFCFE4E8A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC835471E;
	Thu, 30 Oct 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS1gYyNu"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E782E2DDD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829784; cv=none; b=iLQ/Y1pj3Twb/wjCfYZd+hPVp4ZMBkQdFR5vbmoswJvjEtpu3Z0pGDqVHE+yvYx21VWDN2Y3WoIBpW2mibzDfTYvdGT4hl4pt/rcW+HMQp8UlPSVg/+Bk/hwHzBN9vJKGLXb4MTAHVQHRqdGpdjrIEFobdKFLybmwwDwwIPIYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829784; c=relaxed/simple;
	bh=plJUa7lFoTCGcsfOcpff0Mmv8iijDqb9eglwUue1zUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCLLpq0lchi2IO1hJkR84BD8Lmt4ElaBycRe/XtWHB9tD0jxZKGP6ins7McspYFeRnbrf9Ytp9e4Ali36B6gUsXN19ButSldP89UOx8wGVgH8MsoLn74gO3SeIFtAc8B/e9hj6GTHQ49dDGx9kzke5e8p4iuPOMlaUBo5F1nDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS1gYyNu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4270a3464bcso792522f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761829781; x=1762434581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FvrWgtYM1o1H3GtR4yRdUrofDJ3VZExWe4rEvgf3XU=;
        b=jS1gYyNu1dhNyr7TrmrQC3YxaNzV/ACi7UqJs4TAkzRp2qcSXwdL3beFw0rCsnyabg
         CYBGGDy0FcZzUkibSNNztC4vjV1b6khmSSoDGSg9dluNwu75J+NxNPFucRqCEZjGAEeB
         mGG+6rIoDj+3tUPkmxl3SGsnLePoX8Vd+9sNjrJ2Dm0AyxcMsgHXRKHSlHpB9c8T/ua1
         MrWXktOGoL/ynxarz6tjDnM3FQQ6XRIQV9l54Jb5hFDKBCm/30aGbmmPP6TKeW5qvyqm
         tC8qHGlECpgQJSOAnRv2xqKXFJtXqLofuhTk2tMJwCtL1D9FG0lq1rn2wyPkjv+sLC7Q
         GpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829781; x=1762434581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FvrWgtYM1o1H3GtR4yRdUrofDJ3VZExWe4rEvgf3XU=;
        b=SHLjjkwKnYGRMlz7L6dYHyz4EJQWpy5o/qmwba++vo1WssrEZD03YN32dU+c311+kq
         Kwoi/hfUdYyKMAE5W3tS2ZEgQROEhnOMTVjkfAfIbRf6sEjBRU6cXnjjezQGqia9T9ey
         DbOqoQNLXWeeyUZvqzFEysncbFUntCmm+Di4C6ASJRbC32pBfdm4WHs6iVuVwGd7YcH/
         s6e+4DdZfHHjyD2U7LF0UsSGmNqcNA2xss6ufY36o57iZGYoupSU0kxcAxCshc48I3D+
         raSBCon9m2/lqung9VwrTcGwK5H3vw76RzKh1ZoInfveN6fFuxnuLQdrPKxhGActhM5b
         DZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMbvpa3ZRQRndw3Xkrwx2FLdpGyChSRz2/kCY7R4c+dWNIlY8Gs/93NRY4qAgOU2Y2f/+T9Dfc/MPbLY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+AqRNE6otXAemv7d7kioF/RdbstV15DgxGoRUd9Rk7jRJ4WCl
	xrSReVm4xpo/A7XaNEZ9+WIhg62jqsihYSyni2xO+5aTJCIlcpST6rBF
X-Gm-Gg: ASbGncvOlOdjZRiud1N0wfO9ImGZHpK86h3eCAiOFR30+j3IBFuGbbaGqaKBt85CQWh
	cjqEOPRQt81h5Ie7yTIiso5X7Kl3Pwmkj5pPmrmZf0c23adYrBM3i4gK6xS3j4NkYTafplfAIZ/
	Gq4s2hrtE+hyaI6GYyVEnyFOVTttUVewOBJPe+41aSTMsJjgZkdNQ4/ZGgSW+evo64G/kZrFnFg
	19XqX5hT926MXmCXvIDR1gXEdpZ3urBThGV97gsbaKiJLI3N4NKqG4cBNTwUaLnEtP/ypA7KGVT
	IQ4W9u3cLfB/ovxod27j1EL5YBItvfn5IXCUgcVD5VkoZE5oPSmx1yO/ms/yhEOT/hU9EGEpA2N
	A+h2qOcXq6nMBwAN43im2rvBoMzGpa/8k9v/JCBXfN8ByePev1Y+I+uTY62nq9+UUXs+je7Nm5+
	BSJbzlDTv4peshlt04gT37QI6Dstz2M/h4Qy/2FPtwTaexh6ZeYTgpDfwi1/Cdgae9zMFqNxhYT
	KqYLio4xSNQvPL4D+aZqjuHcgDju7E3L3Fwl5JAEcLcl/U=
X-Google-Smtp-Source: AGHT+IHt0qZj97JBfhSm3bU2Z3jejv68CgVJx0PCPzKZeY8wdWN+4MGQv4dUD3at1v6e8mwpzpu6rQ==
X-Received: by 2002:a5d:5f96:0:b0:429:8d0a:8108 with SMTP id ffacd0b85a97d-429b4c8a0acmr2867282f8f.24.1761829780332;
        Thu, 30 Oct 2025 06:09:40 -0700 (PDT)
Received: from ?IPV6:2a02:8440:750a:26fd:c3f7:5627:ab4b:232f? (2a02-8440-750a-26fd-c3f7-5627-ab4b-232f.rev.sfr.net. [2a02:8440:750a:26fd:c3f7:5627:ab4b:232f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca979sm33491156f8f.14.2025.10.30.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:09:39 -0700 (PDT)
Message-ID: <287da4e3-0a28-42a3-8f59-7e41dde4d20c@gmail.com>
Date: Thu, 30 Oct 2025 14:09:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: stm32-mdma: initialize m2m_hw_period and ccr
 to fix warnings
To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20251030-mdma_warnings_fix-v1-1-987f67c75794@foss.st.com>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20251030-mdma_warnings_fix-v1-1-987f67c75794@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 13:26, Amelie Delaunay wrote:
> From: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> m2m_hw_period is initialized only when chan_config->m2m_hw is true. This
> triggers a warning:
> ‘m2m_hw_period’ may be used uninitialized [-Wmaybe-uninitialized]
> Although m2m_hw_period is only used when chan_config->m2m_hw is true and
> ignored otherwise, initialize it unconditionally to 0.
> 
> ccr is initialized by stm32_mdma_set_xfer_param() when the sg list is not
> empty. This triggers a warning:
> ‘ccr’ may be used uninitialized [-Wmaybe-uninitialized]
> Indeed, it could be used uninitialized if the sg list is empty. Initialize
> it to 0.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>   drivers/dma/stm32/stm32-mdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
> index 080c1c725216..b87d41b234df 100644
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -731,7 +731,7 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
>   	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
>   	struct scatterlist *sg;
>   	dma_addr_t src_addr, dst_addr;
> -	u32 m2m_hw_period, ccr, ctcr, ctbr;
> +	u32 m2m_hw_period = 0, ccr = 0, ctcr, ctbr;
>   	int i, ret = 0;
>   
>   	if (chan_config->m2m_hw)
> 
> ---
> base-commit: 398035178503bf662281bbffb4bebce1460a4bc5
> change-id: 20251030-mdma_warnings_fix-df4b3d1405ed
> 
> Best regards,

Hi Amélie,

Thank you for upstreaming this patch.
You can add my reviewed-by tag:

Reviewed-by: Clément Le Goffic <legoffic.clement@gmail.com>

Best regards,
Clément

