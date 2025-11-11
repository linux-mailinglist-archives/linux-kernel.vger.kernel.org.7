Return-Path: <linux-kernel+bounces-895187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B06C4D287
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BF1189A649
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728D34FF7E;
	Tue, 11 Nov 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVAZb83u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BoRxYtPN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28134FF4C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858055; cv=none; b=fGEmlUCI1/BeiaImPGnav+uMx4yaXUMSPkEQrXxK5QIGOXh9xqxIn0eiVhD5aGTxq+FNqsyNVcwfcLqhuwTSuPBlKiHpsxxntOnacffOQ54h3wibbFHjiXK0col5eE0zsPqW8ZlRv9MNLqcwS1jZCwpuT/aBtfeipt2w3nV784w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858055; c=relaxed/simple;
	bh=0fsV9uI1O/cKA8cAsRlcNpQnlJMqVYlThEFX+/lW8l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6APD4ZUfm/6MHqClT1YStgQ+mOZeNFeyxMlNNKi0dqchOyv3btoXINhi79X3Bf5tSF2TSrh5cPx97eUWkibYN9f0P90/QEnz9facjDvrZLL847WMbJeeLCaqG9LI9mR8jFnpNzjdB6YfTkHfHz1TCRkJEeVuFhN+qFZWh9Amts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVAZb83u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BoRxYtPN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB45W7B1009052
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZKoolRTpXFZGn0TM3pvNjb5r
	co+zakFBmbIW06wI+5I=; b=CVAZb83uTPYRJPOyqYQc9PH+81HrF64fe9dzCv5P
	sIige9U3UWG0Khm8TRBBQGAbBq8xshtY/ZzCQDS1e9ZZrMuGhytAJO7/Q/Sfcd8Y
	i2ujOHrsnCNMxJiCY0y41J0MOmsK/EHxGaL4+QXw7lR2RapsDNCMZpmLT4yorEvL
	3Ts2LeMS6dRg8L+Uxs/5xQ/IzomiZCvQ+t/4AtXGmPqHGYFX6wndGOx2toQExwKF
	gDlbqrqzUNbcnyMG3TGxZk76TLBf5WXg1qc11eEcu79gyYWHSV6g6hEsW/ReS24C
	bghmPpMs8RqrQgJeS0Y3dYiyX+Dy/o+mz3Tiwbh7c4ZWnw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj94mn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:47:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edd678b2a3so1258271cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762858051; x=1763462851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKoolRTpXFZGn0TM3pvNjb5rco+zakFBmbIW06wI+5I=;
        b=BoRxYtPNpRMBVONpQhneOhXSEkln5ZGZk7+IbNKGDhA5bozFDW96gDvuisIe+jd2+z
         Kz2Ru2y+UTNWjUFnSH47r2e186QHmUZ0pL7HzjV0ZuHZCDQrIBx+r90sNlVvTaQV6GOo
         Xc/GvwKHaB5qRwPk4mKy1JtacbspGJ/Yuysc2yZDtuWpNWHUfB1k8FG+4x1Jk/uu3iNh
         EcXBV/uEUOnQTj6CTQJm+LWbCQqMt2dV7/JbJGav5ZsPVb/blzHM6fE6LjiDfG7V5lia
         XzrBo643SBRNCz/tK8n2jTPW1Rn7SirqNCrZLxEDlWYo2vnIl0KmFBEEM9gH1O32fsTi
         3fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858051; x=1763462851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKoolRTpXFZGn0TM3pvNjb5rco+zakFBmbIW06wI+5I=;
        b=u8xUA0wY/xkzrMkxZwrZqVH2630SqhlIQFBKVVwOwkXScjo+NBN/4kpURMuksEWii4
         tRlGR4l1Pdqc4Zmx0uflyMX84mdg6bEUetfBnjwj6onyYXMREqs4m0WEFiUY26v9RMIb
         D+XXpq/gkH5tQVNgLz55CLp8CkIcmBY0xbTxvdJKGp5WepSimE2oWS0KomAb1bgUQ0rb
         A4X5MxhCQLyylhsyocdgQJUBzF++vkKzL0RBLPJERkYQz6/p60Ov1wtr5J4QKbxn+KIo
         XN6+ObZnsnko75BV/WqhvHpkffjZHc/qSROtFzDHBWKL2ldZFULWAmU9IEO8AfOOlZQf
         wNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAWzjj1/FJXxnsOP/OHJ/mqENNtp8IEHecFqiaEkufy+MSEF+D5Hc9P7LGT6VH/zycrewWKizzZxyp2KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkCBXJ8sIhxusrovj1dBinOP8uKGLOvxm3onbfm1RKGJ4Mk2B
	7q7u8j3jaP39zxma6xmFIYBwKqPjd9/kxglREAif0a1V3ADARUjsU/GtMDW363dnQ6YRm1Y6VHV
	LKlkq6PYkL8NnvWNkcAg7ClOi7QUemUwZVQx+2B7T9t772RHDt85uaNURqheRasZlDWE=
X-Gm-Gg: ASbGnctIRgWM0hC0aoojDUqpp+NLwHECpVRR6zs0SkJn+ySY2AJW4Q7pxwZkx7YQUuu
	kn31oNFvvFcRJic8myFlQ8QNwtjddbl1lA31NhRD6ZdJBi2M5HK1CPNS+54kbbIZK3G4knw15PA
	vvRJ5a4A1rrwWS5px7BcV8LBypjQ54dmPiMM6mjc7XvRLPo/qE6h0oFjUTOimU420HhV3eO4zYK
	sHXaTG6UC8vqriB+nyMF9Xo3iEgj/Rukal5M3DdPN9gIK+ErjizFIkV7Q+NdceVbnLZCFFpkOIL
	aQLHW8P2iw5t8LOCAnU2jG6e0ekP1kPAKYNLu3FOnwmf9c7FgEs6nRin2uoDlDwjduDRRrRn7Ko
	1i74ugHhpRGl07GfVNYm14vMQ9W1s3ENbkUvTdNJ68392eORMO4WegFSQNuf3kaRbUFZ6CsqZ12
	7FmOklYLVR0RzC
X-Received: by 2002:a05:622a:180e:b0:4ed:b83f:7896 with SMTP id d75a77b69052e-4edb83f7ef4mr91668671cf.49.1762858051398;
        Tue, 11 Nov 2025 02:47:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFCDtYxB/LW3BIrbMOEAj1jjHz3Vws4ZmtYsIjAkOgW0wgxINYmTrO7RAEFffB8gVmP/4YAw==
X-Received: by 2002:a05:622a:180e:b0:4ed:b83f:7896 with SMTP id d75a77b69052e-4edb83f7ef4mr91668371cf.49.1762858050950;
        Tue, 11 Nov 2025 02:47:30 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0dd771sm41797901fa.29.2025.11.11.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:47:30 -0800 (PST)
Date: Tue, 11 Nov 2025 12:47:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] clk: qcom: Add TCSR clock driver for Kaanapali
Message-ID: <zom2b3x26phaxsmabvvzcuutaig2cdmsj4ggnssmuwwc6mhksw@22jwrk2d3tor>
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
 <20251030-gcc_kaanapali-v2-v2-5-a774a587af6f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-gcc_kaanapali-v2-v2-5-a774a587af6f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NSBTYWx0ZWRfX+pgqIJvRNjgH
 pgIF0QvSBqyo9p3YdaM7KX7sePF71tV5hK1E9GLeG3RhXrqCbgBF2zZ5hb20V4AptHs9453T34E
 ozbxLxMJwxsz+15lYboLpyDyGj3mbtbEUHERsKjIoDDXYx70a+cfCkRfnQ1otPDKH3Q9vZ7Npk6
 l1lnymFDjad8NRLYSiORnaY3pIBLWogi4rTd6SivQcGi9oNctRbMY0tE2mSYou9aqEUFC5EqZEU
 IwLHwd/R4aF2S5628imIkRBBrlTepjImGa56szUy5WWWhU4983M00zF8eAuJ8D/M6EndOCbGoF6
 gGPSVvlElzMC+NuubN/jrzAs7harwhctMrM69uBtw5lyE/GhIYVFF91DUg7aVXeEhLFLk0cc+BH
 Y1ApChrWFpuArwm8S0qPDhBRSKm9rg==
X-Proofpoint-GUID: 7OfWHIZd12QpkqkMKxr8aAdx7ItFHy4-
X-Proofpoint-ORIG-GUID: 7OfWHIZd12QpkqkMKxr8aAdx7ItFHy4-
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=69131444 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=G3bzr5uV0MXi1sWuJYwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110085

On Thu, Oct 30, 2025 at 04:39:08PM +0530, Taniya Das wrote:
> Add the TCSR clock controller that provides the refclks on Kaanapali
> platform for PCIe, USB and UFS subsystems.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig            |   8 ++
>  drivers/clk/qcom/Makefile           |   1 +
>  drivers/clk/qcom/tcsrcc-kaanapali.c | 141 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 4a78099e706c2cee5162d837cad3723db75039d0..8ec1803af76cb87da59ca3ef28127c06f3e26d2b 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -46,6 +46,14 @@ config CLK_GLYMUR_TCSRCC
>  	  Support for the TCSR clock controller on GLYMUR devices.
>  	  Say Y if you want to use peripheral devices such as USB/PCIe/EDP.
>  
> +config CLK_KAANAPALI_TCSRCC
> +	tristate "KAANAPALI TCSR Clock Controller"

Kaanapali?

> +	depends on ARM64 || COMPILE_TEST
> +	select QCOM_GDSC
> +	help
> +	  Support for the TCSR clock controller on Kaanapali devices.
> +	  Say Y if you want to use peripheral devices such as PCIe, USB, UFS.
> +

[...]

> +
> +MODULE_DESCRIPTION("QTI TCSR_CC KAANAPALI Driver");

Kaanapali

> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

