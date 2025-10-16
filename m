Return-Path: <linux-kernel+bounces-856296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F33BE3C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB94C1A6793D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C633A037;
	Thu, 16 Oct 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUeUqTY3"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93E339B3B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622202; cv=none; b=W5dGT8h/FoMwReoyW+sie+PrDmRmoswfDuPhVliFwxgdsn7zcHT/nbOw/qvDHv6M63RqgcaVqVIz5Mo6oicFxY1tbdW+T0wgQ3pP6b5+G5mVecFIBFSCAsRgU4kV8E882ILYtMEM5qdhA/w1FHTJlWeZK7chltb6e51xck6hTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622202; c=relaxed/simple;
	bh=jDp9/QBfldp4RgNCkyVTB+rWmBU/cFzzvTwjjiiKsD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkI9XqwRB+Q7M7bjo1w46Ut9PDRkcCdGuPo9Oy9ZDKCkppkYtKekRo4nht7Dj+DDLB0qi92BHYUMt8QyU8LZPDkj2OeYaW35Iz+34AK9XtyC92PbvoHfGIpgdLdt3mUkWBg+phiLEJWxwFFcEawBzO7X2AI9qxQkG1fLybyk3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUeUqTY3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57bd7f0e2daso113303e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760622198; x=1761226998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPa1I3Sb/NK9EofjdAp6afiIJMKd5znl9EBjNEXePg8=;
        b=uUeUqTY3M0yVdJekd+rbaKKgBhgIQ/FbtquqJ8k83WXKo07FS3iLkIieZOXgBnYfwt
         FJMYk44HwpdnDZcaiNnUJR6TihDMKRKTWz+nATgR4WHyEsDR42H72kQN9strCDyAne7C
         RmWPKC1mdrIk+2JmHd/F1MiMjFcLPwSq96n2V6oDf+xGSruWsH+3AvqHulpfGalEaJv9
         rKqLAMxABbbzr34e4AVSEAw11rw2JQtJrsW7pQnVNZ4Q4tGuS295DUx0W/o8CeF2Dv6W
         0vPMJ9WCyN2WDeie6X7Oapr68a7iidDrUhrdLEjKbTGHwY4v36rel0G+cOVX0w4fJhFm
         1XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760622198; x=1761226998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VPa1I3Sb/NK9EofjdAp6afiIJMKd5znl9EBjNEXePg8=;
        b=CLnnFvN9Xhfd/0AVEe3Bw9dgkljwBna6du0DYs4jOaKOkPO9v3eQ/Grf0VmWv7RoIf
         bFfFj+tpdFVgZKeUuZqjMEK+GnmouE3oPSJYcxRNsXEodjcq1ZF8dLaycz3P1SrnHJfK
         COpH+9mg5uEWGpWlUtqT72ENv612l8lKwX358RBthvmqdVnVjYqjI9qTwY/2DX549b2j
         +weNVwqy3LYxDOqxryy9NzuL6AfiJ4/T2uG847FumuJYkiLx06n3/I1FLJW0l/1MDqtN
         mQletDzjDIddJlIgEbR35Xm6NAk8Lc2uxqWWqDvR/aLmKkJTLApTjPKHJUFqyf291Oh7
         a58Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGlb+VPy3QgkcCXXhz/x8eGYz4+HrOl5ShDDvPt5hU8MDsXg3c0p1L3XCUjA5YDshu4JGM6gDOAeXUbss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/VhAHLBox+8l0Q4M/0d1gawsu1T/h4d8wPQIYwy0c1A6thfG
	xe6Ow5m7y1MN+TT7YAjen750P4Sv5k5YUeJ102aOAGPIZAaGvc/fn73Ss2jDTuRzJb8=
X-Gm-Gg: ASbGncv9JY8AEeT1t8dMMJEmqFkwEd50eGO3yeATi1SVn4UhMBvXHXlnZYt648/5Fdf
	R97MuzzE5VI+iB5r/GhxdelCyNH31wxZAuzwIjHBA3AHF1tVOeUOtDbg/gZOJJERQEZMwbHL1xX
	255QkroxzeHGMyN6/bSPa8f5zB8ONuCb/wPdIjktQBkqynQ5/PLQjY3TaUVvZGHTzsPoPwnrKMK
	j+apV7LreGql3dJ4Mbwwexzt07Vr5UhKdgWC5Fx/6R9JU9cZHKWx3X7Rooc/oOmSAedoGKsBk9S
	WX3zMKRtivABExFPLaTCWCndC+ZicIXhf6Fu5DvUEefQiL8wFeR89nFErpvAuhnNIsgk/zImaqU
	9EhbVqydY7Wb9HWrRVSmibORhUfAWk/yuYZi8pfGgK9FfKXE9fFIWL7pfSWZ9oe8IimEhmtTf22
	ju3UQqNzGtmUPuQKcjtgLtU7oBh+lFVNn8/d9P3XJaoG1uTKwq2OUeThamVs8=
X-Google-Smtp-Source: AGHT+IEsA6UFmX5BTWpr/DOMf7GtkUjTzhwEWEKu2is2k952LHuOq+Rngn7xDEvuu7cdwPIaQxIv2g==
X-Received: by 2002:a05:6512:2347:b0:582:512:f4bd with SMTP id 2adb3069b0e04-591d877125amr3346e87.9.1760622198485;
        Thu, 16 Oct 2025 06:43:18 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fdfd8sm7032230e87.52.2025.10.16.06.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 06:43:18 -0700 (PDT)
Message-ID: <cf1311b4-4190-4557-a958-55699df495e8@linaro.org>
Date: Thu, 16 Oct 2025 16:43:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] media: qcom: camss: add support for SM6150 camss
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
 <20251016-sm6150-camss-v1-2-e7f64ac32370@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251016-sm6150-camss-v1-2-e7f64ac32370@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 13:22, Wenmeng Liu wrote:
> The camera subsystem for SM6150 which is based on Spectra 230.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

<snip>

>   
> +static const struct camss_subdev_resources csiphy_res_6150[] = {

For the names of resource arrays please use a valid SoC name like it's
been done for x1e80100, here it would be good to have sm6150 suffix.

> +	/* CSIPHY0 */
> +	{
> +		.regulators = { "vdd-csiphy-1p2", "vdd-csiphy-1p8" },
> +		.clock = { "csiphy0", "csiphy0_timer" },
> +		.clock_rate = { { 269333333, 384000000 },
> +				{ 269333333 } },
> +		.reg = { "csiphy0" },
> +		.interrupt = { "csiphy0" },
> +		.csiphy = {

You shall add .id field to all .csiphy structs.

> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845
> +		}
> +	},

In general the change looks good, after the fix please feel free
to add a tag from me:

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

