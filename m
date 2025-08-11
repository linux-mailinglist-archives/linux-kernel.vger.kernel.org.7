Return-Path: <linux-kernel+bounces-761965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B93B20081
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9466F17A8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6C42D9EE7;
	Mon, 11 Aug 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/8nidds"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89D20B812
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898011; cv=none; b=BaCHE8g22jynlISrtruHPyiAI9JKtAQAQdGrU8XuG9lwcQDsW11N8oe0FVD85qUH6H41HxroZ4WbRqAFoWBpSzg5HUE2/9uL1y/D5FPM1cYgQQFnnVTF+S3J4R3tbf3ldt2hpsybxZUEI9tz6RV6KPOwVWUwpyAzIKJABKuJczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898011; c=relaxed/simple;
	bh=WaxqPwe60aGUkhXsZ36hb/BaEfdKvftcdVEBEnneZvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc5ygjV+kyDDX2cbiUVDYwYKexwRPkuojMgdG6+QebWzxReyMnpEdvqVvcCk9vE6AEqT0J5IcDTepbbBeHrcjvMAT8vYRudO8oUFiXV2Gg7Yq6F7JToyadyWRHP9xqtwXwLQSZE7L1ArQpEqIlh6yE2XjDTX0I7+P+y4XIEPYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/8nidds; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459e7ea3ebeso14577115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754898008; x=1755502808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POALZcOL5uP4hmBAgsW0NLC3bq36nPwjL/gPbRn+/O8=;
        b=n/8niddsEqxjRK+EuEcwA4m1Kh1sxcGL6NLj0rmLanaJTpojCV4ycONQpR4x49mWPN
         7vdDpbJZJgcNjatAH6ZxCpNgqMYTP1XIt+YuQ/ZmqiejOUkOV3dT+VNMOJTGeDiTJe1k
         TQEbGW4t1otUFMYXSJGrkCCApw1JgndqA/iOw4mz0/qBM/Q1ovVO7T8lyeBFNcPrmw3d
         dRJhn5wDx46V+3PpG4CA0Z4bv22vXzxO69bSA/tegMrohqFznXtRxSoqIIXe/ZES2MCS
         dO1Bl+Bp4qe2UWEKhXbCfuh6dSrGoe5ag4u0zlQCGXsX++tJL0OMP0V3IIXdts8ool5C
         nLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898008; x=1755502808;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=POALZcOL5uP4hmBAgsW0NLC3bq36nPwjL/gPbRn+/O8=;
        b=IMZRyMFF+GSMq8cDLfgdEo8q2+tCOTS7guStOJkis/m2indazaiJCQyqkJcWuyr28y
         Qdp5vfzwWMoXBtHhsWAZNAACjOlbuvP/dpf6kQ81bM3y+Yg0f1j1oP6UyD9SnwiDM/+Y
         qgpSy6IeZLJd4iK0SkILTDIrqVLlELvcRLv5dx+Ag9ngwUj8iB140rPhEbKtTEZDm8AP
         OIe+5c75kaayWyWk/dJ7V8UHiWEJR6WFTwMQAOd9wJ4SrUZQAuofrr+krscazH+dDY+5
         02akeTxAiFT87gPfRwxdBrNI5v/joPlt/LZuUE7e6YOjP5R2JzqUXlobpInntmmSqYzL
         sZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWk/wdX7QPLycUQbHMgJMvY/zyPESzK6sai/4S3CnJysf0IkQubRKH2gKpQqfxjFQ4or6PrVhxkHOAks8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzeyxyh7KAEyKpz6IrWLUhYclMg2FQfit21yJlFWPWT9M4WLC
	X3aiKvTFveTu0yNYi6ivMSWqbehmGLov1Ojj9bO8rB2oR9a5s+i1x1reyldN9fXwkXE=
X-Gm-Gg: ASbGncuMbaLFswqhEmQItpAFa+drBG4LHC9Cuv3Qben1a8QKq36kZ0nioFSPsOSBVtI
	7BFgjdjxBGHC+qG1LgPlv0OqV/1g4WAXVHMryLara2ymqYcZ2OONgZPYVFG8L2KlkW1j6VjY6Pr
	fhfuY6nsTYzQIhCSa6S8R+PJA/eixoxsrqLKjgBrW+Sqf8d2g4WCaQDbB5WrUWz+0+1HugETsHE
	CRfy3+ry1zjZj9Gw9C3XQIYPtkUDB/MHMEB1Tj0QTmb4SkKyYK6JxNVi8+SPl68ms9izKeEBe/w
	JiAI1aH8DNcYfzVqkWlsFV7bFcQQumBCXVjghEK6OELlD0G6matNsWaYvS7XDJUYQHGQiqaciLi
	q7OJg/TMTwDSAvBhOpcRKMWrBP2rLP9iwW1/7IPJqwUi5X0ueUMzQ8K7Vqu98KsRynBh421V6OY
	IZL4IiJI1VtA==
X-Google-Smtp-Source: AGHT+IH4eA/RKU/GboTJ9VfoA/pYzZzZec5od8RkolpPdI5Ifcjq96waQtwfFh9MBuje3p8eQLal9g==
X-Received: by 2002:a05:600c:1c83:b0:456:2698:d4d9 with SMTP id 5b1f17b1804b1-459f4f2e2eemr97639165e9.3.1754898008092;
        Mon, 11 Aug 2025 00:40:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b0fa:b045:4b82:de09? ([2a01:e0a:3d9:2080:b0fa:b045:4b82:de09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm314243925e9.2.2025.08.11.00.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 00:40:07 -0700 (PDT)
Message-ID: <9f2bdd43-da4c-47b2-bba5-d69bc0b06ac7@linaro.org>
Date: Mon, 11 Aug 2025 09:40:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/6] phy: qcom: qmp-combo: Rename 'mode' to 'phy_mode'
To: Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com>
 <20250807-topic-4ln_dp_respin-v4-2-43272d6eca92@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250807-topic-4ln_dp_respin-v4-2-43272d6eca92@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2025 18:33, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> There are a numbers of ""modes"" involved: USB mode, Type-C mode (with
> its altmodes), phy_mode and QMP_PHY mode (DP/combo/USB/off).
> 
> Rename the generic sounding 'mode' to 'phy_mode' to hopefully make
> the code easier to follow.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index f07d097b129fb7b3fad003103b7468b16c1c4390..30749943f66280c3aa9e9673466f6f736d1adbc8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -1846,7 +1846,7 @@ struct qmp_combo {
>   	int init_count;
>   
>   	struct phy *usb_phy;
> -	enum phy_mode mode;
> +	enum phy_mode phy_mode;
>   	unsigned int usb_init_count;
>   
>   	struct phy *dp_phy;
> @@ -3282,7 +3282,7 @@ static int qmp_combo_usb_set_mode(struct phy *phy, enum phy_mode mode, int submo
>   {
>   	struct qmp_combo *qmp = phy_get_drvdata(phy);
>   
> -	qmp->mode = mode;
> +	qmp->phy_mode = mode;
>   
>   	return 0;
>   }
> @@ -3311,8 +3311,8 @@ static void qmp_combo_enable_autonomous_mode(struct qmp_combo *qmp)
>   	void __iomem *pcs_misc = qmp->pcs_misc;
>   	u32 intr_mask;
>   
> -	if (qmp->mode == PHY_MODE_USB_HOST_SS ||
> -	    qmp->mode == PHY_MODE_USB_DEVICE_SS)
> +	if (qmp->phy_mode == PHY_MODE_USB_HOST_SS ||
> +	    qmp->phy_mode == PHY_MODE_USB_DEVICE_SS)
>   		intr_mask = ARCVR_DTCT_EN | ALFPS_DTCT_EN;
>   	else
>   		intr_mask = ARCVR_DTCT_EN | ARCVR_DTCT_EVENT_SEL;
> @@ -3355,7 +3355,7 @@ static int __maybe_unused qmp_combo_runtime_suspend(struct device *dev)
>   {
>   	struct qmp_combo *qmp = dev_get_drvdata(dev);
>   
> -	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
> +	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->phy_mode);
>   
>   	if (!qmp->init_count) {
>   		dev_vdbg(dev, "PHY not initialized, bailing out\n");
> @@ -3375,7 +3375,7 @@ static int __maybe_unused qmp_combo_runtime_resume(struct device *dev)
>   	struct qmp_combo *qmp = dev_get_drvdata(dev);
>   	int ret = 0;
>   
> -	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
> +	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->phy_mode);
>   
>   	if (!qmp->init_count) {
>   		dev_vdbg(dev, "PHY not initialized, bailing out\n");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

