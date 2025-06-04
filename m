Return-Path: <linux-kernel+bounces-673167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39595ACDD90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4857A9138
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A228D8FB;
	Wed,  4 Jun 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydSWUQ/K"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38A252903
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039027; cv=none; b=SqdKutWewaYf7ajJzWtSBp4czV3jl44d8ia/96+lNSAgpfIWlKFDGfcXAW5ecU2lzHr/3N+S8eVhxZ2kSzg6kv/WOtNcUw4U0goKAfsAYB9hKRWsRNefabJKkRJth5MDIXfkemDGB2JnNJGwbm2vIjGq8ImWa3RrBg/KlNXi9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039027; c=relaxed/simple;
	bh=2qRhj+8PaD7KbS+ePJC+FIyfrnTKwmRG37BmkAjQGxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B53c74TZDzWAJbGsjiRSQuIoyuoYOXpzt+Cj5ctzQ3NLcJgs25G/jO1jIvDolLtTqX/FWtwGX9L850ar/C1zTawTNwtEO4TmMi4SQnxCRg9kvoHU7+OTDyg9YUmnYQEi7AZnAbGAC013MQDLs2NQLmKD1GrCauVrta+KucWsGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydSWUQ/K; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b1fb650bdf7so3523691a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749039025; x=1749643825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pWB1gx1mno0s7eFeJEUn/nD76wT6cl2IYjc+kN6JYkw=;
        b=ydSWUQ/KtPdi38pFMGjiNI8vQAz1YrJGjTRYBMNh3lVcpKha+82Tjs8ieW1iO4QAXG
         rPsWxto21L/+D8WL+0hSrZwIZ8DOA4Ye5cjiaiasXD4i2MdYwu3KES33K3zT28/j/WMF
         OvSASVFNITGd9SKvtrrqFbIqtlmQi1jkxIRGnEzq0LBs2CXIdPx4J2iPb2dKxGacN8ul
         leSWL/EuTtK5bp366e/pvE3r5vC3soT7R8s5SRBUngxxRSGLgDaEqi2IMWQDly4mr3Nm
         4LEkqu0KfyTcfWAGQX8Zf1zaqqUMqIMuXx954eL2+yiHMG1Q0HNU6dhY+tBWRn94K5FG
         BzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039025; x=1749643825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB1gx1mno0s7eFeJEUn/nD76wT6cl2IYjc+kN6JYkw=;
        b=AaLESfLrSN8TyUTcJA6lwvldItm1geC/+zQhDvuobivmdlDkCMd8H1dCI/685KPFfp
         2cVcWnVQhCM1BsgV2BfKkO4c1LiDkRCsqs7gJyFDdMQwGRZWlQWShy84c0CpRTebv+O8
         lMcQu/aJR/02Zuye1GwkLp5tBCEz7zol4SeWhA+aIcckcH5gZ4FARSsnqs/ojqzT1YV9
         GgxzfRssLtIxIHTa7WVC2j4Ahw5WUElHD7KjuhABfIefHSlQ0nQW+U1y/c73Z3Ve/0AA
         l8ni7EUJIJY5tvqr5EWy+i40pypuqOorAhgEcKluioy+5eBlYH5lY7UzLgANpqRoZVQy
         gExw==
X-Forwarded-Encrypted: i=1; AJvYcCW3sW6CEjSWj3HHmHkDuf0kjRjq7OWUvKe4wNAa28xU48QpyLh+MCWUhHcQaaqKF7y7nBX2WrfW2BdB9Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuT/DrwLYXjjV6wxygdCyfCWXNYOIKaqmMlt4JebD+HeU40Oqf
	bmB7p3M4uOT9PwafI7oapBEtg9Nm4G7Q2Wv5O/37Ejtah8Tq4bb+AYIFe8m2+lbpQA==
X-Gm-Gg: ASbGncvUtDVf/UuPWtEMeOnoGiozjFVwFy7GDYuF3757UGnfQSsesPtWkhTQWFnUx+S
	mxMSySN9mCEo3uUF1KKd0g7oR0E9x0evrCRuJXNbTWI4OGTo2fw3voX3VWHQz0EcXqTef9nLH1H
	Ix9uTzN81Gn0iAYgfyKR5b00pUhi4cA8zLg4Csxid1wc1cDDuEoS4oDxHK80RdEm4E3CuJaQl0E
	uUXQMG+Gm/a+GzxWji2ihaZaMvErVsnzVI20AU8naOk+6rAKaBeh2l2h2VBGHIn7T6DZOX2biRm
	CWvueBxI6jdWW7/A9La3rWh7lWmP3s7tePCDNxRH5Iv99uPsThYKtIuwhW1G2g==
X-Google-Smtp-Source: AGHT+IG57XGK+U+lVqYG/JIjQeIC5Z3vtLCeEP/XJOi9Tpj75vDY8Loup1Fc3OWKbmi7pysssKLxpw==
X-Received: by 2002:a17:90b:4a10:b0:312:26d9:d5a7 with SMTP id 98e67ed59e1d1-3130cd2b40emr3886359a91.20.1749039025081;
        Wed, 04 Jun 2025 05:10:25 -0700 (PDT)
Received: from thinkpad ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3c0db6sm9661015a91.34.2025.06.04.05.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:10:24 -0700 (PDT)
Date: Wed, 4 Jun 2025 17:40:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] mailmap: Add a new entry for Manivannan Sadhasivam
Message-ID: <ejg4ds3igm3njxfhtjx7uoh557tzh3tw2ig3srixlvlyaj5man@rs3gx46dahmk>
References: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>
 <20250604120833.32791-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604120833.32791-3-manivannan.sadhasivam@linaro.org>

On Wed, Jun 04, 2025 at 05:38:31PM +0530, Manivannan Sadhasivam wrote:
> Map my Linaro e-mail address is going to bounce soon. So remap it to my

Err... s/Map my/My

- Mani

> kernel.org alias.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a885e2eefc69..1e87b388f41b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -458,6 +458,7 @@ Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
>  Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
>  Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
>  Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
> +Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
>  Manoj Basapathi <quic_manojbm@quicinc.com> <manojbm@codeaurora.org>
>  Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
>  Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

