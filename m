Return-Path: <linux-kernel+bounces-791886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9275CB3BD54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4730D1BA6407
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A8532038E;
	Fri, 29 Aug 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDJCUt00"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8EC314B86
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477078; cv=none; b=nLSS+7lyeDGsvW3Qs63MjGZRk3hA2ofPRSOnwnGBdgP1ByCkbJuirPZJbM70SNZPyAwepqZCzZ1bIgd+5cn7ZL29AdWmxpiFHq2Ve9/51OC8BSVWHWXMrwodCsx83p8ACH/BeGtVeS9mGeuNtAILJaolt/7MxOylnEQglBfJypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477078; c=relaxed/simple;
	bh=jL7e0H9l7oWIUOWsTHCRgC8GOaaqt4s2mWR0NDrqIeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOeKihsByrKIbTj8Ol/8uMaInpux+sQQF+unxR9FO92Bo8M3WGrbiurtERMlcVXpTYMCpuuCOL6/kOLY5mdijj8K2HWMUoexRPI3Z9RkVvuHkVnvP63JenM1uxZInQg0hy19zf6wIBU5iRBqoQkcjXXAAbxBtD+MZn43lBr5g7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDJCUt00; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3cbb3ff70a0so1331481f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756477074; x=1757081874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UKM7Hh31pGB257PcQYyxWg4WwmJZnesfP8m107J2rg=;
        b=iDJCUt00Zgh3BuW/C42aYbn9tZ4lJSJ2nY6VAi7mWY+oFOi5a4+M2Lf837+yE5D5z0
         66C03abwX5uTrdIZRNBHe/F6CYtVuMvSMfRCDB2HG9zV6cV5YvB5B7wLHtGlkldXCUCr
         IyUwMTVAt4WXRWWcXaE2gF0Ayrc15o+i7axIiTffN3mB4uKfcm4AO8b5gCcgZmnghbzD
         E4YEpE+Ky3UxWUNuyagwInHqT5gOQH9Y9QdRn8S63yWpDAomzXL9Lfzct2Vx61HkW/SI
         rgyF7qZvmVGPdq3IlOUE576bTG86TL8e1XlxYFebW07vLFU+H9ABdw+fMjh2F28XQe7u
         bkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756477075; x=1757081875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UKM7Hh31pGB257PcQYyxWg4WwmJZnesfP8m107J2rg=;
        b=tWRCsTO7G6N93UZcQ2MPQFUZaFQgOX6AO7x03mOlwSSSEeaDgy/mrohEbOI8WfzmLj
         8rg4+CGfKaxNpgksd5UUTTKDxcyfJ/cRXqql2KJq2nWeCY/+Zb979cxsZPHisPgK3Zm8
         VUPK5Uvp+9kbb3pL4eQz6vkZAwboRwcljtIUcyz7gpvO4jyJksryjChlWb5Kh+6r70n3
         gftoqeEb9oBm+/VCOXvICtXlrMh3+yspRFYaDfCiBm0UO2nt7ZANOEWcFPNJfDZdFtFZ
         scl5RXr93DJTjKzV0cLbGj0zYiGwcAjb5A+OAh0uQsnwStFapggpyvr284TFdMjTlqIR
         bv3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/YvzWHzOCdS1D7a3G4PvuBZZ64us2mxHhjTo/up+HJsYOCjsMzlUfwhBsDqwUXWRQ0H01h8+srG2gQ/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytbYQehARGAbydL1ZNMCBGieAX45Ys3ebsGYiztbLLPa9DcjCz
	eW0MtCG6sKWOUWNZ7m53RbfwcHIwCG2R7UfQ7vTxp1DTXofVfHfXksgzSpTiLLStMog=
X-Gm-Gg: ASbGncvWNSfszSHldEtSYZ66lWCf+YySesQt25bMRz/WL9KGEHTvJ9nLMZj8DMzEZcn
	IzViywN43RGkhUgZy03h3xOYoWnYcFKXMKbJ9Eulhc2CSwULTBEbqUrbDiE0PiBHlopicbZMdyb
	lJZMGhVYKo28ZIlDlnq/TPFaP273HtgzjLci6yRP8J9MAiYxC/M7f53KDzhE2WHofSH++yAA+JQ
	XvIUMc5RignyZb3tFo8kj+EBLEGVvcj7gYq0xAMDBT4PDfx2V7TkTnUREeW1f8hqErrp0OYkp4a
	AzLEUfWTFJItO2bxia/x8EdtCqpyp6mXfiWsvZlAKU2Amyf+vkN4RW75wYvwVbiyiAoCI12yFIk
	AhBe2WGTzcTQrs2X+wL+Pi6aJCKo=
X-Google-Smtp-Source: AGHT+IGRlrJL/hMg2fvOfjrwxfuiOfMWO4VNgYqpwRsWHXMQIhRsVFY7GAkc+zMu0TB3KTQQDEX5sw==
X-Received: by 2002:a05:6000:288e:b0:3b7:895c:1562 with SMTP id ffacd0b85a97d-3c5da83c60dmr22817307f8f.11.1756477074430;
        Fri, 29 Aug 2025 07:17:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b74950639sm94583545e9.17.2025.08.29.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:17:53 -0700 (PDT)
Date: Fri, 29 Aug 2025 17:17:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: stable@vger.kernel.org
Cc: djakov@kernel.org, naresh.kamboju@linaro.org, lkft@linaro.org,
	nathan@kernel.org, kees@kernel.org, konradybcio@kernel.org,
	quic_okukatla@quicinc.com, quic_rlaggysh@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: icc-rpm: Set the count member before
 accessing the flex array
Message-ID: <aLG2jl7bwYVEoumO@stanley.mountain>
References: <20241203223334.233404-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203223334.233404-1-djakov@kernel.org>

Hi Greg,

Could you pick up this commit for 6.12 and 6.6:

00a973e093e9 ("interconnect: qcom: icc-rpm: Set the count member before accessing the flex array")

It just silences a UBSan warning so it doesn't affect regular users, but
it helps in testing to silence those warnings.  It is a clean cherry-pick.

regards,
dan carpenter


On Wed, Dec 04, 2024 at 12:33:34AM +0200, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
> 
> The following UBSAN error is reported during boot on the db410c board on
> a clang-19 build:
> 
> Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
> ...
> pc : qnoc_probe+0x5f8/0x5fc
> ...
> 
> The cause of the error is that the counter member was not set before
> accessing the annotated flexible array member, but after that. Fix this
> by initializing it earlier.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/r/CA+G9fYs+2mBz1y2dAzxkj9-oiBJ2Acm1Sf1h2YQ3VmBqj_VX2g@mail.gmail.com
> Fixes: dd4904f3b924 ("interconnect: qcom: Annotate struct icc_onecell_data with __counted_by")
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index a8ed435f696c..ea1042d38128 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -503,6 +503,7 @@ int qnoc_probe(struct platform_device *pdev)
>  			    GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> +	data->num_nodes = num_nodes;
>  
>  	qp->num_intf_clks = cd_num;
>  	for (i = 0; i < cd_num; i++)
> @@ -597,7 +598,6 @@ int qnoc_probe(struct platform_device *pdev)
>  
>  		data->nodes[i] = node;
>  	}
> -	data->num_nodes = num_nodes;
>  
>  	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
>  

