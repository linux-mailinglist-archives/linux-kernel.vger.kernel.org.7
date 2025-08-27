Return-Path: <linux-kernel+bounces-788813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FBEB38A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615D85E1D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF3A2EE61C;
	Wed, 27 Aug 2025 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dCQmge2z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF704258CF7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324915; cv=none; b=bA6UqKMp9rjYB3RmsJ8d234g7mJHNd/5riVcq5IESQLoOzB0LVzNlMjw7b/aSaIcFWRS5GFlRAV9yFiyGalswnwf+nybWPYyepbckprS8ACELk6XWHnPY3dvd0PNBgFG620ehNuzZDkMI43nvAn8PVT2UafQndkxB6K/VfqQyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324915; c=relaxed/simple;
	bh=D+yMe14Tpf3c/xVv+fARYf5ETFaAbJnlz/bfCvrAoVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc4mdhrlINkmwpea5uflnaEaUjwkDMocwPiF+nO4SLKe9LElD2d7cdkVEePWG/DM+FoQlKqJJhoOcbOuRsog2d21MbO8MKVYDq/tLPil2bjU7luw/o5XtaVZ5YwYzHGNypg4nPyDtT82V7XttIXtM9Ugdhd2LNMVUC3Oeko3bkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dCQmge2z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57REu9Mp000385
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Mj5+squga8BNTuWWdxANYVJo
	JH996l1kauWfdJepZFE=; b=dCQmge2zI+S/miJfNaWjec7m+SYfczGuPw35ICh3
	g/av9RED+72TSbUVoDv9D5/bufDvdPuqfhOqyMBptFUoxkZ+yYhroz0G2SjyAe5y
	76uJ7FPxHKg/jOkrxZodmFHak2wnraXWdZANqDG94ovrxRIR6InX9wCF9L5EJAo9
	I51HS4QkzvggMhnulO18zBU0UJJujb9GGMXzan0AyCSi7FDrKiW98k8nQiXcGZTq
	WwNPmVQ2ALbXM0Wu7lP9fhfdTYNUXq/Fn8P58bVWv36E8SV1s7mSHKF5HU+nPqor
	7xI19j3BpyWesKhie+i+dvk0wW2AS8jZIu5BJLoQM0QIUQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48t47b8u2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:01:52 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-8940ebd2ab8so1139043241.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324911; x=1756929711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj5+squga8BNTuWWdxANYVJoJH996l1kauWfdJepZFE=;
        b=OxdUA75HgHq3DbY3p6ateeOIB4sMPdyjGz+ctASxuiMxfqD2gFv8TH8hwwVXtBTiB7
         dJaK3O5Y9GrdgYbnIbyvZ+9H79b03iyO6/Q4D2V2xlFrvU5YmvLaYtplGgHrEZIR5cDW
         R/5/WShkgwcY+CYcKieckxKrBb7zP3a2+NnviAYiGblOQAY1z37CJ7203F9TsCnt+YcJ
         swlsWqPa/EnwQgrjkowWOfnryETp1C335vJERdBZDWiIftdDFXZo2Q5plf1LVNnDnuuY
         E7APtru6pBgLF7wKkSFdQlattztviJk4/UMcTIqKtwTlTKBbG3JPeRssZa0+LLt4Dw0M
         WCGw==
X-Forwarded-Encrypted: i=1; AJvYcCXcyGzYt9evZYOmg9SGh8RK/w+ZFOfTpACS5zjA5LkejTfyKfZlrDGII37pgJ/RNlaWrMP0ndlvO1vjORo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mEjnjSjgxQUOSSDjIrOPoYhkdjtqDc4gikH7ZqVqJLU9vB/z
	uGnriB14wgf8Q+JDropnHrSW6K9LPAG/4JNXt3OaBxCvAJT8CtPvDff58OU6rwWJdnamB++EXx0
	2KbpXLCWK4jj1vEwoZVIt0SgRMc9pDIBybESsrLxh+AkoDneVfx+HbC+HxIO/6O0UaLs=
X-Gm-Gg: ASbGncu+K9mk3gjX6k7Y39/IE5xADH19WEClZ2vA3AzQPSBYSQi0H4gYp3O9hTKZICL
	fhmQW5A/h/9xqV8LRa85tJL/p+R7oQhHOW4YQgr1PAx8G+ZuvjHd38LoFpYMb0QshrD4CSTL0Y1
	O/mJ21szG+xwBbOgK+/t7QnVrv+s41cmJ/htxw5l+ZUeDn8S4Se7hyH3aLNEzegIUAhH8emM5hV
	hBuTC4EVaUaz/0HU3bbS41wdwFZiHljNYwlFM9pobdT/y2IfXFtXSKOmAA0sIXlOZ+BE8ICbokJ
	O5ulp/HZa/osGRBXdsojF1gH8xzvii4mkyTLjcsRld8mxGhlDDmy3Gz0BzD/U5fu8057OazfRYZ
	nullLBwgfORLJW6whkZ+092zlL7G761o1Srq1I369Gy29yXUdaFQW
X-Received: by 2002:a05:6102:6495:20b0:519:534a:6c36 with SMTP id ada2fe7eead31-5248bbc70bfmr1665701137.14.1756324910403;
        Wed, 27 Aug 2025 13:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ/jsGbo/0+zzG2ju1FyxFl38fR1Yik7DRNOp7bX+dkjfU3yg/w7t7cOerSB8W3MKBRSWD6A==
X-Received: by 2002:a05:6102:6495:20b0:519:534a:6c36 with SMTP id ada2fe7eead31-5248bbc70bfmr1665596137.14.1756324908466;
        Wed, 27 Aug 2025 13:01:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5a5b79sm30873701fa.34.2025.08.27.13.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:01:46 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:01:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fange Zhang <fange.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Message-ID: <yutyrfb73wbxlweoq3mc6ezyqr56snzmznw3k6mcbc56fpfayg@3h5jwymlo3ol>
References: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
 <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
X-Proofpoint-GUID: oGIkNN5XW_9flXZa9mDsHq-P1-bBjeSX
X-Authority-Analysis: v=2.4 cv=CYoI5Krl c=1 sm=1 tr=0 ts=68af6431 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NCHn67HwCZdYxv9cn_sA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: oGIkNN5XW_9flXZa9mDsHq-P1-bBjeSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyOCBTYWx0ZWRfXyzs5jY3oGT34
 fpf5voHtqKqL76+YhWwuU653f8pPNA6uiNom78YktLxC6gHTC38xIDtfLp8VUXhBlIdGoPKNiIc
 tP+b8JyvwJk48ccDfB8S5xtxjPo7S8V+IE6UhocRz16gZrAM3eNlKMMg9uu3vDo+ZwMazZR86mB
 OuLeZGipKgaowfQ8oMeUBPNJUdXEr/4kTGHWkpc2E/F4TErzudlBxOwfT5uOc5SXODYyP2I1GFI
 K0ORcSk6RrIu9kWuDJDTUpxKp8TxtnP4Pqz2GL/Gxvg7EOkVOSYOm+dVcxo6mUGpFDUK+uqJoZV
 mGeKNmlSvwedpiSwJaq5Kb0RZ6YJHHmlF0SjXLcNsWJfWVlqOZJCToBEO94NN4bua7awSkmXoVb
 gfs7L7sM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270128

On Wed, Aug 27, 2025 at 09:08:39PM +0800, Fange Zhang wrote:
> From: Li Liu <li.liu@oss.qualcomm.com>
> 
> Add display MDSS and DSI configuration for QCS615 RIDE board.
> QCS615 has a DP port, and DP support will be added in a later patch.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index e663343df75d59481786192cde647017a83c4191..f6e0c82cf85459d8989332497ded8b6ea3670c76 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -39,6 +39,76 @@ xo_board_clk: xo-board-clk {
>  		};
>  	};
>  
> +	dp-dsi0-connector {
> +		compatible = "dp-connector";
> +		label = "DSI0";
> +		type = "mini";
> +
> +		port {
> +			dp_dsi0_connector_in: endpoint {
> +				remote-endpoint = <&dsi2dp_bridge_out>;
> +			};
> +		};
> +	};
> +
> +	vreg_12p0: vreg-12p0-regulator {

I should be more carefull when doing reviews. I thought that it was
pointed out already and didn't some of the obvious things...

First of all, the nodes are sorted. By the name, not by the label.
Second, there are already regulators in this file. Why are the new nodes
not following the existing pattern and why are they not placed at a
proper place?


[.... skipped all defined regulators ...]

> +	};
> +
>  	vreg_conn_1p8: regulator-conn-1p8 {

Tadam! It's even a part of the patch.

>  		compatible = "regulator-fixed";
>  		regulator-name = "vreg_conn_1p8";

-- 
With best wishes
Dmitry

