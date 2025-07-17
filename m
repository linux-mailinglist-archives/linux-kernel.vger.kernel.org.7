Return-Path: <linux-kernel+bounces-735044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D6B08A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F202A47764
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61495292B2E;
	Thu, 17 Jul 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m005fpLc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900D288CBE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746274; cv=none; b=ALtmDJjaAuWU35RelQVWz1POS9UGCCzvLUbG22UU7W8RsK2ErXGyQkBOAz3t2+PudCpFexrHduYz7NW1KWjPevQV+YSEvARaggxl7lJUo/HIon1obAqh9ZIfPqyM4jDcgucEIxuPtsPgkjLw1qKJ3Mq4mKyymosEz/ECNzqPmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746274; c=relaxed/simple;
	bh=C5c7x2+5FmrN92Gtg4+eigW/yNecgUmNAwgsD6/1sDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAqFlg/ep7l4hcnNo3pwXgxh5t60prToUyM6nMIsR2DCc196cfiGamsPGKyuH+lczEOxN2GVg7xb2B00i/PUUv59XzLMuxdjRpKZ0xzWV942sSBIZjHZrCOSbTrrDaG1N3yCNJVZrid5oQz7MvVjxnrtnT4nTe0gU4yKulMnWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m005fpLc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so125065766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752746270; x=1753351070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9sprcw+FL+M/3WWYR2avdQL7tHTil5o2+4ysJZAMdQ=;
        b=m005fpLcWnAvz0JjkEffvSN+/hoEF9efLY4NGGZa4QIIjkqdTs7VODtbCSKCjqMWW6
         lgaeZhLmotaL897hwGqK5UT2DtrafSo2tocknaatWcJMQFCVlc7C5qfmmpAyg81ttVQ/
         Pw63quyidt44Jmq0Lq9QFxuGMX2NmIgx55Ibz409wa74gN8YQpk84YrXGuwmrmxB/MDA
         K6fRpaFGszLJaShnOKD1573GuGQyMYHlY4bpSDNAI0mDwQmWYrFNc10BYLB356kjTxWS
         aq+dy7hCmn8ZsKY1cpCAD64TBmDST26CC05dpiNRYkBWfNra55254x4B/XJqVeqoS2ZV
         gXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752746270; x=1753351070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9sprcw+FL+M/3WWYR2avdQL7tHTil5o2+4ysJZAMdQ=;
        b=vbkLdyiHmTYWn0FhLZsH3r1K+czEZ29GwGuCiilw/nTa8wk2dUC/F11chnwWhPKCU+
         7BgBYAseeTmutd//B8Yuair4SHVbZXPRAn0WsrtXOoCSydIlq6jmFPSDCIHOMlH6Ug/W
         xroohpyqNg8UvF242UCP9TOtfLIy+ngcccCtcJi2BHbFqsChv9D0iJgDTE9/P0qW95NR
         nu/ZyN6CsWYH1Q1y5aoa6cbayaP0mMDrIih0aa50gXy8AMNZ0wZQqP7XQK9NBxoCxItO
         DdOXlWl4GhpgQSllQZCsIpE67XmTr73qx4jcbcDyh4CZe76hS4L09uvFJjX5BMAvB57G
         jA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVMar6PEGuiWOXjdPbQ4ww9GuPVpXL1nCTpeNVd+TYJkOUIAtBEC/0L1ZkGL6yiwEIl5hKXgSQr4GU9Ta4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOU98KHKPsj5sDAkwIOj5p8a9aDs9yz0BZeMEBV6PNhQVoH+w
	HIE1mTOmoMyECm4YfO8ywBnkm266pjCK1oID7449TgjEHmoTB6ePMAYN2Rht/y3AGk8=
X-Gm-Gg: ASbGncsADQFxcqeGs4Vpw2KyQ2kGsf/ElQDJcZCwvYTGTDtC6dsiLVVw0pmtB7xrHqG
	rl1su67hK51RuAcBUXUzMlzgtZihr/HoHQrMRFB+nn5ntmmMvHHj6hUGDitJIaeJbLUl/D8Jl2P
	WexhYxqGa5pJCi8nK0uP/QXS9G04P1XqIYHtUhvWt5/7po+yeMJgOYgN+n/P+WHcyn/xWkCuUgE
	68mrBlgLJkXgdpM9xL6b6UDnQ/3RqN1eKwTbIKw8/oKh2cd1nk8bEbLwp0c+rf5Jqr0F1cfJ64h
	jvOBdl8ZPUQOpw/G4MRog4tMzMzdMNAKdLYIM6yxzLPgE69Eizb56i2mtoZcJH10ZhKO1vQvJFe
	KR6MxdPvjraDb0Y1T9nA=
X-Google-Smtp-Source: AGHT+IF2F1sezQkalvkubfc1kydTpgVG5QuWYuPnjDm/LqI0gsy0QRNYJ/pRxI93KXsHSADKAggVsw==
X-Received: by 2002:a17:906:fd84:b0:ae3:63fd:c3af with SMTP id a640c23a62f3a-ae9cddf1080mr542887866b.16.1752746270277;
        Thu, 17 Jul 2025 02:57:50 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1337846666b.152.2025.07.17.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:57:49 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:57:47 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com,
	linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
Message-ID: <aHjJG2nrJJZvqxSu@linaro.org>
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-8-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152017.4070029-8-pankaj.patil@oss.qualcomm.com>

On 25-07-16 20:50:17, Pankaj Patil wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add support for Global clock controller for Glymur platform.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig      |   10 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-glymur.c | 8623 +++++++++++++++++++++++++++++++++
>  3 files changed, 8634 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-glymur.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 051301007aa6..1d9e8c6aeaed 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -645,6 +645,16 @@ config SAR_GPUCC_2130P
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config SC_GCC_GLYMUR

Wait, are we going back to this now?

X Elite had CLK_X1E80100_GCC, so maybe this should be CLK_GLYMUR_GCC
then.

