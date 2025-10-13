Return-Path: <linux-kernel+bounces-850487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A098BD2F44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EE2189DEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553F26F2AD;
	Mon, 13 Oct 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgdARIrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6C253951
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358234; cv=none; b=EFzRJdxfk2RFFkcoeFwmRfc4DIEDNX2rxvuEhZieTJHt6mIVhxABvQ5+0JYfHpR1Qhvmluz8lsh8OJoI1XKJWzemFOk5yevdYdKDscnKt+PqaSL1IHOcWeZebPXhV2BC+0KYOTHJ71SHxNcyJrrm5fbGy//5NWhsQaeSuGGP3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358234; c=relaxed/simple;
	bh=k6YBXwW5JZbq1DfKwshEOGkm6VHl3nXhxTjFSP8zTaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzhuXfWT59e9yo2BFGXj3Uxy7jSLrn5OBbeSAuNbeEPGDxv8hl61jCcIotGhyjmEWIRRVPVKxLeTEgfA+ujrC59lB0LZI9tqyZn73cZor/No0bko+IJ55pw26gaJpBYlwgkB31gBDzW0ACyrsFokFF1nq/ki3NOPINY423Crj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgdARIrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD75CC4CEE7;
	Mon, 13 Oct 2025 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358234;
	bh=k6YBXwW5JZbq1DfKwshEOGkm6VHl3nXhxTjFSP8zTaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hgdARIrLYGG9IK0Lh3FRkYMA5Ov7p8yddVepvpDEo9ccRZF4BYVssNoKxNx0558sr
	 oDaWGk25Lp2aI16pDj8vfWwWAW0Tme3tIYJEsA3ZxPoi/4w9zNrz9jhYWyIdWj611b
	 +2VFEbcYs4mq1srH4shOR7wclRuFqFwG9lY5CXnGZKWGJsPm4P3eaFsox5JPdqEsoz
	 r6u89bCvNEvImb5lou4xVFdfBEiwsRo6qVOZDctAzJCB66fhz1Wri2LMnPr7xJQs+Z
	 bBmwQZ6LX2spniCfG5EJ3qAk5mZRwXps3mNJM9LGd8oMjMxfXqTT5wdH6mmhj6Uu4Y
	 EpG9P5FxDKFOA==
Message-ID: <f9274080-9a2f-4e10-ad5f-fa84d7615c15@kernel.org>
Date: Mon, 13 Oct 2025 13:23:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: layouts: fix nvmem_layout_bus_uevent
To: Wentao Guan <guanwentao@uniontech.com>, srini@kernel.org
Cc: miquel.raynal@bootlin.com, mwalle@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
 niecheng1@uniontech.com, WangYuli <wangyl5933@chinaunicom.cn>
References: <20251013115910.702784-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20251013115910.702784-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 12:59 PM, Wentao Guan wrote:
> correctly check the ENODEV return value.
> 
> Fixes: 810b790033cc ("nvmem: layouts: fix automatic module loading")

Missing CC Stable

--srini
> Co-developed-by: WangYuli <wangyl5933@chinaunicom.cn>
> Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  drivers/nvmem/layouts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
> index f381ce1e84bd..7ebe53249035 100644
> --- a/drivers/nvmem/layouts.c
> +++ b/drivers/nvmem/layouts.c
> @@ -51,7 +51,7 @@ static int nvmem_layout_bus_uevent(const struct device *dev,
>  	int ret;
>  
>  	ret = of_device_uevent_modalias(dev, env);
> -	if (ret != ENODEV)
> +	if (ret != -ENODEV)
>  		return ret;
>  
>  	return 0;


