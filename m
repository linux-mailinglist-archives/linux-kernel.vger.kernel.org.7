Return-Path: <linux-kernel+bounces-750655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC560B15F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403F218901FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16A2951BD;
	Wed, 30 Jul 2025 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROHC3poY"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765C25761
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874716; cv=none; b=jdXlozPqVRoKCNTB11Sd1O+p50GMj7kcRXbV3LtdvLrdS4S2nEcAUH1CeCO9UD5YspPUpn5kQPOBvNOJ2r07SDD7iQ/8DclU2qEMu3iJl4mO1zOGKt5KbTOmdf7l+HoAk+9OTw0ywHAoGt2w3cHlbUoX1j1ESYW+XU7Ityrglm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874716; c=relaxed/simple;
	bh=AaXLhjZNOuZ+t/gYKYez9Mw6H6FQBgt8vwLmFSdxjLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpwnVMe83zU2c7aI4bAErH04SCup7M3Xh8ldcmcuT8aG1Glmhe7i0jWT/P29gEdKbQCwhGeDXGmt/lvit/0r7gd56rUcx77DEAsf0zFj1HmOuERNpCiMbrHuVERRaLAObHcUQ/0lHDA6/tIlx7sMctiKI764ecQkFI2759r8XOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROHC3poY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7920354f9so1638235f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753874712; x=1754479512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qWnAgYumacwqqXMAwkn/jSAKd2nQaF00yjwz3QS2yE=;
        b=ROHC3poYJfjmj44dpKbRbnCQUqpYIxEOrPlr+qzOFIG4otBK5vEdp91b/r4SnhgMIm
         kgC7/vCPrQuUvqgPLs92gqlHhsrgh7y72DpeIE3RDLQ0KvdZpUDo1jQ8Ql4pQImqhnxO
         k4UBNKitvcWMK0sR5Evtrze66F/K4DP7dhUZptsCkL0QYgRo4Y6f88aKOZv4oCayp2HM
         pWfOy+vu6m0yh3u751Q8MTbaOHRsXYGkiXIkXcHAdRrsPkPU6BzcjKM3QCix8WgS6EuZ
         VzSIHzk8cxLU3QWBFVVP0FuGHWYWNiStk+nOptyj1KMG7n5DTZCA6lJgVoKaUgeaYE0s
         MBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753874712; x=1754479512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qWnAgYumacwqqXMAwkn/jSAKd2nQaF00yjwz3QS2yE=;
        b=Mu5AS0fWMRX7iDrcchq7BHWDjDIYVFwnYp//ZeDDxGvS0y5JnQGfKgkXRmr0zbuG21
         nTotc1uOIh86XrzjHdDq0Sv9wjNd7iho3EnwJo30GtGqPGpLnUCtJLvXNgD1jdW5ADu1
         WnwS6/HG2GwLmXZhAM8rCnJ4a8xOVKN0b9gmdcpdXGEabgGsfNG/f/D2AInSgux0hXPW
         rt0nY2SiXXf670TeioMVmWAaXVodrtBoHqjxbmy6I7Ca6PzfDnbgJl0zBd7ZR6dp8Xqv
         Z8YVumEcoeBX4P8cDbUXwjqkok482vN8ffl+j3OcXyqeq9LxoYYXUeE57MPguBpOucmw
         4VEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1IpIpznQ2Yp08CreO1j0IB1xQGxvapMyHAl2s4JkIXPiR4PSvD2OEHW7RXxltJdRZHnGQMJVg90Uu/4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgKOZgXjiR+7wCDlUtcmZFee0VNznLYbq8Sxg5KfZ3/6O1Ml5Q
	Sepjz1dPPM14AsaL7QTdMbVR3DhdY13p2SHDmysIi10AlEpPdTxFRNLpkAJ7Ztw5Mm4=
X-Gm-Gg: ASbGnctWcrxfFimtI4QYq2j/jg8F8ko+iq9o9bKcIWB2Ut38q05Spu6c2of7si6gtgF
	DajvMwvlMS9EEUgcvaOlC1A3puVWQbKqJ+trPXap8AUyq3bnBcIZW+fzUq06aUxT4wM72hbDz+1
	uCeccN3nL8k39uakW29OFK+9/LSuYTGDS+gsQEz2kOinEzrvOICY63/vctmI8PgV0kq/BJ9kgc6
	HK+0yyLwCHb/qiFYCEvdydWjrYuClo5WUsNd2R3JTIpn5InysTnOEIo/zM9fWu3Yd9XKOPwXDvp
	g8PTBypr1s2vBBIrfz9CPK+PXOdV41mYchQ0RS/kx2Z0ADVR1qcS3vume3HKfZifMIkAxMsoSpK
	rRZ3yYn/G5LeTlB7+1Gc2eNFDOdIjvQ==
X-Google-Smtp-Source: AGHT+IGQQWsegZemm4F84iyOeDGl9Tnw8iV4E/j71ZP2nFqvNfy276zfwZeEv0tcaCBJzz3K3Y6agg==
X-Received: by 2002:a05:6000:22c1:b0:3b7:8ddc:8773 with SMTP id ffacd0b85a97d-3b79503cb44mr2603491f8f.52.1753874712030;
        Wed, 30 Jul 2025 04:25:12 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78acd884dsm8352303f8f.33.2025.07.30.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:25:11 -0700 (PDT)
Date: Wed, 30 Jul 2025 14:25:09 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] clk: qcom: Add TCSR clock driver for Glymur
Message-ID: <aIoBFeo00PPZncCs@linaro.org>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-3-227cfe5c8ef4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-3-227cfe5c8ef4@oss.qualcomm.com>

On 25-07-29 11:12:37, Taniya Das wrote:
> Add a clock driver for the TCSR clock controller found on Glymur, which
> provides refclks for PCIE, USB, and UFS.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig         |   8 ++
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 266 insertions(+)
> 

[...]

> +
> +static struct clk_branch tcsr_edp_clkref_en = {
> +	.halt_reg = 0x1c,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x1c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "tcsr_edp_clkref_en",
> +			.ops = &clk_branch2_ops,

As discussed off-list, these clocks need to have the bi_tcxo as parent.

Otherwise, as far as the CCF is concerned these clocks will have rate 0,
which is obviously not the case.

Bringing this here since there is a disconnect between X Elite and
Glymur w.r.t this now.

