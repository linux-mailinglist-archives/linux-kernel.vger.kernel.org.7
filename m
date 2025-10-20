Return-Path: <linux-kernel+bounces-860586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732FBF0737
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A2DD4F13D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13C52F7ABA;
	Mon, 20 Oct 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IRZ+DmEE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF02F6929
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955124; cv=none; b=XR3s2ybgSx1nmG2UNkSeJc75kFPO5aLiUhS5uLEU8z1I0nDn8NfNZPmQSSrzpb1LHIeXe3l9avdl1m8xO7iujua0IG5bwYlOn+TgL/8ESzp4YhaspMMl/vUbIvZ74Eamcq97qeFYuGDTPRU0izpkg5atQWQda/aXFXGVHY5z878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955124; c=relaxed/simple;
	bh=zjWV32YubOXbSjc/Jt5P+oYvneKV0qaShyrwMCD9uGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MieVipyvDbEGOmchO1ZqEpxDj9wGYkX8YpIEg7QjkFC/50vHHhzZLAEdnyBvQv8JW7S6v0TTo8L9ilTwjwb8VmVJsMlcWXuWOlkTC79ckJhWsYj1xGcLbDGyWn6E4m9Mp/X07rAuucxDjzo9ftFPnsXaW+KuSOUb+DWr/Rx74hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IRZ+DmEE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMpa8q018961
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AlGAc/MgmD7xVwVbzczA9v+kNgPlaCaidCmqysj/V0Q=; b=IRZ+DmEEffm5Iq1o
	NeytoG0fx+L4Tk7jDD3JjoQh6oVUojjt4L5QPg2GxM6Ls5Y+acecBfAcxMV1xpLK
	xy7vv59NST3377GWSOJC5xtOGHx8+UstDWYAhXrNifKtGO6IrEeA1DDqRSPRF5WP
	ojb6cWilL0Rnf194DVWawHf4c6awG96Esj3R8u4vrJhRqrpkO+Qs2zDU0gzJNOJ1
	/7r8rqmA+RyMXLOyCg3dJ03cO1JHMeLkSb7yMeqzKcNsFuDn6/ovQODmdJdNVO4J
	o0OxCR0DEt8BcihtvpJ6ygJmqLr8apVxIqTQpEUIGmsu20wxKAzh4tGpfW1Vr3yf
	eux3rg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27hvfxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:12:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b67c43db504so137361a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955120; x=1761559920;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlGAc/MgmD7xVwVbzczA9v+kNgPlaCaidCmqysj/V0Q=;
        b=dH4af5orm7W9WZRGfFXELWwToB1L2qd3md0VEAyT5ndkkSbP+Z0UuBM8QnSvDTX5zT
         hvl+V0PKq+J5WiJzxEI6kPzwiJf4fl3Aa8chSsM4gxyOs4Pbxc7k31r9qe5wwK3dhAWC
         G9u8oT8dWh1Opqk9XRuCtmqc/nkR49U5FrqbrOJH/jzgHDk8raak7AvDyS9CdiixdwW2
         2MihwpHul7myniJBVPgw5D1r159ufRD80ZW2KJ//kPqUz0X4ujobzzU7eY7LmwGKLMkt
         LTJMoPQHGC0aFeQbnCRUT4UpYD5ruiClATrEq+t7eJR9daNWK3UC+ARZUVJ4UriUJ7IG
         EzkA==
X-Forwarded-Encrypted: i=1; AJvYcCXWIIUrhVfLxMSePL5rf7gxV43JAKxo81l4tEJShK6/nDPxRm03MtBg5JIB7d2GhDS5kXI0QexxnItcJCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZInR6sHMv/GoU1jF6xFLG8CtQd2cmeequpPMjmJouxx7SD4y
	wMdkvRmNRGjIJa10IQzhF6iA3EpKXIDY1iHqiLf6vOYY56ZpGz1jQU43J/D64yUrCV2Vn4h44Ui
	J2PBztdhtw6dnUg8Sif8gvzQVei/T+lA6pWBOJbn5jWHeQ4kUOs3AtR6bK8LQfoxg44M=
X-Gm-Gg: ASbGncs1xHidGdeiACGXVjBjut4QCAGp1pKaYRv3KcZG6wJBsNW65u/g57WbEY4hMdq
	xKa455eYcOdp55Rnqx0GJ09pBdbOgB+vlLYrDYmFhbFgV9sSO0tNgq3ngHFqaa8wlN+D0H8Y82q
	1gGaAmVokqVJ9zesAisLEfLfclqOHRpaO8+ChWzmk5polcW6rW1Isg2c0eC3bMLG6u/XhTv7R+C
	pV86wivwYTCVerNfYgU3rkeLy1SI5x4Ayma5urcFDFA4yPqjqCGC+4D8ti4hlhNQipFVV4rmhXv
	VZmOEZ2dIpHtYuDyPFIwpumuZjfVzfuigkAkOp3ApQ0fi3tOZSmvl39NgcKqG8LD+TYmL9/o+DS
	F2T6FYH0ti5cXfDzSNappieSgBLmxj5YH7H+9AtmNaPvNusZmEFJn5PkY/EOquabeIg==
X-Received: by 2002:a05:6a00:130f:b0:7a1:696d:be2f with SMTP id d2e1a72fcca58-7a220a65d70mr8661730b3a.2.1760955120014;
        Mon, 20 Oct 2025 03:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFvVzbIngqDI8uRFh4dk3VjTpS8uYIUD8ihuF3PhSouiS+ItKdHCOo8Nvo9ZTB/xPIV4lQXw==
X-Received: by 2002:a05:6a00:130f:b0:7a1:696d:be2f with SMTP id d2e1a72fcca58-7a220a65d70mr8661704b3a.2.1760955119482;
        Mon, 20 Oct 2025 03:11:59 -0700 (PDT)
Received: from [10.133.33.107] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f24fasm7826266b3a.42.2025.10.20.03.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:11:58 -0700 (PDT)
Message-ID: <c9e27a9e-2274-4b1f-9953-ca012ba2615f@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 18:11:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] clk: qcom: Update TCSR clock driver for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-5-29b02b818782@oss.qualcomm.com>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250924-knp-clk-v1-5-29b02b818782@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX+9j1lDHKjWn7
 dEsGDuWKW4sYLtexx2FnaBImyEe5zhNpDgtKGUA2YU3WcHxh/fXfr8uGLp4KBLDr7g0MhNBGAKp
 +iJyubl+U8vdvzzgJOMTloeNGK7N88sGDVqIh+SMeNKYUIGPtD0ClVJS5cXxCY4OPFvMWVblBL3
 wJRCLwws2KcRA4/SOy2UmNM9zFHnHEiQH60AAGRO9GvCLxPcquOCU+4l6yb9fvclwuW3LJCA9UU
 0JAWCUAXexM5fnBSWq5zGA/qaBgJDSJGjKti5zpU4M8mK7Pa89+3QfX80H7kQxrusvqpGRORVHe
 nDhDQjxCzyrlRnE9q5dsNHU9T8p/87/DEsC29XIOdPURiuPb3LR08nV/43ckRWhGJQCDSAsQciI
 Rdr36V1axYLndMK2+kI8gtJl2Uiwnw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f60af1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=K8VVhfcJ-VgHpZivss4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: BWXW99b60T1rpe-Gh1f4L39dSCnRUW13
X-Proofpoint-ORIG-GUID: BWXW99b60T1rpe-Gh1f4L39dSCnRUW13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 9/25/2025 6:58 AM, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> The TCSR clock controller found on Kaanapali provides refclks for PCIE, USB
> and UFS. Update the SM8750 driver to fix the offsets for the clocks.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/tcsrcc-sm8750.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/tcsrcc-sm8750.c b/drivers/clk/qcom/tcsrcc-sm8750.c
> index 242e320986ef..f905f3824d7e 100644
> --- a/drivers/clk/qcom/tcsrcc-sm8750.c
> +++ b/drivers/clk/qcom/tcsrcc-sm8750.c
> @@ -100,21 +100,51 @@ static const struct regmap_config tcsr_cc_sm8750_regmap_config = {
>  	.fast_io = true,
>  };
>  
> +static const struct regmap_config tcsr_cc_kaanapali_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x18,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_cc_desc tcsr_cc_sm8750_desc = {
>  	.config = &tcsr_cc_sm8750_regmap_config,
>  	.clks = tcsr_cc_sm8750_clocks,
>  	.num_clks = ARRAY_SIZE(tcsr_cc_sm8750_clocks),
>  };
>  
> +static const struct qcom_cc_desc tcsr_cc_kaanapali_desc = {
> +	.config = &tcsr_cc_kaanapali_regmap_config,
> +	.clks = tcsr_cc_sm8750_clocks,
> +	.num_clks = ARRAY_SIZE(tcsr_cc_sm8750_clocks),
> +};
> +
>  static const struct of_device_id tcsr_cc_sm8750_match_table[] = {
> -	{ .compatible = "qcom,sm8750-tcsr" },
> +	{ .compatible = "qcom,kaanapali-tcsr", .data = &tcsr_cc_kaanapali_desc},
> +	{ .compatible = "qcom,sm8750-tcsr", .data = &tcsr_cc_sm8750_desc},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tcsr_cc_sm8750_match_table);
>  
>  static int tcsr_cc_sm8750_probe(struct platform_device *pdev)
>  {
> -	return qcom_cc_probe(pdev, &tcsr_cc_sm8750_desc);
> +	const struct qcom_cc_desc *desc;
> +
> +	desc = device_get_match_data(&pdev->dev);
> +
> +	if (device_is_compatible(&pdev->dev, "qcom,kaanapali-tcsr")) {
> +		tcsr_ufs_clkref_en.halt_reg = 0x10;
> +		tcsr_ufs_clkref_en.clkr.enable_reg = 0x10;
> +
> +		tcsr_usb2_clkref_en.halt_reg = 0x18;
> +		tcsr_usb2_clkref_en.clkr.enable_reg = 0x18;
> +
> +		tcsr_usb3_clkref_en.halt_reg = 0x8;
> +		tcsr_usb3_clkref_en.clkr.enable_reg = 0x8;
> +	}
> +
> +	return qcom_cc_probe(pdev, desc);
>  }
>  
>  static struct platform_driver tcsr_cc_sm8750_driver = {
> 
Remind to review the change.

-- 
Thx and BRs,
Aiqun(Maria) Yu

